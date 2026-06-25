Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE01CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrJb-0001QY-J0; Thu, 25 Jun 2026 17:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJa-0001Pe-1g
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcrJY-0000Yy-AN
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:08:49 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFdprW3872196
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Q6hOnWB6ECl
 UN2F8njg4yI9C8zvRBFZLFvPujD11QPo=; b=Ww6o3jiWk1Xfkj/JznpA5Fj9Nz3
 HGDkFp1q3EGXqqYv1tXhug2PwyLhxFANyfzpSHXfQS5yd6IfyTicHqDTGesadIbl
 RlekQGVmIO927vODeAzI9fSm2KQRU0ppGyPVucoHE8jQZUmm64wuWwFlLp5ZZ3f5
 SgTVXa3QZRD3YcC6w2WGxuO2COAXbbabLwPihV3O7g9oTo92bGWzV1Jofptf5H/t
 NVSmul5jVSviRxnZwbkoZ9qiFrWAO3B/rP16E+vZWiUG5vKIXQC2LCmRyClndKEQ
 rJi8ZPDVgiOStQ9vzRmDz21khOeaYZLK4hC+PyXjKDjKjOaEqQPP/Fgnw2w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yynu7rt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:08:46 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8db3d8c8c0bso7308516d6.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782421726; x=1783026526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6hOnWB6EClUN2F8njg4yI9C8zvRBFZLFvPujD11QPo=;
 b=Ac5OYi0jCBioa6G2GJ2RWKBBzBUXZB1hXWgdba5C8CzENzze1nwxyTdP3Bw4JzGQ74
 /3zFPy1Vrh/qu4WmkKD3WZcYQBlR088NVqsgkxaAWRVqNf6Gt8qKbjms9zrAXkn5Z8eL
 YbKoSUqGCLemcqvaCvpdO6gwM+R/kw4fvehoXJiO7pQEOMJ3LHQp5J9ey9NbjQeqIn3a
 YdA2L0m77tFyfKdJ9k96uRSWh8XuRFbkxLcx59sPg7oLpcxfxDxssf9jZIPTbRHeidkW
 WwsncRp/GgqcGPILZ/H7SgL6gpaUY7gnfsAZwWBvxrlVsvVSzllUKPWLchBpqWgnKGKi
 bz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782421726; x=1783026526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q6hOnWB6EClUN2F8njg4yI9C8zvRBFZLFvPujD11QPo=;
 b=OKfgGyfR3Cl3/zAcCStgcl7XCqBpDzE4gvGE8BmnmuC0quTF4QmpcMPkrM8U1x28V3
 NcXP45hFSPEr0CeVCw71JJhZK+MnPW/QRayXBjHtqqZ1Q3/p54ARxQ9w7IRRqjsqZbzh
 9aL9jYuZIY3B/8GLGZCm0438VTeqxX+eNtE9V7X2ereVNESL+Mv/yLiQRU3fEGB7ebwt
 X7xZyZzsNwOvws7kSi+HuAZgcKT7FW52+QC1V9fTAtqQJUWj/TVpdM2vsTIww58SkjQC
 X5Nt/w3D5fgSsQr1dswIVyz13Wzg9gJD9eB3egWrbHMpEYfG1xuKSZBNfStxxcWrrUjW
 WVrA==
X-Gm-Message-State: AOJu0YwCoViyzpX4O7b3Dolkom5k4+iYiYbZzufgxYWqaXa2jcCI1R0C
 nIK2WIaOHHBRA6auJnef7IdxIhKxOrOjou64cdOR5setuFYaKxxJI3KhYwKl7tA/lLPlWk7AmH9
 UYKMcMVez79+0hbDALh/9ZpBvbBMD0yyMLpwAGink4hT5sSxJaCtSySFC9BkGkl0XWw==
X-Gm-Gg: AfdE7cnH9PZSXELNP//ls14l4RgIaQbnQTTOcVIY6JHif3eJewljBlbkUhfxbZJ1Omc
 IGvAjypJN7k0u0RHsG17hgStJzCHFlMby9Ur23yPeS6tVHf8F+o96vcoRM7K3fW++nG0uECyYzw
 Yqzg5YK9p80FkAEfHlEiskz3nlESd/gFzmrKMLG6lm1IaKTjU4ixvZTLNZlcng8NI8YJtSjEbo4
 SdhtLnonqu2JO93wVppzOBT316iiQon7TQRVuPH0PZ8QCsunRv7BctA6LCtZskdFkJ/vZ5LO6G1
 dc1rarpRzLGQLkvTZWW+bexYxSi+HO/F/QBSUuuYSkc4u5hw554kmsRNEYDGxwT3x+P3VqppvIS
 cSlHJ87LbmkUp/U19LiayIX+m9VcTCH69pbelq20nqW0vog==
