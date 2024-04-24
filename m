Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C569C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzjAZ-00052z-FN; Wed, 24 Apr 2024 16:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAS-00052P-Ev
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:36 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rzjAQ-0006W3-Oe
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:24:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ecee1f325bso339205b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 13:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713990272; x=1714595072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T5idrgSlsL1v22VeXuuB60pwgSO/bH/MB3TJ64UTqoA=;
 b=I5XNsEg4VSyWibLKCIrJmtA/aWBGf/+pxWqdSfiFhgrxVRIMSGa4C4decSeG7n4p8K
 kpm5A0Z04FhPBiCraCUMD5oSxcJwZvTzrAE4n0dhUTEUNk99JinEIrixobLy/07I+30z
 aN0R1e8Bs6MP58MdDXKdo6M0fJ1EPuHTwBnwQYHuvXw+f6nIBCQu7xBlnSqvKOJG/nH/
 T3WTwMnYOVqGIBhyRZO4Fpf6by/SuIqqFykM/4x9HelrzF4FGPCCl6SYdQHlHYrUbRBg
 O0T+4iRtJKCPhmlbdHtCJxhyiJOHbaR8GsJQ8qNRorOvhyLue8YO0qWbVUCiSLTgFAWO
 xsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713990272; x=1714595072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T5idrgSlsL1v22VeXuuB60pwgSO/bH/MB3TJ64UTqoA=;
 b=YWwFVXwjynXLcZEbpTNrrW5TM/pvMd90Mkw5NENMctwIXR+sRKB8F5r8jVa0yOHqg3
 y64+lHz7fXYhqLtSriNrx9mgPKx8qyB0lfephSOZrXcEearAXdBicEB1R+D/8HysOwVn
 WFx6hfHSkICJUBMu4c3Q9+t5jqYp/pvGllyhKHPJdagx3J8vHdr1xh0K9gv5ndZccrRi
 6SVSVnFO4oP+b30m269W98xmBpWQfgxeOAL/1VT0pPeMuUVl+haDck0yd4UEozTrHECg
 sDddFGF3zZYa3rUx3UcrC5uQdz1Ww5qRE6YUAJnN2qfGsdEaxx2d/cbwlMDSgb+PO6Lj
 5cjw==
X-Gm-Message-State: AOJu0YxRFHQtMhup08dWpp6cC+VAtxUM8xr1v4jpPpB8LhL7p9/KljJF
 sJQ0rgKvKOHr2XrNMmC9m7YlnyKdwbqv6m53cGAm/aOwapdcJ5vw3EHc4BNBUUMa1PTEcru+HGe
 v
X-Google-Smtp-Source: AGHT+IGX/R0PlRJHHkBXxnJfkSw9pW+z06Uj7kUzz6DKjutv7SFFqek0zlYM8/LmENQTtQX0ywm1zg==
X-Received: by 2002:a05:6a00:4653:b0:6f0:b81f:af61 with SMTP id
 kp19-20020a056a00465300b006f0b81faf61mr4841344pfb.5.1713990272413; 
 Wed, 24 Apr 2024 13:24:32 -0700 (PDT)
Received: from grind.. ([191.255.35.121]) by smtp.gmail.com with ESMTPSA id
 fm8-20020a056a002f8800b006ed059cdf02sm11862015pfb.116.2024.04.24.13.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 13:24:31 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 thuth@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 mjt@tls.msk.ru, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] riscv,kvm: remove another strerrorname_np()
Date: Wed, 24 Apr 2024 17:24:23 -0300
Message-ID: <20240424202425.534338-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42d.google.com
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

In this new version a small change suggested by Phil was made in patch
2. No other changes made.

Note: checkpatch.pl is nagging quite a bit about the checkpatch.pl change
this time, claiming that I'm adding a line > 90 chars when in reality the
line has 80 chars:

ERROR: line over 90 characters
#39: FILE: scripts/checkpatch.pl:3082:
+			ERROR("use strerror() instead of strerrorname_np()\n" . $herecurr);

total: 1 errors, 0 warnings, 9 lines checked

I supposed it's counting each TAB as more than one char. Let me know if
I need to care about this error and I'll send a v3.


Changes from v1:
- patch 2:
  - move the strerrorname_np() check to the "non-portable libc calls"
    section
- v1 link: https://lore.kernel.org/qemu-riscv/20240424094700.453356-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  target/riscv/kvm: remove sneaky strerrorname_np() instance
  checkpatch.pl: forbid strerrorname_np()

 scripts/checkpatch.pl      | 3 +++
 target/riscv/kvm/kvm-cpu.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.44.0


