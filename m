Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAFDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpV-0001br-9l; Thu, 02 Jul 2026 09:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpU-0001av-08
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpS-0007z2-Dn
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:47 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0brc522233
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jF381ehenRVkW5eehrJwcSfY8zbW3H1Slv9sIPsOo9c=; b=mUTxCoYksxZfDWpG
 yjvl38l4/qUjR2uR4/X++PYofo/jIdJMvgbsclWBNTIg3vjKFlExInPPllmhi25a
 QamqiU5xTcTNjDeNgZULwiyjEPpT9jasdXTQD638+5UQIJLdTzPoO4uu+YJ78ABj
 DGtdpbZfTcBb/yA4KZB6ufRU1GgkCez80ZtKNyyyuXbW43O3HTBRcaKnFOIh4/GY
 1+CszIFf/eRlCJrlPrvNGNQkEdFWrc+VxAFpNXbizBcYR0F9+feLt9hfwQPfoqWy
 yZg7mAEVldeyQGgXW/3nYngSeG4dpczRG88ZZ1XsfIpYGMRW0BfIpxE0ubryl029
 B6NOfA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1gfr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9691d185f5bso577201241.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000305; x=1783605105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jF381ehenRVkW5eehrJwcSfY8zbW3H1Slv9sIPsOo9c=;
 b=C55WJFUI9qwrbjEztyBSJBm3Yi+0iiP8Jb954pz4QNHPXDvG5iNXUWBOoWZXmCyFHh
 IQ5HxKiXZbYnJl8VTML4J5dGEyhjmC+OJnj/lzsec2Bp2XURXjZaZJNW313Dlw6tJfxP
 vce6oPoJhKEzaGcw9PhEKY6OSaixmQuyS1UgiOBtGgLrPU2yvSihA/TQ1Erb/9IpA8BP
 u8sCfhM0o6gYhxeNCoyuQasFdsasayCg6mKvi/1ULkG/pwDk8KhgmjmDv689N//o2bWz
 cj1QSfqSj9qWI4Jq+L0Mcopc+TD7crAZ93ti8mLPJCSABewv2RR7HqoWSsVtdlXkfsNx
 q6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000305; x=1783605105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jF381ehenRVkW5eehrJwcSfY8zbW3H1Slv9sIPsOo9c=;
 b=c6QbsKYnIsgXBWKLzC6jru2J3TMIY6N0UDnvDNooGqifmEM32lXvBdy0a9SJgB8qiC
 678uAprSm3xyCvtKVBnN6FW5b/BZSR7lqfyCgNh+1w2gyDKuIHesjFB1jLeWapaED6kL
 ykiVuvRgEBzb+qdBWgR6O4LHqsZAfm6W1paN3i3XhFZCHdFdUHNz5DAJXOQksDCIyJ+S
 398Zaxu3HYI6M+q6vE2bCKtjz2xOqYuPX9vm8kX/MlKEMFtYArfHRiI9Ox0Vb4g8M0fB
 Ied0L+tSFaoqIVhzTUSzS1NocZxFBqLF/N/IPoO0b1Pu9Nb7enisWy5KRgkoPXs8gAeE
 7nfA==
X-Gm-Message-State: AOJu0Yx8Hb9ic2LN9qzt1wqpQNYS8cyWrEIUBvAUuZtzILlprM4S0aSK
 q/SUuUyCAw1a9lCxCEPeUS3s57/WSWiCmhCrgoUKpjldcxffD8ItIlvDo9HGPdyuWfoxtwYaXge
 IRNq7hoAL19sApZCFcf1jFU8sHecMCujI1HkIkNWH++9xYcsdL2rf80wr/Kj5CG99Bg==
X-Gm-Gg: AfdE7clvEnh+Rmf0pEgF+TDS6mlQN2VBHfoU85ADOlFclMX95mVMamW60lGN7AV2MCh
 JmSIzEdE89oyUaa7ODdWwQe8VmFjd5rKE5PMC/ZFTXJ/xC63bFArT+alCjAb08SWfW4iuSjGI8h
 nnssJrNm4ATCCvMz/ZMPi9kxMyFE5eoRGbVjCPzUyrWfo6/0cmXd64EeMYf+w/9HDieBsbQDAIs
 Gu544zPgv0B06gMODSCsu/vaHvoRXpVKtJ01Gdsm0alyOaycsCo0jHN/sHwELPOu1mKvnfn9n6k
 jtcYfxM8t3VsLkY19L39EVklIhFEgSu7G5hPgNfVLLalftVKTMXeWBuio3uE7+8FFbirZSbsSjJ
 idoNdeVM6wDH6Z08jXTebkuqEdxylJfnEbZ5AQg+SoT3uVg==
