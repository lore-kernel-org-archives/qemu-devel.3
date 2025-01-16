Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8C2C02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 23:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYYur-0005uo-15; Thu, 16 Jan 2025 18:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYup-0005ud-B4
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:43 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYYum-0004xJ-MN
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 18:04:43 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1126129f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 15:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068679; x=1737673479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/Xc2XaAlWpyN5NpG603Hh+ExSXBxGrhRynU37t6mFU=;
 b=gkLSrPW4Sa/TCnlnNJ3g/5pxMcqBE8rfXCABf33WK5OQLeEITzAtbsKTdXfFObSlJa
 xz0QSZwnYQ7mHZkHSe2M2m571o/UpYn4jTgWlA849N1LNX1yIxVIs7Tr7ex1+9RU5rQV
 pDx6lXaV5cJP/lnK4ByuZrC8/8QiVjgk9iZxCzDR7BA6ZocnryHvDZPEablJIrjSRaAL
 SYoNSz0OTKRiwbZvvNHMAvnqkS6CpdloBSH+k9HByDx3Uo6sArFA/ZxuD9y4E3hYhM8L
 p21J9JcUI7vjt/v4cZcYKTD5Rk+W3qMitSrw6wCvxxz3quTeAyvYUME/QZXcrx+a6PCH
 y/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068679; x=1737673479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/Xc2XaAlWpyN5NpG603Hh+ExSXBxGrhRynU37t6mFU=;
 b=YaGFKBwlIMkZIz5dPJ5L/tOYwSjzF06V0kOIyrrin32SiXpDkSR7rPRq+mRenBc0X0
 K2QpIZPZJplEfIQ7Nsgh6pZpkku75yFyJC5j8zF4wipejGX7eLHC1zAahbg0+LE2+fdY
 PEa2vd7zOQNhWCw4hVAjcUPCqoIzFlmK8Dv474bo1xFxL8bBgR0K/rJqKzchoEwJ2w/p
 4wuXMMhBB5NTLPjR6Py98RrzAWxjvrEixzC9mhorg4An4hdTZuweqcHxr7xH3CGr0WiU
 mfTMqI1V85PzgJMVX5NgDjz0doHZsSTPeDN6uNa8MU8k9LHrWbnhcVwR0LX1snkNVEXC
 4GQQ==
X-Gm-Message-State: AOJu0Yz1sAP6/acjh/chvQYny/qvRCSMR7W+8gPsyQS1ILCbZabjJoeQ
 zph/dwv5ySWCUa+iCqUROxpOCUp5Hdg/NGbHiWIruTRUM/Tp0HkiyDUBqPkf88d60g7f0ZyfQks
 XQNQ=
X-Gm-Gg: ASbGncsx0Gs+TKI1xvqVRZMiqEJYF8atIKlGsNLJ3HMBt9brchJId82rttMjnySBz2m
 fCAkGMTng7aUb5Ba+J7F58ywg+DJtuzGJnHr4orAYYl8ZdThpNpvcgaksSA78iD6paWHFdOeCX6
 ZBA46zuQWURke9PjyZij/LzQcA8r63DKACluFXRoWgQGfyTGEGpUJp4BHkYL8uPpppBWEC9Ll23
 pKVjyADtOkFLHX7D6+lNKYtmQLtdvPIv3Z6Q/vCGY6y6mdJwCJ45s3rVbmVwRvlM3fCh+KRYNs4
 D3B216mpbXorLOAHjgyAGUEpyvLDRRU=
X-Google-Smtp-Source: AGHT+IGo+4BOn4N/u8HKLEKf9M9tdN4J/vS5A9410nA0KIGbxXGttI4vBFtbCEQw2W+SGYIS9Id8Ew==
X-Received: by 2002:a5d:5f54:0:b0:385:fa33:29ed with SMTP id
 ffacd0b85a97d-38bf57d2cc4mr295816f8f.47.1737068678720; 
 Thu, 16 Jan 2025 15:04:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499bbasm76971975e9.3.2025.01.16.15.04.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jan 2025 15:04:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 0/2] target/arm: Constify helpers taking CPUARMState arg
Date: Fri, 17 Jan 2025 00:04:33 +0100
Message-ID: <20250116230435.87580-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Hi,

I'd like to enforce some CpuClass handlers to take a
const CPUState* argument, but before I need to clean
each target. RFC starting with ARM, mostly to get
feedback on const_cpu_env() and const_env_archcpu().

Thanks,

Phil.

Based-on: <20250116214359.67295-1-philmd@linaro.org>
 "softfloat: Constify helpers returning float_status field"

Philippe Mathieu-Daudé (2):
  cpus: Introduce const_cpu_env() and const_env_archcpu()
  target/arm: Constify lot of helpers taking CPUARMState argument

 include/exec/cpu-common.h |  5 +++
 include/hw/core/cpu.h     |  6 ++++
 target/arm/cpu-features.h |  2 +-
 target/arm/cpu.h          | 71 ++++++++++++++++++++-------------------
 target/arm/internals.h    | 10 +++---
 target/arm/helper.c       | 25 +++++++-------
 target/arm/ptw.c          |  2 +-
 target/arm/tcg/m_helper.c |  8 ++---
 target/arm/vfp_helper.c   |  6 ++--
 9 files changed, 74 insertions(+), 61 deletions(-)

-- 
2.47.1


