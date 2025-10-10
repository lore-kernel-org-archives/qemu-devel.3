Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C635CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75Zn-0006br-Ex; Fri, 10 Oct 2025 01:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zk-0006bV-AF
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:21:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75Zc-0000IF-EZ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:21:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so18020555e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073703; x=1760678503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cm5IP52hmTNiep90hMwNdUXCfCvr4M+nPyRTZ9Yd85Y=;
 b=drEALC/MRvNUUkrknhYurO5eFD1SXSg98URvjYFs+5+Pv5WHhaWNKPW3LELt7fTJCz
 QGtuYhjYzr/njoJyXwk2lpSJ0wopi0R7zbM4djZYbDyKKQCcjHmLnX6sHUrZ9snTcco0
 TmmuBe1lCuZYt3WUejfFJXJwQ1Oo3ZXADzFmxAyQGQEMfKWBPB30gKeREToYPtH3bqbO
 eDJctcNf+V0z3KjQ28ITNunsEbYMgNBGadU2u/nyXglM1t19jVV/4qnWFPpBu08SQI2n
 DzePbCPUhKJHFQvVOOHpG7xZRgziogtjVQ9/ADe+oHDIs1dUNrsZBqaRoyPtrWDswQVl
 G9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073703; x=1760678503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cm5IP52hmTNiep90hMwNdUXCfCvr4M+nPyRTZ9Yd85Y=;
 b=Hu+UUl3zHdz6+DTjE7582VMPQFNFGjRcXNs4vAP7CPAYykkcWuK7fUEqJD8SfA4Abw
 85geD7WKHb8lB9K79iZ0mAgLF/209JMLyLwc3lxHac8cDVr0G6EcQGldY0h7lP0PKGCr
 ZRwxqqNbnCw0UA8hhheXVRMi6VWp4Z8XM1qkA2y8Q1rLUqKZ2+ZuN7n2yTKisorU80xe
 5LaFBczMHFdxFJu1DjHAw39Gtw+ruwKrFjJqas+J9P8J70/4Z0Rv0yi9zoEWY+LC7ELB
 PYJW4FQ8EqT9hTqFhOuFoioUZrK6sCOkNiWhoVdqqcV8PLxPxF9wqj15w9JmSHK0QgiD
 9ErQ==
X-Gm-Message-State: AOJu0YyLd0OOCvcbS98JJw6aGxHyNHvL46wa1d916HgZ/VuLJvELkzSI
 YtHzICMTVcJF3VPVTG+u6BpHaz9T9xg6vuUPunzzH9/XNcKDeW6Red5jqL6sicczFuUKBsEDMkL
 Js9xcTNNBiw==
X-Gm-Gg: ASbGnct2Z0nflE/No2TyYLvBiCf//EH2xiR/lu7R1R7Dnj6vS0JEEuyj4Pyd7GQs++7
 jBct9hlNuFo8WeFZevyYHBBv3A66Ar79TwZzYdefrOtK/Pi4YrfBiTGQwfejyG9pZKkF5O2eKG0
 B5owPmj403a9GZKoBspFk+uXmmJ0YgEqki5kG0tcEs0N5WPKoB2wKKYhsRLgzieCwWxK+SrG2Zc
 GjdN6glyvbJY8CY5aNmdZbA9D9vuuTNvYC2opt6Pwm/6ypBw7m1QroHkFI4Gkmi0d21n/MdjxMH
 ddmZ5iDzfxe3oW2DXZGaojSmPR9pP0tzsZCyS/ija51OeVYkIjkk4pTAhNL2tn0EXqGCRwDctEY
 4ub6OIpEJQXpalPMSai6QKnlz1Lc9OsJnNsgKcu+kRGZ01hbv3ZH5ApO+zxL55mpYXUDKbLRl77
 YuIycrvOSMtuheU/3oGV7CB9ul
X-Google-Smtp-Source: AGHT+IHZje5sJ52iB7WPhUpcODNs8q5TtzwazZ+JU90X3EPvC4lADLARMKdi2xZev2MrAL3+GMcWBw==
X-Received: by 2002:a05:600d:4264:b0:46f:b42e:e398 with SMTP id
 5b1f17b1804b1-46fb42ee48cmr14480635e9.41.1760073702658; 
 Thu, 09 Oct 2025 22:21:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb492e6ddsm30940045e9.0.2025.10.09.22.21.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:21:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/12] target/tricore: Remove all uses of target_ulong types
Date: Fri, 10 Oct 2025 07:21:28 +0200
Message-ID: <20251010052141.42460-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Remove incorrect target_ulong uses, then for the rest
mechanically convert:

 - target_ulong -> uint32_t
 - TCGv -> TCGv_i32
 - tcg_temp_new() -> tcg_temp_new_i32()

Based-on: <20251010031745.37528-1-philmd@linaro.org>

Philippe Mathieu-Daudé (12):
  target/tricore: Remove target_ulong use in gen_goto_tb()
  target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
  target/tricore: Remove target_ulong use in translate_insn() handler
  target/tricore: Remove target_ulong use in gen_addi_d()
  target/tricore: Remove unnecessary cast to target_ulong
  target/tricore: Replace target_ulong -> uint32_t in op_helper.c
  target/tricore: Declare registers as TCGv_i32
  target/tricore: Inline tcg_gen_ld32u_tl()
  target/tricore: Expand TCG helpers for 32-bit target
  target/tricore: Pass DisasContext as first argument
  target/tricore: Un-inline various helpers
  target/tricore: Expand TCGv type for 32-bit target

 target/tricore/cpu.c       |    2 +-
 target/tricore/helper.c    |    4 +-
 target/tricore/op_helper.c |  219 +-
 target/tricore/translate.c | 3969 ++++++++++++++++++------------------
 4 files changed, 2107 insertions(+), 2087 deletions(-)

-- 
2.51.0


