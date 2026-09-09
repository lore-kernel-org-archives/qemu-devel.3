Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA12C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JW5-0000GO-Cr; Wed, 09 Sep 2026 10:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW4-0000FT-0P
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW2-0005fW-3h
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788964989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NplcCtalrr4KaNtkMcW82lPswZ8AtudoDtbDep02z7I=;
 b=OBE2QcJI5yLYnz3Y/75MUfyaGQchsDrUrNpY5Ww8tPCaBVGjEwvsUi/kflaUBx3el+MDs8
 pqfSC0gFsefnWnk+rra4H/VE+fjFsR6qfuYjq0bHt/wscN6M7AHW56oPfiqv4ZoAMDBu8f
 0dnzr6H8wFhpEoP4W22e3Seox8PJcnQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-X3D1KIMAPKKQYO0hAUJQ9g-1; Wed, 09 Sep 2026 10:42:02 -0400
X-MC-Unique: X3D1KIMAPKKQYO0hAUJQ9g-1
X-Mimecast-MFC-AGG-ID: X3D1KIMAPKKQYO0hAUJQ9g_1788964921
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so5115972f8f.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788964921; x=1789569721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NplcCtalrr4KaNtkMcW82lPswZ8AtudoDtbDep02z7I=;
 b=oOz5VdDC0gliX8RaLFgzfb6JbBsROxYeDSn4Bqm1tAozd/EUFqS9XosDngUDaH+9wg
 oqkdP3Mp2oMkVJ4IugFdxgExLGEtgsqcUy0cCQ/6+i/ZC7reFg0w8dxlf+Qu7o3Bzgn+
 BV/YkwZ1mnTgPVnTD2/8BhBpikTBY0wcwz2w0wGJGKzEn5q4AXUJFv5n2Z2aMVeXeceo
 jewLE+FT4inVB9qjYY96OZuz5wfQMZfWC2pDwnd1nzhEipTueamU5ecVXVeKKt+qzIuD
 rhT980gP+ZW8QgrdTLymQPPMoCHapYxA0+dQK8B0qaMb7NQegJeCZ5GuvD86kf3bNjir
 crow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964921; x=1789569721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NplcCtalrr4KaNtkMcW82lPswZ8AtudoDtbDep02z7I=;
 b=XrpCdIm3e2hJAhvrWq3bRWx6kPJ7KNrVXS03cG08tZLK5ZJ6VObn1ile2RzivYfCB5
 uG/bQtxqptO2DAoiWfXUAuOHkAdWgWPTfKy60IJxV7acD6zxhCAAvEjpKTe78Ep15v8C
 g33teSeFN6S74K46mV29aseSgmimdZM6koNc2TxW1ssOQDeVz/6mPWdQSimJtwmlLiN1
 SzohE4dyFUQccMJTzSY90faxPKl2u/pPl07OhP5ta8phjbEPooaZE3fzmfk4patjGKoy
 wdG3WFWyjjfxCo2abi4vJuyvyX++WSIVmDoVAr45a0awh6yU4iRpZ5DJmYBJssOEJ6u7
 bZ4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNn9XB07qtXR5jCl5sN6YWqzg+m+Jk7dLjLHJCSaZrYKfJQanfH/2/LTYBucnaW4117atABlFSoIcj@nongnu.org
X-Gm-Message-State: AFuF++nR7MES5cnlaeKBpjvuQEMSz0xw8W9/EoaB0JojgnfUDA8bhcXl
 13MEYSGGMiLYwX8yfokU3Q+K3Fz4OR7/rMXWKEra88S+Q5r3eej98Sqq4K/dM/tQHjw99D0KFiL
 K0xzVQwbKWm0kkdwQa8lCMIehzvO6VbzpWEcPtbK6ZAsvfICL2BFmRQJ2
X-Gm-Gg: AYBFou32gM0re1xFasnG/Q1H7cz768OUvuI4Fcm9h9sKmdxCE/ZcpGxkkHGrsIh/uq6
 o/q4V6ZSqogKUk9z3SJG44zrMSSxNrQcaXK3ULyEsFbN+zWxHeGaVeylcLx+PYbO4GiRO7/CWgp
 j6XFLEA+9H4efIuDaq1DGge2YD0OggzGA/L4tfEUFs79J4PgChnHnqshTaIjQziubceQcg3sw3G
 m+U/4U20HXm4qM7Gy/AcRSh7HYar3WDUfo13dHMVR8crp3a+7msgiyGzgRlx3J9pshvuquFS9wl
 xOeuGMobEGfgZEe+UPSZq/FtOz8f4f4DbaajUidI+x5Y386lwZwzKk6cR1JoysZ4Fl2h2yTThGd
 ordyNsw7bAu5Pv2jamQFgqOAsbpFU8jU2bsHRbsahingaPpEdv0ru23be69BPHLnoiA==
X-Received: by 2002:a05:6000:985:b0:485:8b95:706f with SMTP id
 ffacd0b85a97d-4858b9570c4mr31588714f8f.13.1788964920886; 
 Wed, 09 Sep 2026 07:42:00 -0700 (PDT)
X-Received: by 2002:a05:6000:985:b0:485:8b95:706f with SMTP id
 ffacd0b85a97d-4858b9570c4mr31588672f8f.13.1788964920455; 
 Wed, 09 Sep 2026 07:42:00 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af0e1b00fa6b14698c8a91c3.dip0.t-ipconnect.de.
 [2003:f6:af0e:1b00:fa6b:1469:8c8a:91c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm32933395f8f.37.2026.09.09.07.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:41:59 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 1/3] arm: handle demuxed ID registers
Date: Wed,  9 Sep 2026 16:41:49 +0200
Message-ID: <20260909144151.26803-2-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909144151.26803-1-sebott@redhat.com>
References: <20260909144151.26803-1-sebott@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu-sysregs.h |  9 +++++++++
 target/arm/cpu.h         | 12 ++++++++++++
 target/arm/cpu64.c       |  8 ++++++++
 3 files changed, 29 insertions(+)

diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
index 7877a3b06a..a4b9621a7e 100644
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
index e3f931dba2..9652f8b0bf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -919,6 +919,18 @@ typedef struct {
         i_->idregs[REG ## _EL1_IDX];                                    \
     })
 
+#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs[REG ## _IDX + INDEX] = VALUE;                        \
+    })
+
+#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
+    ({                                                                  \
+        ARMISARegisters *i_ = (ISAR);                                   \
+        i_->idregs[REG ## _IDX + INDEX];                                \
+    })
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 4e8c472530..c11ab2da21 100644
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
2.55.0


