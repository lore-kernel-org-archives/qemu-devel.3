Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADEEC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6srC-0000BD-5x; Wed, 16 Sep 2026 12:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr5-00006S-GV
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr3-0001d1-2f
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789577488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5EMh6T5QY03HYEhSI8G91RkkP5AWwPZD4FfiZxzxWk=;
 b=IWhyw/eaaZCzSIpW5ajkjYXwyKQUTaJQ39BBWx6jUV0fYFTO4//X2fp9EUAGJBqxb1Zo0S
 vFDdbQ2HznkgGALtMtfAygiKDPjg+mwRpi2q8fcEYNBaOnId/SaS+UdjcL1qWet+99gLDR
 rEj46yvb1GtaKzu+8U2JUhePAUQH8mM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-QYcdMNNNNIOFEKYU3xjKPg-1; Wed, 16 Sep 2026 12:51:26 -0400
X-MC-Unique: QYcdMNNNNIOFEKYU3xjKPg-1
X-Mimecast-MFC-AGG-ID: QYcdMNNNNIOFEKYU3xjKPg_1789577485
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4870eda3782so665883f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789577485; x=1790182285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h5EMh6T5QY03HYEhSI8G91RkkP5AWwPZD4FfiZxzxWk=;
 b=TPv9q5vvfzdQfnyHtumm47M6D18vruaLvcPRHWtsk0B23Dqjx4YfpS18SMb0XjsWf3
 LXA6VE40t1y1SDhcEq2ZpK5WhEgoHQbGSiejg0DrFf5un9rBTH1Uoc/7D8P59vbkXAX9
 ko6J1pi0WI41/pnJKUoNqQkyXnfIsklqcCFAfAdQzZRvOQrfUOaN1zw+dXIv369V3z7s
 x/+tYuQRK0JY3gX07zRWcUeWYmPElUOYDKiG1exrjvjNUKulPjcYIG240Q0VQSQqX/5F
 UZY1tFd42CZJ3pXE4STTY5nLXRzZqcoojwSdC4sYZhINzo8EUg9Ad+Oo6hf+aDyMS27i
 dVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577485; x=1790182285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h5EMh6T5QY03HYEhSI8G91RkkP5AWwPZD4FfiZxzxWk=;
 b=ptLxnOKF+U1Y7r1X4KgQAnLv8JpeO39Yvjf63TaWYa86663iKh/lS2y8XmHW6KhVqI
 3LNEhPSMWxIuHvuXV+yn6edadShJO1ALYdQSzuyOPsvdr+ser1iJw9ootu/UBxQxubux
 0Jp1KgJmf3Qls+3CZ4icxiX/LZ3D+LxRyR/CrHNQq+pWlOwm9NgAs7IBCFI+/+e25NOh
 GPTkzgmbBCRKr3xbWVWBbj6zPUmPmmO3iObzQGM+7C66NEjM+Bcf88o+uD3J0RLbZw6m
 HY/W47a/QZrucWUvmyAig9+Vh4bEa7h93vULaqs5BILnU17/Lz2Bi7rmU/OFPmFAv36D
 J9uA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVXLKjiAZ8ZI3AtwzeR/BZS9IEOQEUornqSEhhN/JTTgJgeAKuskDivOgZwZlbR5OpLyZwfmsDQv3a@nongnu.org
X-Gm-Message-State: AFuF++mP2kUnCUyAwgri8zeZkt3n44/0gepKhGGp3LlQffPn5QUCvaYP
 H3HLpA+rwDp60rmOh/XasF68BE0cqLnRSeIoIiZjEMMN/ujdGYVQC2TTCFaG0cp4r0a3xV6gJTt
 zssbro3xNKMUtrhbWFqTqlfKa//ucHiRMO725T4mnp8d6pCFFMbiyMnDB
X-Gm-Gg: AYBFou2YM+bKVxWtYmeoRh3LVWQ7113ShcKxNP1Ag1sUAd4arvskbzWrgyYqxA0veiT
 62OMSR+WTX/jVcjvRV4MaKTwxSdxMvwawqv2RJQ+L72/VLerLADDKhiWyuIDYffrx7t7rbWnmwM
 gsH4Cjm/v6rohJFRCrO9+sRlPnc591rJBapa7ZuAExtLZlY28KbmNkWIE6QPDykVIl/vbYxHtQ+
 fMttecqXB5d6+12qOQtta2MxfC6t+DvVnCLD5W9W4Kblu5hhL+d1Snu3d0X0v6POlmi5Gk72oZ5
 UVLZcgM5/EuslbpagjS/EfRSNGJJ2HyOAW+Wy1SrzXi9zi1LZEBDpNI2FNSCb8STeErCbeFeq/C
 U8HFoqnSBXGOxRafycQN1EgPmAOhdPlEexgJOp64lBG7Ttf5/fVxAuPwMLxnyKZwABQ==
X-Received: by 2002:a05:6000:250f:b0:487:8b9:66d6 with SMTP id
 ffacd0b85a97d-4870d0717e5mr4662150f8f.40.1789577484845; 
 Wed, 16 Sep 2026 09:51:24 -0700 (PDT)
X-Received: by 2002:a05:6000:250f:b0:487:8b9:66d6 with SMTP id
 ffacd0b85a97d-4870d0717e5mr4662124f8f.40.1789577484513; 
 Wed, 16 Sep 2026 09:51:24 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af00a400b6f52cb1a2e89932.dip0.t-ipconnect.de.
 [2003:f6:af00:a400:b6f5:2cb1:a2e8:9932])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm9655089f8f.23.2026.09.16.09.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:51:24 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v6 1/3] arm: handle demuxed ID registers
Date: Wed, 16 Sep 2026 18:51:15 +0200
Message-ID: <20260916165117.39764-2-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916165117.39764-1-sebott@redhat.com>
References: <20260916165117.39764-1-sebott@redhat.com>
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
 target/arm/cpu.h         | 16 ++++++++++++++++
 target/arm/cpu64.c       |  8 ++++++++
 3 files changed, 33 insertions(+)

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
index e3f931dba2..6d1bad1dfc 100644
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


