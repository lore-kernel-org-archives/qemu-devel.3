Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90208C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ5y-0004nX-Be; Fri, 10 Jul 2026 17:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5b-0003ZW-GP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5Y-0004r0-6L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:48:55 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Wjf1697476
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OvT+pjKczvm
 ibpKPgBSN9EVs4MINWzJqiXC4tjcouNo=; b=BSgbiOF/0VKf+VZdzZTtGk0HMpi
 x9Ep2d0EclY115+ANxFjI+MYViYh/xPFtZPFkHxneWw0obWrc2cNU6mOSVwMpeNn
 T/7db1etKBcoViZLlAJs1x1yDKllCwJMRxLlu91PaVJXamuvMcpnSHC/YmNtt9Wz
 e5tSkao0M/lQe2WMnS2ECi0roBVwrXglG042kaFa2TOR0UEtCSipVN35BDTvpbA3
 t8p5mNIB3x9pXISKxoD3qkVK6IDpOaUdg6A8rN+ZzzMnZ+vTCYQZpTFTNAky5VqA
 KXVLJmyKVQjJrwg86W2uFlJejIY6s2A07LpM0uyAFr6j9DmowQnxDqv7Rpg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djh3n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:40 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3812b0c6f23so1586503a91.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720120; x=1784324920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OvT+pjKczvmibpKPgBSN9EVs4MINWzJqiXC4tjcouNo=;
 b=T06LXn8bKyIuChOFnEW07v+sk1CW9tgHvaXQ59Yp1ggdlFPuzfndptMo0TBlLPCmSZ
 xUE+o/ZlkT1YX2AQY+L1od52wWWnFpy+nL1QI5oFFY6gB2cTDArQdNzyDOMX8FriDujs
 hm6+lG6uXknWgvbfCw0fOXmz0zR7khQoqm9K+otAFAnyVx/f6oDFt4eEoyThqLkiPD1+
 hAViLgNvTfW5SzlLcdi3ZSsOo7Kg8xyMyMEvhKkQI1/cEEVYWBzEeYNr7raFVBLj1Yx+
 wPoS7852seBsTKUU4bmWWXqvSsOpNKo7lvjjpIA9j5k01MUQYwPxPidi6kAz1osXOSr6
 gnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720120; x=1784324920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OvT+pjKczvmibpKPgBSN9EVs4MINWzJqiXC4tjcouNo=;
 b=J6XtFR7c/WIySQ8nXzkbCB1KHORN0NzlMfJVWUuSYWg0vwZ5ohE+1+aau+0C1Te0Bw
 roij+smN9D5uLCtjbVmaFEFJ9eNuxL4wJzZZE62OfDdAgRGK1KNErrxhx18YaQx5VvEr
 bWpfcw9mwHRsNrJBlNEPJwc3+jHoIA6BtfP9bxut1Jdk/UleCxq6Hxqi4mKjlU6Qf26N
 fEQ7hpvLnDL6z9QRzjEx9lMMaMVfBd3BBEIP4zkkXzlSeLHcQ/wWKCi8iGPWBC7sB1PT
 vzp5LRMXN77rqBwu4ErecOjLA+MOiO3t5ffUtTUpkqj5rVZQ6d5q5j+WLFixavAW6ZpV
 7l7g==
X-Gm-Message-State: AOJu0Yy69blccZqeQIM/KoxDEMyHkp7cf3P0OvFDEkaa0dxgYB3FblOL
 mvxMT2MmnK+BmH2yhibcvtyDKml+nxtT65X1/rWd2PbWJnRZBB/O365GdIGe1VpBJzALWACX2k1
 Lfp+XiwuTPwsJ3Ud7MKVYgjYuDfkFugaVN7zS5meKZEcsQwvqqbiQ96Wh5j96B3e8QQ==
X-Gm-Gg: AfdE7cn2PlysZf4OgnRJQqwgZzSMjseM4Jd3U3epqpq57Ed4Bx9od4ksQp2UY2/rDqU
 VXB7gfyehH0SE5OC7oxuBYr/bftZyxKsWnZ+L3R4rrkU3TlRldsHhtY9jtFDgxUZNsuYNlKuwq/
 B+7ECQ5uE0ZvHzq1+moFAK2aZUX9M4vb1QoJkjW4RITt0wRHjjPDjnxVkDtsuJESMizo/TGV0lU
 x4OlE4+egmHrZqrF4tYgml9GiC+z1o5nXxs7TAW3E8wc56Dd4pztkbGxTZan+1jc16sn7J1xVj1
 2NTJ6TRFlUm3bax5j8jfCoWmzoTirqTUBFM/EkKkBlHT1Et9MQFEz17TN79DmotcYkeNNf16P/D
 BtoU8gkumCPyCluMzpadURdi7P21rxF5IZumRyaoRgPq6wZzIzsGn+Dgz2atXrMaVcvea8iOG+G
 g71tGkow==
