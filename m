Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7E1C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 10:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1traNG-0007fk-DG; Mon, 10 Mar 2025 06:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traND-0007en-Id
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:28:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1traN8-0000xT-KE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 06:28:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bcc04d4fcso23662225e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741602512; x=1742207312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ha06NxopoyqRvQI/XZs/BZ1HMCeMvHjmNb/s5Nuvw1o=;
 b=S6rHeCM/SIKEpG/GiV01bxgrzg+QLYAq+nNqS924lq69YLNm5sGtmKXSHm5vZmL2r5
 i6gCm3CB3HJa8ZSTCeuZcVdDNOivdUnr+4C3rgRFJ+eqD5PR/i9fbhMiFSZ4y97yH//X
 egrH+M1IBGbVAvBlRnjLUl/K2Y439kyQ4/A369477vbndqN8zIcxqmHDRSom+SiQM2dB
 5h6lxuEwISAtjFzNfEG/iNf+r2G/SCc8w+Mg8Yn4GqZNLyAcL5sH1eIcPatIAArW6mFX
 VQuSJuLMqnIZa2yN/fhZJpF7UjxK4prmXvP3PFIM100SxN2gagQf5CrGS6ImfdpBHsDr
 N7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741602512; x=1742207312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ha06NxopoyqRvQI/XZs/BZ1HMCeMvHjmNb/s5Nuvw1o=;
 b=OmMeQqJQn5xBrbOwRFKWq92+77x0X+z8x0XQqFBr8FUQ1JKkShePX3rNuzM7NS2/jB
 UkBMCZ58C9WpIIqW1XmCoZt1ykvSoA764VjX7RYEaNDOwA/bm3frwwfnKVZ95lBr8Yuw
 cpV0VLDrlPwOIaEnx44ygxbf2h7q+O8456y+ujxgOUeCUKeHFxP/4MuQukaxwqW+eXRh
 HcWDP8M57Jwb4wYgBYRNAGVScjuFZUcEUXOdqwauPyM7xq7VmYprIFaZSOZ20j8aAxBB
 QVA67Pvc3wzboLsbqxcZTrZ6+qvrpbPVWFTj3E3T3u+j3SfjrOGRigZid+HpgJpEBYkM
 Og0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlFQfW1YhZprVXHlxrqK7xCBfTcV9DAFY0Km7YIi4p+duu0QWxeWaR80tvQSdNjQthgiFLHu59rO8V@nongnu.org
X-Gm-Message-State: AOJu0YyuT8rovCjAgeD8XZ0h3dew1sBqozqqHMQ+80hgBtEX/uGaPHEp
 Jx+1DK07BCL4LfjctSc7Y+ixkXnaKBGv3in+ljeuYFva1hp9PLXgN/ez6aHxI5k=
X-Gm-Gg: ASbGncvEGXxjOOKufG1LhKxS/fMDIIfAQ5VMIBxryYGtjDMWMdIbkgQnzhelrNZ+FF2
 gjErDK5qrDR6eRyhSOIa3P7whOLIqkSHxPlE/zIa83OjOAxvs5D+b3p4oS80Y09rJIIHwUPAx/O
 ZlG4gFNZ0w8uFHqJup9Ez6FdwTtUXOEKymAUv61Qr237881GuIaJN6pwtJSLtVj9XgScLv/BGnp
 Q6Y1ltnXgvse4TK81FbVAG5xZHEX/FGUc53j6mnfpFq/0pqACtkFOO8Y061IvDyK+KXgKDa1hMr
 Mbo2M5m8nWFg4OYo6wI6WBG3Kf7rjJNzuWKCrWmhbyoH+80hYQg=
X-Google-Smtp-Source: AGHT+IHusQLbULw5cQQ/WbffaxrnxFS0ComN2eSzg9xsxJoVwfJPZEUlxO2hd8rWsie/N4wPRXB3iQ==
X-Received: by 2002:a5d:64a8:0:b0:391:23e7:968d with SMTP id
 ffacd0b85a97d-39132db703cmr6853563f8f.47.1741602512520; 
 Mon, 10 Mar 2025 03:28:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb79fbsm14684029f8f.13.2025.03.10.03.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 03:28:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional: Bump up arm_replay timeout
Date: Mon, 10 Mar 2025 10:28:30 +0000
Message-ID: <20250310102830.3752440-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On my machine the arm_replay test takes over 2 minutes to run
in a config with Rust enabled and debug enabled:

$ time (cd build/rust ; PYTHONPATH=../../python:../../tests/functional
QEMU_TEST_QEMU_BINARY=./qemu-system-arm ./pyvenv/bin/python3
../../tests/functional/test_arm_replay.py)
TAP version 13
ok 1 test_arm_replay.ArmReplay.test_cubieboard
ok 2 test_arm_replay.ArmReplay.test_vexpressa9
ok 3 test_arm_replay.ArmReplay.test_virt
1..3

real    2m16.564s
user    2m13.461s
sys     0m3.523s

Bump up the timeout to 4 minutes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 97c3f4ad4e9..608732bec63 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -31,6 +31,7 @@ test_timeouts = {
   'arm_orangepi' : 540,
   'arm_quanta_gsj' : 240,
   'arm_raspi2' : 120,
+  'arm_replay' : 240,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
   'intel_iommu': 300,
-- 
2.43.0


