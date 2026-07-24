Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C66C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3V8-0005G1-UN; Thu, 23 Jul 2026 20:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3V6-00055d-5k
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3V4-0006Cv-Jn
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:51 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeX9M1237315
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y2OXNAeZ73Q
 qSKZacYfO2UP2wrJF+Su45xhIAcTRmEs=; b=chamS7HpzgVAsZ6FvZbszrZ8O7l
 /n/VgHvEt8pJxIj0/DL4qRF43Ac0qhn7vRsyk1pgsG66WKEEAlXXo9B/RRkL5Tcy
 yp4Ale2mWfuwBk1Oeqf6apIzjhbaRzBK+1fPNplBXYS7yzbM5knYd/vS6q5xXeL8
 HEgKXWjnlHxda35+M5UaF9Z5wSWU5dyzrlaxAwSrh4Cn8CO8yEH6ZeIUPaGDB06p
 /FKVybx3kr1E+LlIMCQ2xPlnA4015lQunil7/XAh2qhZEcwzwjo4AQDuqH3+EaQu
 h9Eq5IL5Hx72y8HGftnNAv7OyHsRLuMoAijMapDQJa2slp8XP+76Rm0rTfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkp5vhqnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:38 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso24683115ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851837; x=1785456637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y2OXNAeZ73QqSKZacYfO2UP2wrJF+Su45xhIAcTRmEs=;
 b=NYsePYLXWW4X0vAA2fvpKNB8xK6VA3iQ/3Wq8znyHXJXJPLCvxhRg7Fqkd150Z0qvX
 M+XtM+0/BrdUebXKWWYGCbPlw2QSraoQDgIQuU5ljGM/E5cjZXSzgLv5W4pI8t7uuxN4
 /Kk7AZW4LLrtay+KMWKAE3D5iNVwIuCDw1yt3Rj3i1xSfMMpoVhasw+aX90j+lF+kui8
 Wuu9XHn6BbMRpiKnEJu93IxamAj/0Gvd3o9lhDQtvOsBO98Pkzpl5lQgQ0FL55DHvGlR
 Dg+P8v7bwMKxDGwU0HR668GbKhJCDzqln23TMN74usa4ronCPRVENxifwAJ+WeV70022
 KzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851837; x=1785456637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y2OXNAeZ73QqSKZacYfO2UP2wrJF+Su45xhIAcTRmEs=;
 b=SIklTQx/Ldj5m5ffx/Lbof8dpAypwkT1ylxd6dvbWQ0QLregiL/rEXLazxUMqj4ttS
 BhsO14pl3G2KBf4QN71ZTTArUGoFsH5qrJHHmv/ewLSRc9jquWuten3RcNfb6lrwBt4k
 ZsFx4zl8gj+ifR0S349asVZCKu2pA/6JzsSC4377FYV1/8p4MiQnWZqZdiORViEeOezd
 d++2WlKVPq5R2xjIUPmtAwNEQ69a2fsCbVAYYwbd4pCWFZTyDCJAQuLQdI1AWOne+QEs
 jjCn3HpXUcVcxwBxhnMCntY7TW4NcADEXNbtmOqmU9yIlQ25UU3dkVxmN/yw31R+V3Ox
 c41g==
X-Gm-Message-State: AOJu0Yy+tcsc5OUn32r5VBCu2i5nZm5HFMmHnb5O5lHtIci+K2rStQKk
 Gnxw2ZdpYdbpQQDtnHJHA60VqwJCBGIXG3udch6s17hKihJeX7HYA1giunHd8p3fixoGDnE67ib
 R66wLUperxjgvS6+1YgxxjD//UoOwn7v48ZWg7tX6aRmrs+78RHMTJcMv9fJNn0EZFg==
X-Gm-Gg: AR+sD10OSQoY1QzC5MEHeaga4nOVBmw09iXpNem4Ic6X87BMgY7DW4wopg+Jw+AEzh6
 3R2okYdLEhAZQVrOcwRuUTlEK+xLPQaYb90YVGrpjMGkduj6BeO55zpqYaOgf4MpYNsTHCur8sP
 BTh4KxEv0GMQauRqpioSUg66zjyJOuPVv9gd5FSaoiJAjbXzEQxuF22UYjB/foNPZR4+9YkVFzH
 U5WTylDUyRZ/H6UUiYwtPEQ8prKe29cqzv9VpVBXa+WkdB0HnFeVzQB9CfcWvqppP/bGSjf+jya
 zxAQSUX+V7BIIvc62vdyJymvVBRiy4uV7NeHb4A8VOljY0CCnO3CCCySQke8AAiLUps1IeCHADj
 2GpNbenp8LPbOLCNSFNPtcd02+VVHDqloDAwsws+4Kol1W4A9HgAWoFBzzkx1m4NW0wgRtnI=
