Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2580CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQ7I-000752-W5; Tue, 16 Jun 2026 05:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQ7A-00074k-6d
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:29:49 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQ78-0001yk-GR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:29:47 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-660e9fe3c3aso2489831d50.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:29:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781602184; cv=none;
 d=google.com; s=arc-20240605;
 b=H6LaQUioo7N4WXtAr+wxnGCOHPxve7vc5ZYeOYTkT8DP50QGiRegK/pW93nzMEgocU
 Bj7D/7eyP8XY67k/+qEf6Vn/LfOKVBth0xcz+S6Uwg4V395+vK1Jg48oEHTi+pv14Agi
 W/K1exgrUfHVIwDJ/ITmtdwYC/MID12lSaWa8dt3azM6AIdIyawEUrJpkZ4piGgT11sv
 jHz5vIv/X60XUD4r0c9I53Qgqo4+hProUZNd1g1VXnNv+Sjy76d+7Mdm8ib1uYGFCeSK
 A73O+AOreXFRPhZ0ah5tNi9Jo5S9jQF68PCLFL7rEIUZMgwsN5Mxv/gnz/OcAEPZbCGB
 W8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W5Q8gKyZl8xg2qE5EZfjmZ+n/OlmXpc3F2Fzo8UG0hg=;
 fh=jGLXkZl6ML6kEgYzos72XNjqgVKSKEL6gFCA0DwKiVQ=;
 b=RnBJeFkGpkFThMkPbYQXQH7SHdtOEhIurF5N4lMmqoOXKOgdd5dHUzj1E6E420wbn2
 V/ILqNbCXLRgg9sB7Qb41p8FI4xziDSKiEGgmkua1erEJUk0Is5boxZHc3hSAGan7KDT
 xR5bffVzd0vSEyaUNL/TydpUSBXaLZEmWjvekLwrcisKjldv8mjjNSy8gJ57jcF9lFwo
 NdZKx4/70ZD5sgU5HicYicDVlM5lEAhSZHauPozZnJeKcquCe1Dl7L02GAmJkbPWIaaW
 rEYbenByIUv9OnNSiQ5HUGhzB074yebHFLiPsozROy2Msf9tl1XLRE7eVyfupVPZXrQM
 EiSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781602184; x=1782206984; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5Q8gKyZl8xg2qE5EZfjmZ+n/OlmXpc3F2Fzo8UG0hg=;
 b=gpBrJYuadsh9Jo0QmyqV76U9dAN7LYiIF00GWbNZN10xNQQxo8vXt6n6bJ2bg3Z81B
 z/MdR9RZmxcZBsSci6eE703ksdjOzCiVCNvsroSCWVmLObG7eZqsHe6OWfJsTQwd8UbQ
 ONxG0HLsTujhsg5BJMUfXP4czSWbWURkxdXpfSk/6/o+5GNrOqdcYKYhII9NxhKVt9dr
 mlRyCb+2y9q9ywJqnyT3UGxVksj3MXrNRyPbE7Q7VjO+IaI4OmBHI+26xDyQhgB0cOjD
 TQ7vJDMSSrJ4AEc57pZaD4ShZXcecmETcXgK6Kt6YJjyuPgyJUjKPH+712Ed2JAiA6ZR
 LZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781602184; x=1782206984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W5Q8gKyZl8xg2qE5EZfjmZ+n/OlmXpc3F2Fzo8UG0hg=;
 b=OCpDysKyzwtaRc0EyWEaK/STQ9lAIJ17XG7uMpUOMrxI9Kyd94nAtH504CYIpIwBwa
 962JJ4Y+vWpxAnnbIlPe+ss5XP3S5S1ir/zR6VMir1WiR3v+DX44KUwPTlgNNzbMrnQV
 Ur7ikkHr3bSVkaBb+43B3prjeVGQSOH7Ls4nRSeCfW5xo+D9bV+Fxk0pewHT0cz3fNwf
 pAGYJpE/vikXlicROTLeu70CDZC+nuK+X/vxyM9N/YfVBoob9WmCMIDrz74CGoVGKNrm
 5IJKip4DPb78P6LM8VoTVgwdk2Vc+kbTrtDlyZMMrkmlvrs6wgC3djHwtsTMP28jZXTw
 toUw==
X-Gm-Message-State: AOJu0YypzucLL8WFg2IZhTIMhOF4eQxhssuya2dakc7MvvX0Tj8Xiv54
 QlTClcGop4U2BtbTwArF8qTEZe+2HPlLtSMPN9oq9j9yFs8FlhMi4mGMTfcLqw53x1dT0n4LNQx
 FUXCqVm/N+B8IW9vHufOy64s+gv05TYHD0gBIPaEMnA==
