Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5815CCD6E56
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzJ-0005cL-41; Sat, 30 May 2026 17:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzF-0005bl-Jw
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:54 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzE-0000cI-2t
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:12:53 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2be1dd4af34so136044835ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175570; x=1780780370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6RLzEuP5bUGBbtsPN0FK9HcRpDNGWigdcGp5nroe/QI=;
 b=Rq407euTOyxt2tLA9Zl+An4JuqLpZKmYH3jf3bauuwRAF3+Mt61yNYqsfZQBRr2psJ
 u56Vh/StdhIVahF/oauSftS+2ix2rvWFCljO+VGWR9cjG4UJUNPhGlnTt8F6Bfviuu6L
 Cm8KxYeOTizHODAyTfbIkHZtpHw7y4Kx8U0z4dampw00m1IiJ8jBO8wEYfH6lONcbkRP
 ZyGmi0BJ2kMzgCx8wam608lBvbsjyobrFWEbSQYKfSka3l0K2UoaHlEeSj6On+tMoaAk
 RmT0097Ljv3CRlCyjATc9ooUdbud4L4lVO6Cs2mm21+H/UHbx10dagmxZonUBn2iHB+K
 HC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175570; x=1780780370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6RLzEuP5bUGBbtsPN0FK9HcRpDNGWigdcGp5nroe/QI=;
 b=IQJ0mMdKF9p1vAQYd0JKqDWhoFBp8xlP8lGgMgsqOsiY7q/TP1MFLeCdaIwpTProyV
 vBP2QFK3EH2SDkTFWGE8o+kaSr89Q+Fes8xLjrPr/tzARth4TyZGbpetHaZdtYKGCrGa
 ewQ74CcBQIeuIzTbc/+Yz33nPWK2TRxItjL1sA2UgJIjmdklEgS3vjfQfIW0liXgnkpo
 sj9PBT+Hx1yBopJ6KDeMxPf+W9CSs9oGSXvoNDmkz4nQ7v7Iqh97hCBs1hvzErmbNvii
 8xU4HbyrTo6R0nmi/qUo1Mx/0VO/oOUeFCf4C/NA16TD6+PNoBAyjTKggIbO4znNiXOC
 yhBg==
X-Gm-Message-State: AOJu0YwMSzxVXhduWbLuWjFWnNprY0PXurfX27JboC/7jOVO4vwMp2EC
 HfGBuG63IXqpcXG0Nb9P5OThaU8ecFJmcjwoet/HV1hTIBdulgoLT87nDuu3KlfRZF41DOCz3oc
 j8xMAQNw=
X-Gm-Gg: Acq92OEO5fbNSFf8hbdVyfDdR/LRdGk4i1y7bG+l7Lf4iOP8mETFFh+zY7CuLF75GKn
 zAfZMUbQOha3AUYiZvLQEBHK/SlNdmBEaZaQDNDCDSKrcyAglhrs2sOQkmkinWDQGfSaSafQV0O
 7LVS/5s40A9yqpkjg75t3sZqeI1RmogFvQ7hMlFA5mwxSIht6C2nx0sccpXGxh3C3TNSnB9JDMK
 vRHIfcBeKfsdxI7UKR303WeLmsD8UJYfWitqz+VtHEo6s3ujBX7V/i1vkP/vv2jpiPG/3IUVhiD
 JkkO89q2E5FIWIthPSRFXcQSizWKzZkgLmB933hFJ6+GRw6/8DL4uu5h2ZAnBg8FRY25lIqr/0u
 QJ38XRwbf7qxBOoVnCK40ybfMmjrvlPz3v0z1OTXRmqBEwmnmuNf5xSoMHc4U5/jjO7AnNGZ0fw
 yFEezpe34fqS50haL562QYOQFjANGYCtxypfN85M9m4mn/YT+hsw==
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id
 d9443c01a7336-2bf36803dccmr63627485ad.24.1780175569649; 
 Sat, 30 May 2026 14:12:49 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 00/13] *-user: probe_guest_base improvments
Date: Sat, 30 May 2026 14:12:34 -0700
Message-ID: <20260530211248.375318-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

The first 4 patches fix the ambiguous guest_lobase parameter,
which affects an odd usage of a bare metal image with qemu-arm.

The rest of the patches improve bsd-user to use probe_guest_base.

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
 {util => common-user}/selfmap.c  |  45 +++-
 linux-user/arm/elfload.c         |   2 +-
 linux-user/elfload.c             | 400 ++-----------------------------
 linux-user/flatload.c            |   3 +-
 linux-user/hppa/elfload.c        |   4 +-
 linux-user/main.c                |  35 +--
 linux-user/mmap.c                |   1 +
 linux-user/syscall.c             |   2 +-
 common-user/meson.build          |   8 +
 util/meson.build                 |   4 -
 21 files changed, 565 insertions(+), 486 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 include/user/probe-guest-base.h
 rename include/{qemu => user}/selfmap.h (100%)
 create mode 100644 common-user/mmap-min-addr.c
 create mode 100644 common-user/probe-guest-base.c
 rename {util => common-user}/selfmap.c (69%)

-- 
2.43.0


