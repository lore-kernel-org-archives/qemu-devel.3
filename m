Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A6BD5E370
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 14:29:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVW3h-0005e0-BZ; Tue, 16 Dec 2025 09:29:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW39-0005WF-BR
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:29:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vVW32-0002wi-Tj
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 09:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765895337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hhvtml6jjvFmeQn1jiKdFKJeyj25+hrS8UKpojuJCQY=;
 b=gmgpdB2kF51/Ks38dODxJEjs0ylO9Zjin3t7Vl2fuzbFz7H4CJaWoyr6OQS5pIakDQl25y
 ACIxI4O3TmF4tiBkEPWbiUy3ilCIAgoulyNQc/XlGeVAdMqeAntHtjEnURran0pvVBhbpA
 j7jUkKUdGMMpRvjvudHVLYyvQ1jRsfo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-Gy9hK1YiN5OeScmVxhbHNg-1; Tue,
 16 Dec 2025 09:28:53 -0500
X-MC-Unique: Gy9hK1YiN5OeScmVxhbHNg-1
X-Mimecast-MFC-AGG-ID: Gy9hK1YiN5OeScmVxhbHNg_1765895332
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EA1E18011DF; Tue, 16 Dec 2025 14:28:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.62])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C62019560A7; Tue, 16 Dec 2025 14:28:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yodel Eldar <yodel.eldar@yodel.dev>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/4] tests/vhost-user-bridge.c: Fix const qualifier build
 errors with recent glibc
Date: Tue, 16 Dec 2025 15:28:41 +0100
Message-ID: <20251216142843.519084-3-clg@redhat.com>
In-Reply-To: <20251216142843.519084-1-clg@redhat.com>
References: <20251216142843.519084-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

A recent change in glibc 2.42.9000 [1] changes the return type of
strstr() and other string functions to be 'const char *' when the
input is a 'const char *'. This breaks the build in :

../tests/vhost-user-bridge.c: In function ‘vubr_parse_host_port’:
../tests/vhost-user-bridge.c:749:15: error: initialization discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
  749 |     char *p = strchr(buf, ':');
      |               ^~~~~~

Fix this by using the glib g_strsplit() routine instead of strdup().

[1] https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Yodel Eldar <yodel.eldar@yodel.dev>
Tested-by: Yodel Eldar <yodel.eldar@yodel.dev>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251215101937.281722-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/vhost-user-bridge.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index a5c711b1de8e9c164dd1614f4329b8e3c05d0402..ce4c3426d3938a0b54195f3e95bb1f1c3c4ae823 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -746,14 +746,12 @@ vubr_run(VubrDev *dev)
 static int
 vubr_parse_host_port(const char **host, const char **port, const char *buf)
 {
-    char *p = strchr(buf, ':');
-
-    if (!p) {
+    g_auto(GStrv) tokens = g_strsplit(buf, ":", 2);
+    if (!tokens[0] || !tokens[1]) {
         return -1;
     }
-    *p = '\0';
-    *host = strdup(buf);
-    *port = strdup(p + 1);
+    *host = g_steal_pointer(&tokens[0]);
+    *port = g_steal_pointer(&tokens[1]);
     return 0;
 }
 
-- 
2.52.0


