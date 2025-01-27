Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCB6C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcMK3-0001bo-K4; Mon, 27 Jan 2025 05:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMK2-0001bY-7G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:26 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcMK0-0001vO-3t
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 05:26:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so2536555f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 02:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737973582; x=1738578382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HWdyQXqewKLw4j1QduA+K9zB9k1/pnG1qDE+3bxWVJA=;
 b=cU+f9Dak2Krs75maVrhawqIxoT6QGZtdh2MjzBnpTANVrjdwq+Remj6O6W49Jo10mQ
 5U88DhskjsYoBRoeVQ1IoqthMTQOobZo36upMdHjLAOX09FRLubPCb0reG39bBctoDLf
 CaiqDToh2St7Oy3E31qUqvUcTIQopEvi7kQw7U+xQq2B/6x+c/rfob6MD93ws+at+klk
 BDuNjkFW/iQEA0bist/FycsklNuACFOAW0t4+3ihDAs2EgxWj1TzlMEm1iPtmJAxInZD
 ImJUNZplWflnOf9kGNb8jffwp4SP0a5ZAeJUD1AjzHVh4m5z0V2e7XWHlYFEjRvjkv0k
 RG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737973582; x=1738578382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWdyQXqewKLw4j1QduA+K9zB9k1/pnG1qDE+3bxWVJA=;
 b=Nd4kXkk9mgwKPL/feOn52CXr0pzZilprm+ij6TyrZr77KC2ZA5JoYsGXQt5YNarUIp
 7kVoyLCRq3yx2SBAENqZbAiRLEMZDlfggI9+dppeuGNd0h0kZ0RV5ARtZ1tYftDffNAN
 hs9SPckHfyAyUBrk6crUov7qIVlCXyLxm2IGDzO8JjNPWpR76aIg1uuMXekC3pHf+Hrn
 ayuTLrggrEPKwSusD8uED8C2ko8KoduWQYDz+2GKLb7e9hrZkz2SWCoRFRe2PjAIfl06
 /USj/GGcs6qj473pLzUF8tiKa8NCMi0FRuUN1VFOTze+HdMKwBc9OVTZWEnsvI+nStIr
 MQ/Q==
X-Gm-Message-State: AOJu0YwGX2aLT1+OXiPb5tR5PXNj06V/dWPE10Ww0dOYo12+o/viZv0g
 dbjsnguCMO/FSbi/s/TYuOnB3De0E+tZJCE1tuKaqcnsZTwyp9NALOLkx/9GZlQtGjWmJyJZEty
 thNw=
X-Gm-Gg: ASbGnctk0DQ7VvW6vdOzS4mItAytyjgI1uERqmsbG0kb11vF00FTp4CfeySb/zZfGDF
 7AS1O+b8vZWpjatko1oA6w+Na4kYy6zjvtQ4yt3pwcBFgDD18D9Un9qdhEUG4cP32Y/k0NRPC8E
 wWwHr6o0cXk8lp01xdQ4mFt6gYKwV443UhvdUIYsJBLIuGFk8Dr3Hd8mGIbpKsWYh18oS5iT1Rc
 WTqevLvzbNhQCQeHDeorMWHlreyGIx47AQp5VGVaVyOdRJy8ad0MSxR47t86RAs9uszZ7vYEZDa
 tdxIJtQbEYPpfELM9FvtzXadugDR2VF35kH+4L6y9mHjIEm9CKhAa+I=
X-Google-Smtp-Source: AGHT+IHh0MKFEbuhYVA4CRNX5ZS2JVvyF6xhZaS1XyNSHzvbAblCIOnqXXxza7j7JQkiKOFl+lVR/g==
X-Received: by 2002:a05:6000:1846:b0:385:df17:2148 with SMTP id
 ffacd0b85a97d-38c2b7c1810mr9685323f8f.20.1737973581959; 
 Mon, 27 Jan 2025 02:26:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176538sm10443441f8f.8.2025.01.27.02.26.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Jan 2025 02:26:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/15] target/ppc: Move TCG code from excp_helper.c to
 tcg-excp_helper.c
Date: Mon, 27 Jan 2025 11:26:04 +0100
Message-ID: <20250127102620.39159-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since v1:
- Keep ppc_tcg_hv_emu() within TARGET_PPC64 (patch #10)

Hi,

This series is a simply a cleanup restricting TCG specific
exception-related code to TCG, by moving code to a new unit
named 'tcg-excp_helper.c'.

I ended doing it as a preliminary cleanup for the "Extract
TCG state from CPUState".

Diffstat shows 1K lines moved, but the patches are trivial
to review using 'git-diff --color-moved=dimmed-zebra' option.

Branch published as:
 https://gitlab.com/philmd/qemu/-/tree/ppc_excp_extract_tcg

Regards,

Phil.

Philippe Mathieu-Daudé (15):
  hw/ppc/spapr: Restrict CONFER hypercall to TCG
  hw/ppc/spapr: Restrict part of PAGE_INIT hypercall to TCG
  target/ppc: Make ppc_ldl_code() declaration public
  target/ppc: Move TCG specific exception handlers to tcg-excp_helper.c
  target/ppc: Move ppc_ldl_code() to tcg-excp_helper.c
  target/ppc: Ensure powerpc_checkstop() is only called under TCG
  target/ppc: Restrict powerpc_checkstop() to TCG
  target/ppc: Remove raise_exception_ra()
  target/ppc: Restrict exception helpers to TCG
  target/ppc: Restrict ppc_tcg_hv_emu() to TCG
  target/ppc: Restrict various common helpers to TCG
  target/ppc: Fix style in excp_helper.c
  target/ppc: Make powerpc_excp() prototype public
  target/ppc: Restrict ATTN / SCV / PMINSN helpers to TCG
  target/ppc: Restrict various system helpers to TCG

 target/ppc/cpu.h             |   5 -
 target/ppc/internal.h        |  11 +-
 hw/ppc/spapr_hcall.c         |   6 +-
 target/ppc/excp_helper.c     | 943 +----------------------------------
 target/ppc/tcg-excp_helper.c | 924 ++++++++++++++++++++++++++++++++++
 target/ppc/meson.build       |   1 +
 6 files changed, 955 insertions(+), 935 deletions(-)
 create mode 100644 target/ppc/tcg-excp_helper.c

-- 
2.47.1


