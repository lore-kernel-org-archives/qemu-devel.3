Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723B5FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJ4X-0001By-HG; Thu, 30 Apr 2026 00:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJ4S-0001BY-8L
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:32:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIJ4Q-0004KP-Cy
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:32:15 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TKbTGi3992973
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gfYChwZhf1U
 05Zl89Fjt1DlwgN7a8x+03Xmf8Mj5g1c=; b=kM/dy37nlqdJt63ffFO7xXsk5GE
 AXW1Gy5SrjGwpipKCHNOltNhNGz0FhRQxBu4IVAuxmsWJ8bfM0kgIgv4jSwJfVQ8
 9ahBv3/TeF2IX32ftXExLHygdoPI1aF6Mzjhlc/UI1cWGv4TkG+TjLGXfubxTp18
 gBjPOzTT77RTmCggiOA5F6aCYIgEeFcWKzz7ExX9yoBU9IuD6uZrs+d19S9WxRXg
 9t4KzhWlcNbSGt+6FwzVB+/r2Z7U8jRtTewTufi2r4CldfynASBAmJHfz910+KPC
 IEKODbyei8O4VIfp5Sp/ZhBOcvsw62S6qyXqYisIgBXMO6VZteSJ/0hkk5A==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duhx93264-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 03:56:36 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-12c35f2c09dso640266c88.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777521396; x=1778126196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfYChwZhf1U05Zl89Fjt1DlwgN7a8x+03Xmf8Mj5g1c=;
 b=JGj/hSeeYXf6ZtKs3QAmNiE/FPCgim7oG16dFpFM/B4el0MNwIsSOWEndDb5a6Z54z
 KppeW5W/zPjH6F+yFvIZqTDyc1zgun7a7pgz8vhtW0aCn82ix4R7CUesr/XO2PlScdX+
 LFKhBYUKjFRID2UwBzg/2Mf9EmH1aNgit90cVFZpE5ioPEnE6Ywu0+Pr04IGNrg/hX2P
 qYIDMwf6CYMBFuIcyCE5VS74jh0rH3P24XWQtMjbi2OlIxb9JPTEseaelrmzWXvZ2rc2
 9Q2SOPLojmhNGpbH/zpcw3Zg3oTjj6xuSctTFmmOcFJdlzx26bYfJvxxFvSjzX/JL1KI
 Z5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777521396; x=1778126196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfYChwZhf1U05Zl89Fjt1DlwgN7a8x+03Xmf8Mj5g1c=;
 b=s+x7BUFPwSJ39PPCJ3EJOzdiHUscBFrmLse1ZX4gvFTlMDka1S+G6lJihxqqZLQebs
 au6r9QMY0hFrSvlQgzRX0PcBZUGD4r9VQ65+VGSjZU68X0CeHqnnMssRzZJqaG0lFmsT
 LnEjRpJXvlapGkIwVKZSin0ckga8YXHz3iF/X1Tazu4IAhCdM4FjgiWv8OUjeRhTQzQS
 hjUkR4BpufD4VYSaVBn8ZPkOzFtO3+6jY2tB+pNhSuHk1C6SBm5U1EfPLIUn9dmPyOD7
 6Q/sH31L37dlwwjLu0pEYWqWAK4dDZAukAS4tlzZfzFv29homwq+KUIWi50gAcTFc4Ux
 QiMQ==
X-Gm-Message-State: AOJu0YxC9tvzEA03bf1v62Rac3E0sPBd+RGMw5EZqVpGilGOjEUVYrkm
 BTwWSD5wTjQy3FWojT1WtZXx5JcHLjR8R8+Fg6pqs30JhvnJOD78BP0xATLIVDkpWKHOeOiYZor
 k9StP8u94+vsayhpr8Y1vASzwdMOLlnS3TLXha3NKYbogKxcB+Y+9NYq88pxevrmm/Z9h
