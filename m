Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E345C25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 06:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5JwI-0001Om-Mo; Fri, 10 May 2024 02:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5Jvd-00017d-W4
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5Jva-0001ZM-Fs
 for qemu-devel@nongnu.org; Fri, 10 May 2024 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715323221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YrFwTifzcXCgtn8nac43KEmXtUZ2NyyytKwMCkBfxw=;
 b=Dqzu//xy+RkdFDiksn3HmHN0CDTcOR8q3mnqrmoUGlPezHyxVRk+DTuVuN+xsD6z0EIkVg
 T/zlMiDc88knSNQdJn/DuHYlqOmcNFsW48JUetuWAXiAg2tXDZxmKVjR2+NYH4R2nVHAGO
 9fA71XuweDJHxd3et5/0j2GJX2zuCN0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-qkXCWDNBMza0mmbPcv_-0A-1; Fri, 10 May 2024 02:40:18 -0400
X-MC-Unique: qkXCWDNBMza0mmbPcv_-0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55BC9185A780;
 Fri, 10 May 2024 06:40:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAAE52079267;
 Fri, 10 May 2024 06:40:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 8/8] tests/qtest: Add some test cases support on LoongArch
Date: Fri, 10 May 2024 08:40:01 +0200
Message-ID: <20240510064001.26002-9-thuth@redhat.com>
In-Reply-To: <20240510064001.26002-1-thuth@redhat.com>
References: <20240510064001.26002-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bibo Mao <maobibo@loongson.cn>

Add boot-serial-test and filter test cases support on LoongArch system.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20240509084745.2514607-1-maobibo@loongson.cn>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/boot-serial-test.c | 10 ++++++++++
 tests/qtest/meson.build        |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index e3b7d65fe5..df389adeeb 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -26,6 +26,14 @@ static const uint8_t bios_avr[] = {
     0x80, 0x93, 0xc6, 0x00, /* sts 0x00C6, r24 ; Output 'T' */
 };
 
+static const uint8_t bios_loongarch64[] = {
+    0x0c, 0xc0, 0x3f, 0x14,                 /* lu12i.w $t0, 0x1fe00    */
+    0x8c, 0x81, 0x87, 0x03,                 /* ori     $t0, $t0, 0x1e0 */
+    0x0d, 0x50, 0x81, 0x03,                 /* li.w    $t1, 'T'        */
+    0x8d, 0x01, 0x00, 0x29,                 /* st.b    $t1, $t0, 0     */
+    0xff, 0xf3, 0xff, 0x53,                 /*  b      -16  # loop     */
+};
+
 static const uint8_t kernel_mcf5208[] = {
     0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
     0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
@@ -167,6 +175,8 @@ static const testdef_t tests[] = {
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
     { "s390x", "s390-ccw-virtio", "", "device" },
+    { "loongarch64", "virt", "-cpu max", "TT", sizeof(bios_loongarch64),
+      NULL, bios_loongarch64 },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
     { "m68k", "next-cube", "", "TT", sizeof(bios_nextcube), 0, bios_nextcube },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6f2f594ace..86293051dc 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -139,6 +139,9 @@ qtests_hppa = ['boot-serial-test'] + \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
+qtests_loongarch64 = qtests_filter + \
+  ['boot-serial-test']
+
 qtests_m68k = ['boot-serial-test'] + \
   qtests_filter
 
-- 
2.45.0


