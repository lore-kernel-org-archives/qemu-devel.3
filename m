Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E4CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Com-00065X-Qa; Fri, 10 Oct 2025 09:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cog-00062z-DU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoU-0003ke-P9
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so21344665e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101531; x=1760706331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j8CXWoA91XTJZvcdb9Zd4U3ILTUSgZk3asP3C56vbhg=;
 b=K8kM1dZG/dII8jcrEvg3FK287Y6DYe+933oXETGKmkwgI88nv5eUq/x4XMDu1Rkaeb
 vmfZfTSGkltBRdcbsdm+Nik0wY8VdJblZIbPwqlFxM6vtBFsKNJovLPAsVT6K/m5IomY
 eDzXFp+tpqzjdv9OfK003a4zDgZqcq4YdeToP22iXyBgDKnQI9jZELUaasqPFs6YNN5O
 wj1TKnoEkMTe8f66D+G8XZt8Bzy4vXqktufil23njmcOAxOSR1v3Ic/6jo9QfxdvvQBr
 6YTneE6KjAqu6dsiFZt3iWamA35fGqMRmbnaJJEiOOrFex+xiTDb0vjDUT1y33j7RlJN
 iQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101531; x=1760706331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8CXWoA91XTJZvcdb9Zd4U3ILTUSgZk3asP3C56vbhg=;
 b=QKOH41db7aizfl1+e1MYPVU6pVLgc7mDwQWQCNZnTxokQXwFVCjUgSxXaFcQ35yqyH
 owhlgJpzXONi6bu9BNd132n3yTk3elChAilON8nQQ3KDyAU4lzJVifoBdbwgR6qwYoNl
 Fb33Fu4ENsjmtp/bFwTt4meZFm2H7amVnvh4Z69pL6mb9+Nsm3HMH8T2ZTgYs3dMb5z8
 2GG4FrC5Udt0ConEvBJQkmU2zb58PoK57UsvuCd9jEjkeaG/RFMLRNh9dyc4s3wNDQ74
 2DJwqMk9uoNA7ahQBeJI+xrhhpxhKH/0Jtc36jttE4gCs2ALuOkKptTSnY9v6QhQiBq1
 rilw==
X-Gm-Message-State: AOJu0Yw0WKKumMRmHFdP1jrUglxCLseUj6zonnocjrYdJETB4Hq7q9SB
 ADPVK4q+S6fOyyMFzpkX7tNWO9WcUxjewci6kC1aH3I25i6Dv/PgPQ6KhYb9ezzefEvdOzjWJkE
 q1pcg
X-Gm-Gg: ASbGnctH9WMhtZa5LPgC669PEClEYLKWJw98SQ2qjGzUiiEfXU+4bdgxwdzzgp5ouYa
 RjMmKWM/ABivFlGJ4Ki51YPM+eZgeme2J/BuR9ZpVn3QOUfemhAO7qET2Hm/bPEDAhjHICSDESe
 blFTgGEtjEiQJzbj9hRwO3v96Xwe0Peo2P2actWdegLRKqTsQkuEZ1D3x+Ao2UuWB4nKk4uF45B
 2isfIr7DtSMH1/13jzbBIveBzXbvbYX16KRji/tST578zvoXq6iTV+rFQqXijtfoeHWRrk0DerF
 y5vUiYF+WAWeIa8LW70fQjJBAOe4Fl2g4cPK5eZGJXXPXcXm7NvXXzoaYxOKaP9VcEVQkANkoII
 q/spgU8hbRtpBz86hhItl1epCicDFTEp9NMCpQQM6L+D/E9/yXyaVXQYea34G+w==
X-Google-Smtp-Source: AGHT+IGyid99tW4GPFPPNx6LaJM+DPdTHWGJH+l126E+dIz6nwiqNNde4FE8MsZ3KDq9fCv1ZKqVzA==
X-Received: by 2002:a05:6000:4006:b0:3f1:2d30:cb5c with SMTP id
 ffacd0b85a97d-4266e204a1fmr7345699f8f.23.1760101531048; 
 Fri, 10 Oct 2025 06:05:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/76] tests/functional: update tests using TF-A/TF-RMM to
 support FEAT_GCS
Date: Fri, 10 Oct 2025 14:04:12 +0100
Message-ID: <20251010130527.3921602-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_device_passthrough.py | 4 ++--
 tests/functional/aarch64/test_rme_sbsaref.py        | 4 ++--
 tests/functional/aarch64/test_rme_virt.py           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
index 17437784bbe..05a3f52d5e2 100755
--- a/tests/functional/aarch64/test_device_passthrough.py
+++ b/tests/functional/aarch64/test_device_passthrough.py
@@ -85,8 +85,8 @@ class Aarch64DevicePassthrough(QemuSystemTest):
     # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
     ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
         ('https://github.com/pbo-linaro/qemu-linux-stack/'
-         'releases/download/build/device_passthrough-c3fb84a.tar.xz'),
-         '15ac2b02bed0c0ea8e3e007de0bcfdaf6fd51c1ba98213f841dc7d01d6f72f04')
+         'releases/download/build/device_passthrough-a9612a2.tar.xz'),
+         'f7d2f70912e7231986e6e293e1a2c4786dd02bec113a7acb6bfc619e96155455')
 
     # This tests the device passthrough implementation, by booting a VM
     # supporting it with two nvme disks attached, and launching a nested VM
diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index ca892e0a8c9..6f92858397a 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -25,8 +25,8 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
         ('https://github.com/pbo-linaro/qemu-linux-stack/'
-         'releases/download/build/rme_sbsa_release-a7f02cf.tar.xz'),
-         '27d8400b11befb828d6db0cab97e7ae102d0992c928d3dfbf38b24b6cf6c324c')
+         'releases/download/build/rme_sbsa_release-6a2dfc5.tar.xz'),
+         '5adba482aa069912292a8da746c6b21268224d9d81c97fe7c0bed690579ebdcb')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
index bb603aaa26c..5e23773f93d 100755
--- a/tests/functional/aarch64/test_rme_virt.py
+++ b/tests/functional/aarch64/test_rme_virt.py
@@ -23,8 +23,8 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
         ('https://github.com/pbo-linaro/qemu-linux-stack/'
-         'releases/download/build/rme_release-86101e5.tar.xz'),
-         'e42fef8439badb52a071ac446fc33cff4cb7d61314c7a28fdbe61a11e1faad3a')
+         'releases/download/build/rme_release-56bc99e.tar.xz'),
+         '0e3dc6b8a4b828dbae09c951a40dcb710eded084b32432b50c69cf4173ffa4be')
 
     # This tests the FEAT_RME cpu implementation, by booting a VM supporting it,
     # and launching a nested VM using it.
-- 
2.43.0


