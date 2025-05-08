Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AF4C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1WL-0003zU-Ck; Thu, 08 May 2025 09:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1WB-0003ls-98
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD1W6-0004gd-AW
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:42:29 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-309fac646adso2036232a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746711744; x=1747316544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEKZAR/VZgMFUr6PYFqtHtppbGxXvaRql4Q5kTcH03k=;
 b=QDlobytFiUCP5MMBsbHeXpXcF3D7zGK+ybfv/zzhMfY86T0316LdO8RMI8Ak45i26U
 a6sE/C8hEGADJni5eQ3J81k6AvANmlGEru1ID3fKcJ2N/+Mk2j9vn7a0FUD/L7uhTKfM
 rCkHjqMhLDUHE2kVATpmEd0h80dK1YqfuWK8WBYe0XZSKrH1TGDKYhz9JGdr2OxvYM41
 iipdGn+1oP/RDRhnbgJxqKPz9irTeON9Xt66BFO5UEO6b+FWqz2Si0Zf69k6FLeKKCou
 PMhsmZ1N4KzHrRebgn3UKIiRwcUyA0aqQtSghMIt9ctZkZeF9tn/Y6DMQ4z2RUlJHDTO
 3hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711744; x=1747316544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zEKZAR/VZgMFUr6PYFqtHtppbGxXvaRql4Q5kTcH03k=;
 b=NN+WVSuUkoQuu7Q8QrRERd+GqzPZoGivoD4f3F7lfYBa4YVIZUlhAMVAef4at2HrTW
 FE+g7d989dQZqY1nRQNiFzjjiByUnmEtiHKElWINLJVTMR5o3zsU0d5HtJO6slrcbo0X
 ZgXJIEK+9kLg9YlMkAAC2TNtpjWz3HCinmBmZuer4x5yGnONxm0c2uOVq0taPX7Lcr6j
 gMYuurMgnCFsB5NAZLGX3Y4E0xwgtX63WnjsZWAgDG6WIgfzQ9ddk42+QFzuFh3xdVKb
 vS7QfNmfVmbnxKHD7BgLUVVresaHPEfhnkJjaSpsxBT8MFQ+7/r3RIfnsfCAB/JRJJzy
 csWw==
X-Gm-Message-State: AOJu0Yxbm6jJSMd38KwO7TahjEvj8KfGsBCJW9ymbqoPJfPHsj1vodxl
 mTiFh6wt3XmRtEp9hXYkEsVvJoUI7LhVyNyJiV0SJLO7TaWRm/Binr9qNMUewG7Dve4pc8xc8WM
 a2TqkKQ==
X-Gm-Gg: ASbGncuba2RY6DaeKftqeldB29u05H135HkxqiwLaT7MwxRugqy7n4iXVlnGvide9VJ
 Jkb09eG8ynwiEM2zzqnmQ59t81CC2HiYdA5XayI9T9prNzYgxdYVgMNNV2JOxj0LjRwiZh2D/JI
 rhePjJtDD8KDNhOk+WsZWVg3lTWRpukSY0783APxYASKIUD3a4iPGFjEUnEdlmPPLGZY1nGliFE
 pG3WKKJBkUPufAPppa5cqLq1jc8wZmlaC8S0+sJXgo+dpYRyBv/GccXIT95GHLQG7s5GbKaRceD
 6CQTv3W1bbDMCPjgdQJPWplE4H6rGYmvn5bWdo6bC2jSseDaREBvj3/vZRLIqOXwvf7WXm2S7y3
 tEBbwPVMVFv9293I=
X-Google-Smtp-Source: AGHT+IH1WVEL7CuYnhcuoeZe0dF5ZImTjMBcZgMJJlYHkrELO77MU8NVhB0RggY4VqZxOdLZ04ngFQ==
X-Received: by 2002:a17:90b:3b91:b0:2ee:8cbb:de28 with SMTP id
 98e67ed59e1d1-30adbf18acamr5563077a91.8.1746711743871; 
 Thu, 08 May 2025 06:42:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d2f15dsm2382033a91.18.2025.05.08.06.42.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 06:42:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yi Liu <yi.l.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Amit Shah <amit@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 17/27] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
Date: Thu,  8 May 2025 15:35:40 +0200
Message-ID: <20250508133550.81391-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508133550.81391-1-philmd@linaro.org>
References: <20250508133550.81391-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
deprecation & removal") they can now be removed.  Remove the qtest
in test-x86-cpuid-compat.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c                   |  9 ---------
 hw/i386/pc_q35.c                    | 10 ----------
 tests/qtest/test-x86-cpuid-compat.c | 11 -----------
 3 files changed, 30 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 98a118fd4a0..98bd8d0e67b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -755,15 +755,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
 
 DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_machine_2_7_options(MachineClass *m)
-{
-    pc_i440fx_machine_2_8_options(m);
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_I440FX_MACHINE(2, 7);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b7ffb5f1216..a1f46cd8f03 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
 }
 
 DEFINE_Q35_MACHINE(2, 8);
-
-static void pc_q35_machine_2_7_options(MachineClass *m)
-{
-    pc_q35_machine_2_8_options(m);
-    m->max_cpus = 255;
-    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
-    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
-}
-
-DEFINE_Q35_MACHINE(2, 7);
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 456e2af6657..5e0547e81b7 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -345,17 +345,6 @@ int main(int argc, char **argv)
 
     /* Check compatibility of old machine-types that didn't
      * auto-increase level/xlevel/xlevel2: */
-    if (qtest_has_machine("pc-i440fx-2.7")) {
-        add_cpuid_test("x86/cpuid/auto-level/pc-2.7",
-                       "486", "arat=on,avx512vbmi=on,xsaveopt=on",
-                       "pc-i440fx-2.7", "level", 1);
-        add_cpuid_test("x86/cpuid/auto-xlevel/pc-2.7",
-                       "486", "3dnow=on,sse4a=on,invtsc=on,npt=on,svm=on",
-                       "pc-i440fx-2.7", "xlevel", 0);
-        add_cpuid_test("x86/cpuid/auto-xlevel2/pc-2.7",
-                       "486", "xstore=on", "pc-i440fx-2.7",
-                       "xlevel2", 0);
-    }
     if (qtest_has_machine("pc-i440fx-2.9")) {
         add_cpuid_test("x86/cpuid/auto-level7/pc-i440fx-2.9/off",
                        "Conroe", NULL, "pc-i440fx-2.9",
-- 
2.47.1


