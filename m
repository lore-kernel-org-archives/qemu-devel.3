Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D479FCA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBje9-0007i0-Ae; Tue, 29 Sep 2026 22:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje7-0007gx-G5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje5-00037n-VG
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:11 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPglY2969036
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6YkApf4hhXQ
 dUyUU9Jd3OQCLpkoOudCdii2FjP/Bloo=; b=NIoNCs+THBPVY+i2XMAJOSylMkX
 VKurPVEyR/KxpQJBTpOkHqvSA88anBC77DRpNXAfTa6OU3AONNpEEOrKB7wRcMtz
 kLVdBNZ1TsVbZe2PfzZWMxyT4WG5mSR3vrolcPoEv1kmI8ay7BP6UlpguXdE3bS+
 r1oDM0QvdoY7z8eeQuRRYwAhFf477F3Nn668F2+7Oyf+TlJHZtemqsdRMISDdjur
 go6bC3z7GxmXs/2Cjt2XtNow0ldUdNt9vJ0TME5P9N1GwMndYSXt6+VvHsLSwlWI
 R3rTsHK5zVCdDEZ51g5dQSXCnDwCZ0wASGTkeKfiSAnM3kmQtfpHE6xWZyw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfa8yng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34316295d86so8418729eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733728; x=1791338528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6YkApf4hhXQdUyUU9Jd3OQCLpkoOudCdii2FjP/Bloo=;
 b=JYNVmT/JGahZp4DBpxrtnMJkYhFlOMXT6Ghqug4zi/Erbd9ghV2tzgMu8nupk5asgK
 yrsepHMifYw7CfLIfgwPorF8IbIqkM/kfeZWhGhQtwnTLxad+yEfEqUdPqaWvj/SVlAj
 E1cEjvdRMpyx3a2+KSlmIsPb5zFka7uAZWE9+Zar2nmiX9hbzDi5pyQtiQAGMYdCC/pM
 0kCfhH9NKtunjOaKiD0300aaY6CC4AvbjNepVqHs5ksSwxOPqOTLyXbmb60Pqdkj3GM6
 yJ8iZddmh3MNhkRPUDXQaD9ZnEoZHJvfH/wlEpXBacy0pz+DcKTdUa0BjGm9maNTIkwx
 kFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733728; x=1791338528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6YkApf4hhXQdUyUU9Jd3OQCLpkoOudCdii2FjP/Bloo=;
 b=f+oIEq2EqFov7hHy86LKw2WyVbekHiRnvVZDefwPrA7/Una6LgFHPHf3w6MoIkXZI8
 0GvFCq/XYeTtUv/klgtjDG4Q4tFCFL0Qqovw9YPXKX5Dd0alZTpghW0sj009S94WadFG
 u4q1sydF8Xh0WgxzbALbeizUQ2us7jdc4nMxsT7nlvBONXDnO8NJrlpdyExZdYbERNj/
 jthnGQPq9vNyE0uLLS4P6OhBS9Q0FAdFnYXmZtUumGk/VFJHJlnk7nYHhl+0I8mK5BzH
 PF0vB4VEVerGde3RZwgrsvbnXh+H+cv7WK6SzkAj5BlR8qpXiSHalc11XirVz1Zz3mzk
 jD6w==
X-Gm-Message-State: AFuF++n3nxNZfO5O+Vm2mXMY9CzxhRS5TiTRZEdE0jdnHy07Ic/2Dr/0
 Pst3lu/bylLL8o5saEeWRH+yPR1rHABAsDC7Omy1+AmE+B911m6xZzCAIitWlyh4D+BC2UhzcdZ
 idvmuDVHXP+mh1QQAMaXFe5ADBu3mXP7jveVjzaWH1n/aeede+uBRYJSkhqGISnMfMg==
