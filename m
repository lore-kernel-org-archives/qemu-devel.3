Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DD6CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWW2X-0005x3-0X; Mon, 08 Jun 2026 05:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWW2U-0005wu-Ez
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:12:58 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWW2S-0001SN-U8
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:12:58 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66043ecf6b3so3951411d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780909976; cv=none;
 d=google.com; s=arc-20240605;
 b=PYzEbJFZg/YGXOcwXnWyZyzRohyNR9qJj7EBI/kwMRSvzl507F/+urV9vCstOpUWkT
 C59HKZg/hLbk8QMXuoalUWW88JTzO3OtntpGUnnlTmFEaIp6XoIaaaJU4WnNxRqfUxTC
 YHA2oeyXoJYjcZkGzV2wrHvmTUcfaX6K809Yj3mIIoLO5QlK2fOSJvqQ8HEPZCaDk6wh
 6V7AzKuXi8bwovF/PQrtMlVTWE5dG5Y05hUf1Q1rDiRReNG+ccKXlcMZi04gyoL4yREw
 qLHFGCvO1Qsuivsx/4mQtNZrvh5MYevtlpp4O1ohdtI9aAwwf+Yw2Dr3qhVWbBCJMEVo
 aLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ViQ2oHhxwOrcvRkB2YTuHOzio1eIu7vIipBnElx0RJE=;
 fh=jGLXkZl6ML6kEgYzos72XNjqgVKSKEL6gFCA0DwKiVQ=;
 b=lRDuaQq+JC2TfSMt4LSKYJxXj/nPPLpy72cWRvnfv+ix4soJ2KCv/glVvKUvAkVFzT
 bbilpveDAN11qMtzJopzRdssKm8bFDlK7IVFPvTERM/m4O4157d4yQ2ScHyB4CwO1WEg
 jgWQInUar4YBr7BCPyDhpjtp/KrpckeN0SXmQKilE31LIxJ0hPPlRSX34uZFYqoCFAVB
 1O4xs2yqpBm3PFKU29LoRAZY/kWoGP0rHSpP31k0czaqY0BNTYQKyaUXTUVMpNFv3S5Q
 wfotyVtLi92ZoEGpgoQWlfJ+zZpCjZOgyOqoh3Lz1LuPwBNUKtUeFi9ZxZNqQX0VHz7U
 amKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780909976; x=1781514776; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ViQ2oHhxwOrcvRkB2YTuHOzio1eIu7vIipBnElx0RJE=;
 b=A9ASFBOh6G3l/OxiyLHdbaX3TUdlf7dIVZv141KLtCZpl5uamz+KpTBNlauzuSF8Bn
 /awbp5ewJW69K6dgMHVJiWlHGocVktE2QPjBrexZOhHYEq9DqTG9t75ejxEmuu+CrLJe
 bFOa56uryzglohw+3UXQmlVeF7vTKkwEWQPIhozDJdRkKad/2sic1iRjHtAXwm+1sZuH
 epOpyrMSxpoYAHO2nwNfKRlyF4xncKCVZ045xYaZenH40TPJczcoBmGd7yrkA8tLNJfI
 sonUHtrGDuYjJkKA+47QXvvti2dTkVl8+hhEVsu9eQdTCqo3FBXWm70FIJrm4zhwY/5H
 2Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780909976; x=1781514776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ViQ2oHhxwOrcvRkB2YTuHOzio1eIu7vIipBnElx0RJE=;
 b=outhVUi9/ZBAETK1qggK0mI0CH9BMJSi1Y4+gCKRzeLFp/puCcWj1ZjiV2mer33V7R
 dheSg1Pob4TwyaYhBVDjevEqD7F2BKVjfNZjO8ZHUtZ0s5vPyM8npws2yZ1o/dcVWnfR
 D3Z6CSs5mtwiXmUz03jHtEQ66KK4yx80gMVpY4M83EsZn2hYp1gioKJiWDufqlLnzten
 I9RLWABpBZs/eGJubH8aJOdNXXfZgvLcHa2LPzaPmgL2AAB8/7khryDJvKAOT0RnHgD9
 wZbd/dvLWmkN3PIWlmQVtkDpd8sLOx2KBdPhbVUDIzTOxEkK4PmDf2L1iyl4438zFbwk
 Ds0Q==