X-Gm-Gg: AeBDievou3VfAi/Murr34NsCct/I9/WHIDJdPYoAul6WEAjD5ZhF789lsAowHh9scqW
 dbDJ8/b1hVm7YCmZiKJuIyGuBpNVrgSzc9Z5GuHUtlnY2oGQ4wJLO/l4eOQeoXFwqzTI6GrlPVh
 v8kPVt+SuKynZXvap/+LujNtJz5OnhnnNEy6Iz9ES/eDJRMoTJbvT8KYLbEj9ZOjC8RoQoq+iY0
 XAJq9k//6OD4Jpi3ulQmx0x0yoJtfzVtu+dU7cpG5fBhsqpK63L9C4LyMTNWIFIH1g1m4JA3QXK
 74ICuEAAtpnbTh1CmWw6zczZpZPAp9gtp2DSGDU2hWkJdZn9fL1eTw5SGkHDFbJsYbwPlLRz/b6
 yvBHR+3IwzXGzGFkKuUzQPQIqVArXV4j+8L63riV+/CZutgz7Qwt38iXiJjBIr7ebEEv7Om+Wz9
 tH97CUYW8SIemBjzod
X-Received: by 2002:a05:7022:4188:b0:12a:7181:2f1a with SMTP id
 a92af1059eb24-12deac4f47emr540084c88.5.1777521396000; 
 Wed, 29 Apr 2026 20:56:36 -0700 (PDT)
X-Received: by 2002:a05:7022:4188:b0:12a:7181:2f1a with SMTP id
 a92af1059eb24-12deac4f47emr540072c88.5.1777521395529; 
 Wed, 29 Apr 2026 20:56:35 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de32173acsm7159443c88.5.2026.04.29.20.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 20:56:35 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Anton Johansson <anjo@rev.ng>,
 marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/7] target/xtensa/core: register types using type_init
Date: Wed, 29 Apr 2026 20:56:23 -0700
Message-ID: <20260430035626.3511676-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430035626.3511676-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzNiBTYWx0ZWRfXzMZxoZA+Qb+1
 T3eN5cykKsxwxEpUlcT2aIZ3Fexu+7nBmQHb1yuNBXJgfOGMdFod8+2QAtRYErBYZXhAXlcsznM
 TPSdN2M7LC+cjs42IMX4x+VUvdXALX8UPmukfW3e9A/vyl2XbDLLpwq12JBw3eWLqAkQb4KQltI
 Y43KJVVMkml35Z0veqBcj53ZhI46O8K0q+XwFZK9h0DEY/Hl0O/qpxQ5bRfBCtMq69J2d0uqcBX
 dMUq+VRXs3lBDOSO8aJCbwCCi6RTPCtJDixoNB//res8haV67xbxU7VfYZ447Pv9EZzK5TNSQ6r
 X1aKtr5emGcL2ldWKsC45OFyvVZU/lt15yXiRCZH9OI5nG1AX6Lytol6PdVCTkwypC7YTwNV+rG
 v9w68FuutWar+tDMwWeOltxhqCV9vLX0AzYkZgNOh786D14l1rUbv5rtnOhtOb3yD/LKIb4u89U
 Vdh9rImJ8UD+f9JCEcA==
X-Proofpoint-ORIG-GUID: 3qfgwHqHDfBbSwPEhemWCIWg31p8O9wP
X-Authority-Analysis: v=2.4 cv=O5oJeh9W c=1 sm=1 tr=0 ts=69f2d2f5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=4x8i1Y_ebu9NQW6KHmAA:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: 3qfgwHqHDfBbSwPEhemWCIWg31p8O9wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300036
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

Instead of using a static constructor, delay registering those types
until we call module_init(MODULE_INIT_QOM).

This is not yet a problem, but since we will start initializing
target-info types before any other, without this patch
qemu-system-xtensa* fails with:
Type 'dsp3400-xtensa-cpu' is missing its parent 'xtensa-cpu'

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/xtensa/overlay_tool.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/overlay_tool.h b/target/xtensa/overlay_tool.h
index 701c00eed20..b9eaffa4871 100644
--- a/target/xtensa/overlay_tool.h
+++ b/target/xtensa/overlay_tool.h
@@ -451,13 +451,14 @@
 
 #if TARGET_BIG_ENDIAN == (XCHAL_HAVE_BE != 0)
 #define REGISTER_CORE(core) \
-    static void __attribute__((constructor)) register_core(void) \
+    static void register_core(void) \
     { \
         static XtensaConfigList node = { \
             .config = &core, \
         }; \
         xtensa_register_core(&node); \
-    }
+    } \
+    type_init(register_core)
 #else
 #define REGISTER_CORE(core)
 #endif
-- 
2.43.0


