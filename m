Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF32C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 22:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqgMI-00063c-BL; Fri, 07 Mar 2025 17:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMG-00063P-4w
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:39:56 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqgMD-0003HM-Jk
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 17:39:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so19977925e9.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 14:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741387191; x=1741991991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ztej1BH9DZD90s0lU7Teqpf3X8cBF6MU9CYCXJiixE4=;
 b=gpQtb3h334Dvrg6lDqMABM5wk2vIXdHAKktNHF8xJ1y5eEE+TMagNdRoAqk1nVTouv
 wwWDvd4xYSg4o/ItaYkiXrx6XedgNCVFS3FVXXwcSble39FbyPKIq5I0jgJ+smvZ5+bt
 +ZSG8EPFwkDYfGAeyfZzwZroFt+Dy9gFDeu/iji/iWRFmvKTM5bkTRVfQIMMDpfRLk46
 JKioDQp194/xbKjovYDBpgagzz/S80mT8noM8liO4RKDqp+XhVgKXm6CJDxYWx8ciOaX
 JJLS7/S73U+qj9TTHDKxE1Z2ODiC9UIapeLb2nt4P1j8GU8xH1pTLyoLw35U3NcuMFKZ
 pjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741387191; x=1741991991;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ztej1BH9DZD90s0lU7Teqpf3X8cBF6MU9CYCXJiixE4=;
 b=Tz1fYLKJg8DjFj/n9eDKdI3z99vnDXzkVHDGA2gVp84u+LrMJFzop+YvHJrkDfDo+t
 7Kjb9axHtnDHmJOoJmEh82UVi8jIkHxo0gMt0enMeBxB0waz4VPkhI5TwWtoBAsDwkIy
 phJi7FZLjmzqWeWN/Lk3temK+Q/OunJVgBflBhgs+xXzdAsxspRqE6w/Y5IfrDumUekm
 lb/WO3gbmZiMwFu++9VAJ2AofwjtJpDQxopuVXqfCIYKU3DDBR+s2ffcCdsb4KQg9vRz
 ZJTEyP8gHSzXXrqsvm36PiIT1bqP6w2J7tlVyyMJVwH07OJDkKqoQSv69M/kOTQmtX0T
 8wCg==
X-Gm-Message-State: AOJu0YwG8ZM+dkOAFZ0ih75awdJFzusXCLMEO7oxTCDA8bG2coY0Wpyd
 z7NopIG1Jxevh4VDyt4+Yp5HZEdQoXLJtxTNQgwlqXzrnQX1gCPDQr+bLYg9E+znE5K7bU2g0Lo
 n4UM=
X-Gm-Gg: ASbGncvZG+iF5Ep2pFWhyPzkqKlLeujXPh2wf8LYe2/ujelXzE9OeWNZpHLBAMLcsz4
 Knmp+xbF9TQMZOq3r+q0WRbr7lkhRdswPUjh47mIJxJmwccR8g5a8GFeOwS4IwHUip6Gmrv3+xA
 P9bGNLZAsGFJ8IlHwZ/vDGljjQmtvtKELTfC51vyiBiy9KCxTPlMsb9c7oE4p7LhvGSpqJFQPKr
 cJ7QrZQPN+cZSSl1D42FdarqSPdJLBG2WBVlnErB4mx7KdJhL6Cg2cG1pUZo+GwFxdex7t6UGgM
 FiFAxY+LTR+749FZvCkLDI6NqALO8XZa9oyHWre7Fd3PTo+geE+Fmdw8JZAtqm9Pf+8iuJVqv5a
 JR4W3jLfleYX82MLobEw=
X-Google-Smtp-Source: AGHT+IGc1YzHqfYdRR9uhgBN2OoBbnXQycmTfwMRmP8IwV41H417MHKuatFoeJJZoaR9BfbN2KRtzQ==
X-Received: by 2002:a05:600c:1990:b0:43b:ccfe:eeee with SMTP id
 5b1f17b1804b1-43c601d95d8mr45357785e9.11.1741387191034; 
 Fri, 07 Mar 2025 14:39:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da473sm64093895e9.18.2025.03.07.14.39.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 14:39:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] hw/virtio: Build virtio-mem.c once
Date: Fri,  7 Mar 2025 23:39:42 +0100
Message-ID: <20250307223949.54040-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Missing review: #5 (reworked, R-b tags dropped)

Since v1:
- Use max extent size of all archs (David)

Replace compile-time checks by runtime ones:
- CONFIG_DEVICES::CONFIG_ACPI -> acpi_builtin()
- TARGET_FOO || TARGET_BAR -> qemu_arch_available(FOO|BAR)

Philippe Mathieu-Daudé (7):
  system: Replace arch_type global by qemu_arch_available() helper
  hw/acpi: Introduce acpi_builtin() helper
  hw/i386/fw_cfg: Check ACPI availability with acpi_builtin()
  hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT to runtime
  hw/virtio/virtio-mem: Convert VIRTIO_MEM_HAS_LEGACY_GUESTS to runtime
  hw/virtio: Compile virtio-mem.c once

 include/hw/acpi/acpi.h     |  3 ++
 include/system/arch_init.h |  2 +-
 hw/acpi/acpi-stub.c        |  5 ++
 hw/acpi/core.c             |  5 ++
 hw/i386/fw_cfg.c           |  8 ++--
 hw/scsi/scsi-disk.c        |  2 +-
 hw/virtio/virtio-mem.c     | 96 +++++++++++++++++++++-----------------
 system/arch_init.c         |  5 +-
 system/qdev-monitor.c      |  4 +-
 system/vl.c                |  6 +--
 hw/virtio/meson.build      |  2 +-
 11 files changed, 83 insertions(+), 55 deletions(-)

-- 
2.47.1


