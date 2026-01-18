Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AD9CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaob-0003sY-SQ; Sun, 18 Jan 2026 17:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoZ-0003r8-Sd
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:00:08 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhaoY-0008WL-24
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:00:07 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4801bbbdb4aso17159115e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773604; x=1769378404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pijc4SGaIxjhH3hv/CpBfkcN+nrHKNQfSy0KVIp/tpg=;
 b=jpK4WCfFHllo+/ae0q0gm6BOFWxRKQ8AykPc7gejav1BKqlWTMbvhI6ZMQFRtIY4V0
 ZWp1L7e0kz4//uMjbMIeFdw15rl0ybl2xJsbuY723z0pnMKLzsXsBV5O56jbgSj+NUhl
 1fRAu7BlJgN82BAx6A8DJWYyBKmxRzH1df8X9htL4x/RBgn30vWVrZPqY5WmdVDNuNXJ
 l8BD1SH4XayOtCE9KHbv3ljKV15LZBnX5u1iyLkDZRrFSU8/DRxGPeElUnnWUy9qX8Zu
 3Gy+m2Mm2hE9B6MNxmcC+r35Nk5mY9EZ4ttq9sp3WzEcfFTvRGBE2XqGtnjek35/CBIR
 8Osw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773604; x=1769378404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pijc4SGaIxjhH3hv/CpBfkcN+nrHKNQfSy0KVIp/tpg=;
 b=E0g68rLKfLRZKSBYLe14hWfywaspPyY+jfx28QudA2B8ryuEwvV5XdxKO8di/eRICM
 BqViatoAGAtv4zmT8pwCqDiW9nLYGNkjn4vYMPdCAZAOF+m4PD4QW/BtTvSTFfAB6wE8
 cMo0hrEvgrRptxkCeCuIIlEgCmY3y5HyqgX76hMdKE85J1hFUoKOXlrEoGVdncIj/jX4
 RBB5KOsOBwvDaX+mxCIjmcLAjLZudS/XBq3/fwtuZjFPPWuV6DoyrKNpIx3u96Z61Mh6
 6/jayGB9CZqqsnzVsjERNaFcv5X2LqHmvuAbSsc3iRwsWxwKmPRlxltmpnzwM/P0r+WI
 5Whw==
X-Gm-Message-State: AOJu0YxezVckyRcopGiTd2ayOrNJn4hM6ouOseypA3R+KLGbdo+khFRz
 i/WSkiD6Cdo+Un+FfAXmuDo5pFxeWBwqN5Ry0B7l/3NNYg2SpKfE/pzYMH5UThpPsUlhA3Uid7H
 wvHeZ5/4=
X-Gm-Gg: AY/fxX4nlWOT2LzTc1eI+Lz5yNJBfv2uwUfAT+OzzLOgf7ZgLpZrstZs21KDlUOcITS
 SRNW8XbQnQ8F4pG2MiOl8aqjagnBrSFRRQAZw2t9YHsZ4GwK82Ll6bqQ+Zqx2rFZNYuCeE9YLW3
 QQYIhCjgXj50SUvv9ITu5X3XJqaWITHrPiC6/SzwGnn8z0KwaAkUPEt/mjOZ+Itm7Lp4qpJR6gH
 DDYDrs1ZswJfPSexP2xktEWBNqsNn+GV4G4ni+GIVkfacOpMf6AkJYqEZ34h9b2dL84JZLms8vK
 JQh/Q2ZOjqN4qQSrVvicHFW7ZAIU0LPYKZbBbhy91/iOBcTflSEgDP9U+g7/3nJHvl1mBEZlj8+
 xk0fk+T8I0NRMmRnokwT+O4aXzZ3U/EkQgiKUnJsC0aQ4QC3rGxXqAUzTJjPgx/vKbd5l7xBY20
 BeTU5/gTDeAOlff4wyB/zHKEY9fjblnxpFuku7znKHP0LBzzXdbdPJbM9U/IsnOn4uO9//kzI=
X-Received: by 2002:a05:600c:3e8e:b0:47b:deb9:163d with SMTP id
 5b1f17b1804b1-4801e53c118mr104787115e9.7.1768773604014; 
 Sun, 18 Jan 2026 14:00:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm214997135e9.12.2026.01.18.14.00.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Jan 2026 14:00:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 2/2] target/arm/hvf: Sync CNTV_CTL_EL0 & CNTV_CVAL_EL0
Date: Sun, 18 Jan 2026 22:59:45 +0100
Message-ID: <20260118215945.46693-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118215945.46693-1-philmd@linaro.org>
References: <20260118215945.46693-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Keep CNTV_CTL_EL0 and CNTV_CVAL_EL0 synchronized with the
host hardware accelerator.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index fcb7fa3b30c..9ce720793d8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -200,6 +200,9 @@ void hvf_arm_init_debug(void)
 #define SYSREG_PMCEID0_EL0    SYSREG(3, 3, 9, 12, 6)
 #define SYSREG_PMCEID1_EL0    SYSREG(3, 3, 9, 12, 7)
 #define SYSREG_PMCCNTR_EL0    SYSREG(3, 3, 9, 13, 0)
+
+#define SYSREG_CNTV_CTL_EL0   SYSREG(3, 3, 14, 3, 1)
+#define SYSREG_CNTV_CVAL_EL0  SYSREG(3, 3, 14, 3, 2)
 #define SYSREG_PMCCFILTR_EL0  SYSREG(3, 3, 14, 15, 7)
 
 #define SYSREG_ICC_AP0R0_EL1     SYSREG(3, 0, 12, 8, 4)
@@ -502,6 +505,7 @@ int hvf_arch_get_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -631,6 +635,16 @@ int hvf_arch_get_registers(CPUState *cpu)
 
     aarch64_restore_sp(env, arm_current_el(env));
 
+    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, &val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, val);
+    assert(b);
+
+    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, &val);
+    assert_hvf_ok(ret);
+    b = hvf_sysreg_write_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, val);
+    assert(b);
+
     return 0;
 }
 
@@ -642,6 +656,7 @@ int hvf_arch_put_registers(CPUState *cpu)
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
     int i, n;
+    bool b;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -756,6 +771,16 @@ int hvf_arch_put_registers(CPUState *cpu)
     ret = hv_vcpu_set_vtimer_offset(cpu->accel->fd, hvf_state->vtimer_offset);
     assert_hvf_ok(ret);
 
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CVAL_EL0, &val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CVAL_EL0, val);
+    assert_hvf_ok(ret);
+
+    b = hvf_sysreg_read_cp(cpu, "VTimer", SYSREG_CNTV_CTL_EL0, &val);
+    assert(b);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTV_CTL_EL0, val);
+    assert_hvf_ok(ret);
+
     return 0;
 }
 
-- 
2.52.0


