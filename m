Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78A3C88E72
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1J-00066M-Qp; Mon, 14 Sep 2026 20:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H1B-00062L-8v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H19-000135-Fj
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN0ANf1272914
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rWcRg0KX+wt
 ewjZxJdgqp2eBhLZztknRh49JUnI1SrY=; b=EK3gGFG/IE6HeWA65JLzBQLpha2
 AqmRdq/FmDPRUKgzgv2+Pniq5XRbrZ3bPArAvTzq+5klhtrPbQGsfVjnAxiWuSBt
 8ydd25ZwthmbYsv1zU+5UsgpUIVsMMZQsBV9XK72BLlwRntpd+4isVxuyJ4gn2d8
 hUBlR8xa2pksQxwyRiLT5V1qLBv9ZrpY7foEoUxL0xV1tA+8x4XL1ufHJK3XcC17
 RhYBUAgPzLClGf9ZCLpR+HMiZNSjkOuMsUcfw5Cc7sIT71UgTdDDf8UW/Fsbp4dc
 MClCe0G5at55E9TDGjtlL/1cC2UNSuW04fGCCwIrDtDiLoGsXedytAQ7ZDA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f3mwh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:22 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-396b9ef3070so6963319a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432041; x=1790036841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWcRg0KX+wtewjZxJdgqp2eBhLZztknRh49JUnI1SrY=;
 b=itMPwpycvkNiB40PBWnEqv5tB7B3gsoKSP+sDglH1lOVz9bfxnvYqR+fr1Wybh3C5Q
 9kcj4iU7QVr+7AW0AIZ/tiqkd2TBvYCZJtFvywF8qXRyNS4R4Cd9G5XO/qVbmXCkhnBo
 UjvWEBexClY642wrf3OsIeJ0QJDBfHNhrHzJ+3wWZWKrHysLU8Gc8b/juwkrOkcntyLQ
 EHT2xVDKNiUIhB/wQdbEvpHzh2IDo84emBuSVLxKhNFDeUTwEPluDoe43P+uxAuV+7vL
 RzkJ70f5oJnc99RRzHyvJ0LU5xFmh7ABiF7hD6L2QmdWJdWqR/oCDpcR+2Yu1HQh6uaG
 MbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432041; x=1790036841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWcRg0KX+wtewjZxJdgqp2eBhLZztknRh49JUnI1SrY=;
 b=QroVX629/bP05NOTLcwg5+f1kd/Z2bWkXSxqlbTdwtsjpMrYRbonHs9nbdQbTXrEgN
 nZ27hSbaIg2PNlRrPV4MraygliHixmJsx8e7xiCsc51L4MX9eVyZdiolhmCwwmisLnbI
 AJoZrJn9h3tRd3cS+/jCarAXYOf8rmIrSAhQKa//IjP8HTjoGh117ZNYJiRMlKOjUoNk
 GHB4KtyiKQzc7n9I9VLPp2WL0jJNR4UyNDdZHNb9Ia7oPxPABkbvQGaysmxJ40RoJ/Tj
 2OhrDgf0vV+qqJkBXlBu2aySXkwV+ebMgp9fR991AK3Vjq2j30yh+vsWs7b/TpyRwNRf
 nLdw==
X-Gm-Message-State: AFuF++kUOsaiIhnolWstwix8Yc2SHlcf7Qt1+yVjloV5zwauGX66ywL1
 JhjbsI+y6C9cMJrR4+KmBivLZ3svMedkvzsirNLvPDZ95k6pcmAVnJHQLc+RTTlCNkMDYuJZFhe
 u6svvTnXAHP4VjD7ffCTDuSfskSfZrc2k90wcALLhvwCmk6lN+54sRqtE4i/T4hyNwA==