X-Gm-Message-State: AOJu0YztgedQnQbKu3j9qC9/3+k5G3U+u8Fwab/MQar8t4OUww54F0SA
 g/ARiSBzxceXWnmi1rWob4PAf7I5Yy4Vlp5+X8cnh6PhRNB6136OF1ey2zKB+SyfSTRUXiZGPHS
 +rKtU0XiqLEG+EekLSedDULus8Mk6dVD+P/WCfi23UA==
X-Gm-Gg: Acq92OG2omCpDKgbZ+tlWi0BeAkC4Nk1FEyuv3bWT4kHqPq3uVTXnCowKqEkquxstzu
 ipowLrEqec36mK330CWop7BDMfN+yMiLrz1Zu87jcXs1owyvPmPo1MMR0QuEEsaE87WNs/5MHnC
 XpEUEi/+fZgBXl3/cwWQRsX6MbawWVK1n+Ff4AUbxVzWP9WT+2iXXEWnZjbXlKc0is6gWS7p1SF
 vlbB3Q/n3NZJUanER3jZLd+EiGOwSrc7kPSusiTQhQE4tgnuvKO4nUxA0vvEgahZ5WLlqYwCHtW
 4eJR8qu5ldvzqKM685u0M5mGojF9XdYoY4Zl0ph4ZpsAmSkiDdso7yQ3A3Rp7NJtG9VoX7Pnuet
 srQ==
X-Received: by 2002:a05:690e:1918:b0:660:5a88:6442 with SMTP id
 956f58d0204a3-66106ffbf5bmr12399190d50.64.1780909975608; Mon, 08 Jun 2026
 02:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260529174639.451353-1-peter.maydell@linaro.org>
 <20260529174639.451353-4-peter.maydell@linaro.org>
 <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
In-Reply-To: <d6f30fab-eb87-45e7-bc5b-bd1f97afead8@mailo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:12:43 +0100
X-Gm-Features: AVVi8CdFATCgDgRaz775tc30gCC6DLTsG1KuFVXoLLGv26v8ydWVdGaCVwndeq4
Message-ID: <CAFEAcA8uLpCA2kCzqM2jii+jigd-mRYgpVCfb=qvwZH4SU9Gzg@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/nvram/fw_cfg: Enforce standard layout for x86
 fw_cfg I/O ports
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
> On 29/5/26 19:46, Peter Maydell wrote:
> > The fw_cfg_init_io_dma() function allows the caller to specify the
> > base port number of the selector/data register and the base port
> > number of the DMA address register separately. No caller actually
> > uses this: they all pass in base + 4 for the dma_iobase.
> >
> > To reduce the risk of unnecessary variation in what different x86
> > machine types use as their fw_cfg register layout, remove the
> > dma_iobase argument from fw_cfg_init_io_dma(), and have the function
> > always use the same "DMA port is base port + 4" layout.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/i386/fw_cfg.c          |  3 +--
> >   hw/i386/microvm.c         |  3 +--
> >   hw/i386/pc.c              |  3 +--
> >   hw/nvram/fw_cfg.c         |  8 ++++----
> >   include/hw/nvram/fw_cfg.h | 17 +++++++++++++++--
> >   5 files changed, 22 insertions(+), 12 deletions(-)
>
>
> > diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
> > index 45a3747908..be3fb5f8aa 100644
> > --- a/include/hw/nvram/fw_cfg.h
> > +++ b/include/hw/nvram/fw_cfg.h
> > @@ -305,8 +305,21 @@ bool fw_cfg_add_file_from_generator(FWCfgState *s,
> >                                       Object *parent, const char *part,
> >                                       const char *filename, Error **err=
p);
> >
> > -FWCfgState *fw_cfg_init_io_dma(uint32_t iobase, uint32_t dma_iobase,
> > -                                AddressSpace *dma_as);
> > +/**
> > + * fw_cfg_init_io_dma:
> > + * @iobase: x86 port number which is the base of the fw_cfg port range
>
> s/x86/ISA/?

This is specifically x86, because we use this where we're
wiring fw_cfg up to the x86 in/out port instructions. There's
no ISA-bus version of fw_cfg. Anything other than x86 should
be using the memory-mapped fw_cfg.

-- PMM

