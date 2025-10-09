Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241CCCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nbr-0005Ww-Ro; Thu, 09 Oct 2025 06:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbq-0005WK-1z
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6nbk-000786-1d
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e47cca387so7866345e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 03:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760004642; x=1760609442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DMyJb1kgjQInl1Zt8ATMyxZqJDqGdcJNQvJTeA+3aMY=;
 b=iUD1zk1O2wxdB6gRtu+cT8GyfJIDvyi7HADy0aOSexfRg2KmVQ1GBU5c3bHZTdNbcL
 1Z1V3/NCn/c+//pBjETABK+BBdBUivI+XN/tO1YB5iEQJzzotC0r/CJCxDtj7nc1Ukr5
 7lEwCEQE4cfuu2JUPfp6SDVANpkpsaiNWwEHwIHYtXNwlGcp1sarPijxcYlYAODDAFWR
 emXk41Qzht6SfgsBc7McJHCavhy8jcZIyVP7rFhZspbbzh558b7bhxzKG8Es5u8O4Uq7
 V4SAFZ1Oc4R/eeWpG23RzEUnSt3CpGBZD70/C0+2Jm1hFpJtDn8N+bYl6K+Qhy5CC7OA
 kfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760004642; x=1760609442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DMyJb1kgjQInl1Zt8ATMyxZqJDqGdcJNQvJTeA+3aMY=;
 b=LIW255HFRBGsoCcC49YZI9LLqWOWPfeU1bDh8XnXlpgUzcep2lLBkmmRngh7tf7STD
 zR74eD4m7uLSQIVc82YLWcPeIY0WxpAI9XTcb8V4CBF6MtyHrIchOtgU9XCwEXn+DmZU
 cLVDYCxIjSO9BQp+OHaFSdU5N4PCiQrszDq7u6z/DjOCJKf4A70uhw0llw+T/xkVNcAn
 j6IMHdVNpAFdh2gsYVjGEdn8iMXobczJpyg5Zws0VUQG307h/yrZLCsQKfFmwyB24h5M
 bYddjYWj4+jjtfsnauElrnYCAuSDm1j+3UIokkdfoQOlEY8BjYNh5VKBt0tAqmmrFBSt
 FS/w==
X-Gm-Message-State: AOJu0YxgBedielX5ECM9cEEWByAJI66VCO9lLRq8wMeqPeCm8SBBx4L8
 Gx3MUENNyZGkOspJxAJEwAhX5nkpXKKslCIPJe/zHqIGPGFueI5qyZz51iSd4PcNoSUkzhP8Hng
 IsAnE8nDUQg==
X-Gm-Gg: ASbGncseNUqMlO4l4kQ6HraFJezwosjQr/HpaBuQEY57xfzcJzoWOSHAwUs0NyeK94+
 /nXhtSD4eXudTcxb8QO+8T+EmsyiIsbDJgJ61LLkNNmMmOeTF7pd6tW+4TKh2lK/oAfZdEWn/zG
 9RMIkdTHzU/QkC21WoRE47zeKdwNdv+ph8jrHoOyy24iMs3akkMyBT6UKbz4WBasg2wGf/NOq8q
 uWICGbFHMdE5uCx/fQqeBXxAnfQqmnbwydCq6ukSqE4QRw7hCt0xPDnG0Fr3DWpRFJ6pPzKDdAC
 yLJhnxmj4crQhoPLsXr1zDXK/8Nh5zo6D5aP0WXZfpKEMjDNP1qE4K7BRuZqPEpYKf9O2/VJ9AF
 6KitrMpw7DOvHYD+3SUMYlhgovdnB/q+HCHSOmas++s5bP5LYiNc5+P2xrQOfbPLO7uzEdbDykt
 jRV9TaVKz2BnAjMuwJGP1ihpI07y0/MGiB044=
X-Google-Smtp-Source: AGHT+IFAsuRxpRvcGDORcDULwFeiPORRdGgbjS4K83CCLm7uxdATNCal3lkeb8qYN/r37XRPZJEcxw==
X-Received: by 2002:a05:600c:34cc:b0:46e:3550:9390 with SMTP id
 5b1f17b1804b1-46fa9af18ffmr51795785e9.20.1760004641940; 
 Thu, 09 Oct 2025 03:10:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e970esm34051401f8f.35.2025.10.09.03.10.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 03:10:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] target/hppa: Remove use of MO_TE definition
Date: Thu,  9 Oct 2025 12:10:30 +0200
Message-ID: <20251009101040.18378-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

- Replace a pair of target_ulong types
- Replace MO_TE -> MO_BE

Philippe Mathieu-Daudé (9):
  target/hppa: Use hwaddr type for HPPATLBEntry::pa
  target/hppa: Have hppa_form_gva*() return vaddr type
  target/hppa: Explode MO_TExx -> MO_TE | MO_xx
  target/hppa: Conceal MO_TE within do_load()
  target/hppa: Conceal MO_TE within do_load_32/64()
  target/hppa: Conceal MO_TE within do_store()
  target/hppa: Conceal MO_TE within do_store_32/64()
  target/hppa: Introduce mo_endian() helper
  target/hppa: Replace MO_TE -> MO_BE

 target/hppa/cpu.h        |  6 +++---
 target/hppa/helper.c     |  4 ++--
 target/hppa/mem_helper.c |  2 +-
 target/hppa/translate.c  | 23 ++++++++++++++++-------
 target/hppa/trace-events |  6 +++---
 5 files changed, 25 insertions(+), 16 deletions(-)

-- 
2.51.0


