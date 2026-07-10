Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3469DC44507
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4c3-0001mi-5o; Fri, 10 Jul 2026 02:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4c1-0001e7-6Y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bz-0004l0-7U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:24 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mhn43721079
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mf2oa1NkMki
 4bbhfmb8SG8t3WH7jRZP/TYKHXo91ijE=; b=LekCX7CfFkAplV9A3ZrxCNtbj/R
 MaqLjnVCWyH3hKWOxdFZg/1MtLGAKgpw5RgMwVgHFvIa/daevWO+IJM92mvWY4mY
 3Z+YcHA3oq+hUSAER4VuqPbXi4d89s95TiATKPFPjbpNuL8pI/Z6f2fiQtlOc3ck
 f0ut2i5YIZMLF+S2ihfTToznKL9JKR1obf+85rZMUIDx/GypQnjbrO8ONo5YfiXb
 NTUsWjPTcgfw4VxbrBvCMAAA1NyS2kRY6B7ZeB2nWbalLfFDpHmubL23XP/7w8DW
 xljn5M1LRL9zsfY8e1Do5lJexwg79UwKscgK6CpxkXvK8iSCLajpO8+Y0mA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9nmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:11 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1d4so582995a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664471; x=1784269271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mf2oa1NkMki4bbhfmb8SG8t3WH7jRZP/TYKHXo91ijE=;
 b=YsEyJwbrPv75v0jH2YYMStMzKyFMmZJYMLkcaCtGZLScDF8A9j6jlCLLT2fY38o5ce
 GYOlsMQE5Gr6jSQQidwkr9al5gQcocEAoUyOs15I0GqTAUvtXNTG0mIm/PZGRaUv71JE
 U6cQC6F4llq5vuhzwmVlBW0nRU0yCVm4EVeK7Pe1HDeLNb6I7PQfFPwWJWnSxMVuSJuQ
 8SVmdjwO5CAhPg90sttFr01H4VEiTObG3QR63pqOaJTdPxApma5BVo+eWfFabNcsKq+P
 aPUAy7Vb6wJRXfXU5C4YImktAhoFYQyzo01WqNX1y9/XKqPC3F4DhfAEmx+v6ZXvZey/
 i6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664471; x=1784269271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mf2oa1NkMki4bbhfmb8SG8t3WH7jRZP/TYKHXo91ijE=;
 b=p9iSJwAhoaKfFULobgbNhCHj/tXSp6rMW/nE4vjD1ZTVxWQKuYwODJrx9LWvUzPmtu
 ohOfeHVwo3klN9/oq7AcOT4LA4c/oKxQm4fkjYvl/aytqg4lsZazg8NspKBRaNcXMENt
 vI4uM0YHtCqBp8F5c3bjJIGDFLRkItn/zYrxTwAEthGv/4Qi9v/qKNVEOYWZ0jVcAPoT
 PN393xAFF/jlB4dPYr+7jRR79fqr80hbmCTm5uAx/mTVwvhzfLug5qX+CKMIB+ODjrSx
 0EkinRjg0IowaG2GULdhnkfV/44RsNf+rpWl3m/NJW9pNCKjvAY6CHEyGb3Ip8Kx0W7g
 +S8g==
X-Gm-Message-State: AOJu0Yz63BC9EN5mdaWStkHCqrpxFAn7Mk4pM8eZ17F9kKxYyyivcV2h
 dkzD5EWo6jDV0EUlg71OIX7mMRxZs6T04wKh7K6kpDAoLQTA4gYN2nqwrfOs5BvcGM684GAr7oG
 oVvf4wViTZgEKrWj5n5apA4Yuf3aKu30YsdIND7qvT53aFwDuyCbFTwXU+LM8FIblFA==
X-Gm-Gg: AfdE7ckEW1tTqFtrHUJrNm3mSUmKghfdJuDND7IG4irI7hw5Qzu08tKfyTrSZtdFr3K
 VABgTfylJuVxOHhtxX9tm2ExPdue3hf08HcpVMae9nSJ6jRxOVl7I59+QhnpHEXuMMwRyv0yc1z
 /7BfkYHCDX771cm/h4vALoXAcbMLROw8OKFXiPKsuiPjh4mH/RjdC8xZC4eXM8ayYw2npbamyhe
 sOQjkU52ch0CAj+iCM7VS9Z/iXpGfAfCezYJTQZfGQdG/ehBB9IvRMDdTePjM/k5INumsPwmnmy
 LrwFf3sIF5lQ5UkAk/DZCDzQLnsR0sTRLxNwcdSUXnKzGSC+B3ALIB83VFvy6gaopvWF7mGWmde
 gkdFA9FaCZf7JfemfAV6O+/TXlgdFM4YWmVlLPcN7gkuMxfEGDof/yvRxniTkjG48S6SdnGdJ2G
 qwiU262Q==
