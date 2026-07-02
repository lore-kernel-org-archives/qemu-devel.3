Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C36C43602
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHq7-0002pq-8o; Thu, 02 Jul 2026 09:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq5-0002nm-Od
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHq4-0008D8-8F
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662Dcpjd565177
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HvA+knPHbaA
 9bnWMtQEYjaoJjnLoQbaJzpAbT7IhYlU=; b=Fqnofq+xfmBgTN5sVhYHPuOV3zS
 pfosklGz5osVA0mRmn/H9DlpMmv9vtCeFjKSIBj41QQmX149ZGuY/C+wAz36nh2k
 z/3Xk5y0GxXNUbpTdTr1ZBEB8Kk8jc5ne2Pmvxl+FOmFVxOVH/ZTkgvB6EvEFPaD
 vx4WgQ4sLxN+XCr0xRiBvi2pVoMne9cRXo0GfiKT9ed3G+ZKM7A7oDIPd3MhUX1h
 YUKTQLrZmLhB0y/+npxcIUUbKWxiee1BpLVk5KuRPV/axEJzIDTT3I7w5/2JC6au
 bCHZ3YI9Y96wMSi1CnXW0tEn+NP7rR2XPX5S2YTLKjkPUBztdRXbW/FPzcw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s2501w2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:13 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-966a617821aso487502241.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000333; x=1783605133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvA+knPHbaA9bnWMtQEYjaoJjnLoQbaJzpAbT7IhYlU=;
 b=eOD1fbzOiqFXm/1XKPxs1bQH0r3NscB+41STodV54nTHMRNnSFbJzmSmulb4+RuViJ
 gSIFcB+iOv7hXOewIm+SAsX9VSExAx973pClxeszgDaeQAvKXR4EgXgP2c3uDt40TXdz
 zulh4xpc7TKHbsvgDHpTpYacIZQEofZh71AeCHl/oOO8liRf5JO8Vz8DmyUQpxYEwuxS
 6dFqwjBBMdSF/3ZPbaahTjKB+vX6A3tGW7PPJFQNHBcbfj6m0if/Iq0J0xXdPuF1ItnE
 oj7Q0quBged65KLg6ypuoCaeJbg0rVrxCxYgdPuY2Ng28o7oMVrsk8IXYgp38NrDq2OA
 J1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000333; x=1783605133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HvA+knPHbaA9bnWMtQEYjaoJjnLoQbaJzpAbT7IhYlU=;
 b=VBuATPrqLNGLMpNDb24Kmhz1FY5YXrVfX9AvMGd86hDzmvyxoCfWhcmDscJFMj8kPC
 jnPt5AI+2n8pYKK5zcnCDI0gSkg3e1lJRCp1qECJ0uP8eBF25zftzVMdRf8D3QkoLSMW
 XsRQMyOQy0Bland92Utpk4WARgMBiz3G3dwmrYnNXl4HCOwtu12hr/pWMs0nayLztBhT
 HScj5gnIMtblizTv6/v9r1aUjygeH4cfFl/xkEyPYulKWLEAd2od2zmOYwUL15g6Mlvk
 11rOOPW8LcSQiN4oUM72R7rGrK74o60U6Mcy9ihZLmFPpxDEtmGfTjRacclMAD+FhZgH
 gRCA==
X-Gm-Message-State: AOJu0YzyigBj29JnPpyCwHKa4fcw1BvTxgkjehWTQMM3G74Fl8wGdUeU
 KA2kIWNX72c3NI2QGPDrgVxByYa43MZm1M6khbGQ/27BWJdLagp+9aFYL2j8oFR8iKjVbZSRULH
 tbtcrOv9O9Kw25v3LYPHGDtCJ63Tw4cFlZMDym/Jnv0UP7I0zJgNsnSvyfyZVoQaGbg==
