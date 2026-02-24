Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F665F4BB73
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux1x-0002as-NK; Tue, 24 Feb 2026 13:21:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1N-0002HE-0I
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1G-00049Q-CF
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso41157665e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957219; x=1772562019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LXesVbsYFq4cDCWomK/ccfT2BkYZ/Ob/vUxKUsGgFGI=;
 b=zy7MqOkbZhFacBGxlmgLBn9gV6nEsPT1LypnBjID3zGmhoDC7LQKwWk92hrtOXpxNz
 T03blB2hG58x46nTZtYEpqKLAe84OGfluilsZXHTJRyrHwZKyahb7P7n6ChVqPAnwiDn
 gkcTk0Z57fOdPcJ45CD1efJfh6ni74PcK7Bv3nxcCrGGSVVuhz1jKp7TyY0Nz5iA0rc7
 I0lx89VObmHYlQqt8TAAOYqIHir8ylwtlGO40p3SvE69QdAgdEePa50Sx4M6cja5QEF3
 4RENEUxVpzoUeiNFxqje8LuJ6v+dBApEMPA+0d1EECXqiCVNusldgoyUeqqI3TJYnfG4
 qcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957219; x=1772562019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXesVbsYFq4cDCWomK/ccfT2BkYZ/Ob/vUxKUsGgFGI=;
 b=KgCNi+4t736fzwR+yymRfiehVB4TFdKdnis8eD/8e09enhTUOKIOzheSr28kRRVhP8
 I+FHzGVEFSpgYECS8/sm6EMve/aheH1Nr7jbnOGA6Wk335ncj3GIJrgAYhK0ZRlnd7fh
 htj9FoiKcjqxNcVYqZABuqZykt541/0xqJQiF5bM2CQZIKaR91lDn2nb8nJ1dYfPkCNF
 6/8mHllax/p9h9ZhfXnQoYH+5gAKbQXYXSaXvRglh+bVs1DA3YNu3oA9u4j7N9Oa8DZU
 EONYPu0UbAPOcfoFtIKZT6/75r52zzvlhl66jUUa9CudfiMZzgiRNUZ8W9l6MXU7CNIj
 mB9g==
X-Gm-Message-State: AOJu0YwSup3b/RTV7KlE6Jojp62bJm9ZpiP3hxRYBUtgVkwMmoRI650K
 lFpVbN0YjcC3Rm5lEL+DnpWjTt0to977LdU/VYOHBX2P56MvGV2c9InxppJULqWpHvJyauoYRX8
 OyafEALo=
X-Gm-Gg: ATEYQzzCWM4BpiLZvRCK3oAuqzX30aFunuRJkA/PjsPjHCf5cNsVrn6WZehBpoXTDRf
 rCxYO9lkguOJL8Cpehq6qXpep/VsQNtWlzV+yRYFeAV8ej0BWxhnWo8ml7286JdUtpU0tyuDqXR
 tR8qLQxgxmDrIUKIAqihDOJ6nPEVSchvxhOLMZtOqSieBkOeY/L2MD507FX9SOWOZnrZK2z+qgY
 B3aLqV5dQJmH0u/SgU68Gt2Dg1mq8isbCqJGmoQd1MewvvvKWd67mcJLRx2LYdgaR7ncN/LDsUM
 4A9rd/4vF9Ibb6GSMdnf0OJ8IEV9mKmEfHrHMExvuf/v0sGfFaNTGmFyP8GRDGBdLLZSu/VgVy6
 3BjD/brqyiPB2zw5kJurlXl1Jx4D6bpqUBbsndfX1WKNwQr+g7joEvQpPgLTtvIl9FBD28PP7UK
 XajVK6UrMcwSDSNiKcxlY5GzEJjIht5gl46CfN3H91HwG4CZa/HRldDkk2r6e2F0DiZEKZI/zV
X-Received: by 2002:a05:6000:2890:b0:436:37e4:594d with SMTP id
 ffacd0b85a97d-4396f14cb64mr25615950f8f.6.1771957219054; 
 Tue, 24 Feb 2026 10:20:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d3fdd0sm28246619f8f.19.2026.02.24.10.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] buildsys: Build most stubs once
Date: Tue, 24 Feb 2026 19:20:06 +0100
Message-ID: <20260224182017.99865-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Use meson magical machinery to build stubs once,
instead of one time per qemu-system-FOO binary.

Philippe Mathieu-Daudé (10):
  meson: Include various directories providing stubs before libqemuutil
  hw/acpi: Move acpi_send_event() function out of acpi_interface.c
  hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
  hw/acpi: Always link QOM interfaces with system binaries
  hw/acpi: Build stubs once
  hw/display: Build stubs once
  hw/net: Build stubs once
  hw/*: Build stubs once
  fsdev: Build stubs once
  semihosting: Build stubs once

 meson.build                                   | 14 +++++-----
 hw/acpi/acpi_interface.c                      | 19 -------------
 hw/acpi/aml-build.c                           | 11 ++++++++
 hw/acpi/core.c                                | 10 +++++++
 hw/display/acpi-vga-stub.c                    |  1 +
 .../rocker/{qmp-norocker.c => rocker-stubs.c} |  0
 fsdev/meson.build                             |  3 +-
 hw/acpi/meson.build                           | 28 ++++++++++---------
 hw/cxl/meson.build                            |  4 +--
 hw/display/meson.build                        | 19 ++++++-------
 hw/i386/kvm/meson.build                       |  5 +---
 hw/mem/meson.build                            |  4 +--
 hw/net/meson.build                            |  3 +-
 hw/pci/meson.build                            |  2 +-
 hw/smbios/meson.build                         | 10 +++----
 hw/usb/meson.build                            |  3 +-
 hw/virtio/meson.build                         |  9 ++----
 semihosting/meson.build                       |  9 +++---
 18 files changed, 77 insertions(+), 77 deletions(-)
 rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)

-- 
2.52.0


