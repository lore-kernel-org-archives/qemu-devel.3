Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89574C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZjM-0000zm-JH; Tue, 28 Jul 2026 00:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjI-0000kd-8e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZjG-00025W-KP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:47:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3adqq1467219
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Yy5h26QyPQd
 SMkhBQd2TB2rKiz4E5VrTJ8VhcnOCqlM=; b=plIKFdbgn2r2s/L45f0ZdtAAgIN
 3ZQmJDgwDe0y+XN2TRlM1vlWVxC12YZwyn/nlLJJP4ZQEe9/FYLSHpld0lC9UNXq
 T6fJ1Lhni6wQ15CJD6uXqquw/KOJ0hSAs05t0z+ulfRgGOLkrUCwms3amtuzvprd
 pFHLtrsSipFOTlajHSAfSl4dCbnYll159RgqAj7xz4lkpvaBVglrCQooakZzUDUI
 0jZ7leAeGBuJk9a5OCS9TdvnpITzAU8eONdJBIgotvy9mWRS8jYzprYK4Gcr372b
 bx6JoNX2Y7IuN97rhcLEJZt0Lj6LlNaaofgoPWAOpXskt+b1ynqpUe7PQ9w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbvhcb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:47:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e54b6556aso4061147a91.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214064; x=1785818864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yy5h26QyPQdSMkhBQd2TB2rKiz4E5VrTJ8VhcnOCqlM=;
 b=GKMrriPbfiI+L1BIkkOLeGzP0HhmzK88pmGb4oJIfNmVngEr3qlsbWZJCBqvJ/yitK
 H/lXWU2aL3/6IhnOLPhVvW+162GGKdR0IYSf2z3lPia92xxLjYoVoWnDkNLMZuLSkMHu
 rGlLXyQ2LT5gyt/Uo/FTZPBqpAnHwrtUTJS4M/Pzqh+WMOnBoYG+loaXzvIIFJ5/6YC6
 +pP7xdwhBaAqW4EhYdBuqG8XQMcNvumDHgUl8jPcJv97wmTEidtX28HtF5ZXeqztfWjP
 To2d4Qhmdzr6CoyiIWCSTeG34I20CIcsyT60rBVPPDJa09tcH2QiPmF0fUMXilaW622s
 caZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214064; x=1785818864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yy5h26QyPQdSMkhBQd2TB2rKiz4E5VrTJ8VhcnOCqlM=;
 b=ZQMFytRid8fU6Xnrp5d8QBTN4wKCwYkmEALxvVhC5PPDuP8N5HysAri8dF6rSghqQY
 HDqr1qqFbTltcWEQ76BURDHp47D98Od+VD2WKPzeCVRKuRI/VjvA34TB+9/2larC4iU3
 hh7Ffse6Y508gNjuWfwrdw1CEW6rykHbNcOE6l3xrEG7H/WG1g8eq9+utX5+4aMQsQIY
 ROIAd0wFD8lPRJf0aXSyTMY5KyFFRlNtaxlKzVEOpovLRVJlV1xZV/KvL4bCblG2AYVI
 yKaDXteaF2oWyW+2sJXaVxS/feBDmUtXTIrc1LbPNAuElMi2AV9GEHxkr7rjlYhBSs4X
 8nGA==
X-Gm-Message-State: AOJu0YzuVnOxcLsMP7SeuOUtMtYRYNXMDImwD73sO62UVQblsw9CsGkZ
 lxBWJtkCO+HcGQ6X8uSqHdvIqOx6v1C9iRNw0jtINGIn3XFZ1V/06lpjS5PvCqztcoHrWdwEgNI
 4fvtF4BU48WB/Xkymh6cAjlhXSM6Y0tXSbhF2P8iBEq2nPVsJz+e+YZk7EzLPn6Wdtg==
X-Gm-Gg: AR+sD12OQqCdJiBeYk+3rIOl+TUBW9h+PLac9Nt9Mc34iZnQuos2S9fOu8CsJSgACE0
 CNfJ1p1CpY0yc8BiBHitOArkt04fNFjM57yWO3zzB6CqpRUeJ/IQGIci6WL/Uzb3n2OavquDMt8
 AsMsQwL9YF4kfHdRpOqcT/C61u18iVLhHLOiGfwGjW3PoAQFMfx2vtkUit3IkIyrtdL5Y78lFO6
 SRDq9AkCQcujzPA8gyAc551zDLaCEgVuq+i0i/wicmNqMKh+b3lMWSeIRAFkjsCK1EJad8BKd3t
 C1aJtK5PL/G/Suai5K9gSggoZhTSaTDW1k07d8whgHybvSOCnFfREDZhDKKFk6TNolJ/QAXaPTC
 qXEPx0bhDapsjvsAfjqJe0oLJhQzJD0bOG60s7l1SI6KKkhC2zTQqnuSu+ktjugf5IexwheM=
X-Received: by 2002:a17:90b:3143:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38f6a45f6f3mr863289a91.31.1785214064543; 
 Mon, 27 Jul 2026 21:47:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3143:b0:38e:76f8:fcbf with SMTP id
 98e67ed59e1d1-38f6a45f6f3mr863258a91.31.1785214064089; 
 Mon, 27 Jul 2026 21:47:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13d13003f12sm103090113c88.2.2026.07.27.21.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:47:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 052/103] tests/tcg/hppa: user tests
Date: Mon, 27 Jul 2026 21:41:56 -0700
Message-ID: <20260728044248.137626-53-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -3bDjdASjt1Tk_F9ub69dURxx9q1e58i
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a683471 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Wtfs_aKp8OXI5K8l3bAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX6x7JN8ZD20cu
 Kmpr1wQ4ajujCB+jj45T4XJJuNoECQO/NWP5Cou/22ai+jaM4bFdcOxvsbn4WILRLae378VJs+u
 L16l3sxd6SI8YbE5ux7oHzYduj+PEUw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MSBTYWx0ZWRfX5Xh0qOAImLOr
 qC3gUYYMQRP44WA2gXuvZcg4kByoDInoZzGK1gQN9/zq/m0EQzG4L84/eej5gwfIGY5ubDp1e5q
 ncvHjqUi4fBA+gLvsqpfCt9HTyDG3vK6gU3M5CkPr5LXExM7x7rYVRNFEj66JgoCM/r6ZW6u+ac
 RNmkxOhv75rA0Y+/nXd0URAst00IE5u7+1D8IrlHXCu9qsFS2+iV7ynur4pLXZNl45ThKf/x7A1
 lR7t5pfzaSPudtCzJc9gEeby+ghlBC5AINqLu0Zf6rcMfFgYPQCiZuq1pVhq9oT65IvPVAwXuCC
 AGy5759GqUTWoudq8NwNnKDqxtB70F7IqdER/qbEtW6lXqwdo6sjjN2ijNPUoibJkHhk2WSdQiY
 INpU9H/kAGkWzxNbvDq7jSAhUYRtRrwia5MLI8vB6JvOKqcPZQxSca7JEhrrTPRGcsaFNNLn+qX
 ZCwAO+kvOURJWxVRoeg==
X-Proofpoint-GUID: -3bDjdASjt1Tk_F9ub69dURxx9q1e58i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280041
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
index 73deb6cbc3e..284059da65e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -141,6 +141,7 @@ subdir('aarch64_be')
 subdir('alpha')
 subdir('arm')
 subdir('hexagon')
+subdir('hppa')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


