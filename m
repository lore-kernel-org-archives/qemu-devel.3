Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F2EFC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziR9-0001wg-Eu; Thu, 27 Aug 2026 18:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR7-0001l1-Oy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziR4-00072q-Oh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:19:05 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJMJtE1118121
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ULhWTpVVu3o
 UQdoawtTWecfZY3q2+DDyBvmTtg9KbOg=; b=amQQwqf++pcjJUv6skMQoBrV/3C
 1pUjuBW8z5pRUwnQLMScxjCyz1VYXfPM20r4mtqPwiNsBSN+wTgbnFCgHJl+Uoo2
 aLugHJOd0D0WDV8fqN0qP+69sJiE5UyHL1haZchbDHVXgDcfEHmnHiZN9bqIIJ4v
 +ApAwe/p/79DYf8bdvRaoB9Js8tHm//bnUcE0hfoXRoxpqvfSp/nUWj7ivH6TPr6
 z77qoZDe8N6SwUPz5FicDLd2KJD7crEeXcFiSsA0yzDjyIDQZl4CZuONIcRB4u7G
 ch9bGtwCpIRDqXHuoLuusvRHGTQIm8PbkkXUp4LCbCot4vIXN4hvS3A5NgQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0hfuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:19:01 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so921259a91.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869140; x=1788473940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ULhWTpVVu3oUQdoawtTWecfZY3q2+DDyBvmTtg9KbOg=;
 b=TsAdSH+dwkILSBPd/v/TNEi5ldg+ipU0SYscHeO310tqKpjxo2bICSU0tXZZaMMKTL
 c/wzy75LDoej9ZW8buRKyW3q5/iUujPdMOJrmnqeUk82pv4U3XBtp/VGDCxRLyff9Fko
 vkgsXf4pZqo07uH4HngnC7SWY3B7+h6YRE8NeuXP0RXKnWjBkVnz+RAIC92V8nN5lKnM
 SpBjkQIKVJY2vTind0k/rjee8a+oxElKj/qwO27DG3cVDIQWA5KOvp4ut14FZYKNox1U
 oqev3GV9n9GJ6uXzyhcZFojWUHvIhlbdbv1eVJbx9yYjZh6LnD4I37/9lTPaRmYbFiLL
 jbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869140; x=1788473940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ULhWTpVVu3oUQdoawtTWecfZY3q2+DDyBvmTtg9KbOg=;
 b=cRl/CognYtTfIqVeiik6pjvkAzYmzrJ24e22Oa94JPQPqGZbI1hZHQ8dtxHaxZs74I
 +y+RmttTMQU+eCxFM437qwrFHD9m9fWrW5HXZWl/Qo/g9CLn6MHyO3B9pzoLGJZz/IvS
 F35ZF1sFsov9DHYl6abwMtFDzmonpsjttoz165wE67ydUp3RUIKrbbvwu+8ItxOQ4+r/
 8MiBszBQfAY1ksk8QC1EDw3NdQ6MTbjLxx7YAfDfJ3R+ifKI7AecVKOUuqRL7vfLFSOg
 IDr8lZ1LFdDKmzrC8vMUm7aN/FpMBYc/R20ZMzst/AnERHrpOp9pSQCu0IVu1DbW0u7F
 JA6Q==
X-Gm-Message-State: AFuF++lpCyxvFzc6FFsU1kZCFyYjfApGwJSQlIu0qFgMA5myqRVtg2ba
 b0NsC1js73WFyFPJ5KtABKVAy/edwVPb/npGxdKoBDjJZKHRc2YyN1pcy0zl6PRCtoc9y348RD3
 NzJoLMPtkmeFspzQ1p/KhzoiebDAtaacBiPPeApMDhjwCfhSx/aLT6o+IRPLqDHTAEw==
X-Gm-Gg: AR+sD12HDjlrOyv73e/rj+P4VG4rElux1s7wWTtP2XbCvwCd8drWpqLWQCV5EA+qggU
 N5Y274fyiMZLkCpQncTwU7lyCtSDDIKA5RuhGB8MdfkdeBcSt3Vs9WSgmOZCJGQW39HyEkmjPwI
 IzZFue4TdN70FrCQSY80Xn3cO4+c9UYfYAnDwln07Hk2VIKyQg2xBefDfoGO4byJsL0Q57SNIE1
 6UTyg/E+M7dM2Eg3H3HDbJ6Dh4Ppq3urWpcZOsnzEmXnUgp1eYrL4ojaSXatHpLXSs/vU39LlZY
 3t2V+IrE9FnSd/GwzR08X//rPFj1iM2JXil92Xf7QdHV7Zq41JcASVKpPICyp9wDLMURxMdTG+E
 DUy7MZc6CW7pzm3g9XNHZJX8hE8O5FnTkvNHXKeQuV9/ObkCgK6XgPWKj6k8=
