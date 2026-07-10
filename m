Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04570C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ28-0006MW-VG; Fri, 10 Jul 2026 17:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1s-0005fO-1v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1q-0003ZF-Ah
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:03 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3c921846374
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=BGS3VTO2+0F
 49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=; b=aNpjFZ/fJ/hLwg1kUK5QKTpyHnK
 i6A9KoV83m43wx6PDy8Il9BzCOD9FMU/gUzOjE4qxo78Vc7UDrNZ8zBbNHtYvfPC
 q3rLNMx+DvLEU6cGtsGaFppMM1TiVcTB3s++RfKQViqfE2VVM4G20ws3XLfSfD85
 ydlaEN1vfHdahUSOboqyo3zSOxTjk+YGjSfrPVJHyuAhMg66b/unUTMKYeepA/fM
 S+SmCg7kEZEZosjISuTDNnhajRdulPgZ6u/OPq9+iVHYdE/w8Dc/4KNDbTMwQHx4
 7JZsGL/qvh5/2PC77tI4mElsrOu2mrLMF5XR9UXTbQwXMYCVF4nQNNTpQIw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rjap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:51 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so24050a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719890; x=1784324690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=bYKllTJR540exHWlg/MCxnSaRYPVxFUrtPtVd4zg/qSPCpVGgi7pjrx6CnyKyKVHuN
 Q0AnrQxsa0DCUh0bjwwzuFBENN/6WAraVPICX7g29Eg3Ob8FvLgp5o6iPssm5OwpsIM/
 +PsHwkOlslANb408PzZxdv21fn71XCa5YhaNRYsRxdDL7vbI8jdDGfWiEMlvGgOEyPe3
 I3vC3K5V9pIOvkMspIrHuD4sKeg/ruqQyc4xuShvnUVCE9sciuNJzx2VC8lWFZsC8aCM
 eN/3y2y3il5g7YZyP5WVOK4mAIX/TseG+DAS6F0jNkKFcZa15q/giVgYa+F8kY8cY3I/
 CPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719890; x=1784324690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BGS3VTO2+0F49Nnag/VsBS2SuWMVefwEKDE8A+uALLo=;
 b=E+HD7BGUhnnfMAkM8yfrLUkpiGxCR0oFGYQF1+Ki9Miv5dOE3yWc5HL/9jMn9GeDKK
 xqRPOUW0Wf5dulJ8cnTfUGnnIpGQTWR0NfvwIHAPkCYSPVGsTvGYJfnShqfAkhAK8YQa
 r58888Px1is//nixRAuy1Ia5WLO75hocoZ6Z6SB5w8YVgO3YmWJ9cS3DCNuqUxK0JaLC
 4Basm/CTD8kF5Fnq5HwHUoDTXcObF7K70LPAhk4YmdShqynVpop7gvhLL1w3xt0G3H5T
 emV5F4VkC6TcV+0LjCSA9IKlwYDXOKvN774VfH/NLFg6x5Mdvv/lj3QV9Mq1QNLjT/Et
 cyPQ==
X-Gm-Message-State: AOJu0YwlsPJNdZ8w/03hTzAI1jeYvuHlsuLgx5/vSd8Mxr3kmOoNhYzr
 7yyW42+uMicKDjXP/3HDql75up3HN6s/wzB10t8H3oTdh1UsFUQ+u+WAIm7F7NW//w/lH/2Uqg4
 0bgyZk7m05PamlQKmi075Y98zM//tVRFAm/S8ZqHAWuwkIVw/grtOz9xV85WUhHDfwg==
