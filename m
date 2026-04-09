Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30A3F31E25
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 14:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAqGO-0002rb-LI; Thu, 09 Apr 2026 10:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGM-0002r7-Mb
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAqGL-00033m-2n
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 10:21:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso10402755e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775744499; x=1776349299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6LKiLHBuO+qqN94NMoP5HEOooYN0938OEtpgM2ORzGc=;
 b=XM6qU3QuiA5vUsJrHaCUqb+n9D+ZVoiQIGXc31mSLsbrml/0pWDYoibx/Ij41IPnQU
 N6eisSmhclR/X9YUkjlUiiGP4Y/fo7h0etIy7Q1KQHCtWLrfRa9skPI+k9jx/XEKEbSQ
 +QVTdqalsq6iuRSCyd6D0rjw90i7/ZgBNKMdDLhPfKdw9DiaA9Z4kVnSPtrpn1yAIFZq
 x/swfFbxyK4RpwsRn6MwkyQIB2zdcUSeXz/mF6MTyNG6AcWVrfhIY8wcgoBQa/WD+nR6
 z3Xgyi8KKwiUOh8a67cvgKfcsgE+P2z+gPwpKKlDXRn7GMdM9EQIVkFdvTI38Fcp6fW1
 4Ibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775744499; x=1776349299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LKiLHBuO+qqN94NMoP5HEOooYN0938OEtpgM2ORzGc=;
 b=aKY0JmOBfizH16SY2b7LQkyTI1nvL10JWGR/1sfeihEARs33ZrsJWbN7WqIFhsJ/ZA
 b/TJ7VTMoSrGeQAyj0xvaYb0RjeJRDlIzR8EIa9mFhRRha/IHZGTwpzSlt39z4im0uUx
 eR4zyh5xjwWLpG4pfxsW/86rOaZXZkuYAR7IVgJFJnfbI6wPCCwpvB9FfP2PYz5Nyd33
 2uMEJ6kXocLqWJLVxQXDNYb1YXPXU2dN8Hh7bHlM16O3+qyNo/+hJ2QMikprGYuz65Cy
 mN9gk2Y9EYUTNCXwTRI8E/ym31SEweNYBfWxvMiiOv9m+2DSiFvD5a0W8Fdajwk+eAjW
 nPSA==
X-Gm-Message-State: AOJu0Yzmasd2s4XkVe8XjwEdWx7uYy/j8wNsDF55cFx1tQgVlym3e12Y
 Bf4ljiJD4s0dNy2RVYBpOP1/my1l5HYixioxfvk3i0X0QS+vfM/w34cffzoCkzDB6MySZgVQz7V
 mo+2miME=
X-Gm-Gg: AeBDiesL5iaknx3i/EkKQgLejZ4yFxv6IieqB5doKEoKS2r4XxMYiYNExKW5AgkNXCH
 +tdfpkyFdOaMK8CQmFTuG1FxH+W+QaAH/QLY8yI2+YXMMQcCkMp2LLtsPtC7Da/XYtZSJIINRLL
 x2wFQ9yxSeFli0Npzr1bTGsGYMZmirRxXt8YoMbkcZpLplxWAA3l1KMbjkiu2xpL1IBLh+qknR7
 0PzJLwEM/+RVaNbbFr1gyKREWgL3jkuss1ploH30d+sf111+ZeZEkGk1vKsUh5kIx1pU7tjVkRd
 OT0Pn6pn3cha3Ntbls7u+Tfmp2i8iSbltK0WaCbOTblCsurSRtP9VEAo7SA90Jos9+AcsSESo2C
 w5biA4LDzCcu71rPEUdoc+8aoivQ+DWjfCZMQxFgCpDm5wckJ0cl4Q+Pj5TGRito+cgGmHF0Krq
 E22hyWQh/8dC1YjfFx+hiLhSvpfU+HqBZcc5iwKNe7+8GJO2f4ZpsY+bkQJbXPkhPevrvCqf/0
X-Received: by 2002:a05:600c:8105:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-488cd01655bmr55528735e9.28.1775744498800; 
 Thu, 09 Apr 2026 07:21:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5308811sm444775e9.2.2026.04.09.07.21.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Apr 2026 07:21:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/4] Misc HW patches for 2026-04-09
Date: Thu,  9 Apr 2026 16:21:32 +0200
Message-ID: <20260409142137.58349-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The following changes since commit a87e211600e5e2a86ae51ea53615cd4d866b24a2:

  Merge tag 'hw-misc-20260407' of https://github.com/philmd/qemu into staging (2026-04-08 19:16:36 +0100)

are available in the Git repository at:

  https://github.com/philmd/qemu.git tags/hw-misc-20260409

for you to fetch changes up to 4e6fb62fb0f33c815b089d0b59e1313b768c55d0:

  qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config (2026-04-09 15:44:58 +0200)

----------------------------------------------------------------
Misc HW patches

Few hw/ fixes and a keymap one.
----------------------------------------------------------------

Alistair Francis (1):
  hw/timer: ibex_timer: Update IRQs after writing CTRL

BALATON Zoltan (2):
  ati-vga: Fix pitch and offset registers mask
  ati-vga: Fix check for overflowing vram

Dietmar Maurer (1):
  qemu-keymap: fix altgr modifier lookup for newer xkeyboard-config

 hw/display/ati.c      | 16 ++--------------
 hw/display/ati_2d.c   | 13 +++++++------
 hw/timer/ibex_timer.c |  1 +
 qemu-keymap.c         |  3 +++
 4 files changed, 13 insertions(+), 20 deletions(-)

-- 
2.53.0


