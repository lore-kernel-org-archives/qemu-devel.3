Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A364BC27C5F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFZYu-0003Db-GC; Fri, 07 Jun 2024 09:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFZYs-0003Cy-Gw
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:23:18 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sFZYq-0000qZ-4g
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:23:18 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5751bcb3139so2369423a12.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717766594; x=1718371394; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hz7KIHgqQkoU8fxiYHqRc1uzz6uGe1LeWN0XDL9oCDA=;
 b=r7Bwj1yIM0b+CNU0Mra88myh3pH1Qx+Hxc+frhREPOkRv7/FMHBs5TL83KQVgKEZBd
 eyjM4xAh5RXH2jKZfsJTFhPKu8j21GfkNrtnHdOP6rkDdkFX1riHYNXtortcBACbvLjT
 0Ac8J8aq4LkGy5sttmvX2sXxyw70k3MurFPi/JBV79dbecn3sr9mTmDjLEzu8cEQ5k6W
 T5Dc3jnimXN+3aQ3e6g7rJ0OxY5Es8VLs/NqhIumFzil7jcJC4DjuMzILSMgM7COGKV9
 6RqBwz9kS817mEQSVrXiwzsWtjZE5raLyLJc3c8bX5AUi5AKOlNeCPftblkBoq/a7Uxy
 +Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717766594; x=1718371394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hz7KIHgqQkoU8fxiYHqRc1uzz6uGe1LeWN0XDL9oCDA=;
 b=Z3QznrhwsLa01bx8Jd0Qnn07xC5u37SsiRAPF/0daRNo27o37WErNUV9nlzHJw0Yh+
 VXJD5fVIrri85e5DhU05OX8BK2DkYkLq828rUcangVaqyAJ7TRIbYOjtBgBZ7WjYtqRy
 Mhw4T9SrD+hXsESKpxHUFwcz9Fb5TTclPxldZyaZEgozW2asH3LgbdBMtwAQFXxsFJBb
 AEo5HZAy3CxhgEbV1AdlqGApkf0+a3UdYhn6iZBlO1qqsKOVDAVqq+/vs6KssHo2zgmr
 yHhnLTVwxTcmgCKvHwFIuwx32xJEkCxTcESLikQV6b+uTggn3bkWKCBRpkjBNQHrcvMO
 KgSw==
X-Gm-Message-State: AOJu0Yz+yjZ4saMOgeLofQh5YaUXkiMpSKdK23O7ZR/2ACcEsz6/vLhQ
 uqtv119Q+AtfInramNc2/EJzErR8Sf8HAM5aI4YGnmPSlB+HBpCcxFRHfR4AM/KskdCG8BB5Mmo
 PiAhg3sijHzN9GfSqf/O9NJAlCJE8suLWla89pw==
X-Google-Smtp-Source: AGHT+IEe5YIkdqa839hK5lGB55YObRMQz82aI4z1iW5jJhtTdW+wiVFlSXyLZ4wPMFOePJrB8mEAocOsPY0F20lyNno=
X-Received: by 2002:a50:d541:0:b0:574:ebf4:f78c with SMTP id
 4fb4d7f45d1cf-57c5086e307mr1454036a12.7.1717766593768; Fri, 07 Jun 2024
 06:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240520232634.317988-1-dmamfmgm@gmail.com>
 <CAFEAcA8JFMid+SeHWuoaK9meVWwgch9wwzKmT4SFUXz4U_iacw@mail.gmail.com>
 <CACBuX0RaZyXZtmdSsF279UZnw_St8mgX_U284zZ+o0o4ziHypw@mail.gmail.com>
In-Reply-To: <CACBuX0RaZyXZtmdSsF279UZnw_St8mgX_U284zZ+o0o4ziHypw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2024 14:23:02 +0100
Message-ID: <CAFEAcA-xF=ko5xZ-KfquY_PBr3xXdnRrwp9JR01W7ko40_BFDQ@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-ohci: Fix ohci_service_td: accept valid TDs
To: Cord Amfmgm <dmamfmgm@gmail.com>
Cc: qemu-devel@nongnu.org, Philippe Mathieu-Daude <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 31 May 2024 at 19:16, Cord Amfmgm <dmamfmgm@gmail.com> wrote:
> On Fri, May 31, 2024 at 9:03=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>> What I would like to see is what we could classify under
>> "rationale", which is to say "what prompted us to make this
>> change?". In my experience it's important to record this
>> (including in the commit message). There are of course
>> many cases in QEMU's git history where we failed to do that,
>> but in general I think it's a good standard to meet. (I
>> am also erring on the side of caution in reviewing this
>> particular patch, because I don't know the relevant standards
>> or this bit of the code very well.)

> Thanks, in responding to that, I'm breaking down my responses into the fo=
llowing answers:
>
> Q1: (summarizing) What prompted us to make this change?
>
> A1: I'm summarizing what I wrote in previous emails and the commit messag=
e -
>
> * Bring qemu closer to actual hw with a neatly packaged test case to demo=
nstrate the behavior
> * I interpret the spec (Table 4-2) as saying the "be =3D cbp - 1" is vali=
d, in addition to setting "cbp =3D 0"
> * I interpret it that way due to a comment in an old linux kernel version=
 in the 2.x range, ohci-hcd.c file. It said (paraphrasing) some misbehaving=
 ohci controllers would fetch physical memory at 0 when cbp =3D 0 was in th=
e Transfer Descriptor

Interesting. Do you have a more specific version for that?
I had a look at various 2.x Linux OHCI drivers but they all seem to do
zero-length packets "by the spec" with CBP=3DBE=3D0. eg 2.6.39.4:
https://elixir.bootlin.com/linux/v2.6.39.4/source/drivers/usb/host/ohci-q.c=
#L539
and there's no hardware-quirk handling to do it differently on
some controllers. (The USB OHCI driver seems to have gone through
a couple of rewrites in the 2.x kernel timeframe; the earlier 2.3.51
version does the TD fill here:
https://elixir.bootlin.com/linux/2.3.51/source/drivers/usb/usb-ohci.c#L812
and again it handles zero length as BE=3DCBP=3D0.)

> But I only have a test case I created myself, and am not an expert on com=
puter history here. I think "be liberal in what you accept, by conservative=
 in what you send" applies when I don't know which historical OSes, if any,=
 need this behavior. I think the behavior of actual hardware weighs more he=
avily since that *is* available and testable. Are there additional checks t=
hat would expand on what's known about actual ohci hw?

The other side of the argument is "if in doubt and you don't
know of any concrete problem being caused, don't change
working code". If there are any historical OSes that rely on
being able to send zero packets with be=3Dcbp-1 for some nonzero
be, and anybody wants to run them on QEMU, then presumably they
can send us a bug report saying "XYZ's USB support doesn't work".
That nobody has ever does this is evidence on the side of
"there is no such OS out there, everybody writing an OHCI driver
read the spec and made their driver send zero length packets the
way the spec very clearly says you should". Please correct me
if I'm wrong, but my interpretation of your helpful explanation
above is that this is essentially a theoretical problem rather
than one that's caused you a problem you need to fix.

thanks
-- PMM

