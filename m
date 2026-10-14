Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33BCC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3fv-0003vL-1t; Wed, 14 Oct 2026 14:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fr-0003uL-8s
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH3fp-0001zA-Km
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:25:59 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EF4En34167064
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VBs/W/maE4T
 OHR15R+od0gMic/fqSD06bHPzgrW12q8=; b=JlWk6kCznV5Z4TcxgJy+rcAodaI
 XNvn4waJEJQpgE0jZT17AELWUVIT9s1WNTkE5eiyX3W9dGOCDNa3v8qIiSEPxX+U
 trcksAHOCrRf+qQBwUZ775ryem8MRNFq1waxqzjTF9sflvzDZ98sXOt1VoqpDEm5
 grfz6/yDKD/M14+no2bw8lzZs3Rhgd3kARk/J5bAiXC0+JC+XIocmEa9G+hs0+O7
 0EyrRA8A7/DmCHuyYOUfE60ICX5PRnTyJyidtO5yPzthDvih8WJjvjFTaZ/EosXq
 n8JtXym/yGQTlGA/VbNEe8lpXnrTg2jCmziIw0Mf0SucOo5dbELXr3S7b1w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac230thc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 18:25:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so3989697eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792002355; x=1792607155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VBs/W/maE4TOHR15R+od0gMic/fqSD06bHPzgrW12q8=;
 b=VesS0kZa4rrwYZyGQoRVwYvm2K7o9QXArT3S8m7m74+GhLpug2SLs68Qor9wT1aidT
 m7VX/IypKqwjpiIR4x8nz2aJe42RBRrkmKa0SXdu+qqeR0JHvvNsnDu1vuahrFfcAPbO
 fj5CnwM597U1dx+OyGkEEN7yKtTRDc2srxg9q9gDqGD8MXxTZy2lEkaa20hm8zEABHj6
 awkdM87cfAyqZ92EFJ43upSVYQ7tabDDGT10MmYEuOowCAvElzEzC1hK2+TkwVrwofs5
 4bjXT3tcYJ7gHF50jhDTfXQ4GUuyJa9zJTePSWSKq++YqTpRP1JdgSrIujQRx69SwhTU
 kQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792002355; x=1792607155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VBs/W/maE4TOHR15R+od0gMic/fqSD06bHPzgrW12q8=;
 b=VU8PfUWgsag4Nvd/pJQWBhJ+7PBQG/56oqK9oua6kA/kbQbjryG+K4YIEWxMUe6BK2
 FDZLVhFxjQBmc+6ee2xs+a11cfw7LgYmKE1FEkXJIq/KGVKiSV/TK1y88f3DURVEVe+c
 89dnnb+aOE/VMhyy2telUOhLYxJjhuICaOihCozP124szFWU3DVIeCnVWR2D8vlXyt7x
 zsLWxeXQDjT56hZLE47KCPx+01Fr2pwjrRmxrWqnruwzHvEOpw+mAKJQL+MmONFmLwik
 szxQvy9gs8J1yAK48DxU8+1bDIEW79eFMQixAHKqBq1Nh8kbS4epDRBjJoSV62fvYMIr
 2/6Q==
X-Gm-Message-State: AFq9FYLKlNZijAdbVL9e7zZa34N90nDJ/9jqDPME/ReYTqUZi8baWPiu
 i4N5uF7V1ibaICGI3wmOAbh5OokXus6xC0ZIicfpdJ99f/Tul83dv8S0IO7UCUrVltUs76I2dCt
 R+Tz7KB1y1mKvRsoguvz2zJGm2+XeLfCE6/Ez6a+qteVqQPR8UfNXqhw8Ur1wR+AdAQ==
