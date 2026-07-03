Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBE7C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa8B-0002jk-OO; Fri, 03 Jul 2026 05:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfa8B-0002jS-5n
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:24:19 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfa89-0005tp-As
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:24:18 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66628618509so498225d50.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783070656; cv=none;
 d=google.com; s=arc-20260327;
 b=Ysaw1oDOPSGa/Rxc2Bvmqj3aC2H74ikgzVPn1TlfkaUIsSodYkyqyfiXyaYaKGQVgk
 dsu58wfx4uzsI4ngNkLIqF7M6QVYJMtEcNk49F6lHyXH7+FKsoo8f2swPJf5EsS6BGia
 /gjulZUUg8F9vfLQ9GuKR1Tv5wXXqvGX3zOmMMGEKfhjOHiazywaiUdWci7gNRvdu3V1
 rrFrt02w3chukHIzuxMb8JAIIIT6cMjGIdAwaqxuWDUSVmCncGXMEwTMEWEmd5+7GesI
 YZczcNBKWC1ZIHpqbJmlUt328QS94cbIAGrduKHsNLQlorP5UvaJBxZ4Vcx1E/uZu/Ho
 SlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h44XTmF1r2IahND93ICYPnNi3Yr9s5Dy0jVRmDQ2BdI=;
 fh=xXUECa7x/m9222uVR6doJyAafWA+wMRf05AlemDJ3Gc=;
 b=IYDXkpdxEjDlPQbUzxJ1+HNTRAWYyilET2KKCJOU8KElhqPmRPacEOYidovmVTZuAK
 Fbf1PO3Mj38El44diSW30Fq464tnkXnjs0X3GnyeQ+4UdBzBHQtvVRi+ZHJMYcQNPmG/
 AjPCYp9g25Awr2jBvGC35IB2hXCPlZFH3MdfHfJzyJdZrlhPufQ5zTeBvmNrEGDj6EOr
 cz8L6i6Tn1wFXT3p87yLkKIuqS/ftB0iWjuNbEm7WrRcyHwmspFIfHn1o+n0c1CfnQ5V
 zslVJF4/LwyPJtQSECvFK1ZINuN72YnuE32n6Zr9MhgH9swbvFmvcknKmXmuH9aFN7gy
 dUYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783070656; x=1783675456; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h44XTmF1r2IahND93ICYPnNi3Yr9s5Dy0jVRmDQ2BdI=;
 b=qeYrh9A/4eyEqnNo0TBC7C1LZxAOZJn/NjReBI5lWOIgdBg5H1Ijp1Dm60iviNreRA
 xcrc/Gs6YxlhvwajQNMknuseFHCkC5U01SCA0Rj84bmOkEXRCLaLzKWqNYaGI7IyneVB
 dg4R0YkN/tVFhD5AqDkvGUamWr4mcMX0g8Adxf2D1Qlnz03qBI4TbVfxCuazBH6Ks68z
 iqRqjT6zplEHaHLihnENpy0lGUDTdF7PRzx2NznZ2VGBEvCDvXy89n0y14m5XbVE0fp8
 L03q5cVga88hnWl29XrPbwDtaVPsJ6w76wf8Q/8LJlhQEJ8RDxTp8MqZiJfdfKql/1QH
 soQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070656; x=1783675456;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h44XTmF1r2IahND93ICYPnNi3Yr9s5Dy0jVRmDQ2BdI=;
 b=HhcyToxaPaf702Cep0I4qmR7g58vNHZgoehund7rS0rv8v5uhjfle1hHy4qt3ggWVb
 l2ZnkrFRMgz+gHWGl9+J5NkYip346ul2olgxvA2Jtdz9gMMcW9AqbvVGUB2wJBI/c7N1
 JpBHZOxYFAu8BhA34OrCeWkbcXdte/+Bi5kXbuTS3/spmlsLQGndC3UHjKa3mD4EOH35
 m2gAtoft1yKKF5x3CS3t2Qyn66WDBX8dXFNxTLDc5mz/7DLQa9/UsR079Rr8hSBlF123
 HDeIRyjPoPTarW1cyn2j41DimTSvb9z2EhxhptDkZXajgQGxfu2t8vYSTtw75DNBJj+p
 EUxA==
X-Gm-Message-State: AOJu0YzsFaxklG0IM5KqZY+W/H2ZyJZHIRr87J4XXv3NW993uHcBhN+n
 Q3+20qUMWIYvns/RLpUt7QuOAAljw6nEk0A3LU8ivTUe5vlWmb0iuAjrEU/yhLAkG6ZW7YQa3tc
 5piLL+z37ByORkvnUDKh+p6+yWGH/ycDMr9tAMPwChQ==
