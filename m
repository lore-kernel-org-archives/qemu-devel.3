Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE50FD461A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 04:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvT5M-0001Va-KU; Wed, 25 Feb 2026 23:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5K-0001VE-Fi
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:46 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vvT5I-0008KG-BH
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 23:34:46 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61Q4Ute83225947
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WsR20ixZ7eACFtHj/lxqptDZAT6vfYF5bRFUepAMUdI=; b=PdwxRDuyUnqv2lJU
 yZ+b5RTGY/e5doHgR42/mVy1s7EeEDC0vrh0vxD/AwVdvtaaSBbETbBQU5mqSRrL
 uN9UGWrEmO800H/JaCb1zvAQKLzCrbEUosBHIlZFAeFz2VtZ6wOxCU9G8lxkI1UD
 CaA6SgHRCpfoZwFAmZc7aFVgX4zLGlY8gv6rKt2oRtwb9up+keZ0pG+D31sIGTA3
 9L36A3Uw93Y/mbmO8aG8Ntry7ZpTonGpHeOWpI7j5Qk8UuKHBf3ocmWNsywUTdcr
 MPq6O9Zp+CBXvRHCwc/qjJKfiGqcif2vgUanaBfnaIY2SbxxCEx/DbSmVLo6cCE0
 TLJK4g==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjdph088c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 04:34:41 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-45ca5b0a968so6387486b6e.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 20:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772080480; x=1772685280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WsR20ixZ7eACFtHj/lxqptDZAT6vfYF5bRFUepAMUdI=;
 b=BBtDX7XAfBxSvsL1RUZn88YQlCyWhApPXTLgjhhGIL6q10qz2uw4bx4Wf1tvvroV22
 VeBlfUl/cNMFuFoMNcM2wKOA4y8+Fj4wG7seUtFIrYfz88cF3NnnB6z7CFykGBm1XghK
 COyh6mdw4RWcLAsOHmEFK8wHtCk2pIMmGw+JJ3/gwlCj29Hs0aQ06SvZUciQeD1Zo/py
 W84e6CisNJ9Q+sf/Ta5kVUbyTvzGMVzcPVAiuW93uUX7p1LKnzqpu1d7rJZC+WpIfro5
 oTE5TJtvVhHyEEYh2mFj/lmabkkU1j01jKULRQVw3sb+40gL1gXRU2HnF+LY4XshVdN/
 Sgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772080480; x=1772685280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WsR20ixZ7eACFtHj/lxqptDZAT6vfYF5bRFUepAMUdI=;
 b=Buo3oBfeZyf89f6IdL4BpEjcthF9RKAVUK61aWQof/Zqz3tvecCNSa0tU5Hmqie0KF
 BwDqxlUuxiKE0hNnXulak9oEDERGnnE4+JBfMjNoFRaNyiJ9LI8xK+ZFzr2MwrPmwriE
 Yktf/FSEKjMWwJOV/9xKJkunTpW4yP0y/mD3f6yo7yfCxOMXViz32oyY3QFmyNcpVnY0
 Kc13iGZrRjs9yPluGAT/aQ3DHr7d4Zp9+m46bTBWBmkqlLsQrh0vwZXz0oZqh/nVe1RY
 JO7D0MdC5F7Zli4egs7naBRt9dMPa535BojLZ6fEy1RgQL4moqEwckg6HSvuYZV4ZHQE
 2CUA==
X-Gm-Message-State: AOJu0YzHx5I6wzTm/LpqK6lIN/epH0aoMZU7n3bXJ0q6z8hwTz/FEjBv
 lQMVYQeRlcBmyrE6et4rEP5hPDZnFI6edXXGR9uqm9XzcMziwhLYQOAC37JjlhtEXosVOEEPACa
 vnB9Whj6mx9sDTD2l7geFu8DlifnJpfUs+MwJSpcOo5Usg73um8GQL8GrAVRnECvHZQ==
