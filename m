Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CEC4345F
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2024 15:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3HU6-00021S-0r; Sat, 04 May 2024 11:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU3-00020q-UM
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:32 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s3HU2-0006E4-88
 for qemu-devel@nongnu.org; Sat, 04 May 2024 11:39:31 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5e4f79007ffso432836a12.2
 for <qemu-devel@nongnu.org>; Sat, 04 May 2024 08:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714837168; x=1715441968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XK2Cj8Ymf/hnOrcTtUAYtfoPm3ZJ2mNc+NDvIX21uzc=;
 b=PN+3kOL44KuvX04UNFBzEoFZQiECvCad8MBRAkpTA42+WCf/9D47jbwkq18FsWK07R
 wVHdGGOsHg8xDAWN0bahCBh3qV4wxUhBhtATYEPhsrVa3nA2olxXDhfv4z0GjCMIOUlQ
 jJlhz+buChC/n6Cf7Nuuy2zLzKGMJu/V1rMaR6waOfB6wJyEjv5lIUjN5wCq+JVhRzJC
 eD2RT5dzwgdbg+lueaIN8qNrm0eKQ/4V2Me1dvedLwilEeC0I20kHVSc4cQ0S8KtTcLu
 3AfZftkTfiRet9haKCVHKOuRYzbvsmqgiIx/OQPPRI7K3NMfpWzK6lnobsmo75V5hkEn
 SJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714837168; x=1715441968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XK2Cj8Ymf/hnOrcTtUAYtfoPm3ZJ2mNc+NDvIX21uzc=;
 b=j2slewPUZeQS0iq25CCDy5i7+u8furuXqZeVVte03emQw60r0KIWeBLA9g9p5ZdmH2
 EzmmS6zp4QjzsWc0egeK9m3ZaB/JyLzXGGcCM4DCqjR1e288bQps6SrAgyfdA4uCjI23
 N0d4FLNTYD5i9IlFH4ueNIgc9EU1Lc5ghoBnEaFfC6HUqwnPr2V4zdkm6pdHgRcUqAmk
 7iicN//o0sOt05pqT4TFMiAggsC5Oao5+90xLpct2OSvwRWSezGumMQE2TLJGY73titp
 MIKEkT3qvGX+EM85e6ldR5yxkenckZGk1vb4tmpmomNY5xfEPvbhfBCb7IpX3qe2YYCB
 NV6A==
X-Gm-Message-State: AOJu0YwohfBxIIp+JQVxBqSugSH0PvjF2YLCZxUiMcustzo935azd7d8
 w9bc1u1fmUmM9CcEnLqDGIU3pYhIF5JoDCi/WH5azPZvxxVPZTojKtM8OAnqE/qNZ7teBTEagNE
 d
X-Google-Smtp-Source: AGHT+IGkxUHZ2zEmBYmbvtACMX97vravFWcJEqeGIQTC67nKxOZLXviCI3lGwRAEE0MU0qICoOIw9g==
X-Received: by 2002:a17:902:d482:b0:1e2:d4da:6c72 with SMTP id
 c2-20020a170902d48200b001e2d4da6c72mr8632704plg.0.1714837168115; 
 Sat, 04 May 2024 08:39:28 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a170902e54f00b001e4d22f828fsm5197859plf.33.2024.05.04.08.39.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 May 2024 08:39:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] target/alpha: Implement CF_PCREL
Date: Sat,  4 May 2024 08:39:17 -0700
Message-Id: <20240504153926.357845-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

The following changes since commit 97c872276d147c882296f5da245bd8432f1582f6:

  Merge tag 'accel-sh4-ui-20240503' of https://github.com/philmd/qemu into staging (2024-05-03 14:42:50 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-axp-20240504

for you to fetch changes up to 23bb086350c0de390f77dd034d775742314cabd7:

  target/alpha: Implement CF_PCREL (2024-05-04 08:05:51 -0700)

----------------------------------------------------------------
target/alpha: Implement CF_PCREL

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      target/alpha: Simplify gen_bcond_internal()

Richard Henderson (8):
      target/alpha: Use cpu_env in preference to ALPHA_CPU
      target/alpha: Hoist branch shift to initial decode
      target/alpha: Use DISAS_NEXT definition instead of magic '0' value
      target/alpha: Inline DISAS_PC_UPDATED and return DISAS_NORETURN
      target/alpha: Return DISAS_NORETURN once
      target/alpha: Split out gen_goto_tb
      target/alpha: Split out gen_pc_disp
      target/alpha: Implement CF_PCREL

 target/alpha/cpu.c       |  32 ++++++++++---
 target/alpha/helper.c    |   8 ++--
 target/alpha/translate.c | 117 +++++++++++++++++++++++++----------------------
 3 files changed, 91 insertions(+), 66 deletions(-)

