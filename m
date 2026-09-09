Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5DEC79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JW8-0000He-F4; Wed, 09 Sep 2026 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW6-0000HG-KP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x4JW2-0005fh-Dl
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788964989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3z3uG81r0Svs/ChPjpP+1B4Cf8w806Yhgna5tjlMtvs=;
 b=QuN6pg0AgaHJtiLZdN4WKyuZIUIgx5RVqaKkIH7dbA/mHR0F6bPZx/CROckWIiHfqD34/E
 8sSkSHZTeNfcctM4TQUu7AfoReZpkpeGiMYdi5oJhWAiaP2d02hO7TKBa4oIP0U9eEkRV8
 uBkhkaDhdj4FgyF5ca2LH+pDhjSgMDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-QavUnqBAOe6qYn7Ubs1PGg-1; Wed, 09 Sep 2026 10:42:04 -0400
X-MC-Unique: QavUnqBAOe6qYn7Ubs1PGg-1
X-Mimecast-MFC-AGG-ID: QavUnqBAOe6qYn7Ubs1PGg_1788964923
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so4260186f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788964923; x=1789569723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3z3uG81r0Svs/ChPjpP+1B4Cf8w806Yhgna5tjlMtvs=;
 b=Ag6ECAHnQsOFGtS/oc2VO2L3RYQLk34859556P62Rvt9qok89g8vwQjpJkLb8OBxQ4
 Ht3uK54DmDTJgHF9I5IvMk85pXoRpct0EYtcPwaU+eKB6QwsvL/bZmFjyqdF2Aa77wtf
 Qd6HK5MGPdBNPkmxWSQr7pedAVPLTkWNRtxuo//TOWQGyJBW7CEBdJjZVqiba5PW422+
 hLP1XNFjyxMUYmiAibr5iqRUewGIsPTBiVjVzKrwUy+bwUvXy6QEq4PJdYywt08I5bg+
 ikl/vluyOOW2YRJv/+UUT18W5xBQlxJVHXZqjuXBWVI24JioWDL0y/40Pnkki11kdeBo
 +5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964923; x=1789569723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3z3uG81r0Svs/ChPjpP+1B4Cf8w806Yhgna5tjlMtvs=;
 b=cAuu7imCQ7ScLRgxgoEKUX+jQj79mPDuzzlFYJD/4Ug3ptaIUzkmgX4QlKDQOJEmcm
 L33GqPAxGT/sV/X9anY8txvKywwYSkm0v2sHaWczLE1DO7jq8PAwDJVQ5JghVzqqrA1R
 CzFBQGjOTjbb1vo6VCGs+Q5WMnhSiOJCj4bDu3yc/OVxkjAh9bRdQ8yqpNj6GaEHbAzv
 KX85oL+lNW148/dD3z2wSMFA1IjCNcKblvFIa8XTwQiwoDIuNGRQy0v8TQhdTuAm1z6e
 6qdYBLjvjDNNBSEzqaNPXZoTsyRXh0pVWmoK1knIY+S/0yfVw/XvKuq6NWtD7Ow/IuA4
 Qn+w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj8dvj3eNa1ThhUbFnwDgnNDxSzrGI+hRPrUNm0Z7gTiH0t2F+6S58dxLySpA8JL9PHFnLqf7Efgl5@nongnu.org
X-Gm-Message-State: AFuF++k66/ecVMdPGyTowJOgzVJqGzCdrOiFp6WUdY+BbXjV9E7yGS+Q
 J25/j+l7oHn/b0wOPmoKFfhS/idD50q6fdyYCpWXiUmAbCY8WAPou5uEVgPi8xD6WLDAmzXCTLA
 YLfRayxIhvikcGOJSvUpfNYA8xyLZY4eV6IStmy+isUjGW/SiQb4/CHZdrdl83HUW
X-Gm-Gg: AYBFou1Ja1X/9AvKN3IPPbffy2wmNvoCrKuHX3WhaujcH+T1D8WxHFGidLQDKo3dUQb
 gyovfL1w8l+780M1nLVnar3LDxRvhgui5yBotC46q6EVkfxc7nmR/RFbd/DQlOXGHp7N5xTHY4z
 eeK07VBY9KZP5WI7xis+U7owh7AOHWVTSouPJttjPp1QsN1sbyqwY4Aqg3O/+PDVOmfEJAggAlJ
 kH9T1b9KlLy2yY9aSgrLMEz2zfq1blZBegppP1J5uTnG/VlZVjoxLYo+aMflfZyIqQptJik9ghm
 01QGZTBOw4/i7Z1IcQ0Y4ck2PaUi13tdccfJhgWRfgYTqauK7z7XG1O5vRcNCo5i9UZYfvRdj8A
 7cGksvo2Kep+YJuTE4qRAq8wAI9CFe+2kO25VG03Mtb2++6Zva1QGVhn5FwW+NgLzbg==
