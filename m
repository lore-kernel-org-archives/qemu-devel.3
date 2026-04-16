Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7B4F8A164
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 11:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDL4X-0005Jz-8c; Thu, 16 Apr 2026 07:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4I-00058Q-8a
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wDL4G-0003BN-4d
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 07:39:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G7uwDX3733606
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2OUE2BZvCkh
 P3m2KzBqhz4prBprubJMeMyYTeAjRTI8=; b=BkpuZxFR/I3tZhPzRdOyywi4XiO
 7rGVC2c388CwPo/zb780Kzym8h+u5y8hK1jvWLEWoarH/lhIx4Nz7EV1Jj4e+z8Z
 OTZ+au8NVsfGwK1LIjALrhlPqURedEH2l/GFNhzVUo3er9xgmacAtuainiaRqexE
 bGudWT1mcl9z6SZc4BxvQH9ptDj5IIwbz7m47SJnAKmXkbgt/GZWswdBaXypKbtZ
 lvh1AqKfjuIE4pV6Vxv//T5vhVMNTzAQYdRjlVAJrJxYSupdfHQ5cWzCvcKjvqvN
 /nymZP3ZW7eT0Wlcuj6BNXKBzzt7ScAYHba9eY3Ob+74i9T6zFO3fG/AFSQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djcqwktx3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:39:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0ba59a830so10021035eec.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 04:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776339560; x=1776944360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OUE2BZvCkhP3m2KzBqhz4prBprubJMeMyYTeAjRTI8=;
 b=eNaN/+C1FKP9GX1R5ePeEYfjYxxUKJloDawXxk4NzFdEWL3Vt84Sfp26klVvFUkMZ4
 q75axDR6LmeCC1jchvVZOpHBg8LYPq6cQvUFXaP2MNth7GbSkeOobmqRgvs2pf5k6DYH
 zUvri3WBTntC8wSjqzCs+pJRqj6ZCdNPT2Klsg9ntxNrI+Hn7foQ6V71mxjpFBBnLs0x
 hS7ajcTB4s/u3ySpJd0lwOJrPf7FFx0uLVogNT15yvenIgjqnEzB2HHEtX0ogo5rQaoe
 OcxXNE897JeudA4XQqip7e55WNK4PAd3GiABMQNQv1A5Ys3M+LeXJocY1PyseLLrCPQT
 UN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776339560; x=1776944360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2OUE2BZvCkhP3m2KzBqhz4prBprubJMeMyYTeAjRTI8=;
 b=AVLhBHxnWiJiGxQwfFPunA/glexcUg4wiH7MovnttrfkVUHQeMP1tw+VsIQM2KHrCw
 lJc4g8VsaFuVVY7IwTZSGPZfRcmhgfnCq6q20pbA/ANohQlxr5vyf1eVeXNbxGMc4Omn
 vNNmkNULj3wRxWNqw1QmQ8sbFqgKy6OZ2V9ylT5UH1n5VwxyFMZcXkeUoJUopKcRlXR+
 sXqG+zMZozBvC2vzMqiryjERYemfPb/B8c7vhoFgRcWeVE9pnFSRyKMTZdD0Sdiw1Oym
 b5aAZD/LylqugZNiNXoem0wGHb60Q9HPgp5+LmzxXfE2DSFa/eV3ZpUII3dNTaS1OmtT
 pB6A==
X-Gm-Message-State: AOJu0Yx561DQCg9D3Bg1M/0iAa36LL8uyS0kltyPMD3UdrWSAMTxNegA
 CnzVPfG2GVyb/KiadC5G2+2TKgP5dTQbNpXTb1eDPW2I0rP7TLMYy60Z15BFa7d9FE3QfaKPrHw
 z2gDVExPUUbxmVfNvvqnopv4FMyFRC039QYisQPf2xSf56u6Bt/g0HYwFcng1btNW6qxe
