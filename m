Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10006C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjA-0000ca-HK; Tue, 28 Jul 2026 00:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZj1-0000Al-VZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZiy-00023F-UG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:31 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46RXC1821155
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R3XYQ9TpuC9
 NThnu+gP11VUXdBuMiJAcEOXCNliMRWs=; b=ZuJquWn8DXClUUw8HYxOXKX9EMx
 hXH3PtL05wl67GksKHAtwsQG5GBG9v+OIdFPVXaJPcGsSRexndsRi5VGJJHST9fb
 jxk0W4lvbK496QJRpneylsPf0o4oGms2VgLUVXE1ZoRXpf9Z5lZQ2AssDQbS1awf
 6W1F8cHgubw8SXfMF4hcGCVVDjcvfOZmJ2Y/merZXnKZTVEHT5leMLv8ZN3yb6q0
 YuRBZxURJYYt6xZH76MH3g6Aj7R0dqKDrBvkTWwzXmTUwCJFuPOjXRwkz5gVoezU
 eqk7T/aJmkMTuqOsGxhCICwcz712oPJFvwQKgLXt1x33XSU8tgS9yrwc2jQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y03tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so530543a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214047; x=1785818847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R3XYQ9TpuC9NThnu+gP11VUXdBuMiJAcEOXCNliMRWs=;
 b=DLthrQAHWh+0oWfWTS7YMvnOJhhEa7Hi/n4gkfcHTEjj/Ur2rg1M9R1rAhf0BZlN/w
 aphh3wWBdw6c3JQO7vajSV8IfezyrtyFcdRRCI1/7KAEfSfJW5XFSo6rNhVVGyO772Bq
 hFMWrk6enDrzRUoJBDLaYtq9ucrGHGH+RN5LNb2vafwgXxEGFyknraTSiiy+hkojSfGe
 pH3jbKOm0mOVbjFLHAbpYuf1eeCYnzvykh22rm8Oz89yijEBhGTzkw1l6y32SMz6WN6Z
 JJYKsTgOepFnfRmt26BUjd6fAENx68DhAhw44cb4FpUwrI/6md2lKz+NkY3EP+n+Ki0x
 7q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214047; x=1785818847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R3XYQ9TpuC9NThnu+gP11VUXdBuMiJAcEOXCNliMRWs=;
 b=Qt/OZi41wonqMNodTrfuoTeC7wjMigkxBW4SMFCBYid91RzsnC2/xJTp/YhCHQtIgy
 OlA6YjiN/NNjuYmrSjsJESyb5J/+sx3HYHraYFjeK+ovCg1naUGVsMi9fy8DUhOcN3jW
 1VR76fGK7+nlvYozO3lpgOB9RpG9hWbpgMq88GqOwZ9s12LOyY9aMZPHfyXAtaYu8Y9o
 A+NlKhGdV6yktDxcKIkdPtqJnCri/8sbx5QddvQEuJqqCLDWC5f8/upVLTbxZ5FZZqgV
 pbj7hsAOGFUaxqTURxNLSfYzaXZ2Gw+yDzzX3xVt6u0RIXKnuMeLtDDzS++MtKMeTvAi
 tNHw==
X-Gm-Message-State: AOJu0YzAlytDvmGWnSypt9eTjHYQd3Duep1Y1zx0/EJbV/NNAEnt9Mr7
 +dQdDWMNmNKK/pz25MaKeZbbGPa0cmvppQJ86fNro+mePbbCKFvuIT9dgxag1KGS3UkBmR9WQ+Q
 lzIjgOH6bCDAezSV8stLe6lixLUrpPW+uOV5qrHnYoYxL1E6Wa3QTA8Q63hua8B6ucw==
