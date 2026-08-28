Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393FCC61DDA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvSu-0007nX-Tb; Fri, 28 Aug 2026 08:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSt-0007n4-Qv
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzvSo-0005Wv-QK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:13:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4956869750eso5690205e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 05:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787919221; x=1788524021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h98rJxO4BgEZh3Fit0p1BlQut3znbv3PxOdRc7eAT7w=;
 b=MJxzNuTynFQSyxdt0HrwhoiZyN7YDAZbxguzvar0NyOU5jYswwalByqOfGgzLNLgzE
 va2ObJgce73TflJLWW7S/la4MAluKQZr0jmNSw3MkYewhfDNo50XHC1QJIHDL6X0uWN7
 fuPQYbVu14zUUP59oMObqKxkMCT93IGALL1yssat1UCQtmjbfj8G3qJe4RC/af1O2PHw
 zv6T83BPgDU18pqtv6VUTw7erEURHWYo7kDtlVGAIaraC2QC0Bfu355meaHAkthITUp3
 6UKbkGikXdqA9eW6dz1ABNnAKWhTIODMLGAlWlaN8v2kdVL4rxGX+XVrtq2XKAIHeHwC
 1pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919221; x=1788524021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h98rJxO4BgEZh3Fit0p1BlQut3znbv3PxOdRc7eAT7w=;
 b=ErWZ7EhO/m+5AOn0enY0zunD5jVFoK9qTG2vQFgvSyDwYuSHb8iNPKI9Cb9HtR6D4n
 oKS1iBHxsq6APMf4pD1q3dcJjhAv8VZRqSJdW6JYXLbBJbTyvkTzXvK+72VuMQR1KEuV
 dNV3/hZwTcXXajFIbxeIME3XZaTLX7e0ouQAssk9wtECDyEUpOG+8Ve/nsU5RKYkdKog
 WUTJseufvwfgj2zSzJEhYX/sNKbPIWrQSraBdDsUuDyNys4wDhhgqpGmf/Ax/Z0/Qcla
 aYOO/Np8boegzAdAtI6ZX268dz3Nd8mUE+tV3cahLOb60gOzeDk55U7u4bQmzNvdWqwC
 tPVQ==
X-Gm-Message-State: AFuF++mcHErczxGSBh2vYXIJDl4+xaJNZ8OF53PiUOBN4e/MHas4YZD0
 hOMY/MKo4vc2hPuvl+MIZhcv3s/JWNs8cKLpm1DOIT1nA44wJsk6e89aCzR1To61t3g=
X-Gm-Gg: AR+sD11K3hbEVZ0ReP0ebNVkvyDsAW25F3zkBbO0IuIvmbuAN/6YRZ+t4C8z8JSItGK
 EUwGLHZTY11SGSzY5N9xNMX3eaCSEpNc5re8BRGwd/wUocKixGqzKbKRohQif1ZdlR1nCL3+RvR
 H+krH91ZbTOvig7vDaKyRdW9XIc6g4gSMg5QkgFD/1bNlsXG3RDQsCe9pj1s3DoFe6moZA9rKLR
 2CjpoZtO+YnQXWiJ5V9NBdYsdlD4ZBVEhqqsVV7KOm5q5tFDr3THrXH3+y468dBgKSphEifwWKP
 0Zv1x3g/3jTz2xfhjPeghHZTPI4QBi64j6Dz+jWdSoTPdVDjFfaKd4ACTTty5nm06KYEvXCSxx+
 HP1v7+swfThoIUI5EP0T9aLkubgx3lq2ENvSsM69HctLZUvu2FRfJxT50xX7YPG1nQnyyvROkG3
 +G56308FCKcu28Ddqn0hvDjl619CDaoyGqcVYL40dECSZV0DLTEdbUvg5R+eBj
X-Received: by 2002:a05:600c:8b86:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-49b91c2777emr113035695e9.7.1787919221042; 
 Fri, 28 Aug 2026 05:13:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20784sm3659186f8f.18.2026.08.28.05.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:13:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E99F75F954;
 Fri, 28 Aug 2026 13:13:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 1/6] gitlab: use .base_meson_job_template for macOS jobs
Date: Fri, 28 Aug 2026 13:13:32 +0100
Message-ID: <20260828121337.2277303-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260828121337.2277303-1-alex.bennee@linaro.org>
References: <20260828121337.2277303-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

This way we'll get more environmental information which will help with
debugging.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260824-fixes-for-11-2-v2-1-352c6b890402@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 641a48b3832..bdb3eae18f0 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -1,5 +1,5 @@
 .macos_job_template:
-  extends: .base_job_template
+  extends: .base_meson_job_template
   stage: build
   tags:
     - saas-macos-large-m2pro
-- 
2.47.3


