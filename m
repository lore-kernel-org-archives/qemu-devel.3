Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C2F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRc-0005hI-D8; Fri, 10 Apr 2026 15:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRa-0005gz-8V
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRY-00022M-UR
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wvZdzUIzdaeckoqtlkTa5p+Wqgu1dxUiASLnYQALEl4=;
 b=SMne8MAPEPyQNvZzTuXkNIDfUpn4AAqRllSKI3MoqV14tdnM4IKgx5NMUzEr4UynPcR99N
 4sHpXkqZzmKX0KlTKD+ncpNUBLHVMljWd1Qx3s5Ghnn1ch2DrwJax1moUcYwQfzB3ihCPB
 jsYGN07Hd/PxhXt1JYoIAFpWhhI5Xp4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-XYqAu1PGMnW--sdu6K7WEg-1; Fri,
 10 Apr 2026 15:23:03 -0400
X-MC-Unique: XYqAu1PGMnW--sdu6K7WEg-1
X-Mimecast-MFC-AGG-ID: XYqAu1PGMnW--sdu6K7WEg_1775848982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37BB019560B2; Fri, 10 Apr 2026 19:23:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0CCD7180057F; Fri, 10 Apr 2026 19:23:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:03 +0400
Subject: [PATCH v2 41/67] ui/vnc: simplify vnc_init_func error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-41-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MRz/TL0HF7a6DU/hBk95ZC2vvHeCoQttUAyFaMDhRS8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0VPBOcLojet3g5aspIqmuLIeMAJF4FtPCHB
 Sb50Oea9CeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFQAKCRDa6OEJdZac
 5fnxEACnxCxqRuxq2L8vaqOaLxDK62MvytHfGv1ZRHujPSkiH3qWWvok7fzKbLcAC+hbldYk5H8
 vB8OZtNM8mHP4MV19QDiZ0OLsqTLWstNlGYh1yhmdy3EYP8RwfPPQZJBq7ha0TJ/UEdLMBZ5CBI
 n+B78GQ7rv/rK2BL73+sAk68G5pmdw1ql5XY90qHgJvwBhiuAqbtmbFDtoA5Kw6mXkribMoFNO6
 ea8Qs2VCU516a8XzNDBUrxFZ2dYVsPOBCDGt3ZFEYQQmT0b8fJatIi3rEbskY0reylP5YO/hzxS
 reA/T3j3AJTlbeDhCO6E7FfNZ4IusewyGzn/PE9T4abA0oLkiiRtwLduMWUlFfPMHJH3BhC7AdU
 H5rvhv6kSAMl6lzaMMRElSWPVFfbTlkJ4iNs6dBCNe6P8tCHxjFOYe/HnHIRCSNb4BReVhINx1L
 O1GMksSqkBXIYXMYCTJw+wkWUXNExGKrK1IRVHDmRoUhmDQ/+ifsN08STZnZKSRqCcblMXR9zDB
 +r2N/UEt1Jvs16Sq5eymvjA21CKOXZD2G4fsNI7gl5P17HtxUECstjjZTGwIHvnK7c/wrVc1dHZ
 HhToR3rdDZ+xZIKokCAl8xoXpzNV/eNPQVgguQLmWNggUd79B9yPpxfgjTLTmuyG/X1Sr5xjsLI
 3iDADtp28zgpuGA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 3633fbeb6ce..2df91642570 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4319,7 +4319,7 @@ void vnc_parse(const char *str)
 
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_GUARD();
     char *id = (char *)qemu_opts_id(opts);
 
     if (!id) {
@@ -4327,14 +4327,12 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
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