X-Gm-Gg: AfdE7clr96tiCoyzSVypyJcSn1OcCucvc+5Vz/8wplU63NIqMRqzI+HtiR3BLgfpITU
 6/NLkbLxuZ+W7THYPl3NZm/ZGs4gAZkTdnyxTHYEfig8l9HbR2sAj0tdzETZa7nMboLqlpDIFk1
 qgXgXNMJcxa1Nso5VTn8yBHQG3u1y6SURG4YMB9dcoAXAZ4pPYi2Vsb0uxViSZRaneXSqp2pEtY
 YSd7kehbG0o0xsSjsaZqHNMnXKFins3+7XMUdIEkaLQ1gHgoHu8pgi/QUlpJLgKcz2pe80sZyz+
 cnQoFflnOjUUGzE2d4TZiEEGn6TAwxz5tLeTbXyxmmGP8PxdCFfWTUNC3mI5L7dmnSKVxFSqtPe
 mC0PxuV6MW/qNK7UzWpD+ZzRcicuu18lPlBOcWjCp/ZJIaA==
X-Received: by 2002:a05:6102:1497:b0:728:68cf:c76 with SMTP id
 ada2fe7eead31-73daa339c76mr2325532137.23.1783000332669; 
 Thu, 02 Jul 2026 06:52:12 -0700 (PDT)
X-Received: by 2002:a05:6102:1497:b0:728:68cf:c76 with SMTP id
 ada2fe7eead31-73daa339c76mr2325523137.23.1783000332214; 
 Thu, 02 Jul 2026 06:52:12 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:11 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Date: Thu,  2 Jul 2026 10:51:17 -0300
Message-ID: <20260702135128.1188021-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a466d0d cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=n_Gjmr79VRyvsDPUZ2MA:9 a=TOPH6uDL9cOC6tEoww4z:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: DsJqU5HpqtWrKLoIxll8cU_VJQHqEcZ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxrSKM2W/maUZ
 pOCopSLJYyEJCoTLhdw4dN+O5Acidl8+ic/m9LVlfQQEdVSid7tXZ9wYR9Ttb7TCjpXCQtLrVxJ
 2ZTA1N8oLUfQpsV8/FqM5wV2DeROtf/SXCCix0d912zfYlt8kn4yTdtb/G67m+K35avYFuET99O
 3tU+nBrvB6unXIYEOGKUCGUFU1guivzsUefnMpYQ8reI8npQyjY9a+Hfr3orOKrnb7AvktAihtF
 8/k2XB4UNyZ/Nu6BubHa7nCyqDJoBfrkn3RNdqiwOFYqYFbxqpE+kfNM4yeRjDby/xVgK06/vlE
 36X2NfrNbAvSMxG4N/6gFtqJXpF4Lc3QIymOTmOu/FumGw+ArcRvdepObUjGw84EHC1A0BJIdYb
 39B4v8RJMxugVo91CMMuMfVdRrR/FKZ3UJyl/xW10XZQ1l8W0AcrJnR3xlarAsjph3EBMNFGk7J
 gERDa6lHFBgbDyntv2A==
X-Proofpoint-GUID: DsJqU5HpqtWrKLoIxll8cU_VJQHqEcZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxl8PsV1Spuu/
 J4IjNKE6u/u+XDc1zR1fa9xnGMQrMlVKGrHBptfS6Rb4Aa+WnZB016fEeBB0FLhuTr6/Atp5TS6
 kN64LCPZOhqQreq1HeDxvw3leexMwdo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
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

riscv_dump_csr() is a TCG only function but we'll have to implement it
at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
ifdef while making a note that this function is unimplemented in KVM.

The csr_ops array is also TCG specific, thus the for loop inside
dump_state that iterates it is also TCG only business.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2741047769..db18c52656 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -612,8 +612,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+/* Note: this function needs a KVM implementation.  */
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
+#ifdef CONFIG_TCG
     target_ulong val = 0;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
@@ -625,6 +627,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
         qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
+#endif
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -662,7 +665,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 #endif
     qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
 
-- 
2.43.0