X-Gm-Gg: ATEYQzwqXj2mqpgEoXxaKfsAjcsg6HtU28RpJgDRWf3jC+Q+eDEwkuQMHUT/3DxH7Ge
 iNK+7OzGueZ2B0yICpmMdcl70vF6xdSHiVZEqTJk7oG2vYlaI97njO9XKcAJbgOgqaGegfTMNdt
 zALIP1otU+TC+aDVBuhIIsS3E8ciddwHSaTQPZdaP0DEaB1SFa8xTEt+op6Q4INagQptEUE3bQ+
 +W3jgm5rYs3SfPHtgj1V3dPI5sQZxVUBpLXCCoZdbbKieuLl42+oWgDTK5dNWdTaEgrz9DiWB0a
 5HmVMJ3STMbX7KS/Gqf8Bo9fg9AnWCdytUUhzxUs0QDBqPPZTrj/7rsYmCk59XMtwz9G8FXhksi
 ZlF5zqxOkEUPhxxtnfIdlT96xVzjCAz8dHSZ6EKBaO1I7Nm+YUb3k76pjiK/qEFNNuSwz4g==
X-Received: by 2002:a05:6808:1a03:b0:45e:f0ef:382c with SMTP id
 5614622812f47-4649f061367mr1344225b6e.44.1772080480277; 
 Wed, 25 Feb 2026 20:34:40 -0800 (PST)
X-Received: by 2002:a05:6808:1a03:b0:45e:f0ef:382c with SMTP id
 5614622812f47-4649f061367mr1344219b6e.44.1772080479899; 
 Wed, 25 Feb 2026 20:34:39 -0800 (PST)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1f6333sm10394328b6e.19.2026.02.25.20.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 20:34:39 -0800 (PST)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com
Subject: [PATCH 2/3] target/hexagon: use TCG_COND_TSTEQ/TSTNE for predicate
 branches
Date: Wed, 25 Feb 2026 20:34:35 -0800
Message-Id: <20260226043436.648171-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
References: <20260226043436.648171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xQhk9OrgWil4oo_uyWCfR_6-__nhld7j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAzNiBTYWx0ZWRfXyyNfpKQJVnkK
 X6UMdBt2Zbxa82p2FXLI6TfAUt2k9AEcx7Wy0LiqjAwfm+IOTpQxoTfGtE4PHAHl2DQJZv3AJ/t
 Ng1MPVI9Um6MG3DDkWghuMKVb5vY4VpKmTahrSkASXuBR88oyfFaJhs/Fma80WeZt8zsrJ0oDIx
 cAmt8P5yC2ckOqiGBCYreX7mgRApAcXPxjkC98f0tPGVV0EXJ8j7BrDHLtZ1c7MzBHSfqfaINEv
 biYYqFIIqW9R8sKEPgm/wC7nV9Wci6e4dWYk0oVng4VTfYnZTNtu7+t8azTdzRATr8Sp3lUDzfQ
 MGlbRiCOaV5EjltFiRqsjt/jbS9NZ+jYhQDFzfLnYGuAx1Iop4anXUSL9LehzmqJI8NGnHbs45h
 r0vJQledi11YkrM6mmXly98sfx6Aq8WEzhTR93Otg8R2ZVCUECQ8+JDW8ZTD0PpU8Wjgwxrz7B0
 f6oD+DboypWdk8q6Sog==
X-Authority-Analysis: v=2.4 cv=NJLYOk6g c=1 sm=1 tr=0 ts=699fcd61 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ao8-HdWYDGaaWDIvVGwA:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: xQhk9OrgWil4oo_uyWCfR_6-__nhld7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace TCG_COND_EQ/NE comparisons against 0 with TCG_COND_TSTEQ/TSTNE
comparisons against 1 for all predicate-conditional branches. This tests
bit 0 of the predicate register directly, eliminating redundant andi
operations that previously extracted the LSB before the comparison.

