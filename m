Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0711FC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 21:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reiTU-0003zg-23; Mon, 26 Feb 2024 16:25:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reiTN-0003z4-PP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:25:18 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reiTF-0002Am-SD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:25:17 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56533e30887so3884279a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 13:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708982708; x=1709587508; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bQRQ0XH65pU8LNMR6pUZZg2xwkLvwO3/j0KVncA7cF0=;
 b=fpbgbQEaU6CNF3v3Tp6dlk7NImhkSNC8oX+qA11zjDld0mvdIyoeMBet87n/KfYG1S
 7wzf4A9h1Q98XzrkBEllHd3mCm95s5oyS4py4dSh/IpxBwm8/8UtewfjTVv4klcK0kz3
 2q3GEZ8HWWE40QKbGbWCQYnQgNCILoF7eWBVqLA0ett9RvyvC6DEhJEU1RBZ4iDTplyP
 Fw0fry2ho/UwLpmq+WdzxOSXbGs5Ow+AbsM2O24EaD+LojXZjppC04JFaWspH1uXEBXY
 0paWHJ4zTufMkKrfcjHQRymexKex56yFM9rK9hEp0rY/CTgyu1d33u1neKXC6kR3UvZR
 1GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708982708; x=1709587508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bQRQ0XH65pU8LNMR6pUZZg2xwkLvwO3/j0KVncA7cF0=;
 b=Ly3Tc/rsUJvziZw/27S9l+RuxpmqQ/1yBC7t2tJe1mfU+tO0R5zrxKMW9IzgPP3p2h
 UeQF4zaVZ+sMzrTMGL0gwWv2pOo8O5VhEcaalCjLRk62EaD0oNHhg5m64MPHnrVTFX44
 gF6EKVnc12T5ndp1GXa7LtKlQBIC193TxLGefzBumoKW2MU3OtWJPteBhX336cy0lRBU
 N7n4lm/pT0DFurXcvZlaj/A+AdrbLl+ExGefgD3EN2EySayUF8Q7HbbJnnbzT/1zFe4F
 V7fDYD/kruEJssMtJ5v7JCI3xuRRgHUyydQFx0Xzn0Bl9qczoudcL+bM+CM6hZHZzsBJ
 2QHA==
X-Gm-Message-State: AOJu0YwrGM0FQg++jY6upAYuqZS7FilsdX7/qyZX3xqP2BwBrRgthZL+
 C6sT5lDxBXgtDKyNycgL+xcZ8Ysi9gi43cobpQp4RkfK5LI+z5fAMZnrJKohLX9zXd9QSGxlX++
 pMVf71nTXMGVCwdNQSZQVMlIO/tZWptWHyQHvXA==
X-Google-Smtp-Source: AGHT+IHpRO4A/Kw57w5STsE3Tv7+qBT5QthPXirZ29ieBxht7DLwiP5UZs2kRyE29ijPyV/mHgZcFh4U86EQVscW+4k=
X-Received: by 2002:a05:6402:1c82:b0:565:9892:a74e with SMTP id
 cy2-20020a0564021c8200b005659892a74emr4478196edb.21.1708982708180; Mon, 26
 Feb 2024 13:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20240219200908.49551-1-arnaud.minier@telecom-paris.fr>
 <20240219200908.49551-2-arnaud.minier@telecom-paris.fr>
 <CAFEAcA_LZ6oGj_y+_9zKDZNVSk8zOb4hQG+OKETXyE3-ezP_Rg@mail.gmail.com>
 <1459219120.11729362.1708975293687.JavaMail.zimbra@enst.fr>
In-Reply-To: <1459219120.11729362.1708975293687.JavaMail.zimbra@enst.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 21:24:56 +0000
Message-ID: <CAFEAcA-BtQ2d+UE6menpHoBaEwe1gA_gN=fatoXg6MsBeRBQaw@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] Implement STM32L4x5_RCC skeleton
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 qemu-arm <qemu-arm@nongnu.org>, 
 Alistair Francis <alistair@alistair23.me>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Feb 2024 at 19:21, Arnaud Minier
<arnaud.minier@telecom-paris.fr> wrote:
> > From: "Peter Maydell"
> >> +static const MemoryRegionOps stm32l4x5_rcc_ops = {
> >> +    .read = stm32l4x5_rcc_read,
> >> +    .write = stm32l4x5_rcc_write,
> >> +    .endianness = DEVICE_NATIVE_ENDIAN,
> >> +    .valid = {
> >> +        .max_access_size = 4,
> >> +        .unaligned = false
> >> +    },
> >> +};
> >
> > What's the .valid.min_access_size ?
> > Do we need to set the .impl max/min access size here too ?
>
> I honestly don't really understand the differences between .valid and .impl.
> However, since all the code assumes that 4-byte accesses are made,
> I think we can set all these values to 4 for now.

.valid is "what is the guest allowed to do?". If the guest tries
something not permitted by the .valid settings, it gets a transaction
failure instead, which then becomes a bus fault or whatever the
architectural equivalent is.

.impl is "what does my device code implement?". If the guest tries
something that is permitted by .valid but not within the bounds
specified by .impl, the core memory subsystem will try to synthesise
it (eg handling a guest word write by doing 4 byte writes to the
device write function, if a 4-byte write is permitted by .valid
but .impl only permits 1 byte writes).

thanks
-- PMM

