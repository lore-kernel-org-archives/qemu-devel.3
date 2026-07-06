Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B345C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtu-00037H-13; Mon, 06 Jul 2026 18:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtO-0002jx-BU
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtM-0005bG-LJ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEGfx1639679
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ek2w00CDsjG
 n8MTzxHKv4bpmghh90wPgzuMpdqH8ty4=; b=QAOlP6ha+QvX1dQtfUBEV09qgix
 8KOptDlZX6nab9uXPo6pVDJXLyv5amgMEevOnSIa17za0ySSpm9rALYRATjGkZ8x
 covPSQ96A+9TZqkaJL/tQd9aBclJyPNvaa3YY/Fl6H6p4iXjV6e7yrNWVvss5rCo
 NN3TwTqB3GV2D7VNNiiWXqwfBdtd4BJ+RHyIeNgEQ/PnyJFZZFIgeArjzsEDtHxo
 LIiK1Sf8QFZhKhPyXdYV7irEvcTZdCYvLBIC33EGkdkW36tjANpqTmgWBEyG1E+m
 NGsTixGRwLW7+c7nR0TcrwwvLJ+PQ0/D8h57Tt+wYT/MFRfzSe37NpfwqXQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r34rr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-384048e7e14so3264670a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377259; x=1783982059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ek2w00CDsjGn8MTzxHKv4bpmghh90wPgzuMpdqH8ty4=;
 b=fvFyFQb3XcV3PkD5oMjP7KVyaajnTdEqKbjiKeonc3z4/iZ6ZdXW4ndPOEpsg5BTEL
 k3s1fOteYSvhNu6R2G9qKYO0cZzCdtW6xPVhmqCtlS5zji9a2xQvHd1asOsCmXDvTCRj
 l6ntjnQbkX3tRiNZQBEBHr4hpudj7/wAmXAAcq27qVIQRh0dwLl+IjX7R9vMOT4lV+Mm
 Vqq3gBpgXYND/Ek/SeLcTstPC+BreezPJFnKcmjZS6PjTg+3/a3wNk5tUocV6OntUvnn
 kpOTt5eL1lEgdSdsiaqv99YJLG0hU8Ml4/ykstOIbf6ov5MVDP0uJmcPyu6X5HvT6Iyt
 smJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377259; x=1783982059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ek2w00CDsjGn8MTzxHKv4bpmghh90wPgzuMpdqH8ty4=;
 b=B6oVDa/5vEHZG/T2Ibe7zVgUtEeE6wR8OmerPHz9FLx0wLojVpbMKnbHrENYDkZUfv
 htyzohtR+Msmn4dhz8AXEJT3M5654N5Gy7ObbKpg6Ps5rG53WhX+d4gysW/QfEvvhRbb
 OaLrxxmzLFVHcd8xEB7sHXydhegqWvo5+sks798GGrLMDmtzr8v0Es6k9ndZT8hS2fsP
 Z2c9r+qPGoa/k9KFTU67LkuolHeWO5PdscpRuybekEttUf547Hw1FDI7+Bylc93JeJL1
 /5qRP+2odAjQHGrokVk7gZiS7YLHFphT3JWUtlRpzH1HPSpPnpsLwfSyUFaq1mtTuQ6W
 g0IA==
X-Gm-Message-State: AOJu0YxKJU3A2M8lcgXK6ZYN2phuAaQFWTK0hDOMobo24u0AKs0K6pij
 TuU9g/VRvO6TVdGlQ1pC4YkxphsVuCet7DhZSDhNUCLuXqQ7PbpKlEjOlNK7JQBsnehD8lTW6JB
 MUv5w4DBXwQVIRu4wwx10HZFafsvW1iHqDmIvez+gIlLAvztUoZQRBY3dWb7aFc429g==
