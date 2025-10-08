Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE56CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9M-0003vI-1s; Wed, 08 Oct 2025 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9G-0003tc-SJ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:38 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c8x-0006cP-AR
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-27eec33b737so4614605ad.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960575; x=1760565375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKAGfZs2aUn7WyuimaFd4lNQuJHE6KaST0vvQSal6OY=;
 b=KolnlsBOqe7oIlW+BvMDVaV2tX29HSY8HvzGDczXYmf2iU8Q+C2jb+FTY6h5QWHpDS
 w6OVZ9QdNXTvtz4ugQIcLdQ4XmWyrZHj6M4MOc6gEpCt0Q9Al266LDmgLdPgFImeBvIr
 sMN6OCwJ9Yrn+C/1NJdRBJ8wy4wOk+lWlAVlgRi3cAcX1bT1rtqgRLUJbVcHII20dhAq
 Yb4ZzcCZgFAdZ88y7Mp2HmE6ONw8TmeJEigMJbCU02/zeixo+pRy53J4Dp93DlomjDZ1
 ysCzfXc8UB39Tq4I+HUC0opGXvFHR4gb1ImEcJ/rfKmvg465u6MDvRtaQG3nTNlSbovs
 PzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960575; x=1760565375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKAGfZs2aUn7WyuimaFd4lNQuJHE6KaST0vvQSal6OY=;
 b=cTa0W3r6F8JlgL/jrm66pY9BfqsHx/fMu+nFTBaURdR3g0nE5g4VkVrrZ5qBEpcJ6J
 FOEs8fRBBhKbdBHL5Vr4f0etH4tK4YvbtBlbXUlmfsd+gfHjePXzwPzx7IptnxNzaT0K
 AEWMWJWd2P095Eqh0RPRoVZK+69stabeImaW4zidzyBlYDqoFsWvjw3+QbBDl54JF+Y4
 SCT3yjBNL+dLCnuBmYx1qq+hvjkHaSbJ/yTar5c+GCC5F++vDC2ios6hRGp38GgiF0lW
 IWccHAFi6aEJsgWCquEW519kaGlyKsYACcOR/sWye1D2PBspWT+HZTUeERD5pL7Qri5+
 LC0Q==
X-Gm-Message-State: AOJu0YyzVHRiSxZOqbF+pCjAUnCstz0WPnJ82NY08jO2AAR8AkbTLEmp
 DVM2BpaO8ZNldW2/BFZNvd5/ckC8sRnLH9IsDVR8G7iuzApilARuRqHW2Zw1m7bBLxCapHjsOhH
 l+1IHlCk=
X-Gm-Gg: ASbGnctx1RoKEOQIU7pfA+Hsr/whvS52LkI5p96oczBMij3xxkqmwQf9myKeEe4tA+Q
 WDYhREv+nTzStX0hwEEI1+AZDcFjlVduuH0utSoewxKVqYb+7yoAESMvggzU3+J8KdmE6Xm9leT
 MN0ktEbGABDVN8nwxGZa/nfkeA3PU/4xCkLWUYzZSMrvAGjtGVh+Y55XTRBLBi7GtpL4rBbV9mD
 me9w1ds3s4Lc8QJcvRI6V8CaTpuHwWkOU2HeKUn1tBdQcO6NKDm0DDpMqVFNmtKUWs415n7V5tB
 225CgBodeMveD5jOde5sCwjiewcAb+YHfR12llNuGi5z947PSRDRmtQrlzDda0jpQ4vAcIcsWjh
 Cu+CWwqb3q6V5UNEu9L+s5oWGje8qNG4q9JRl6kX/izNBYntNYu2ydQOF
X-Google-Smtp-Source: AGHT+IEi4ndwlg8/dfO34ERJz1qGEiG5DKmWz1edUyAE0RlDMpD33nKkzhV6S+DZ4xjN0WZ/9XlUxw==
X-Received: by 2002:a17:903:2343:b0:25c:b543:2da7 with SMTP id
 d9443c01a7336-290272159e7mr51517395ad.9.1759960575258; 
 Wed, 08 Oct 2025 14:56:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 01/73] tests/functional: update tests using TF-A/TF-RMM to
 support FEAT_GCS
Date: Wed,  8 Oct 2025 14:55:01 -0700
Message-ID: <20251008215613.300150-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
---
 tests/functional/aarch64/test_device_passthrough.py | 4 ++--
 tests/functional/aarch64/test_rme_sbsaref.py        | 4 ++--
 tests/functional/aarch64/test_rme_virt.py           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
index 17437784bb..05a3f52d5e 100755
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
index ca892e0a8c..6f92858397 100755
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
index bb603aaa26..5e23773f93 100755
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


