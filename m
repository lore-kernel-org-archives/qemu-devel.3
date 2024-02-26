Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA9EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reeAS-0005wM-0Q; Mon, 26 Feb 2024 11:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAP-0005w5-M5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reeAI-0006C9-SO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:49:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d38c9ca5bso1756817f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708966156; x=1709570956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9RSIg5MfPMyLdHeCWQZgIMl/x6MtwhIPf52e94miu3U=;
 b=qmjhs4pMZjhyaN+ZKc4gpbrGRC4LE1XBdZDiZbPyZaGLD/783CoclyrfbNVtFVLZa7
 XouZbuvHlO9CLBdG+wvwtDP6eQve78ca5m0p5isX9/rdFDlpZrWFwQDWHVQ4ygPqW4Il
 tuT5fIxvfJAMAzY473pEeAH9iy+I+o3Wn8Yk91lVhjf8tM6gejYWfyeMykJ106f1tYhu
 vyJcSQwZcvOiEPeby2hMWhV3GMauKDoIKtoWu/4PUXf/3cUN72bvEv3us0bunsXLpICO
 W+X4QGfkLuz8onQa6DRPGZLpkBq49KbjeVr86tJNbfBnQtLHA7tvuy+8HAZ64c11oVDz
 HmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708966156; x=1709570956;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9RSIg5MfPMyLdHeCWQZgIMl/x6MtwhIPf52e94miu3U=;
 b=OjRPrl+CYlKU8x2dAB45FURzql9qpRYsSLn1TYDY/H6o5abEZZY223jYImwoj1Fu02
 jiLcJSsvLSI+wDuhUJY6JC8X5vA+46quWv824T7f8OajA7UCmBOQb+swOsBmrIz1MCBc
 VMLpEeo0eUuODzvaz2tmi6zAe2W/rh8hxvSXXv39in37W7fIYruxjgceHTlifwqQmAFp
 LIPKXjYdN24MeFP7Tw85zXqQXD5J5+OvlzwXu162sygeSlTGG3oolcm7YeWNYfi4K5Nd
 JwDWBf00tyhj8JZjaJrohUkftKLaBXlOmFtQUcv/sVd29DiEYKb6GxiD+1UoISrfNt3m
 XmIg==
X-Gm-Message-State: AOJu0YzeM/MavgB6Gh/ZYALyPW+PZON7ihvfZUSFs5uD3odeMGbYXGgu
 LiqC8RnNhZm8fcjUBuNpJvFKfPRMLqKaQtm5KMoThlDdGQt/MO9Q2J6AqncmdOVOG5SJEagcasY
 o
X-Google-Smtp-Source: AGHT+IGQPxGspqwWDNWnLNKTgCtZhcT2Ctl+CLeH1jYm6cClbKckED5VPav9F4necSdLl5soIIxwVw==
X-Received: by 2002:a5d:4a06:0:b0:33d:3ff4:60b8 with SMTP id
 m6-20020a5d4a06000000b0033d3ff460b8mr6330135wrq.18.1708966156580; 
 Mon, 26 Feb 2024 08:49:16 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 m17-20020adff391000000b0033da1c4c29csm8766052wro.91.2024.02.26.08.49.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 08:49:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 0/5] hw/i386/q35: Decouple virtual SMI# lines and wire
 them to ICH9 chipset
Date: Mon, 26 Feb 2024 17:49:07 +0100
Message-ID: <20240226164913.94077-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

This is an experimental series to reduce calls to the
cpu_interrupt() API from generic HW/. I'm trying to use
the ICH9 chipset from a non-x86 machine. Without this
experiment, we can not because cpu_interrupt() is target
specific. Here the interrupt is decoupled using the QDev
GPIO API. Even if the SMI# line is left unconnected, the
device is still usable by a guest.

Based-on: <20240226111416.39217-1-philmd@linaro.org>

Philippe Mathieu-Daudé (5):
  target/i386/cpu: Expose SMI# IRQ line via QDev
  hw/i386/piix: Set CPU SMI# interrupt using QDev GPIO API
  hw/ahci/ich9_tco: Set CPU SMI# interrupt using QDev GPIO API
  hw/i386/q35: Wire virtual SMI# lines to ICH9 chipset
  hw/isa: Build ich9_lpc.c once

 include/hw/acpi/ich9.h        |  1 +
 include/hw/acpi/ich9_tco.h    |  4 ++--
 include/hw/i386/pc.h          |  2 --
 include/hw/isa/ich9_lpc.h     | 12 ++++++++++++
 include/hw/southbridge/ich9.h |  1 +
 target/i386/cpu-internal.h    |  1 +
 hw/acpi/ich9.c                |  3 ++-
 hw/acpi/ich9_tco.c            | 13 ++++++++++---
 hw/i386/pc.c                  |  9 ---------
 hw/i386/pc_piix.c             |  4 ++--
 hw/i386/pc_q35.c              | 26 ++++++++++++++++++++++++++
 hw/isa/ich9_lpc.c             | 15 ++++-----------
 hw/southbridge/ich9.c         |  1 +
 target/i386/cpu-sysemu.c      | 11 +++++++++++
 target/i386/cpu.c             |  2 ++
 hw/isa/meson.build            |  3 +--
 16 files changed, 76 insertions(+), 32 deletions(-)

-- 
2.41.0