X-Received: by 2002:a05:6102:8607:10b0:738:f5fe:3c42 with SMTP id
 ada2fe7eead31-73bd2d50c63mr2491744137.9.1783000304906; 
 Thu, 02 Jul 2026 06:51:44 -0700 (PDT)
X-Received: by 2002:a05:6102:8607:10b0:738:f5fe:3c42 with SMTP id
 ada2fe7eead31-73bd2d50c63mr2491727137.9.1783000304025; 
 Thu, 02 Jul 2026 06:51:44 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:43 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 04/24] target/riscv: move pmp files to tcg subdir
Date: Thu,  2 Jul 2026 10:51:06 -0300
Message-ID: <20260702135128.1188021-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XgoRd-SRGIr6pGa9vevXafw-osBwy7yq
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466cf1 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=pGLkceISAAAA:8 a=jnI-slyzAa9jSDvEpakA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX1RLLIgafmBGn
 3urmnh6XbVS0geEYeEgw3mdPencIg4mElr3u6U79bn5GKuZ+3KcnoUIJPiXhWtiTISy5ASLFaie
 EQAQfLfYrSGYpOzId4D33HBBVW0dZz5KOkZDcPiR6cK15Zr4XjIp9xPgrWeKt6UO6jtKOM/PLBA
 e7RGo8VWowOiWt6hJiZC6wCekoKT23KJ9in/HHahhG6otp0s4mU6GveUzZOdqO7R5dyUOYZ+Qsd
 HIuYuAl3SngI4UwgRe4/1P0QtPH84iuSwKG2/xlf7KVEbhonpBJ3AKEasMRU/78g9CVvG8W9cU/
 7VVvw/HVCBAQKKXS7b4Yr7APhGy3AoXIgxvWhxvazu/McZdJo39z2wzey8+sE/1AAnV+ELmOuFT
 2FODNlmZx6A44uZ+f8CduSPbFRboOSJyJTsc4amHnnXZ43Mw0JdZ+e61ZhvbTWBfDvczsUE5ZN4
 ej9y9zNK/DyezGCIybQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXwjF+25pjITiJ
 B+XYzmSzaebtKXOkP890Z2eVvHTDnocxH/lHtlmxMK4SMmzdBBu4tGDwSZQSoJ3AEpZ/poVt6w/
 HH6UwjWKdIt7FG8STyreCM6u7N4vrQc=
X-Proofpoint-GUID: XgoRd-SRGIr6pGa9vevXafw-osBwy7yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

A trivial header change is required too.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.h           | 2 +-
 target/riscv/meson.build     | 1 -
 target/riscv/tcg/meson.build | 1 +
 target/riscv/{ => tcg}/pmp.c | 0
 target/riscv/{ => tcg}/pmp.h | 0
 5 files changed, 2 insertions(+), 2 deletions(-)
 rename target/riscv/{ => tcg}/pmp.c (100%)
 rename target/riscv/{ => tcg}/pmp.h (100%)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index bdd28d329b..f0c78c1474 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -183,7 +183,7 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 #define MMU_USER_IDX 3
 
 #if !defined(CONFIG_USER_ONLY)
-#include "pmp.h"
+#include "tcg/pmp.h"
 #endif
 
 #define RV_VLEN_MAX 1024
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 61874ed0af..42d0f6d538 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -22,7 +22,6 @@ riscv_ss.add(files(
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
-  'pmp.c',
   'monitor.c',
   'machine.c',
   'time_helper.c',
diff --git a/target/riscv/tcg/meson.build b/target/riscv/tcg/meson.build
index 5684fcf985..a05ab642f4 100644
--- a/target/riscv/tcg/meson.build
+++ b/target/riscv/tcg/meson.build
@@ -21,6 +21,7 @@ riscv_ss.add(files(
 riscv_system_ss.add(files(
   'debug.c',
   'mips_csr.c',
+  'pmp.c',
   'pmu.c',
   'th_csr.c',
 ))
diff --git a/target/riscv/pmp.c b/target/riscv/tcg/pmp.c
similarity index 100%
rename from target/riscv/pmp.c
rename to target/riscv/tcg/pmp.c
diff --git a/target/riscv/pmp.h b/target/riscv/tcg/pmp.h
similarity index 100%
rename from target/riscv/pmp.h
rename to target/riscv/tcg/pmp.h
-- 
2.43.0


