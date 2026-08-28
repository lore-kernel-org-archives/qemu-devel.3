Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C69C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bP-0001E0-Vt; Fri, 28 Aug 2026 19:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bJ-0000wV-4Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bC-0006Ba-VT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:07 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMU2P0170016
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BI9lzGV7CdE
 iHTI8GC3Mv+uu0jG3uaMxbadWrl4HUEc=; b=pNSO/P2fSz91H9yr65T1nQnKACo
 gabz1OSRvM05kkKLyVp5c2mKM59aDTHH4Dvv9lPmJ1ndBYAFxhf50z523WR4zLq1
 Ql5Mq4fENNpxsEks8HLRNgKwXX5EdWRIncO58YLGEIYC+oIb+eJTtxv5qbLxhcHI
 R4I354h7ZprLLDHhiutzDuNlQcPEfhQ/SknF1nYsTBpERFDc1oaegBBcYajGsYWH
 A6BLzxsmS1w7/VqL23Ac2B+lGfOVOwJg8zhj9yQbJPCiwnxasVuJ0fENHehU3rAj
 1RuncSXc33uksefoGSfMkTH3Btkb/xry4Coejt4iWQYNYXVKblyWLV8NvYA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbhgq8crm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so3688356a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958181; x=1788562981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BI9lzGV7CdEiHTI8GC3Mv+uu0jG3uaMxbadWrl4HUEc=;
 b=AYSkAacW2XJo/j8RkCt5B2uNMP2ly03Tikr6WjSOhvii42AqK1gJDbVFyAe1DZNzRh
 pJ5Vy/JBpHqeSZ/ST0CeEXrycZdqVkBVLmmSfGEYapH7yhlggE/6hfvrdor61X8BCUKJ
 Kgap8ugvn07TO1ocLbfsb1az5qFtiB6M97kQH/lJAp7PVJbRNaWZ0eajFlreHIC8oUs7
 d2pE8E+0rU0eJ1+TN1hUG7mKejO0A/w7dhtOuHA60YLOM/WMlcFGqRfEzYK++Q8AoTkS
 ElLfIjx1Vin1BX8v7spK0t9pzFuCiGmsm93QhVF0LRK1o1EH7uF/zLt+iP2AYENbAe1M
 O1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958181; x=1788562981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BI9lzGV7CdEiHTI8GC3Mv+uu0jG3uaMxbadWrl4HUEc=;
 b=nSeYUNfg67e1OQanIzxUT9AaRzFrOdWZLUDRxM0wbgAPBzfXi3PX/HLLaN8KCYZh7s
 Qg1K2SXjRlj89XJuu115kH0cD2sodXD22aubX7aBtxxWOHmwgcFmNPVLXadfO1exvz0M
 HqkKKO7CFmBQ7mE1c2ZbXGmJ/YFaM9CJUhoedyFYAcwvz5Z2bMMno4zjECALyeJN1s60
 7X5qZOR9yO6e9PLUeuEZoQ46rkwjIAEb4OrAaNmnpsICpWp+YONVfUSWC69JITn4O7ue
 Iwpcv4YzhUGCcKJvCepAldpP3eWkDprRRAfCT6UhI9lloTUJ83ex+GqwOWZOb6xPOdPM
 31bw==
X-Gm-Message-State: AFuF++kn3QE8uiTn+fmozphO4q92TmY5nsZW2FqC+TzyfvdSjhOMXeJV
 dKjk51wQIJMAjAGSDb0XU2cmrwptmUTU8QsUEb6KYo8qU0VjsVDc5yCXGeeMAspaqRHj4Gs2InT
 +Yc9wiI4W0Ro8C4yfYnUjiPsWZ8MpvaKte2eOJoWq9rlMbmV0AsE6iken/ti1uFTMVw==