X-Gm-Gg: AR+sD10DqxlKXRTI7Itc/yLUasGhq5+HV1YlWCaUUgTuej1JSfUf9jjwlOk7yhzPRU1
 +vB4pdclz1k6mGSoyLhVvpmlalRFTxf6H4kI4zcDIiRYN+OGQFljcIEQYIY4goA03kVAhDuuROF
 COet5J4xL69y0NAE2EDkfuxhG5A1atxTn77UVXK8nsh8zRTzWIzWsdxL9ndr2AeCVnvtIG3eD7j
 o1HKnwTvXg9CfYUPLb6A13nlRB3kls5OC4KawyMKQSM2pTG13P8JmUyDibwzIwQ/893gbqcVXYF
 BQFJA1M2Y6Cg29yXSvq2TIyf91yXRFwz2bxaiy3H9lgUY90GfcJbUX6c+1lfzvrFZ/t1WEhyPHu
 GqLSjzQyutlb6iupVxdn6GAaLWVkZcYBzQ7/oWrj6NWBsdx3tkV8CfBEoPNpDijd8SvWHPB0=
X-Received: by 2002:a05:6a20:431f:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c8ba6897d5mr1112317637.35.1785214046709; 
 Mon, 27 Jul 2026 21:47:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:431f:b0:398:76d4:c7e9 with SMTP id
 adf61e73a8af0-3c8ba6897d5mr1112274637.35.1785214046208; 
 Mon, 27 Jul 2026 21:47:26 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 041/103] tests/tcg/aarch64: system tests
Date: Mon, 27 Jul 2026 21:41:45 -0700
Message-ID: <20260728044248.137626-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68345f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=lKJin8fYq-Jz0iZqabkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX1GJWAKTP9D/S
 vR3h+4wv82iL/rzlUW566qA0A99dhzlYdO8uwPzqD3CZMwwVC/jWYiW85qhBb+/BNltk6AObaDm
 e+iS5szDaxbvtDnmHhAqedw0Ppp9uxo=
