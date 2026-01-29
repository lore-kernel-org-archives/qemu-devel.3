Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E78ED6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUbB-0001pa-B4; Thu, 29 Jan 2026 11:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUay-0001Kn-Ux
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUax-00076n-02
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:12 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so9409185e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703009; x=1770307809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IlsBtCnmhIZFl3u2JK0/ew3XW8UoDsMuJkmGhR98BWo=;
 b=eHJexbK+3Oaqaa3rfAfTsSTLZnxAt3gjUxcUDhlM1xBuuiWzMsZ51AuKjOrVOndw3k
 m4mMcLiBYQhZ/IIA1NQUh5joctXJxJVJRn/v4ckQ7AlqSw7qS51mo4HhXI8dJqpPrbnP
 C9SlUrXdmxv/tzwSzp/tJVWamB7BPa5WDCCe8M0igOQGR0VwBphOblqx1s6ajseyi6R3
 CKMTa9SV90vMCGSegMUpk3lNoPf77p2k9d4+wSBM7LiOoX815cf/aNSpMVpLTULVWgq2
 R/6VoPSPj5ocdo1EQF7y3PMUQkdkGznFzJt1vOb1Qm5ZRB+HaNrQ2Q26LudeQetpNl1E
 Ihqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703009; x=1770307809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IlsBtCnmhIZFl3u2JK0/ew3XW8UoDsMuJkmGhR98BWo=;
 b=URM3AVMrKGiSj6wvv+k2IaIXLyaKV/9IGXVKx5dCrlF8mx7BKDYArd+K1DcsMSQqAq
 YPan4Ktp+9kFehZuhpHN0yQucGSbeMrfvI5bXYOt4fCwg5pPih1t6ptfKP1WIjhO+oso
 0lhIkt1WsARcxGlc399X2LFZ2h1F2cYLMw8AKsL6gu2H9WUVi9Wd3oxodB4VBdPEw+1Z
 rplfKFKt+XFrqxeoVqyRpd4aGgc8sBvfZbqsxF1iME4ESA3gUVoCL97pWlSW0xpdtQzS
 pfuTSwfJKLdQIMGZXXKMAX2ibqrJ5Gtf4UNB0DOp1q7awSRVK1+G6+R4wQ5ZORRY9Fto
 DxWg==
X-Gm-Message-State: AOJu0Yx+f32kPsXBTkROLexbJ3w38ojS1qB0dkT5cXz1dzK8L1xfO3OU
 nOAAJaXYWuaoGfrc5Z/q+jLkljjuk+/55jUjPURNXuj8tRTKm4zG1no2jieFgAeEAfT0NJlzxBf
 6gF9Ro78=
X-Gm-Gg: AZuq6aKZNDCPd6jfvb1qNJNLh3uKfYIzL+BCcZA5s5ukDsqxYv6Wwp4l1vkxwYnB1r4
 9m2OYdERpwf3nDuTYFHLoq5SYnc27ei1d083OGHMGPo/78i6lEhT8Ax0Wa743DQ2OtHzbz+Da/5
 oxcctjx7pD5l3zn2t91/gu8znvhwVe2iqOoX5bKBMNIo0SvCA7t2UFvcIqxActCCDvPC30gzg+5
 6T58jO8AM1SVhdiVA3aIVH+Qsl+pfTb8QgYhehjqmObgyJLWVY+UxmWQLiD1+DAT1g0tEy8bnW1
 qbmLoDyil6XIyGDzj+a2TWEpsn+qC40JSrwySGWb7AsVgV8IQtFt4zhqjeCaIKqIKtecRlBxjhY
 liHvc0x26HFc8XdEZKtEPonCRSMB+58lVvJ3M/7cSmifl4LVDwtlgbIoCR1NknTPDNKBNHY0hhh
 RfMFzBWp7rgtDpmbcCaYlKGjcnkHrCYw==
X-Received: by 2002:a05:600c:e40b:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4806a5bef7bmr114557085e9.13.1769703009487; 
 Thu, 29 Jan 2026 08:10:09 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] arm: add DCZID_EL0 to idregs array
Date: Thu, 29 Jan 2026 16:09:17 +0000
Message-ID: <20260129160917.1415092-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Continue moving ID registers to the idregs array, so that we
eventually can switch to an autogenerated cpu-sysregs.h.inc.

This requires a bit of care, since we still have to handle the EL
specific part (DCZID_EL0.DZP). The value previously saved in
cpu->dcz_blocksize is now kept in DCZID_EL.BS (transparent to
callers using the wrappers.)

KVM currently does not support DCZID_EL0 via ONE_REG, assert that
we're not trying to do anything with it until it does.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260105154119.59853-3-cohuck@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/cpu.h             | 8 ++++----
 target/arm/helper.c          | 4 +++-
 target/arm/tcg/translate.h   | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2ba49d8478..3d1ed40f04 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -40,3 +40,4 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
 DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
 DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
+DEF(DCZID_EL0, 3, 3, 0, 0, 7)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 019f4e6147..21fee5e840 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1112,8 +1112,6 @@ struct ArchCPU {
     bool prop_pauth_qarma5;
     bool prop_lpa2;
 
-    /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
-    uint8_t dcz_blocksize;
     /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
     uint8_t gm_blocksize;
 
@@ -1181,12 +1179,14 @@ struct ARMCPUClass {
 
 static inline uint8_t get_dczid_bs(ARMCPU *cpu)
 {
-    return cpu->dcz_blocksize;
+    return extract64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4);
 }
 
 static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
 {
-    cpu->dcz_blocksize = bs;
+    /* keep dzp unchanged */
+    cpu->isar.idregs[DCZID_EL0_IDX] =
+        deposit64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4, bs);
 }
 
 /* Callback functions for the generic timer's timers. */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4acaee407d..e86ceb130c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3314,12 +3314,14 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
     ARMCPU *cpu = env_archcpu(env);
     int dzp_bit = 1 << 4;
 
+    assert(!kvm_enabled());
+
     /* DZP indicates whether DC ZVA access is allowed */
     if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
         dzp_bit = 0;
     }
 
-    return cpu->dcz_blocksize | dzp_bit;
+    return cpu->isar.idregs[DCZID_EL0_IDX] | dzp_bit;
 }
 
 static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b62104b4ae..1e30d7c77c 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -193,7 +193,7 @@ typedef struct DisasContext {
      *  < 0, set by the current instruction.
      */
     int8_t btype;
-    /* A copy of cpu->dcz_blocksize. */
+    /* A copy of DCZID_EL0.BS. */
     uint8_t dcz_blocksize;
     /* A copy of cpu->gm_blocksize. */
     uint8_t gm_blocksize;
-- 
2.43.0


