Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB063C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJA4-0002zL-6f; Fri, 10 Jul 2026 17:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9x-000252-C9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ9s-0006N1-Ec
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:53:25 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Gel1621358
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3BpZ/M9+d6e
 c7QF7OgKBpEOVQEVMQRqG6BSoQvgmFZM=; b=Jajb+E/xiyPoxwlMDjL2HaY5ADo
 YCledJ+/V2Sgtdhf2gzQ64NgxGAjGcjfM24ApY3+ThGNQhU88X033dgpsHOyj8GL
 O4nfU3MWL64MXncPpF6xGqBWw4vAOO4QmNCI4ppGUTEtWUFIy0WTdXs73lI5Euis
 lEUnr+zNU5NdUs7TuFRkZqJ1ZHyFXVAA0ooePDH9p0iQ0a1gBJu/WXqMHc13WPy9
 MtLXgLCX1apjkqy0adIdD6ppFH2xDdTGdqgxYDza1au1BWZ6KZee4eKKR3yuyMRH
 Ja7p8CN/1WJYk+mExvj7MAEyyc9m9LB21qx6uLElwszLA5SyHlKHY9SklhA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8vj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:53:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so1588171a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720387; x=1784325187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3BpZ/M9+d6ec7QF7OgKBpEOVQEVMQRqG6BSoQvgmFZM=;
 b=Vgx/YZPpTB6IbeTdg8laMWLV879L80mKDENsjarJQPIpIq/2w5u/ADWA92zMGmIVQf
 SGq1u5u+tnRcy3O84i/lIGuMmOCWWJVPNbxFF+RlibpU7cUMYShGkv91O2iMfcVYZ5mR
 0WkTk8r69MO2almu6exnyGHUlaytnTnXwXKcUURR6IFH6iWhHONKoUBTW25N5dJviajk
 Li6rjGEJfKHxPHbbo4bgVuQNsFUDKbmzEXH4oZHPzmWOiUYd6HaxzcWY8BS83EpF+1R1
 ocZknPGug0A+TjUtHACUcxlCKGFZI2YaXS8V/g36alyrVcqJqYqOukp++8qeqm1eAZvr
 YxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720387; x=1784325187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3BpZ/M9+d6ec7QF7OgKBpEOVQEVMQRqG6BSoQvgmFZM=;
 b=qkq5n4/O5LBlhIydbJQZp4GPI/w7ojObu+T4dztrEPs7vZ0jMmzriyeYyyL6i3kUTn
 LWrlgJN9eHkoWj/0YpzfO7Oz1n9X6tUTKjBdetx+MC7ZBVSiQ09JRC7dC1/1IPrXPe3A
 vITv0Q41jjA8CL5cOa9wtM6Yas6XoF4xK3+Tu5yHPSq3PZP8mAAkAx6PnIrJaL7vxNYp
 2FgNNlVzbAx+Mgd5dKo47xawcLJT6sZpG69OOcoLaACbfMekq84idszw8+F862R8dR/m
 jrSkhLR7UYhCKJwQYwMlZ8SQYPnxRx1nI36KkJMZrcoJQQhfLyuE+gJjmtKF/+Q+0llA
 A7lA==
X-Gm-Message-State: AOJu0YxJM3DdkKecuq419jB9wL8hECr6IC7akujvinPbsbCL+l+Ns1Nf
 5pBBu3n/x4Lzek+wS7QFJV2cSsgUHoiEmi6cnpEq9xojBTI0y62jT22UesLGhXq3Wn40ioB7JvX
 /JOLmcUElSmCg7H8S+szHN2Xg4u/weT5eH+Fb/BlEP+mYPTHQMhU3919pfRyxwzFYxA==
X-Gm-Gg: AfdE7cn7CO1+kF0XTGdLmJcnE6PQ5ta31wDWwK/3ZIV+P2KUe8rDB76sfHHDPRwgFaH
 nHKCnq0hCepI1rYNgKN4Bvz7i01L9ZOeiChTnSeqGWJUjfEJ1z1ZOJ5jZkKZcKzbZosmg43eFv2
 OVc04fACXP9f44bkdrTN+XcjzvTw2cAZ68SPl1IWgiEXinxWDWBlC9wMFPOPkA0nSsDuwZL5/9d
 0emJ+wQNLugDyZIY7gtATYVY+VUEC2NltgFCeEhi+d8WbGQHphSQrjiIb+UIRc7qdo/W+LF7CJK
 nJPj58QSwfyLSjXiuq+7v/rHG7mBGSTs4j3ialZ0t/YeIDWWIQBe6CwJqILit0Hc/XrYbihS5Oa
 1sBkaLlJAS+a0MZhXAq4SWn7C1DvkX8va3kF4hwTijWKFEWx16kxJwGWZ3YtlJZMdj+tXtcQBPS
 BDl6ozcA==
