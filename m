Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68986C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNc5-0007ge-Lb; Mon, 24 Aug 2026 01:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbw-0007Ag-Gz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:45 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbu-0003Aw-PX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:44 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so2336502a12.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550761; x=1788155561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SdRM7x1qzPNyHLcBH9MizyM4AFSQfbw/UNmU055a3dE=;
 b=XbIJdFBf1wgDZ1FBPhgfpScGq6pVWVsbgflxdL9FtKBKE06+ou3tMxmJQXjKRgI2nJ
 PoS5ODnQ3sVofqrBlP6NtTfpz3IDCZquotf3W1hy/yZFVtPuTare8/WTkhvE2k1B//qY
 B/+81r3M2lKBO6aAFCFC4wpEIr9xEmDfyM8GliiXFjaY92Is0io11BtuegGLsIGRlpQ6
 hfoXdx9qSttyCg5gFK9xrW/Tp+uYKN2ZqxZkZ1EzPKcPGqcqVsuMfB9sUpmVydTNMfqM
 wiK2wlMvIwUmJbmUHsDlqGb7fVS30gWgRSOZowOecHzk+CFA+HwjhfUIRLf5lzl+On7c
 3H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550761; x=1788155561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SdRM7x1qzPNyHLcBH9MizyM4AFSQfbw/UNmU055a3dE=;
 b=f04HRGvn5eQy0JJlDwswvVRM9y0V/iPho5JMuDaqgrcCP57tjbkHA2elEl2JTvU9YK
 xcrjEMhkhdPhBArAc54AKZqtCpssPw4MIaw3OF4A0EmjumgEHN90xCywHoq37iC0tkx1
 RHKKdEp7D4mXMtcOFeSlUmM1YTtQRiLlXVCMOBiMumfWgxO5+DxRi95oegrJ91mniQE2
 jZiu8piEpyRQZGcRM6HvDBENkpMUeV65mpxp1xwDBeN5fptrkftXwbanMYICi3sQefe+
 pGE46wpg0nCcndt90Kqs+u1goAfnRHkvhV7ZKJeakqVMyXRZXwkKbD6NqMZ2mbfQ07XW
 zgaA==
X-Gm-Message-State: AFuF++kFXvOlYIF1ty/fKhVOxtBmuEOZeuqGKXmvxSmNvq/51aLFCmNw
 2lJwOhlAegGjoLyBGoqD1ENKLCxeVaA5eA17ePcubgaVrF6JI35NdenPZo44Rg==
X-Gm-Gg: AR+sD13gchJAv+JZBzwFqsrrhpfY19jECtyMxn4t70ayDd9b3HPBfjF5HcDFCOrVb9D
 spLfQxO47UgOST+BHxoTWqJ6tTrEgH3z6SAdnO6qH+Beh6XbYhrP+wR1ShQobYQVbU+S3jvCt1q
 SOTNJ2UOyOPJL+Y8s1EMaf84WJyemrSFPXAAR2te5PlszPMiaUUWlaH1uxEYQ0IPao6ht9FA79x
 LLVRxnuaX3UVDmBumO5GkWmExVbUF6imIFt58F0z+WH5KDPe7N2oe68MlwUj/MCsLBASoY6aYtw
 zrM2sLJ8Ku4jjhM/ZAaXgFi/nJkyjMtHYp8UgmUgbT5Y/ys+a+ogBlKYS3V966Vfgar3g1ow0EJ
 a/SlfOL4V+NfK0ONJqXM0R2cXlRns3b5G2YfN46iZpmk8ul2tuHOfJdvV2cy4sASfxOfwW0qXnA
 uohZzdExz+qR1Xk/1Kmdv4ALj3VkanNHKt8VAyBLysm149zAromGy2mFT5ouhF+IwMAwJ7w3xW8
 WiwgMOLYcpJ7lFl
X-Received: by 2002:a17:90b:4c4d:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-395deffbb5amr27126609a91.8.1787550761341; 
 Sun, 23 Aug 2026 22:52:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: wangyang <wangyang25@otcaix.iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 86/96] target/riscv: honor zicbo* envcfg gating in
 linux-user mode
Date: Mon, 24 Aug 2026 15:47:56 +1000
Message-ID: <20260824054806.2790041-87-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: wangyang <wangyang25@otcaix.iscas.ac.cn>

In user-only builds check_zicbo_envcfg() skipped the envcfg check
entirely (#if !defined(CONFIG_USER_ONLY)), so cbo.inval/cbo.flush/
cbo.zero retired unconditionally in linux-user even though the
machine-level envcfg fields are never initialized.  Give the
user-mode build a senvcfg-based gate, and initialize SENVCFG_CBZE at
reset when ext_zicboz is enabled so cbo.zero stays usable while
cbo.inval/cbo.flush remain illegal, matching the user-mode view of a
typical firmware/kernel setup.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4107
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: wangyang <wangyang25@otcaix.iscas.ac.cn>
Message-ID: <9b2f22fc402b48b8ba81f72be8ed04bc@wangyang25.otcaix.iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c           |  8 ++++++++
 target/riscv/tcg/op_helper.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d8f239e41d..79ddde419a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1062,6 +1062,14 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
+    /*
+     * Match the user-mode view of a typical firmware/kernel setup where
+     * cbo.zero is enabled for user mode; the CBCFE/CBIE bits stay zero,
+     * so the cache-management operations remain illegal in user mode.
+     */
+    if (riscv_cpu_cfg(env)->ext_zicboz) {
+        env->senvcfg |= SENVCFG_CBZE;
+    }
     env->menvcfg = 0;
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index acdccd1a97..a7bd42d2c6 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -152,7 +152,16 @@ target_ulong helper_csrrw_i128(CPURISCVState *env, int csr,
 static void check_zicbo_envcfg(CPURISCVState *env, target_ulong envbits,
                                 uintptr_t ra)
 {
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * linux-user: the machine-level envcfg fields are not part of the
+     * user-mode environment; only the user-mode view of the enabling
+     * bits (senvcfg, as initialized for the guest) applies.
+     */
+    if (!get_field(env->senvcfg, envbits)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
+    }
+#else
     if ((env->priv < PRV_M) && !get_field(env->menvcfg, envbits)) {
         riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, ra);
     }
-- 
2.54.0


