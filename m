Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C7C44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ65-0005S6-6a; Fri, 10 Jul 2026 17:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5k-0004Ka-FV
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5i-0004vK-G6
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:04 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3R4E1697277
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Lxceljk15Pu
 B3c5Wc48rwfq5O8iZHsWCAJ6zkMC7j6Q=; b=AV41mBHZrsOzNDpcMlU4un4UKOJ
 sm6CdUsSTYOmlUx/RPAESspwJAs57vccfuU4GiSMbCDgftDWn1pQxbKnL2/nPnvc
 vh6nRKFQcL0fWRSAO6zqwlo8Z/bY5uRS95NRujH31oYcNmTlQ2TS7VMRHqfU988r
 CPBXYX+Ux7hJRaJMF3Q2GUo0iaZ/w91iJ/FRptvO+1yxi5Xikzm7Ugebsz3PB/BT
 3ZpgHFcVu2duRN9P4/Dl34rIut4VLUY6zZNEK7Vhfx+CjChS/NlBuHNiMyXgxe2Z
 6e8oyw+Fz0cUImxcHP+CTB+f1SWDZ5tR02OpC4BGWzFp0XqGiOCpVxGwYiA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5djh4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:51 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c890bac374eso2583063a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720130; x=1784324930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lxceljk15PuB3c5Wc48rwfq5O8iZHsWCAJ6zkMC7j6Q=;
 b=HieOciajviphvoKvw74iaki3JUmtV6exkZQg0yB9cjvPvsDLf0yGB0mGYamke6se1r
 pDPqYExd1UMNzttve83MkhfwS5QJyGVRb21q8unWo32RTF58zYDa0Dvr3ZAogg6/FaoW
 ywFMTcoofe+vOCKInUQbtZ8tD1/QOXcUhKwpwxp1bQcm+hULKHhUAmV52DHTTa29paOu
 OE1b1IuEgEeYERqxHUucQutgBeSLi/UKPQD3/pbXP2vU9t74LC/IM23gUeQY88E/Lnp5
 XgdSi6veYqIZSv8S2wFJkS94RRBKN00Z/cqo8yQK2z3GUKpOQeVxctUHkjY7Dqe3zabe
 VmLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720130; x=1784324930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lxceljk15PuB3c5Wc48rwfq5O8iZHsWCAJ6zkMC7j6Q=;
 b=jA+fl12rnzEVBJ6cD9e17z42jR/YgeeYVZAyq/yFAzd1Cr60sfXCMZ2r2qrbJR/cDT
 ichV5jH6Sq+/Q4K1IqeLjg4vtkItITfmseUEf0XdLxjkWO6Gq3zrweaBiXSHYlPLaS7K
 hEVNLX3TMydW1TZ4eAaV4jIXz99TfhMW3BzesZs0/VNYDD1gO/AmLbt8j90LUXKBZ8/G
 4EfMDP0wLf06HFurFAN7U/JO401OunFxFhkzgfOfav7y1RDSCdQIyUnA/ZF+epubhYcg
 L7q/9BWQDK5ejBhTeCHDS30F6zRqQvzBI0d2nSDRXMpYRPSZg+B7Tp9ijNN9esKwgN30
 cVtw==
X-Gm-Message-State: AOJu0YyERWlZj4I53G1qzF0wn78mtSsmZp2q4cKYyY1nvf5rtZWjqQIP
 Q4YdbBThwWxqwRMMeU9jQ+cUQk2D4XB+PK9bTz4+lsNAiucW/UORiCcYsiO4hLM+TnvEXkBLWLM
 SAg7LXIDHSqBEm5Wxt+93VUqTYZcaVPmOhWXfmCukHmbEOkbS5NmO5yrLyxyq+ShOOA==
X-Gm-Gg: AfdE7cmVWgSrNxUaQVusW0urUb+2Gmat9H3R2TL/9XsiTam9zcuCGQ/MP+etWOrdr1a
 fJmN49ONHxWsIm0IB6D3S0/LZ4AUfovUBJqRyTIJo6K2+GD33WgzJzI32Fh4LhUboe7s+Ai8GyQ
 RbqJTs8kxehrrE9BBYGgw+VbvyVZp8NEs+fes6Fq9E99BElCH7ZHyG1MickLwXh0P6aAjSrz68a
 2cdWCBooatZaw+z0IwXZYX3xtDNhtZDHtv3DHyF2d3i0zkaFEsXKeLP1oPjhohWHGG36WfOwRTK
 nhgBQKdT7lC4IKRlwufY1oNlQAtbLXFz0892zQR+x/AHstNkfXnLZJOTyLQIdK59PPrleGAw53O
 MFfBDfaCjmz7b7CQTuGIPx/XLppBaYVvnlzkZL/sAYRqE5upY0Ks/zw7MHVt2Yw+jPJcGbdyt8T
 wU3Id+Eg==