X-Gm-Gg: AYBFou1pj5zdYWKHnwd0pcPzeWnsHylKhHelsZMCEEWqE1KG+BxUZIDa3mF1jAL6ORi
 i+Bebl/Qc2hgIEc+o/HbbVFaEDkUrhYIeaZsrprcid7BheUk1gLAiMLb99+VIBKKFiPlixGiVmb
 lTovgzGjvGCOoO9sO9aAX6naJscw+NBvLQzlbxXSO/3q1ZcV03KhyHI94K6bl85xC996HbHN5Vc
 03Ca4oPljIrq4m5lWvqnPOgLZuo7QrSBvJjtdLT4R0s5UzYntd/GA5qJjkpRt+mW035y5UkAlPG
 k0ctfN4iJfXwuGRQGzkkdIvTOSw9bnNHV9hbOeshZKtXdTH/+Kcy75MniCN3ebL2odbl3mKGdYB
 bU8AftE9PwkU3kjSDEJqgHYhguMCvItRWiI27ZYm2jVWR7asO0JyEl0iPT/g=
X-Received: by 2002:a17:90a:e7d2:b0:39b:92bb:9ef0 with SMTP id
 98e67ed59e1d1-39dec0bdc60mr9131814a91.20.1789432041469; 
 Mon, 14 Sep 2026 17:27:21 -0700 (PDT)
X-Received: by 2002:a17:90a:e7d2:b0:39b:92bb:9ef0 with SMTP id
 98e67ed59e1d1-39dec0bdc60mr9131762a91.20.1789432040953; 
 Mon, 14 Sep 2026 17:27:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/6] roms/Makefile: add optionrom-bin
Date: Tue, 15 Sep 2026 00:27:04 +0000
Message-ID: <20260915002706.36318-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wDCqrzMNm8ADK-E1ofjGnmjtkqwFEJrs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfXy++n7Cqs0w9W
 YDUO1DM0KEUnhM3vWoi2Fe8W9MOp8G6u4g+G7mgcsMFTZEMPnctPU47rT9q8CxLC2DF3kxbTU84
 p/xkK2RgUK6tt2vjB8O1bUvGq71CuKg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX2lHfNNWdGBxW
 ClsbtgQc52utMM1QTJkssa9x72w9sJzIrHu0qGpX8EDLccriPR64ReuhAKj1OTkRMNxcMJL7kF4
 FJt5IosA7kDneAlnLGY+N58YNrLw3jLvdZiE3kCw3KWMa53JZkHm7WWoM6FlCE/meKWrHw0OtYF
 Gb2RmGcKlCYtBVGeLnD7O9BXSJZZvJjsUwQzYvPLV297G2Qznhuib0wLtTE5gN/t5UqvPtTJmLJ
 mg5/xu/NDPPVKw/3YpxqettQL0D4gdVWRxhUxp2hMmziTLSbgnpz6EwphzVPseEmp5aTMBe3C3w
 IXTyLTkBK0JpVUEu09PuI3OV2j2/l3vtWkYcjbfriPNNCZxLI06kSEl3Lc8Mkr6LMom4HGW7FnS
 SCneyn06ETGqUoXqyglDeoZq+xJL2PFyqZyVSBJaZ0fOCLFHOaXWOFsYqZpNR0O6oUhbaPBYteY
 opMG9sWmZu+MWZd7w6A==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa890ea cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=4rAdK4PdC6YBIYm_0AkA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: wDCqrzMNm8ADK-E1ofjGnmjtkqwFEJrs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150004
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

Remove dependency on config.mak and simplify Makefile.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 roms/Makefile           | 10 ++++++++++
 roms/optionrom/Makefile | 39 +++++++++++++--------------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 84f22943d35..57a53944b9b 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -75,6 +75,7 @@ default help:
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
 	@echo "  qboot              -- update qboot"
 	@echo "  hppa-firmware      -- update 32- and 64-bit hppa firmware"
+	@echo "  optionrom-bin      -- update optionrom binaries"
 	@echo "  clean              -- delete the files generated by the previous" \
 	                              "build targets"
 
@@ -216,6 +217,14 @@ hppa-firmware:
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
 	cp seabios-hppa/out-64/hppa-firmware64.img ../pc-bios/
 
