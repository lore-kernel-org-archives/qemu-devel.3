Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F57F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGsn-0000zD-Gs; Thu, 05 Mar 2026 17:09:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsl-0000z0-IG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:23 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsj-0002CW-Bk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4837907f535so77742145e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748559; x=1773353359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QqAbdk4Pe2MQVed+WtrEw6pFfWk8J389+1HbvVagQKg=;
 b=k6X2UDfG9nE/p6wAylwyXj+x7UKnyJVJHn/Agcg9ZhSUjGsGo0Ogy/YcN6Pdw1QTzj
 BwyHcryRrRQKcDO8ATz2IlZGY5ezb3QBmfK55cCypCnjXsfbZblqoew/MMeWKQAuCj75
 dyCZV+FHlq6qCoLKkLxKc0xt4wNk4ba0dcD0dIWGInAnCDTddBP4kmoiuhH0FCkjMEiZ
 kr3bJJgzCC8cK/Y4a6V59DyegF4xOwbf9X06UL2WMYSo+GCRgXk4ozid28rodvnK7QUQ
 gtBwVwi3fkkYFA/sWR21BQs/hG8Nds4unaRCqUnDa1wpXSbYTsgLbbH4IAMczcrqR1l/
 KPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748559; x=1773353359;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QqAbdk4Pe2MQVed+WtrEw6pFfWk8J389+1HbvVagQKg=;
 b=EZsDB/N8op8gmfbwKaIWYFVamWfUepjmXucGbzw5PxuzVJ0c4gRDpgQ+nFaU1QmWAj
 lfLyBTwd4sQa+9LgNlDZiAi+dNt5122OeVkao2sCuIp+0oqtngkgw8GvIZFcCoVBFpl1
 BLk0rtmn9MwtTYfebxBnHQbFeb8hPl+QnckICwroJc1UoXBOuhr5WU8A3H2zeFtkJNqV
 kT/H9TzEqg4BoQ0r5BbDCf/fQkHIG4uc0S4O6ijs6FKvlZHheKv9hgAiMwHSaC3v3GbM
 rFfuxwYG4EW3F/K7hyhCrhvIh3m3HhnX+tgYDDHpVcFvlKYTIfUoUz0C46Sombqehl5i
 9/Bw==
X-Gm-Message-State: AOJu0YxPZYXwX72vQb8oULJitYT8k6retbwPWrZQfMo172cHCbjT95wm
 N+fk7mD2oVGcdhpBRFLLJ+oruqwzWVojg2PpyexGSxtdnh1cWPc0ITXmbhZMig==
X-Gm-Gg: ATEYQzxDb3MseN+xTn9EcdkTbWaMut9prxWlGHNWrtxD3sqWScI6x1pluiMMfluKCed
 KHIRyQCT3c+/i6lY846N5Yc+4aeH/elQtOh1kHyrOh2LqXIXGotUjtZA4u4E6l9BxDeXOJWWOtc
 Of3e4FeTRgd3yRC2jJd0hh7GdggZ7pGdBEtf21prwA2f5VEqlz+EKN9penHqsP43JqdPNqHyHjP
 8iHvJhFR82OyCcMZv7huWbfTHssacQ/wdXf8ZCyR7OVD2yTuE/bNgun+IYLmYB0UMo/eANjA1Ql
 CugTZiQSR1kGSiVXLSSxuJBBr88IjK+MbbCkcatgT8m6Qr2RZiXZnxONtponWsou2n8EADKamrF
 XjNzSUbaRf36WUkk9RjE8kxdygdQuGgyW17xkubJEYK23pP5M5vS5XAxjH7qmam+CZ7OWfMrMsR
 emCPcMnzsOAsfxkNq4A5HRiEMaDlSuymt2qKehuIVCk1fRPHOyV9lircdnDLn+CP5ItF0R5i8kW
 7p0dgcyW1yFutlII7hEvoLMnNU+va04EipoaqKBNdsu+NQ=
