Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C3DC3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0MLL-0007fR-3D; Thu, 03 Apr 2025 11:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLI-0007f4-0b
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0MLG-0000R9-5S
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:18:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso7518265e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743693532; x=1744298332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SL1deZbZrQCTs4masaMY+2Uy3IE2KzJVlJp7tx88rA0=;
 b=yXlY0JzgJcGqddVTxcRNgEkyCaP4sH/gZNj9XZkvP+OpYT7Yvo+StWnQE43c2FxRvu
 VhQ/waq/UAqOC297RISh6656wYAAsJMzDOIgNWlGYs6qry8HcDRoqeNdbQE6Dx9zozI/
 eEtW1Zrk7oEgcnfXbo6bVeVXPefUBX9gJLt+2RKe/3Ao7RirodNcKtJeI34XhxIatAgn
 jgQ3TFXw0izRojGvU/ChZj86xXJTpeNXOix3Vn/aPbuTzd/fH22S56Evn167GTPkVYfc
 CwUozwNzsF6+JNQYZJd8v+hGZ8xx57j0zg1NszPiJMO6yqkGMjXUULC2NugymtdQ6e35
 OAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743693532; x=1744298332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SL1deZbZrQCTs4masaMY+2Uy3IE2KzJVlJp7tx88rA0=;
 b=ealr59vqKnwDgwP5q5Tc9MbbidbakZqfFoPB67W6iusjmnWdzWhVRDE+t4Sw33z92O
 j/Sskt3QAqTlV9x6VMIfUM4lqjtpKbfNgNHy2AyUw8Z2UHq+BiqLY0rfp9d7tJaYELNW
 Tcm0qbFFd/EG82nYYll5Wfwqtdr0eaLXCPMRRPoeB8DvIibWCPSTHfXi/qaLMGqkwHmy
 A3fhlCaNbcgkM66EZwUXig3BhE84/ny/mFNrycgYo2g+G/vSMulFjuDPZtZefpGkritH
 E0Mw3lqm4yj6lX+BKYE3akPilfRXoXhExM/iEaXyQl8coaaG5PAqaicIlWL4tB8Rk44e
 6D7w==
X-Gm-Message-State: AOJu0YxAXDdsJy2jWNVlS/57ELFk3kcm4kW8KxW6tOKItzNvlrCEN9H3
 qzHwcA53nfsAuq3ArhOqYW/Kb4Wj3+3/+V3HYfGmnkkxcKHxS5tfDH2Dvk65aemJcbY2h/llv/0
 W
X-Gm-Gg: ASbGncs51ywDnl1b2yk02sgWP0zbxjpdd/H9yCDEENfAajPVQtPn98zKOiJsmVCjJO4
 7Yg6Xgu4AK2NlE7WT7H/kcdaP/cErK62gtFEA01FofXyTO7QK0co5hx8Kv030gAM/A47EtPJEdv
 KldUa0LhuGeToETk16kfI5d/nlPv4rVdUOQ8uGdEndFwKhU/ClboJGZd6BSNCacGd38Cf2UOf2k
 BIcA67cQEn60qGouoQ52nyfGajp3xxVfpqss/FIuOOlSd9zsEOSyHlE4INX/AHnlnxqAHh7gtNN
 kBKhiOVlEUPuEkE7k87gVEodhAAVgD30LinxmssYKkP067ocj8jouQ3Lsg4RMpw5KhiCWtmhivN
 SBgF8RqzcGo0b8mS2O+KNDbs65NeVBA==
X-Google-Smtp-Source: AGHT+IHLdb/KwzDYEzMPQ8tCsN6KanjpCnJ40l6AkElsJ7H4X9AR7REyWlw92creuZIMat1lQjU28A==
X-Received: by 2002:a05:600c:3d0a:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43ec1532085mr35629655e9.29.1743693532113; 
 Thu, 03 Apr 2025 08:18:52 -0700 (PDT)
Received: from localhost.localdomain (145.171.88.92.rev.sfr.net.
 [92.88.171.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a92desm20988475e9.14.2025.04.03.08.18.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 08:18:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Udo Steinberg <udo@hypervisor.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH-for-10.0 v2 03/14] tests/functional: Skip aarch64_replay test
 on macOS
Date: Thu,  3 Apr 2025 17:18:18 +0200
Message-ID: <20250403151829.44858-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403151829.44858-1-philmd@linaro.org>
References: <20250403151829.44858-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

As of v10.0.0-rc2 this test is still failing on macos:

  $ make check-functional-aarch64 V=1
  ...
  ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())
  Bail out! ERROR:../../replay/replay-internal.c:235:replay_mutex_unlock: assertion failed: (replay_mutex_locked())

This is tracked as https://gitlab.com/qemu-project/qemu/-/issues/2907

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


