Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722BDD3E79D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbiq-0008Ei-CR; Thu, 11 Dec 2025 03:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1vTbim-0008Dl-CT
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:08:20 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1vTbik-0008OR-9L
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:08:19 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso239556f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 00:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440497; x=1766045297; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OGTCYWCcesRs60jELqisOwCkzUhPgFTVNdAZ+HTwVSo=;
 b=a1Z8wPIEwQP5fMzIsyTDOFLue3qk/GQnUfYI4lYlNtYGmwidUoxDmugjuJ8JsYokr/
 sFr48e54dsoB7iATz7wW68DLtUn047GLvh3QrFPL9DHnx/E1oxHBc60RiBNk3Ba7M4v8
 Zz4St8nqDkJTgQ51y3qbkdKz9hLgTasYvCr1HuNdS2KGDJwP0LdlnjFPdF97NfyLDg3s
 Uk3sDPRKr0tMPeJ/gkJSRuP7V2V5W5PcNeo/ZwevxO3BnBamu5fHDJCIHgxrwUR+SlzC
 0EGUmwrNCFnb10nw8jpyGjPaObA8OcRQENTy7aeuwrwZy4y/obRztEO7vHMVyiCRCnVa
 /rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440497; x=1766045297;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OGTCYWCcesRs60jELqisOwCkzUhPgFTVNdAZ+HTwVSo=;
 b=LpTzBOBXcbwb7IgUcATuJBfhFBVIfbemJIs9itsLxkGqREwHqOvgWI9axT5DEIUSr5
 WIYIMpeccRP0yGFbMD8UhSE60KuwHfZeDXJT7fA40Wbi7S26ayF1qHxN+k7+jt2YDadB
 pgqtGUIHWk5gHywRk51adpKNhNcN39j7fWw+4eUza17+Gj8fZPfEYT4U+7oZGQe6jFQd
 2qCci2OzA+npBlVf1yEP8tUb0OVckdqyqJ+F+bggLd7KTEObHPpzxJu8HpMTZ3HSiUEJ
 tRh6gY7YglOjHctOPzTf3p1DpRqAX4s7LoMABL/BeLUGmRFb4vO9sdichbi32AJzjrBy
 c8Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE4Ry5iFAHLRSTZZVyggieATO4Zrf7EfGuNeEqRihQVOxB0Z1JFq65ABYfwjBBfEkYQengx95v/j2s@nongnu.org
X-Gm-Message-State: AOJu0YwiEFX+XvGF5KFcRMWFdeVOpswql3uiqD3K2NIpch4uQFVZXOkr
 uG1n4wruyH85KEOILf0epuVuVysHUgGSXQbpkl7Zrc+vHB58vt9r6Yx7
X-Gm-Gg: AY/fxX6v/zB0wCvglLovaRFm0o7TkevmZHw1/IFBG13ecQUlAbxZlNLsr/JikIh69pG
 thcD/P0rixpaThI2kdk0qoVaCloGobqps2pismeGdmJYWQzF0yaZAN24JlXh6TqC7zsCmOEQnvx
 un6M1ERF3zLXJ33v8srhYfXXLBb9mclpXn24lt5iR3ARIIZy6ZYsZDxU8k0aT8Qf8ON5l0biHCy
 onuAPtrjndxpWba9YVpUnvKH1t6WTCiUb49CmrNHbryS5I+cf5dVAs3C/RsM+HN/AYKybQHos9p
 /bMdtOo3YXGPpGPWwZs8+n/3iYUkzAdNybTpDbE5uEWizDjkbLGhPAGS3nBpJKaOnQAtS8z8anD
 oqiRdmiRk0DQK1dO4RNIfZ9pJW77G2HubM24Bkh2IEII6aceniEzkWUIBe4xjmT4pQsZtm8Z8RZ
 9cdyxbM37NXEBtF6YkMVMJzgad2uft2z8zByq34+UzMyhcl74vXiz9NpdXtkRJVRiJ
