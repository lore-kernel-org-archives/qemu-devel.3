Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34499C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOiF-0007Il-9Q; Mon, 12 May 2025 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhw-0007Df-1G
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:21 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOhn-0001fm-Uy
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:40:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a1f5d2d91eso2123146f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039205; x=1747644005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uTMQAKQrwsxKp+xMJSEkXrWXfxVvSZortm+STZ1AZKc=;
 b=ylqpoYzyba04r6TOuY6tAL2s9SmQDaJyhVE6XAA/WRGhEJUz+/bWJUcG/Sn/zwKrb4
 OrOPEg8beCcWxHvCijM8mKP0JkFG2FB6X0mC8bHS/qu46kxwOuTTk7CXIyeqoEVLi5eh
 bMsEqpqYh01YZmvuQ0mS81XJhcMfNzE3RRpouW8OMhqrbysJ/PPEKuAWCmhuhSGakCAb
 7Z/a01sQdLrCjk7wNxGj0vpCmWkbi5K6Y/m1hQ5CrU1ChOVBvlGwnJlBGK+G5uu4pIVc
 nynTjqw6sS/BHzgb50wREgbRsedczSzfSK9IbGFbdTdPLGNQyvprFiRxODNX/UORAYl0
 itcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039205; x=1747644005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTMQAKQrwsxKp+xMJSEkXrWXfxVvSZortm+STZ1AZKc=;
 b=kmzTXfvfbpMk1vEaWgEnUotTHX07/XYKDZPII0hAsbf0M7OemDeargLXHqv/izJvfZ
 AFm7cL/VOmYRxN5fCHZlSh2GlMHkGF5RsS21FQpd/Lx977Yhmlqc1O4qynx4f1ZHx4Rq
 b2dK7VfPRaNt4UoqHCatlE+K+BUbgs2oeHa9Oe52BSr+i0GO7EWIhEpKtaXg42cWfPhd
 NrHSSgBdjUfWr1tOcoQpQWj/AX/nlCyUxuIh/N/RoODDKca25Qx7cCp7Sj1GBQfWQrnz
 SnxZvVufLWy/6wAlCHBLNkWPiJYHxBRV4YbD6QwMfiUaXrd/UNGuYtcM/d4UmbJVSMHZ
 56KA==
X-Gm-Message-State: AOJu0YzAdHPbcTgMYkxCtIFfB/5ns9hlJQUVuRF0HAvxa8CYlSFONIK1
 xgLkX+1pQfJnNfqvSPAmsPNJlW60lIHRLCHDFO/VIHq5amqsibsGc+u9FioLL3e7sjSTotdQGpG
 hjrmk4Q==
X-Gm-Gg: ASbGncuSBGxZ5VLgM+5GGvf50jJ2Njw1TQ5iWJ2ibxV99bHwUxfxezfEEotVfRnSKh0
 KjeKWpEiJNCs95a/JAkXUWJp5eorKtYD8prBCVfy2VkEfhwbVzChoDkv2WuW4RZMx7bO8vhhcA3
 H5FHyHcEldqkrLcvndazGr3O200sNrmAgw+5Lc7Mk8ILgwRLHd5LYqrApE3vIy8Q1jKjljVPjm+
 bfDWm2mu4h1vUaF6E+VxibhKbC6RUR7Y68fUOFu4DkHydCRp8UscM91v2GXKFc6hqHKfl7yawC2
 vcK/4f+UyPPKe+EuMOf/SCP8gJspjJ0qDpUesD6/Z1Wg4ISJaxznNVlZuV43UZkLBoC57tCcTwo
 UxCeBEHQm89A1FZZCtbcue5k=
X-Google-Smtp-Source: AGHT+IHrGU8RuKgzP+9CaT5xBTOF2lk2Oqz9U3OnAidWY+L54CYZ2ZFbRVmuOBF+b6M6P4Z6IE4cpQ==
X-Received: by 2002:a05:6000:430e:b0:39f:efb:c2f6 with SMTP id
 ffacd0b85a97d-3a1f646600fmr10771552f8f.33.1747039205021; 
 Mon, 12 May 2025 01:40:05 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddd2dsm11702422f8f.9.2025.05.12.01.40.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:40:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 01/19] hw/i386/pc: Remove deprecated pc-q35-2.4 and
 pc-i440fx-2.4 machines
Date: Mon, 12 May 2025 10:39:30 +0200
Message-ID: <20250512083948.39294-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These machines has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") they can now be removed.

Remove the qtest in test-x86-cpuid-compat.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc_piix.c                   | 13 -------------
 hw/i386/pc_q35.c                    | 13 -------------
 tests/qtest/test-x86-cpuid-compat.c | 14 --------------
 3 files changed, 40 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0dce512f184..04213b45b44 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -791,19 +791,6 @@ static void pc_i440fx_machine_2_5_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 4);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c538b3d05b4..47e12602413 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -685,16 +685,3 @@ static void pc_q35_machine_2_5_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 5);
-
-static void pc_q35_machine_2_4_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_q35_machine_2_5_options(m);
-    m->hw_version = "2.4.0";
-    pcmc->broken_reserved_end = true;
-    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
-    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
-}
-
-DEFINE_Q35_MACHINE(2, 4);
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index c9de47bb269..456e2af6657 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -365,20 +365,6 @@ int main(int argc, char **argv)
                        "level", 10);
     }
 
-    /*
-     * xlevel doesn't have any feature that triggers auto-level
-     * code on old machine-types.  Just check that the compat code
-     * is working correctly:
-     */
-    if (qtest_has_machine("pc-i440fx-2.4")) {
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-off",
-                       "SandyBridge", NULL, "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-        add_cpuid_test("x86/cpuid/xlevel-compat/pc-i440fx-2.4/npt-on",
-                       "SandyBridge", "svm=on,npt=on", "pc-i440fx-2.4",
-                       "xlevel", 0x80000008);
-    }
-
     /* Test feature parsing */
     add_feature_test("x86/cpuid/features/plus",
                      "486", "+arat",
-- 
2.47.1