X-Gm-Gg: AeBDietzI1PxYxLCsjH6VLhKPbVm8fNuLnDolHX8r6O5DDW86Of3Wl5dvWn8KRTs8BI
 VyaFF/eYicTkIKj/UHcfl1TwQzhrI+7PMpMaX9O3YusBUS5BO5Un7YXyRYIfIELOrueQto45wLm
 b/yI4bYQd95tNO6eGEwlECQ9oKCnQtyVsPHsWaJUnL/t1BL15+KKili4jv2rR31DizTM+ZVkdRP
 0wtxzPxB6v/HgGmw4Rg5xpMGf+/R/gGfncvW1q4JyQ+BDk8KnFE0I9hXqpiGi8rS6fJQ/zHR4Fd
 dA4sEgLSelPVy3IEYh5JlUvU6V6MLzENLbERBjK9CmAGD9LVWfpeXxZa2H45fYVMv/x/GtyK7BL
 vwcn5e5sdcmrHkFPTTuGhR6aOyC56OJ56Z6Q8SYwR61lwyJVlxMj76+jMAKDy/X8OYFdpGZizMy
 EMjzDwkZaRTjTuHRP/TC8=
X-Received: by 2002:a05:7022:609d:b0:12a:6f8b:36a3 with SMTP id
 a92af1059eb24-12c34e71d4bmr13039043c88.6.1776339559706; 
 Thu, 16 Apr 2026 04:39:19 -0700 (PDT)
X-Received: by 2002:a05:7022:609d:b0:12a:6f8b:36a3 with SMTP id
 a92af1059eb24-12c34e71d4bmr13039011c88.6.1776339559070; 
 Thu, 16 Apr 2026 04:39:19 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c10a65asm6845391eec.6.2026.04.16.04.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 04:39:18 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, ale@rev.ng, anjo@rev.ng,
 brian.cain@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Subject: [PATCH v5 10/16] target/hexagon: add v68 HVX IEEE float compare insns
Date: Thu, 16 Apr 2026 04:38:59 -0700
Message-Id: <96e27588ad5a7d47ba9f56f1d547729a19b691c5.1776339451.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1776339451.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jNu58ZhU7SuXSwTeKwN0X2a4KxrYqz_y
X-Proofpoint-GUID: jNu58ZhU7SuXSwTeKwN0X2a4KxrYqz_y
X-Authority-Analysis: v=2.4 cv=XOIAjwhE c=1 sm=1 tr=0 ts=69e0ca68 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=kUWl_rcrYXyUEKLnQikA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDExMCBTYWx0ZWRfX9Fr6u7/1T5oT
 BBY/VycPX1GppPOnZrr3XaG9y4aSZa/IMGewW5Eq3n7EPHvYzsGF3jpy2xetG3yd6oQIXJFrrEQ
 lV4Wns78TMDTkI1KrIbIFoaNAq/4rW6ZZf32z8AKShOx+xLVQczeCuZFLvvQ+1XjkHOJx1KPyui
 tSI1gC0UtrdqljBfuHGxnZOY6ZDbDMm9vwapd3fqILRAxitE4gRKCNFqVHgj0iSmqLKA+CSzE73
 vyKtZo+GHPWu+UhgWQUlFTATiUa85PI6aeJFFHp3KzIUWwGOxEZ4kE7TPQ53RrtSp7NoIQZLdAm
 AsLSS97fzsrdc6NyDmezbpAw0RKiZPvlmsK00yi1rR/WpIQMQxqDn7imb6KJbrQPsHjSiZZjCw5
 ZA1POZo7RR3ZTmrurd3ZarT7VUC/Kvtm/ffMqT86D9rS931q30mbfpSvxeP7FAy9KbGuiSJ+9Jp
 6ETwZcyFhGJfuULNEJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160110
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Add HVX IEEE floating-point compare instructions:
- V6_vgthf, V6_vgtsf: greater-than compare
- V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
- V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
- V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/mmvec/hvx_ieee_fp.h           |  4 ++
 target/hexagon/mmvec/macros.h                |  3 +
 target/hexagon/mmvec/hvx_ieee_fp.c           | 48 +++++++++++++++
 target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
 target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
 5 files changed, 126 insertions(+)

