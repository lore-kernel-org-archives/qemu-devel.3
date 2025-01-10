Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A010EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtx-0004j5-CS; Fri, 10 Jan 2025 08:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtn-0004dR-6R
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:03 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtl-0004hq-3W
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:02 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361c705434so15411125e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515079; x=1737119879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwTkOGv59VwM/V59PBnunUCxSh4hXLsryxJ4F/T0+aY=;
 b=UiE3PxDWVdkEn+/O8q/MDo6xu3ZjKQSpUj43sQixbquXPT48BbVF/rfH09hITBgpbt
 Uctko6wBhPhcNZsBevwS9KcMrXI+3ng33Kn/coHBL6UuJ+FxKPa6Bk1O8sga1n1gfi9d
 RSY3wNCfSJQ0z0+2w4QopuZq+ahWRFzRJvc7eQopqq5BvqoMLTQkYBqwya/L5/Y7QBJ/
 qyKZDHQNudGjWNhRuVQPYAj4kVV2cbZYQX5dC5DqbgRhbwFDvnXJgWwpbNx5MYG6l+jC
 qoV4P2EFNfdNodFCYIOHyxxQPF5muow6FYCHW1+RGHlDLo1D5yMqLyT5dToHqjW3uYTM
 tZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515079; x=1737119879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwTkOGv59VwM/V59PBnunUCxSh4hXLsryxJ4F/T0+aY=;
 b=r7GXdU3OeLq+ku8qcYdj8TO9o+f/u4iZgiNxLGvS9dPQU//sOIpLL61KjOP7kU5bnn
 hzAkR6rlMZ7xUMFzJK90p/r8h7QoNYCxaWb0jmK3PUCv5UlEOir76zCj8koMDulhkIAY
 9qdzShPQiYXY2TWfXO2vehOulewMhppj9fEBaS27D9OMqNVtaVSJ2f6tI7vfEpHV7HHo
 3iA87VYSLciuVVJMSakFPJj71VSS8kVcyQzNegBMwD1NnF0fqcV17R5L1JSXrvkshvCZ
 VKIVK4RYUnFXgrSl4rB1ZO4KIqLOEpcJjt1S54TsL5OIfJMqMeL7dFXjYL6sNlUhuQsi
 HiNw==
X-Gm-Message-State: AOJu0Yzb+xCpwdYyewXZwwcMQtM9UOd9ZMwC3YrFbyMSdOppCsFlrjwA
 e4A5wSvXes5s0hGyPy7o4JpA47JLKyQQdjV6MI5jy4M83U40cxY+KRrLAVWzfvO8V+Sr9DGwB8u
 EhuY=
X-Gm-Gg: ASbGncudlMaTzbgSjE9cWe6JlBanO0rbUDnk3SNRaFvEiwV2mxrh0RIh/ymAm5Y/n0U
 k3Lckxy1xyf6VXEf+MyvKu2YW5nsy3+qHYFO8Y7YamneqJCJcyPM050B2OAWyS6n3FGehBAXgpD
 wYb/Yv+tbyhJ+nXFKezUbsfTPiQ4voEBzrrdZq6FYW6Aq4U84fyc6pA6S4/m4fzMw5fljSRMC4t
 8Dmwo85ktwsPWyn2uv+baam9L4YDzRupPEPAfvv8nrI4R+S2y4/3Fc=
X-Google-Smtp-Source: AGHT+IEolU/d0OwAHXHioguedPwtvc7Rz4iSGY/tmLLDvUIm1LslubR5pe8B86ZTjDlywYA7Hmmx/A==
X-Received: by 2002:a05:600c:190f:b0:431:6153:a258 with SMTP id
 5b1f17b1804b1-436e269a7d5mr99996955e9.13.1736515079320; 
 Fri, 10 Jan 2025 05:17:59 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc05a1sm87592635e9.15.2025.01.10.05.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A275D5FAA7;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 06/32] tests/functional: update the mips64 tuxrun tests
Date: Fri, 10 Jan 2025 13:17:28 +0000
Message-Id: <20250110131754.2769814-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-7-alex.bennee@linaro.org>

diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/test_mips64_tuxrun.py
index 54af1ae794..0e4c65961d 100755
--- a/tests/functional/test_mips64_tuxrun.py
+++ b/tests/functional/test_mips64_tuxrun.py
@@ -17,11 +17,11 @@
 class TuxRunMips64Test(TuxRunBaselineTest):
 
     ASSET_MIPS64_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/vmlinux',
-        '09010e51e4b8bcbbd2494786ffb48eca78f228e96e5c5438344b0eac4029dc61')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/vmlinux',
+        'fe2882d216898ba2c56b49ba59f46ad392f36871f7fe325373cd926848b9dbdc')
     ASSET_MIPS64_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/mips64/rootfs.ext4.zst',
-        '69d91eeb04df3d8d172922c6993bb37d4deeb6496def75d8580f6f9de3e431da')
+        'https://storage.tuxboot.com/buildroot/20241119/mips64/rootfs.ext4.zst',
+        'b8c98400216b6d4fb3b3ff05e9929aa015948b596cf0b82234813c84a4f7f4d5')
 
     def test_mips64(self):
         self.set_machine('malta')
-- 
2.39.5


