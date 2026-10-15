Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A788CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT54-0005GE-8c; Thu, 15 Oct 2026 17:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4V-0005CF-Vo
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT4T-0002S1-QI
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:33:07 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDP1w4126286
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hJk2Ls8ygjz
 tvGBrUfFmOeozBamKoF86GoVW2VCYsHU=; b=RRbquBL1BKP628+KZ9PrRFDJsM1
 kIQ0I1r0cthHJvsAq1A17WrxV7QlIeMCpD2rTBF8ET/rpWRi2bSO3fagusom3J2c
 LK1PymCGqFZ0yogTGlOVril9DLr/t7V30eL4mGeDXhPpH3kkRDr9GiEYCOGbQxdI
 zz8kgKPT44XFFl78mahGzJfJA2kfV3krviNrz446Y9JpwP7EGCCk3Bs0AH4PK0Hv
 wRzQwx9mGrJSqsHuZfOH5aN8EkJz+/KtzpmvjN5quyk7CT6i0jbUw4aoZ048i0eS
 +vrcL/tqwc5z9Pet+2+iJkxloIhXbplyoh9DbJ2BnGrs9I0bszIYOOWKKJQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m1cxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:32:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab926c236aso4621505a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792099974; x=1792704774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hJk2Ls8ygjztvGBrUfFmOeozBamKoF86GoVW2VCYsHU=;
 b=edFAYHnVtc4Q6SU/UK89RE3JVZzp/KKX547gbi2EtI4x+VbzINDL17L7dtszpDBiCn
 L7qtlTl0PYCLsqLMgB0b7uDjMZVdoNDwnh1AZWJkbxRZNiLfxTJk6hhVt+EEgtalYoC/
 FavGg3uVLC4vcWJdWuxNVvBc1nilCXPqMELlETmciJ8qEel2Ab4XSz3+zqQDvDLIrG22
 pgqdRI3R1u6ywxmz2UUKe8Ozl5FFF3K7l4oIrLvLpyjSV56wGlPRY/p7d7tENkl90fCp
 9nogDX14i8yLeiorpCm3f1ZEwYHb3vpm2LElTL9L8/kJjuMhqQ2cnasFS/mwGuiNhcDU
 oWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792099974; x=1792704774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hJk2Ls8ygjztvGBrUfFmOeozBamKoF86GoVW2VCYsHU=;
 b=NYatsQnVswzke/nYSxLi9x99K2xskTbyr2jwOoFTJ9F7/NegCtVKW1txJ5+eCxtj+k
 2jQFRcXr04pjMNIyFbuWy5TL8dsjp9D2VOB64yHPPTwYilgLo+sWZRwBXBJCljMhsXVT
 hVbyLD9LtWdL7gYXqbB9A8dmYICtEjuycVkXxz3Cv/V2oOYulDtvzPfg7JLN+lzd51qR
 pb+DsM0GmLcuWKqMACbN5AIRO8km5mnf27aYcHDXCvQ7r5NMQgBnhBp+kHk7i9VDOHc6
 CJrjukMkYgiTrtUbislxD1AgifWYt+uAJG7hEUItJ3inKU82MbUOowVfveRDLLXP4q6o
 gjDg==
X-Gm-Message-State: AFq9FYLft9BwxiCddlla825y6yvIgiWzCdE4HuyE+k4nOHDYuwFy+Uxe
 qZqVPjEn4nh7eoUE1/0NiF/x+fSHG3c2xHtT5h1lVSLG1bBzE5cOR1mful5A4MqxJjmiParu7ZW
 TBOtC05QiqbxgEAPvTjtnQDs5wb0mQDNoapQqUZPaFpkao8ssS8lwKP3TWg3eOpcIbw==
X-Gm-Gg: AYBFou3plClV+LD9y1CuInktW/2MDJ6LoUUB9V16Elr7ehRRofxchYlZQmWKbh5coRN
 sg89Ci5Zhl2wvijf3pymvHcG4TvAjQnFw6bJTy9Y8XtvF3WOSGAg6+nbQSBr7/9Kd69ZEKEov11
 QFSPNewKrntmUoUyeGPviElUIAQg8NtP13rM5Z2dLYf6D6QoZYq5xH2uLm6XjfxQzOvsf2Cf/Ps
 4FfbcdZXt3+bLxpuj91iMUXY449wGym2ho3B9gAyIxtPPFe4ynag/3NxWeUI1i9eDeTNf97PWxc
 1aurc6vUCqq+XpJCdSrVaC0wqZrfSH6EXdIE5D1WRv1NjTzFTpc5vYQGmeZ3ALsfC0CrAsGtVK/
 ldwe5qwf5t/PxEX7S8NloZaGTCFmdAIY6VyirjsLNUTf0BEJsC2c8+WsmQNAx2Vs=
