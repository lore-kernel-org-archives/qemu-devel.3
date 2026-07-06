Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DCDC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru3-0003mF-Pc; Mon, 06 Jul 2026 18:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtw-0003JF-4e
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtu-0005es-Gt
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE81k1654885
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=C51sAKGnH6H
 +vJ8U7R68O5eMYIdU79KcxZxvDwkzbbA=; b=IOP28x0YFSetJ7pl9bSYWg0QZ23
 +p56iWWkWDNjaxGsgwvi7n8iYxMi6r+39BTs4WI9Q++OxrafwLDcnkwZQrj7jA9p
 fRl81YDoLyTAF6sSoPyzS+xHrKXWFWeMVho9zdCNQ/6DITwP1ctG4nPdHIFrcBOn
 W9ejSc8ekzi0SclJFxtvXAF75oGk9C9n2XVEyX05ssDkt1NHV3RGWO1Af5bUu5Om
 jUD7wrkqoZD6TmDPXl2HWI4a0YUATSeo8iVOQacF8AjhDGi9SXZz8AsWaX2GXnI1
 vGYluTGiN2Tu2DcqSy+06PIrtAwgy7I6K8intpkLtA9jvEba8SQqfjwHVDQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk8j9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so51346745ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377282; x=1783982082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C51sAKGnH6H+vJ8U7R68O5eMYIdU79KcxZxvDwkzbbA=;
 b=Wehy8yCd9Jw6gd+0eTkYsNqNMgLCfQTeWW/nBHp4cgbfd5h4v/1tgeezlMl1ZF0CY9
 +8dOc6zukgWW+M5Y9pfHHyFzUr5ppIwwS2kA9dwmlJ6ozJ/bWid3L6SZ2NWWY5K17w1F
 iu7k+m0OOnmORXbbNm/DBx8+tSoXQqFIFCCpeHDk22JMDsLMeNwen1Btt0Q1j+cZFEGH
 qD++rPaTTgbDZPuLWVSqwuYYKBNBL3lvWfcyaaWL4x8GR2PmLYqY5Dvh7Jep8AECSufL
 V4pqheQW2OgEsqI1Zh15tzE96nbCVfBE3fok26hkuQGzoc3UhrJbhtsMV+r3xk+8rQc7
 hoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377282; x=1783982082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C51sAKGnH6H+vJ8U7R68O5eMYIdU79KcxZxvDwkzbbA=;
 b=aBymZAR5P8TuhWQPkJCs+fLFlw9Nlblk/iu4abBkHmA88+kO2Es2/yTp67uxN6aUh0
 PavoskEsV0T6p8NwD+fD+T86DgSHX+IjoWsDHVloiZ0hzldcEzlR/mdg7b+gIYKKoZSI
 f4FmPhQn3AAeLyKY5aFMx9D1OTFxr1BEf4zYR7patX165kECj5bxBsuJdnbtPhvaSKjc
 u99LwzPj9JWS2LgGIPmyvngOvlJoJjrPjpPZDMXDk0uihEKW2NR/P2g7f1k3wlDFkoHN
 Pj5nHEL42Edqij7zqoMIV2nImEYEcxTySzhOOt+hV6B0JWT2EQmS9AC7KOuTAUczPZ8+
 r9Ng==
X-Gm-Message-State: AOJu0Ywlpams0srivxM/qjGXmfxYB5X96NEl9fGKiwmT4Sj694BS5VEe
 8d9R1YpNDQgmqNSV2fsIVeyI8apvTLkZCuAfFoWUO/5hV9uPJo3JSW6n2dlfaKkhJtWjul9hPqf
 n8F3mIOfEQB4sOomnDlH+0qrm5cObihwC5WvJZOHC4cY1Ok1T2Ptj99G4aazRrPCBpA==