X-Gm-Gg: AYBFou0SMRLNiMSDx0ugtzizPyxA/NdeqL82L4m4/0+93fQPfQoX83oWA/EfSfYBPXg
 THsDt9hy+tZ96i3Nud8nhStYA4kOGRtv0sh9whJJ6rmemHt9FNwllZK18UGD6pGqpoyn9wxRmJ2
 NhPCsAZ6n3BqVh7x/NFwklc+c1/7Q9sog0RQJMsVNJrACfpnbcvyTuD9fb+aHV3YhAyOE44zDP2
 RghxAc+QTPJSufuwbxcjPpwF+E1rV/gxtHnnsY0o8QmyRKeTuI/7XknQm7z8c0UNey78li7TK+g
 YAYycVU65qV1UXznvAf76uJS5A+Ga3M8WB7EdaCL6L48VgFF/HaFY/pLSq7D2bPhGpZeW/Wo6Pt
 xFyttiIbD+DLiFXDdqqB3Z/8S9EPQTgH5Bg6TF520XD3ZsHYj3YjYf+KHULX/
X-Received: by 2002:a05:7022:150e:b0:15e:6541:3099 with SMTP id
 a92af1059eb24-16a5e49fe20mr24595373c88.7.1792002355265; 
 Wed, 14 Oct 2026 11:25:55 -0700 (PDT)
X-Received: by 2002:a05:7022:150e:b0:15e:6541:3099 with SMTP id
 a92af1059eb24-16a5e49fe20mr24595329c88.7.1792002354533; 
 Wed, 14 Oct 2026 11:25:54 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a442956asm62348223c88.16.2026.10.14.11.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 11:25:53 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 03/11] hw/hexagon/virt: make machine available for hexagon
 target only
Date: Wed, 14 Oct 2026 18:25:35 +0000
Message-ID: <20261014182543.135965-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6acfc934 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qlv5defmNkfQSHP61AAA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX2FfNh0IhiTjS
 AhgkiAMrN3OqNga6yK8UzCZSBjnLy+BNAU8/0GUG5QufdfTPMg9yj0D1Hig9UEyLLxGvWObVqCz
 x8yAB1owiLRcrEWAL9lUA2G0qfmPsLk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3MyBTYWx0ZWRfX/FG/WN+cK50H
 gr4YuQn7NHjh5ZpRlLaAKKxkAGzlQU2OA60QGaWQNaAsDRd3bsrm/PaOvGPG/lq67b+CuQpUoB8
 A6zKgQmdfXV3AcDa8heMfyZOTkB2WuTMM0/xJh2zmEwowDGqQ7O4aSmNeow/ZTTkJqTrqmZkhTr
 3/Xq5N40J1TsaA5C32AfnSLBLL8rLQpqAZFkJH8y1U9rsaoD4i9iPk70VdwWTES8f3/BlHE2OJd
 GXWb50k0CHosc8s+5AGVClytfPiywf/CIWBkzfXTb15Cud1QhqXFcG4W/6b2d4NceT4CgBbAlUZ
 p1m3Rgh6cr87n/cI8RL/KERZIKh5iCCw0ogUmWexYiCD1ZsnOhOUjBehDbpfYY/gxwCbCchmv1d
 UkYRu47w0QyyJmUkgVAO7SiH6yLgTWP8zXhrXaFoeFeWlMK35aXdKXr5CRQdbvBvLFD5esILjfX
 6g0vJUpfXMIY0sP5wCQ==
X-Proofpoint-GUID: pNAwxfamPW7l1ejFmXGc2ozEEE381Dcs
X-Proofpoint-ORIG-GUID: pNAwxfamPW7l1ejFmXGc2ozEEE381Dcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140073
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/hexagon/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index 64d8366d27d..b601cd77a92 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -20,6 +20,7 @@
 #include "hw/core/register.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qemu/units.h"
 #include "machine_cfg_v68n_1024.h.inc"
 #include "system/address-spaces.h"
@@ -379,6 +380,7 @@ static const TypeInfo virt_machine_types[] = { {
     .parent = TYPE_HEXAGON_COMMON_MACHINE,
     .instance_size = sizeof(HexagonVirtMachineState),
     .class_init = virt_class_init,
+    .is_available = target_hexagon,
 } };
 
 DEFINE_TYPES(virt_machine_types)
-- 
2.43.0