X-Received: by 2002:a05:6a21:b8d:b0:3c0:9c19:659a with SMTP id
 adf61e73a8af0-3c110b7b9f2mr713694637.66.1783720386776; 
 Fri, 10 Jul 2026 14:53:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8d:b0:3c0:9c19:659a with SMTP id
 adf61e73a8af0-3c110b7b9f2mr713665637.66.1783720386314; 
 Fri, 10 Jul 2026 14:53:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311b00048a3sm14268659eec.5.2026.07.10.14.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:53:05 -0700 (PDT)
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
Subject: [PATCH v5 86/98] tests/tcg/sh4: user tests
Date: Fri, 10 Jul 2026 14:43:30 -0700
Message-ID: <20260710214343.2065491-87-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ue8EOL4MwukCqqx6BDSDIFSAKuBW0nw9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX4gUUAZnG/0q+
 WapUzm0KEtz5SC+SLlmwo5u64e1zXwpnd1Q3IH445FXiIkEWnvKERxGSE52hpmz/suRyf4nQ5lu
 1cDskRm08iK92ww0QfErMTGLL2X7mYabjmf0Zc8JKIh7lDVqK0aV5PXGUU8iC1Zmdi/SRTsZU8q
 +cEEuA46HVsBjnwV/PxIA/+M1tsPT+C8AMGIxKIdfngAxVHhpcdvPCW0xQYDq46tiyNBAwCqnOq
 Vazl2tHdwX7iwtMiI0e1CcFzBySKTn+kd5MdAeCZgMh3096UGgxSSq2T8n5mqpN0gcBeX7GAngM
 woZHT8wzHIGlg4ukn4QZvocEqDESw0Y4aTOijxTw0fjw7RYeTmHeBY6UHKSpi51L3+YJesxPjP8
 Qc/C/FuZfjNRKqaisI1c2w2aRVmajZf7CZfvvmiKCpXNfzkS9zCK/zz5plBTqRPY9//l4seyZjU
 fcLRz+gh1TWuOggXbgw==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5169c3 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=fPVroQZirc9Ac6AjaT0A:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ue8EOL4MwukCqqx6BDSDIFSAKuBW0nw9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX47k7q2iHHusU
 ccoqxZcCRKraoWBQOswevlAoAGTXb5+DUDZodj/fushq6gOvVYQC2Pw1qOmOmRAoJBmK91xXyRT
 LsEDSWVD4IicN9MTgmyLvQt/gJkC/AA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
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
 tests/tcg/meson.build         |  1 +
 tests/tcg/sh4/Makefile.target | 18 ------------------
 tests/tcg/sh4/meson.build     | 25 +++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 18 deletions(-)
 delete mode 100644 tests/tcg/sh4/Makefile.target
 create mode 100644 tests/tcg/sh4/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 014959c38cb..07e03048d18 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -150,6 +150,7 @@ subdir('ppc64')
 subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
+subdir('sh4')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
deleted file mode 100644
index b7a8737be0f..00000000000
--- a/tests/tcg/sh4/Makefile.target
+++ /dev/null
@@ -1,18 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# SuperH specific tweaks
-#
-
-VPATH += $(SRC_PATH)/tests/tcg/sh4
-
-test-macl: CFLAGS += -O -g
-TESTS += test-macl
-
-test-macw: CFLAGS += -O -g
-TESTS += test-macw
-
-test-addv: CFLAGS += -O -g
-TESTS += test-addv
-
-test-subv: CFLAGS += -O -g
-TESTS += test-subv
diff --git a/tests/tcg/sh4/meson.build b/tests/tcg/sh4/meson.build
new file mode 100644
index 00000000000..d73df074497
--- /dev/null
+++ b/tests/tcg/sh4/meson.build
@@ -0,0 +1,25 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test-addv.c': {},
+  'test-macl.c': {},
+  'test-macw.c': {},
+  'test-subv.c': {},
+}
+
+if 'qemu-sh4' in emulators
+  tcg_tests += {
+    'sh4-linux-user': {
+      'cc': 'sh4-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'sh4',
+      'gdb_arch': 'sh4',
+      'qemu': emulators['qemu-sh4'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


