Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBDC109E543
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5bci-0005FA-Im; Wed, 25 Mar 2026 23:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w5bcf-0005Eb-Ok
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:43:06 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1w5bce-0006vO-3O
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:43:05 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2b061b6cf36so3662335ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1774496582; x=1775101382; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=452EKNfUmA2G5TPGOc8X6iyAUGUmA/KlYJbm/Arbkuw=;
 b=AHXSIkym1KP/A1HBQhhbj7J1d94JdNzeJCIw1kCbFezqB9hzMp40recZyQjwcHYefZ
 36HfFI0oGdwcVEMUS30buZzOMCHOK2TTbkaro4U7gc5baLKX754sOgpAn9Tim7BKOYm4
 dYFuHE2nUP83hhXidpKTLgrzIeT6iTrynQsBk58KAENgku3qclrAcIUH4yjRHb90aIoJ
 Go2LivYPPlZo+qUtfQqCt85CslZFfCxpMScYGdnfFzswSjdh5K+PxWN33tX8rCBwXRQ3
 09eIQ7UK3QwjX1aRhMwUNs1uTxYwH1St7zsDFlk+z9CedM/WqS5G9d6l6i9xvXyPQrKH
 aHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774496582; x=1775101382;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=452EKNfUmA2G5TPGOc8X6iyAUGUmA/KlYJbm/Arbkuw=;
 b=N+2Pz34HVS+CmvZjA4xxCsBs14Qh/IB5pWlg1m42zQf+ba5mTGB/7ZtNJ4TI7B7Jwn
 7rNvG6RYv26NHRrCUjSwbpocCmN8ulavkJBH1O7nLdWkxiogv0xanLuMLJWTT0TNxmRK
 HNRcPhH0pbfH0BHd2aTGFK3j5Oc88kJ6SxSB8GC994Jyye6DpbdpK+YDSC7VZHb4w9wr
 2NCqZX/fse8aEZCwVoXOAXAl4QOdorvEFhCfHYY/nY33PciRR1uUUBjPaqr4ICbLKbJc
 JSfo1UCOsZ/1ifeTmLlfh60wi/U/WLU3qE7BBhXpGAy7iDEbm7JsCsTp//DUyvr9gkWI
 RUOg==
X-Gm-Message-State: AOJu0Yx8U8dW8nRvEhCH8E+7sKlnVPi+mZOLFT5UmPWpKIhaEFWxzr1h
 uDNZPO7yMhPrPSbCJo2BnGlyt5kJXPWfGvEAWmR/NoM9aw8F/N6aHOH7TQXGdHxaHvQ=
X-Gm-Gg: ATEYQzwBQjcMLJqzmNVjPjPR5kQSmAMsp225tj7SGreT5vcN5btkkBdTvawrSgS63uc
 cgB85R12h6twqZmdko2XJhyuSzpBfani5Ld86vVaAzS4P5Thw0AGQQj6z3UgbHGLsJSCSerC1Ta
 WUT4teE3fWmkqkwBeRLaF+RI2E3ZXr3CXosRSshH49o2YaS0C/gnDrAsfLIrcQsQkgD5s2AoyPu
 07YxD8hAKj1rHKHT2HZlHlyj9wyKtcJypVMAByg5P/i92gPy88/WdFBaBPoZXrdLCuSiSjIybp0
 GMOwAH589iErVd5qwny8chjsNcM1E5CQGkR7dxi+Qwp4GNUJ4RXvqhONweBmbvCGnw2ZudVCLJc
 UgFfqBxxoWiyAZF7JYOG+iLBBngkAFZKaVi8MKcIdqWEFDChJfI+/WeDBoftnI6HMT8qKtCvR0q
 TT6faevjO7aI8DBiNfVpnSYO1uFDG0k3Qlct8t48Mc4grpNlQ5ZrSqHmXv27dylUF0
X-Received: by 2002:a17:902:e951:b0:2b0:665b:c7de with SMTP id
 d9443c01a7336-2b0b0aef15cmr66910895ad.40.1774496582057; 
 Wed, 25 Mar 2026 20:43:02 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8b5dcbsm13458225ad.57.2026.03.25.20.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 20:43:01 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:42:58 +0800
From: Max Chou <max.chou@sifive.com>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH v5 0/9] Add Zvfbfa extension support
Message-ID: <acSqxQQxnO0HdB8M@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <CAKmqyKP7VKi21xfMAiKi9nmAGaaNdrtH9u=6ktCbWBk7kiRoJA@mail.gmail.com>
 <abKfuTO7zg5d67E8@sifive.com>
 <CAKmqyKOcCKAb2w2t2qYgOevswst75FjzKfihrYP9+odRAsCQmw@mail.gmail.com>
 <abe80eiIC4gXUHxk@sifive.com>
 <CAKmqyKP-42diNbiAwr_qykVTAYgR=Ok2S4dgLwPN5oGuLTQGRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKP-42diNbiAwr_qykVTAYgR=Ok2S4dgLwPN5oGuLTQGRg@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62c.google.com
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

On 2026-03-19 13:45, Alistair Francis wrote:
> Yes, that's how things previously worked. Basically I think we just
> need a tag (that won't be changed) in an official RISC-V repo that we
> can point to. That way it's easy to say "this is the exact version we
> used to write the QEMU implementation". Then if there is a version 0.2
> we can easily see what has changed and update to match.
> 

Hi Alistair,

The official riscv-isa-manual repository has added a new tag for the
frozen Zvfbfa v0.9, as shown below:

https://github.com/riscv/riscv-isa-manual/releases/tag/zvfbfa-0.9

The current v5 implementation fully complies with this frozen
specification.

Since the Zvfbfa is frozen, should I prepare a v6 that removes the “x-“
prefix from the zvfbfa property and updates the specification reference
?

Thanks,
rnax

> With the seemingly infinite number of draft extensions we need
> something to manage the version and compatibility, and that seems like
> the best bet.
> 
> Posting the draft PDF spec somewhere immutable would also work. We
> just need to be able to point to something that won't change and
> represents some sort of "release". So a git commit doesn't seem like
> enough, we need a "release" that everyone can converge on.
> 
> Alistair

