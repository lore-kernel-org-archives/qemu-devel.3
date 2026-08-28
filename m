Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1B9C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xg-00009Z-G7; Fri, 28 Aug 2026 18:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xf-00008l-8Q
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xd-0005jr-Gg
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTn0F3666826
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+1VSVSBxGg3
 3owI1wY/Ik+9RAK8tassq8FGXU807x24=; b=k5r2rShIj/CI3zc7emwKIROSNXG
 ZM6qq7iLhGqPn6qE47etqkmWwJDoipbUDRQHlFHxOzm/vq93FNpyS5PJ+DwE1zd4
 3y3ugPq7zdx24W9/06ZzOtmkcG6hJn9E9zceh6tHCE7xwLWUratqnZG48bBZyXTO
 kCYvlxXncODclKMLcO38ooZE4bb1ioq4U/XamsBAbjvedb7rayToQBubd/L7mS0y
 eVIk2qrmnaleCCjrv4n5OuEABiXZm8fe+UZhRgFc0n/3ya1kgwT08MurfrvqT8ut
 iQszut2oA1lGtfxCe5qdY5yOM6gBD7NF+D4EhOpSEa9QZ8an6tJPAvFu8cQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubsvp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39533bb224cso2061829a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957959; x=1788562759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+1VSVSBxGg33owI1wY/Ik+9RAK8tassq8FGXU807x24=;
 b=Gq1fIoZPHWLaDXWdcfeV01twr1t28Hz14RROt91zcH7IjDFTXlp+34OuAxW/E7T0Ww
 NBailTD1sUR4Whbzouy2TMbydG1gkfztXZbjbK06JvtlMnzIOK3TkUaUf4C9QULD+gHu
 raVJBJpDWDi4T7tJfBu9/DeKT9I+uAH4JMl0EyX/k91s3Xlfm11WjN+HbvGSM3sABwMK
 CzydgDJfFD5OKpIPrHkNtC2R52/zr5wI22O9Y8Al+rH5iPKb1q9oyLoZD/WhzIgl1ubM
 0vKmtijWDbcOKDX9Qi1horicAXjdU/zmQPdPOh4R4awDI18/GFHCgHjug96p/boOOGd6
 Gbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957959; x=1788562759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+1VSVSBxGg33owI1wY/Ik+9RAK8tassq8FGXU807x24=;
 b=SQ4XmCn5L5jDSEiLqvtXT8t7fdvloLA32NCOccWNvLrFoT+j687lM8Q8QOOBMhrkDK
 6666JvzumY1O+2eA/zcshnzTPsAJ1TF3i1zEz05YOR1hRIw1B7earFDTbyKr0FvXK/NX
 KtFBUF3Z+YqYriiiZjKopFWnUubfDNGMPHj04xezha63XgL62+SDy3swzqAV25BNvx4N
 Ju1Tc9V+WnsJ8ckBZhNJ9j2fn4K0kxM3h7Tj1ulXMTprUJdiTLysWg4FQRZO1FWzVBmb
 mqBG+c+11NuWfBPLyuqyLHGvnB1ySgbbYmq8bQUZeNYCKg/VLwZOaguZoG0HSkPpJXXw
 r/2A==
X-Gm-Message-State: AFuF++mIbj/GLDrzYmvczFdle4mSEslOdhfkLRvYWjGTFBGQOIxtqMqP
 7RJJsGW/VFZz4/OVEO2dVssWUPMUcsLkqLA+epulAMMkqfXZpxGB2+Kq5II7wIXsjiR8o2ATuIW
 5UzdOKvw1e6cyM5Kn7ul3DQXtKggxp/Q2/h4US/SLM4A6X5DVmrew3DuNEV8DxRIocg==