X-Received: by 2002:a17:90b:3c4c:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-38dc74cf348mr570995a91.9.1783720119943; 
 Fri, 10 Jul 2026 14:48:39 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4c:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-38dc74cf348mr570971a91.9.1783720119495; 
 Fri, 10 Jul 2026 14:48:39 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 51/98] tests/tcg/hppa: user tests
Date: Fri, 10 Jul 2026 14:42:55 -0700
Message-ID: <20260710214343.2065491-52-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXxYxfrYDt4CDe
 zGvFSswAOzzUyCOuW16W2t4sxz4lPmvndfjPgsrn7RtMEFfVbL1+mpf8Ja1O46fY0JBOmrYLzTP
 JPgJdOvHQWCOhBDSNkRB2q3F2dWVVWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX8aUotoJZ3oRd
 EbTF33OnPs3iYahssc9aTJdROkcew9wDNrGxdSDzKOLHZ8q1y3YbEsGVWZUZbNpgnWIUNa3xkdj
 Z1xOERrMlrraPDWXNfmhi3IZi6JONbJN+I7Vf7AkdZ0PkmJoCiAFv4R4LwUamZIzxd3GOKzc8BW
 vTEr+zYp6wH/2o14PA1v44yf78ZIoPc+j3wRhE+J42yb6po/LjCOhfB+K6VLQwri1bvp0UK4xCl
 SFV1p48QcuC54jIXtY8Ay0BJR35HNotN/OFmmqA/FkXCcWV9/S4PAoSHceiB+lJqTU5SlzQ9bg8
 sjYwvGiDDYq3iZU5j+klxkD9NAOArjX4/n3MtyDJE/AwgobYcR/uQhNv1d5mnu+x4RHev0djCAO
 MaeXlpNMlpIJEjLYyuYwKqj8LOkWESv3aHijpU5jWrw6gNqPaAEiOpv0hAOv9L2YJcZ2CbE1XcJ
 Vb7FXvxsWRC+iOhqTaw==
X-Proofpoint-GUID: NYLGjET6WHZXU9_-Z_4gZ6-OMVuZ5JPz
X-Proofpoint-ORIG-GUID: NYLGjET6WHZXU9_-Z_4gZ6-OMVuZ5JPz
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a5168b8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=Wtfs_aKp8OXI5K8l3bAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hppa/Makefile.target | 14 --------------
 tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
 tests/tcg/meson.build          |  1 +
 3 files changed, 23 insertions(+), 14 deletions(-)
 delete mode 100644 tests/tcg/hppa/Makefile.target
 create mode 100644 tests/tcg/hppa/meson.build

diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
deleted file mode 100644
index ea5ae2186df..00000000000
--- a/tests/tcg/hppa/Makefile.target
+++ /dev/null
@@ -1,14 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# HPPA specific tweaks - specifically masking out broken tests
-
-# This triggers failures for hppa-linux about 1% of the time
-# HPPA is the odd target that can't use the sigtramp page;
-# it requires the full vdso with dwarf2 unwind info.
-run-signals: signals
-	$(call skip-test, $<, "BROKEN awaiting vdso support")
-
-VPATH += $(SRC_PATH)/tests/tcg/hppa
-TESTS += stby
-
-stby: CFLAGS += -pthread
diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
new file mode 100644
index 00000000000..9ca8f29fa93
--- /dev/null
+++ b/tests/tcg/hppa/meson.build
@@ -0,0 +1,22 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'stby.c': {'cflags': ['-pthread']},
+}
+
+if 'qemu-hppa' in emulators
+  tcg_tests += {
+    'hppa-linux-user': {
+      'cc': 'hppa-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'hppa',
+      'gdb_arch': 'hppa',
+      'qemu': emulators['qemu-hppa'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e6206ae670a..018bc480e18 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -138,6 +138,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


