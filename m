Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00790C35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 06:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvVo2-0007xa-Qn; Fri, 21 Mar 2025 02:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVo1-0007wy-1H; Fri, 21 Mar 2025 02:24:33 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvVnz-0002yB-2s; Fri, 21 Mar 2025 02:24:32 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22622ddcc35so2439415ad.2; 
 Thu, 20 Mar 2025 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742538268; x=1743143068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PlARjNE1CUXCKD/qD10aXpmRUq70iN0LAmQNZZygo2Q=;
 b=hbKb6jmPi3ay9bnMXkjcUOgGFx7wWXB9XBXeu5pHQOdn4LQlZUpmSLZNulxUm/IKlA
 79nV8kazj97D1ppNfGmnOiAIt6HrmkvHiZ8gHsOXGGf/4vo+nTC+PfNxYstpAWOGQog9
 tlLyVoAhl/W7sZgRQTazWLqtAjy8IWbFOKR0DQGuHykCy0wmFFnCSt+GW4bvpOJBoH4g
 awhauc7qVW+58reqhAYJh3YzM9AeObRevoDAHdt17gDWhq12fhmmZHquIbeoW6pnsQfT
 WfQYLaB5jfebgiZwaaidrqvEWyuv6siY+MyTeS0x76Z/ERT5Qb1c7rZQv+iNhPvUToz7
 /Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742538268; x=1743143068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlARjNE1CUXCKD/qD10aXpmRUq70iN0LAmQNZZygo2Q=;
 b=oNVC44Z7sIKHfQyjbrkJKNwGk3mnmEE4I92M17+fW0aJwSx3Jrwneww/zKdYPGcZpS
 vh2zmN6cizCmfTYk2SAZSjEYvRJiZPZLrKEnbouSCuYsF94Bd1HfxJ8yqQVqAjHjp7i7
 i5PzKT3gILju2XDV9UhhVqFlNZf53r86ZgOB0CwgYnAEczRlIwKMfAK5cDeJSqcUBTC6
 s5Fhf+X/4CZ7XMynlioaMekEzP83AMxpkBu0UZoEl32D6MhD9RjLsAaBzwSi3oQeQ/0Z
 2AIQIu1NDD1k4XDslmtgTdg6uckSjgnFzyv8Od0jNouyEMvvS3fPfCpQ6zDkTqz5g69Q
 Rt9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlKI7yRK+T1egVM1dPd3fk7AnVvJZY8TM5/8cSnXx5fC/R022q+votdBNMaPMv603yWDgiupTc/Q==@nongnu.org
X-Gm-Message-State: AOJu0YxZUmGju4wJs9gfKjr2NBfafYS0TtM2G/vEUSX3TnsR1vt9yJjD
 WSo4nfI0hXTl4dB4vRwIngQQW52bA2/x8eRitrAEqHDLQBBUivsxoQrhuw==
X-Gm-Gg: ASbGnctLrEaJ8u5bsf6S228qwTG7Lf9oEdr0tvNB+dJeMUUhL0RgGpGbIoRUFlzivfO
 oA2PVpr7JzxtDu9fFNHHQgQlwnWzVm31xU18fUhUKI19Ga5Vmy1dRM0R2o4A10Ik9gLJw+7hu3+
 i7gM9pkmXRWe34EFu/VcSjz/muHKdjS0nbomQ4XmGwpJ/No2o1FoPB579+rEYTFfVJhupq8BKGS
 +XShWzEjpheDVXP8j53RUJiGpMLCQRqpINloJ5Dwqn5Nc4UklcjhVGPt1TeJO9HhnQf7pxUhAMP
 mNExCsGjrmLy2cHQ96jsok6HVhwFRjm5tePK1NgL7TtwCmB9DQ==
X-Google-Smtp-Source: AGHT+IExyoG2M5z8+vDwolUUOXzxL9Ijy7raNBIIXh1FeDwqQ6NBiG8pZF484bYJ73Q+IQJTA7340g==
X-Received: by 2002:a05:6a21:900a:b0:1f5:6680:82b6 with SMTP id
 adf61e73a8af0-1fe43437130mr4383682637.38.1742538268393; 
 Thu, 20 Mar 2025 23:24:28 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4761fsm941381a12.65.2025.03.20.23.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 23:24:27 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 00/12] ppc-for-10.0-2 queue
Date: Fri, 21 Mar 2025 16:24:04 +1000
Message-ID: <20250321062421.116129-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

The following changes since commit 1dae461a913f9da88df05de6e2020d3134356f2e:

  Update version for v10.0.0-rc0 release (2025-03-18 10:18:14 -0400)

are available in the Git repository at:

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-10.0-2-20250321

for you to fetch changes up to 73c0c904fc99e2ceecbbded84ec76d40d3f2daae:

  target/ppc: Fix e200 duplicate SPRs (2025-03-21 13:54:36 +1000)

----------------------------------------------------------------
* Fix a KVM SMP guest hang. This is not completely trivial, but just
  small enough to merge it. If this causes any more problems, we can
  revert it and the timebase patch which exposed the underlying issue
  for release.
* Fix a bunch of Coverity issues reported introduced in ppc, mostly in
  powernv code.
* Fix a NetBSD boot bug on mac99 caused by VSX/VMX decodetree rewrite.
* Fix the default CPU selection for older spapr machines.

----------------------------------------------------------------
BALATON Zoltan (2):
      ppc/amigaone: Check blk_pwrite return value
      ppc/amigaone: Constify default_env

Harsh Prateek Bora (1):
      ppc/spapr: fix default cpu for pre-9.0 machines.

Nicholas Piggin (9):
      ppc/spapr: Fix RTAS stopped state
      ppc/xive: Fix typo in crowd block level calculation
      pnv/xive: Fix possible undefined shift error in group size calculation
      ppc/xive2: Fix logical / bitwise comparison typo
      ppc/spapr: Fix possible pa_features memory overflow
      ppc/pnv: Move the PNOR LPC address into struct PnvPnor
      ppc/pnv: Fix system symbols in HOMER structure definitions
      target/ppc: Fix facility interrupt checks for VSX
      target/ppc: Fix e200 duplicate SPRs

 hw/intc/xive.c                      |  29 +++++-
 hw/intc/xive2.c                     |  21 ++--
 hw/ppc/amigaone.c                   |  16 +--
 hw/ppc/pnv.c                        |   2 +-
 hw/ppc/pnv_bmc.c                    |   4 +-
 hw/ppc/pnv_core.c                   |   6 +-
 hw/ppc/pnv_occ.c                    | 201 +++++++++++++++++-------------------
 hw/ppc/pnv_pnor.c                   |   2 +
 hw/ppc/spapr.c                      |   2 +
 hw/ppc/spapr_cpu_core.c             |   6 ++
 hw/ppc/spapr_rtas.c                 |   5 +-
 include/hw/ppc/pnv_pnor.h           |   1 +
 target/ppc/cpu.h                    |  11 ++
 target/ppc/cpu_init.c               |   8 --
 target/ppc/excp_helper.c            |   4 +
 target/ppc/translate/vmx-impl.c.inc |   2 +-
 target/ppc/translate/vsx-impl.c.inc |  20 ++--
 17 files changed, 194 insertions(+), 146 deletions(-)

