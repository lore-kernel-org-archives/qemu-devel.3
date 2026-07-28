Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5E9C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfS-0004rq-L1; Tue, 28 Jul 2026 00:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfQ-0004r6-V2
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfP-0001ck-9P
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:48 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3akIu2693071
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qegqj1OMVyQ
 t1DkFbHbnCljxWNayKWdj+baKt3JmNgA=; b=Q8HS9vLvaBXxlsj4HaBJxqMKOiY
 XyhwB7G4OyHtFtqIxRxDxq33AizRgin6tLqjDBols50zxO9uq9a74A6EYx5OyorV
 R4dxYPXHSEEB4l4stqQz67jqhYJrkDtw2qrWnsLYkpcFzsUX9JVk8Wl4mAAZ+Nff
 kr2pS82kNVyIXhoNeFCRdN3aNz5SDT1jrohpOVA29wH1hSVYbMJJ8qkqX5touYdw
 XoM1F5vOekEbGa7AJieu1hSq4AmEHOcQlUnQfkcAbrQCfbwziPwAD/RGJc9UE4Ke
 H/BhbF6DOPnZJ8ES09meQAaDfXTrr87Y82hPAxMROF8wTJ65P6UrJpCFnaQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbp5jeku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e25e4b41cso4098843a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213825; x=1785818625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qegqj1OMVyQt1DkFbHbnCljxWNayKWdj+baKt3JmNgA=;
 b=jeMFDv7+wnJD6kQI03DD2wdzcKxtHRh+AXwfRN+UxXhsvZ/aUdxKCw7z03TdQXeMAz
 OMo04YBMlw2OdYMvjl+t82v04UHwQ9Ya9N0qYggqc4phf7gnMkBWSlws32B/W4Tpffg2
 GOBLZ57noeOjClTCwQ66TfY3A2/6sLtURKxnoIK3ARGj2qeXW2M1KwbUhR9gpmWrUqFk
 yDcf8DyhxNG9Bdxf9IgazTB3zJAZs0TL54/ls2ObIdXDxf1SP54+m2gs81yPmSXTtvr9
 ECaC2jb2i3BjUQpU45YkraOjBHGZ47K7OcjlE/zu/5wVLVmNFnrxpfd6m/AnzTGUNMVr
 FZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213825; x=1785818625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qegqj1OMVyQt1DkFbHbnCljxWNayKWdj+baKt3JmNgA=;
 b=hHcgnig7NAtB3leAJkSQ5Zs7u+SYnaTTmPceHIcYk91ZKhYLifRc4J9wpW10sqWCvN
 8zEhZN1gIAZ/PTk8AlXWD0tqAqeaIMI2S0WGHThCIb4oE5xD5dfIxgopH3/dyQ+47x/c
 CF6aX5q90V5+9irBls2IE282hBt54L7fozucBfLFBF5LnQ3e/+Bl7bv60e60XDrMR5n0
 lr24buF7IjN/Q3Z3MBFqJt50aRYdJ7MsHNT8ZTjqzsZkPhJT0fjPRkapDSPF3hfXgPxr
 Yp7rDD83FhaHt8+LpyYcFADxZ2Fgjb6IKB+wAnAnhOK16jhz0kzdhjoSmXPwGNHnr4ys
 69/g==
X-Gm-Message-State: AOJu0Yy+n+ypXhXAjSKDkILUnwQikmpH1RR6WI+C/amklkKrh4b40SUO
 JIJyvK7dMylNw2LuHTSqexoq1IT+M1QNewOnAlxcACvjfizoka92eakTE/3J1DXgqCKxL2EK3at
 HZ0RI3n161Z4dlLaCSTy3uW1RzPWj9TuDlTy5Ip2WPJx4SxaDy63Q0vgw89IcbIsq+g==
