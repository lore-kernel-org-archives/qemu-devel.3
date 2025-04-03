Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8861BC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RFI-00040E-MI; Thu, 03 Apr 2025 16:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFG-0003ze-BS
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RFE-00043p-DK
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:33:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso876727f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712378; x=1744317178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUYVIflGesDLaaMP/ur2j2JEaJvbIDtPIxL00Q+AXXI=;
 b=icqd3iAkO2LDQm4JW82e5i04PFlHoxB3gDl8VdEGpBq/VCNasoZBX2jjEa9UXmhj2b
 h8WsRgTSMiG1QcrzKZg27SV7PEZYWZBBQLUN6wwkR4cm3uYsweOABH0CjADd8/ItD6DD
 5/EIDe0tlboP0MrPfIGxEzevlIw5AMUhiuXUhyJyz9Holziax1/B3ZNihiE7Exwi8au/
 7dWLMp5Ee6xLc8LAqBHDdFCGWcsxuksyZuuEK27XEdtmaj9yrKmChDKvVT3EUTTI3PA3
 wjXS7ddQZJrO2MRLiJzS4h4S8cbp3N5RWem0T6aWJRu33AsI9It9ccNVhiO6wo4z4/3d
 rILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712378; x=1744317178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUYVIflGesDLaaMP/ur2j2JEaJvbIDtPIxL00Q+AXXI=;
 b=ERAtXEI638SdX7UxE9RCwOGc4Vx2EKyOb0VlQiYGj3B4+kEwn+bdjV2141yJ5HxLdO
 yStJ153qXO/eUzNpIqNHaJr8QsVa5D4/n0AL3bY9jbF4V8jMmYXmOh27zPg6RexOM+WB
 d/bneiUMWK6JYdcIBjNLjFyNqLBK2ejJ4FWuJwMOhXx/aM/zE+u3zYw9jA6mwOF0ODwF
 ZMkVakMX7MgH/lBaFMgHR0ymzcI3l4VxkwALGoPCBwEsAtLUrLd7n6HHhB2hIdgNB3l6
 5Fjrmx8cYWfKbxGjKM0I+KlbHAvlDxfMWmJM/9qOgzS9Rr247zFrVuQnsnzoPXcCAP9C
 Po/A==
X-Gm-Message-State: AOJu0YzeehLLqUfrXnkZbJc76IX0fabVNVO1zNKHczemRJFBDN07gOMj
 1Iw2oZ7DuB3j1IMVKf4wkJkMOf/ZIbnZrJydBhPxNEEw9FqlQHRxw4jAUssW+nEcTVujtWNRls0
 o
X-Gm-Gg: ASbGncuii+ILu6TxidxTDJW61JxCkwVfbJflo7cZTHE6ImPSVTAJ1RC78StgBTJRefd
 pSMA4W+YqhggBrIbxIU/bDnkungc6SUvv42jvf+1FZTq5mII+92IqHeWAkUNNNqt3bHOKnU9p2U
 Zggo4+8XdbxsOvhvzsDCCOO60w5Drua1kqU66B8gg7WGsh+YQQT9nsvwswM9VmXdXSd2DaL+Zd1
 a3K4OkJARicgIcdnUGgXw5Y3X5Vok71+JQwtloVENljuG2v/b9G8WO7rbkJi3nZ07y4YBCLWPHP
 /WzCdVqUdaDT2PUfbkwyT73QRNU0vZTi/mA886pXMVMKHrLEf0RTCdHU4Ai/MwivAZnujnoomSm
 /hJAsWe3UFDbkORWUuqJjplky
X-Google-Smtp-Source: AGHT+IFuMDYU5C4vra/zISd63w4g/6Hipaj94TsmKScrBLHLx9GhSPj20bLnrPFVU3VA9q+RLjaQxA==
X-Received: by 2002:a05:6000:4304:b0:39c:12ce:1052 with SMTP id
 ffacd0b85a97d-39d07bcd00dmr154832f8f.7.1743712378220; 
 Thu, 03 Apr 2025 13:32:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301acec9sm2634257f8f.40.2025.04.03.13.32.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:32:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.0 v3 3/5] tests/functional: Skip aarch64_replay test on
 macOS
Date: Thu,  3 Apr 2025 22:32:39 +0200
Message-ID: <20250403203241.46692-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403203241.46692-1-philmd@linaro.org>
References: <20250403203241.46692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

As of v10.0.0-rc2 this test is still failing on macos:

  $ make check-functional-aarch64 V=1
  ...
  ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())
  Bail out! ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2907

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/functional/test_aarch64_replay.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/test_aarch64_replay.py
index 04cde433bcf..029fef3cbf8 100755
--- a/tests/functional/test_aarch64_replay.py
+++ b/tests/functional/test_aarch64_replay.py
@@ -5,7 +5,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-from qemu_test import Asset
+from qemu_test import Asset, skipIfOperatingSystem
 from replay_kernel import ReplayKernelBase
 
 
@@ -16,6 +16,8 @@ class Aarch64Replay(ReplayKernelBase):
          'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz'),
         '7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7')
 
+    # Failing on Darwin: https://gitlab.com/qemu-project/qemu/-/issues/2907
+    @skipIfOperatingSystem('Darwin')
     def test_aarch64_virt(self):
         self.set_machine('virt')
         self.cpu = 'cortex-a53'
-- 
2.47.1


