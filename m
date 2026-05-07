Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB68CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 05:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqvk-0007Lh-SL; Thu, 07 May 2026 01:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKqvh-0007LK-Iu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:05:45 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wKqvf-0000KM-SX
 for qemu-devel@nongnu.org; Thu, 07 May 2026 01:05:45 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-67c2d57a5ceso609168a12.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 22:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778130342; cv=none;
 d=google.com; s=arc-20240605;
 b=DguhdB5IAoHA+3gu6YHr++lJELHRnMPtOhoooO8f3WGHYiQ2E4sBnWgbj0/YuLUWeF
 oy0OYYufjMAfcfY3bumuHVXKV6078yu89L8+5NinKHriJy8iIdMv7j31advkv/ZOjV2p
 qnfbStOF9BE6s1p14o6V1LdCkGQKqItOi39hFRVeP+H/KgzkJLwkKMkkL50Z0/bS0dkj
 qogcVRfvmAv0smugKLybccY5DoJD6s2FoSDJl12LC7+AC656tUjpIfxrh+IrZDCsGk9g
 8s7z7eRGGalPupdwW3YKAVFFAI0+3LADzAiIjNWTV7bycnMAXlw9vHDhGW+jX7MJ0PmX
 cp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6XUaqbVQu3dzrHaq6PIScCTQY1b6Pko6JKPWP1i+DhQ=;
 fh=9rJ5TzVsly0KzP19dArHBdQGvorIEb1dzhm1+zrtNcc=;
 b=CEDojHN1dG9ugrPQtrs24GcjIY24w0g3MWMey9z3W+yP01xaFK8pwl5vOte7xEoYk8
 OFTPB+dwchiovfSJkgzd4t+ogMtqICL3W8NFukg6J0V/W/FEcRUv2/FMOTtN78ZzJMEx
 jQ+pXeu62ETsPTWKJUuDHavTXhStTjdhCCp18tJneY72XNZqTN3YXBIPVdEFUmNsJTn+
 lHsT2GfIjP9QoQZJDxHhra+JXPXqkWDLctJMP1d1agfbOy0eosnAtZi1uxB7bRQCqFVN
 Ai/3Xd0FhDF+ogYXogfZjhU9doaCIDSxXtSNlhn4nLtaYSvHb4a7fdBuNIjWQg2BpFP7
 wlBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778130342; x=1778735142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XUaqbVQu3dzrHaq6PIScCTQY1b6Pko6JKPWP1i+DhQ=;
 b=XIq/YUwE1Cf8tuKgrl6zLd5ZZ3u9VUujcPPdWdaxNmLuyz8Bb2cOdDCQAQ1PYbbjGb
 LSWRIMJN6a1Mpi/EkA2m4OtCpmfHR4BQJP9jIQNq4gK80RYDWQVQ/amsz7m5wlu36s0P
 7C3ZVcA7C3cNAycCkbtS+eTDhr/ATFCDD9+5oBp0t3+aBjwn+JBXWtL/4kUqRDnNBwxn
 o/zvWtrPTNWr5dVxjaLaDikrnRQCEgqchXHjg+/TGLpAFaJvFhv2iChX08R8kEdZWwuT
 uq/zW8YhUzvA+rr/lVVNLZFs0+wksiXkbk8fFSdSMY67Ecy6HzGuBjtSoHnYkNx11DCy
 A5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778130342; x=1778735142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6XUaqbVQu3dzrHaq6PIScCTQY1b6Pko6JKPWP1i+DhQ=;
 b=M0bmnLlUlyFngkPLiAQl1o1aLKHqnXX2rsS5hoQsy4taumUjPocTr4s0EYculwFVXW
 Y3uXi2GMbkLGv+TjaMa9trqncFsh8EUBwbHjKx+oyxsAt3zQD1oeGJMmRG9rCuR6x1kw
 v7+/QFrX9rIP0EzKn43kbXaPTjOmZDclVQbJ0A57z8qOFf1wS9Rqsd/QSVoNNbP+vrik
 LF5SyAbNCjYxm0w+KZTKnI18CXxN1YqDrzEcaCSOX/zveVuTqEYuxkmlEmb4FFlqDg1r
 Jf1nPa9UyQCDtmyh1XrIrRfsmlRo8mQafZt73OvrKyd476u5ELAM9B0kXOn2HEabViNQ
 Un9Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dB+xoYa9O6buq2VjO1WNce6FLNniAV8y5PMJIaQiacKkW5DBi01DJcPN52yRiJaGYKJUIk5tm9FrC@nongnu.org
