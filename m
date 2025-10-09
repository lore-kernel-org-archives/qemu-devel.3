Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D664CCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 14:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6rg2-0002Ja-Rw; Thu, 09 Oct 2025 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rft-0002Cu-47
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:21 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6rfk-0002zf-Pd
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 10:31:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f99ac9acc4so922935f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760020268; x=1760625068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cjPNevo2CNH0Pr/i8dAGnpuNpJKgjLopUkdNiXz8fvE=;
 b=JjmCxjj3qWWDvPGmiZ438nvWvitjhwURXDoNOFLQkeqc9XIaTNKoX/tiu5goVV5AEZ
 doY2saxbo8WuL3D9+wQDRSOJDjjQVRPsZzahuazm43dxe5DPMPzgGFVowmHulFUjeO2k
 1kRhtVahSlLtTVWNtrsqqyMgMtGIimN8udWYk7ftYdgP37KsUtzwBwyOuF4wVyW2tzo2
 mnlMBJBvbPxl49BPpU/Uj78+ny1aperYlCw/HtXfu7sOEwrJ/EkPHuNZme+s7eJi5eS8
 Nbs6o7XBr2AvtE0P9ANNHQ08vi6paE/LgkDCvJJPRPszAGDz5Vr+2SdTdAB4iVGSmi+S
 yNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760020268; x=1760625068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cjPNevo2CNH0Pr/i8dAGnpuNpJKgjLopUkdNiXz8fvE=;
 b=MuqniFunvhQg6hYVIZkPzCw6CNv+5o+PDRkRZOiRj6iZbNXoKJp5kfVTFpieTO9/Ch
 AOPzdBSkjADraT461IHubF93kz5BIw8Mo+9jAQfx6vNTv9pqDC0mrYIC1umXzELGdsC6
 na38yZsOPzBTD9jnf9hdzkkFajYJlcAf/Bi8uTcbvtNrr/WNtr9H0uFnGQJbdPcJw+Td
 f6sUkYs+y7/7xASxAUeBfwoKsYyCKUhtJtA7OaynJ5JQk+2A4mUpnCLmZhTtoVt/ogqr
 BL+3OLMtWJlCvq0RRGToVZOPw+O8VIkpz7Rz6wRT2fHthu1riIGipkrWaBEnOa6+MHGo
 ndbQ==
X-Gm-Message-State: AOJu0YyulTuTP/igNrtGF9ErthiUPYfdv2bCzJWWZ9qsRT87sfWY3F/3
 iSC+FQjxQQrQuNyzLj/u5Ga6dQWPsummnS5dpCgRyBdbiCEXD+tIGwSb8uS0oL54kyabn/2rror
 rtfusC3UnjQ==
X-Gm-Gg: ASbGnctAzgi7wPQrHdFGlIiJnuj9eDMRJAGLmmLRa7piPYezGMZ9Yah8KpG/YxxF9Uv
 HL6BMVZPs4SsrOTTEVSlldpwMgU6gxVVBO8ew6W/IVKZGv6fw9rPCqKG+aEmy6iy9BbBLJjnDIC
 XWSP4i5vh5PcbgQYMHUZAO0bZtq3IUETvuMAgNLvtE+JM47GK3Jqz/ehhQ3vOAA6YbAv3hJx5B4
 4OBm/Dvf/F4D49tA6M5M5i6qKQf3ovR1nb2aIF6BG+u91AHHNv9vwgV2BU01x030vfs6MTONqMp
 fB3vKi/SF0/DGFnW33mLqGz2+TqIHexFA1XcRJ5eI94GGHzqaoc1FOSI/r5P6UTgRRnL88hVGmh
 tT2SC63ARCdyveZQ+qM2UEOjLQWVFNv2pVLSJmboMSXP9JHlIQLy/xeznHUDPXzsZ18a6SraJqs
 q1Iw4shOUlwPDlktHwTlB7QN/7
X-Google-Smtp-Source: AGHT+IErP/avI+wlvm88GNCuJ8NQKQdIjCy96DsnTjBGvBvNTQmWQoIQpK43SiMXQefyg26mmwXxJg==
X-Received: by 2002:a05:6000:1861:b0:401:ae97:a1a6 with SMTP id
 ffacd0b85a97d-4266e3ecf0cmr5199730f8f.26.1760020268366; 
 Thu, 09 Oct 2025 07:31:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm35672426f8f.50.2025.10.09.07.31.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 07:31:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] hw/hppa: Clarify machine variables and move them out of
 CPUArchState
Date: Thu,  9 Oct 2025 16:31:00 +0200
Message-ID: <20251009143106.22724-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The HPPA machines uses a pair of variables for distinct meanings,
depending on kernel or firmware mode used. Replace by variables
per mode, allowing to use the proper type. This helps reviewing
the code. This cleanup allows removing unjustified target_ulong
uses.

Philippe Mathieu-Daudé (6):
  hw/hppa: Use the machine default boot order at reset
  hw/hppa: Convert type_init() -> DEFINE_TYPES()
  hw/hppa: Factor QOM HPPA_COMMON_MACHINE out
  hw/hppa: Introduce HppaMachineState::boot_info::firmware structure
  hw/hppa: Introduce HppaMachineState::boot_info::kernel structure
  hw/hppa: Move kernel addresses to HppaMachineState::boot_info
    structure

 target/hppa/cpu.h |   4 --
 hw/hppa/machine.c | 162 +++++++++++++++++++++++++++-------------------
 2 files changed, 94 insertions(+), 72 deletions(-)

-- 
2.51.0