X-Received: by 2002:a05:620a:4613:b0:915:6cfc:5018 with SMTP id
 af79cd13be357-9293d4bbd52mr629299485a.58.1782421725830; 
 Thu, 25 Jun 2026 14:08:45 -0700 (PDT)
X-Received: by 2002:a05:620a:4613:b0:915:6cfc:5018 with SMTP id
 af79cd13be357-9293d4bbd52mr629293785a.58.1782421725252; 
 Thu, 25 Jun 2026 14:08:45 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ac1acsm920733485a.32.2026.06.25.14.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 14:08:44 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 andrew.jones@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 2/2] hw/riscv/riscv-iommu.c: make FCTL.BE read only 0
Date: Thu, 25 Jun 2026 18:08:33 -0300
Message-ID: <20260625210833.3294437-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
References: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX2x814Dpe8pT1
 AEDXrwLB1Ysjii25bW/rY2nKI/VAyRwarhs1iFy+bW4760jQl7HdhehhkWELab2lZX1VU6r0K5c
 i8P6fLl85pZZq4+zXa68IEtn5weJuR/8+MEsoWkM6qfesul3dV1ZDwUl5awACbibtydHPi0SNlx
 lHYwAAPMn/fQE056ZotkZjwlD4zzUtSclc/wUhthA4C8EX0VrZ7VzbpmM4devCRCTgobRBHk7N8
 qXJMbGFUiEOla2EYRB/Fwm8Ge0iU1kpfopKtCVGUqGrnM0S81pHn5I7wxiuF7eoNry4z6jEvysa
 +Bmcy2GiVl+1CXxTc5b7fPclm2wlll+5yjWa6gnMuoI1DyPS8awaOdsiyqZwL1fqN8DOuB+iUVm
 2jY4nV9JYMQv/kk/c84v/1rREr74w+Ol0DlEwdwCWHmUl4eOumYev9TTWPTYgQh0tNzVsiAFcaJ
 ZxzVrDlAVmgBLpcXksQ==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3d98de cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=y0Gly9JQx-F5jikTsYcA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: wVZKrHYSYXKg6ISlLMB8Mdl-HD76T6FU
X-Proofpoint-GUID: wVZKrHYSYXKg6ISlLMB8Mdl-HD76T6FU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE4MyBTYWx0ZWRfX3s6yQrNf5PsI
 BHS4BhvgendsKLrlnBBJ+dBOVTaktgPOhrApY2vW4g5+iHSnWJTcdwaBwlejO66Z47RGqGzwUt6
 LrCFw/YVMNYnGUx5wkwoVQxNQBi8RSI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250183
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

We do not support FCTL.BE equal to 1 hence do not allow this bit to be
set by software.

While we're at it: the riscv-iommu spec allows FCTL.GXL to be set freely
and we do not have hardcoded restrictions on it, so make it writable.

Fixes: 0c54acb824 ("hw/riscv: add RISC-V IOMMU base emulation")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3576
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/riscv-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 30f16b999c..c9687e01a8 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -2609,9 +2609,11 @@ static void riscv_iommu_realize(DeviceState *dev, Error **errp)
 
     /* Set power-on register state */
     stq_le_p(&s->regs[RISCV_IOMMU_REG_CAP], s->cap);
+
     stq_le_p(&s->regs[RISCV_IOMMU_REG_FCTL], 0);
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_FCTL],
-             ~(RISCV_IOMMU_FCTL_BE | RISCV_IOMMU_FCTL_WSI));
+             ~(RISCV_IOMMU_FCTL_GXL | RISCV_IOMMU_FCTL_WSI));
+
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_DDTP],
         ~(RISCV_IOMMU_DDTP_PPN | RISCV_IOMMU_DDTP_MODE));
     stq_le_p(&s->regs_ro[RISCV_IOMMU_REG_CQB],
-- 
2.43.0