X-Gm-Gg: AfdE7cmUAEXvpIYFsd8WlkOp0zJYJgnM5lPE3CWyecPLopNQqxT3MqYfTN281fOuMP5
 dKraM7u3zcGf5RLoXn0Ea+5cpgla6U2KRYIYCfE5QZoHIQrMlCZv2VOe2vuyt4H3yeL4Ll5AlT7
 6fqdy67lSCntRsiBNXDRx9JI89v09s+ivOOWk54TDfx4yYvZP4BqezGb0sfjoAVdO9vi0CofK1l
 H4RJpLpPqlspzC4uXhMG4yttfS4T9SkrFMIlgeWAyVS3CNElITuWomsfDRE6nTy3JKoAQ1z/JaC
 24Ll4+0n2on6MDZuz7rej7EQOtmCuDpFGPGvlX9/9qi5JdEjacLaMXLaRFlyK5OdCOwQryZW9/t
 sg1EVrt8krlsF1GPezyXimrCXLjQKarrSxSzbHadyeZyx8H1wUYzGpYS13hoF34Z4+G7boUziaV
 0b6ntA8w==
X-Received: by 2002:a17:90b:39cd:b0:381:85c0:1d88 with SMTP id
 98e67ed59e1d1-38755d3edc7mr2722893a91.9.1783377281954; 
 Mon, 06 Jul 2026 15:34:41 -0700 (PDT)
X-Received: by 2002:a17:90b:39cd:b0:381:85c0:1d88 with SMTP id
 98e67ed59e1d1-38755d3edc7mr2722703a91.9.1783377278496; 
 Mon, 06 Jul 2026 15:34:38 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 30/91] tests/tcg/meson.build: add top-level 'tcg-tests'
 target
Date: Mon,  6 Jul 2026 15:32:42 -0700
Message-ID: <20260706223343.988769-31-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c2d82 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=WK-hs4OApzzqMslTwvAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 2GwJtiUoo5uwD_Msi6nNMGnFcHJU5-Zn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX5p3QahqaE1nj
 GiGcQeFWuSPltvPeT92LAfJaDjTnjvbiIfKbDvcKQav5//ux+qd1bS8xjhfHutBuzipP3OFUBwX
 2hS3Prrc24FwVi3HVGLV5tqBZ0RoKUdqgmC2WLtfJV7M+o0VdFBZdWmpNzNDO8NDIrDgywEQ/ar
 LNQ0qQLmnSjVrlK+vCzkKR/EOtLE6WCcVXrp0lhb3msQKsll2OVXkjusN1crrrAAX1+DANG/rBm
 ayo464yRrx5K/2HwIdn9z0B+Rm5MA9vZxOU0QMOAHtxodnb/mJzhz84JvD2/I6qpswOMsVm3OIv
 +E70fb3qWQA40mgHLyPxNYg0RuOBtVvOEEbIifcNyN+FeWxUoe+qFlY0KevxY2Rluh5QhaudOQN
 Kg0HGC6zqYqsPbUGJEwKADtmydIPRUrevyifFAqh2HSaI3QCSq6LoqFiNNHk5lpBn/8iJotnvg2
 LgNEQw+tHgNVKWiYVtQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX6P1zBLqmrp+c
 gbshWB2pghpFBPZ+s2pUXUuKeToMj5tIvZN1pVFY3XA2qaJwEWTLX5pfrBltRR8589YWdOAzbCl
 +qjrX4p+BV12flsca7GY7L61HLKhGik=
X-Proofpoint-GUID: 2GwJtiUoo5uwD_Msi6nNMGnFcHJU5-Zn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060227
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

Add a target to rebuild all tcg-tests at once.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1f553a0aa8d..9fa97627eec 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -87,6 +87,7 @@ test_plugins = {}
 subdir('plugins')
 
 image_targets = {}
+exe_targets = []
 # Finally, we can create all test executables and test targets
 foreach target, plan: tcg_tests
   # Detect duplicated executables/tests, and report an error to force user to
@@ -283,6 +284,7 @@ foreach target, plan: tcg_tests
                             depends: exe_depends,
                             depend_files: build_test_depend_files,
                             build_by_default: false)
+        exe_targets += exe
         built_tests += {exe_name: exe}
       endif
 
@@ -364,3 +366,8 @@ foreach target, plan: tcg_tests
     endforeach
   endforeach
 endforeach
+
+if exe_targets.length() > 0
+  # finally create a top level target to rebuild all tests
+  alias_target('tcg-tests', exe_targets)
+endif
-- 
2.47.3


