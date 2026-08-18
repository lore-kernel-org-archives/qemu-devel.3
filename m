Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D08C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPUn-0001rY-7E; Tue, 18 Aug 2026 15:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUl-0001gG-2Y
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPUj-0007fZ-4x
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:29:10 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGmLR2494334
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tRJogJIr5rF
 B23w2DiHH3okXiLmhBX88gL0+8xj2zso=; b=CK40E3VVJfmlZO5YFv8Tf62R2os
 OdO/gVQ33BmJox4W3DjI3Zn6w0RYCf4hEbnPND4n5jXl3B7s28oE0nIcY8Xt/SoB
 8eoV5Y2r/jAoorQxBsuoZfeCkT9fW7tXT8khheHzmzb3CTPhkTLxOxf4lB+2JMZ/
 J+rBJj2gmSADLHzjTAiD93Q2vcT7IPe86bT8Kwb8E4eVvxeRAbKBlwM96kONjFTR
 I07AI8q+wwrwMu4bQF6orE0xR/SOx9gVzwePmOs0I7Tl1hDv+2M/XiWFTT8l6s2g
 R1mfd4N7hetBxk8GbXK3vGwaGjF51vidasQ6xcCb9LOTRzJ3Q7Iewc2wVrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnhasa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccd1958e8fso2545655ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081337; x=1787686137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tRJogJIr5rFB23w2DiHH3okXiLmhBX88gL0+8xj2zso=;
 b=drJxlsxKilbtJi7SNiwXnEs42NW9FlE7gUduSNbMJvKFUwbo6vBgjsj1Rhqx1eP1vN
 D110kJEEFT/o5Y4DkrdUh2sR3i8HoBvvMbJdkoHqcvQr+ddu65YXOdDaGf6N1wMyhNmk
 HT6Utkmjxi2B2Rw3IjKhHgOJfB3cEIziUfqGyIndLEtDB40eAFgw1uOeNADtWYpmGdO6
 UUA722bK3DAnrtzxZlQAsRQYi+ABLXRMlmjttvO/UxZCCcTJtjU8VT/OeS0fnBs6L4KC
 rZE/+kcPHiNwG3wywy5pwCvSZBOANyVGnGglwiUc/RK6nEHqm69/yZU7wp6weUCHjrhm
 95Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081337; x=1787686137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tRJogJIr5rFB23w2DiHH3okXiLmhBX88gL0+8xj2zso=;
 b=rfxnVd0ukg3mLfgLZC4jftZKzlw+cbF4LQJ32Hdszcr1Oq/K+RLnjV0OUyXNt3+bbB
 Zu7CQdbyNIJ32pEk+LWpjfkaWgUEjAi3PHov8cHR2GI328U6fvs3HbBRwvNmJe7Cx9+8
 k7suW64CM6n+3j7TBMghNJpFlervF0j8XdPZ+GqqhJYCec/hEJfuZjMKFCMOuDNqsc4Q
 Q6e9B2uKRr/leoqngx69V4FBOGY9DJYqkh1u2+FAGd7xplBTMluxCA1nXjPLNzVuBOTs
 +AKbpa+JrdgS3uHmsjlLsI9a0pugoPBbM1VNFOZ2I0Q1SrGDWL//PRClJKcXVr9IPW2A
 Nouw==
X-Gm-Message-State: AOJu0Yy3kyl6tiZLhmODfSgI1QHiJRAzJSIAQbRtlQYpFoGypN+p4AOU
 luVzciSlqh9kdrH2I/y8RBQe1vGu6eGSIukMANe1C7OwuNko2+eg7PVV/A6d7Mnz48i8qQ+QTdS
 Kwxwwl7xL/YMwYTqF++K0/4QUt3W3TdNKWCHhQa5Fea4eaKGJNqDRS9kTtZ21fqM+Jw==
X-Gm-Gg: AR+sD10kN/HV4wpQNtu4ZAyl8ekPmxexRoNGnVdo9vO8dcrtpjCiR6+PWn0Xmiaegnw
 nNJjgSdaayteJ4QzUS0oZuiJTyQ+52Rk56k7X9hE2Alw5/f4BiIfWzr7VieNAB8GZ/YIcto5uFW
 7rOSDiGNtUfVAhhOsRZJTpuYxR+MKTqdLRiRopQ/IHcTaTNUnc6FWR0gk3D4R1HeFUUX53KNLWh
 5VfY8WadKuWOVZt3L/1zT025+MGxjSc5FLraW4o0UmlNmK7ZQmu3OjH0xrG786+y6g64ASY+ZEZ
 vUnC4wobrv4PEGzkfWpBy97ImP1nitwXtMe0xQ8DAFqg9aviruZcPciCoYeG9JSf2eDjNqneVtl
 sZV3bfYt4qlRgxaPKjCzLbNCzY5tIissxDGCQX1CxiNQ5BmxGMRMnVEsfrMA=
X-Received: by 2002:a05:6a21:2d46:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3ccfec0dd57mr359624637.2.1787081336854; 
 Tue, 18 Aug 2026 12:28:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d46:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3ccfec0dd57mr359567637.2.1787081336436; 
 Tue, 18 Aug 2026 12:28:56 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:52 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 078/104] tests/tcg/ppc64le: user tests
Date: Tue, 18 Aug 2026 19:22:42 +0000
Message-ID: <20260818192309.22169-79-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX3+A/us8iCwjc
 +vnWdOpzFqGsr7Pt/Q0UBBdINqV9JaiZFnzmBbJl4ylMFMI1w/i73//6dcupHswmgZINEELZYVg
 nZCKAZuktnyN2b2FYqgEp7EJs/bPNDc=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b279 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=xUnFrxDuBQSFVXqpql0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: H2AUEHe9dYXTrh34Lw06ITap5YBMdewd
X-Proofpoint-GUID: H2AUEHe9dYXTrh34Lw06ITap5YBMdewd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX0GtaklnToTPo
 Gi6N5JQuAg4t6iBXF8r3LR56eIwR0XW9gLTPSy+euAYgCb4u9xotuaCet8RIFjexTHtbjraNYC4
 WaxaLPTOZJDbdQUJWFx14dMM7DH+f/y7JOPiuT55hOLIY7fKqLvQlg0ySIY2FF/3sE1+uksPkNt
 uAHhe8QwRNC9b9KsYh5li1ubP9KeRhLBqIxb1CQtpQN3N2ywkaAZjkh4joJFRbMgrFB3HOb3HkK
 40TsU2tktE/+wwih3quZJf/q3PXXr3wZ3h6d0QgYHl49/1WEONh2rZZxO8cM+WjqVG+bgQ6xQ/h
 qlxmqgh8tD1LHGiHuoe3fewJs/wv+UDIE1/Sclquge58URyzVQ8NEw3JAXO9NGZGtiAX9ps+0Uq
 rxIEkjuxPo65kEyvZeZeHFHzs5+LYIJV3U/1Wl9nMBzwVcTjcgguqeIpr1dpJNs2o5xL7wQYNvY
 NmraQbZZeTS2ZElo5zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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


