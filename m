Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE368E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6C9-0008QT-86; Mon, 16 Feb 2026 16:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bn-0007NW-H8
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:38 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Bj-0003wT-7O
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so34758155e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277484; x=1771882284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cCPH3IMkM+pPTIgeZK/yAg32MsXi9GhNEv/F9XKgdBc=;
 b=iDRo5U1/GAkqtYRnkhICN8aEp6Sdfk1XEaba6YA5a3TowH6c7DUGhiJ22/IqvA3tME
 Xn/YBs1wPg4dutLufQt64XsOP7f8pnf1ljyvmriPUvFdrimIsb31FTj2tAhr8bvISbrX
 Az1eRhwtjwu6oynMS5vyAZv7WxtT7AE+9G+L0aTGsivmBVal6i3Hhr4JiqjQP6+NKM26
 SeAWV/Obl3yjYKO2WaSIOGYlmlNL1P/TPX4e+11aPCMAvElI4YCXNle/ah3TjIBHji3q
 gmYPXvlZQoylNgUODByQADNYjR3x1m9rtV3ZvGWJLSE5GALYL7ecPjPsl4Ce4OJzsfd+
 fRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277484; x=1771882284;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCPH3IMkM+pPTIgeZK/yAg32MsXi9GhNEv/F9XKgdBc=;
 b=FUk2bbP4qVANIpkjluBk+I7RldWTVIXXM2S2Os+OYJxG9ccm1t5MTAM2EcBPJVTB3o
 /QfPHvHVIKRo0EBw2sv79iA0uSQbjOVphJQsq5a1nUOUdM8GQYP1Xz4fXwQzaZWRTzv9
 swajymn1CunVNH/kGP7ina5AxAoMe2+/FB5oy1BEOZlIpoPvFTVx6bLe1KzwtceX8U/E
 bEDc5z1wXHBdTtrWJvT1jq/JE3t3tbT6D8B/0/k/G8ou+NiD0yUuCM5wGPNqtAOQB7Sb
 oA4lQpgY7VgQCj3Vcm3OANAsAelI/Jr3HOzJEYw6psLKqEf2bMeR67ww+1fvTBgVPE+g
 XuQw==
X-Gm-Message-State: AOJu0YzfmFPA8Z/xjC0s+j3JSX4iAZ92m7efpib5hio6NWRfWSbhIn/g
 Gu2BbyyiHfhO4M7ys6PJ6Bonv5PyIQNnS81V4ykzPtKlIUAJUFNe0FLsL28Wlkslg80LIVRCIWz
 9NY7PDrg=
X-Gm-Gg: AZuq6aKvcokajnVZLZsyU3R7uePRarm3GOk12RlcFRpbKp5NgIYLA8pS/YhxXApzJCs
 53/yko82EjtrIdAiNMO/jOYW4aH9KwbRDrgfB6kAU8nP6N6wxnCp2uvlL/md7QzZblbYDU1VZ1+
 7s3JAFRAzHjQ6J/pbVnmcM3TF2cyQGaYJGLbL+0n7wI6uzg3Sxog1c9Df8m9ZDt6RjLQwFacj6+
 q0PyM02w5ADHBVFp5XJav4Z5IFtc8GL/UWPKWTE1/jCfs4S356mPDrifn2LytCciqzr4x7cegMT
 oCxupN5qLVNxluRD5juO9q/Q/iVWYcvWpNG3OY0bbjq/flz6W/ZwnJdlNuJfeh7Chj4w/fyVWRy
 n0xPvXYT1ecF6qV1geq2GmcIyQzUeUtGIeMZdTzxQNUc01S1D2ZalRi8u8O4wyBwerjZTf+pWqi
 yuPr2H4unesuvw+o0jnRXgviSPllT0mbRdHo428b1WEdgemmdriievQBu49Gh9FSY3RAgeSqVG
X-Received: by 2002:a05:600c:4f4b:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-48373a160b8mr229270625e9.3.1771277483722; 
 Mon, 16 Feb 2026 13:31:23 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836aa0847asm497175955e9.3.2026.02.16.13.31.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:31:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] system: Absorb globals-target.c within common globals.c
Date: Mon, 16 Feb 2026 22:31:13 +0100
Message-ID: <20260216213121.47122-1-philmd@linaro.org>
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

Missing review: #7

Since v1:
- Inlined PPC code in patch #7 (Mark)

Slightly rework how the graphic dimension variables for
the M68k / PPC / SPARC targets are initialized, removing
the need for the target-specific globals-target.c file.

Previous discussion:
https://lore.kernel.org/qemu-devel/e514d6db-781d-4afe-b057-9046c70044dc@redhat.com/

Philippe Mathieu-Daudé (8):
  hw/display/macfb: Constify macfb_sense_table[] array
  hw/display/macfb: Constify macfb_mode_table[] array
  hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
  hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
  hw/m68k: Set graphic display dimensions generically
  hw/sparc: Set graphic display dimensions generically
  hw/ppc: Set graphic display dimensions generically
  system/globals: Build as common code

 include/hw/display/macfb.h |  2 +-
 hw/display/macfb.c         | 18 +++++++++++-------
 hw/m68k/q800.c             | 17 ++++++-----------
 hw/ppc/mac_newworld.c      |  9 +++++++++
 hw/ppc/mac_oldworld.c      |  9 +++++++++
 hw/ppc/prep.c              |  9 +++++++++
 hw/ppc/spapr.c             |  9 +++++++++
 hw/sparc/sun4m.c           |  9 +++++++++
 hw/sparc64/sun4u.c         | 10 ++++++++++
 system/globals-target.c    | 24 ------------------------
 system/globals.c           |  3 +++
 system/meson.build         |  4 ----
 12 files changed, 76 insertions(+), 47 deletions(-)
 delete mode 100644 system/globals-target.c

-- 
2.52.0


