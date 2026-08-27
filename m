Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A78C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziSf-0000d0-SN; Thu, 27 Aug 2026 18:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSW-0008Cl-5U
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziSU-0007k3-0b
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:20:31 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM6GR1803764
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tRJogJIr5rF
 B23w2DiHH3okXiLmhBX88gL0+8xj2zso=; b=VSpnRZA4hHlQ/qpwmH0jtJfK7Z9
 QXe5XeS99YNJ2kBdocvc/esJvWo6oMkvthXGM+8avjwELgqvehrqosVM6w1BSstq
 HimXNQtPBG9db3Sap1w2HyNsMyA4nSFc0Izt+CxogTHpiA6Pa0wfbF5P6hTzUYj2
 pe9lV8gvlzp/0EWyGas5MvpkJ3wImxev2tRjNloqlxR670ss0ulXh9h/6j0WlN1g
 qTFRT+oTzCakvHyi4bcovEew7+/cNJNhXLvRJqoWWXwX98oCy3DX3OPb68tfN4FS
 hbGWJs9zMhsFGkBImwSa6NVvP4/mIla/vKuiVBfDDl/rh2e/j4sotLizTvw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatfxgvn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:20:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-395543dc382so564021a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869218; x=1788474018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tRJogJIr5rFB23w2DiHH3okXiLmhBX88gL0+8xj2zso=;
 b=Djkf1TJHs3PuRYyUsPKuPvnvU4GO9EkGAHiaL8imQopdBwf9gDvXsmBJfP0K9p82bG
 nXlXe/fPXZb0IeCGXfFLquH7kAn7KAcDtRlK/6FdG8KKPylnav6pBv3aOoxZ63uDu4uC
 GUIIlgT6oy6FkDt0EaXet1DUqQrCiEYvDJdJFfVLKw9ukHFV1oc8mFHsccZRjr1SkFxs
 6uUT/GnBSg00x6CJQc0gLl/U1vsYSP1ROQxotjEUJGHHD/s+7Coa2KpBZT9QfCJAb1vh
 LXMU85Td+zirZsPGqGpXk4gPNgwxEVlirl0Lh7XciNvjYNL+8MbjFmXj2VuSi3JNaCVC
 mtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869218; x=1788474018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tRJogJIr5rFB23w2DiHH3okXiLmhBX88gL0+8xj2zso=;
 b=naosVn8dpRr24bXbJX2hKHOWoVrNu4jOGg8pD8qSG+eAa/xCFuOJCjJ7rxudyeCf2s
 tyqY/Z5AsyCvuKrCxfY0oLqIMzmJPqCIlv6/LG4TbkD67bkLYn+t1BxpFMgXKBPpwa4+
 X49m3xDDIBKOuPGkaCALJ040yBJuLNRLSBEPMGkKfwQYKNeZ4oRnvUgLEdPNwR1QOgY2
 1u0ltRw2qLbpz5tXM4tmHc7Eh2SoZxZGWZYc095R43ijSzppHCyJG8xHIIKjYiEKeq1J
 j5OtWW497Y0g95XQF3kMVNSeKsiqz6DUaCQirFkTBVskj03vFDyylfZso3Zbz2O+StcZ
 /c2A==
X-Gm-Message-State: AFuF++mmP+cpxUKdwekOwyTkZhiv61HL3jXHubIQZE9T5PB+cZBoBZeS
 alO+Ul9ByJQxLCGmQCq1lwBwLpuapSwk9510/f0eoIYpEbF645JrBQt/KxNPaU1xFoj/dedxmf3
 V/bjduSuZAyCXt3ai3TlXJgYIIhbcBYUJCoxSQqa4FgQfHuAf2yVg6Fri3kLkIDw2Gg==
X-Gm-Gg: AR+sD12L6aymQ3x8j06IyfA4qFZzTuhWEcmlTtndV3JcrxhkB+agJrWnV60DSmGKPYk
 LFxkf7HdCBIdFZQTFvf9XAEZYM/53XxLkiUnakxLpnlO4q4VuuluwrvUG/ELHCCEt5l6fal/1bE
 Wfw3gTkbvns49B0hL1HRNLQ8YmCFp3WCie/Wa88G7thFzCofQcnbRl5+VZ0XbO4HjqZ5WFoX/Tv
 TcUcL+tjuQGT6MGyw0BN9I+K+hH/EHDdZa19YibnERJ7sFK5J17AOUSuSkj5EM33FaTRl3ThhCB
 43VM+hJo2v+pYEYEgXVN2k1+A/V2gJitekZyXHxWD0WDj06/WR2hXNT2FkgnYA74Rx9hy5nlOnj
 cTeWXc6UJGu0VmBz8VAZsF368ONDOyXqoUl3xM5USws66eNGu6X0jYjQMeQw=