X-Gm-Gg: AfdE7cnNhTiokis3GI+d4t8C3qcd3pYLzJeV5U36NqYPRNAVjOx3UenCTRhue170+30
 K3jzawePENKqX8yMBSjfEFdqe2XGFO78MGeIXbVirHnaK+Tj5hx+kjvLv37h1YL/AvLzSq5rIPP
 LS/8kMYZTPmiroVMWXZoS4uplttyp4vYR9md2G9MQQDLNULbUPF0YsyLP/bK2H+WIpAC05nPvTX
 1fCIrqlysvoCN2haVPw/whYHvhp6eow4os1lvsHtWIFzibh+Tk4R5ulvqTWoWy57VTzt9AfwvnQ
 o7tzDpGad1FwSIiA7y3oJ6ni/Qq3ZOq+WDGCclUC56dsfJwiBUmYCh0HPQBTmVWxSB1lXnLOsIj
 oCS21SEgEf4opN9DmhEp+9ZeuG5ng4KAjOyd21KtColOO2X48Mv77jno8PbqNYXybUXHE6XzP2z
 tZnv99ew==
X-Received: by 2002:a17:90b:1a86:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-387573b2d1dmr2449501a91.19.1783377258686; 
 Mon, 06 Jul 2026 15:34:18 -0700 (PDT)
X-Received: by 2002:a17:90b:1a86:b0:37d:ee77:78ac with SMTP id
 98e67ed59e1d1-387573b2d1dmr2449461a91.19.1783377258218; 
 Mon, 06 Jul 2026 15:34:18 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:17 -0700 (PDT)
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
Subject: [PATCH v3 16/91] tests/tcg/meson.build: introduce expected_output
Date: Mon,  6 Jul 2026 15:32:28 -0700
Message-ID: <20260706223343.988769-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX+xbCBCjDiH/0
 HPEjTyWA+JL0hHhG8ssRudSXrvCyTDJ5itD8qF9XtIsv8d1yLMBc6yNu9YzAHxG0c5y6SNLOcMp
 XVWCsB6qv34bh/B1ClMZmX2+G2P06PcXWeO0JdhgrTy+xwYk1R9MoQHrtYSJ4JX6kBRnvjwSZll
 BhM3yAAR2+/isWHw9O4vSgoLWdHFj6VQbm7jvd4iBnDiACmhRlaGclqTBTRCLH/ZIJXNldPButF
 fyHz+DxfY41Eallyjrq3wj8lwYPymRdygGtsWPbyhoqWNCUGn3MLI9m36Ko3PPMQLRc7mkNIAjy
 DqVMx9GUdJ7TBMYej+jkTuU6CIRAI3ceyyh7mDuA94IGa1zYvTvF7pvvVjuMJV4TGlpty579LkM
 Pkvbv5urU4z9oR0rsePDxDJkNrBB1D1AK1okGJDy7wTOcr1YiblStqkRoNURnG0Czs0wqJXYGin
 IbNkl00TNi91+Lho1Aw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX6qfr9weox9vM
 45Cqu0lJBXihVsvte1kd88XZy0HWeuKOLgfy3Wp1l66WQakLemI6EH8KL3Vl+DJ4K2tOP7q4eO4
 vBugDpfc5wyKJy17pnYGkymAQlQyEhk=
X-Proofpoint-GUID: StU7YLM-LhvBoTz018oYXo380EL0sUml
X-Proofpoint-ORIG-GUID: StU7YLM-LhvBoTz018oYXo380EL0sUml
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4c2d6b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=twXvQjPDpJ6hybaE9wIA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

A test can declare it expects a specific output on stdout. In this case,
we compare it to a reference file. We implement this instead of relying
on a wrapper because we need the flexibility to resolve name of
reference file per target.

For instance, multiarch float tests expect different ref files for each
target, which is something we can't express with a test wrapper.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build             | 12 ++++++++++--
 tests/tcg/scripts/run_and_diff.sh | 15 +++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100755 tests/tcg/scripts/run_and_diff.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 2106f5d979e..1dd0e492810 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -24,6 +25,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
@@ -87,8 +89,9 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name', 'wrapper']
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
+                   'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -202,6 +205,11 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'expected_output' in setup
+        expected = files(folder / setup['expected_output'])
+        cmd = [prog_run_and_diff, expected, cmd]
+      endif
+
       if 'wrapper' in setup
         cmd = [setup['wrapper'], cmd]
       endif
diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
new file mode 100755
index 00000000000..3e51cdc9663
--- /dev/null
+++ b/tests/tcg/scripts/run_and_diff.sh
@@ -0,0 +1,15 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
+    exit 1
+fi
+expected="$1";shift
+output=$(mktemp)
+trap "rm -rf $output" EXIT
+set -x
+"$@" |& tee $output
+diff $output $expected
-- 
2.47.3


