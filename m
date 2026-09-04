Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3C9C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJL-0006B7-5C; Fri, 04 Sep 2026 08:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-00069H-Sn
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-0006r0-U2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49ccfbe062eso7981395e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525978; x=1789130778; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=13LMg+NSAtB4VizZeFc2Tjt1gwiB0gQPaZo/TMmIkg8=;
 b=MtnuFrcTfs+y0EJtBgUOj34asa8BsngThfJ7Zn27FWECfxTVNusHwbJK8L01YmblYG
 JKYN1Ze/pP2wnF5kQm7o+ggkKncyOYF3aLHnV2KkhplVOWBhe8yeOdSJJn5TWREgMU/j
 L5w/X3iUWOWD8te/G0Dm6gdHSj6E7o44gxopHWG6T4dPw6a1gDG3jd2DrjtZ3jvF5VHW
 WOm9IAq8YGzNUtd+1xuSFYpk+D5NztwE+WN0A1Xdao5hXqxB8oJ8i5UCrdHzS7UkDwKH
 s8TFtRQ8hN8ofYvXoCKyEjd2b2r9Yklk1hazySu+ALFpWlrZGfZHxLdchPz2IKLElaqn
 NhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525978; x=1789130778;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=13LMg+NSAtB4VizZeFc2Tjt1gwiB0gQPaZo/TMmIkg8=;
 b=kctVa6wX8u7yflJh7jwWF9EhCEEHG3Qm6q9bbNArFM0earHsasDG5w+BJ+iDxuesb+
 Fj4sbUwgTdGFQbYIIFnYnsGes96WVXR2pPPVd2n9tXPrvGwA2vQfkhvQDRy1bwPRSLm8
 vCVH6+qJXJVLqSEMSu7pXu1zkElKbzQDrSqqPLkSsO0BggndzOsR6lf3MCyOd8Ezk8/+
 0CkEMz9HTNRnD86CXQh6EF1hjYZhyMc0b4+EIcCOU+iH3Jup30Vp/5RPVqMVy9bmm7WM
 YwRREInKHXIcGvnHn2m0HH/HpDR2+IPks3wGH2tUvwf4mHUTRiQhER/a41tKmaSdVZTO
 slZA==
X-Gm-Message-State: AFuF++nrpcSU0tgdh/0IKOrNM3LkRVjDYDDVlw382XpB2l8QgdXWvfYd
 2CfM6JDkZQDvp0XGH4OyQhtVM0Kc6E8sZDOiMJUA5CmJ4Bn3mJUwrI60Nli0K9AgaK0=
X-Gm-Gg: AYBFou13daXsR7OEtkGl/XO0NqGBt4zh53qOZqmAXswGg1dz490RQk1vM8RYzGi7eYy
 P1DJyKvkS86wrfR16n4h1hx2ddm57unURZPCIOjxGdd1vgFkGA7Qt01zlFx7lWks2sT9vao6Mcp
 PtvzwZriiV9S30NfHnUM+azLfKKF6mXBdEAXMyDruLEaDo524UusQ3Gjk/6ZycTW1YUWesMbpI2
 j1SmJRJPUjszj36iNbHt1MnF3o9jVpRyFptf7ItpX101wIVI2tkY6yVuSlj52/bIplmACHCdLnN
 GlaosnC8R1iS+tHcHmlm9+VdHABBMKA7Kyn3BBJVsT3gYaHwpYDXhiipcNDliSlKgtqQuhOR+Wa
 JMS13rfO7p6Pk6DeRc6S8hllQtaom4u4rlOOskTf2G/FChXiEHtJTLnbxT1AuBi3yX2dCKmrFok
 PCjjJV4Xdj/3Q9L3In3A03AH35KDNfUC/2BNyQTZ2gSbcfaap5ggf+6A4kdVOe
X-Received: by 2002:a05:600c:3b07:b0:49c:fa20:cbfb with SMTP id
 5b1f17b1804b1-49cfa20cd04mr38716805e9.18.1788525978166; 
 Fri, 04 Sep 2026 05:46:18 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee7fec25sm168377665e9.13.2026.09.04.05.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 59F476182C;
 Fri, 04 Sep 2026 13:46:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 031/105] tests/tcg/meson.build: use full path for QEMU binary
Date: Fri,  4 Sep 2026 13:44:45 +0100
Message-ID: <20260904124604.2207440-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

On MacOS, meson does not find qemu binary. Use full path to fix it.
Also, add qemu binary as dependency for the test, to ensure it's built
automatically.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-32-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ea17a947628..fe382638297 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -323,12 +323,13 @@ foreach target, plan: tcg_tests
       endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, qemu_args, exe]
+      test_depends += qemu
+      cmd = [qemu.full_path(), qemu_args, exe]
 
       if 'gdb_test' in setup
         cmd = [prog_gdb_test,
                '--gdb', gdb,
-               '--qemu', qemu,
+               '--qemu', qemu.full_path(),
                '--qargs', ' '.join(qemu_args),
                '--bin', exe,
                setup['gdb_test'],
-- 
2.47.3