X-Received: by 2002:a17:902:da4f:b0:2c6:8d95:fd6d with SMTP id
 d9443c01a7336-2cfa6ba9a4dmr59054205ad.21.1784851837271; 
 Thu, 23 Jul 2026 17:10:37 -0700 (PDT)
X-Received: by 2002:a17:902:da4f:b0:2c6:8d95:fd6d with SMTP id
 d9443c01a7336-2cfa6ba9a4dmr59053915ad.21.1784851836881; 
 Thu, 23 Jul 2026 17:10:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:35 -0700 (PDT)
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
Subject: [PATCH 27/27] target-info: rename target-info-stub.c in
 target-info-def.c
Date: Fri, 24 Jul 2026 00:09:47 +0000
Message-ID: <20260724000948.234657-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX4ySj5ZpuYeFb
 yjUO6+zUi5OJ4IyEmTLA0ilYnwfqIBjWGWgDkdrdb/FnOkIEEqMtLU+fJJZnv3+3r4LY4kSr8+V
 FpslJ+/zfsAfLZakizV7Z4sJuys5ljU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXyDrh3OvurXFo
 iqCafjdNh9vb1Nar9Bdv9KaRL8dh/qqJomTm4g0P+KLi+kMJ9EKci13ubW4U5owjaZHhVo9hghq
 JUy+A6SLkrp8vaA7ns+WrD+qLsg7oYalZg86vHUqlkzjBxEQKmdvOVGMhGIrfCF465LtOJLeWCA
 ALVwYT7ODE20BFPz4ThtdRtSQ0jcN+Ss/zqgtlwBGJTyTUO1KGZ//UV3xhlg6XAGJNmfL7mbnfE
 6bO5H8Dcx5aPwFFaSbSGnjhvC5eyy8ixavZBA48aViL03JMCEFftGlbQ6VjMdC3kQ+5UeXTcyWT
 qgxVGAZOHr+qJbHdrsf79Pmq5cieGcKNCbLM1wwJBgnByMovFKK2S3pqzk0A2h/fNLnUnPivz3q
 5KrspHFokzcwh7xMlWsdEzTLwiPU5cFEa5I46hAir6Ie5gKzVw2oz0qfUz0F0WUTUw9DD00M3Nx
 9d6ZV5VXFfadeVkQGbQ==
X-Authority-Analysis: v=2.4 cv=Z9Dc2nRA c=1 sm=1 tr=0 ts=6a62ad7e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=lug2nQC575Q72mQ437UA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: FFXcZN7KNSxnYYuqvPo6qM-QNdsysDOs
X-Proofpoint-ORIG-GUID: FFXcZN7KNSxnYYuqvPo6qM-QNdsysDOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Now it's the only file left to define target info, we call it def to
make the intent more clear.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 meson.build                             | 2 +-
 target-info-stub.c => target-info-def.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename target-info-stub.c => target-info-def.c (92%)

diff --git a/meson.build b/meson.build
index 6cfa0e6e754..449d50f2983 100644
--- a/meson.build
+++ b/meson.build
@@ -4321,7 +4321,7 @@ foreach target : target_dirs
     endif
   endif
 
-  arch_srcs += files('target-info-stub.c')
+  arch_srcs += files('target-info-def.c')
 
   if target_base_arch in target_arch
     t = target_arch[target_base_arch].apply(config_target, strict: false)
diff --git a/target-info-stub.c b/target-info-def.c
similarity index 92%
rename from target-info-stub.c
rename to target-info-def.c
index 71a6064548f..5d38e405735 100644
--- a/target-info-stub.c
+++ b/target-info-def.c
@@ -1,5 +1,5 @@
 /*
- * QEMU target info stubs (target specific)
+ * QEMU target info definition (target specific)
  *
  *  Copyright (c) Linaro
  *
@@ -28,7 +28,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
 QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 #endif
 
-static const TargetInfo target_info_stub = {
+static const TargetInfo target_info_def = {
     .target_name = TARGET_NAME,
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
@@ -63,4 +63,4 @@ static const TargetInfo target_info_stub = {
 #endif
 };
 
-target_info_init(target_info_stub)
+target_info_init(target_info_def)
-- 
2.43.0