X-Received: by 2002:a05:6000:2909:b0:485:8dd9:910f with SMTP id
 ffacd0b85a97d-4858dd991a5mr34922467f8f.9.1788964922694; 
 Wed, 09 Sep 2026 07:42:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2909:b0:485:8dd9:910f with SMTP id
 ffacd0b85a97d-4858dd991a5mr34922405f8f.9.1788964922092; 
 Wed, 09 Sep 2026 07:42:02 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af0e1b00fa6b14698c8a91c3.dip0.t-ipconnect.de.
 [2003:f6:af0e:1b00:fa6b:1469:8c8a:91c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485958f1493sm32933395f8f.37.2026.09.09.07.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 07:42:01 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v5 2/3] arm: handle CCSIDR_EL1 as a demuxed register
Date: Wed,  9 Sep 2026 16:41:50 +0200
Message-ID: <20260909144151.26803-3-sebott@redhat.com>
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

From: Cornelia Huck <cohuck@redhat.com>

Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
infrastructure.

Note: the existing size of 16 is kept and might be extended
at a later time.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 target/arm/cpu.h             |  6 ----
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/arm/virt.c                | 19 ++++------
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  6 ++--
 target/arm/cpu64.c           |  6 ++--
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu32.c       | 26 +++++++-------
 target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
 9 files changed, 63 insertions(+), 73 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9652f8b0bf..f832cdd7e1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1121,10 +1121,6 @@ struct ArchCPU {
     uint64_t pmceid0;
     uint64_t pmceid1;
     uint64_t mp_affinity; /* MP ID without feature bits */
-    /* The elements of this array are the CCSIDR values for each cache,
-     * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
-     */
-    uint64_t ccsidr[16];
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
@@ -2138,8 +2134,6 @@ FIELD(MFAR, FPA, 12, 40)
 FIELD(MFAR, NSE, 62, 1)
 FIELD(MFAR, NS, 63, 1)
 
-QEMU_BUILD_BUG_ON(ARRAY_SIZE(((ARMCPU *)0)->ccsidr) <= R_V7M_CSSELR_INDEX_MASK);
-
 /* If adding a feature bit which corresponds to a Linux ELF
  * HWCAP bit, remember to update the feature-bit-to-hwcap
  * mapping in linux-user/elfload.c:get_elf_hwcap().
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 6e8b335b8f..d9e058a57e 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -39,6 +39,7 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
 DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
 DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF_MUX(CCSIDR_EL1, 3, 1, 0, 0, 0, 16)
 DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
 DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11..59ec51ddf3 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -306,24 +306,19 @@ void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
     int bank_index = ((cache_level - 1) * 2) | is_i_cache0;
     ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(0));
     bool ccidx = cpu_isar_feature(any_ccidx, armcpu);
+    uint64_t ccsidr = GET_IDREG_DEMUX(&armcpu->isar, CCSIDR_EL1, bank_index);
 
     if (ccidx) {
         *cpu_cache = (CPUCoreCaches){
-            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                         CCIDX_LINESIZE) + 4),
-            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                        CCIDX_ASSOCIATIVITY) + 1,
-            .sets = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                               CCIDX_NUMSETS) + 1,
+            .linesize = 1 << (FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_LINESIZE) + 4),
+            .associativity = FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_ASSOCIATIVITY) + 1,
+            .sets = FIELD_EX64(ccsidr, CCSIDR_EL1, CCIDX_NUMSETS) + 1,
         };
     } else {
         *cpu_cache = (CPUCoreCaches){
-            .linesize = 1 << (FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                         LINESIZE) + 4),
-            .associativity = FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1,
-                                        ASSOCIATIVITY) + 1,
-            .sets =
-                FIELD_EX64(armcpu->ccsidr[bank_index], CCSIDR_EL1, NUMSETS) + 1,
+            .linesize = 1 << (FIELD_EX64(ccsidr, CCSIDR_EL1, LINESIZE) + 4),
+            .associativity = FIELD_EX64(ccsidr, CCSIDR_EL1, ASSOCIATIVITY) + 1,
+            .sets = FIELD_EX64(ccsidr, CCSIDR_EL1, NUMSETS) + 1,
         };
     }
     cpu_cache->type = cache_type;
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index a7651f831e..5dd867242b 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1360,7 +1360,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
     case 0xd80: /* CSSIDR */
     {
         int idx = cpu->env.v7m.csselr[attrs.secure] & R_V7M_CSSELR_INDEX_MASK;
-        return cpu->ccsidr[idx];
+        return GET_IDREG_DEMUX(&cpu->isar, CCSIDR_EL1, idx);
     }
     case 0xd84: /* CSSELR */
         return cpu->env.v7m.csselr[attrs.secure];
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 739500a04f..2ed1cfef9b 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -71,11 +71,11 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 48KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
     /* 2048KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7));
     if (aarch64_enabled) {
         set_dczid_bs(cpu, 4); /* 64 bytes */
         cpu->gic_num_lrs = 4;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index c11ab2da21..dcd0d698b3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -749,11 +749,11 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x41033000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2));
     /* 1024KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
     set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c3f607e6d6..a608df1211 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -925,7 +925,7 @@ static uint64_t ccsidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     uint32_t index = A32_BANKED_REG_GET(env, csselr,
                                         ri->secure & ARM_CP_SECSTATE_S);
 
-    return cpu->ccsidr[index];
+    return GET_IDREG_DEMUX(&cpu->isar, CCSIDR_EL1, index);
 }
 
 static void csselr_write(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f292a269bf..7db35e1955 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -277,9 +277,9 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x15141000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (2 << 24) | 3);
-    cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
-    cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
-    cpu->ccsidr[2] = 0xf0000000; /* No L2 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0xe007e01a); /* 16k L1 dcache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x2007e01a); /* 16k L1 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0xf0000000); /* No L2 icache. */
     cpu->reset_auxcr = 2;
     cpu->isar.reset_pmcr_el0 = 0x41002000;
     define_arm_cp_regs(cpu, cortexa8_cp_reginfo);