diff --git a/target/hexagon/mmvec/hvx_ieee_fp.h b/target/hexagon/mmvec/hvx_ieee_fp.h
index bdc21e08f0..01728121eb 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.h
+++ b/target/hexagon/mmvec/hvx_ieee_fp.h
@@ -25,4 +25,8 @@ float16 qf_min_hf(float16 a1, float16 a2, float_status *fp_status);
 int32_t conv_w_sf(float32 a, float_status *fp_status);
 int16_t conv_h_hf(float16 a, float_status *fp_status);
 
+/* IEEE - FP compare instructions */
+uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status);
+uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status);
+
 #endif
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index ac709d8993..318d44efb7 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -356,4 +356,7 @@
                extract32(VAL, POS * 8, 8); \
     } while (0);
 
+#define fCMPGT_SF(A, B) cmpgt_sf(A, B, &env->hvx_fp_status)
+#define fCMPGT_HF(A, B) cmpgt_hf(A, B, &env->hvx_fp_status)
+
 #endif
diff --git a/target/hexagon/mmvec/hvx_ieee_fp.c b/target/hexagon/mmvec/hvx_ieee_fp.c
index 697f35b5ed..d7751adbe2 100644
--- a/target/hexagon/mmvec/hvx_ieee_fp.c
+++ b/target/hexagon/mmvec/hvx_ieee_fp.c
@@ -87,3 +87,51 @@ int16_t conv_h_hf(float16 a, float_status *fp_status)
     }
     return float16_to_int16_round_to_zero(a, fp_status);
 }
+
+/*
+ * Returns true if f1 > f2, where at least one of the elements is guaranteed
+ * to be NaN.
+ * Up to v73, Hexagon HVX IEEE FP follows this order:
+ * QNaN > SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg
+ */
+static bool float32_nan_compare(float32 f1, float32 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float32_is_neg(f1) != float32_is_neg(f2)) {
+        return !float32_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float32_is_any_nan(f1) && !float32_is_any_nan(f2)) ||
+        (float32_is_quiet_nan(f1, fp_status) && !float32_is_quiet_nan(f2, fp_status));
+    return float32_is_neg(f1) ? !result : result;
+}
+
+static bool float16_nan_compare(float16 f1, float16 f2, float_status *fp_status)
+{
+    /* opposite signs case */
+    if (float16_is_neg(f1) != float16_is_neg(f2)) {
+        return !float16_is_neg(f1);
+    }
+
+    /* same sign case */
+    bool result = (float16_is_any_nan(f1) && !float16_is_any_nan(f2)) ||
+        (float16_is_quiet_nan(f1, fp_status) && !float16_is_quiet_nan(f2, fp_status));
+    return float16_is_neg(f1) ? !result : result;
+}
+
+uint32_t cmpgt_sf(float32 a1, float32 a2, float_status *fp_status)
+{
+    if (float32_is_any_nan(a1) || float32_is_any_nan(a2)) {
+        return float32_nan_compare(a1, a2, fp_status);
+    }
+    return float32_compare(a1, a2, fp_status) == float_relation_greater;
+}
+
+uint16_t cmpgt_hf(float16 a1, float16 a2, float_status *fp_status)
+{
+    if (float16_is_any_nan(a1) || float16_is_any_nan(a2)) {
+        return float16_nan_compare(a1, a2, fp_status);
+    }
+    return float16_compare(a1, a2, fp_status) == float_relation_greater;
+}
diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexagon/imported/mmvec/encode_ext.def
index c1ed1b6c23..3572e4de4c 100644
--- a/target/hexagon/imported/mmvec/encode_ext.def
+++ b/target/hexagon/imported/mmvec/encode_ext.def
@@ -858,4 +858,14 @@ DEF_ENC(V6_vconv_w_sf,"00011110--0--101PP1uuuuu001ddddd")
 DEF_ENC(V6_vconv_hf_h,"00011110--0--101PP1uuuuu100ddddd")
 DEF_ENC(V6_vconv_h_hf,"00011110--0--101PP1uuuuu010ddddd")
 