X-Proofpoint-ORIG-GUID: pPkp4rPrnGZfrH3ESRAKRUZEiCVsaVNw
X-Proofpoint-GUID: pPkp4rPrnGZfrH3ESRAKRUZEiCVsaVNw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX4si4GHb6CdbB
 KGgs2xndrRutSkfz5/Z3OHrOwP1O46ZTXrkcdKf7mEMMx2FBlPE45o5PNQfdXOHITnl1UG19+K3
 LV8USSGg3t/pzq8KacupsXT+nz0PiB/az6It8Vg6C2IpCcO+Ggku8BW23GbFm1IapbQu/u0qJBQ
 gTr9di3GMgZMkLvnIURlMOsPzLmUqCK16gTNM6iPLzXwpp7vTH8k3jjiiRMbSaV17OBvx/+TENC
 6vmFcs/wQsohuSTlrHmabt94tqLoxEKRE51jpgVHiOWNCW/TOpFC7ahnLDlMleboWhrVXxit1hz
 iVd2W2T3w7EPtXp03j8Ngl31ElVwWzXEF92bk4+eg89k36ITk8xF82vgue0y9SEOnEFsiosnSap
 4DUHBeqRYFvGnq9u1VKeicXAUDKWv0sUDuvSQqygNJ+SX0995dUqSTESY1I5duT+JKtRGiY+bOC
 B2ESCWjZEl6IGHgE45w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280041
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 147 ----------------------
 tests/tcg/aarch64/meson.build             |   2 +
 tests/tcg/aarch64/system/meson.build      | 108 ++++++++++++++++
 3 files changed, 110 insertions(+), 147 deletions(-)
 delete mode 100644 tests/tcg/aarch64/Makefile.softmmu-target
 create mode 100644 tests/tcg/aarch64/system/meson.build

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
deleted file mode 100644
index 3f30be6c5d6..00000000000
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ /dev/null
@@ -1,147 +0,0 @@
-#
-# Aarch64 system tests
-#
-
-AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
-AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
-
-VPATH+=$(AARCH64_SYSTEM_SRC)
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-AARCH64_TEST_C_SRCS=$(wildcard $(AARCH64_SYSTEM_SRC)/*.c)
-AARCH64_TEST_S_SRCS=$(AARCH64_SYSTEM_SRC)/mte.S
-
-AARCH64_C_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.c, %, $(AARCH64_TEST_C_SRCS))
-AARCH64_S_TESTS = $(patsubst $(AARCH64_SYSTEM_SRC)/%.S, %, $(AARCH64_TEST_S_SRCS))
-
-AARCH64_TESTS = $(AARCH64_C_TESTS)
-AARCH64_TESTS += $(AARCH64_S_TESTS)
-
-CRT_PATH=$(AARCH64_SYSTEM_SRC)
-LINK_SCRIPT=$(AARCH64_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT)
-TESTS+=$(AARCH64_TESTS) $(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(MINILIB_OBJS) -lgcc
-
-config-cc.mak: Makefile
-	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
-	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
--include config-cc.mak
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-vector_log_boot.o: $(CRT_PATH)/boot.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -DLOGGING_VECTOR_TABLE -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -x assembler-with-cpp -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
-
-gpc-test: gpc-test.c $(LINK_SCRIPT) vector_log_boot.o $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) vector_log_boot.o
-
-TESTS+=memory-sve gpc-test
-
-# Running
-QEMU_BASE_MACHINE=-M virt -cpu max -display none
-QEMU_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output
-QEMU_OPTS+=$(QEMU_BASE_MACHINE) $(QEMU_BASE_ARGS) -kernel
-
-# console test is manual only
-QEMU_SEMIHOST=-serial none -chardev stdio,mux=on,id=stdio0 -semihosting-config enable=on,chardev=stdio0 -mon chardev=stdio0,mode=readline
-run-semiconsole: QEMU_OPTS=$(QEMU_BASE_MACHINE) $(QEMU_SEMIHOST) -kernel
-run-semiconsole: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-	$(if $(V),@printf "  %-7s %s %s\n" "TO RUN" $(notdir $(QEMU)) "$(QEMU_OPTS) $<")
-run-plugin-semiconsole-with-%: semiconsole
-	$(call skip-test, $<, "MANUAL ONLY")
-
-# vtimer test needs EL2
-QEMU_EL2_MACHINE=-machine virt,virtualization=on,gic-version=2 -cpu cortex-a57 -smp 4
-QEMU_EL2_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="2"
-run-vtimer: QEMU_OPTS=$(QEMU_EL2_MACHINE) $(QEMU_EL2_BASE_ARGS) -kernel
-
-# gpc tests need EL3 and RME
-QEMU_EL3_MACHINE=-machine virt,virtualization=on,secure=on,gic-version=3 -cpu max,x-rme=on
-QEMU_EL3_BASE_ARGS=-semihosting-config enable=on,target=native,chardev=output,arg="3"
-run-gpc-test:  QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-run-gpc3-test: QEMU_OPTS=$(QEMU_EL3_MACHINE) $(QEMU_EL3_BASE_ARGS) -kernel
-
-# Simple Record/Replay Test
-.PHONY: memory-record
-run-memory-record: memory-record memory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-.PHONY: memory-replay
-run-memory-replay: memory-replay run-memory-record
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
-		  $(QEMU_OPTS) memory)
-
-EXTRA_RUNS+=run-memory-replay
-
-ifneq ($(CROSS_CC_HAS_ARMV8_3),)
-pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
-# This test explicitly checks the output of the pauth operation so we
-# must force the use of the QARMA5 algorithm for it.
-run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
-else
-pauth-3:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-pauth-3:
-	$(call skip-test, "RUN of pauth-3", "not built")
-endif
-
-ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
-QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
-QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
-mte: CFLAGS+=-march=armv8.5-a+memtag
-mte: mte.S $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) boot.o
-
-run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-mte: mte
-
-ifeq ($(GDB_SUPPORTS_MTE_IN_BAREMETAL),y)
-run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
-run-gdbstub-mte: mte
-	$(call run-test, $@, $(GDB_SCRIPT) \
-		--output run-gdbstub-mte.out \
-		--gdb $(GDB) \
-		--qemu $(QEMU) --qargs "-chardev null$(COMMA)id=output $(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py -- --mode=system, \
-	gdbstub MTE support)
-
-EXTRA_RUNS += run-gdbstub-mte
-else # !GDB_SUPPORTS_MTE_IN_BAREMETAL
-run-gdbstub-mte:
-	$(call skip-test "RUN of gdbstub-mte", "GDB does not support MTE in baremetal!")
-endif
-else # !CROSS_CC_HAS_ARMV8_MTE
-mte:
-	$(call skip-test, "BUILD of $@", "missing compiler support")
-run-mte:
-	$(call skip-test, "RUN of mte", "not build")
-endif
diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index 959d1cf698f..7301d004606 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -21,6 +21,8 @@ gdb_feat_version = {
   'mte-baremetal': '16.0',
 }
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
new file mode 100644
index 00000000000..9c31694fbac
--- /dev/null
+++ b/tests/tcg/aarch64/system/meson.build
@@ -0,0 +1,108 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script]
+qemu_base_args = ['-display', 'none',
+                  '-semihosting-config', 'enable=on',
+                  '-kernel']
+qemu_def_args = ['-M', 'virt', '-cpu', 'max', qemu_base_args]
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+tests += {
+  '../../multiarch/system/memory.c': {
+    'exe_name': 'memory-sve',
+    'cc_feat': 'sve',
+    'cflags': [cflags, '-DCHECK_UNALIGNED=1', '-O3'],
+    'qemu_args': qemu_def_args,
+  },
+}
+
+tests += {
+  'asid2.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'feat-xs.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'gpc-test.c': {
+    'cflags': [cflags, '-DLOGGING_VECTOR_TABLE',
+               '-Wno-main', '-Wno-unused-but-set-variable'],
+    'qemu_args': ['-M', 'virt,secure=on,virtualization=on,gic-version=3',
+                  '-cpu', 'max,x-rme=on',
+                  '-semihosting-config', 'enable=on,arg=3',
+                  qemu_base_args],
+  },
+  'rme_gdi.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiheap.c': {'cflags': cflags, 'qemu_args': qemu_def_args},
+  'semiconsole.c': {
+    'cflags': cflags,
+    'qemu_args': ['-serial', 'none', '-chardev', 'stdio,mux=on,id=stdio0',
+                  '-semihosting-config', 'enable=on,chardev=stdio0',
+                  '-mon', 'chardev=stdio0,mode=readline',
+                  qemu_def_args],
+    'wrapper': [prog_run_with_input, 'X']
+  },
+  '../../multiarch/system/memory.c': {
+    'test_name': 'memory-record-replay',
+    'qemu_args': qemu_def_args,
+    'wrapper': [prog_record_replay],
+  },
+  'vtimer.c': {
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,virtualization=on,gic-version=2',
+                  '-cpu', 'cortex-a57', '-smp', '4',
+                  '-semihosting-config', 'enable=on,arg=2',
+                  qemu_base_args]
+  },
+}
+
+tests += {
+  'pauth-3.c': {
+    'cc_feat': 'v8.3',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt', '-cpu', 'max,pauth-qarma5=on', qemu_base_args],
+  }
+}
+
+tests += {
+  'mte.S': {
+    'cc_feat': 'mte',
+    'cflags': cflags,
+    'qemu_args': ['-M', 'virt,mte=on', '-cpu', 'max', qemu_base_args],
+    'gdb_test': ['--test', files('../gdbstub/test-mte.py'), '--', '--mode=system'],
+    'gdb_feat': 'mte-baremetal',
+  }
+}
+
+if 'qemu-system-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64/system',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-system-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