X-Received: by 2002:a05:600c:1c18:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-48519871aa4mr147654815e9.16.1772748559328; 
 Thu, 05 Mar 2026 14:09:19 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:18 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 00/14] TYPE_SERIAL cleanup
Date: Thu,  5 Mar 2026 23:08:57 +0100
Message-ID: <20260305220911.131508-1-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series consists of cosmetic changes around TYPE_SERIAL. The biggest change
is having it derive from TYPE_SYS_BUS_DEVICE which 1) eliminates usage of
qemu_{un,}register_reset() and 2) stops all its users from accessing private
data. The latter allows TYPE_SERIAL to be ported to Rust in the (near) future.

v3:
* Pick up further R-b tags. Thanks!
* Add patch "hw/char/{diva-gsp,serial-pci-multi}: Fix deinitialization order"
  (Peter)
* Justify switching to serial_io_ops in certain cases in TYPE_SERIAL_MM (Peter)

v2:
* Pick up R-b tags. Thanks!
* Ad patch to free consumers of TYPE_SERIAL from setting up MemoryRegionOps;
  configure via properties instead which should resolve odd code (Peter)
* Improve wording in one commit message (Peter)
* Sort patches by moving char/serial last
-> Keep "Avoid implicit conversion when tracing" untouched for now. Can be
  omitted if deemed inappropriate.

Testing done:
* Boot mpc8544ds machine with Linux and interact with it on the serial console
* Boot q35 machine with Arch Linux and interact with it on the serial console
* Make check
* Make check-functional with all architectures enabled:
    Summary of Failures:

    238/313 func-thorough+func-aarch64-thorough+thorough - qemu:func-aarch64-tcg_plugins          ERROR             0.72s   exit status 1
    309/313 func-thorough+func-x86_64-thorough+thorough - qemu:func-x86_64-vhost_user_bridge      TIMEOUT          90.01s   killed by signal 15 SIGTERM
    311/313 func-thorough+func-x86_64-thorough+thorough - qemu:func-x86_64-rebuild_vmfd           ERROR            33.64s   exit status 1

    Ok:                257
    Fail:              2
    Skipped:           53
    Timeout:           1

Bernhard Beschow (14):
  hw/arm/Kconfig: Fix serial selection for NPCM8XX
  hw/char/{diva-gsp,serial-pci-multi}: Fix deinitialization order
  hw/arm/aspeed_ast27x0-{ssp, tsp}: Do not access SerialMM internals
    directly
  util/fifo8: Make all read-only methods const-correct
  hw/char/serial: Remove explicit cast from void pointer
  hw/char/serial: Prefer fifo8 methods over open-coding
  hw/char/serial: Reuse fifo8_num_used()
  hw/char/serial: Remove unhelpful comment
  hw/char/serial: Add constants for Line Control Register
  hw/char/serial: Remove redundant reset
  hw/char/serial: Avoid implicit conversion when tracing
  hw/char/serial: Keep MemoryRegionOps private
  hw/char/serial: Inherit from SysBusDevice
  hw/char/serial: Plug into reset framework

 include/hw/char/serial-mm.h |   3 -
 include/hw/char/serial.h    |   8 ++-
 include/qemu/fifo8.h        |  10 +--
 hw/arm/aspeed_ast27x0-ssp.c |   7 +-
 hw/arm/aspeed_ast27x0-tsp.c |   7 +-
 hw/char/diva-gsp.c          |  23 +++---
 hw/char/serial-isa.c        |  17 +++--
 hw/char/serial-mm.c         |  59 ++--------------
 hw/char/serial-pci-multi.c  |  23 +++---
 hw/char/serial-pci.c        |  11 ++-
 hw/char/serial.c            | 137 +++++++++++++++++++++++++-----------
 util/fifo8.c                |  10 +--
 hw/arm/Kconfig              |   2 +-
 hw/char/trace-events        |   4 +-
 14 files changed, 157 insertions(+), 164 deletions(-)

-- 
2.53.0


