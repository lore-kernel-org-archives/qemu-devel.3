Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E56ACD4F26
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB8v-0007P2-GJ; Tue, 23 Jun 2026 20:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8u-0007Oa-4k
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB8o-0003Ax-JN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:06:59 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK1D4i1259741
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 M2bDB3WX/4cfzI5MLnNA2V9fGf9bdsUqT/08tNTdLTA=; b=hBrHL5Aobckj7/cT
 fqbKCGONwVkRhMTELUMdnJnuWh9h6oOh/2MpSNgCzYfjBSNL38upVup6raWWHLjo
 zgUOAobQ/aiFlnS1qLEx1OcKtit+8fb6ZCIw156CQtaPy7akw2yDMmNk1x1/LpjN
 v5LgCutwsx2oTjEUSvHLNC363HUZdLYgDsR8XXwiClQPBU/KvsQe13VPPgHDKV9R
 hg/VjEksurrIgVVUoCw+JsRn19uhw+gQawllWYnlWL79ixhyNIQXWxSc2S7K1DXl
 YpJtzhKumnGtT05d4QDdpRbhyBTm8bZuonRUvTKCQA3GQUMkPwIbRixevv6yZgto
 f/ED9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvv3vj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:06:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dbc0f048efso10783696d6.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259613; x=1782864413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2bDB3WX/4cfzI5MLnNA2V9fGf9bdsUqT/08tNTdLTA=;
 b=jQ7Eb/izMdFct9ZkQTJ5cyq8uJhkSSnsIV3AbWFqiS8i55fK1Bmc6Dw/kHjLXgkaDr
 +v8bKWKvPf5owVDZJgCtrQ2aBfuduxKro3Da3sQnFvGecdOcD8PYu0fEevxOLPEpX3oy
 y0lNiAa56Gg986qqX5q2lhqvOyG8XJazHSIY9EMQgeS0mNXADnwVYC+u1wsYRp7WzJXl
 IVNwRHWsF2L5yoPBCni0HcHNDQx3SkseOZ3AOTJEFEFfBq9PzrHTB+pciJOGEQmvX96A
 3ZRBGykr2ZM9XvDGVCuwJB5pR415+1Jmn85AjK18afRlBRe2SqyyiBuv2tO3muyGK+bo
 /jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259613; x=1782864413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M2bDB3WX/4cfzI5MLnNA2V9fGf9bdsUqT/08tNTdLTA=;
 b=DufoqkAa8bhNoiLe2cr+zqmdWFXzomDpUfNNezicxbDkj1+nbqKwa6HMALLcOEv011
 i6gOcD/xG0dbOFqw19uf2V5o/qUXve7T9JLMwBz4pqRD3fSWEQCQKsPSvUirsQJaiXa5
 SQMTTiErh13zis0Bi1zMhHbE0l5ISX8zapcX5eINjKxgJnpdnvY7GmMNZ5WBH4+93/0D
 sK4HN4VZukahOMhe7Jsa011vKNju9KwfEOrYTgG9/I+UO1n0fBvSfhoNdABsUbAJejv4
 gxnheuUDnPbo3Ty1cXFo9Lv6giAYdoPSUIZFDXDD8M3Fi/6sZnjRj2w5j4M6GUChquWl
 Y+4g==
X-Gm-Message-State: AOJu0YxE+kQ/Ze4Hv6Z7c+rCtHGpKZyrxTwImXzJITRQkRMGtn5tuddd
 WoA15l1tT21cghuLRFGaCSMy2UWTLxBJvkeHQpw2gTV0Pge+TTe5kZQ0syrtx3QVqanGPSzktXX
 w30bKqUQEMAs88blwXeynHa4HSI8bnDfQKQVfFCneEwnxa/wN2kjYk0xYsSEAc0vsUA==
X-Gm-Gg: AfdE7cm1uTULyImuqIy2rMEfcJag48AlVV8QNowjlderyJXYWppS3bNJ9hD5FNHwFif
 +XSxWmV6dhb6zeRM/GdnxgmPbU2NrRQvhgKHNUSwEDfHt+Oq1GO1nZuGfoNzIafzJHtr7K3uGkI
 OwqpK2GYJENQ34v/pj2LW691f1//E/0MxRg8LGUaLIGGEUsv2iyfNkNCBQk4trvEiglOI9gWZJY
 1zEUDrcp9/hl2RsiAQoQd6ex6O1yAGLFQhd63C2B8e1BXWTUCabzbP+XogMCateGYDV4KF1roD1
 MXmr0gY+GJRgn3DIIhKdLoI78+akNqepJs5MN0C/n7NLKf3O/sGSkGd8izyBSVrdRtMGbXXKTmw
 4s5zPtxkgemiTHuZTwJZD5Oj3l893WENMzGQliae+6Ec/oQ==
X-Received: by 2002:ad4:4591:0:b0:8e0:4469:4284 with SMTP id
 6a1803df08f44-8e52d8cbc56mr19819036d6.5.1782259612956; 
 Tue, 23 Jun 2026 17:06:52 -0700 (PDT)
X-Received: by 2002:ad4:4591:0:b0:8e0:4469:4284 with SMTP id
 6a1803df08f44-8e52d8cbc56mr19818696d6.5.1782259612575; 
 Tue, 23 Jun 2026 17:06:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:06:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 04/24] target/riscv: move pmp files to tcg subdir
Date: Tue, 23 Jun 2026 21:06:11 -0300
Message-ID: <20260624000632.2149359-5-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3b1f9d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=jGktlri6GTd5LI-DgqAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX5BDedf1vyUbX
 MpUbZZ81lGK78YMai4XO5Y86Lc9xS0SauU/bOsfBgg1BsFD3B31glLrl+3p5glOErXnF0ZscOa2
 UPNOOplTcf7B07s/t32PpQFMcArRDP8=
X-Proofpoint-ORIG-GUID: uQjLgVj7qZWj_K7oL83EOmwAtQompM2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX5I2DZdlmTSaO
 HKAmMCuseDtgTuKT/lrkAjtJMBvpmtYMmaE24CzSg5I9egbdCfufcuzV8kNXyqpN32dkubsMAwy
 QXvNCZTzmXvuPc6PWWt8nw7YDCfl1ergMJ247IGZbkgqWsJGyTCFEdNLQwS1oKKrr1/li9i6v+y
 NwOH/k44KH73JXuqcYX8UxA1ZnwNE9PdxObLCsXxZO2CJWT3D7kC8sV6Z6LY6JcZebzM29r8mcM
 nvVrB6b3k3d/fpSmOpSAiQ3uZDVAC4O9UdSPpPSRQyTyUCSt4mpq2nU2/hIqKye5B3ajrQZOGxu
 /lU7iro8Q2/moEgy9gkNH94AjkCjANufpwX01O05tqzPiCPeYLO9BfVZgtrOCsIOsyJd5qQeEzB
 IUf8aC/peBKM31ZYaJ+0873lsFm+v5vqhsJDR4Sy9olm3QBj3yR7X6aDSkvW+sXYnTyykpEb0CS
 OoWfO5zT18t85y5HT3A==
X-Proofpoint-GUID: uQjLgVj7qZWj_K7oL83EOmwAtQompM2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

A trivial header change is required too.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


