Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8032ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUep-000704-BV; Tue, 29 Sep 2026 06:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUen-0006zG-Mv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUel-000891-QF
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:01:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6aa8d04fcddso1344184a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676110; x=1791280910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5X8d4mzD1FUNO8qMzl4hH+p4fBhPvGgv0Onyr1W6qQo=;
 b=QGLBGcVpMgxVHT00nEX1ZJQLiJ0SxQtVTx4W73KcA83xISucQKuLcfs0uv32MfSX4+
 QXokvZhMRyRyn92+6CZe+CO5TErysQHFE43mWFnVZIQD0DQVirMOSIVXtN2HVmWbCKp4
 vunTIw6LYW+tt0jBTK/8tQzgdeWzaF9YOi7v2uoHOosBhC9Pfq/4TJISqebcAbTDD6lD
 WEjqTCKYqAnfqBouGofLZjCjNQnWK4L0Nx8fFYaWWUUpOt3INlfM9MK3K83Y40q8YN37
 Nrzz2Ogm6x6gLeU393yaBqY0Cv8mwbhSqHeu7mSXt9AmBrOV4jGDW1kPPzlgMSlgzyDk
 5efQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676110; x=1791280910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5X8d4mzD1FUNO8qMzl4hH+p4fBhPvGgv0Onyr1W6qQo=;
 b=0v7FmBlx0sZT6c4HpY1KZcp7/88W3Ia++RXX0UcxdwY9IOrB+uPqd1y0bL564/aeI8
 EQ6PXFabXw+OwQEk4Jnp4VfdADzg0HMy52JaP4AlPi77Z18O1WK7aGM1DXT3FX73gdxr
 jXtFjb8bb17+MXAfBXVGglVi0SwoDUXmYtn71EjIWWtW1X0v+/O5JZLG6KJNo0V+fe3E
 hKWNQkXOP0FpQ709bhVEYSg+bj61sjTnmZkUxhaNO7LNB9L9JMJegL5S4GpYFlfrf/KU
 bzAK7YzNqEgi26f+bCmYZK8/cIoVrL4NZOOUPrwiBXOpyPKcNUQliqWXLk9hluqrMLfh
 ZH2Q==
X-Gm-Message-State: AFq9FYJY++SvTdaIEYqTHlAAd+R9yo3hBOAXf8S3USpy0ZwRq3ScB4PP
 VCIIITkvM66TWmuttFfg0R7fQX5vkT13tOn7+MEeVILb0veHmFNq0z/RsJs1OPfppnp8Es4XE7l
 RVvid
X-Gm-Gg: AYBFou3Rn+G1x3XpiU24+vZL6BIwXF7zc6QxJwEdfLYA06jU/tq4SiAlwXTb67m6P0k
 V9vjzbp9WjcVQtlvxO+6ZFuLbLV56dhJ/NoXQPyfOdEKM45Lio0XNAlBoZ8o2JS8O9eOm3KfMX9
 lHpRT6Hx5s3NnW1I9i0DBI55HLTbvf3PdWDZjjfxfXzAJ2+/3N5DwxaajBR48mfI/1BwkJBC6Ko
 JP+KfM0t0b6CHBBjWBn7HQ7Em8jw5yJF8y47Fn5uDCAZrU+u3KcJss2wxhZl129ESrg6cyUoDrd
 TBjW3Db/cEB/oPkxin9zEjp6dl7FXYDP5FgBjo/m/Z04fo8t7kjCYOgl2OxhaZmP+X3v/6RMRJM
 bJN1OnTA/+N3cP1ZtjK8q/JuAI/J/nNMI6GVngknFGFFJKXBvUFJeUUEuII0aIZKpBm6vZ0UlB8
 bgxaf2WdF/W2hW1wRn4pKz3qzxNOSmYf/Ll+qC+FMxCFp/4+0DIm14NJbcmgCYqCXggd7wya6m8
 r2r73vhgR+YbyWIIjhqoPrzMJBqAtLuMe+5sgN0YTOpDFUTbDcWxJ0AqJ1nH4b/nZP3sbRbINF9
 69o=
X-Received: by 2002:a05:6402:3257:20b0:6aa:e44a:ae9e with SMTP id
 4fb4d7f45d1cf-6aca82b4179mr1226492a12.1.1790676109414; 
 Tue, 29 Sep 2026 03:01:49 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.01.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:01:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/37] arm: handle demuxed ID registers
Date: Tue, 29 Sep 2026 11:01:04 +0100
Message-ID: <20260929100133.2598676-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

For some registers, we do not have a single ID register, but actually
an array of values (e.g. CCSIDR_EL1, where the actual value is
determined by whatever CSSELR_EL1 points to.) If we want to avoid
using a different way to handle registers like that for every
instance, we should provide some kind of infrastructure. Therefore,
add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
we already use for regular ID registers.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
Message-id: 20260916165117.39764-2-sebott@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-sysregs.h |  9 +++++++++
 target/arm/cpu.h         | 16 ++++++++++++++++
 target/arm/cpu64.c       |  8 ++++++++
 3 files changed, 33 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a8..a4b9621a7e1 100644
--- a/target/arm/cpu-sysregs.h
+++ b/target/arm/cpu-sysregs.h
@@ -20,20 +20,29 @@
 
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) NAME##_IDX,
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    NAME##_IDX,                                         \
+    NAME##_IDX_LAST = NAME##_IDX + NUM - 1,
+
 typedef enum ARMIDRegisterIdx {
 #include "cpu-sysregs.h.inc"
     NUM_ID_IDX,
 } ARMIDRegisterIdx;
 
 #undef DEF
+#undef DEF_MUX
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     SYS_##NAME = ENCODE_ID_REG(OP0, OP1, CRN, CRM, OP2),
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 typedef enum ARMSysRegs {
 #include "cpu-sysregs.h.inc"
 } ARMSysRegs;
 
 #undef DEF
+#undef DEF_MUX
 
 extern const uint32_t id_register_sysreg[NUM_ID_IDX];
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e3f931dba26..6d1bad1dfc6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -919,6 +919,22 @@ typedef struct {
         i_->idregs[REG ## _EL1_IDX];                                    \
     })
 
+#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        unsigned int idx_ = REG ## _IDX + INDEX;                        \
+        assert(idx_ <= REG ## _IDX_LAST);                               \
+        i_->idregs[idx_] = VALUE;                                       \
+    })
+
+#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        unsigned int idx_ = REG ## _IDX + INDEX;                        \
+        assert(idx_ <= REG ## _IDX_LAST);                               \
+        i_->idregs[idx_];                                               \
+    })
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c4725308..c11ab2da210 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -42,14 +42,21 @@
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
     [NAME##_IDX] = SYS_##NAME,
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 const uint32_t id_register_sysreg[NUM_ID_IDX] = {
 #include "cpu-sysregs.h.inc"
 };
 
 #undef DEF
+#undef DEF_MUX
 #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
     case SYS_##NAME: return NAME##_IDX;
 
+#define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM)     \
+    DEF(NAME, OP0, OP1, CRN, CRM, OP2)
+
 int get_sysreg_idx(ARMSysRegs sysreg)
 {
     switch (sysreg) {
@@ -59,6 +66,7 @@ int get_sysreg_idx(ARMSysRegs sysreg)
 }
 
 #undef DEF
+#undef DEF_MUX
 
 void aarch64_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 {
-- 
2.43.0