X-Received: by 2002:a17:90b:384d:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-396d0ec6bc1mr3520138a91.7.1787869140170; 
 Thu, 27 Aug 2026 15:19:00 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:38e:bbf1:de34 with SMTP id
 98e67ed59e1d1-396d0ec6bc1mr3520044a91.7.1787869139595; 
 Thu, 27 Aug 2026 15:18:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:18:59 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 040/105] tests/tcg/aarch64: user tests
Date: Thu, 27 Aug 2026 22:14:01 +0000
Message-ID: <20260827221506.91574-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX6K5lf0wi5zpj
 w7AYCWDTXjyPQOMUfiOloilZ4/NmbjNsUAcS2iuPLEx9SumDmdlDsYyRIFcHbmgw8g9XEn/oEnI
 nuQf7iGyfHfeK1Q1S4uiS5pRGktHL3gt7mm6m+D9aH1GK7pXW/S5nd/lw9hbBXOEVKizRS9CQI8
 XDPBiOkiqK+eqElFSlh+zopRNhbrmP+y6oFkxJa7IY7S8g5y3gjdJDE3nFSK8u8TNiUIpJc1MEh
 1M1OtFL8t8fpd/tgYHzmHh9CT9fwCsYXv6XBKnZmOCushSmeEkgRImypEVlPBFqIcWHEbNT8N8O
 nPcyrWHpmIJ0JAZXmdaC7mfcvmvU43mYSeUSLE0NdpsDCpYyBQFzPdaB4zoCYr9CK2qeIO5jcZE
 nlHbNvQYtLc7dgUUV/EfrD9IogBc3EzFsyhNaRcB7OkJ//+fpcbWMTSAF4eENrr0yCdkvI0KzAk
 Ddcpv6sqJcrTQqtVWsw==