+/* IEEE FP compare instructions */
+DEF_ENC(V6_vgtsf,"00011100100vvvvvPP1uuuuu011100dd")
+DEF_ENC(V6_vgthf,"00011100100vvvvvPP1uuuuu011101dd")
+DEF_ENC(V6_vgtsf_and,"00011100100vvvvvPP1uuuuu110010xx")
+DEF_ENC(V6_vgthf_and,"00011100100vvvvvPP1uuuuu110011xx")
+DEF_ENC(V6_vgtsf_or,"00011100100vvvvvPP1uuuuu001100xx")
+DEF_ENC(V6_vgthf_or,"00011100100vvvvvPP1uuuuu001101xx")
+DEF_ENC(V6_vgtsf_xor,"00011100100vvvvvPP1uuuuu111010xx")
+DEF_ENC(V6_vgthf_xor,"00011100100vvvvvPP1uuuuu111011xx")
+
 #endif /* NO MMVEC */
diff --git a/target/hexagon/imported/mmvec/ext.idef b/target/hexagon/imported/mmvec/ext.idef
index 788ce1d2ae..a7043d598c 100644
--- a/target/hexagon/imported/mmvec/ext.idef
+++ b/target/hexagon/imported/mmvec/ext.idef
@@ -3143,6 +3143,67 @@ ITERATOR_INSN_SHIFT_SLOT_FLT(16, vconv_hf_h,"Vd32.hf=Vu32.h",
     "Vector conversion of int hw format to hf16",
     VdV.hf[i] = float16_val(int16_to_float16(VuV.h[i], &env->hvx_fp_status)))
 
+/******************************************************************************
+ * IEEE FP compare instructions
+ ******************************************************************************/
+
+#define VCMPGT_SF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_SF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+#define VCMPGT_HF(DEST, ASRC, ASRCOP, CMP, N, SRC, MASK, WIDTH) \
+{ \
+    for (fHIDE(int) i = 0; i < fVBYTES(); i += WIDTH) { \
+        fHIDE(int) VAL = fCMPGT_HF(VuV.SRC[i/WIDTH],VvV.SRC[i/WIDTH]) ? MASK : 0; \
+        fSETQBITS(DEST,WIDTH,MASK,i,ASRC ASRCOP VAL); \
+    } \
+}
+
+/* Vector SF compare */
+#define MMVEC_CMPGT_SF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_SF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_SF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+/* Vector HF compare */
+#define MMVEC_CMPGT_HF(TYPE,TYPE2,DESCR,N,MASK,WIDTH,SRC) \
+    EXTINSN(V6_vgt##TYPE##_and, "Qx4&=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-and", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), &, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_xor, "Qx4^=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-xor", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), ^, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE##_or, "Qx4|=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than with predicate-or", \
+        VCMPGT_HF(QxV, fGETQBITS(QxV,WIDTH,MASK,i), |, ">", N, SRC, MASK, WIDTH)) \
+    EXTINSN(V6_vgt##TYPE, "Qd4=vcmp.gt(Vu32." TYPE2 ",Vv32." TYPE2 ")", \
+        ATTRIBS(A_EXTENSION,A_CVI,A_CVI_VA,A_CVI_VA_2SRC,A_HVX_FLT), \
+        DESCR" greater than", \
+        VCMPGT_HF(QdV, , , ">", N, SRC, MASK, WIDTH))
+
+MMVEC_CMPGT_SF(sf,"sf","Vector sf Compare ", fVELEM(32), 0xF, 4, sf)
+MMVEC_CMPGT_HF(hf,"hf","Vector hf Compare ", fVELEM(16), 0x3, 2, hf)
+
 /******************************************************************************
  DEBUG Vector/Register Printing
  ******************************************************************************/
-- 
2.37.2


