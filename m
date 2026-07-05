Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DC5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNxY-0000Fg-RF; Sun, 05 Jul 2026 10:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxE-0008QE-Gq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNxD-0001VU-5p
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZJhrzwj0rR5P5+aXZ0Vf5nhibC8oR9PHvHBDPY2UrI=;
 b=WeANrcFHVAK/xoA5CXvy5Im5e61hWyrt0SrhWEWAACDfUAdN4SsUApPRx36DlTNLSjl/bQ
 36sqff8TV1cd3smhhOrSGXfnCHbUQd96V+CmfJy6xcFR+fSSlE8ngqgr36+0b8HY4OagKW
 PUFbEH8+smgzpeqdMsw6pNV3BJEnEUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-ww4I156mO5C5I6dofQUpXA-1; Sun, 05 Jul 2026 10:36:16 -0400
X-MC-Unique: ww4I156mO5C5I6dofQUpXA-1
X-Mimecast-MFC-AGG-ID: ww4I156mO5C5I6dofQUpXA_1783262174
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so15255875e9.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262174; x=1783866974; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lZJhrzwj0rR5P5+aXZ0Vf5nhibC8oR9PHvHBDPY2UrI=;
 b=pPNEvjSdW2uU9xD93ki2k9Nb13sQ2po1L+GPtKdkRccyCTZ8ZnOytOX4gFHbMsAuhK
 vIHQKasiKgrLDEdC3aFf8+otCTk/FxEYuG0kuMgdk4YiA7lNO6sJuSXwgBf598N3ojwy
 SJ733n7yyprsz3ttJzd2jYL0wwXjJtDn/qwcGEKfj7I6yuoHQ5by2J5W+JqQli5B7UXa
 TYtX7Uyzo33KKAUyM8vaoc4p5WYy8KnlSkeCxORSjVS6JmfnStPl0las2PCd0LXCjKf9
 64s3mt6t4dtag2trUwilIMuIp7RI3BR5hHvsmEIvupChFap+um3bHHXaeAxTgmniQn3g
 gz1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262174; x=1783866974;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZJhrzwj0rR5P5+aXZ0Vf5nhibC8oR9PHvHBDPY2UrI=;
 b=gmsmzARFRfj5S1CgXu5kupzeCpO4Xt4n1ZZxe5nqFwBxlhx0JwxIESjtD4aTp9l4ua
 IavRPoCFXf3FBkYJuAU2WCEuTdfeyhSn1yw5BwWa1K3e4npI+yst+VmgdEk9BboAy+/E
 5KQkdTEWeAWUZt0+MPT14J1AmRmEJGEj8Fo3dSbsg5I4dkYylRPHHC5i/G6dIWMZm0Gd
 rKbvH3oudKgmhuaa+mqOBqhKEgdIdrY+4I+OVxxg8nRCzj37PHVQyJdyviGI9MiWo3q6
 SkGEESkSAIc6nvCvoqO/sZit3Xg9ejLCfr4DTi7HzReOj58Hncm7CHijqoGt8a1Bud2q
 9SGA==
X-Gm-Message-State: AOJu0YzbknvkR/jO0qQgz0uE1eN5j1HkSq8s0s1LGq3hG/cdkmAvdopJ
 Q0PSMWm7aLJGjQoPDRPHqczfI8Sn6EG+oKmvHKeCxHB5/S1zIWWbesHaUF0ut6PjUl0DVrqmERy
 0fSb2e9y81vm5EQjnr3vAo1mos0JVc6hCkB4V26nZJXp9E5LYhKwoM8gK8Nk8imXVY0B15gBUBg
 vj19SclskOcM4/Omwz6YNTAMRYaNcnDUxgHA==
X-Gm-Gg: AfdE7ckBRXBf6CSvyhNHmmpT0zmGIQDVumzXAM+GYAFqDl9rlVDHHYkeav/4isycNm5
 TZ16dJ5VJCu87EFnuRjd3U5n0AvotSTQFiUPMRUcEPMPzNe5IRXnLvQbg4aSzkrLnMcKUFMsku6
 URI0Zh5S0w6yWGCAs71m8AoHiS9sl5vfClmGdMd7OnBrfuFo0OLNyxKPT6YAeS/x9ISPOlxkPtY
 QE3VnNmDQZgPLiHyjacDNaKvGC/mEOSI6X6PGZ908mmesC306kSDI+z8Mau2aaFTGWCz5FgtMMU
 W/lQgGkyglkv3Q5B30IBVujhKutsyjqlTuUvK5JP1mmM8mSvcnUaE9q0MjT80lrokM7G4xw9nkx
 K/7q7/qVUeXAEu3tApN/VbDb5zbDb6cNy
X-Received: by 2002:a05:600c:528c:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-493d11d3d1dmr77545925e9.3.1783262174145; 
 Sun, 05 Jul 2026 07:36:14 -0700 (PDT)
X-Received: by 2002:a05:600c:528c:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-493d11d3d1dmr77545465e9.3.1783262173594; 
 Sun, 05 Jul 2026 07:36:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab3a8sm231862935e9.6.2026.07.05.07.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:36:13 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:36:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 38/44] tests: acpi: arm/virt: add GTDT watchdog table test case
Message-ID: <c2a283fe9989a1839e931daf664f192339f5ce7e.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260702145856.1539572-13-imammedo@redhat.com>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index cee3dff31f..5cc526510a 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2314,6 +2314,24 @@ static void test_acpi_aarch64_virt_tcg_wdat(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .variant = ".gwdt",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    test_acpi_one("-cpu cortex-a57 -device sbsa-gwdt", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_viot(void)
 {
     test_data data = {
@@ -2935,6 +2953,8 @@ int main(int argc, char *argv[])
             }
             qtest_add_func("acpi/virt/acpi-watchdog",
                            test_acpi_aarch64_virt_tcg_wdat);
+            qtest_add_func("acpi/virt/gwdt-watchdog",
+                           test_acpi_aarch64_virt_tcg_gtdt_wd);
         }
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-- 
MST


