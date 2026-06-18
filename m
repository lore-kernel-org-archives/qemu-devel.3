Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E518CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waIsn-0000SV-3c; Thu, 18 Jun 2026 15:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIsl-0000S5-M9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:58:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waIsj-0000Lz-AX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:58:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2c6ec0af575so8277475ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781812712; x=1782417512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=rLgx65tFsFfblyNJf9+3CEqUiej5TmumNRZKANQrI48=;
 b=CKVZZJTAizIwVe71P0K9Q0cO+UvM8p+b/deCIRYmPmYQdKYo1nxaj+ExNh9jERapZI
 aTxKi0id46WRqaT1qWYVqwGLL+NItAHfC9+ONxc6SdB3KWIY6wZIxhDwqR9ybs3bnqz1
 8QSn/wwB6e/hMLIvdv7yhAy7SUIFjTWC5VBM+4mszPynQpL1sxl/akXbqbaeghFDH5O0
 PE3aaHr98XVXRUtN/j/vffWlrOK8zZeVVOREi0VMUwyRPsPpMmrYdafi77o5ky8L325p
 +p8IWzwxON1hlGW1hoQja0T/vjKeVpemlCC56YI1xQfIKRmEQ8/1JOV3Ui0fyHiFlsAU
 lvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781812712; x=1782417512;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rLgx65tFsFfblyNJf9+3CEqUiej5TmumNRZKANQrI48=;
 b=gk/sIBs9c53pYR+54SXpFYyt623hNW2oWiWZpeB1ZFeTONHKFLvwjvX7wdx5PyFa/7
 0JTJXfsrW4D2TDAHxnp+ca+kQFznpcORl1wSJXQ+OSOqo6sC11Q2Gpk1X9tLsrEykKkL
 BXhw7jIBjTDiM8padw8toZaBByZjBZqLXXaqPPNQwBEq6KduL24y97MxXEf8IXE72fCh
 b41djigHNGZM5R8Y7abwjxTxBj+cQ/bdcXnFy6Y5/FsABucEBUQUvEOXujIXbyt7605o
 XdvyL0iBmEl62s/rOUwc7X9sAGqNhqB3Ddn6oNVWB+1K/imQFJ5v3NAvJnoVYCX+wdGP
 isyA==
X-Gm-Message-State: AOJu0YziR2L+ijfWQXXER5bTwKawA5YNozUToCtbZfJn+aDZKZOVqYJx
 p7a+Xpm2R5yUOXpzUyBQtnECHnZhltshv+usgMkFW6ToP+TTSdHgk18jEXMtctSIOp5nnTQzFIa
 rDsyG
X-Gm-Gg: AfdE7clL/XDa+tQH1cHR6zFcwCDMpC62p+tpzVioSvKV/AwM1gEY86JQekdJImCpoJ7
 +obgWIbVF8Fm1vY6wlxuphDlVSQ7w2hrR9P3xXEXSBc5nXLqJwYRt23b2P7VpDxb/gKTVXhYY6m
 ZGsnmTMuuv/XOO+NJhiXbqrKGTS7BXDsCxfeWxu20/HWIzEvChJn8d7c5Rfhu+/yzunU30gE7UB
 EZW9Oi8AhtDR/9VH6gym2JGOZ34PQRw1H64MbrD6z8YLlHTclxDdrFRspXR+/vReqPudgyWtGo9
 ZpH61iAc10xvh/jIZye0HmBtb1x7VZiNoY4CWMwp2sHb+LQkbR4+ibiRA6MadiFBOoxGa3sSJQ3
 DAqH+St7TkgOX2LqgGDAkGFfA/Vdwea4eA5UpSHiRxSpi38CVD1OeWb96ltOqn9gzh96cP5Py9U
 I1ap/8k5cYV+GfYTewF8aiCsUl4HdK/svKTHgJUIKSlm4wWZCHDnR2llXvPHOJ
X-Received: by 2002:a17:902:d489:b0:2be:22cc:e227 with SMTP id
 d9443c01a7336-2c718c87b90mr8232025ad.4.1781812711691; 
 Thu, 18 Jun 2026 12:58:31 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8ca31sm205776395ad.55.2026.06.18.12.58.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 12:58:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/13] *-user: probe_guest_base improvments
Date: Thu, 18 Jun 2026 12:58:28 -0700
Message-ID: <20260618195829.590072-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

OMG.

Changes for v4:
  - Really, really include the read_self_maps rewrite from Warner.

Only sending patch 10 this time.  :-(

r~


Richard Henderson (13):
  linux-user: Introduce PGBRange
  linux-user: Use PGBRange in load_elf_image
  linux-user: Drop hiaddr out-of-range check in probe_guest_base
  linux-user: Pass image_range to probe_guest_base
  linux-user: Use PGBRange for commpage
  common-user: Move mmap_min_addr from linux-user
  common-user: Initialize mmap_min_addr for FreeBSD
  include/user/guest-host: Include missing cpu.h
  common-user: Move selfmap from util
  common-user: Implement read_self_maps for FreeBSD
  common-user: Move probe_guest_base from linux-user
  bsd-user: Use probe_guest_base
  common-user: Move guest_base, have_guest_base to probe-guest-base.c

 include/user/guest-host.h        |   1 +
 include/user/mmap-min-addr.h     |  12 +
 include/user/probe-guest-base.h  |  37 +++
 include/{qemu => user}/selfmap.h |   0
 linux-user/arm/target_elf.h      |   2 +-
 linux-user/hppa/target_elf.h     |   2 +-
 linux-user/user-internals.h      |  17 +-
 bsd-user/elfload.c               |  37 +--
 bsd-user/main.c                  |  42 +---
 common-user/mmap-min-addr.c      |  50 ++++
 common-user/probe-guest-base.c   | 347 +++++++++++++++++++++++++++
 {util => common-user}/selfmap.c  |  49 +++-
 linux-user/arm/elfload.c         |   2 +-
 linux-user/elfload.c             | 400 ++-----------------------------
 linux-user/flatload.c            |   3 +-
 linux-user/hppa/elfload.c        |   4 +-
 linux-user/main.c                |  35 +--
 linux-user/mmap.c                |   1 +
 linux-user/syscall.c             |   2 +-
 common-user/meson.build          |   3 +
 util/meson.build                 |   4 -
 21 files changed, 564 insertions(+), 486 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 include/user/probe-guest-base.h
 rename include/{qemu => user}/selfmap.h (100%)
 create mode 100644 common-user/mmap-min-addr.c
 create mode 100644 common-user/probe-guest-base.c
 rename {util => common-user}/selfmap.c (68%)

-- 
2.43.0


