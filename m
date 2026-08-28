Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A417C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Xi-0000AT-DV; Fri, 28 Aug 2026 18:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xg-00009e-LH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xe-0005k3-OP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTunM1174511
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6ngNY2danIh
 TqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=; b=Od6HcA2qjAmx4Dj40Bg9CK//Ue2
 R5xNmTu+r7Cx1T38/vVwIrKWOK3Z0Kl0Ln7Z4u85RLYCe2mzps5TWnN+/2J+reja
 FJZ8yUUyDHooYtEgurEiRqC+HfjT4v+Ma57CMPxD4FbA7Vnwlj0vLMR6pnkp1XAw
 1LjHsqsLZp+AqSdUGv+xhuEO7Uc/eI2HqKoB9L4hAHnOHb0As6xyYRQzmsVg1JWV
 xgGBr1q54JKnROKyPZnDM57J+sAEl3Y//ejp+HJxcDt084NLJCZCQkySzFHqINi6
 r/32H5ZLqTZF1e3sA7JNwOqzRVjpR7mOv6lpAlfRXLq+fb8lmt5ljUV65LA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjk5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so2208095a91.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957960; x=1788562760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ngNY2danIhTqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=;
 b=g79AJ+60XBNzicaCEHfD59SPzUZhIKpNar3FAPcXVxt9ATrTLcbtAHQG/tXYZs2JQ9
 qQTEuwxJFmJheFuIKXWLcxfqEBVzRCIYfmwuk4D3DhghWnoY5jvi1+QraiqJcKVlFAxK
 GZ+2tV3wN2xo0CQsTJRTI+MaBlgBoefe+PfRLASfwfjkUg43vchhPLVwBUceU/ZDQZHn
 BCRJDFOW6PxRSDpZhDMLJvwnOd3NoC92wubTn/8JReoTXGSMu4OBlaa0SFF7ZumxBXcB
 k1at31OEdydglncggX66oEm8xzh7f5izY2W3Ojc0KjtW1LWCIUfP5/Bv37i7zUvJNpXP
 d1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957960; x=1788562760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ngNY2danIhTqRMm611hp79hfteIG/+Ld0UI/A/Vx+8=;
 b=KWWl/usbAzmt5XIgGsZXrsWDLuCtLu3qnB69QZALF1rnDtmbavrO44c49N1DAGcsb3
 lowv9NzRVSXhcTyBUViVH5hcOWeh+19zNbWpQOpXIk6wBs2DffvQpgJNosZNxzUGRP58
 WycPAs16ELB4X+N6BEFwvTCWwAEp8CJcLkH6ieizJuiara8wQBNTmHLlckx1okA7IG1h
 DaSmANh4D51cInf1xe4ccUdp4U5XnfhSJZo5KKYuav20x38sX9KYr99C2hwgcQwQRdv0
 8Thn2tayhzPblN0I14OcWGW5xshT6MCWnrhBUYyt4YPlXd5RO+eQ9PS/oSPAEg137gCK
 rHYA==
X-Gm-Message-State: AFuF++lFH5E929Ir9fk89zzatAGUYYvLepquLRoQTyOPvFaYzi3E0dUv
 SH6JfPD8vZgqHCLmDa48KwxNLz/64jU/XmcX8gYcKVt9V+BJWh812rO0NODJL4uCBHTJA027PSB
 XJktVNGc8dZB2R+JL3qTRdlF1PXg1Tet5sruId1WDZz+0tZoW9nHsHLR6rJd3YKPd8A==
X-Gm-Gg: AYBFou36vMhjbVDn/CRxOgJKZe9pBLCk79fP3NpNjoU7YclfI8c5FQ6N4sJoPw7X3VE
 KQhL2FCSerBwYyQMq+bnHOkjrqY6SOsWzCmQgmJaQRuM+uwmm5Ghcf3LxPkcKAEuJbwSc0dDxri
 W9+7ZDEhGmVCpiUuLEkWPDOugB85K7OKhIHXeNKVlAgmitWKUFmT5hzyTq5w1kR2CDrVk5FaaXh
 GPGzT7RTm9Omd+084zLxk5Vh3gGHxJaEL208x0TZM01+7qGBoPiK1Pq0xn3LcFQF+PKsMcME5Sx
 Zm0/9p4E85tGld7gYNfz/c/xcqFHbEuZTlaYek3mVwLdAqA8EoCAdLPfDoeqmLu/+9OsEDNGO3o
 vvsgiBL+fSHNEgHwz9J2uxJp5/jA1EAti/7m25Q4ZOywWKV098kTUZsQl/fM=
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-396d0e20f00mr19898980a91.5.1787957960537; 
 Fri, 28 Aug 2026 15:59:20 -0700 (PDT)
X-Received: by 2002:a17:90b:538e:b0:38e:c232:9d3f with SMTP id
 98e67ed59e1d1-396d0e20f00mr19898935a91.5.1787957960088; 
 Fri, 28 Aug 2026 15:59:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:19 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 12/47] target-info: remove machine_typename