X-Gm-Message-State: AOJu0Yx1CTCynCsuU3PoxUmrE8UQhSdXcwHI/qZorUA0N8vdyAXxS3uQ
 KPrnM+TQPfgSVa6+LKF9tlGE8VFPtFSN3gnjfArc+HqXQ9psDrofdmELR7qZWi1tY6i9CPCLWBc
 G8QO5lDN53MYmwfhWSrf/QiaMLzXt700=
X-Gm-Gg: AeBDies/1mie40vij9UWxrVTPE7ad2mWkAIrGd0Uf78fltME3kzbaLWNXQNcTynpghX
 XArJixhzDd+9ZpddagJUmi4PpcIfG90QlCMIBDdPKtQNm8+SMw20E9A8vNuzCeNdMrookjaQ+8r
 V1dKSpWN75+VNZaef3w99x9R5niAKtwseXCJmJtre4JcAd7jqxhxGPlMwLO38aa2qpbSEbvzR3J
 sF1L1EJS90SfwrUVpgBcnADTvbmxmcl2E58TtLHdYTlx1EoltpMnyLCnvMVyn3UOOLVpsN6PWnT
 j3zMeRAdH11+jtnVUuDuZq9xAdXouzCbR6G6xrXbG5kgOAtE
X-Received: by 2002:a17:907:c06:b0:ba4:94f8:4df with SMTP id
 a640c23a62f3a-bc56b3228d7mr360724166b.17.1778130341415; Wed, 06 May 2026
 22:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260506234243.1873782-1-alistair.francis@wdc.com>
 <0daf8491-4677-4b42-84c9-b08107158c61@oss.qualcomm.com>
In-Reply-To: <0daf8491-4677-4b42-84c9-b08107158c61@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 7 May 2026 15:05:13 +1000
X-Gm-Features: AVHnY4IbW43ajNfy9K4n3H7QAO7D16-2wKzT1bF-Myck6N7WenZbXDRbKM1tslY
Message-ID: <CAKmqyKNh5go3sD5xNNAwSDcmz6JhrS-B+S8TvzE2b1uEUGKo-w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Maintain OpenSBI Firmware
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Thu, May 7, 2026 at 12:46=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
>
>
> On 5/6/2026 8:42 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Mark the OpenSBI Firmware as maintained by me (Alistair Francis) and ad=
d
> > Daniel Henrique Barboza as a reviewer.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

>
>
> And speaking about OpenSBI I believe you might've missed this one:
>
> "[PATCH] roms/opensbi: Update to v1.8.1"
> https://lore.kernel.org/qemu-devel/20260108160825.171794-1-daniel.barboza=
@oss.qualcomm.com/
>
>
> Let me know if you want me to re-send.  Cheers,

Also applied, thanks

Alistair

>
> Daniel
>
>
> >   MAINTAINERS | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9d3d645953..cf91b9f9f5 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4044,6 +4044,8 @@ S: Supported
> >   F: hw/i386/amd_iommu*
> >
> >   OpenSBI Firmware
> > +M: Alistair Francis <Alistair.Francis@wdc.com>
> > +R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> >   L: qemu-riscv@nongnu.org
> >   S: Supported
> >   F: pc-bios/opensbi-*
>

