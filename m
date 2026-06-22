Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A4ACDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkO0-0000u0-GP; Mon, 22 Jun 2026 15:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNy-0000rW-1G
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkNw-0001rm-Ch
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:45 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFVic33842313
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zTW6iltEwLv
 RjrstwtoU0aPT0/EdH3lbHOuPE1b69z0=; b=ht3jjsIsqukVmzp5vo9pbALyQFu
 qEjMH9Nx2IpbXXlRD5Zo90kK34C31IQFsS3EdHp8dY5RybAen0ZhdykNx9HJIfoJ
 4rFk8aNAbhFltouHrCyLu6o91GOTAzP4gUozQZIPF+P9y9zzCDUNM5PI2rEmT1pg
 zBF3fwaTDQoUmmvBC4VmFfex/R5xWuOfwkE61KA6fMSupoeV64tI3OBZcl3skClu
 7pGpJs9RtNgvfQrdsvGcU4bLnN9mf7hox+veoAZYtd+eKCFURI8KfBjBYxgM8v5J
 H4ceKqP9XrkB92WwcNf2+2Kyj5M8TCwpOA0jLyV1McBHbIq6WMfvZPw1FGg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yht18y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915767b341eso440326285a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156752; x=1782761552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zTW6iltEwLvRjrstwtoU0aPT0/EdH3lbHOuPE1b69z0=;
 b=OjvsT7yHDnk1a1h/4Lv12UBEMsq4PduSc6scTq2amv0HGI5ethIYH+KgN0CfWblf0S
 oA63yJCljJ+GRvzFT3dKW5j5xc6CChWIDoL8pKt3woSIebFJ3xdxS8ovCPx7HJNClLO4
 vzAOGTQRxGGBC/ntz6jAn7dD4WdiiHN+Cbjke6TH415l8ZoR1K2QouvfaAElOUfrjC2r
 1nlY1pxtr+gAs+XG/laQeV4yrUv2/xy5JH2srMGJzfBi3HHPbz3FLaBnMIqd5iREND+J
 K1fo3ObqLwL9gA6zVmObQZFJkDpTFmG+P0j60nDxJ7J3eUHTu7+83+G6yx6Qf8zyDr4j
 F/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156752; x=1782761552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zTW6iltEwLvRjrstwtoU0aPT0/EdH3lbHOuPE1b69z0=;
 b=V7peaqZLyYEP0VSMMPb7IYr2biTZ7k8qZPsTu+mxyIYnTewwReGJ+q1Ur8IxaB8z56
 ZGrUm97n0XGH//HZ6q1afCUkBWrGxXCgGP1Sad2IhqtsasuoyVu5j/MqWpcER278X0iy
 rAMH1n6eNbhC6mBC83UYg+UZFegqeyJzAvxAAYZ23xE1+Fm7ixWuvMdEnMdhxlP+Igs3
 LhAtNEVfetfNR9zAb87WXn1CVV1v2PnmOAdTSlrWaVyvapQlRO+EWeWjA6UuvONWBF1J
 /Z/ThrOAmP2AgjAQdrM6+Hci+GWSY+sC20Ro+baA4o1Qb/PGty/4Ww+9yquuegUY2vku
 AjiQ==
X-Gm-Message-State: AOJu0Yy2G2xbkkmNvIDaZF6SP55yS9M0IQq7Mp0Ph9I5yYPb58VN8vKL
 tgiFSeXFSRs5Z7mN9Dn3z70xyT1KRCnPqG7o9i++CY7KOWQwSdq8y2yJ43DrPcmBZhLvbJL/5kW
 dDtPB/PlMYRpnuwiWqzmFjsBDJPmEdjZgw9AH93QhHViCBJmG1CbDVyH5ZSDxLoqEsQ==
X-Gm-Gg: AfdE7ck7yKM3SLZHUjNKixT/DHwutDwR/9BFqkWyoC70dzI5AGWd4iztecmhGIR18HD
 hyt+F/P4SIXAR+drNNQTKYZJYBFF36Dd/vN3yljmOrBMH9bEDK/Sg0m1S6xBS7QWMUBYQIRZ1r8
 kc4dwSqfg+7dLwnsOHLPWvCIC+XLd3QclLzugFpTz0/+tm6mhKyOkrsvzh1/H/nadtIOk5l3z6D
 QpO/zAzZhdXrNhHPOUt4zCqWa8SYMwYJodqw2rXVVg1Rj2rHtDp8B1DBXcr67+3vaieJXVuWb1z
 EQWJdc7jdVlk7h0JeP6HOT045ugwzMBp/rZdT7QkkQInxvCxnPCSCwe4CAYpExNiqlgeB5Hj7dh
 Yd852jm8kLiJgwwBXii0eiQBEI6F0nMbgIs4Omz84gNmbTA==