For predicate-conditional jumps (jumpt, jumpf, jumptnew, etc.) and
jump-register variants (jumprt, jumprf, etc.), pass the raw predicate
value directly instead of going through fLSBOLD/fLSBNEW extraction.
For callers that produce a 0/1 result via setcond (compare-and-jump,
jumprz, etc.), the TSTEQ/TSTNE test on bit 0 is equivalent to the
previous EQ/NE test against 0.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h   | 80 +++++++++++++++++++-------------------
 target/hexagon/genptr.c    | 32 ++++++---------
 target/hexagon/translate.c |  2 +-
 3 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 45ccd51888..98d3996011 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -696,13 +696,13 @@
     gen_callr(ctx, RsV)
 
 #define fGEN_TCG_J2_callt(SHORTCODE) \
-    gen_cond_call(ctx, PuV, TCG_COND_EQ, riV)
+    gen_cond_call(ctx, PuV, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J2_callf(SHORTCODE) \
-    gen_cond_call(ctx, PuV, TCG_COND_NE, riV)
+    gen_cond_call(ctx, PuV, TCG_COND_TSTNE, riV)
 #define fGEN_TCG_J2_callrt(SHORTCODE) \
-    gen_cond_callr(ctx, TCG_COND_EQ, PuV, RsV)
+    gen_cond_callr(ctx, TCG_COND_TSTEQ, PuV, RsV)
 #define fGEN_TCG_J2_callrf(SHORTCODE) \
-    gen_cond_callr(ctx, TCG_COND_NE, PuV, RsV)
+    gen_cond_callr(ctx, TCG_COND_TSTNE, PuV, RsV)
 
 #define fGEN_TCG_J2_loop0r(SHORTCODE) \
     gen_loop0r(ctx, RsV, riV)
@@ -893,21 +893,21 @@
     gen_cmpnd_cmp_n1_jmp_f(ctx, 1, TCG_COND_GT, RsV, riV)
 
 #define fGEN_TCG_J4_tstbit0_tp0_jump_nt(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_EQ, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_tp0_jump_t(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_EQ, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_fp0_jump_nt(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_NE, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_TSTNE, riV)
 #define fGEN_TCG_J4_tstbit0_fp0_jump_t(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_NE, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 0, RsV, TCG_COND_TSTNE, riV)
 #define fGEN_TCG_J4_tstbit0_tp1_jump_nt(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_EQ, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_tp1_jump_t(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_EQ, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_fp1_jump_nt(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_NE, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_TSTNE, riV)
 #define fGEN_TCG_J4_tstbit0_fp1_jump_t(SHORTCODE) \
-    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_NE, riV)
+    gen_cmpnd_tstbit0_jmp(ctx, 1, RsV, TCG_COND_TSTNE, riV)
 
 /* p0 = cmp.eq(r0, #7) */
 #define fGEN_TCG_SA1_cmpeqi(SHORTCODE) \
@@ -933,31 +933,31 @@
     do { \
         TCGv LSB = tcg_temp_new(); \
         COND; \
-        gen_cond_jump(ctx, TCG_COND_EQ, LSB, riV); \
+        gen_cond_jump(ctx, TCG_COND_TSTEQ, LSB, riV); \
     } while (0)
 #define fGEN_TCG_cond_jumpf(COND) \
     do { \
         TCGv LSB = tcg_temp_new(); \
         COND; \
-        gen_cond_jump(ctx, TCG_COND_NE, LSB, riV); \
+        gen_cond_jump(ctx, TCG_COND_TSTNE, LSB, riV); \
     } while (0)
 
 #define fGEN_TCG_J2_jumpt(SHORTCODE) \
-    fGEN_TCG_cond_jumpt(fLSBOLD(PuV))
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)
 #define fGEN_TCG_J2_jumptpt(SHORTCODE) \
-    fGEN_TCG_cond_jumpt(fLSBOLD(PuV))
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuV, riV)
 #define fGEN_TCG_J2_jumpf(SHORTCODE) \
-    fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
+    gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)
 #define fGEN_TCG_J2_jumpfpt(SHORTCODE) \
-    fGEN_TCG_cond_jumpf(fLSBOLD(PuV))
+    gen_cond_jump(ctx, TCG_COND_TSTNE, PuV, riV)
 #define fGEN_TCG_J2_jumptnew(SHORTCODE) \