X-Received: by 2002:a05:6a21:329e:b0:3c0:9c19:65a3 with SMTP id
 adf61e73a8af0-3c0bd287dc5mr12676570637.75.1783664471066; 
 Thu, 09 Jul 2026 23:21:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:329e:b0:3c0:9c19:65a3 with SMTP id
 adf61e73a8af0-3c0bd287dc5mr12676530637.75.1783664470652; 
 Thu, 09 Jul 2026 23:21:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 25/97] tests/tcg/meson.build: let test infrastructure
 detect compiler
Date: Thu,  9 Jul 2026 23:19:03 -0700
Message-ID: <20260710062016.1818125-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a508f57 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=tvGfH4KSH3m2s3Kz7-kA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: xxNf_jc78Sss50cJy8Zn63U-mRW-5Ffp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX+cP3+5+24Fqt
 hWDhYY2sg09yhGHJ35uImt9PGHRR0hKpTgnx3q1qNZ1++AiNvt/Oq/GAfark9qPPNLhk1uFKc/v
 ycpDWtOg/ED3D+EGTMfDzVHONN9zGxE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX4wKrQatslC4a
 PJdZpp4BPedDoPmCIx4oRUxRKpiDgJUNzQEngf0mPz+nkkZdFKhIuddnRTU0sFjodL+0Rmo783C
 CyKWpFUfjMaPbM7CsPSviy6rX+p0lfkzsFvfQYZVB4zdM1VvJlRQST9Zr4WRMbzMAV5BXPrGpqW
 xwQsZCenDH72A6wmPqOljen4RoYbxk82EhCpzuYdKiRd3KRGTrM0SqxFItWrHerZEXEg5iV3IEh
 t7Fmav5Da2yR4BdHxQ6uWmE60nrJ6B2tuQkgn7qpy1Ddq3DZOnLC9OSNOTktpWd2TMG0tePqyln
 AvOD0b3y58K0PouJ4nxGvqEiXaowDXq8hDWaArsX11oSo01ldKQSLnQ6Wh/u0qMPL7FNnhH2k17
 tA2fhoQCFxD7+b7X5bgY/J1rHsnDvgUYxI3UkfbzkShJhKXtYAUBa7oXl/Dhg25lnCLj6gZDbi+
 8gQwmV16pHf7slzf/iA==
X-Proofpoint-ORIG-GUID: xxNf_jc78Sss50cJy8Zn63U-mRW-5Ffp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 572003f4ee7..cb58ad25a1a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -19,7 +19,7 @@ tcg_tests = {}
 #
 # {
 #   'name_of_target': {
-#     'cc': cross_compiler,
+#     'cc': 'cross_compiler',
 #     'cc_feat_cflags': {
 #       'name': ['feature cflags'],
 #       ...
@@ -96,7 +96,7 @@ foreach target, plan: tcg_tests
     endif
   endforeach
 
-  cc = plan['cc']
+  cc = find_program(plan['cc'], required : false)
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
@@ -189,9 +189,13 @@ foreach target, plan: tcg_tests
       if 'cc_feat' in setup
         cc_feat = setup['cc_feat']
         if cc_feat not in cc_has_feat
-          cmd = run_command([cc, cc_check_args, cc_feat_cflags[cc_feat]],
-                            check: false)
-          avail = cmd.returncode() == 0
+          avail = false
+          if cc.found()
+            cmd = run_command([cc, '-xc', '/dev/null', '-o', '/dev/null', '-c',
+                               cc_feat_cflags[cc_feat]],
+                              check: false)
+            avail = cmd.returncode() == 0
+          endif
           cc_has_feat += {cc_feat: avail}
         endif
 
@@ -202,6 +206,11 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
+      if not cc.found()
+        skip_test = 'compiler ' + plan['cc'] + ' not available'
+        built_tests += {exe_name: exe_name}
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
-- 
2.47.3


