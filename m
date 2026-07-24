Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9B1C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UU-0004m8-4q; Thu, 23 Jul 2026 20:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UR-0004kW-PM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UQ-00067t-5m
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLe9xe814517
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CfTg80cvRFC
 VqXiQ+LLZ0yC0F2A0xAzCXxrkiVnvXxk=; b=NkZIIdYVme+M/tx7zKNCkbx2QTV
 bw5y4LsaO/IxlJzo/Jh76XW7AJpJGlfJmv5PAtsPqQdknBAX4/64G9I4fKZ99Cnp
 S4+h9GkiE6ClPZf3glTj4mZQj4DeIN6Qz81gLZQv2hr/cTz/70xxfqnyEhFJfhXb
 bV8zyPrEsTt7i3vlGvXYucHkTcu6Lb2VMj/gUcPPKHHYA+LjXOoIxGwqEsx01s3O
 Dojj9lnpOZ1CGsBIvNNHz8ZdzN3KXPB40cyMyxUEuHykH6iulau1JpsrJyretl57
 gwMJjCRZqTvvz+TRcymiudSxfDK7kVbLQqozIULZmocTp0IypktMQCEPz/A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqajsaxu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:08 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso2658318a12.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851808; x=1785456608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CfTg80cvRFCVqXiQ+LLZ0yC0F2A0xAzCXxrkiVnvXxk=;
 b=T19dMtI923B+Xzf5DmNHDc33EdWF8s09Rgccop+4gKI09H8hfURUw6WswIscNzOf8g
 u98WWuAk2ndafTJWt8/S1NL/u7gKI7z+zfB9l/4RD1iChZT6ZDsYrEfKqUbgQou1zTH0
 OWfn2+pSrgIMYxYc2XHxTB73vs1E/D+OV5iJ7viBnUWmoEPSBOzvVdFLm2I7iKvnsZVw
 urj+m85BKd3wvz/ANU0vb7r/Egj0hFmgzJbXfSEtGqpN6wjuBglkUiTxUHHvEjDZcbKw
 wzu31+Q4lE+1Qie4VGKeu5SPqxXjDV23rgKVPukwvOi0MNUlUUMq4QEu41RKeqNRBkti
 J39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851808; x=1785456608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CfTg80cvRFCVqXiQ+LLZ0yC0F2A0xAzCXxrkiVnvXxk=;
 b=aoGXJq2Ad/kn44wgfjbvu+fvHwabCItlhe9yL1IyJogUAbeMGNdS/8ka4x7opAcEj2
 WV+I2BMam6N8I2Ic2B67dAW/8vdqueMxs9QjM9C/Rcsum08+zN9Q/n+p6n3auS4pHjme
 CreerfIbS9hIqO3oJyQ1caaRCwAaVAsY8cjGxabFtfaCGyxe/kHOVmcFfPApJj9SIr7D
 vdlYc6EuD4usgDKcH1UTXFwFL0AhELXGL2dteDkB/RhdYf6ojwIIFVln7QjGsF39mHci
 H0eXNjA/ycGwHVh9uELERFq3d964FHPvdzAVm6cYHz8fzYhglpembk97bLU9IrRGdhig
 yNDA==
X-Gm-Message-State: AOJu0YxWfpIpRRQupVWRCsZDoODYkxsvDqk8xfTK3Jkjb5NqGbbMHFJq
 naoJGLzXcTTGtMngJVe40fn8Llsr6dmKXt6ZkUC3MdTCdBA3w9UPQxQi49EUTbNw+0UdSK8MW+B
 juUcISJf0ao1fFOWrGHsTu5j9RcehmKPYW515TevUE/cPzSRPZbdRVdVR9+Q8bRqNgA==
X-Gm-Gg: AR+sD11OvTKyRod6DorywGpROknk0j6TG4DJ0XglIWN0itAy3PvGXuYL87OTpDW4RRL
 bs0uY4+c1es5KRppnuYLyxU+nEI17IeVoqw3S3iJSOcKbRtac+yDUk+eezOUP1tvUkRb+1+9oqL
 awtsu6fvqufnwYYd5ayFwsoYAz31LOiIH6+2xWsd8TQZX/dT1T+uvK7uRYnRJOhx0a0Js63EyAb
 cwrsbUktIMWtb/pe3Uf51MXS5mhckB2fBuRzLDlmvHM9tWnNI3lgfWlScBLIohuBe/L31XdpnAI
 UQB6llERG9mym3FAOqjTo7C7cjDNiQbBowYAMQmXepBQFG7ZNdiFSPDiJkWD7YRs6WZzuGCQbps
 8gglYOrORGMSFcSt2UpQ9Xp6RgZ7vpViwGjerNusC9tBIRWbuZESWbZYRNHynOq5F1vq5P2A=
X-Received: by 2002:a05:6a20:9147:b0:3bf:6c08:2843 with SMTP id
 adf61e73a8af0-3c44b1e49cfmr5626786637.50.1784851808287; 
 Thu, 23 Jul 2026 17:10:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:9147:b0:3bf:6c08:2843 with SMTP id
 adf61e73a8af0-3c44b1e49cfmr5626761637.50.1784851807879; 
 Thu, 23 Jul 2026 17:10:07 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 09/27] hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:29 +0000
Message-ID: <20260724000948.234657-10-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=6a62ad60 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=8wwqb18Pi6YFJsFQidgA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX+UpVaVHo3PhU
 Od94PpdQeLVGLNrftBzAb2zQ4nKadbmjtkvfZvlNkEtYWkJLvjXxN8AUEohzohXlehRW94Vi/tr
 omaAHX258ECdo5WDc3VtQ6PVn0ssH2sYyufQet9iX0MKqrMMXPnHjx1bMwqrmBVwxujZJisTnyD
 wgIIqCkFdu6VDe2/4c0fG/AAQuK0Cd1dvDMhS1QmO5HjQxl7CLKtZ2I1K/uGCvurWvvZiOpdLP6
 3AZ7p+XhbkQ8GUYXs8H51A74/1SUE3kYk6d/0XZwNh6LK1g/o/vzvkF+xKuqAxppZe647fJE09F
 38UIc/VIV24EuRQaXwntiKVAMC+Q6hP2hsrMEtt1PfT6DBV6mmiOlB5n2yslyt7yc0rSjhTc4lJ
 pT4D+93XjExvA4VratZQR8OBItW0VEvnI+8iizWkQymy1EHupS4zJaUCm4hM9NorQhEGvNfmby3
 smlymgMS5Wsq/An+Nfw==
X-Proofpoint-GUID: PK5QjkFRxRJUhkgKCTjp10hUcyMPh8xO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXyUCMqIK51iXA
 qArIUYVfPWgKPF1PVYiJDdK3twXSimPIvQ4Q5fezjd4jKcSQPPOoTmxNf3natTQJtPC48xpp8yD
 V4GZQLtrclHXE/GjUO0u2S8/ojP0cds=
X-Proofpoint-ORIG-GUID: PK5QjkFRxRJUhkgKCTjp10hUcyMPh8xO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
 hw/arm/xen-pvh.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 10cac28a910..fd83fa5f541 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -51,6 +51,7 @@ static void xen_pvh_set_pci_intx_irq(void *opaque, int intx_irq, int level)
 
 static void xen_arm_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_config_xen;
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
-- 
2.43.0


