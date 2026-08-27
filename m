Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF256C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXU8-00053h-1Q; Thu, 27 Aug 2026 06:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wzXU6-00052v-5y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:37:26 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephensportia@gmail.com>)
 id 1wzXU4-0006Rx-8x
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:37:25 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4a475409044so1150201b6e.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 03:37:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787827043; cv=none;
 d=google.com; s=arc-20260327;
 b=HVPMlukyzNcbZ+0KtPEQU/rWsFuQYIxeXCLNKPjjR3zlzI8gVBaOHqur6apcxgvZtR
 EvSNjJMzuB7v4Ifo1KxTo/5ReuzhtHYQC0taImWsOOfkpIdcyYfPU3nsOgH+yyoZdKUi
 YEYqUPXVUOji7VOykbNJ9tbBAEYoQZAcVoSrtWtSeV5wawKxnwOWtFbk8TShkkxaPa3r
 EwUDdccFO50fyiq51bC0qVMf9RAExPUza1JekImQhGrrAlS9QUSRx6uxjHVfFylthAr+
 lMOIrfKANQQ9dR8ARI/rPp0CtIQBeyxrCh8TQLuFXlsVS7vMzmKakapHEn0tfsugKyRY
 sLvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+049ShgHyUj99nuL783HWpFvu79K2tvNuriDgzPsxd8=;
 fh=9ysVbe5KS4Lhzj0G7Qybi58mU7ICweieEe8Mn1OfeYU=;
 b=phavYVMQkZzMmny/hCHiJlmMPHBqbK93BZSItJIShvjy+gzT6YwdQwxt/oVsT+06xm
 cm3CnCcMYBMIIbzR9UCTxVKrOusyVXpZ4ot7HgetmeCJ7RuRpxYJKpQ3RFRdHtW9cjqR
 u41xRZcND7qALgDCyZZGVYG73SKhOhok7FjOjjNlAG3ARDwTzbKG7UgqGoOjnPe+ro8e
 ZmCF1JIY3o4X36YFG6Qc037lqHCzCOjXHGo6lEqP+sbzTUc25AZSvThzabQkBdDSLRSm
 EYD6IP+Lx2Olv7K3n7hhZtf711TVUKhgLyIr0u6QbSuA8HJCICIsXN0Va8QSFyUAeU4S
 2YqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787827043; x=1788431843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+049ShgHyUj99nuL783HWpFvu79K2tvNuriDgzPsxd8=;
 b=KyhT5U1Ts8ocXjE+BqLyx1A4l6ngFIxXoIAyHM6K8A7BA85j1qzCsfVp7RjjOVXwzv
 TJHrWwS0OIS6jhYfs+0v78eGoY/04b4Rr6DnKx8rzw/voD8CH0w3kdSzCg7lnEF2W8ux
 IA0LhN219Bmrh0KrCrpXj+Zo4J8OuUtJfDWcAKUxxbfqqF3idFT4dXXkWBewaqrZlQSg
 hlMLKpQGOx3eJbTKq/AEpoyYD3fMNxQDZW59Gxzog5di7Xb+lOhkukGOv7wn7NYtpTIi
 CT6r4jbjhBhhtYJDVNDh+pndwTpsMPcLjcBI+qyWdPF3yzmLT7RpZhT76DV3aq8SerDE
 Xnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787827043; x=1788431843;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+049ShgHyUj99nuL783HWpFvu79K2tvNuriDgzPsxd8=;
 b=LgIdvAku0UIZHS/ZAwi0gxxOSkI5Q8R+wheHEVaT6tq+7h6JrPW1lgaAgQxIsLlpt6
 vmuDa+qgkokzIRN0V/uVOslPzi7BAvivsXSF6FOuxfn9+4Mn2+odEAquJ8mnnK2Ialy9
 pqXx8Y3/Ckt5j0XvwOYH30Q3gppMSI4YLbBvv8wLobzFJQ96hMtrRJb+QKwcUwuUMlkh
 G64OitDiCv+h11NaCxekFu/7xAOMyTug1EeCCzbsTkozuU5Yn81IDga13qvRImIsIXUR
 KIcI/uE7eGlk7ZGZkLJYfE5u8LrDLB5/GeXy9XRZnoDx/igrQgBi0vbp2YHptzESKJVh
 NZFQ==
X-Gm-Message-State: AFuF++mn+tkqRyhkhMj8Cfe0JGq+mZRFoBVmwxLFQDu45EgCbxxYMWFK
 8hIiAmTCKXV1bdQXLiZwgTn7XSoSbRTf8CkMOxbOWbh3yGlT+IR8/j1fnBVCt/oaTsnPzUsXjHH
 XidSfvYChgQszb7noypAsYts+iN2h5kQ=