@@ -355,8 +355,8 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x35141000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 3);
-    cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
-    cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0xe00fe019); /* 16k L1 dcache. */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x200fe019); /* 16k L1 icache. */
     cpu->isar.reset_pmcr_el0 = 0x41093000;
     define_arm_cp_regs(cpu, cortexa9_cp_reginfo);
 }
@@ -429,9 +429,9 @@ static void cortex_a7_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x1;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
-    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x701fe00a); /* 32K L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32K L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0x711fe07a); /* 4096K L2 unified cache */
     cpu->isar.reset_pmcr_el0 = 0x41072000;
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo); /* Same as A15 */
 }
@@ -478,9 +478,9 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x0;
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
-    cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x701fe00a); /* 32K L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32K L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, 0x711fe07a); /* 4096K L2 unified cache */
     cpu->isar.reset_pmcr_el0 = 0x410F3000;
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
 }
@@ -670,8 +670,8 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR5, 0x00010001);
     cpu->isar.dbgdidr = 0x77168000;
     SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 0x3);
-    cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
-    cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, 0x700fe01a); /* 32KB L1 dcache */
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, 0x201fe00a); /* 32KB L1 icache */
 
     cpu->pmsav7_dregion = 16;
     cpu->pmsav8r_hdregion = 16;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae..e156baf35d 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -83,11 +83,11 @@ static void aarch64_a35_initfn(Object *obj)
 
     /* From B2.29 Cache ID registers */
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
 
     /* From B3.5 VGIC Type register */
     cpu->gic_num_lrs = 4;
@@ -252,11 +252,11 @@ static void aarch64_a55_initfn(Object *obj)
 
     /* From B2.23 CCSIDR_EL1 */
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 32KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 512 * KiB, 7));
 
     /* From B2.96 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -323,11 +323,11 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.reset_pmcr_el0 = 0x41023000;
     SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7));
     /* 48KB L1 dcache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2));
     /* 1MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7));
     set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -387,11 +387,11 @@ static void aarch64_a76_initfn(Object *obj)
 
     /* From B2.18 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
 
     /* From B2.93 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -460,11 +460,11 @@ static void aarch64_a78ae_initfn(Object *obj)
 
     /* From 3.2.33 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 512KB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 512 * KiB, 7));
 
     /* From 3.2.118 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -518,11 +518,11 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
     SET_IDREG(isar, CLIDR, 0x0000000080000023);
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2));
     /* 8MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7));
     set_dczid_bs(cpu, 6); /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
@@ -711,11 +711,11 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
 
     /* From B2.23 CCSIDR_EL1 */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 1MB L2 dcache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7));
 
     /* From B2.98 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -800,11 +800,11 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* 1MB L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 1 * MiB, 0));
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
@@ -1043,11 +1043,11 @@ static void aarch64_a710_initfn(Object *obj)
      * L2: 8-way set associative 64 byte line size, total either 256K or 512K.
      */
     /* L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
 
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
@@ -1146,11 +1146,11 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
      * L2: 8-way set associative 64 byte line size, total either 512K or 1024K.
      */
     /* L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L1 icache */
-    cpu->ccsidr[1] = cpu->ccsidr[0];
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_CCIDX, 4, 64, 64 * KiB, 0));
     /* L2 cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_CCIDX, 8, 64, 512 * KiB, 0));
     /* FIXME: Not documented -- copied from neoverse-v1 */
     cpu->reset_sctlr = 0x30c50838;
 
@@ -1180,13 +1180,13 @@ void aarch64_max_v8_tcg_initfn(Object *obj)
 
     SET_IDREG(isar, CLIDR, 0x8200123);
     /* 64KB L1 dcache */
-    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 0, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7));
     /* 64KB L1 icache */
-    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 1, make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2));
     /* 1MB L2 unified cache */
-    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 2, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7));
     /* 2MB L3 unified cache */
-    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
+    SET_IDREG_DEMUX(isar, CCSIDR_EL1, 4, make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7));
 
     /*
      * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
-- 
2.55.0