X-Gm-Gg: AYBFou1HvgqWl0WhH45V19Klsf012AJH/ygGdfSHVxj7HUKadOsgGQ0s8VZZFDqXXFt
 eTwYqHHq3i2pYvSsriZiPN1qWn39Yfe9eZRMROCvTJNKUq0ABEljuUBM7r8NDQpSDoXKQD1b6za
 bavz00N0/CxJryvUGU7p89abhtTflY02DbboHHJTPeFC0QCRy57UG3Btr8w9sLaCywD2LviXSfa
 yOhSbmLyzC0A0zj2zu5N2ftWIluoArQQw2lzjN5hYf6MCoeeIVbPS7CLgk5ndns2CkloTcLo/Em
 d7x+QH2s6CZcuGfwvDIzEXeiGbH6E0ftq0cT8uXK2UfvUF+eDm/0qgGB3I7CanKrSGgJcV/MNXG
 tqRZGgNshhTPZAdX9aWRb90z/rsupMsBngB+tI5VGTzCsZAMwgo6llWIykxdf
X-Received: by 2002:a05:7300:f149:b0:342:56aa:67a6 with SMTP id
 5a478bee46e88-34cdbadaa48mr124274eec.7.1790733727592; 
 Tue, 29 Sep 2026 19:02:07 -0700 (PDT)
X-Received: by 2002:a05:7300:f149:b0:342:56aa:67a6 with SMTP id
 5a478bee46e88-34cdbadaa48mr124251eec.7.1790733727024; 
 Tue, 29 Sep 2026 19:02:07 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:02:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 19/21] hw/or1k/virt: make virt machine available for or1k
 target only
Date: Wed, 30 Sep 2026 02:01:06 +0000
Message-ID: <20260930020108.217892-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX0WEx9YaFWkgd
 MfFe1WJt72LLU1nWl/z8RUY+6SLMSn15eFhuI9NQxXXQlmJrPz7WMPZf668ZGf2W4BP++s8VDcE
 UuGO9UKP9gxpAdNGR+/gjgJHONtcmVp0FVC9nIAAmAV95AL2Q8NCrW24bSRqjtMNFByfjqhf2th
 ZoCS7+sr/3zhEqExSrWh0LbAG2T1c3gVIGNhvcBlbrFwOCvNaON1nzMx+LiaXiJuvcUt4nf4CUH
 i8V1pItA+Kfgl4YV9IK7p+vvEKibD9fhPgINyJWavp452MjOrU3sS3OyubfbJ7YFwt4qSczlMkn
 8/u8PQSYLtOnARjNL/bYkASb6UDVPCvKGGjj0GPVZQMDUDPJ8/5/LOfZQWxqCySN13BKx5xsnkI
 uNwrwb5iZwRzIyhyHR9lE8YWNhLl2LDrp1BzR97hiFquuAuRx7XoSCILZMq15dhXe96gEis5cFi
 CytGE2mnsNk2Jn7OPHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX/JsE4elYRMD9
 tqrKikDze9j445KQlcnlIh0EDdd5MNrezlS32uCvHJ2BCW+BPQylo2NpOdreKKvU1RtQBPT+u+u
 98gpeMI+okliT3Cj4BjmtClKuDNpeE8=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abc6da0 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=EUh9dpdD1nl5Ug-eZJgA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: xtSPtIHK05DoZ5hnpqrvW22xM0iOv-FN
X-Proofpoint-ORIG-GUID: xtSPtIHK05DoZ5hnpqrvW22xM0iOv-FN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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
 hw/or1k/virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index 2ff5c084a2b..a3ff903839b 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -559,6 +559,7 @@ static const TypeInfo or1ksim_machine_typeinfo = {
     .parent     = TYPE_MACHINE,
     .class_init = openrisc_virt_machine_init,
     .instance_size = sizeof(OR1KVirtState),
+    .is_available = target_or1k,
 };
 
 static void or1ksim_machine_init_register_types(void)
-- 
2.43.0