+optionrom-bin:
+	$(MAKE) -C optionrom
+	cp optionrom/kvmvapic.bin \
+        optionrom/linuxboot_dma.bin \
+        optionrom/multiboot_dma.bin \
+        optionrom/pvh.bin \
+	../pc-bios/
+
 clean:
 	rm -rf seabios/.config seabios/out seabios/builds
 	$(MAKE) -C ipxe/src veryclean
@@ -226,6 +235,7 @@ clean:
 	rm -rf u-boot/build-e500
 	$(MAKE) -C u-boot-sam460ex distclean
 	$(MAKE) -C skiboot clean
+	$(MAKE) -C optionrom distclean
 	rm -rf Build
 	$(MAKE) -C opensbi clean
 	$(MAKE) -C qboot clean
diff --git a/roms/optionrom/Makefile b/roms/optionrom/Makefile
index f1c1b9efc21..ba4a26ad390 100644
--- a/roms/optionrom/Makefile
+++ b/roms/optionrom/Makefile
@@ -1,30 +1,20 @@
-include config.mak
-SRC_DIR := $(TOPSRC_DIR)/pc-bios/optionrom
-VPATH = $(SRC_DIR)
-
 all: multiboot_dma.bin linuxboot_dma.bin kvmvapic.bin pvh.bin
-# Dummy command so that make thinks it has done something
-	@true
 
-CFLAGS = -O2 -g
+CROSS := $(or $(CROSS),i686-linux-gnu-)
+CC := $(CROSS)gcc
+OBJCOPY := $(CROSS)objcopy
 
-NULL :=
-SPACE := $(NULL) #
-TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
-
-quiet-@ = $(if $(V),,@$(if $1,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
-quiet-command = $(call quiet-@,$2 $@)$1
+CFLAGS = -O2 -g -I ../../include
 
 # Flags for dependency generation
 override CPPFLAGS += -MMD -MP -MT $@ -MF $(@D)/$(*F).d
-
 override CFLAGS += -march=i486 -Wall $(EXTRA_CFLAGS) -m16
 override CFLAGS += -ffreestanding -I$(TOPSRC_DIR)/include
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
-    echo "$(TARGET_PREFIX)$1 detected" && echo "override CFLAGS += $1" >&3; else \
-    echo "$(TARGET_PREFIX)$1 not detected" $(if $2,&& echo "override CFLAGS += $2" >&3); fi
+    echo "$1 detected" && echo "override CFLAGS += $1" >&3; else \
+    echo "$1 not detected" $(if $2,&& echo "override CFLAGS += $2" >&3); fi
 
 # If -fcf-protection is enabled in flags or compiler defaults that will
 # conflict with -march=i486
@@ -36,34 +26,31 @@ config-cc.mak: Makefile
 	    $(call cc-option,-Wno-array-bounds)) 3> config-cc.mak
 -include config-cc.mak
 
-override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds,-m,elf_i386
+override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,flat.lds,-m,elf_i386
 
 pvh.img: pvh.o pvh_main.o
 
 %.o: %.S
-	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<,Assembling)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
 
 %.o: %.c
-	$(call quiet-command,$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@,Compiling)
+	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
 
 %.img: %.o
-	$(call quiet-command,$(CC) $(CFLAGS) $(LDFLAGS) -s -o $@ $^,Linking)
+	$(CC) $(CFLAGS) $(LDFLAGS) -s -o $@ $^
 
 %.raw: %.img
-	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,Extracting raw object)
+	$(OBJCOPY) -O binary -j .text $< $@
 
 %.bin: %.raw
-	$(call quiet-command,$(PYTHON) $(TOPSRC_DIR)/scripts/signrom.py $< $@,Computing checksum into)
+	$(PYTHON) ../../scripts/signrom.py $< $@
 
 include $(wildcard *.d)
 
 clean:
 	rm -f *.o *.d *.raw *.img *.bin *~
 
-distclean:
+distclean: clean
 	rm -f config-cc.mak
 
-# suppress auto-removal of intermediate files
-.SECONDARY:
-
 .PHONY: all clean distclean
-- 
2.43.0


