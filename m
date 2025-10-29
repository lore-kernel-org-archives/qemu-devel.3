Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11D4CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 12:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xj-0003P0-ID; Wed, 29 Oct 2025 08:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xH-00036V-It
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4x5-0004zh-8s
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mtk7orbZ+/0SGdJlnprrUwTXuTaF9y0Knu3erU+SuHI=;
 b=GphMxxxyL3UXX/YjJnnz0d23Tf8frFFXn68JSgqkkT4vqrAZZdGBoAn9P2KHzfWmBiNdyx
 te3piBgH/LWSAkSyqyLbhPxcMWYw7x0xhbhKuLHY0lHOuY/CxJYZvKIitvLqdQ3MJXkg0l
 50Ifaak9vFJjGuIHmAMhXt8amXrRj7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-foB2aJUtOvuTgVCTNpXlwQ-1; Wed,
 29 Oct 2025 08:06:50 -0400
X-MC-Unique: foB2aJUtOvuTgVCTNpXlwQ-1
X-Mimecast-MFC-AGG-ID: foB2aJUtOvuTgVCTNpXlwQ_1761739608
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 356F719540E8; Wed, 29 Oct 2025 12:06:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF4C4180044F; Wed, 29 Oct 2025 12:06:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/18] block/curl.c: Fix CURLOPT_VERBOSE parameter type
Date: Wed, 29 Oct 2025 13:06:21 +0100
Message-ID: <20251029120634.288467-6-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Richard W.M. Jones" <rjones@redhat.com>

In commit ed26056d90 ("block/curl.c: Use explicit long constants in
curl_easy_setopt calls") we missed a further call that takes a long
parameter.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20251013124127.604401-1-rjones@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/curl.c b/block/curl.c
index 68cf83ce55..d7d93d967f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -524,7 +524,7 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
 #endif
 
 #ifdef DEBUG_VERBOSE
-        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1)) {
+        if (curl_easy_setopt(state->curl, CURLOPT_VERBOSE, 1L)) {
             goto err;
         }
 #endif
-- 
2.51.0