X-Gm-Gg: AfdE7cm+aA6faWM0B/mkSFWvgMEoRHO0ojz69K95SdSUSTAsuozteKjAoiSVpq79YVg
 yWVCrT3PZw5X00f5m6s8FUA5E1/kPtps3hUbhiIL+LCz0gJkAqz22ZztgBjdH/kg/odkesZ0P6N
 bC4kCc6iR4/YgSCZb+ftVyrntiyJSSPJvD3ZF7XUBG+/o+PHOefbb9+npqrmt0/od8Iy8BRIFKN
 qKc9SU3AvkraVpNMsci/HgcPljwc857GFx2muvp4j20lh9au//J+jZfeuNg3Smt6TmAm2NUB0tE
 s+ii1wZ6PfdM9J3Ilob1sCCWROBGVHuj+UzeZIf274LXwmFRBHsQKk5b
X-Received: by 2002:a05:690e:1348:b0:664:baf3:f665 with SMTP id
 956f58d0204a3-66521b876f2mr9351439d50.64.1783070655716; Fri, 03 Jul 2026
 02:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <rxuL-6ZdTjc0-X6Ez2rU4TPEObWUUb4HjRf6X2__bLs3i-9N2d5NX3HbQK2Zyrh5V2c1szltCX91cL-s-WHxX1XoBDSyx5_m6FCvmBmblIY=@proton.me>
 <ad4b1u-MEfso3miW@redhat.com>
 <0NssTF_XyAbzwx4DB1ecmeaWsoqoRMwGSrf6SCVUaBsAR3aN_FinUY8ucoU3PrTya2Jdf09HrEMWR9mwdFI0HW_ZF6SBe6gi6aIgrVpZd3g=@proton.me>
 <CAFEAcA-BW-W0tD=_Cy6AR-E637h_Ryo0JBTHTzXqB3o3f71Rxg@mail.gmail.com>
 <CAFEAcA_D3u900UDM5dzPrMvs1CF_XJD6HdgnKTvHXa0H=ysSbg@mail.gmail.com>
In-Reply-To: <CAFEAcA_D3u900UDM5dzPrMvs1CF_XJD6HdgnKTvHXa0H=ysSbg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 10:24:04 +0100
X-Gm-Features: AVVi8CdgJCjOZNTEPnMGUL64d0xFVB_1CIXAK9_tHmjrzNxdsRdBY48QtkfAdag
Message-ID: <CAFEAcA_K5AvrrX3_rDHwOFFj-Hi9QSEsUJbpyqG6mxbUv+HdEQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net/fsl_etsec: validate FCB offsets in process_tx_fcb()
To: Feifan Qian <bea1e@proton.me>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Bernhard Beschow <shentey@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, 
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
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

Since nobody else has taken this, I'm going to put it in via
target-arm.next.

thanks
-- PMM

On Mon, 29 Jun 2026 at 14:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Ping again -- are PPC or net maintainers going to pick this up?
>
> thanks
> -- PMM
>
> On Fri, 29 May 2026 at 15:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 15 Apr 2026 at 05:08, Feifan Qian <bea1e@proton.me> wrote:
> > >
> > > The TX Frame Control Block (FCB) is prepended to a TX frame when
> > > BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
> > > fields that process_tx_fcb() uses to locate L3/L4 headers within
> > > the frame buffer:
> > >
> > >   l3_header_offset = FCB byte 3 (0..255)
> > >   l4_header_offset = FCB byte 2 (0..255)
> > >
> > > These offsets are applied without any bounds check. When the
> > > UDP-no-CTU branch is taken, the function writes zero to
> > > l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
> > > write target is:
> > >
> > >   tx_buffer + 8 + 255 + 255 + 6/7 = tx_buffer + 525
> > >
> > > A malicious guest can therefore corrupt up to 509 bytes of heap
> > > memory beyond a minimally-sized (16 B) TX frame.
> > >
> > > Fix: reject the frame and log a guest error when the minimum
> > > required buffer length
> > >
> > >   8 (FCB) + l3_header_offset + l4_header_offset + 8
> > >
> > > exceeds tx_buffer_len. Move the l3_header and l4_header pointer
> > > declarations past the new guard so that out-of-bounds pointers
> > > are never materialised.
> > >
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Feifan Qian <bea1e@proton.me>
> >
> > This bug just got re-found by somebody recently, so:
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3517
> >
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Jason, are you going to pick this one up, or one of the PPC
> > folks? (I found it didn't quite apply cleanly for some reason,
> > but I don't know why as that file hasn't changed in ages.)
> >
> > thanks
> > -- PMM