X-Gm-Gg: AR+sD13hX4hfV/k/hJIvKkxOT7k3YTmR5BrwjNXJcv0JB4rukOkN9Yv3Rxpzxh+/FGk
 /FDcIiaK+0GUyD+Mn05r3ZB+vltq9KY2qxbrGTiDMR/TPDxFZPEedzsUUr8v61Qjo03Rub4pNxz
 H+VBJAAsJjQi+QDXNxIOzVuJ1Sf9ry85/NlthwD+pn9Y+GV7W2rIRX5bRJPiveswv1kCVUrqnCO
 npO2T2cpyE5fa3MamgA/rUYCFpqYOGi9A2RRObstPbJdM2w3VDKQ6fJTgnIpH/oiLmcw1L1bBib
 wQDqyiliOM5RIx7yaZCrRxojPEonDHn0OqLfkLopxNiMK0TApY+yLlrJR+gxZyB5HlvYGeMv7Gk
 QmdhXT8UR3Z+/6g4577ES4sDF+r5WE9x/KYxes6iQ5Rr9PKTNtZG8EOC++XuLR9wiiLSNkAw=
X-Received: by 2002:a17:90b:5444:b0:38e:4482:ab14 with SMTP id
 98e67ed59e1d1-38f6a45e16emr942877a91.32.1785213825196; 
 Mon, 27 Jul 2026 21:43:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5444:b0:38e:4482:ab14 with SMTP id
 98e67ed59e1d1-38f6a45e16emr942846a91.32.1785213824758; 
 Mon, 27 Jul 2026 21:43:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:44 -0700 (PDT)
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
Subject: [PATCH v6 029/103] tests/tcg/meson.build: check host cross cc is
 working
Date: Mon, 27 Jul 2026 21:41:33 -0700
Message-ID: <20260728044248.137626-30-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXxRbIn086GOsw
 41o+z7WxECUMmkMb2Kxiigotb7JrgVAEzv0k58L19Kc+ZPYjVRBkFNojhzRkcnLCiwcsa5VlIqd
 BhX9p4HPCkeUSgPQV+U+p3NqE3r3ulY=
X-Authority-Analysis: v=2.4 cv=XuDK/1F9 c=1 sm=1 tr=0 ts=6a683381 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ViepqEAAKRRHcruyvJ4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX52qQXH4upBlb
 uSc2wy0g2Tu3xhqJTuvRfdMhbjYn9HkePd16UyJES+ZgbrO4yCfGJ22x97YWbFlE1dkrgOKm7gp
 7YdqscvhykT6mSdwn009eP8FTFPJKsM4BvOe9E/h8lhbOyPSqlabym3Odba3v4Gmj/Cp2JU64Eu
 BcRB6tku5JZEQLtGxoq9k3HYVN3oAweGojWpLQ16w9Mr7ArrO4rJRN3RWBSD42hyhRlmZXL8gdI
 mH/Oaw2qDigF11kZ+wDV7sEBXooN2vY2/HcenKtmLFQymqR1vY+RD80fCifIJw5cWLEebHWAfLS
 ey3OVNKfA119Uq/FTiipyjc0NtgZPi2Zi1uLnE81BroRHa7kK1oLp1ffK3D4eHS/hqInKo6WxFq
 TUxl1yp5uk7oekxfmC1h8cS80jcVak7p2UxDOSGlB8cCvc7K24JdpED8rD8p+YX9hInaFXLXWP6
 L0XKbrY9vqWsRej5VVQ==
X-Proofpoint-ORIG-GUID: fxsIzGMskoRp-N5wfKj_ygWFoKnNdqly
X-Proofpoint-GUID: fxsIzGMskoRp-N5wfKj_ygWFoKnNdqly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

On Fedora, cross compilers are provided without runtime or header files.
Thus, even if program is present, it can't be used to compile files
directly. Check this, and fallback on docker if not working.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 12 ++++++++++++
 tests/tcg/test_cc.c   |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 tests/tcg/test_cc.c

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ab7090a62fe..8611a30da6d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -109,6 +109,18 @@ foreach target, plan: tcg_tests
   cc = find_program(plan['cc'], required : false)
   cc_from_system = cc.found()
   has_cc = cc.found()
+  if has_cc
+    check_flags = ['-static']
+    if target.endswith('softmmu')
+      check_flags = ['-nostdlib', '-r']
+    endif
+
+    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                      check: false)
+    has_cc = cmd.returncode() == 0
+    cc_from_system = has_cc
+  endif
+
   build_test_depends = []
   build_test_depend_files = []
 
diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
new file mode 100644
index 00000000000..d3614a01fe6
--- /dev/null
+++ b/tests/tcg/test_cc.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+/* Include a standard header to make sure cross compiler provides them */
+#include <stdint.h>
+
+int main(void)
+{
+    return 0;
+}
-- 
2.47.3