X-Gm-Gg: AR+sD1073BHx/o6wQs2uaSYXhQ6aH7Q3k5xB9mHEKY+V+Csbl1UCvuu8VcsSC0r3uLv
 5VBi3Rs/i3144V+1lNxJGlJDK1mkj5lxwUIuc4XfOBv92MPjrbODRYukPTQsIpGurBPzsEhYwhX
 qnUMkWxPSVZb7YIFAMdC3GjaySCvYuvr8x33M/1WdMRJ6JQQFG+7wEw1sKYAwWq/8nqCWaLt2IX
 896de+TKHJ0EBB/sbKRz2lpkVYSROOu6fb1aF08DuZ3T4TaE+5k2d7xhhxvmdu+QqvXdfu9hqT8
 HBZ8vhARvOmbUuVlDwa6jsMplkDYjdwy/pxSze7KOrGDmpnSEl8JY9xFqL8m1xYia1P4AnzhsDk
 qJwB9q92+
X-Received: by 2002:a05:6808:1910:b0:4b3:880a:f08e with SMTP id
 5614622812f47-4b3880b1abcmr2250536b6e.13.1787827042685; Thu, 27 Aug 2026
 03:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260825040452.1322251-1-stephensportia@gmail.com>
 <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
In-Reply-To: <CAFEAcA9etHvjL1igO4mFy5iQNy1pCbNFGaSg5HFva+YCeMkGEA@mail.gmail.com>
From: Portia Stephens <stephensportia@gmail.com>
Date: Thu, 27 Aug 2026 20:37:10 +1000
X-Gm-Features: AcwNN1XcfRUbsldtwVE7ZLjcGTDazu0Fo4Mo2swVpAOsooTm6tjhILuszIFYo_I
Message-ID: <CACYNXwKU_UuhrBWHNFtYYmSfzRsUd5jRFjSc1++xvQHxPk6rew@mail.gmail.com>
Subject: Re: [PATCH 0/4] Rename ssi_transfer to ssi_transfer8
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, 
 Troy Lee <leetroy@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-arm@nongnu.org, 
 Tyrone Ting <kfting@nuvoton.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, Joel Stanley <joel@jms.id.au>,
 Hao Wu <wuhaotsh@google.com>, Glenn Miles <milesg@linux.ibm.com>,
 qemu-riscv@nongnu.org, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Portia Stephens <portias@oss.tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=stephensportia@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 27, 2026 at 7:19=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Tue, 25 Aug 2026 at 05:05, <stephensportia@gmail.com> wrote:
> >
> > From: Portia Stephens <portias@oss.tenstorrent.com>
> >
> > The ssi_transfer function comments say that it takes a word varying
> > between 8-bits and 32-bits. ssi_transfer takes a 32-bit arg to transfer
> > but there is no means to indicate the number of bits that should
> > actually be transferred. All child classes of SSI_PERIPHERAL class have
> > transfer functions that, despite accepting a 32-bit tx, only transfer a
> > single byte; m25p80_transfer8(), ssi_sd_transfer(), ssd0323_transfer().
> >
> > The current implementation depends on the SSI model to know
> > what peripheral model will be attached and what transfer size it
> > expects which is error prone. If a SSI_PERIPHERAL model was written tha=
t
> > accepted 32-bit transfers, it could not attach to any existing SSI
> > models.
>
> What is the motivation for this change?

The motivation came from reviewing the designware ssi driver [1] and
realizing how error prone it was. The designware ssi supports varying
frame width but there is no way for the controller logic to know what
the transfer size an attached device expects. It seems like all the
code, that is actually connected to devices, is just written to expect
8-bit transfers so it should be made explicit.

https://www.mail-archive.com/qemu-devel@nongnu.org/msg1218153.html

>
> As far as I know for the hardware SSI protocol, it is indeed
> the case that the SSI controller (and/or the guest software) needs
> to know what transfer size the attached device expects: the
> controller just transmits (or expects to receive) however many
> bits it is programmed for.

This is true but do the devices currently model only support 8-bit
transfers in hardware, do they not support multiframe transfer? SPI
supports varying framewidth but the devices are not actually modeled
in this way.

A better solution may be to have multiple transfer functions,
ssi_transfer8, ssi_transfer32, etc. This would require the device to
explicitly set what it is expecting. It is challenging since the only
model's not using 8-bit transfer don't have any devices connected
upstream so testing is challenging.

>
> > This change updates the the naming of ssi_transfer to ssi_transfer8, as
> > well as changes the return value and transmit argument to be 8-bit.
>
> This means that the API will no longer work for a controller
> and device that aren't 8-bit. We happen not to have any of those
> devices today, but why specifically stop them working?
>
> thanks
> -- PMM