X-Received: by 2002:a17:90b:1fcc:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-396d0f6efc0mr4444331a91.9.1787869217700; 
 Thu, 27 Aug 2026 15:20:17 -0700 (PDT)
X-Received: by 2002:a17:90b:1fcc:b0:395:4e0d:bc60 with SMTP id
 98e67ed59e1d1-396d0f6efc0mr4444232a91.9.1787869217260; 
 Thu, 27 Aug 2026 15:20:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0fd55a4sm4466925a91.7.2026.08.27.15.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:20:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 078/105] tests/tcg/ppc64le: user tests
Date: Thu, 27 Aug 2026 22:14:39 +0000
Message-ID: <20260827221506.91574-79-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UKLt2ify c=1 sm=1 tr=0 ts=6a90b822 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=xUnFrxDuBQSFVXqpql0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: KrzqpU_FIz8t4xRJfRgEWGOBsslTqTmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX93M9LEGBGLl8
 v+MVy5TPDKhJYT7Gi7WQlGASgqKza0lHvWzKFHD25WcnZTWSfszw4gx9HR4DLfN3oqcwF+pnqv4
 RzG0zlWJdpeVj9NXG1M58DUcsQZNVwJv+lKdfX1i8ADtbhGeut4RJcyBTdn9duHGuIzMnGq2+Rq
 9j0ZPUy/YxnxaOdVfoW6THYt0cF45QN5Yo4snvlIpeOAa+bC1/oL1nP4YRJIE7bSPgWpiqIKFSB
 ZVRX6jVrKAyuGbRjxYjRakDEYWPrp0GRZyC6rtk1nhedFnIkfE+QGkWX2t51ckWtuAp+YThvvt1
 0KR9oXj+XF+FaTpSitfrVfAxWq+sAt7NRpHtjjNgPQigJwPn/K2db6T4dErkHlaXYBumBXc3uJr
 woRRQMTLi3u2Nj7jHsv6ulPd57H0z7Xuo9QOsT7VRpBAAQjsvMcmSis12xyj7V72KXA58ujvV2A
 imF5w8HMOeDMWlvQ1vw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OSBTYWx0ZWRfX/MiQOupniAf0
 6aU91JLG+SBQVyDEcvCekUfLqIF8qDt3Omptlf6t0fuLHXHrdPJy7fT+ngno8w7wTMOZRL7OPXF
 rpmBTFns+lsg0j9uT3oWjQBYW3Z1OZQ=
X-Proofpoint-ORIG-GUID: KrzqpU_FIz8t4xRJfRgEWGOBsslTqTmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270189
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             |  1 +
 tests/tcg/ppc64le/Makefile.target |  7 -------
 tests/tcg/ppc64le/meson.build     | 14 ++++++++++++++
 3 files changed, 15 insertions(+), 7 deletions(-)
 delete mode 100644 tests/tcg/ppc64le/Makefile.target
 create mode 100644 tests/tcg/ppc64le/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1d1986f5c1b..f13f0d84792 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
+subdir('ppc64le')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64le/Makefile.target b/tests/tcg/ppc64le/Makefile.target
deleted file mode 100644
index 00a0cdba295..00000000000
--- a/tests/tcg/ppc64le/Makefile.target
+++ /dev/null
@@ -1,7 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# ppc64le specific tweaks
-
-#VPATH += $(SRC_PATH)/tests/tcg/ppc64le
-
-#include $(SRC_PATH)/tests/tcg/ppc64/Makefile.target
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
new file mode 100644
index 00000000000..720aa167f23
--- /dev/null
+++ b/tests/tcg/ppc64le/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-ppc64le' in emulators
+  tcg_tests += {
+    'ppc64le-linux-user': {
+      'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64le',
+      'gdb_arch': 'ppc64le',
+      'qemu': emulators['qemu-ppc64le'],
+      'tests': tcg_tests_ppc64,
+    }
+  }
+endif
-- 
2.43.0