X-Received: by 2002:a05:6a20:3d02:b0:3c0:9c19:65bf with SMTP id
 adf61e73a8af0-3c110a74115mr777340637.71.1783720130413; 
 Fri, 10 Jul 2026 14:48:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d02:b0:3c0:9c19:65bf with SMTP id
 adf61e73a8af0-3c110a74115mr777314637.71.1783720129995; 
 Fri, 10 Jul 2026 14:48:49 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:49 -0700 (PDT)
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
Subject: [PATCH v5 55/98] tests/tcg/loongarch64: user tests
Date: Fri, 10 Jul 2026 14:42:59 -0700
Message-ID: <20260710214343.2065491-56-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2GMA6SvROOVd
 cN5VlkeZrzT40kHf2F+YgjHvgzZqePL4/RAanbnYOU2IvB0yayuxMjlb4nY0O3tqXLwmnPRPCjZ
 kgvZoeVpvfWgfYcS7FbXPWZ3Vwa7SAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX2COuiIaEGpbr
 JNDbyQDtYG5cq1XSpOzHttcYtKQAxje0+dHfzf90CX/NvsQULVvBU416x3ZYI6KXLrjW0dfWYUe
 bSOXX7eUcUvWduHjRl0MguwK2cEeTJ79MjVgzbRZf9FIl+UgzZzjv5qgOFYbgoj34Pa94yNIPX2
 uMGYApnoh8xNdmyFsC7ATwpf44EaVjwVSRCE5zAJb+JaETYSlDF7W9egxmf+qftFw1W/GeEe1U3
 QZiz3OGU6mYoNzqC6LzZhZGO32GoorlxZId+xwm9jBIRlRewWEa20M3YeO9DrkHYIoe71dmJhqs
 H3BAfchV1vlsU6E2vSPM6bnKjA4uVPgBetXbpXiXJW+E9vB+QoJZPvpGff67fgiIPLDITRK5ese
 Dj77Z9+ZNXzFs/u6BxPwGLe93AnzsJS+41LYR/lZ48rZa/sm0YqewvNAg4OVALuqBTZ1r1g271K
 +kN/d4cCMPNWVm61Tkg==
X-Proofpoint-GUID: 65gU6jvyyBFs43CCbORaJlRbOD-W0Rjg
X-Proofpoint-ORIG-GUID: 65gU6jvyyBFs43CCbORaJlRbOD-W0Rjg
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a5168c3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=zycwdWGqJDoWXRg1zkYA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
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
 tests/tcg/loongarch64/Makefile.target | 20 ------------------
 tests/tcg/loongarch64/meson.build     | 30 +++++++++++++++++++++++++++
 tests/tcg/meson.build                 |  1 +
 3 files changed, 31 insertions(+), 20 deletions(-)
 delete mode 100644 tests/tcg/loongarch64/Makefile.target
 create mode 100644 tests/tcg/loongarch64/meson.build

diff --git a/tests/tcg/loongarch64/Makefile.target b/tests/tcg/loongarch64/Makefile.target
deleted file mode 100644
index 00030a10266..00000000000
--- a/tests/tcg/loongarch64/Makefile.target
+++ /dev/null
@@ -1,20 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# LoongArch64 specific tweaks
-
-# Loongarch64 doesn't support gdb, so skip the EXTRA_RUNS
-EXTRA_RUNS =
-
-LOONGARCH64_SRC=$(SRC_PATH)/tests/tcg/loongarch64
-VPATH += $(LOONGARCH64_SRC)
-
-LDFLAGS+=-lm
-
-LOONGARCH64_TESTS  = test_bit
-LOONGARCH64_TESTS  += test_div
-LOONGARCH64_TESTS  += test_fclass
-LOONGARCH64_TESTS  += test_fpcom
-LOONGARCH64_TESTS  += test_pcadd
-LOONGARCH64_TESTS  += test_fcsr
-
-TESTS += $(LOONGARCH64_TESTS)
diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
new file mode 100644
index 00000000000..209179fd96c
--- /dev/null
+++ b/tests/tcg/loongarch64/meson.build
@@ -0,0 +1,30 @@
+cc = 'loongarch64-unknown-linux-gnu-gcc'
+cc_dockerfile = 'debian-loongarch-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_bit.c': {},
+  'test_fclass.c': {},
+  'test_fcsr.c': {},
+  'test_fpcom.c': {},
+  'test_div.c': {},
+  'test_pcadd.c': {},
+}
+
+if 'qemu-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 23508228ed8..451fe349a3e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -140,6 +140,7 @@ subdir('arm')
 subdir('hexagon')
 subdir('hppa')
 subdir('i386')
+subdir('loongarch64')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


