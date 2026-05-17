Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF18CD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPj-0008AX-Vl; Sat, 16 May 2026 20:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOm-0007E8-D5
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOh-000516-Vy
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:28 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8021c8c42fso341256a12.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977817; x=1779582617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVsvcQjrwAu/Fw5QeICNMsfPv4wnEzD0NNefmVwM0W0=;
 b=pBjTfX4Z5hdj3cIYMVVeIFr52mkMeBhMim/nQr5UXl+3gxOEhgxNKSJjWCZSGil+Wv
 SXSyzaTCzmfRcotl4GA3yzKuUrsRlTe1jbCemUHx9wOY9sOv2c1VW5A1HnRDrJ6YMhug
 Nd8aEuPyq9qkz97ZEA2wcJNXJ+w5I4Oa4I7A1ThXzcn+msVebH4B6KC00rL9Hvom5tNm
 V2rB6G2QC9u3CXHoS4mWYXIFEfLPWH+L3kdN4HAfClGF4yJxftcMzzL5R+JtCEHXST5Y
 aUkMmcfYeAQDo9nI13c5/RFCYVDFiAyYj3WTakT2Fosf9UCf3UU38TMI2vXraNUHsNY/
 MCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977817; x=1779582617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZVsvcQjrwAu/Fw5QeICNMsfPv4wnEzD0NNefmVwM0W0=;
 b=jrWVoYjOrHgqZIbD1UNl937BEhjuBzm0qFK7MQ20pnMd61Rlx7bMatDgRqWF1FMF7K
 cGi4z37OST+kAqmYhhiO+DyWkRgx7axJVcRyCySUi44tgYZHW/i3eaUvgjFi9f7j/P6i
 g8ejjTaq4acCiWRuPx9mYNvStKE5KpkZ8sgLFw4+mLzh3CHIMaMK90SshzTpoaB3FrIE
 NlfRVDoOu3LJPiGXyXIe5TlEPmYa9jASNjrAUPRNBDqbREp7qlXNeaAq971ZuELYzgRF
 xBiObg87JVj7whRnl4agthkCsQSwnXJhQGqPVR2TgE1usj715z3lcFFHNk+9Kxy4eDA7
 /meA==
X-Gm-Message-State: AOJu0Ywtvp0h0zNB9g688b0D09pnLH810LS64FEwzgrXW2Y/LANbw8yA
 8GucfeEF5cTLIlkY1A8+6MoIvGAHEXtnK7HpbkaCuV+7rV27Cs3hWq7Oid6KKqH5DaFef4tUwMs
 tq8NW
X-Gm-Gg: Acq92OGB+6+/c8OUeTESYMOav3f2b05gLOUw3hyeJt87Cb17JzSl8fX67nU8Al6bCdu
 jjNZOIKxxnqzFzuRJvdw+BJONGIORYzu/V6wqefoOHOrUFajN7vNEilB1VP87W67/eP/FLpH0P/
 iZc/E3dqNujeMS+bXI1/omQ/vN6GRgTYtyrqd0FbGzbsG73uqDgrlVk/6YQTjo8+EigEtTD8PvN
 Mz05AP1DrIyp3wUsjJ5M52qj69UwIoLZby7t0lVnEgSCZLK6cN5ktAmAshKFKlBFuZdvN9J+w9y
 R1rFc/TQIgzpBbHoy5KXKD2BcgNnV/XqMEvFENGAdXVr1NuERb0sSgx0OgVtM10ncwHtKAoIt+r
 BQJNS+VFImY97ZNMgJIP4Jnwl2vA8eaHcOdkhRIGo2Y+uTy6Lujl4M/j3KNTUmZtohpC5HHMRWN
 kcoqLEqKiBMesHl9sDVmu7YLZqveQp
X-Received: by 2002:a05:6a00:2793:b0:836:3f6a:3e7a with SMTP id
 d2e1a72fcca58-83f33d2774dmr9458967b3a.26.1778977817266; 
 Sat, 16 May 2026 17:30:17 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 15/63] tests/functional/aarch64/rme: update images to
 support FEAT_FP8
Date: Sat, 16 May 2026 17:29:14 -0700
Message-ID: <20260517003002.321430-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

As well, use -smp 1 since there is no visible speedup running with -smp 2.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/functional/aarch64/test_rme_sbsaref.py | 7 ++++---
 tests/functional/aarch64/test_rme_virt.py    | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index efea80c578..d252101ac6 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -20,12 +20,13 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # Built from:
     # https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
         ('https://github.com/p-b-o/qemu-linux-stack/'
-         'releases/download/build/rme_sbsa_release-6a2dfc5.tar.xz'),
-         '5adba482aa069912292a8da746c6b21268224d9d81c97fe7c0bed690579ebdcb')
+         'releases/download/build/rme_sbsa_release-74b7fab.tar.xz'),
+         '82a754bacea04e709cb1cf2759d1d12d09fabd612e014961eb32368723c7920a')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -57,7 +58,7 @@ def test_aarch64_rme_sbsaref(self):
                           ' --params "root=/dev/vda rw init=/init"')
 
         self.vm.add_args('-cpu', 'max,x-rme=on')
-        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-smp', '1')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'sbsa-ref')
         self.vm.add_args('-drive', f'file={pflash0},format=raw,if=pflash')
diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
index dcb18678bf..2afcdc6b07 100755
--- a/tests/functional/aarch64/test_rme_virt.py
+++ b/tests/functional/aarch64/test_rme_virt.py
@@ -19,12 +19,13 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
+    # Built from:
     # https://github.com/p-b-o/qemu-linux-stack/tree/rme_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
         ('https://github.com/p-b-o/qemu-linux-stack/'
-         'releases/download/build/rme_release-56bc99e.tar.xz'),
-         '0e3dc6b8a4b828dbae09c951a40dcb710eded084b32432b50c69cf4173ffa4be')
+         'releases/download/build/rme_release-2701e89.tar.xz'),
+         '8c40af440f5bd1518f7add7d0a43b39289865ee48430979db8024cb897a74790')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
@@ -44,7 +45,7 @@ def test_aarch64_rme_virt(self):
         rootfs = join(rme_stack, 'out', 'host.ext4')
 
         self.vm.add_args('-cpu', 'max,x-rme=on')
-        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-smp', '1')
         self.vm.add_args('-m', '2G')
         self.vm.add_args('-M', 'virt,acpi=off,'
                          'virtualization=on,'
-- 
2.43.0


