Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74907C5DF86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPk-00071o-3e; Tue, 18 Aug 2026 15:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPi-0006sv-I5
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPg-0006dZ-FE
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:58 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHGrQw2494363
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=; b=aCLEgu5AqnQaBlWm
 z77W7at8IDh8M2mzyA/EXBRYdC/JSPI54lEz1hIXa4KJMw1BSGUWDg5neKeT2wur
 w5cgmuQ/Hc+pb3eRZazASAdw4LZwSPKj/8adi4iMzgKtWa+to1acUKRtars7sjTJ
 eN3w4EQzQFGcBifIhTNgn/pvWR6weB392UsazDW223tqzklAxpp3kQ0UFK7NuRhW
 sOeIH6p9v0Uom2LhDprorJVJzAwSK/mUVDnmlWTIhXi2MHFNsdbF6ZVprUZ4If94
 5TZZrO19/VepNgZldoG8j8u4JDaL4uy5q+v9BjjC410u/jp2O2/hfAS9lZIGFpjo
 KdTspQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnha5v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:45 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c85798977dcso211564a12.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081024; x=1787685824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=GOO/aesbLpaOugfOvwMJgUs/VD42v8KQY+LNtg5SYPLDR1H54EFyfaOPZdBNGVi+Xd
 KyCLioaSslJGKR2tnGIBekrjdJ0M5KmYl/d2GNIjazykaD/lhltuH2cXcx+vKJ+MYFR4
 45jAJkxohRBsG30eiRGeuChtdE1FrDK8Y75hdwsxCtwsvch6VWXCUPf6hhjXeMtYAUyJ
 feDPbaaVoQoSOVV/MMAMUxPyHm2mfx2ZkeepvFngjBZiJumEO7u37+L1vzX62iceGn9M
 E26ZYdF+V8dOkMHZWb68Ijp5yH0adYL6/rJGzhNR/1Kci3jPQz/stHqRBtEiJX1xJRcK
 FICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081024; x=1787685824;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u+5WLdDS5F9nDMV/ufO3bHTKlXlRDTglwSfIkNahPt8=;
 b=FIsn+s+N3f6LQLOvPGS3eCY0UzzMwQSTTGjW7T9gDrf1MfDu329Yx/EluUA/nWYr55
 Y9/yv5I6SjRUl3D/Yv90vj/DuXefRjRtn6MFr/H/vhF9VVwGl7jcB4s/BRS0Tv74iH/m
 PrByMASgS8l+8fTwxeKBnoTuEZptklUyLP34pIroBMIh70GJFwV+uqq1Xu8wUgqTXn2m
 JSKhCFxIf5jg6QN11XGKuqMf6J9RjZN7WGf6IjcPGnsUch43Cj3X7eszRRik95JBqjIH
 HpPKzzX/Wyl3oMdlQK5V5I28kFgZ5oT5Z61kqXwP+OSUomIds2juAwdPEL1m8ixKjuSU
 TP5w==
X-Gm-Message-State: AOJu0YyepqYBpFSR1F9LU3yn1FObGZ5CQw70nL6ggUgpNsAvsmdxmSAn
 IIYa+mcRXf1D2kx3oC2tCPtY6e/lqsqCiypHPoHHm0PfC2yHPf7bEysYv5ylweomKk6AU42GF0D
 6Okyv+uDyZKgsAc9ILdJwBzMKO1odxvn2eesgXL1TJpXmNnfaJXpeJQEvYTORFappSQ==
X-Gm-Gg: AR+sD112FDRMGHVT1XJi5EOBVi2xSULMPILIzIDgzQC+axzkrvxyVeiv4xjaCpLlz96
 XhwgQac8L89jMk6/GE/VK0ES4cyqxENHFaNAtWYiDN+pycbs8RmDi2W+3aInL9JIErhhuUcw9sS
 rMNoUNlYPD2kDVRL4USHNdQrEXk6zAdxRiGLJAOwPJkjCfYqTk41IuZvW2/DLg7J6ch7MiRAjOm
 5rkSCQOZ96rqbX7aIT0bZNWtIb1ewtzGyjhoaEHAi5l178GH9O4ZlcMLhnC4vRBVs1t6Bo789vc
 v/YFoIoXjZZ2NCnDuG0WXa+a0Q8lWbfhqS1wDOLUXEZ6ok66X+3kI3OudloIFAlcEHwElyktIDi
 7ghECzatDMe7rSjcHUOdzO9S2gmGTbllZ8Bu/d6j6PWu5jktJOZ3RohGZyio=
X-Received: by 2002:a05:6a20:9c86:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3ccff62d2e1mr23585637.10.1787081024318; 
 Tue, 18 Aug 2026 12:23:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c86:b0:3c3:8651:b317 with SMTP id
 adf61e73a8af0-3ccff62d2e1mr23470637.10.1787081023781; 
 Tue, 18 Aug 2026 12:23:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:43 -0700 (PDT)
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
Subject: [PATCH v7 018/104] tests/tcg/meson.build: add wrapper run_with_input
Date: Tue, 18 Aug 2026 19:21:42 +0000
Message-ID: <20260818192309.22169-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX6QCCA8qRKKW3
 BqT/WkYez8ZAuVzy0FDIYkvWBS4pPc7RujF4RtMV3IHpze2dSMNszJeRM3p4sN9HdV7rY4Sqx6j
 00+hbTHVngB92M023t3EWmpZZRl0FVE=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b141 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: cn25fzUZUiJjPOuK6tQxFCf387_-SJvM
X-Proofpoint-GUID: cn25fzUZUiJjPOuK6tQxFCf387_-SJvM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4XNL2Lb6Ao2H
 P/d4gheQ8Mh0mfeikZSsyEPSlX9ovhEiEcohVjatE706T12XWoyazTXTLXI9UeTe+4Dp0LMR3ul
 G5s0OSBeTcGmHOsYT3WgjEVR55HRSQtHDPKo2WLFip/dR7pvnn8uCweXtGhf3GgpyeVU53s2SXW
 TRIDPoYLZ1a0XuPY9uCdLk0Xlu1WYDnGMYjAGz+2vbS6uYdIyMMkqUTOZs9FdNzyW6XDtvEvFlY
 I38odnjAKNKhbpb/SSGIBcDbEr44Fr0kfqWH6JP+fJbg1eEz7oNj1B70uaidRzh20oyU0Wtdbx2
 d/Dh6Ao41f/EErp8YO7tFlYV7xj69YyypYv8S1+8tBPSt6RCYD1cW66g7fxhpJdK0xSgI65xAzM
 1ZodvpLFiU9yffV++FJ0/pY81QKyia9lRORBd3uot48z2kUI45kV+pLnJsEeujA8ArpTjVRzMs4
 JlNm4+D3hC74YgNNDeg==
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

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build               |  1 +
 tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/tcg/scripts/run_with_input.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c718555d257..f2c5d77bfe0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
   './scripts/run_and_check_forbidden_output.sh'
 )
diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
new file mode 100755
index 00000000000..3d280547c3a
--- /dev/null
+++ b/tests/tcg/scripts/run_with_input.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_with_input: input_string cmd [args]..." 1>&2
+    exit 1
+fi
+input="$1";shift
+set -x
+echo "$input" | "$@"
-- 
2.43.0


