Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BBBC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 18:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAYnP-0000LF-Jh; Thu, 01 May 2025 14:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmY-0007Ug-9d
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:16 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAYmW-00082F-Ja
 for qemu-devel@nongnu.org; Thu, 01 May 2025 14:37:14 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d450154245so10673655ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746124630; x=1746729430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXADTJwgYK4rQDoTBJwmSMh4WIgzI1vWgP1J7gzagsQ=;
 b=KdltTTsn3Ni/h/oQJaeelw3ESJW7W7A2+G9lR0c0TeVqnLBx6Uzj2CeqoXCI63kGmR
 /ha07fqZ6oxT9KwEruLWaQeoqJ8K1upqrbTCbAMosdgsU06BhCYJnDN0/0ZSxQOVD98t
 fkf0g7dyIzSaJ522vquZHoCJ579Vu2xCAKKJ+PEXXA2rzenzaaXaZnchap5E47x1wtyl
 lqa27/9ikY9XT4lgFNdWrKNnLQrCNtYBgioWmTtQOrZG4WDp9oTpChprpkg1kYvS0dLM
 P+4BqF3i/bd3+nDGyE66m+xyrLSM1y5n8ER9SzJksM0uaTGcdFLn9Px4bT+sWyA2pNbK
 1n3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746124630; x=1746729430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXADTJwgYK4rQDoTBJwmSMh4WIgzI1vWgP1J7gzagsQ=;
 b=ZLRiZuLSC6eGSoXrGBfGR9YjA/u+/tJNRubgy9cx5/hPxN/1G6Mm733lQxhLEgkVuR
 8RvPpwqFuyNIzXmQXIM2d4bLIu2uHvXv0BR+LixBRidXsgwcOHmSmJyf9aO0yAHUvFkH
 2Y/qHgh1krvqHT5/oIDAh+IoMCSz2JH1cwniW4huo8SiaNsTsEzgkm8hkxaIx8EGzYAT
 bOZkwHRoP9Ji1u2sItXyOcaJIq9FfyVbm+K4R+vAoREMQrAfnzt392nhlGVlL9evR4Nw
 gl4DNFdrwottvLP0ER2uQXkHgRrjX2Flg+gRd1eAnF4AI2Kr/3Bm1qePbPDA2jC2DX2r
 +oiA==
X-Gm-Message-State: AOJu0Yya2iA2/bAU+U+MBKszSfVI1iudPjz1Fh+/ewy/4oe+lT+fXqrg
 0HvMbJisBnVd2PJuJtQvX2eUDG1d9uO/fIDiOC4xaM7fYG+twmbsCgSqVomq/Euau0U3KuDcZ7b
 6
X-Gm-Gg: ASbGncuFt6/inla/p8QsBlnZzlvcOegjWaIg6GJXH6GaNrRsYkljPa+AHcJLM2yF5OF
 6q0LQiUUGz82vM/0OhEDsz1EZjT3WOlKkldDNouG3BQEUvJG1PpjKPeSBuPsolJtT8MQ92OVG9h
 v9fwq2+kaAufXzlcEpi/KTwxT3lfxY+k2ccooN0cyp9WBbIRuimuF9cvxyQtoATajSTl2Ttq0Kb
 xd7Eu6OayDkN6x4XCGC9StVgzw3IWmGUq2PHt31ZI05xY7sESi8p5GU+7d/Y/5+H7cKDtg7410a
 llPZdP00MKpq3hSIrXMnhqoxUJkUdspWM4i/17GY+HeyUzLf4IWDIY0pVfyhFefE6f/I6VmFkCn
 CPBstnoJYnv1XiLEPZN3v
X-Google-Smtp-Source: AGHT+IG1AjPTJ9CmAnwaqhyWbwzMydJK02WR6ePNouF+OXrBZjI5JcJ2Zlaz7X4Kdy90KucPytqsSg==
X-Received: by 2002:a05:6e02:1f05:b0:3d8:1cba:1854 with SMTP id
 e9e14a558f8ab-3d970198c59mr55748625ab.1.1746124630482; 
 Thu, 01 May 2025 11:37:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975e7808esm2526775ab.25.2025.05.01.11.37.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 May 2025 11:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 04/16] hw/i386/pc: Remove pc_compat_2_6[] array
Date: Thu,  1 May 2025 20:36:16 +0200
Message-ID: <20250501183628.87479-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501183628.87479-1-philmd@linaro.org>
References: <20250501183628.87479-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12f.google.com
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

The pc_compat_2_6[] array was only used by the pc-q35-2.6
and pc-i440fx-2.6 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 3 ---
 hw/i386/pc.c         | 8 --------
 2 files changed, 11 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a3de3e9560d..4fb2033bc54 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -292,9 +292,6 @@ extern const size_t pc_compat_2_8_len;
 extern GlobalProperty pc_compat_2_7[];
 extern const size_t pc_compat_2_7_len;
 
-extern GlobalProperty pc_compat_2_6[];
-extern const size_t pc_compat_2_6_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, \
                                                  const void *data) \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 49632b69d29..7573b880905 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -251,14 +251,6 @@ GlobalProperty pc_compat_2_7[] = {
 };
 const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
 
-GlobalProperty pc_compat_2_6[] = {
-    { TYPE_X86_CPU, "cpuid-0xb", "off" },
-    { "vmxnet3", "romfile", "" },
-    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
-    { "apic-common", "legacy-instance-id", "on", }
-};
-const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
-
 /*
  * @PC_FW_DATA:
  * Size of the chunk of memory at the top of RAM for the BIOS ACPI tables
-- 
2.47.1