X-Gm-Gg: AfdE7cmEAf7+FrsiJve80+MJuseAIoZwncQxjylFbOeIROJ30creK2K3fIW/D3okz+B
 cROpkbVH7DGkHR2xuhnSu7PaTWxXbV6od1mV+3reDa+dgLuMOu4m8v222wKNC+raxCFeW4L5icD
 YGLpn5mnPSwdPsicCOLUEmYwyvd3Qx5ZYS9hln8nYVys2Rvjlg6x92HshSf6ESLUIHDsPfsCJmC
 McUf99B0yQ0/RjBFL8q81xGppjpMNzjBvqVy9BWN4itgb7gRyrD8DBnur53gvUL4a7KaOoo7Nt7
 PyCLI+lz3Bt67RRBWoQarG0oq/yrAd6bEKOl1qXxrlCVyGZGnUSW4jaQPGjYMNUwxmkrWMJPljD
 v4a7TRh9DL/AHsFQUOAbj7h4sDH/DC9aMBm1X4m/eUL4libExAW5bb5Jr4okEpGGI8Ssz9phXoo
 xoYHS8Iw==
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id
 adf61e73a8af0-3c110a65ba0mr688574637.37.1783719890484; 
 Fri, 10 Jul 2026 14:44:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3a2:f75f:73ef with SMTP id
 adf61e73a8af0-3c110a65ba0mr688550637.37.1783719890050; 
 Fri, 10 Jul 2026 14:44:50 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:49 -0700 (PDT)
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
Subject: [PATCH v5 33/98] tests/tcg/multiarch/gdbstub/prot-none.py: deactivate
 on gitlab CI
Date: Fri, 10 Jul 2026 14:42:37 -0700
Message-ID: <20260710214343.2065491-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FmPrkUjkKiH5oYRe5yfLPQVgMrvGfFrz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxS51ihzDVNq3
 Aukr/vOPEFdxNWYgFxvuiI1rpUmgJA8dgzu7jZShlbiFO0Y8C5H8wEQHNnZaiNf1sMo2RA6PJYp
 wMk2zrFgWVo0kzW8zjMFia293TmC/vkL/IBO2so4V/6xOUrVJ5r9EbbTTqUNHGSvJRJ8E/q2Ht/
 Ut2K5Tt5ygLe3/UcVRhc//beIwcrL1DjrDOLrfBeCawOIowOf7gRVnwiLwV+CztlWqNaeyZT3hH
 UiQlzactdwXqqpCogIO93Z60CSoc7X46DhiTIRLP2MUsGDpoQ/Jh3QThM8VB3sWziJqv8DNx/Dx
 vgAJ/ppR2ZhXyXbQ1FpgENwR1uvOSqhvExgoseSYAhq62ZZAntHL+JTiFpd2vtmeAMZrHzecfuP
 WamtcE8SKJspf630NNvnOWBMw4ApD2sJZPTM/Wqb7Y8ie9IOWrJ7A5M+J7PXqFdvNXPDCL8cGws
 G0mBmhSh/uZzS4KIANQ==
X-Proofpoint-GUID: FmPrkUjkKiH5oYRe5yfLPQVgMrvGfFrz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX9vPINX7/x/67
 jCnNlB/bi1ypB2TsPtKkekLvrdW9yjWPi6v25eysKr+X4Y1ncE7TD1LxAtXVyblVNmWQOmpPIip
 hzzLjOuN6z34OBQdTKJn4j18j9lO0j4=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167d3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=p0WdMEafAAAA:8
 a=EUspDBNiAAAA:8 a=3V-_cSConhulDen5wCkA:9 a=O8hF6Hzn-FEA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

This test was disabled on Gitlab CI.
Tracked in https://gitlab.com/qemu-project/qemu/-/issues/3329.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/gdbstub/prot-none.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
index 51082a30e40..e653bc697f6 100644
--- a/tests/tcg/multiarch/gdbstub/prot-none.py
+++ b/tests/tcg/multiarch/gdbstub/prot-none.py
@@ -5,6 +5,7 @@
 SPDX-License-Identifier: GPL-2.0-or-later
 """
 import ctypes
+import os
 from test_gdbstub import gdb_exit, main, report
 
 
@@ -21,8 +22,16 @@ def probe_proc_self_mem():
 def run_test():
     """Run through the tests one by one"""
     if not probe_proc_self_mem():
+        print("----------------------------------")
         print("SKIP: /proc/self/mem is not usable")
-        gdb_exit(0)
+        print("----------------------------------")
+        gdb_exit(77)
+    if "GITLAB_CI" in os.environ:
+        print("----------------------------------")
+        print("SKIP: fail on gitlab - " +
+              "https://gitlab.com/qemu-project/qemu/-/issues/3329")
+        print("----------------------------------")
+        gdb_exit(77)
     gdb.Breakpoint("break_here")
     gdb.execute("continue")
     val = gdb.parse_and_eval("*(char[2] *)q").string()
-- 
2.47.3


