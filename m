Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488D2C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 09:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLfjX-0007zG-Sr; Mon, 24 Jun 2024 05:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjV-0007yV-KP
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sLfjJ-0003tV-DN
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 05:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719220276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+9IY13yh8RRCqanS8sKsz76bmifajzLlE5oieW9FlZw=;
 b=JU2MLtA9Jbmkg6QbcPO7P5L2rvoRe63+r7ojw38Tqr0snCFlZJReBgMjKWJTLabdGtD3ND
 utkLjXQAv4m0SKbi9jWqxIjIMsoeerMfbw5P1DlABnN7P7Y59XmjlHHbPLkZhpqYZGgnf8
 HyZZ9JklNyT8lEZrJ8heFG3+TdfvLac=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-5Ojq6atiN0S2wfz5gobYkg-1; Mon,
 24 Jun 2024 05:11:15 -0400
X-MC-Unique: 5Ojq6atiN0S2wfz5gobYkg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F11C91955E72; Mon, 24 Jun 2024 09:11:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDE69300070F; Mon, 24 Jun 2024 09:11:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Dmitry Frolov <frolov@swemel.ru>,
	Alexander Bulekov <alxndr@bu.edu>
Subject: [PULL 08/11] tests/qtest/fuzz: fix memleak in qos_fuzz.c
Date: Mon, 24 Jun 2024 11:10:40 +0200
Message-ID: <20240624091043.177484-9-thuth@redhat.com>
In-Reply-To: <20240624091043.177484-1-thuth@redhat.com>
References: <20240624091043.177484-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Dmitry Frolov <frolov@swemel.ru>

Found with fuzzing for qemu-8.2, but also relevant for master

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Message-ID: <20240521103106.119021-3-frolov@swemel.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/qos_fuzz.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/fuzz/qos_fuzz.c b/tests/qtest/fuzz/qos_fuzz.c
index b71e945c5f..d3839bf999 100644
--- a/tests/qtest/fuzz/qos_fuzz.c
+++ b/tests/qtest/fuzz/qos_fuzz.c
@@ -180,6 +180,7 @@ static void walk_path(QOSGraphNode *orig_path, int len)
 
         fuzz_path_vec = path_vec;
     } else {
+        g_string_free(cmd_line, true);
         g_free(path_vec);
     }
 
-- 
2.45.2