X-Proofpoint-GUID: fw_rJCLjaKEqNq01Wrl2lN2uNaWvI75O
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a90b7d5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=Em0P4F6pParytpyspAEA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: fw_rJCLjaKEqNq01Wrl2lN2uNaWvI75O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfXwjpRjoDE1LDi
 DV8fzA0vzcRL1y0m0YmINJFrppUEEEZH8BOHOUIh5jFoBmuSP5ELSFlgI2/6S+mjoHhaNQpwzai
 ZdatPCRhiOvWg6hkCAMfqr8pq78b97E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/Makefile.target | 211 ------------------------------
 tests/tcg/aarch64/meson.build     | 208 +++++++++++++++++++++++++++++
 tests/tcg/meson.build             |   3 +
 3 files changed, 211 insertions(+), 211 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.target
 create mode 100644 tests/tcg/aarch64/meson.build

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
deleted file mode 100644
index 6cc81bf854f..00000000000
--- a/tests/tcg/aarch64/Makefile.target
+++ /dev/null
@@ -1,211 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# AArch64 specific tweaks
-
-ARM_SRC=$(SRC_PATH)/tests/tcg/arm
-VPATH 		+= $(ARM_SRC)
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-VPATH 		+= $(AARCH64_SRC)
-
-# Base architecture tests
-AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
-AARCH64_TESTS += test-2248 test-2150
-
-fcvt: LDFLAGS+=-lm
-
-run-fcvt: fcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    fnia=`$(call cc-test,-fno-integrated-as) && echo -fno-integrated-as`; \
-	    $(call cc-option,-march=armv8.1-a+sve,          CROSS_CC_HAS_SVE); \
-	    $(call cc-option,-march=armv8.1-a+sve2,         CROSS_CC_HAS_SVE2); \
-	    $(call cc-option,-march=armv8.2-a,              CROSS_CC_HAS_ARMV8_2); \
-	    $(call cc-option,-march=armv8.3-a,              CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
-	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
-	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
-	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
--include config-cc.mak
-
-ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
-AARCH64_TESTS += fcvt-fprcvt
-fcvt-fprcvt: LDFLAGS += -lm
-fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
-fcvt-fprcvt: fcvt.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-fcvt-fprcvt: fcvt-fprcvt
-	$(call run-test,$<,$(QEMU) $<)
-	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_2),)
-AARCH64_TESTS += dcpop
-dcpop: CFLAGS += $(CROSS_CC_HAS_ARMV8_2)
-endif
-ifneq ($(CROSS_CC_HAS_ARMV8_5),)
-AARCH64_TESTS += dcpodp
-dcpodp: CFLAGS += $(CROSS_CC_HAS_ARMV8_5)
-endif
-
-# Pauth Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5 test-2375
-pauth-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-test-2375: CFLAGS += -march=armv8.3-a
-run-pauth-1: QEMU_OPTS += -cpu max
-run-pauth-2: QEMU_OPTS += -cpu max
-# Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
-run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
-run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
-endif
-
-# BTI Tests
-# bti-1 tests the elf notes, so we require special compiler support.
-ifneq ($(CROSS_CC_HAS_ARMV8_BTI),)
-AARCH64_TESTS += bti-1 bti-3
-bti-1 bti-3: CFLAGS += -fno-stack-protector $(CROSS_CC_HAS_ARMV8_BTI)
-bti-1 bti-3: LDFLAGS += -nostdlib
-endif
-# bti-2 tests PROT_BTI, so no special compiler support required.
-AARCH64_TESTS += bti-2
-
-# MTE Tests
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7 mte-8 mte-9 mte-10
-mte-%: CFLAGS += $(CROSS_CC_HAS_ARMV8_MTE)
-endif
-
-# SME Tests
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-SME_TESTS = sme-outprod1 sme-smopa-1 sme-smopa-2 sme-fmopa-1 sme-fmopa-2 sme-fmopa-3
-AARCH64_TESTS += $(SME_TESTS)
-$(SME_TESTS): CFLAGS += $(CROSS_AS_HAS_ARMV9_SME)
-endif
-
-# GCS Tests
-GCS_TESTS += gcsstr gcspushm gcsss
-AARCH64_TESTS += $(GCS_TESTS)
-$(GCS_TESTS): gcs.h
-
-# System Registers Tests
-AARCH64_TESTS += sysregs
-
-AARCH64_TESTS += test-aes
-test-aes: CFLAGS += -O -march=armv8-a+aes
-test-aes: test-aes-main.c.inc
-
-# Vector SHA1
-# Work around compiler false-positive warning, as we do for the 'sha1' test
-sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
-sha1-vector: sha1.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-run-sha1-vector: sha1-vector run-sha1
-	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<)
-	$(call diff-out, sha1-vector, sha1.out)
-
-TESTS += sha1-vector
-
-# Vector versions of sha512 (-O3 triggers vectorisation)
-sha512-vector: CFLAGS=-O3
-sha512-vector: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-vector
-
-ifneq ($(CROSS_CC_HAS_SVE),)
-# SVE ioctl test
-AARCH64_TESTS += sve-ioctls
-sve-ioctls: CFLAGS += $(CROSS_CC_HAS_SVE)
-
-sha512-sve: CFLAGS=-O3 -march=armv8.1-a+sve
-sha512-sve: sha512.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-sve-str: CFLAGS=-O1 -march=armv8.1-a+sve
-sve-str: sve-str.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-TESTS += sha512-sve sve-str
-
-ifneq ($(GDB),)
-GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
-
-run-gdbstub-sysregs: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
-	basic gdbstub SVE support)
-
-run-gdbstub-sve-ioctls: sve-ioctls
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve-ioctl.py, \
-	basic gdbstub SVE ZLEN support)
-
-EXTRA_RUNS += run-gdbstub-sysregs run-gdbstub-sve-ioctls
-
-ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
-# SME gdbstub tests
-
-run-gdbstub-sysregs-sme: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_basic_za_test, \
-	basic gdbstub SME support)
-
-ifeq ($(GDB_HAS_SME_TILES),y)
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme.py \
-		-- test_sme --gdb_tile_slice_test, \
-	gdbstub SME ZA tile slice support)
-else
-run-gdbstub-sysregs-sme-tile-slice: sysregs
-	$(call skip-test,"gdbstub SME ZA tile slice support", \
-	"selected gdb ($(GDB)) does not support SME ZA tile slices")
-endif
-
-run-gdbstub-sysregs-sme2: sysregs
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-sme2.py, \
-	gdbstub SME ZA tile slice support)
-
-EXTRA_RUNS += run-gdbstub-sysregs-sme run-gdbstub-sysregs-sme-tile-slice run-gdbstub-sysregs-sme2
-
-endif
-
-ifeq ($(GDB_HAS_MTE),y)
-run-gdbstub-mte: mte-8
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
-		-- --mode=user, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-endif
-
-endif
-endif
-
-ifneq ($(CROSS_CC_HAS_SVE2),)
-SVE2_TESTS = test-826 sve-while-ptr
-$(SVE2_TESTS): CFLAGS += $(CROSS_CC_HAS_SVE2)
-AARCH64_TESTS += $(SVE2_TESTS)
-endif
-
-TESTS += $(AARCH64_TESTS)
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..9ec8df169d5
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,208 @@
+cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'aes': '-march=armv8-a+aes',
+  'sve': '-march=armv8.1-a+sve',
+  'sve2': '-march=armv8.1-a+sve2',
+  'v8.2': '-march=armv8.2-a',
+  'v8.3': '-march=armv8.3-a',
+  'v8.5': '-march=armv8.5-a',
+  'bti':  '-mbranch-protection=standard',
+  'mte':  '-march=armv8.5-a+memtag',
+  'sme':  '-Wa,-march=armv9-a+sme',
+  'fprcvt': '-march=armv9-a+fprcvt',
+}
+
+gdb_feat_version = {
+  'sme-tiles': '14.1',
+  'mte': '15.1',
+  'mte-baremetal': '16.0',
+}
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+# Base architecture tests
+tests += {
+  '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
+  'pcalign-a64.c': {},
+  'lse2-fault.c': {},
+  'test-2248.c': {},
+  'test-2150.c': {},
+}
+
+tests += {'dcpop.c': {'cc_feat': 'v8.2'}}
+tests += {'dcpodp.c': {'cc_feat': 'v8.5'}}
+
+# Pauth Tests
+cpu_max = ['-cpu', 'max']
+cpu_neoverse = ['-cpu', 'neoverse-v1']
+tests += {
+  'test-2375.c': {'cc_feat': 'v8.3'},
+  'pauth-1.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  'pauth-2.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+  'pauth-4.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+  'pauth-5.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+}
+
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+f = ['-fno-stack-protector', '-nostdlib']
+tests += {
+  'bti-1.c': {'cc_feat': 'bti', 'cflags': f},
+  'bti-3.c': {'cc_feat': 'bti', 'cflags': f},
+}
+# bti-2 tests PROT_BTI, so no special compiler support required.
+tests += {'bti-2.c': {}}
+
+# MTE Tests
+tests += {
+  'mte-1.c': {'cc_feat': 'mte'},
+  'mte-2.c': {'cc_feat': 'mte'},
+  'mte-3.c': {'cc_feat': 'mte'},
+  'mte-4.c': {'cc_feat': 'mte'},
+  'mte-5.c': {'cc_feat': 'mte'},
+  'mte-6.c': {'cc_feat': 'mte'},
+  'mte-7.c': {'cc_feat': 'mte'},
+  'mte-8.c': {'cc_feat': 'mte'},
+  'mte-9.c': {'cc_feat': 'mte'},
+  'mte-10.c': {'cc_feat': 'mte'},
+}
+tests += {
+  'mte-8.c': {
+    'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    'gdb_feat': 'mte',
+  }
+}
+
+# SME Tests
+tests += {
+  'sme-outprod1.c': {'cc_feat': 'sme'},
+  'sme-smopa-1.c': {'cc_feat': 'sme'},
+  'sme-smopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-1.c': {'cc_feat': 'sme'},
+  'sme-fmopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-3.c': {'cc_feat': 'sme'},
+}
+sysregs_sme = 'sysregs-sme'
+tests += {
+  'sysregs.c': {
+    'exe_name': sysregs_sme,
+    'cc_feat': 'sme',
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_basic_za_test'],
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme-tile-slice',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_tile_slice_test'],
+    'gdb_feat': 'sme-tiles',
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme2',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+  }
+}
+
+# GCS Tests
+tests += {
+  'gcsstr.c': {},
+  'gcspushm.c': {},
+  'gcsss.c': {},
+}
+
+# System Registers Tests
+tests += {'sysregs.c': {}}
+
+# Crypto Tests
+tests += {'test-aes.c': {'cc_feat': 'aes'}}
+
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
+# SVE Tests
+tests += {
+  'sve-ioctls.c': {'cc_feat': 'sve'},
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sve',
+     'cc_feat': 'sve',
+  },
+  'sve-str.c': {'cc_feat': 'sve', 'cflags': ['-O1']},
+}
+tests += {
+  'sysregs.c': {
+    'exe_name': 'sysregs-sve',
+    'cc_feat': 'sve',
+    'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+  },
+  'sve-ioctls.c': {
+    'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+  },
+}
+
+# SVE2 Tests
+tests += {
+  'test-826.c': {'cc_feat': 'sve2'},
+  'sve-while-ptr.c': {'cc_feat': 'sve2'},
+}
+
+# FPRCVT test
+tests += {
+  '../arm/fcvt.c': {
+    'exe_name': 'fcvt-fprcvt',
+    'cflags': ['-DFPRCVT', '-lm'],
+    # fprcvt is available only from gcc-16.
+    # Use raw opcode until it's available in cross container.
+    # 'cc_feat': 'fprcvt',
+    'expected_output': 'fcvt.ref'},
+}
+
+# Semihosting tests
+# Add -I path for semicall.h
+semihosting_cflags = ['-I', meson.current_source_dir()]
+
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
+if 'qemu-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 16292d4d7b0..76d7dbe045b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
   tcg_tests += {target: {'tests': tests + plugin_tests}}
 endforeach
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.43.0