X-Received: by 2002:a05:620a:28d2:b0:915:675d:a2d with SMTP id
 af79cd13be357-9208d7e7a14mr2604408185a.51.1782156751974; 
 Mon, 22 Jun 2026 12:32:31 -0700 (PDT)
X-Received: by 2002:a05:620a:28d2:b0:915:675d:a2d with SMTP id
 af79cd13be357-9208d7e7a14mr2604398785a.51.1782156751288; 
 Mon, 22 Jun 2026 12:32:31 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:30 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 14/24] target/riscv: move riscv_cpu_claim_interrupts to cpu.c
Date: Mon, 22 Jun 2026 16:31:30 -0300
Message-ID: <20260622193141.1449724-15-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX76DIOkS4aLBR
 RgSerhhwhJUrhh0o4TqfAAINhtiw56YDxruTsyv6iHU5d272NrzsGw/s0L4nd1fDbLWPCudoamr
 TkoLKm0UIPWcnvuVEGRMUwKsCfBUkF8=
X-Proofpoint-ORIG-GUID: CpXmQA5hJlo9zEhwJIZMk9U5SOYUhotx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX8JdlQjfZ0d6G
 /E0J7lZKAW/E+EtqZFbk8BtzL7wd2fedNfcvtQPjCPkJd0eEYRSVfuXN6st4yUZocd4Tt/1it2t
 XW1lDTxI+M4SIhOEAF5wWs7MLe35xuTZn1tRo/ZEmfS0/8jIemHDRDkKT8Waxt+6dgr5APbJ38L
 W/6GuPooRoh+41Q1BVkyMUCdjp1bpKo2/GPtq1R2rBSfFgs+Orf/Ftqaunv4UHWSJWYjNIghhVv
 3kKoJXPoczBG/7Wohv1kK3XO5yozRMqWzl0MswZSKYuSbj8jB/G+1QuQTXNXXFa1/LBoiGpCV3z
 Z/rf080KaqpwCL2ce5rIgN7WQyZrkTY7la13y8xVKHoeojGuPpJ8ChiaAqlRZ0DL9EnByHfaulu
 qCUyUW5yFYngBe+zL0iRTkln1W0EvBLWH2RJybx0/h5FOuAYZtSvYUg7e7XVdpXy2lcyo0XkduT
 5i0URJubXIH5UppJOlA==
X-Proofpoint-GUID: CpXmQA5hJlo9zEhwJIZMk9U5SOYUhotx
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a398dd0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=P7v9EdgfUgEVytVI3b0A:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The function is used by hw/intc/ files that KVM cares about like
riscv_aplic.c.  Move it to cpu.c to be accessible for --disable-tcg
builds.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c            | 14 ++++++++++++++
 target/riscv/tcg/cpu_helper.c | 11 -----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 41646acfb5..2b1fbe4b0b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -566,6 +566,20 @@ target_ulong riscv_new_csr_seed(target_ulong new_value,
     return rval;
 }
 
+#ifndef CONFIG_USER_ONLY
+/* Used by lots of folks in hw/intc */
+int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
+{
+    CPURISCVState *env = &cpu->env;
+    if (env->miclaim & interrupts) {
+        return -1;
+    } else {
+        env->miclaim |= interrupts;
+        return 0;
+    }
+}
+#endif
+
 static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index 09ac1aeda9..f99fa636c7 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -572,17 +572,6 @@ void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level)
     }
 }
 
-int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts)
-{
-    CPURISCVState *env = &cpu->env;
-    if (env->miclaim & interrupts) {
-        return -1;
-    } else {
-        env->miclaim |= interrupts;
-        return 0;
-    }
-}
-
 void riscv_cpu_interrupt(CPURISCVState *env)
 {
     uint64_t gein, vsgein = 0, vstip = 0, irqf = 0;
-- 
2.43.0


