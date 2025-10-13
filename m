Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29783CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hs6-0003ob-VS; Mon, 13 Oct 2025 08:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v8Hs4-0003oD-Ai
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1v8Hrx-0007gm-SP
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RG6EMlmoMZDZZVPU70B9WzfFIpoSMU4fu/dAUx3lorQ=;
 b=Vsy8Zwnztay7iOMoZom9V34+R7mFdTYAleBeV+LM8zEJkbtJyk5rUvDsg5ClxpRxd2wV3w
 XbKf7Fvh7y2N3vFHWDZcGMNCRk0cwmIGM6BKuPYaLeGH+pyqoEX4vqCt63glwX2LRsrryK
 YPSe0eY5Ph1lCr0JL5n1/XBDEF9buSM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-XxGHuyXwNnSBLau7AIEsPA-1; Mon,
 13 Oct 2025 08:41:32 -0400
X-MC-Unique: XxGHuyXwNnSBLau7AIEsPA-1
X-Mimecast-MFC-AGG-ID: XxGHuyXwNnSBLau7AIEsPA_1760359291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AB0D1954111; Mon, 13 Oct 2025 12:41:31 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.44.32.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C74AA30002CE; Mon, 13 Oct 2025 12:41:29 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: kwolf@redhat.com
Cc: hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 richard.henderson@linaro.org
Subject: [PATCH] block/curl.c: Fix CURLOPT_VERBOSE parameter type
Date: Mon, 13 Oct 2025 13:41:19 +0100
Message-ID: <20251013124127.604401-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In commit ed26056d90 ("block/curl.c: Use explicit long constants in
curl_easy_setopt calls") we missed a further call that takes a long
parameter.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Thanks: Kevin Wolf
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
2.50.1


