Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F292CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkO0-0000u2-JI; Mon, 22 Jun 2026 15:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNv-0000p3-R9
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNt-0001t5-T0
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFX7Pl1591648
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CoY4lHGOSRL
 +t8mA9dqO1s1tHLvM33QXIPneGNC5ixg=; b=cGaIxt1ZHY7U0mhKHGeNuL6Rzz7
 SGV925c47orETpjoJjhoxCykUOZYTg1frEpyY0dtpaZIAMlM1TcqZ4pVQl0KEt2f
 dN3icBemYm8wiJXr3X4YDB0nwWZiraT03KHBzFfMifoKw2O9UGq6zQUQfG0B86L4
 qNkfDur0XsEZYKJ9URWl3twp8qccqRGaA5jSZr1dPU3D95zW0lNvuXOtKNUGrYU4
 6LQSek3vcwPcYtZLfoOnOJYsOJNqIicfa7uLWw9CsvwEnqIbHRl6gLCyNIclYMSl
 SgMSfBQ7gkkEKBf2x0bYW+386M6gVLBdYeh7OsQb+ChjerbuToFTHMO+7XQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n41dwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so1098015085a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156760; x=1782761560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoY4lHGOSRL+t8mA9dqO1s1tHLvM33QXIPneGNC5ixg=;
 b=NTFgWItVALOv908KyS+cuYIG1rQScfJreR2bfJUjpyaBxUKP5E/Jp5krlKtDI0r1Jr
 7x9xVE097VFOBLa6uOsfE2Z4/+ygEgA0p6EBa0JA+WeJuGa4YYwbYf+hTN/u0ftAuF82
 Rjk5irUSLHg3sQuMN92O23b+TovJiyaDooQ4tL1rbUcu/afhti5grHpKTkMJLdiYrhPB
 2keHJ0PC9abhdVyz6nfuSfdrxGqJ9ENwoh7HG4w9t4WqOo1pmWY2K4XaRntn8pqfN0iH
 42hqlwQbzKnkKWcnV9YgJbAhGiM7eNr6/b5DIypQaTaU4b2YOqLr6xvMk/OWwr2FC+9I
 D/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156760; x=1782761560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CoY4lHGOSRL+t8mA9dqO1s1tHLvM33QXIPneGNC5ixg=;
 b=IQVgjVtNxWuD2t/PqFiKHz7uPQQriLQr1IvDwZKWKznEq2EeKrLvzHiRalWm5QirJ8
 /oX3FwVSVIlO580kxd5rDKepehYT7cV81pYj9V/KZX/lQ/0gfTo96pMig/sOchT+jMFe
 akIZrxKbBujzev2Pw7vIvTiiqfamXZU8eNDr+KIzyWyZ8RlTOFiRTHYYgeQG/8HGrIB7
 ZlZTENOv3s322cS/NzTqMEp4Cp16aErMcLLap0eZcgK3T/DF/t0BHsD7ZnQu0zfQGhiD
 WFlvG2e8jgL4ITB7jZEe+U5nwjI4by+r9HqiyxlA/VWfw4pyAztqv9uL5pscLDuopzNq
 u7ag==
X-Gm-Message-State: AOJu0YyOPsX6wA9Y8lWNdvkfVADiaqFHFilnNeLWTul6mpzDu79AJiUF
 qVMALV/pobt+9i2boAXnnBKzEsrpr6zz3tNQf/cpad9PjUhlM9nD+JpUsYICD4dseDNksEb5o9d
 zhDPtnBguDly4XIox7hrZXX1clRyiTH43+aXA5Q332Ib+o2z7kkc0NpwsTzXaUJ0pgA==
