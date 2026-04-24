Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4063AFF885A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGPWp-0000tw-Sv; Fri, 24 Apr 2026 19:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWV-0000nd-Ug
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wGPWP-0004Yw-58
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 19:01:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OLp3Zg1681586
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IuS33lZ7Xfc
 xW7B8j8VxD5ntv5c20cW9NAk8gPPHNVI=; b=I3vMco1/3NONYyuUnX/x/NKea8A
 Fvjd8ppoOXFRY2IOtPcFP9gLin3BzcL0AS/s3bNEO/x6VnrDoFkX1KKK4RZLqy1h
 /niZV6SSby/mGTNW/HvTRBGnfxgVY8Owvfp0elgTKSuuM4aPvynrtiSy9ZuvgEvg
 KO27g3FHvhW3KL/K40w2zFBoX3BAu/00pMe0L0NiAfcOuJW45JTFIq0qzjblwhMK
 yFxdWXWw3XKXLCvduQSs1ufemJPfq6INBoTN+FPC88ol6VfarglrFy5TRZj/UAob
 xp3hb5GeMHHBkM4C9x127L+BUCW//wAHeP14VlK7B/hli1iXhHRGq5RzTTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drbr599kt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 23:01:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2eaed3d96d7so198663eec.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 16:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777071675; x=1777676475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IuS33lZ7XfcxW7B8j8VxD5ntv5c20cW9NAk8gPPHNVI=;
 b=TDevHutI4jiKQj2LIhG/iMV3fTpvTFaCuHuf01wKc7tnMBmnjQbJ3Woxtp04LfUPJV
 QBLtxl+LYCeEfIN9jeY++lJKhsGntPW3IGXmy+Pd7gkIfGioiZlGAAa0S4YMEYwh3jHk
 qC8RjmByNN6Y3xRqURLyq2MF5JUARGRz0J9/HtOXcXRRJASUYjpnNK8JlLfg+J3H6d9d
 INjCgYkZR2U3oya+ZjJhoAoSllg6n3JIXCL7SwEaIxawiueIHYwd3xQqQS6h3iU2giNw
 3lt5UJ+L393afiLp2xMl4GnLTcLrTpFt7a5Ef9tda4c66fW8zFzBtQRVQUibZagz0EtC
 buQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777071675; x=1777676475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IuS33lZ7XfcxW7B8j8VxD5ntv5c20cW9NAk8gPPHNVI=;
 b=fGshY/bBWse+Rw2/buahcUyjP/Ardl2SeF6r7IM09TAODuXAXL0h1heOUs0SNmrKoD
 x97Q9XBIXUSBNB/z/97PDqVDCsOJ1YmeLDnFHDSMKt/+pRgp/Fto4Qf1a52nusY8yuuh
 k55sEh0IP25MTNl9P1rCDkOU4zjzlWZhefJYbhHXfa+2ORKGXNNza0bGOerq6CAisgJO
 sNKFha6uNGF3J5nJGZrFe+MBF2OvJT18dc3KngRCqFBiLsZ81owUh0yv79kUxjNrGBip
 NGB5Wc7v/CEV1uFQjWtljthc94D0XkjA1ZlWlqeuGXivtCnOhoFVzT5I01Loz42CHMeE
 8g/g==
X-Gm-Message-State: AOJu0Yw6p4vtvNsOqPbNxqF4aN10PeaZkUgECpcIY2gWKapWZ1D7viuS
 4HfdTKH7siWgK4vaXGhp9wEboue+VJblSnYlE+KS5DpUMsSMOaLCPBh5JDkKgqiQm1Wd5VZnAnW
 t+i3xcgvpzYVukGtQtN2CtWGW3uebs4lXYr2UTGzkPXDRoTlafg3wVGNx32pZ7ZHkDn5Y
