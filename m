Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884C4CA5FA9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBHhI-0000yU-8m; Mon, 28 Sep 2026 16:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHh1-0000u8-SO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:11:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xBHgz-0008Ec-VG
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 16:11:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SHvseq1457993
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jM/yuS8jP1Z
 624dX2v0u9TUetTQDgBTnCDzRAvG82oo=; b=aX3Nj/0SW3yLaLKEGs652Int3sB
 N7xtcYRsWZwbpa9IZQoxkFoQw2juPQh75qUgLtXc9T6ADz0nQG2/Gwvc9qyJ5DMa
 TnsPYh0QTJEznhw0JlXnAiHcDuk+1fQ4nEkDxFIDPqMmNuEq9+P3MbMcmM4uyHGn
 dnYYzGS0U12kM4cHFTRy3mImijsWg/0bVeoI27FWcjdiuvOD6J8VIW80O+la9fa1
 FEo1G7nP9g9IcxcX38PCPhyCgg1nhzfXIsT0o2RcCgYWoYfOD8cGYaFN0qx/ymvw
 cYaDewtMvRwe99ELukzRdyp3axk5MbT1uwS9gevTKZPXGfGoPhLt+e3gVLw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw20mmf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 20:11:16 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91430af782dso78231536d6.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790626275; x=1791231075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jM/yuS8jP1Z624dX2v0u9TUetTQDgBTnCDzRAvG82oo=;
 b=BHRfUesElcI/dJS5ZU+nHEISaW1oPPngDGPtc5cpKN0Hl9dzMcPBti3xAJxVBw1UPO
 MB/vAIwQ0p+mrIF+1Misi/MjsRdsL54ryhC4TvaWrHZinrJXH235BXGUIUmGegAsav0T
 ziPzj2WKqEasJFV8Hj795DwVAQouTRVgm7KzbvZeyiER2zNG73uwwM+kRxSDE3JKSBfe
 62BpLxeRPDQzHtrfDa3s3utaTStiJbAlx4Z/z/8Iix2x1ibC5VcMY1EyKU7E6JbSV9gC
 yzzxsegXa7fovIRFcQ3OwH0Qubo20UO36x6X3XgVtk9scKAwLQH7AgwWf54sW42CZ/xp
 UMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790626275; x=1791231075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jM/yuS8jP1Z624dX2v0u9TUetTQDgBTnCDzRAvG82oo=;
 b=ozgOIzdvt7ilaFmF9O0gQQ3YKgk1tSModPCYgc1Fbxndsj5DleE0gnXA1nJDrFeEp0
 uqpnE5Gm2p2UmRCZ4xWge8Sn32E+Nm74j8BQbbHqBsbV9dNF5H1PGxd6JULlhWKHIpG5
 Hc1sed0sYAZj3l01s9FxKqapLSDnp9ADHKXcwhk1wUu8G9RDf8TW7Pi3RggbSG9Z3+Pk
 CIZXuw4eouxXxv/Q+ZLzN0RuYg0YCmfCej85+2wzrCtmBLh28zOj3hMXSLd6jKICAQB/
 NzbjZlEK8rufnclF070UhUSNTPTTIfIV24dcCl6A+FBdLnZHPCPD+lCTPwYcf0z9DP0C
 6vzA==
X-Gm-Message-State: AFq9FYI03gROi2OuX5Ia+ueALISJ51mFnklVVBvgw5tULfyfmJZ6xT2l
 aiDf+nRBfytPn9k7Pb1Bz6tIsCSJHmJCrjTwHsAiY5SdUHnnAR9nLvsb2cnqHwiSqqaC+LWqLsr
 xhwqaZ0nf6KwIehNmPQtWzfqWgAPmtDWhFA8ik/38wNB9ymwQXGUOtj+GLHnR44N17g==
