Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D7AC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:41:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rB9-00008W-QQ; Thu, 24 Sep 2026 17:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAZ-0008Oe-Gw
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAW-0000w5-KJ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdkUp1672861
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HxrKfdeYYyz
 7V679qfBzJxXvE41ddTAReTnyqQwRv4Y=; b=CsO/55wonaW0jeORNCjUc+AktZs
 cUoRzli/JTjQsqaBd5zaIw2Ok2bk9uxtDMSxkEDvZvCx+eSv6k9aAGLPeSPlOVmD
 O6+Sj7lS0e8piVJDOxArkOyhkPYmECcnrSbqUDbVH0DeGxK6/rxu+E97jEQKCr1m
 RZrku8ID4JtGKiYQZY1LCFkrGLdHN3285Hzc/Ecsg4nErdufOJUv4QBKrO8UiRAR
 UoQ4yJbCN+N4uP7F4fQ4qRRxQQlVN3GXCEYqGUzZoi3oAGvtUwIbpqbVvfJYiEvw
 /flGFPQ1NhQ2yks05Ep60DOr9A3Jt0INTfr2G9TUlpuOx0tq7wAynIqd5yw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1scaumy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:50 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-32861f5448cso767390eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790285990; x=1790890790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HxrKfdeYYyz7V679qfBzJxXvE41ddTAReTnyqQwRv4Y=;
 b=Yn2Q2qEFNXT4x5tO+fxE1O67GYXoJpasJPBrgJH4wOIciLLMb3DwjyJD36x6JJhU8N
 qZqQVTJWL9v8MFsupgr5hp/lDweuiUEaLKNqYpyA4q3+SzRJDY0sWe1CCWe8Of6xtrI1
 3YF60PKaExPusBuo/1VmwZ4X9sbkwyKNAu1DZW9sW6fSkv0LERW8C6GCp9F1r2hc8V6E
 /DqqJ4nwabJavmyxbBQOXjTWCe6C6IFzZnVEj+cjTS6vuEvVNPAX4pcOZpg3QCcTrHNK
 GHxnIfgKRZzd+VRLZMOHijG88TFv5QxgmBxfji6gSIaPV2kWvmKv8IE+PpDg0doRebxH
 Nl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285990; x=1790890790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HxrKfdeYYyz7V679qfBzJxXvE41ddTAReTnyqQwRv4Y=;
 b=KQlalFJdj3rMytlsc2tsUezN8da9fNXpgNLm31pratWqL8KEDi9TQaQ5pda2I06a+S
 EtCWBZ8fbGBUvROkwZs60kP52kEcfH0euS9EudppBlXUUMCDnHCTn/f1Bl5GAJfNvW2Y
 aPXhVIftoTQ+5P0so/me7X5Gls6fRGHEFKBjUHInNi8genD5dwoTwqI5ztpZpdaA10IH
 N+ObOhYLycWOoylW4vmQBsnHQLc7KO9ocvWMV4zHqtiy5zMZe6lMfWg4LRFB5iFwE5DK
 5FG+uazt/K4oE+nMSOVj1pODKvNYLVrFlOi6yoWV9UAERNmOLK29La6un2apkzA168bR
 IXXQ==
X-Gm-Message-State: AFuF++lHZ8Xidq9gh5edV0Xme8fWe7IxXF4DU+lIIfIbjXLEehfi8bve
 suiaeENj6Adwq9tLFOwezWrOKQO7b13W6CBviCM8w0lhEHJprdcO2Beb+rsUGWjD0Cw/lyI+Zs1
 dqg5jtjcvdHlu5H+CvO86rwgXVow5gd3jOun9mfT6GQnqNSh5poosSIwX+bIbWe43Wg==
X-Gm-Gg: AYBFou3Or14Vqer9+q2cwMvrZwwWj+hBLPJalyonOySs2cGqreKPTTuczLupBudhnr8
 vq1eDLBmeigAoqHWkFtpXcbKgH0HCCJKmo4N3fyLo+4HpeRSHY0Pcu1aIj4LZZWSjoD8xATWHZe
 3HZsnnmj82Qyx/DEmrAD77C8764mxcugcF+ewzjTuGIf6BBjM70neyirR9+kJ7R3ewXCPvI7N5j
 tGoBUjDvE2ClZS7NdAaAxULsZMornRDFrFqSa7Ak/nT/l4DY80QId0ltuKT/n8J+aFiMHzv6hnS
 kbD+CsikW3YrOu780o4Tr3cgC2BszgaNnoFAQ0I+xCvSY/0YsU6T/VmjMoR/94rQqzL42C+hvms
 r23REii7sblF1z11HJxTx1nxXAU3hq1q8VJrATWmt3uGsFBPIx6HNWUcQDQ==
X-Received: by 2002:a05:7301:1981:b0:33c:e9d:6d4a with SMTP id
 5a478bee46e88-34003bad76bmr3168554eec.40.1790285989492; 
 Thu, 24 Sep 2026 14:39:49 -0700 (PDT)