X-Gm-Gg: AeBDieu5b2xRXcFOksMAa14TDKVdVYwjuLIDNrZU8CCEFJpKUsBx5/Pq0vvpT5WPYZx
 xiIeKQtUw5yysYv8B4S6PwztbiZgQQ8pT8uJ/4QOJKrlNmPtBLjGxi4CZsASAwt+N2sWGXR6uqT
 SQhH6C1RvYHHDRoyVX06hjJN0bTV8aX76mouuG/FfZDw/XLMtsfcHk3r4JGgpZxW3ajtRenh19/
 COnGb1BRzrXgs1bHgC49W+DSLoemixAQhvSZZFkSKs8yO+ZTJRrXsTRtat2vD9nk+0a0CYGtfWs
 lIXarKl4qQKjO1+OddKYOVg/sR/RxWrfucSdgtJaV5mlmXkFB1cReOY1qRtYKm7oBA97lqZsoaM
 XzB1VDCrBCD/78LQN2pu+W+wQ1R+dPeLOqMZfLE/8N+feUvSzqeZEZIuZqoX67/2KeOy59mS9zM
 wkmOhHNCeZch9OECZx
X-Received: by 2002:a05:693c:4011:b0:2e6:e916:70ff with SMTP id
 5a478bee46e88-2e6e916770cmr11380237eec.28.1777071674279; 
 Fri, 24 Apr 2026 16:01:14 -0700 (PDT)
X-Received: by 2002:a05:693c:4011:b0:2e6:e916:70ff with SMTP id
 5a478bee46e88-2e6e916770cmr11380211eec.28.1777071673306; 
 Fri, 24 Apr 2026 16:01:13 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d8b944bsm34075003eec.28.2026.04.24.16.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 16:01:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] target/arm: define stub library
Date: Fri, 24 Apr 2026 16:01:03 -0700
Message-ID: <20260424230103.1579600-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260424230103.1579600-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDIyNSBTYWx0ZWRfXzPGu4sb8O9yi
 HQmDbWuCVQhN3kuvLDqnnEigx9ZT6tRgPBNYJfiJFVQtECqFaVxk+XZfQX4MynQhGuKJ8osEvxB
 hFNc5K8eSu5n1+0jBGIhVF8v6RZkJ99CMdLTAZl12TrMvE4mGEJhcqYuplieRjDwxRZeAYTttv2
 mBS+Zg7NRxy59flUkRDpy71Sldb/NQRu62ccocyedjqhUAC7StavwVnU46+Y5ba+PHHIEOTOTvQ
 Eyx88o7hmO+JPgZ03zXXrwPWFGa3Sm3MUjlOW+x0xbhtAfWf0rSCUo0bqCNAzqVzUS2sCQAeAdP
 cjMNAQO/s4WFsgegjZktUTdwJ9bCxUWKWfVTzBUWv4wJSNI3YPiz+cR8hgLDSENu9T64paf8xRl
 n0XpmsBaqHHyTKXzAUjnCnKwYTJgnhRtYIRoldz9huvPGBLmXodEoxsrmGVsXljggnA5zRzODNb
 j6TlXplMWRnS9Pr+V6Q==
X-Authority-Analysis: v=2.4 cv=bftbluPB c=1 sm=1 tr=0 ts=69ebf63b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=gGADHmZ5lr5h4apGqLsA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: mxFm70-1oz7XZaucfyvTaMuAaDYpJxYb
X-Proofpoint-GUID: mxFm70-1oz7XZaucfyvTaMuAaDYpJxYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240225
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We use the mechanic introduced in previous commit to define a arm stubs
library. With this, we are able to eliminate symbol conflicts when
linking arm and aarch64 targets, and get one step closer to having a
single-binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/meson.build     | 8 +++-----
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 192ac7c31ee..4723f9f170a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss = ss.source_set()
+arm_stubs_ss = ss.source_set()
 arm_user_ss = ss.source_set()
 
 arm_common_system_ss.add(files('gdbstub.c'))
@@ -23,9 +24,7 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c',
-))
+arm_stubs_ss.add(files('cpu32-stubs.c'))
 arm_user_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
@@ -39,8 +38,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
@@ -73,3 +70,4 @@ target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
 target_common_arch += {'arm': arm_common_ss}
 target_common_system_arch += {'arm': arm_common_system_ss}
+target_stubs_arch += {'arm': arm_stubs_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 506f031f1aa..80ec9f5b0f8 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -28,7 +28,7 @@ translate32_d = [
 ]
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
-arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
+arm_stubs_ss.add(files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.43.0