-    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)
 #define fGEN_TCG_J2_jumptnewpt(SHORTCODE) \
-    fGEN_TCG_cond_jumpt(fLSBNEW(PuN))
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, PuN, riV)
 #define fGEN_TCG_J2_jumpfnewpt(SHORTCODE) \
-    fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
+    gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)
 #define fGEN_TCG_J2_jumpfnew(SHORTCODE) \
-    fGEN_TCG_cond_jumpf(fLSBNEW(PuN))
+    gen_cond_jump(ctx, TCG_COND_TSTNE, PuN, riV)
 #define fGEN_TCG_J2_jumprz(SHORTCODE) \
     fGEN_TCG_cond_jumpt(tcg_gen_setcondi_tl(TCG_COND_NE, LSB, RsV, 0))
 #define fGEN_TCG_J2_jumprzpt(SHORTCODE) \
@@ -979,31 +979,31 @@
     do { \
         TCGv LSB = tcg_temp_new(); \
         COND; \
-        gen_cond_jumpr(ctx, RsV, TCG_COND_EQ, LSB); \
+        gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, LSB); \
     } while (0)
 #define fGEN_TCG_cond_jumprf(COND) \
     do { \
         TCGv LSB = tcg_temp_new(); \
         COND; \
-        gen_cond_jumpr(ctx, RsV, TCG_COND_NE, LSB); \
+        gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, LSB); \
     } while (0)
 
 #define fGEN_TCG_J2_jumprt(SHORTCODE) \
-    fGEN_TCG_cond_jumprt(fLSBOLD(PuV))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)
 #define fGEN_TCG_J2_jumprtpt(SHORTCODE) \
-    fGEN_TCG_cond_jumprt(fLSBOLD(PuV))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuV)
 #define fGEN_TCG_J2_jumprf(SHORTCODE) \
-    fGEN_TCG_cond_jumprf(fLSBOLD(PuV))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)
 #define fGEN_TCG_J2_jumprfpt(SHORTCODE) \
-    fGEN_TCG_cond_jumprf(fLSBOLD(PuV))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuV)
 #define fGEN_TCG_J2_jumprtnew(SHORTCODE) \
-    fGEN_TCG_cond_jumprt(fLSBNEW(PuN))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)
 #define fGEN_TCG_J2_jumprtnewpt(SHORTCODE) \
-    fGEN_TCG_cond_jumprt(fLSBNEW(PuN))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTEQ, PuN)
 #define fGEN_TCG_J2_jumprfnew(SHORTCODE) \
-    fGEN_TCG_cond_jumprf(fLSBNEW(PuN))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)
 #define fGEN_TCG_J2_jumprfnewpt(SHORTCODE) \
-    fGEN_TCG_cond_jumprf(fLSBNEW(PuN))
+    gen_cond_jumpr(ctx, RsV, TCG_COND_TSTNE, PuN)
 
 /*
  * New value compare & jump instructions
@@ -1101,13 +1101,13 @@
     gen_cmpi_jumpnv(ctx, TCG_COND_LE, NsN, -1, riV)
 
 #define fGEN_TCG_J4_tstbit0_t_jumpnv_t(SHORTCODE) \
-    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_EQ, riV)
+    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_t_jumpnv_nt(SHORTCODE) \
-    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_EQ, riV)
+    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_TSTEQ, riV)
 #define fGEN_TCG_J4_tstbit0_f_jumpnv_t(SHORTCODE) \
-    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_NE, riV)
+    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_TSTNE, riV)
 #define fGEN_TCG_J4_tstbit0_f_jumpnv_nt(SHORTCODE) \
-    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_NE, riV)
+    gen_testbit0_jumpnv(ctx, NsN, TCG_COND_TSTNE, riV)
 
 /* r0 = r1 ; jump address */
 #define fGEN_TCG_J4_jumpsetr(SHORTCODE) \
