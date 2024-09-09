Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54051ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 02:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snTuF-0006Yh-6l; Sun, 08 Sep 2024 22:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuD-0006XH-Tw; Sun, 08 Sep 2024 22:13:29 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snTuC-0001M7-AF; Sun, 08 Sep 2024 22:13:29 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7c3ebba7fbbso3101912a12.1; 
 Sun, 08 Sep 2024 19:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725848006; x=1726452806; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KLRsgiRq2dHxcCBQwd2sfMREwdz6qo7HJN6nu36C3qk=;
 b=ZIMD6DSIDlsZuW2+oR4+ewu8xriamq/lMqE6O1Qqc9wXYtkS5H/Xotg3kDB0tayxX6
 H12j3wRcTVB/1TfPctyFmFH16pclim9R5S1eLWtr4hVqHdcignWZCboLQCxmxi2ZB+08
 WDq/KA4Sbu3ornufHC8IbWtJIsLcizsAiDioYZHHjH+LY7Drn87Cl/+qmUCgce6+kYcb
 bOEtYKxhtrsqcwpLetvLBceooQhW0lT/jmIYvYzGdqoNApUffYDeMpOFwojK7vCsLMVH
 qWqHPlOUf4W0r0nQ7Wxh4SnFfKC7YJoP316EDmbpFvYtqbJ1uIPOMz84u6sW4Tk9enKg
 pH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725848006; x=1726452806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLRsgiRq2dHxcCBQwd2sfMREwdz6qo7HJN6nu36C3qk=;
 b=FsHzhcH7Tt6r6i/vYRwGXtVR6aKrWcwC0K0mxrUWg6iYJWvbDoY6FdVIRmJwmvDpTj
 LvKoOz8Sei/VPMvNSaiGAxwxcYSNB3v2m1jyTD0ukn1T7fZHCfufwPmmV3ksdnDzxd54
 VFPNxIUeOnqvk2cIl5mmMx4GuuQAfAg9AR3+HoguaTc97ZZmixFpUVWiM768UVrP2220
 5SCZI1LYZ6utUPEQeX/NGTyxnXQM2b5G8J4HyKa2QqTE3CDNuzyStIAgaRBP7p1dkoc9
 wo56AukguamifzJ/MHnPOr5/P6tWP5kL5rbHCAawdUqpwOQ5H+oHQLThN7GfXmBHmWgj
 KfqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn0JkZm/7LCRXM24z+zSsiNefF2BjseswKtNMAjblCgbZTXluGKhJlqjuzAbqVYpeJPp87RpH5/WoAUA==@nongnu.org,
 AJvYcCWxT6YIqqznAIPyjRJW806AqawgrXsH3mMqd2zy3cxAdhE02TMpV70j1kv0blt/6lgZjyUN26BPSV4O@nongnu.org
X-Gm-Message-State: AOJu0YwzEs3rGX3yKXpiy7nS+8brrIGDug4n3JleSAEQPfJ81acDYDkB
 pzqOsPJCToQZ4EQKQHinZZP3cx3iGnFdHNKzT3jKXrwBQtFmDc3Hx1KLd8uJ
X-Google-Smtp-Source: AGHT+IEAonjt5Dw8LC1OxFX0fNTpNX34+U+WViObGTBdkYD8a0BMmsGsiqx8qTM02s0WTTZypvyZAg==
X-Received: by 2002:a05:6a20:c797:b0:1cf:3e99:d7b3 with SMTP id
 adf61e73a8af0-1cf3e99da15mr3003654637.2.1725848006239; 
 Sun, 08 Sep 2024 19:13:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58c68d3sm2528155b3a.84.2024.09.08.19.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Sep 2024 19:13:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.bennee@linaro.org,
	qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: dbarboza@ventanamicro.com, palmer@dabbelt.com,
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com,
 Bin Meng <bmeng.cn@gmail.com>, liwei1518@gmail.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 atishp@rivosinc.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 0/2] riscv: char: Avoid dropped charecters
Date: Mon,  9 Sep 2024 12:13:15 +1000
Message-ID: <20240909021317.58192-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This series fixes: https://gitlab.com/qemu-project/qemu/-/issues/2114

This converts the RISC-V charecter device callers of qemu_chr_fe_write()
to either use qemu_chr_fe_write_all() or to call qemu_chr_fe_write() async
and act on the return value.

v3:
 - Fixup spelling
v2:
 - Use Fifo8 for the Sifive UART instead of a custom FIFO

Alistair Francis (2):
  hw/char: riscv_htif: Use blocking qemu_chr_fe_write_all
  hw/char: sifive_uart: Print uart characters async

 include/hw/char/sifive_uart.h | 17 ++++++-
 hw/char/riscv_htif.c          | 12 ++++-
 hw/char/sifive_uart.c         | 88 +++++++++++++++++++++++++++++++++--
 3 files changed, 109 insertions(+), 8 deletions(-)

-- 
2.46.0


