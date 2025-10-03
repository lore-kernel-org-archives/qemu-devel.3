Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30227CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jGs-0001Ua-HV; Fri, 03 Oct 2025 13:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGn-0001TB-Gl
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGP-0006ER-Lr
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:37 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b6271ea39f4so1135175a12.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511283; x=1760116083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qKAGfZs2aUn7WyuimaFd4lNQuJHE6KaST0vvQSal6OY=;
 b=MOu2yBHo3rk3n7bucT28+9jAisO6/h5yFklBudqg56ZhA+SXPas1sbLynVAAxj0khu
 rnINiZwvVgk3oKgWQ0b39ejMIosl9EZ1Vo4EWCBs7Bod45N1tPKFM3mefZ1c8gR3TEym
 Zk0EFjtmeZOpgQLSv8aPjZgzrSFzJhxCaS4AnE1VmgMYOid2UiGNJa/eMySVyaL438kE
 iASUmx30CVjzAh8MnfziEFm+zQMK8Y480cmZvjTCT3A9k3BBqWVtkVOURVwMfIUvCYWi
 +4TH5qykuJ74ESN+/atmNRee9mvyH2HfzXTFBdIDkbW3W1a4NVm1aSqyl5eBp/fudHyV
 EGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511283; x=1760116083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKAGfZs2aUn7WyuimaFd4lNQuJHE6KaST0vvQSal6OY=;
 b=UfcswI4vzdZc4yn+dRkN5hfAw+AtEHRg7rqDilROSePcyDaD8GfmMT6xzOS56YHt5d
 AwQyiEXcMDVHxGJ+bF9yVI0TUxJCRPhlv4jHVoJbnHaTRGvPEOnt3C0cDzAQ5bixKFfn
 Pcz+KSvzYko6UZpyTXv9GAtxh8YklGT9alhITWCOHP/+3Y8WnsLC6D1od0AIFQyqaeTr
 f30mrVxKs1sB1XN4R1S82onfK1eFLVKIhGR9dGax3rIZMplpRQRTOkXFmgZRN+fUsjni
 QoJ2ZQf1QTGjnUZKDkz49Qp0laQ+nk5Fc5/OXXfBTX0kSc58W/i9D552IJxtVNNIEMZe
 p+3Q==
X-Gm-Message-State: AOJu0YwdJbmrqqGNnCqPbln1ixh9u5+J6TP8rDM5Pwn7JVFfYODeFJjh
 015MV7O+ZlgQI1kSvEpwl5xMIcn/SstraHR96QGX4nM/tY9POJY0YBnfZXysovarnXE94gcx2Ex
 wI+iUQDk=
X-Gm-Gg: ASbGncvKKEWR8nx7jEg2D/02TFRxf04+z1N5F2esyr0HjdxutSM1IFB5xRmc06CQ2uW
 QLqbU9VR9iO3TR2C//ILVxNHrlc7WJM+rykOA49ginL2XJ655BXA/99azD1Xrv0q6GyvzGyyjaq
 QSeF2G+U4JoLdYYB9+JjYjPdi8wJyGEeHq6PHEdnE8EOpqDl/I+ThaOY4+VFCrcXjOlCT74fUOQ
 lhYfKkEyY++Oj539MH/hHN1S/LzEtTlrfLheJg7nX63QojrX3mCs1h735IEUW5qb2TnIPK0TkmC
 NqChhtfnZdAMFUHkEzy+1ejWHuBI9pG9GZGkvyMTAuK9unC4JqGAp9HjpfKhzd/yN3rf85vTaoF
 EzbyjEEUDZl2tQ+68iRb0/A6KhaIYNDgfs5chPjJo2G0iQC4xPILqyl/S
X-Google-Smtp-Source: AGHT+IEgYc6S6VkZf57ZfxfeIDdDGT3X8llH2tosBjnnImV7uWQkZBcxsAo+P6vN3DCatl9aE3P1hA==
X-Received: by 2002:a17:902:c943:b0:273:c463:7b2c with SMTP id
 d9443c01a7336-28e9a54edeemr50996465ad.3.1759511283326; 
 Fri, 03 Oct 2025 10:08:03 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 01/73] tests/functional: update tests using TF-A/TF-RMM to
 support FEAT_GCS
Date: Fri,  3 Oct 2025 10:06:48 -0700
Message-ID: <20251003170800.997167-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