X-Google-Smtp-Source: AGHT+IFngcIjyBV8gBCk1DPUw91JffraDPhY9iQfgYwI5mnvzKgsc9iCa9nC3MiTf2LjvbzN102/Og==
X-Received: by 2002:a05:6000:4285:b0:42b:2ac7:7942 with SMTP id
 ffacd0b85a97d-42fa39caa0dmr5960206f8f.5.1765440496421; 
 Thu, 11 Dec 2025 00:08:16 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b85f81sm4448039f8f.21.2025.12.11.00.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:08:15 -0800 (PST)
Date: Thu, 11 Dec 2025 08:08:14 +0000
From: Stafford Horne <shorne@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Maydell <peter.maydell@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Joel Stanley <joel@jms.id.au>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>,
 qemu-riscv <qemu-riscv@nongnu.org>
Subject: Re: [RFC PATCH 3/3] hw/openrisc: Add the OpenRISC virtual machine
Message-ID: <aTp77oJFaTFL4B70@antec>
References: <CAMuHMdXBtihLpdOYn7nj_fH2g08nDUiUd-_zCZ_EdEyvw1UxWA@mail.gmail.com>
 <YpwNtowUTxRbh2Uq@antec> <Ypxb/VDfYLFg3n2s@antec>
 <CAMuHMdVwAzbAOBDcv4y1WmYgCaFOMdywxUZvwMtDccOgDMN+mw@mail.gmail.com>
 <CAK8P3a3Vpn02uDe3rdXSNXANY=u4ZM+wjm-qqszTXzjOKkAeEg@mail.gmail.com>
 <Yp8epZsizfKMEVZV@antec>
 <CAFEAcA97oraa5OSdqmubmJ2-ONTCTF4ZszwfTcZ9VhqKRFhogA@mail.gmail.com>
 <Yp9Al1UfqvIzStI7@antec>
 <CAK8P3a13PTsMExyXZm5sZM3WBK-8hoNFjYoi19pHmKKCJQmHeA@mail.gmail.com>
 <59727ca7-9f17-4688-8212-9c37271af41b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59727ca7-9f17-4688-8212-9c37271af41b@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=shorne@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Dec 10, 2025 at 06:22:11AM +0100, Philippe Mathieu-Daudé wrote:
> On 7/6/22 16:08, Arnd Bergmann wrote:
> > On Tue, Jun 7, 2022 at 2:12 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Tue, Jun 07, 2022 at 11:43:08AM +0100, Peter Maydell wrote:
> > > 
> > > However, in a followup mail from Laurent we see:
> > > 
> > >    https://lore.kernel.org/lkml/cb884368-0226-e913-80d2-62d2b7b2e761@vivier.eu/
> > > 
> > >    The reference document[1] doesn't define the endianness of goldfish.
> > > 
> > >    [1] https://android.googlesource.com/platform/external/qemu/+/master/docs/GOLDFISH-VIRTUAL-HARDWARE.TXT
> > > 
> > > 
> > > The documentation does not clearly specify it.  So maybe maybe or1k should just
> > > be updated on the linux side and add gf_ioread32/gf_iowrite32 big-endian
> > > accessors.
> > 
> > I don't think it makes any sense to use big-endian for a new
> > architecture, just use
> > the default little-endian implementation on the linux side, and change
> > the qemu code
> > to have the backward-compatibility hack for m68k while using big-endian for
> > the rest.
> 
> Hitting this thread 3 years latter, suffering with endiannes. Sigh.

What is the issue this is causing?

> Back to OpenRISC virt machine, it is unfortunate it picked the
> TYPE_SIFIVE_TEST virtual device (expected to be little-endian)
> instead of the TYPE_VIRT_CTRL one (expected to be big-endian,
> like OpenRISC).
> 
> Fortunately (to me) OpenRISC virt machine exposes the TYPE_SIFIVE_TEST
> virtual device via device tree, and make its endianness explicitly to
> little order.
> 
> Stafford, is it too late to use the TYPE_VIRT_CTRL? We could map it
> as a secondary reset device at another address, deprecate the use of
> the mapped SIFIVE_TEST then remove it.

I think its ok to add a second device if that will help you.  But, it will take
time to deco the old device as people may be running old kernels, with old
device trees that expect the SIFIVE device for some time.

-Stafford