X-Received: by 2002:a17:90b:2e08:b0:3a7:a463:54c2 with SMTP id
 98e67ed59e1d1-3ab3ad1ffa2mr17805824a91.35.1792099973779; 
 Thu, 15 Oct 2026 14:32:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2e08:b0:3a7:a463:54c2 with SMTP id
 98e67ed59e1d1-3ab3ad1ffa2mr17805803a91.35.1792099973243; 
 Thu, 15 Oct 2026 14:32:53 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac940055f5sm5989362a91.0.2026.10.15.14.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 14:32:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, anjo@rev.ng
Subject: [PATCH v2 10/19] dump: remove cpu_get_dump_info
Date: Thu, 15 Oct 2026 21:32:27 +0000
Message-ID: <20261015213236.157767-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad14686 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=5zY7TNBH-1z3wV7SeYEA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: QMOQd_yKs95OM27FZbgPNR4boAWuo79O
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX0hpp1F/zNP2A
 y1Wgfx9tdBPr1Rj/lM2HTUgXQusC9hyf9UIzQ4OozX3GmAqXnSzzyqgN3nkhIHxDNiimnVMfgOO
 TcMZRQ8vTWHcFf1HfaxOUBCv+pPGfRo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NSBTYWx0ZWRfX3pvkbbEpBkr6
 4L5amCldL1Ge+BvRm4zQKEQO+Ywufs+HvPalIzbj022Rftm0Z2d6osOnhi0E0PslDJVbmIogOUf
 g9tVaNXkbXcpD9jaYsfMy+OWCJT3/tl8GEM7P45x0ybQ/F+24LRstcaeMpkbjhjqqZg3FHCBqUY
 FoqtmL8QVScrm3LWDRWGjl9o4TnYiWuaPNYhLESe1XzOjsr3v6uhsRb27oxjtjwnnRNeZxbkSza
 +75wCeGptsZ4HW5RDbQzA6ebauYmtNgwMlK0zo64FTooarzNTuLH3YNEFNdF//tG8WYlmeqEQK9
 IazNDLQHVrxejGNy9qZwc21eOZVReSoZy2mfwEmfXq12g4ix2a8P2HaWkJ/uT/+qJ8hL8VxYP/S
 SyFrvGM4hRsb5RQbx3Hrfnhl4Ss4J610u5QKiR2kGGqrAG3gNnn6VszsJciTGTcqQfU94CUOK/S
 9beVwy6eYf3WtOaomiw==
X-Proofpoint-GUID: QMOQd_yKs95OM27FZbgPNR4boAWuo79O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150085
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

Now that both cpu and the dump implementation use the SysemuCPUOps
interface, we can remove cpu_get_dump_info, including its stub.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/system/dump-arch.h   |  2 --
 stubs/dump.c                 |  6 ------
 target/arm/arch_dump.c       | 10 ----------
 target/i386/arch_dump.c      | 10 ----------
 target/loongarch/arch_dump.c |  6 ------
 target/ppc/arch_dump.c       | 10 ----------
 target/riscv/arch_dump.c     | 10 ----------
 target/s390x/arch_dump.c     |  6 ------
 8 files changed, 60 deletions(-)

diff --git a/include/system/dump-arch.h b/include/system/dump-arch.h
index 743916e46ca..7cde5e27ce8 100644
--- a/include/system/dump-arch.h
+++ b/include/system/dump-arch.h
@@ -28,8 +28,6 @@ typedef struct ArchDumpInfo {
 } ArchDumpInfo;
 
 struct GuestPhysBlockList; /* memory_mapping.h */
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks);
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus);
 
 #endif
diff --git a/stubs/dump.c b/stubs/dump.c
index df7897b72b1..2ce3c5e274d 100644
--- a/stubs/dump.c
+++ b/stubs/dump.c
@@ -14,12 +14,6 @@
 #include "qemu/osdep.h"
 #include "system/dump-arch.h"
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return -1;
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     return -1;
diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 98eecf3d26d..181691b81c6 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -432,16 +432,6 @@ int arm_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return arm_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     ARMCPU *cpu = ARM_CPU(first_cpu);
diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index d5016c198cb..004a639030e 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -430,16 +430,6 @@ int x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return x86_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index e216e906414..5a0e1742242 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,12 +152,6 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index b8d0bc8462b..46030ba684a 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -252,16 +252,6 @@ int ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return ppc_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index ac9e4964660..b2138ada1ec 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -182,16 +182,6 @@ int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
-{
-    if (first_cpu == NULL) {
-        return -1;
-    }
-
-    return riscv_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size;
diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 9a92efd249a..4301cf400e4 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -469,12 +469,6 @@ int s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
-{
-    return s390_get_dump_info(first_cpu, info, guest_phys_blocks);
-}
-
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
-- 
2.43.0