X-Gm-Gg: AYBFou0eLegeh2RGqv5q7r1SeE0XI1fleXBqBN9z6s0hIkcxI1LxKJ938GQzquXLJvk
 QOJdMa/TjQF/GrLI40qwMdFmkUIk9sdsMtPV+5hEwQotvI9WGj5zDbhII2NZhOH3urf+nxrCeAB
 nVlEqwuXBrn4Sat2AFVZd1MFVKdUcznXANx0qlfSsYjPXVl1UEw3ctTU8N+XtTdkHjnAhU635NO
 fZ+6MdV8Z0Op0keb0Guy8l6twVE+53kDJu2BxPOKwJ8mNqZlCet30nICrQWXH1sLZrnurfjTeZK
 OM+Gpcer2urWjmo1ItVN09KimsvO00sYDg20vW9BulvaT8Og7DnJbClLYvKJRycyw8Y6pvdOH0D
 12pe15dHSF/GygoYLP2qDsGRkm7/B1nJkZOQ=
X-Received: by 2002:a05:6214:29c4:b0:914:cdbf:b6a with SMTP id
 6a1803df08f44-914cdbf132fmr104517486d6.29.1790626274754; 
 Mon, 28 Sep 2026 13:11:14 -0700 (PDT)
X-Received: by 2002:a05:6214:29c4:b0:914:cdbf:b6a with SMTP id
 6a1803df08f44-914cdbf132fmr104516936d6.29.1790626274189; 
 Mon, 28 Sep 2026 13:11:14 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-914399d5002sm79815646d6.48.2026.09.28.13.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 13:11:13 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v13 1/5] target/riscv/cpu.c: remove 'bare' condition for
 .profile
Date: Mon, 28 Sep 2026 17:11:02 -0300
Message-ID: <20260928201107.2049458-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
References: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abac9e4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=GhL2bEVCvcqOW28JNKkA:9
 a=OIgjcC2v60KrkQgK7BGD:22 a=xVlTc564ipvMDusKsbsT:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: JhYBS0OxmeRMvTtTmTx-b0VKkxmJq6E3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfXyy+RoCt9amFR
 bmGfUNBdIi1xPBHJxhYi5Jui93socykJLVVxEoM9HzCSRdi9QzlbGOx6/RXq6JxuXEvute521jp
 3KVNwBiI2KawNVSPenfL64+DaKItj/kIPhQqU2h13MkXPYsvUPNnyCi3qwr3vHyugrLNLMoKJCT
 AXSol+CdSyp8e6a68Gb09xKiBD8d7BtVvEy7ZPJoPTDmCGkYMadbvU5pAHbfei/88mPuoIwlk1M
 Fa7nMbrT0Kzc3Gvudqje2MrHuxt8SUVfO9dP5L1iyQ8gi7+yz0pIJtbHaosvAu+KNGZr4eEJfnJ
 Ubi4pz8eFyttV9RQFCdv5zBnRCDBkIlN0s11pzv48ddRtGQtxXGF0o9QotTRDcHDTrOffiU/5sj
 TsaBoQ4ueyfNARfIOxMNLuOYRLJVIruye0IDiOYd23n2SOH+rVqhsdR7h88j+JGGzXzi5hC5kBn
 y8EjkNM9tiz8rEi+vGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA4MCBTYWx0ZWRfX4Ad9XanuyS3K
 n6e79/fIHv45HtOp5xbh1LPMP1XMxZndxFyde108by8dUZH+UttQhEbuXXE2EuNqj7YKV9GtYJk
 OZwX1RuKcUTwjiuMexhfBmVnCZx2Vw0=
X-Proofpoint-GUID: JhYBS0OxmeRMvTtTmTx-b0VKkxmJq6E3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

We want to configure other CPU types to use profiles as an alternative
to adding every profile extension explicitly, i.e. a profile is nothing
more than an extension bundle.

This means that a vendor CPU can set .profile=rva23s64 while having the
same handling as any other vendor CPU. Same thing with all other CPU
types.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f5490c81ea..766b9424d5 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3107,7 +3107,6 @@ static void riscv_cpu_class_base_init(ObjectClass *c, const void *data)
         mcc->def->bare |= def->bare;
         if (def->profile) {
             assert(profile_extends(def->profile, mcc->def->profile));
-            assert(mcc->def->bare);
             mcc->def->profile = def->profile;
         }
         if (def->misa_mxl_max) {
-- 
2.43.0


