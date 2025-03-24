Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F97C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewM-0002jg-B6; Mon, 24 Mar 2025 06:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewH-0002hd-Ha
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:49 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewE-0006yI-6o
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:48 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so746914966b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811704; x=1743416504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yu8RlLKAJY774dQq/0UwJZZsh2CwMTMr9ikfsbGGuSA=;
 b=f2rMd78vq/SngrpuuUun7pwqGDClkKbDfLE7nYgsV5GceFhn6JqOr2OncW2Fc8WnYk
 KMWVapKdTdd8L/03Qc5Q8Ifm1VPi0jVS43t4lu33G5AyOEHEwPmZ6F2WneshtLcilTPj
 hGdmrpk24jFlQmdGSQL1rpWwxWLPTWeUnLU3QRfEQqjJEcF16ZsBAc7pxjX/4IxdV8/Y
 dK/2utVxFVuwWAR4pP8wSCYNVna4NIk8AZvpVCqGdPv55LRzXhCGk09rkdp7fsHl1ehb
 wYR7ZeLzUTGUVTcE74NkQobtFMxpsbD7iMZphYspjh/qZf+DMYoPcPu0nkz89IFpe6ic
 GwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811704; x=1743416504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yu8RlLKAJY774dQq/0UwJZZsh2CwMTMr9ikfsbGGuSA=;
 b=ZxLYWF+Ma9YlhTc0ZR0EUqXLOPlNbzBOoNRqjeNUa0B5iGHcz+iTabkZJZRcDJqJdP
 YwAMS1bgOcvyWW9rH1k9o7wnyVihu+2RD+xwHaA9bP3eFPhsPch3qNTSCYZr7nE31Hl9
 xa6VAo8rQB0j6Jegc1ZRHdR7LBbXzzPP1lAzJgRPh3B+kZrqzLS/BN1PekUp/1mb/6Xi
 4rl19AS4TZHfNmH2SBWfmSfKDi6YVjCE8GRAAf6yEuaDusB1ckvMot6dhWKMG0npVPEp
 LSCXCb/2m7HAgxNXIr7KzZavj+ihaaR8rHRs7lxcKnxRoUgqhHKPKz/I2UUNFnEx6QJo
 QyUw==
X-Gm-Message-State: AOJu0YxA2RFdFlRxxw6OWAFrooLwdiUVGYBhvfiUOGtUqB0BG4V9NUGD
 /KdpWS3opiNsI8A1SvRq3X+hfEzhQgZYzSk26pv5gdcGSYvC3xFioprFfgVTajQ=
X-Gm-Gg: ASbGncuSGBckhZvIWI1mYxhun0gUqCri4lTCQxt5S3HI3guHQdLBsKPUie/Cp1RyDyp
 tBRLA0m1FJLEDVuqhK1/2VYi+GJQd8iXNzbIgJaW6xQZiKjHYhXWUgNPvXy1nOsNzXhQk4P+ELt
 542dUlGWsFTu8Jvv6cvzAIA3avz5zHcZQkvWATUVCmWm+qrEuJWTBZuRogLL+aBe5KzTjozURUo
 EX5fdbydLQK8lELCWFao903x+yX+teyhXafOTIxegoZPxGO8hpDypKwhDyaHl82ofGR87A7diav
 xNbblzTlvSHvwR7dSpCgjG8/msp7m2BU5SSjT322JdzRG7qCTKsXeJobbQ==
X-Google-Smtp-Source: AGHT+IEX8SGzROIudRzJshBqcN82NYLkpsCoaD/Yo/ftNW65T4eTY18sBup7fcabjuDKnu0zFZp1Zg==
X-Received: by 2002:a17:907:1b10:b0:ac3:c56c:26ca with SMTP id
 a640c23a62f3a-ac3f20f8556mr1332662766b.8.1742811703927; 
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3efbdfcc7sm654291866b.146.2025.03.24.03.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 95AEB5F8B9;
 Mon, 24 Mar 2025 10:21:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 00/11] gdbstub: conversion to runtime endianess helpers
Date: Mon, 24 Mar 2025 10:21:31 +0000
Message-Id: <20250324102142.67022-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

The aim of this work is to get rid of the endian aware helpers in
gdbstub/helpers.h which due to their use of tswap() mean target
gdbstubs need to be built multiple times. While this series doesn't
actually build each stub once it introduces a new helper -
gdb_get_register_value() which takes a MemOp which can describe the
current endian state of the system. This will be a lot easier to
dynamically feed from a helper function.

The most complex example is PPC which has a helper called
ppc_maybe_bswap_register() which was doing this.

This is still an RFC but I've spun out v2 for further discussion.

In v2:

  - drop uint8_t casting and use void as C intended ;-)
  - add specific 32/64 bit helpers with type checking an assertion
  - various tweaks and fixes (see individual commits)

There are a few other misc clean-ups I did on the way which might be
worth cherry picking for 10.0 but I'll leave that up to maintainers.

Alex Bennée (11):
  include/exec: fix assert in size_memop
  include/gdbstub: fix include guard in commands.h
  gdbstub: assert earlier in handle_read_all_regs
  gdbstub: introduce target independent gdb register helper
  target/arm: convert 32 bit gdbstub to new helpers
  target/arm: convert 64 bit gdbstub to new helpers
  target/ppc: expand comment on FP/VMX/VSX access functions
  target/ppc: make ppc_maybe_bswap_register static
  target/ppc: convert gdbstub to new helpers
  target/microblaze: convert gdbstub to new helper
  include/gdbstub: add note to helpers.h

 include/exec/memop.h        |   4 +-
 include/gdbstub/commands.h  |   2 +-
 include/gdbstub/helpers.h   |   4 +-
 include/gdbstub/registers.h |  55 ++++++++++
 target/ppc/cpu.h            |   8 +-
 gdbstub/gdbstub.c           |  25 ++++-
 target/arm/gdbstub.c        |  55 ++++++----
 target/arm/gdbstub64.c      |  53 ++++++----
 target/microblaze/gdbstub.c |  49 ++++-----
 target/ppc/gdbstub.c        | 197 ++++++++++++++++++++----------------
 10 files changed, 292 insertions(+), 160 deletions(-)
 create mode 100644 include/gdbstub/registers.h

-- 
2.39.5