X-Received: by 2002:a05:7301:1981:b0:33c:e9d:6d4a with SMTP id
 5a478bee46e88-34003bad76bmr3168535eec.40.1790285988911; 
 Thu, 24 Sep 2026 14:39:48 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341463ec3ecsm1273668eec.31.2026.09.24.14.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:39:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/4] tests/tcg/meson.build: introduce cc_alt (alternative
 cross compiler)
Date: Thu, 24 Sep 2026 21:39:40 +0000
Message-ID: <20260924213942.26491-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WTYFtrLKqpGaxTstA-_zrayS4wbk-dBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfXwZQUZD/iE4Y8
 vsqgWpJa88bG/PigWmZo0fDDlRSdUnoNskdE2T+6vv+L3oMelSAlWAStDFvSyC6kS2mBGNFW3kJ
 m6B7hkaezDvcn2mrevo289ePq/CQDB9HoaWC7/EpyQ9jqaC/IqnZuflXdYNHi2m6QFTi0Ll08yE
 acXL3BqHDlY66CJRGJ4TwGkYIf3vKGLueiqYC+jqigF4F/Msi3cocVngcqfZW5EOtx5GGU4jZAb
 4m5upfp/N8/8YcHJRamb1W3BDgt/WUYbAHQzJIa245CUoKChJivJdo3EA2kpxdmaukI2h/Ycf30
 I+BBXLLsVmEI9+803FhojU97dLfs3FxzJ8lR9l8VD7cx9uxEbMLxV9fPqWtHFV6SR8/fbUMfLWz
 /dX+4P4iIgIsHiuHJlaxmEKQKo/qUAVlZxT6lrr7zvPyaPwSMCSXakNoCymIjkswbieDkoSW4uy
 VzYHcTlP4DBahpHgCIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX/2JdeExHHReM
 cpdlvWwyaP7cl2XDerHjiYLTdXVwr+ybmK1s0Xb1kzVlT7HUN9elDwewFBSQ2PLbVHMNYd3gD7K
 Zo0jAOejCm9WVtKuFi9DBJb5JMPmuZI=
X-Proofpoint-ORIG-GUID: WTYFtrLKqpGaxTstA-_zrayS4wbk-dBw
X-Authority-Analysis: v=2.4 cv=GI+dgeNK c=1 sm=1 tr=0 ts=6ab598a6 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Ug-m1vyq1uLveP7qexYA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240088
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

This allows each target to provide an additional list of cross
compilers to check. With this, we can detect default cc for common
setups (debian/fedora/macos) without user having to provide a
--cross-cc-* option.

In addition, it allows us to pick up host compilers for various hosts.
(debian and archlinux have $arch-linux-gnu-gcc installed
with gcc package by default, but not fedora).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0006d192cab..59ab73e1d10 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -21,6 +21,7 @@ tcg_tests = {}
 # {
 #   'name_of_target': {
 #     'cc': 'cross_compiler',
+#     'cc_alt': ['list of alternative cross compilers', ...]
 #     'cc_dockerfile': 'name_of_dockerfile',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
@@ -210,7 +211,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'cc_dockerfile', 'cc_feat_cflags',
+    allowed = ['cc', 'cc_alt', 'cc_dockerfile', 'cc_feat_cflags',
                'folder', 'gdb_arch', 'gdb_feat_version', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
@@ -218,15 +219,18 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = find_program(plan['cc'], required : false)
+  cc_list = [plan['cc']]
+  if 'cc_alt' in plan
+    cc_list += plan['cc_alt']
+  endif
+
   cc_cflags = []
-
   check_flags = []
   check_required = false
   cross_cc = get_option('tcg_tests_cross_cc_' + cc_arch)
   if cross_cc != ''
-    # we make sure cross cc exists
-    cc = find_program(cross_cc, required: true)
+    # prepend requested cross_cc
+    cc_list = [cross_cc, cc_list]
     check_required = true
   endif
   cross_cflags = get_option('tcg_tests_cross_cflags_' + cc_arch)
@@ -236,22 +240,26 @@ foreach target, plan: tcg_tests
     check_flags = cc_cflags
     check_required = true
   endif
-
-  cc_from_system = cc.found()
-  has_cc = cc.found()
-  if has_cc
-    if target.endswith('softmmu')
-      check_flags += ['-nostdlib', '-ffreestanding', '-r']
-    else
-      check_flags += ['-static']
-    endif
-
-    cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
-                      check: check_required)
-    has_cc = cmd.returncode() == 0
-    cc_from_system = has_cc
+  if target.endswith('softmmu')
+    check_flags += ['-nostdlib', '-ffreestanding', '-r']
+  else
+    check_flags += ['-static']
   endif
 
+  has_cc = false
+  foreach possible_cc: cc_list
+    cc = find_program(possible_cc, required: check_required)
+    if cc.found()
+      cmd = run_command([cc, files('test_cc.c'), check_flags, '-o', '/dev/null'],
+                        check: check_required)
+      if cmd.returncode() == 0
+        has_cc = true
+        break
+      endif
+    endif
+  endforeach
+
+  cc_from_system = has_cc
   build_test_depends = []
   build_test_depend_files = []
 
-- 
2.43.0