X-Gm-Gg: AfdE7cmjy8DKEqXIiT+s3G4RRoR9cFNnwtojud55npsRBBNfLTE6znW3TFlq/32fwxn
 UP4iF0LY1kszSuvNpUyMcSyPKMa3YCO2xwUJ8+TSW7Ihx7/s642J2fxVONV10XtzKQM2w5LZMav
 /3paJRq0MW1eF1XEMbtVnNic9e3E0lNCczw6NodWiZnPNcobv82gzd53KPgWEiPBroQVEKYM32U
 jB6wIMkDJgm4oZiSW+qO2aoL10d8JuWoJgQXL7zP02jm6046NSlR2j1kuR9loxC8cTv6O1+LXAz
 NeoywK38qSbXwDMRNj+einIg8qOMTPEcql6SgoE/n9U9p/urPeiVQHSDXGhIIbjzC5jUBepS9M3
 YBolSOJ0wru6bNkKrDfIOcPXkd52a7mDCU1oxeafbeN1+qw==
X-Received: by 2002:a05:620a:1991:b0:91e:74f9:17e7 with SMTP id
 af79cd13be357-920d403a72emr2244101085a.31.1782156760290; 
 Mon, 22 Jun 2026 12:32:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1991:b0:91e:74f9:17e7 with SMTP id
 af79cd13be357-920d403a72emr2244095685a.31.1782156759844; 
 Mon, 22 Jun 2026 12:32:39 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:39 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Date: Mon, 22 Jun 2026 16:31:33 -0300
Message-ID: <20260622193141.1449724-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX5cdugoSNLMw5
 7SdJk/nYpQ+LX2JWNiGuwF60zjlnG2b2I1PpgbjzRp0Vwadnu1lh5f28+VeSix99sqDMZ4idkQm
 bM0sVLBXvlcgMz0v+wPsnspmxzYNrbo=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a398dd8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=bJI4hLjMr12y1cUB6bUA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: oKHi-J5E0SktMbMtrk_esoA6xZvbyLD7
X-Proofpoint-GUID: oKHi-J5E0SktMbMtrk_esoA6xZvbyLD7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfXwJr1YxX2iBv9
 MOt2zm9sF+ldNSKsTSCXpjgUXwIDlaNfm0umvM+nhiZSwnI6ylaiCH3XDzdE4FJnveQTE8UhaZD
 ux3zoNOhQ4K0PadaPqHYZV01F0Jfp8SXlJtJu4ZY2D8BH7lCFly7ti+KnF2nVCqG+F/0RjDBFif
 gnZ+CJmEjiicAjPG4XhHcMIn7SH2YO0Si2B0fQrYA/lJptpvTameXbCB15Y6E5ylLsL/ixDof0R
 Drbs1kNDneQ1MnObiGgBYzx3jldl5PlSbjl537NYRqZsYFYhnEl9nJA2nZI5xdTDydkVrZMjtvI
 yLKUSwenVfVZOjllcpeLEOf3MVIcfy2+6vHxz9mgQ8xLfBRYTgojtFZktCZFUD2n/3p4ck3M0Sv
 R44igsC1V/QKXry1cHWzegCHvkAhVWVU3V+ma9hhXmFLPElOeblAm5THUfUPEoIimlfbWuau4qb
 L7vIOXCJOPL7nF2BzcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
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

We have a lot of TCG only initialization in the common cpu_reset_hold
callback that prevents --disable-tcg to work.

Put a CONFIG_TCG ifdef around those bits to make the build work.
Eventually we'll create a TCG specific reset function in tcg-cpu.c but
for now this suffices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8aac18ea5d..8a330487c5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -958,10 +958,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
-#ifndef CONFIG_USER_ONLY
-    uint8_t iprio;
-    int i, irq, rdzero;
-#endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1013,6 +1009,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
                     MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
+#ifdef CONFIG_TCG
+    uint8_t iprio;
+    int i, irq, rdzero;
+
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
         iprio = riscv_cpu_default_priority(i);
@@ -1050,11 +1050,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
     env->menvcfg = 0;
-#endif
+#endif /* ifndef CONFIG_USER_ONLY */
 
     /* on reset elp is clear */
     env->elp = false;
-- 
2.43.0


