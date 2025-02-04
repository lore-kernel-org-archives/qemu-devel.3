Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3297C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNfk-0000MY-TO; Tue, 04 Feb 2025 13:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNfh-0000Kg-Bg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:29:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNfc-0004ms-IK
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:29:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43626213fffso305565e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738693746; x=1739298546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ykqranp7X4nBDBQjg4lR9yhZHLNN6ITQwGAO0yzpXkM=;
 b=K/ly31RNmCq4PH2GUmW0rKwKND5khicvbw1lfL2gi5NeN6M/6CHz7hauwqZ7+a7/Ae
 hWUS6t8VTS3HtaddpC1+J8Pf3UuASyMj+KqtkZGdTk4FwR+W4wIJfX4w811mI6uh6KqK
 +6rk6AgsuHV2oCbC+9yVHDJ0QlmgDLXdfWNzP/uRvlw5fdc9hirWecCmX8rb6eM3EEEf
 81QpgYZfx2me+znEVIeI88Tc/vdGh0RkWGlYmd25BorrQu+s3SudkxGytHlUa8B4eokS
 t5qkBDNLilaeF6JK2jcL5vxOfx24EOL2VaDQVzTmsPPtrmzClBh+rrfty5fQFAknZTgu
 yLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738693746; x=1739298546;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ykqranp7X4nBDBQjg4lR9yhZHLNN6ITQwGAO0yzpXkM=;
 b=C3oU0TuMi52QKZ6Q2E5ofwG1THYV5ed3/MuqE+brqqZTyMOTNbn0ZvTSmYj3NHnQmB
 GvXQbrQDivQqLZyEtvntfCISXZ+2N9fyqboyMHY14rdErh4ofcVYm0PK/SYwGOV5/TCd
 Ha0l5LuvdqHWy/dSralds0abvCIbF9YWGlpJ1U2UE4W6Z5KPxAt5LYQPRTvBiKrq6PYH
 ssOdAWZGJYj8Tg+mkuYbrL0UzKqdsjgacj5FncgK9SZkDEibcloEamz0WqAHxajemZFw
 7sUGP+KNT9Y+8LvDpTU0+060LoZuddjHI8rEbiQ4K0xN7wXuizWA7Uy8v3j0RRR54w3B
 KFCQ==
X-Gm-Message-State: AOJu0YxU0NAjq82Rc4UOKcoWs3wEwNSLNhMmhw0cp8ib/uMq271iniUS
 aRXF6hK61tJeUJCot1cpjyD2cijZu6seYnFRnMXAhUlv1Ip8FSs3Ly1vdvnfZQHvwKIeD6ABqcI
 emgU=
X-Gm-Gg: ASbGnctqHoHlaYaHGd0hgLQQtFE5p+e45kMHYAOtRILkAEEokwUo0I6jU1vb0hb9Fsg
 pH1dSjvlEiVoNfz8eeFD5gtYJftJJm+1YLHAMxYJYpv3Yrst4ygYXjsG41qEaXzrY+HUTLsweMj
 nHxsGL5En9zWf36GC9IV7M/SiW/xwByqiXczDLp4885RuX1nO69iP/bpDMZ7vP5kpnnr5mQ66+R
 FYteUxlDCF8P6nXI1i6zv3e7eZ5x9+b6/2i5BhKwVk59Xb91Yd2wHACAXyDc1cmJXhbePmlReR8
 3rTAi+Y8ZrDGZUfDbnkXhbgd9CruRhjeOkicUR1B31eUrpqdrqeCjsffVZvE6t44BA==
X-Google-Smtp-Source: AGHT+IGZ1wh5KslGHvIjxLM9k0hAjqp9q/rO4iR3ggiJcVyrHvZw5p6VEgicX0iRunjxZNGww74cdQ==
X-Received: by 2002:a05:600c:1784:b0:436:1af3:5b13 with SMTP id
 5b1f17b1804b1-43905f99943mr34458085e9.15.1738693745465; 
 Tue, 04 Feb 2025 10:29:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc26d6fsm231220125e9.14.2025.02.04.10.29.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 10:29:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/7] hw/boards: Try to make sense of
 MachineClass::no_sdcard flag
Date: Tue,  4 Feb 2025 19:28:56 +0100
Message-ID: <20250204182903.59200-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Invert MachineClass 'no_sdcard' flag logic and rename it
to 'create_default_sdcard_drive' to make sense of this
default value applied to all machines.
We use the OnOffAuto tri-state to catch implicit default
values. Then we toggle the logic and remove invalid uses.
No logical change intended (except the assertion added).

Since v2:
- Fixed mis-rebase catched by Thomas

Philippe Mathieu-Daudé (7):
  hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
  hw/boards: Explicit no_sdcard=false as ON_OFF_AUTO_OFF
  hw/boards: Rename no_sdcard -> auto_create_sdcard
  hw/boards: Remove all invalid uses of auto_create_sdcard=true
  hw/arm: Remove all invalid uses of auto_create_sdcard=true
  hw/riscv: Remove all invalid uses of auto_create_sdcard=true
  hw/boards: Ensure machine setting auto_create_sdcard expose a SD Bus

 include/hw/boards.h        |  2 +-
 hw/arm/cubieboard.c        |  1 +
 hw/arm/integratorcp.c      |  1 +
 hw/arm/mcimx7d-sabre.c     |  2 ++
 hw/arm/npcm7xx_boards.c    |  5 +++++
 hw/arm/omap_sx1.c          |  2 ++
 hw/arm/orangepi.c          |  1 +
 hw/arm/realview.c          |  4 ++++
 hw/arm/stellaris.c         |  1 +
 hw/arm/vexpress.c          |  2 ++
 hw/arm/xilinx_zynq.c       |  1 -
 hw/core/null-machine.c     |  1 -
 hw/riscv/microchip_pfsoc.c |  1 +
 hw/riscv/sifive_u.c        |  1 +
 hw/s390x/s390-virtio-ccw.c |  1 -
 system/vl.c                | 16 ++++++++++++----
 16 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.47.1


