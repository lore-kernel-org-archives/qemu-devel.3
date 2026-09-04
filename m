Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12514C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TaV-0006kr-Na; Fri, 04 Sep 2026 09:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TaC-0006Wf-3I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2Ta0-00039W-3I
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:03:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48584dc164fso932361f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788527016; x=1789131816; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Vwi/v16VEFtIkIsZdprLMxjoR8j+CnHHyslSLdnntaw=;
 b=tLP1Wr8cK3yXc8wi+ZOzcuR8Z+bEdk7nUv0q1QAjr8z9qSXpOaj94Vuah2dMbaX5/w
 SPLpt+tG0fw5PqiVCYohQJdEt8KoPlkbHN1yMdiODEMu6WuQARXPm7xFtjXySPE0lY8b
 F/ZG7UuTbsWFMJF2j48ot1sogS0NyetqQeX2Ms9jA0NNG5Bqd2HC8gHsPxq9+ChQLGVR
 QlvUEdcPRpY5qKsCZGbnzj5T+ZKtnH8ZO0XwalhEwUNkd4i4cTorJOaPMyYMPrd0b7Rp
 qZzH/HEom6Ro7nh544HUGIPx3dHIqekZdXPl83Iqz1xREdq19V71c2SrNJaS5bqAiki0
 SSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527016; x=1789131816;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vwi/v16VEFtIkIsZdprLMxjoR8j+CnHHyslSLdnntaw=;
 b=mPQVlbIlC90rg3qtOH67+FzOLC4tWBMXGccPkKm/YRpFg3B42WgrJyAYhNjCBuPGhf
 sjZCjra8Gp5W/2S012ux+Oj14L/pmvmX7ylOYe78or8Zmn5YpFWfqszq4ZSq9LgF6L7k
 vJ1yWvRESsONKwjc7T+joAQT4pPpRptbS4BxVEB6aFf41haGIXukeenHDiV44875sy2m
 J8rs+sId/YfRS9eW3V0PX77ycCOAkwEEOZg6s7zoTMaJjhjectcv9xwfjyrbuY2NLmYU
 cnNEXnZ/xRjXZAAym/YE/Xt2zQ9Owd7JyoMeTRki4hWXu7kauf5cz9XwUsbGQc9bDzDU
 KmZg==
X-Gm-Message-State: AFuF++nYGqnxE2EnTFuV1oVy5PJ2H6azpYfbB9EFHZzgcQpG/yFSwQc9
 aBYa/P3Y1Oc8GOo7UArAao64gxiQuxTmdhqsmD8i2htOvPvHX3CIHipEZTWZEwEXrHs=
X-Gm-Gg: AYBFou3Ny42gDMdsKE0wfWnhl3d43bNIpC+5enPP6Ij/E2Qq1AB7jsKKGggx7ud6O4c
 zyGqWsbTzxlyOpZAmy+IUpodYza4FDAsd7PHxTyeyfq8Yyo/BvUERfbvsfj92ZBpWo6y4kggfZa
 sNLRzXxSQNZq51S8z2XG7nYc6oQujFWXVxLfudTFswLT7I5n5w16U1yqTeQzwrBEh5RAut0Oiwf
 3OPpuCA3OMpR+nhI9v2h+MfDPCLGG55LYTd9Jw263w3A3GlrC35+0V4sPqjpc9PQHXmT3a0DQSP
 fTH/O5mgPciUmbFUyX1s9pS4jS1BQeH5+Xqu74Vc0DaGBWR9a8yYlmYn77Y9hLEDF2ENOXgbB67
 GlWD3wg4dJb/c7sTH4Han31t2GbzWDGPSIfLbq/6hUNv4bQRFDiPm2FNZlMcHhpkiQcYobm8Qg9
 r3Qktc6Bm5a0+8sOcAVrbHNm2OQOX7743LO/E4UlIGLgnSJWaQvYgGF0y4UO8M
X-Received: by 2002:a05:6000:29d2:b0:484:3311:3703 with SMTP id
 ffacd0b85a97d-485872e183cmr5227752f8f.26.1788527016411; 
 Fri, 04 Sep 2026 06:03:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm6680456f8f.10.2026.09.04.06.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:03:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C5CA661709;
 Fri, 04 Sep 2026 13:46:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 025/105] tests/tcg/meson.build: let test infrastructure detect
 compiler
Date: Fri,  4 Sep 2026 13:44:39 +0100
Message-ID: <20260904124604.2207440-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Now we moved back flags to tests/tcg/meson.build, we don't need to
expose cc anymore in target files.
This will allow us to easily introduce cross containers.
Also, we can reuse the skip_test logic to gracefully report why tests
don't run.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-26-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c227bb52381..9c00d21f059 100644
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


