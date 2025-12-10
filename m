Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A70FD2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 05:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTCef-0000GU-AW; Wed, 10 Dec 2025 00:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTCeY-0000Fq-RS
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 00:22:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vTCeW-0006oF-9g
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 00:22:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47755de027eso44231895e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 21:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765344133; x=1765948933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ozKqbnq0g7re3gbXMTPyVxC4GGOAO0PNhUA0d4T7pF4=;
 b=vii16PI7j1at+VEs+gDH5Z3A2Hj4orINtqoyoq7IV7mwC1PYFU6MztOifi7drMdXUg
 2mvMShG5fhOIP6UbFZU/xcUlGkNQGFwV9J28GGuVfdukXELbV6xQDeYMV6+Rd3qOtpa8
 Z9nlFT1s1qwWFspJHFVdvdfo/rTkbX0tk3f9JO0QzVzT8yxvMJ/es4BgaxNJsEJmp+4r
 xoOtZsF+tXRsEkhmy0ouAQs0Hrpt/2XWUi647Im+w9lqoJfBU7gmd/djjbQqilfYo2hz
 LUSbvhKk5wMSO6W4r5T6TtUdpSfjL+2kWu8cHsc5s5rc1aMft/4KP6RqU6UW6MsKWNIW
 OWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765344133; x=1765948933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozKqbnq0g7re3gbXMTPyVxC4GGOAO0PNhUA0d4T7pF4=;
 b=RwU5jxKHORTEKF4GMe3R+xzvQZwVigfZHASBUUg/+FA2R/53Lcu8XwjMWDV3XKK1TR
 jDBNQ+uIfrsSseRNVWaL1k6gRrP4uFZx+nwuEvtQdeyTdRl1C4Dcvhl/27nasF0LRacA
 Iy6E7KRRUw3b+fILw8URuY2hQ/JP9rlhW3/POLJdsEr+qWjNzPsw0535NhRqOYDpTsye
 +Zo213sfCkqlzn54vkTS2VDdE6PFnt7EHYm30/7Y+qT0dIIk3ENBZHTQeVYp7L6RLw7G
 kKIauasaSfJncBQjqz2ExOJVwXmMX3lcla2arYZa+Nuog5NO91MJkR19faFhEwIisB+x
 k98Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuFnKfbWIIJXAjBGL0YL1GvtzbmBxdXsbEebG/3kTUtnHES6EGnb0QTCREVOIyiPwxihn59A/kXE1Q@nongnu.org
X-Gm-Message-State: AOJu0YwMRfD9GdMGTuRRxYqB/CBgb5Mvm9RkI3aNdEjl3IUMdh7JGWiO
 qUOoVfIY/alcrhZnr6esqhI7h4Ql4bhJ/mLQZsulUULnZhfl9uTQ50pxgckfazqfMrQ=
X-Gm-Gg: AY/fxX5LMPBFTzS5bWL7IPQ1lzGrSaOnbPUh1OAYp+viAAFxktgb72nYODFXLZHzdcK
 PpwMn9BjAdscci00Fp+jElIBdviTveTSZ5fwXEFMC5Oi96Px8kqzl8wENWcaR6z4/8lsh0fBrfS
 vKzj8TDOEPEyqRLQd/cHioReoMrH0nLjxyVrXdUYcf0D3TX5FL0sS1ItDonUBOpy30FD4lZ0kja
 4lqxedtcHrnmVnr0jhjGDAUCl+XJUKHCtR56i2ucW8ny8S3X6HtmhT1q6P0ELSeSKqe79p832nc
 zwD+btaJpgMzJfOQOk0dd/o56Cg6fDbLZYSPfXVb/nIFN+QTSEAeFSkT1KAuY8n50FdhPCZmWrk
 VYayAjMBzlEi9KmhW8aaCzQUA4aadsU6CiyjBIIHWZ/v5rZouSepNt/cCH7OQ/gdZx7zkAyajA7
 v/Dc6A9Nw4NTMHlvfW9Nz2rwRli52rCsZFCmgzkLmNt8xp4F3ymla9LSNFOfFHXpPI
X-Google-Smtp-Source: AGHT+IFz29OFOYbicvoV+XQyy2CR0FbdmdlopqORQ3AAFZE2FTH+IJdxSsYb5Mefm8am2cymYS48bw==
X-Received: by 2002:adf:fa49:0:b0:42b:3455:e4a4 with SMTP id
 ffacd0b85a97d-42fa3afe634mr681165f8f.31.1765344132880; 
 Tue, 09 Dec 2025 21:22:12 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226c5sm35824228f8f.23.2025.12.09.21.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 21:22:12 -0800 (PST)
Message-ID: <59727ca7-9f17-4688-8212-9c37271af41b@linaro.org>
Date: Wed, 10 Dec 2025 06:22:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Joel Stanley <joel@jms.id.au>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <CACPK8XexaTREY3Y-jp8urTAE+UmQWgygFx1MAss9KcJw5tGMtw@mail.gmail.com>
 <CAMuHMdWF_OwTMZZ=joRsnOAuB5UuKjACt3Ku4-o0--fR6xqQbQ@mail.gmail.com>
 <YpkWllpTFzb2HHY5@antec>
 <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
 <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
 <Yp8epZsizfKMEVZV@antec>
 <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
 <Yp9Al1UfqvIzStI7@antec>
 <CAK8P3a13PTsMExyXZm5sZM3WBK-8hoNFjYoi19pHmKKCJQmHeA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAK8P3a13PTsMExyXZm5sZM3WBK-8hoNFjYoi19pHmKKCJQmHeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/6/22 16:08, Arnd Bergmann wrote:
> On Tue, Jun 7, 2022 at 2:12 PM Stafford Horne <shorne@gmail.com> wrote:
>> On Tue, Jun 07, 2022 at 11:43:08AM +0100, Peter Maydell wrote:
>>
>> However, in a followup mail from Laurent we see:
>>
>>    https://lore.kernel.org/lkml/cb884368-0226-e913-80d2-62d2b7b2e761@vivier.eu/
>>
>>    The reference document[1] doesn't define the endianness of goldfish.
>>
>>    [1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
>>
>>
>> The documentation does not clearly specify it.  So maybe maybe or1k should just
>> be updated on the linux side and add gf_ioread32/gf_iowrite32 big-endian
>> accessors.
> 
> I don't think it makes any sense to use big-endian for a new
> architecture, just use
> the default little-endian implementation on the linux side, and change
> the qemu code
> to have the backward-compatibility hack for m68k while using big-endian for
> the rest.

Hitting this thread 3 years latter, suffering with endiannes. Sigh.

Back to OpenRISC virt machine, it is unfortunate it picked the
TYPE_SIFIVE_TEST virtual device (expected to be little-endian)
instead of the TYPE_VIRT_CTRL one (expected to be big-endian,
like OpenRISC).

Fortunately (to me) OpenRISC virt machine exposes the TYPE_SIFIVE_TEST
virtual device via device tree, and make its endianness explicitly to
little order.

Stafford, is it too late to use the TYPE_VIRT_CTRL? We could map it
as a secondary reset device at another address, deprecate the use of
the mapped SIFIVE_TEST then remove it.