X-Gm-Gg: AYBFou3/gNDnPBk7IJxsC2AEka7kRGheNDy58ZqSwDVm6TiwjQpYfPQKBxld7VTXKPh
 W7LYcBTHWtaSubs8jmZdkg/iFQN5srQXFB9Yg6JuebrMvVvHcCqcklJY/r30K7P6OOCgnCzMSP2
 wNaSPM0qqBY4XlJbKJzCx+k+ul/Th3vG2vwxw9ZZxgm5AaJXnkB5vF200ATor/VrP3frB3B0qUz
 x6lt6iIDQTVvH2aPc3W6ViYmT9fpGQNuv2cE9Sse0eZqvIyUEomyoADbkE/bBfuN+IDMzqt/hWN
 a9tSfiSghSOHEYWgAx09KmbPybMTT45UHPVm26ivLPqfZe2qaRYF+q7KdplKtckZJxS0Bi0VL4+
 /2eJ+hhgTV+MoGDv/2igfAEJzT+qBM1a6w9BDER91Dq0Oj2lx4BVLAIhCrtE=
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-3989be5b50emr2705379a91.25.1787958180996; 
 Fri, 28 Aug 2026 16:03:00 -0700 (PDT)
X-Received: by 2002:a17:90a:114f:b0:398:9be5:b41e with SMTP id
 98e67ed59e1d1-3989be5b50emr2705342a91.25.1787958180589; 
 Fri, 28 Aug 2026 16:03:00 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:03:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 41/47] target-info: add target_microblaze
Date: Fri, 28 Aug 2026 22:58:55 +0000
Message-ID: <20260828225901.367438-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nwyjvrrNJzYZay6lL5dK7R0YRdJNuOGR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9dK+vlXefy3b
 aDJcskeXo2OMV34O+bZCssezj21YL7yZZ0oF1e+NUL3Yj5IF1tAW2bUM7kRoU6vbrLOlJ5/K2hy
 I6w/9le+wGbNn/ANaUAfjqBXHgaxxaM=
X-Proofpoint-ORIG-GUID: nwyjvrrNJzYZay6lL5dK7R0YRdJNuOGR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX2o4AvrvJ2OPz
 6TTL3YJ3Z8bDsFl9HWEtah/o773TxuRAYk6e9iYqcQKLwTTHzBfFl8bLwG/lvAOliFxIGYPD+d7
 w0iRHIf7PQh1QuQXfJtqfk3xg9J+NwgmJ9nmrTUwX1Tt+nW30NH2Mug4UDCrmt98PjaJIntuyu2
 4JSrAzzxROt0BJvnvhNM9RBlJ/RsF6/HECGXs8fhtTlgv7GqEZwMh20ETqzAG1/fscrXVPug7Sf
 6e6WFExF7+hV5BSWrrXnrZw6u3qV6cDYTmEr//+ugwNY8qeMtModTlnc97/Am2I6QISQImMCPTf
 jVVOH2DwrcK7OMnWjbcP4mUwfe+6MGtNsJL2MRax/OnM1tkdZfje3vzR4T+xadTkhFijvEidbOL
 ejGJrnIKNc90WeGLCeFm5POWn9fd0JzEOus58ZtXreEU1aHN28gvsRLp3+oIjVuim6lCF9xubvS
 KRkbhRGHDMilodWXFxQ==
X-Authority-Analysis: v=2.4 cv=CsGPtH4D c=1 sm=1 tr=0 ts=6a9213a5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=upjuZsUD9oIM7hwv7PIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 7 +++++++
 target-info.c              | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index a60751a4ef6..e6524a8001e 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -84,6 +84,13 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_microblaze:
+ *
+ * Returns whether the target architecture is Microblaze.
+ */
+bool target_microblaze(void);
+
 /**
  * target_base_ppc:
  *
diff --git a/target-info.c b/target-info.c
index 8e9f1823dc0..1124aa5f780 100644
--- a/target-info.c
+++ b/target-info.c
@@ -78,6 +78,12 @@ bool target_aarch64(void)
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
 
+bool target_microblaze(void)
+{
+    return target_arch() == SYS_EMU_TARGET_MICROBLAZE;
+}
+
+
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-- 
2.43.0


