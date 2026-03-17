Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53210F3381E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:58:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEC-00065N-CU; Tue, 17 Mar 2026 04:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCc-0003Ni-Tq
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCU-0006pe-5i
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MohqLKRFXQbENKBHTeznLw2KfQVmXjody2QDCT0Nb0U=;
 b=E2XtvRQpnTXS496yqjWHiIaxy/5nJcpjyzNPo2L6317YY4QNaCE5RjVTUpBHNIUh/c51j1
 25L465jdU7wQKcszTUMeAocgoZn/H/+jTJ3PLkJNoSrf3zThwg9EANlyd6VsAhee4+vrmV
 heGWMbESa7aZM++FaRI6WZJk+VDG3FU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-QQmW4duxNLaDGMqO7iQBFA-1; Tue,
 17 Mar 2026 04:54:51 -0400
X-MC-Unique: QQmW4duxNLaDGMqO7iQBFA-1
X-Mimecast-MFC-AGG-ID: QQmW4duxNLaDGMqO7iQBFA_1773737690
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ECD319560A1
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:50 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B0F919560AB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:57 +0400
Subject: [PATCH 43/60] ui/vnc: simplify vnc_init_func error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-43-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mpTuET72Uh5XCNvV40mgiXnypBmj/w1fe3eUGvOKBRA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXc5CKClv3vED1vOCNsHQp73gXJY60OSkVHR
 ItcCOCVDVuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5e74D/9jUDYZEUsNTTrvpDhhHCRO+DNLLxcgbu7qCEPtneGLYzfRQAgtgtwH6cN9pKHM2eCDZkH
 Pau4txiU/tqddOvT06/AjzXSXSnx48a5kEnOh7bg6lHaQ7Wfl+FYyZHD9u5i3oIj/oTnL5YNAYc
 RlQsBgTtaiIRng4lN3u/FMeM1Cc5fZpRRbFM4cF7Vj81dRhxOphi2tKMwTt/I2RDgYW0FSagBhc
 /LGfxaElAQFYMc/eExqTes23RCvNwgUgn670YL8HtioZQUdhRl3aNDIRjkopHUJCrCIOXV/9Dz3
 srfZgAR4cz22GYjiDZfWaOC+frROXd8+9OV4IIU/azXUCnTSrM3TAu14UVsRyvDoccEasvWqjFW
 2NumDbkXb1U1qjdUvcX1fTvHRqOElZV/R6exM3jw/e+7kuCG3YW6KQh0NXvNmUTkx3nqRuermQf
 3IPV5wfa4xF5B/145ssP7XP5P5E2PQY+LYYD6Q+HlKog5gQpAW4leSAFZFXlNyCVtRWY6U0o8LR
 gbGCCq/VE9fyb1VRlEgyVmvkteQA/GKUlogJWahsM6OvNlIWY5YtT7zwx4Rj3EQ3DSG0bc1frzq
 +UVBBXrRrCC26UuJLrCYdLS4JcaU/n4105/8Z4afyT+4m0Ks9N28llo/qCJgXL6XSelN15LnsRj
 L0KL+5OXWWUzA+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 605e5117b7f..af5fb3c1551 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4318,7 +4318,7 @@ void vnc_parse(const char *str)
 
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
     char *id = (char *)qemu_opts_id(opts);
 
     if (!id) {
@@ -4326,14 +4326,12 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
         id = vnc_auto_assign_id(opts);
     }
 
-    vnc_display_init(id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    vnc_display_init(id, errp);
+    if (*errp) {
         return -1;
     }
-    vnc_display_open(id, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    vnc_display_open(id, errp);
+    if (*errp) {
         return -1;
     }
     return 0;

-- 
2.53.0