X-Gm-Gg: Acq92OFw8X2wsiDEHFs6+2fNt5StvINpkKLXsPuhsXOuGwtxWDMcdc3024LRZcuiQ8/
 18XQ8vOUJUY/IZrS6uvmL/LpazpIeNGlZy3/cj5V6fd1w1vR4Sb4gk8JV7OZOP1uhmqL+0PTVdb
 HpfoOe2E3uIlG/MJdCMXW30T25o9OgRqc4dz/Map8ziFGm2ZqoikTqCwTeERz9Fg367KPluob7D
 zd+YRYEcLbDwfvn5tHijvx8wbsiaq+Q4QZqxSaeoBdUrXsZnqFmjGR5K3fPj7F4ojz01W6nxD2K
 iRe6r4gD6FE1DsWzNbKN3oVNKyn40Q5IZkEP8+bOEJHXIrrnTvJQoOANK1nrO6Wa3iE=
X-Received: by 2002:a53:ac82:0:b0:662:c431:658e with SMTP id
 956f58d0204a3-662c440af48mr16081d50.39.1781602184172; Tue, 16 Jun 2026
 02:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-2-peter.maydell@linaro.org>
 <931c8511-8c13-4134-b562-d4766d1a101c@mailo.com>
In-Reply-To: <931c8511-8c13-4134-b562-d4766d1a101c@mailo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 10:29:32 +0100
X-Gm-Features: AVVi8Cd4YVX35-ci-O6_6hH2VxwrCbf6iOE25yxkMgts708zYE2ZVLH1mogBjQA
Message-ID: <CAFEAcA_9KQsiCM0WGFYEonu-Afrv=zVrssv2ar2DgG1AMrw2yw@mail.gmail.com>
Subject: Re: [PATCH 1/5] docs/specs/fw_cfg: Document all architecture register
 layouts
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Song Gao <gaosong@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 3 Jun 2026 at 08:08, Philippe Mathieu-Daud=C3=A9 <philmd@mailo.com>=
 wrote:
>
> Hi Peter,
>
> On 29/5/26 19:46, Peter Maydell wrote:
> > We implement the fw_cfg device for more architectures and machines
> > that we let on about in our documentation.  Luckily most of the new
> > ones (notably riscv and loongarch) have followed the straightforward
> > layout that the Arm virt board picked.
> >
> > Restructure the documentation to present this as the "standard"
> > layout, followed by the other layouts used by various other boards
> > for historical reasons.  This adds PA-RISC, SPARC, PPC and MIPS.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   docs/specs/fw_cfg.rst | 28 ++++++++++++++++++++++++----
> >   1 file changed, 24 insertions(+), 4 deletions(-)
> >
> > diff --git a/docs/specs/fw_cfg.rst b/docs/specs/fw_cfg.rst
> > index 31ae31576b..7e2fe0851d 100644
> > --- a/docs/specs/fw_cfg.rst
> > +++ b/docs/specs/fw_cfg.rst
> > @@ -84,15 +84,35 @@ increasing address order, similar to memcpy().
> >   Register Locations
> >   ------------------
> >
> > +For a memory-mapped fw_cfg device, the standard register layout is:
> > +
> > +    * base address : Data Register (64 bit)
> > +    * base address + 8 : Selector Register (16 bit)
> > +    * base address + 16 : DMA Address Register (64 bit)
> > +
> > +Some architectures or machines have a different layout for historical =
reasons:
> > +
> >   x86, x86_64
> >       * Selector Register IOport: 0x510
> >       * Data Register IOport:     0x511
> >       * DMA Address IOport:       0x514
> > +64-bit SPARC:
> > +    * base address : Selector Register (16 bit)
> > +    * base address + 1 : Data Register (8 bit)
>
> IIUC they have both the same base address.

This one's confusing, because the code for both sparc64 and x86
fw_cfg is more lax than what we document.

The sun4u code does:
    qdev_prop_set_bit(dev, "dma_enabled", false);
and:
    memory_region_add_subregion(pci_address_space_io(ebus), BIOS_CFG_IOPORT=
,
                                &FW_CFG_IO(dev)->comb_iomem);

so it uses the fw_cfg's comb_iomem MemoryRegion. This is the
same thing the x86 ioport version uses (except that for sparc64 we
disable the DMA register), so it's the same layout, with
the selector register at the base address and the data register
nominally at an offset 1 greater than that.

The implementation in fw_cfg.c (fw_cfg_comb_mem_ops) doesn't actually
check the address, only the size of data written, and dispatches like this:
 - 1 byte writes are ignored (they used to be data writes in ancient QEMU)
 - 2 byte writes are selector register writes
 - 1 byte reads are data register reads
 - everything else is rejected by the .valid.accepts function
and you can use either baseaddr or baseaddr+1 for any of that.

What I opted to document here is (a) the same thing we already
document for the x86 ioport interface, which uses comb_iomem
and so also is not actually checking the address values, and
(b) what the Linux driver in drivers/firmware/qemu_fw_cfg.c uses:

# elif (defined(CONFIG_X86) || defined(CONFIG_SPARC64)) /* x86, sun4u */
#  define FW_CFG_CTRL_OFF 0x00
#  define FW_CFG_DATA_OFF 0x01
#  define FW_CFG_DMA_OFF 0x04
# else

We could document the lax conditions that our implementation
actually enforces for both sparc and x86, I guess, but they
felt to me more like an accident of implementation. What do
you think?

thanks
-- PMM

