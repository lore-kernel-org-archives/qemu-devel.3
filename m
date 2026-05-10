Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D24CD37B9
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4aV-0006LC-Jv; Sun, 10 May 2026 09:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4a1-0005y7-9J
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4Zz-0006Kl-MA
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778421142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oFFF/vb3C0DgB9pfHJE5MTx0Y3d5kkHf/ZwA8oUKhNI=;
 b=KoOyl9VVa40cpUVWT9oa+4Vn/yW80judwRsVy0Q+d9+2BN63IQpqAwx6maMqq2gPytYhah
 05QR+OV33gaada36AopUs0GM88xscwjw7wjJ0Ifw6tOD+ooHEo6X5m29ZcDn2Yz4kUXYhD
 Hr8qo7nxKnEmZSz61U4ERVTLZsFvvI8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-9FPhYdqyNWWXYZLX20JSbQ-1; Sun,
 10 May 2026 09:52:21 -0400
X-MC-Unique: 9FPhYdqyNWWXYZLX20JSbQ-1
X-Mimecast-MFC-AGG-ID: 9FPhYdqyNWWXYZLX20JSbQ_1778421140
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA5131956089
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:52:20 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 244511955D84; Sun, 10 May 2026 13:52:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:43 +0400
Subject: [PATCH 46/54] target/riscv: fix incorrect QAPI types and u8
 casting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-46-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=UE7mY6S0DrxxAQ3iVf+YTP5Z3aNRTDFraZUT6j5SWbc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItxlKIy4DBS7G+RqTsod0nA+/hkgMVnuhWpM
 6Oh3q7crxGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLcQAKCRDa6OEJdZac
 5b8pEACbtTdC7RotXUOUuVBTcY9EXjbtcOfPMvJqn8VIekbhO68fSYLZuXaEHDmenU897whI/nw
 x7/WS/cgqCLZ8IBxFjnCvWxGAVJFwTFB0CBop5DgVAQdlxx9bF16ijyxFLZaBaT4e7npKlQ/xp1
 ahkRlFjTy45H0KkLw8RfPyOe9Dvul2g2lO+2n9Er/BwImZSFc5jSeRZ2SaJXDLvMrQvAAnP3vcv
 h/4jeDNLfeKfrUS6QHAmxaOLkxjN3OLw9aGnEEybkw0WEVDbIp4levSkJq/JQiYU30SuMNbTUci
 HKferJ9VNNu5ogPyGwcKkRbNS9jzTtXdd6F8UoBfvSrxHQy0WM1X1ZP+YCKdEnknuDl89N0O4+t
 kKkAreGxbhgqonRuhxntIvPPTC9OsA0YsrfP1veaKQIAICu8FeiIC3BEb1Me7o6TySGyRfw9G1p
 XltmT3BYAyZ1kJ9IKVxuXPGveU273ARHnwx9ovDePowNrvGG8Oa9+9suu9x6uIJTFDhkHvFWpAq
 zApjwTVIpUiQ0HHphcArmtkyEdvAy/YmfbVQkd5J98ODZpZh40vZOE2ZJVk9X4JPNva25mzButw
 HE4Ih0UVajg5zHEGIlpobsyPOHTskA6gY1w1Vqm+i48HHo/SdBjBEts/5SJzLiS8BM+18zTWyZ+
 B5vJJF6Li4TP8nQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

"pmu_num" is u8, "pmu_mask" is u32, so is "pmp-granularity"

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/riscv/cpu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7d0cf88d48d..235764462cb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1467,7 +1467,7 @@ static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmu_num = {
-    .type = "int8",
+    .type = "uint8",
     .description = "pmu-num",
     .get = prop_pmu_num_get,
     .set = prop_pmu_num_set,
@@ -1503,13 +1503,13 @@ static void prop_pmu_mask_set(Object *obj, Visitor *v, const char *name,
 static void prop_pmu_mask_get(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    uint8_t pmu_mask = RISCV_CPU(obj)->cfg.pmu_mask;
+    uint32_t pmu_mask = RISCV_CPU(obj)->cfg.pmu_mask;
 
-    visit_type_uint8(v, name, &pmu_mask, errp);
+    visit_type_uint32(v, name, &pmu_mask, errp);
 }
 
 static const PropertyInfo prop_pmu_mask = {
-    .type = "int8",
+    .type = "uint32",
     .description = "pmu-mask",
     .get = prop_pmu_mask_get,
     .set = prop_pmu_mask_set,
@@ -1651,6 +1651,7 @@ static void prop_pmp_granularity_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pmp_granularity = {
+    .type = "uint32",
     .description = "pmp-granularity",
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,

-- 
2.54.0