@@ -1150,14 +1150,14 @@
     gen_jumpr(ctx, hex_gpr[HEX_REG_LR])
 
 #define fGEN_TCG_SL2_jumpr31_t(SHORTCODE) \
-    gen_cond_jumpr31(ctx, TCG_COND_EQ, hex_pred[0])
+    gen_cond_jumpr31(ctx, TCG_COND_TSTEQ, hex_pred[0])
 #define fGEN_TCG_SL2_jumpr31_f(SHORTCODE) \
-    gen_cond_jumpr31(ctx, TCG_COND_NE, hex_pred[0])
+    gen_cond_jumpr31(ctx, TCG_COND_TSTNE, hex_pred[0])
 
 #define fGEN_TCG_SL2_jumpr31_tnew(SHORTCODE) \
-    gen_cond_jumpr31(ctx, TCG_COND_EQ, ctx->new_pred_value[0])
+    gen_cond_jumpr31(ctx, TCG_COND_TSTEQ, ctx->new_pred_value[0])
 #define fGEN_TCG_SL2_jumpr31_fnew(SHORTCODE) \
-    gen_cond_jumpr31(ctx, TCG_COND_NE, ctx->new_pred_value[0])
+    gen_cond_jumpr31(ctx, TCG_COND_TSTNE, ctx->new_pred_value[0])
 
 /* Count trailing zeros/ones */
 #define fGEN_TCG_S2_ct0(SHORTCODE) \
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 9eb21da6f3..c7b9436c8d 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -455,7 +455,7 @@ static void gen_write_new_pc_addr(DisasContext *ctx, TCGv addr,
     TCGLabel *pred_false = NULL;
     if (cond != TCG_COND_ALWAYS) {
         pred_false = gen_new_label();
-        tcg_gen_brcondi_tl(cond, pred, 0, pred_false);
+        tcg_gen_brcondi_tl(cond, pred, 1, pred_false);
     }
 
     if (ctx->pkt->pkt_has_multi_cof) {
@@ -579,9 +579,7 @@ static void gen_cond_jumpr(DisasContext *ctx, TCGv dst_pc,
 
 static void gen_cond_jumpr31(DisasContext *ctx, TCGCond cond, TCGv pred)
 {
-    TCGv LSB = tcg_temp_new();
-    tcg_gen_andi_tl(LSB, pred, 1);
-    gen_cond_jumpr(ctx, hex_gpr[HEX_REG_LR], cond, LSB);
+    gen_cond_jumpr(ctx, hex_gpr[HEX_REG_LR], cond, pred);
 }
 
 static void gen_cond_jump(DisasContext *ctx, TCGCond cond, TCGv pred,
@@ -609,14 +607,14 @@ static void gen_cmpnd_cmp_jmp_t(DisasContext *ctx,
                                 int pnum, TCGCond cond, TCGv arg1, TCGv arg2,
                                 int pc_off)
 {
-    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, arg2, TCG_COND_EQ, pc_off);
+    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, arg2, TCG_COND_TSTEQ, pc_off);
 }
 
 static void gen_cmpnd_cmp_jmp_f(DisasContext *ctx,
                                 int pnum, TCGCond cond, TCGv arg1, TCGv arg2,
                                 int pc_off)
 {
-    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, arg2, TCG_COND_NE, pc_off);
+    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, arg2, TCG_COND_TSTNE, pc_off);
 }
 
 static void gen_cmpnd_cmpi_jmp_t(DisasContext *ctx,
@@ -624,7 +622,7 @@ static void gen_cmpnd_cmpi_jmp_t(DisasContext *ctx,
                                  int pc_off)
 {
     TCGv tmp = tcg_constant_tl(arg2);
-    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, tmp, TCG_COND_EQ, pc_off);
+    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, tmp, TCG_COND_TSTEQ, pc_off);
 }
 
 static void gen_cmpnd_cmpi_jmp_f(DisasContext *ctx,
@@ -632,7 +630,7 @@ static void gen_cmpnd_cmpi_jmp_f(DisasContext *ctx,
                                  int pc_off)
 {
     TCGv tmp = tcg_constant_tl(arg2);
-    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, tmp, TCG_COND_NE, pc_off);
+    gen_cmpnd_cmp_jmp(ctx, pnum, cond, arg1, tmp, TCG_COND_TSTNE, pc_off);
 }
 
 static void gen_cmpnd_cmp_n1_jmp_t(DisasContext *ctx, int pnum, TCGCond cond,
@@ -665,9 +663,7 @@ static void gen_cmpnd_tstbit0_jmp(DisasContext *ctx,
 static void gen_testbit0_jumpnv(DisasContext *ctx,
                                 TCGv arg, TCGCond cond, int pc_off)
 {
-    TCGv pred = tcg_temp_new();
-    tcg_gen_andi_tl(pred, arg, 1);
-    gen_cond_jump(ctx, cond, pred, pc_off);
+    gen_cond_jump(ctx, cond, arg, pc_off);
 }
 
 static void gen_jump(DisasContext *ctx, int pc_off)
@@ -698,11 +694,9 @@ static void gen_cond_call(DisasContext *ctx, TCGv pred,
                           TCGCond cond, int pc_off)
 {
     TCGv lr = get_result_gpr(ctx, HEX_REG_LR);
-    TCGv lsb = tcg_temp_new();
     TCGLabel *skip = gen_new_label();
-    tcg_gen_andi_tl(lsb, pred, 1);
-    gen_write_new_pc_pcrel(ctx, pc_off, cond, lsb);
-    tcg_gen_brcondi_tl(cond, lsb, 0, skip);
+    gen_write_new_pc_pcrel(ctx, pc_off, cond, pred);
+    tcg_gen_brcondi_tl(cond, pred, 1, skip);
     tcg_gen_movi_tl(lr, ctx->next_PC);
     gen_set_label(skip);
 }
@@ -710,10 +704,8 @@ static void gen_cond_call(DisasContext *ctx, TCGv pred,
 static void gen_cond_callr(DisasContext *ctx,
                            TCGCond cond, TCGv pred, TCGv new_pc)
 {
-    TCGv lsb = tcg_temp_new();
     TCGLabel *skip = gen_new_label();
-    tcg_gen_andi_tl(lsb, pred, 1);
-    tcg_gen_brcondi_tl(cond, lsb, 0, skip);
+    tcg_gen_brcondi_tl(cond, pred, 1, skip);
     gen_callr(ctx, new_pc);
     gen_set_label(skip);
 }
@@ -955,7 +947,7 @@ static void gen_cmp_jumpnv(DisasContext *ctx,
 {
     TCGv pred = tcg_temp_new();
     tcg_gen_setcond_tl(cond, pred, val, src);
-    gen_cond_jump(ctx, TCG_COND_EQ, pred, pc_off);
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, pred, pc_off);
 }
 
 static void gen_cmpi_jumpnv(DisasContext *ctx,
@@ -963,7 +955,7 @@ static void gen_cmpi_jumpnv(DisasContext *ctx,
 {
     TCGv pred = tcg_temp_new();
     tcg_gen_setcondi_tl(cond, pred, val, src);
-    gen_cond_jump(ctx, TCG_COND_EQ, pred, pc_off);
+    gen_cond_jump(ctx, TCG_COND_TSTEQ, pred, pc_off);
 }
 
 /* Shift left with saturation */
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8a223f6e13..633401451d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -163,7 +163,7 @@ static void gen_end_tb(DisasContext *ctx)
     if (ctx->branch_cond != TCG_COND_NEVER) {
         if (ctx->branch_cond != TCG_COND_ALWAYS) {
             TCGLabel *skip = gen_new_label();
-            tcg_gen_brcondi_tl(ctx->branch_cond, ctx->branch_taken, 0, skip);
+            tcg_gen_brcondi_tl(ctx->branch_cond, ctx->branch_taken, 1, skip);
             gen_goto_tb(ctx, 0, ctx->branch_dest, true);
             gen_set_label(skip);
             gen_goto_tb(ctx, 1, ctx->next_PC, false);
-- 
2.34.1