Date: Fri, 28 Aug 2026 22:58:26 +0000
Message-ID: <20260828225901.367438-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OSveXJVu3sGeayT0tbPpkEImmjX4XzHf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9bJ2v+Ww5z2H
 PjsCVf6SxglbHRxY/LKaxFrMAv1wzY0euI0FDGq2SBI+WxQXs4umxiPjG8DVkTNXV0oO6y5Znpp
 zIB0/fum2ysm0UbHbLvE7Lww1/+TP7c=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9212c9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=-0VSjDDMCBEubZ-f8bYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX698RuObYpYrX
 fkG2V2KtTexVlyh4yPP8wAHYUl8/B4O0Wqfw+8ScS5F4P2sff5itaGM4lbBpmbDFkx7hnIaNWTB
 MAxj2U6RJ1POrpDp1qc+YMdTV9lUYckDpt/51jS2vDez2rpoBeLoqqUQ+gK6lCpoJ30oXmHq1dt
 Nj7fyxKsX99mc2g+zj6rI6b3u1DnTTQwTNLFFrxnzANcRGu1tK6sxkAo5jj30goQBjVVINd1bRr
 3iOjB8PtHXV6sJkxc16Bi1yM83VvfqFEF4k5lc9Xw02bBtQRqqomH5OCZPup7kv8DcXosfd7WRR
 sqRDDvWnjEyJhF5aM1D9Ew/y7/ZY8Dr8jGiqFOhUkA8Iim1ApgphX27OZ+xvSV9IwB8JYCfb6mc
 nIe8uAz8cVT6pon8rnMfYwgUgQCVYPZpPklQ4Qs2ichs9HKRASPzlpOSScdFUHtgndm3kAedNrD
 esQy6SXyuLDPRLaaUqg==
X-Proofpoint-ORIG-GUID: OSveXJVu3sGeayT0tbPpkEImmjX4XzHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

This field is now unused, so we can remove it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 configs/targets/aarch64-softmmu.c | 1 -
 configs/targets/arm-softmmu.c     | 1 -
 configs/targets/riscv32-softmmu.c | 1 -
 configs/targets/riscv64-softmmu.c | 1 -
 include/qemu/target-info-impl.h   | 2 --
 include/qemu/target-info.h        | 8 --------
 target-info-stub.c                | 1 -
 target-info.c                     | 5 -----
 8 files changed, 20 deletions(-)

diff --git a/configs/targets/aarch64-softmmu.c b/configs/targets/aarch64-softmmu.c
index 75d95b0e743..2200a4f19e9 100644
--- a/configs/targets/aarch64-softmmu.c
+++ b/configs/targets/aarch64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_aarch64_system = {
     .target_arch = SYS_EMU_TARGET_AARCH64,
     .long_bits = 64,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_AARCH64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/arm-softmmu.c b/configs/targets/arm-softmmu.c
index 73546fa5737..9d558a0c1a1 100644
--- a/configs/targets/arm-softmmu.c
+++ b/configs/targets/arm-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_arm_system = {
     .target_arch = SYS_EMU_TARGET_ARM,
     .long_bits = 32,
     .cpu_type = TYPE_ARM_CPU,
-    .machine_typename = TYPE_TARGET_ARM_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_vary = true,
     .page_bits_init = TARGET_PAGE_BITS_LEGACY,
diff --git a/configs/targets/riscv32-softmmu.c b/configs/targets/riscv32-softmmu.c
index 752c813077e..c1d94679c7e 100644
--- a/configs/targets/riscv32-softmmu.c
+++ b/configs/targets/riscv32-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv32_system = {
     .target_arch = SYS_EMU_TARGET_RISCV32,
     .long_bits = 32,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV32_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/configs/targets/riscv64-softmmu.c b/configs/targets/riscv64-softmmu.c
index 5150f0fe9d9..f648a5c8944 100644
--- a/configs/targets/riscv64-softmmu.c
+++ b/configs/targets/riscv64-softmmu.c
@@ -18,7 +18,6 @@ static const TargetInfo target_info_riscv64_system = {
     .target_arch = SYS_EMU_TARGET_RISCV64,
     .long_bits = 64,
     .cpu_type = TYPE_RISCV_CPU,
-    .machine_typename = TYPE_TARGET_RISCV64_MACHINE,
     .endianness = ENDIAN_MODE_LITTLE,
     .page_bits_init = TARGET_PAGE_BITS,
 };
diff --git a/include/qemu/target-info-impl.h b/include/qemu/target-info-impl.h
index c917d546eab..cf42aabbc8b 100644
--- a/include/qemu/target-info-impl.h
+++ b/include/qemu/target-info-impl.h
@@ -21,8 +21,6 @@ typedef struct TargetInfo {
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
     const char *cpu_type;
-    /* QOM typename machines for this binary must implement */
-    const char *machine_typename;
     /* related to TARGET_BIG_ENDIAN definition */
     EndianMode endianness;
     /*
diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 6c5b714288e..b23e5bc5865 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -23,14 +23,6 @@ const char *target_name(void);
  */
 unsigned target_long_bits(void);
 
-/**
- * target_machine_typename:
- *
- * Returns: Name of the QOM interface implemented by machines
- *          usable on this target binary.
- */
-const char *target_machine_typename(void);
-
 /**
  * target_cpu_type:
  *
diff --git a/target-info-stub.c b/target-info-stub.c
index 22b7911201c..d121b8c0170 100644
--- a/target-info-stub.c
+++ b/target-info-stub.c
@@ -29,7 +29,6 @@ static const TargetInfo target_info_stub = {
     .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
-    .machine_typename = TYPE_MACHINE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
 #ifdef TARGET_PAGE_BITS_VARY
     .page_bits_vary = true,
diff --git a/target-info.c b/target-info.c
index 04c69c41f8a..012b384036d 100644
--- a/target-info.c
+++ b/target-info.c
@@ -32,11 +32,6 @@ const char *target_cpu_type(void)
     return target_info()->cpu_type;
 }
 
-const char *target_machine_typename(void)
-{
-    return target_info()->machine_typename;
-}
-
 EndianMode target_endian_mode(void)
 {
     return target_info()->endianness;
-- 
2.43.0