X-Gm-Gg: AYBFou2v4p5GwZ6LlmT6ue4hKkplDGTRaQ8kTocwO5GpA4XjoXX0YqXhK78LBj4xNep
 2FodTOWdQNyv7OA1j1iIwGQ0DUcyonL18Yu22cI019fqwrxjqsRxO46BfZ8/47ODvIoJmSSMYGD
 YoRAllHy6izGQOikZWASIe1NzP8px/TwIEhj6mK0/ohtDs1HmcNK9fV8FszjhFAcWyZfgRHSRTB
 TQDaIC8Sgv6wEqiEGhdr650Bw7Le7cDrXOUYzOQPa4JqNnlZMw1gJdA19ztakc5JXvvbuO6HsrH
 K8CRB8df9MynE0X8nMdpI6iDNmR9WCcTbHMVoaXdfeNHSfuutmOs697GfMUH3mSPU6WDf32aoB/
 sTbVdikSpxlvEZIgDMQ7y4JS0mLrT2oAopN1ABu/2NGHhNaWfu35W7pW/ycQ=
X-Received: by 2002:a17:90b:2551:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-396d0fe384cmr21541629a91.9.1787957958954; 
 Fri, 28 Aug 2026 15:59:18 -0700 (PDT)
X-Received: by 2002:a17:90b:2551:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-396d0fe384cmr21541483a91.9.1787957957555; 
 Fri, 28 Aug 2026 15:59:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 10/47] hw/arm: filter minimal set of machines
Date: Fri, 28 Aug 2026 22:58:24 +0000
Message-ID: <20260828225901.367438-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212c7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=uqJ8O8kv5ld6GfOkGsEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: zeUVFJnPJckcJQXlnM0C7DgBtPHcO6T8
X-Proofpoint-GUID: zeUVFJnPJckcJQXlnM0C7DgBtPHcO6T8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX+p3LjcXWjbat
 md5VPdDDA9ypoSG178mSZ/+4cE9eE3xTXrmKyCeJm0tZqIW74zpoUFJtIs/R4o7n1a6gdxBtR10
 Ea6ptrQBOf+UQGTHLIKcHaiZYRmebJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX5iN6uTF+RjOt
 6+ULwG0mm37fqRJEuJCW7MgPQXkkUE20TCjhlrODT1Gd84s4VjJyyR4vvi2TkFGnwvhedOljmzP
 YaL/6oYgAl9mV/IqK9nG3h0xVowJaAwPaqvTl/ZSQWTMZtebq81WCsLMpMwG3Q7X9bDKJ8m0nKY
 nQ4zJm3sk0ssY+ySqWmPA2xJfcEiQm0uKHy8Kkw/awWJd6BWL6/XSLdrL+kQcqHbDOr20R6JTeL
 r/ahY4WLMY/23oip8KbqD+xlYLWMq7VEg32Tiie28TjKCVzKJ1MfDLR+z62n4iJKyqXj4u3xVt7
 o0DxpSmVw2e+N7mS8yfd2bNBfOJ8cjVajF8mCKOfBet4OhgBEvCBNGker76R4d8v8fYYrbuqeUL
 i399tIPiH7QotgLnnVLYpYOqfs05pi+/ho/OsfPGMiXBupTaQhCm7QzxwNi1rRhI14agidUL9EM
 /S1HJ1DxQJ/VHN01UPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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

We are about to change the filtering logic for machines. These boards
are impacted and already are conditionally available. To not break
existing binaries, we need to filter them accordingly with new mechanic.

From there, we are free to remove the previous filtering mechanic
without changing any existing behaviour.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 1 +
 hw/arm/aspeed_ast27x0_evb.c | 2 ++
 hw/arm/raspi.c              | 2 ++
 hw/arm/raspi4b.c            | 1 +
 4 files changed, 6 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ceeae336df1..54230aa92e6 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -235,6 +235,7 @@ static const TypeInfo ast2700fc_types[] = {
         .parent         = TYPE_MACHINE,
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     },
 };
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0ff1bebeb0e..2b767808e12 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -76,12 +76,14 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a1-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
+        .is_available  = target_aarch64,
         .interfaces    = aarch64_machine_interfaces,
     }
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 3f99e87428c..bbaa20bd630 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -407,11 +407,13 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
+        .is_available   = target_aarch64,
         .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index e1595a875fe..2ad561fdcfc 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -126,6 +126,7 @@ static const TypeInfo raspi4b_machine_type = {
     .parent         = TYPE_RASPI_BASE_MACHINE,
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
+    .is_available   = target_aarch64,
     .interfaces     = aarch64_machine_interfaces,
 };
 
-- 
2.43.0


