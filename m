Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765FAC54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 01:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK5tl-00080V-Tq; Tue, 27 May 2025 21:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK5tk-00080E-8M
 for qemu-devel@nongnu.org; Tue, 27 May 2025 21:48:04 -0400
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uK5ti-00025C-Hl
 for qemu-devel@nongnu.org; Tue, 27 May 2025 21:48:03 -0400
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-5259331b31eso1333668e0c.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748396881; x=1749001681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Jh3LV0P6chBScb3dqZwjbGR8+3MCbXx1b+bmGLLAUA=;
 b=cPfDpFD9aiaYcfrBdN0+VD0KKWhkNYe0TDZZudqbqr1BnRBY3Gz1QuTytoAq1dqyq0
 b4Sty68UdqLyFIfv4B+zwL0H90+avvq0yeP9j55IvrG8LV6fx0k7SOsF/1OB9BUaLa6z
 cg6c4+tukhwAo2zJ5UTxPjslUWnMfj4/5qx+x5HOn0TSyk3+waKdyYJmLpc4T36Ih/sE
 /fhqIuMtCowv7aI1e3puifi9Bzs/7MxvWTQHnK8KPirUBp/15/iRCaTeKBnVPKo3Y5Gi
 DxOT1zDdVDOxQYueE2xUc7p+UP1yP0uhxz/UoGIfqOPUJB3PVGmAC50vOBhcpJrmqT1Y
 bHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748396881; x=1749001681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Jh3LV0P6chBScb3dqZwjbGR8+3MCbXx1b+bmGLLAUA=;
 b=Em2xSgU5g09T4reVLScojt7DOe/6xpzOeGQaWhL5zDWtXnH/DP1fSnJKCbiwPSYzd9
 llhx93n13i2Bt0rrLlkkjvZoTUKqo6VpbzH4VUhVDVsJSjwv2CWvNPYZS9Gowr4tmugp
 bxnsC+xChCLRWfoN3eZwKkaG7qZUXmMpgkvir013l+sNT53PSpUjzp+Mfq+tdjH9MZwU
 FFf6+5Eu6phsPn7hMxsEKfZb8Q2BkeHgGgPtGq62vWfgsfj3D1RsYdEu6WVVAlt+nt41
 M9EkHL4BGKsWFMS9lgjRklE/O0LRT4Be0cQD58QWukl73pdXzHrlq87GlpnfH/uCUkuN
 /WEg==
X-Gm-Message-State: AOJu0Yy/DQgUaNSI/SJGTg4zUw9m2ZfB20TfHIPMjzsTyMobNdDyPmvR
 1MfUrJEF9GV7HNfMyMvO+pkuQWeSjkbMu5xfHPY5x26R+A+bAvY4yiZJ8IdtTw4AI54=
X-Gm-Gg: ASbGncs+z2rGSQuoLEXmKDTgCQ1PU1Ba9mFUNpaScXQYxHqt3MIvZWLmMdtsrpfdY7T
 tkqgVMa+8vyFhcwb6VN2vfwEc8jKy9m+N66JK9KOv1yV7VP8VphiIUyPj5c50+nt98qrydnnTkX
 hRnlTMkGVBEqPU0AIWQf67wYhxe3WkBgD+0OOAOXDgYyRY6QkLwixe/nmaoMmZRJQlHM+bw52Rz
 5FwbN3wrFALlMpi6A9nCCkrbzbH7RTIq/KV5Lt3+s0fIMWdyCrUlNjzW1QtLy3AYGERGiw1CGjd
 5SRWEW6M2CLdtbJmgI9CT2CWruJK/a9VyLdekpvpmQrNFMlBdYGx5SMZrIVO5hOGhpPdPgrp/wt
 ZWAeH2iTD20P1U+WknfA9dQ==
X-Google-Smtp-Source: AGHT+IFvnvy+3yHGfVkH7k9UWYyCF2Rink6hR2FqEopqvNUXmxwDcU85Flb2k0l7fQy3Lj35iabhTA==
X-Received: by 2002:a05:6122:82a6:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-52f2c590417mr12109463e0c.9.1748396881160; 
 Tue, 27 May 2025 18:48:01 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066945964sm145921e0c.31.2025.05.27.18.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 18:48:00 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: thuth@redhat.com,
	alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	gustavo.romero@linaro.org
Subject: [PATCH] tests/functional/test_aarch64_hotplug_pci: Update images
Date: Wed, 28 May 2025 01:47:37 +0000
Message-Id: <20250528014737.1630668-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa36.google.com
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

The current links for the Linux and initrd.gz images are not truly
immutable, so let's change them to point to immutable versions, to avoid
having to keep updating their SHAs.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/test_aarch64_hotplug_pci.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
index fa1bb62c8f..2cf5c28b9f 100755
--- a/tests/functional/test_aarch64_hotplug_pci.py
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -19,13 +19,13 @@ class HotplugPCI(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
         ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
-         'current/images/netboot/debian-installer/arm64/linux'),
-        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
+         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
+         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
 
     ASSET_INITRD = Asset(
         ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
-         'current/images/netboot/debian-installer/arm64/initrd.gz'),
-        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
+         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
+         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
 
     def test_hotplug_pci(self):
 
-- 
2.34.1


