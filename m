Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED85CCF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4u2-0003XS-13; Tue, 24 Sep 2024 08:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4tz-0003Ny-Nf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:24 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1st4ty-0005tY-48
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:44:23 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-846c44bfbe7so1097925241.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1727181861; x=1727786661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFr1o/hBOBsQTMIRAihuGpWwsDolabR4H9g+K1D+mEA=;
 b=KNxGkkBCG4UtzCZiKsvGTX6P+mLElarTBelJ+i9/j/OeAHsRKo7AuRVT7FEsvFPouQ
 J7zvwNFBhn9yx5AxsOrF4CybLRXIjiDBdRtZXH3yNVG3v0pujYi89+7VmfEOAoTulX2O
 A5UGVAwqGVQuv4sBuArvb4KBxN7lojtosProeiRN11pQoRtc0k0Cf/QV1hRSCT6WddI9
 F3UwKN0Kivs9JBruNmdzSX9ES9c3YxXAYjV3XOoRqN/Iu4BfSHRLiUXAWwuk6rahMpLM
 mB905KHEN2eThP8IyToPcGSZ8q6fCBMRKk25PaCA4JJQw4QpcC6XlhWtna1CZHbYIttV
 DXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181861; x=1727786661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFr1o/hBOBsQTMIRAihuGpWwsDolabR4H9g+K1D+mEA=;
 b=QGjBq/Dg5CsDIAi/rPYokXNO3eI/+VpaYMT0feBmF7aMUPtzBwweCMjynNBgFdUmb+
 hSuq3jrFzTZvnjpCEyVMRpvyg21uQmUuF2oxY9xVLCc7vPPxQduYJnLpdg6E6f4WV1Hv
 HUFWxNGDGq/G1l+/xms/fcfQGiMsUX0V5QsLqzvO6uYOFZ7626VVJ9AHfmrMlrEWjUqI
 QSwNoznAVRd1AfzKtVmZJ1SbeIc2OxOzJ6T3dzXa/nC8T0kaV4ep8C3/zTQM2D6m2w/O
 XF2cWDEekMOJXBHJHOu0utsTYnWf1/kmzco4UJWry029JxbAI1IqAKzIRQQl/56RDRhh
 a+BQ==
X-Gm-Message-State: AOJu0YznwwudXLP+ND6XPBIpMuoafw7912DBP8CuWDb1Vy8vWsiPIu4U
 oC8VxIaRFfW3WwaGWqN0Lo9B9ZiSO3UvHG0APybb8JLFq0di9cw1cW8bRdIbrkDXINE0J0+CnRd
 F
X-Google-Smtp-Source: AGHT+IGLfIcAlQy2xXNtG3LDGrido84RjPwXwueSEW/3AdCbgqkQAy0xKlagDSassyUZLkR7gBkhGg==
X-Received: by 2002:a05:6122:1691:b0:4f5:2276:1366 with SMTP id
 71dfb90a1353d-503e04193e4mr9374152e0c.3.1727181860760; 
 Tue, 24 Sep 2024 05:44:20 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-505aa10a8fbsm767830e0c.49.2024.09.24.05.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 05:44:20 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 2/4] target/riscv/kvm: clarify how 'riscv-aia' default works
Date: Tue, 24 Sep 2024 09:44:05 -0300
Message-ID: <20240924124407.766495-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924124407.766495-1-dbarboza@ventanamicro.com>
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x92c.google.com
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

We do not have control in the default 'riscv-aia' default value. We can
try to set it to a specific value, in this case 'auto', but there's no
guarantee that the host will accept it.

Couple with this we're always doing a 'qemu_log' to inform whether we're
ended up using the host default or if we managed to set the AIA mode to
the QEMU default we wanted to set.

Change the 'riscv-aia' description to better reflect how the option
works, and remove the two informative 'qemu_log' that are now unneeded:
if no message shows, riscv-aia was set to the default or uset-set value.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 970a7ab2f1..32f3dd6a43 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1676,9 +1676,9 @@ void kvm_arch_accel_class_init(ObjectClass *oc)
     object_class_property_add_str(oc, "riscv-aia", riscv_get_kvm_aia,
                                   riscv_set_kvm_aia);
     object_class_property_set_description(oc, "riscv-aia",
-                                          "Set KVM AIA mode. Valid values are "
-                                          "emul, hwaccel, and auto. Default "
-                                          "is auto.");
+        "Set KVM AIA mode. Valid values are 'emul', 'hwaccel' and 'auto'. "
+        "Changing KVM AIA modes relies on host support. Defaults to 'auto' "
+        "if the host supports it");
     object_property_set_default_str(object_class_property_find(oc, "riscv-aia"),
                                     "auto");
 }
@@ -1712,10 +1712,7 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         exit(1);
     }
 
-    if (default_aia_mode == aia_mode) {
-        qemu_log("KVM AIA: using default host mode '%s'\n",
-                  kvm_aia_mode_str(default_aia_mode));
-    } else {
+    if (default_aia_mode != aia_mode) {
         ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                                 KVM_DEV_RISCV_AIA_CONFIG_MODE,
                                 &aia_mode, true, NULL);
@@ -1727,9 +1724,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
 
             /* failed to change AIA mode, use default */
             aia_mode = default_aia_mode;
-        } else {
-            qemu_log("KVM AIA: setting current mode to %s\n",
-                     kvm_aia_mode_str(aia_mode));
         }
     }
 
-- 
2.45.2


