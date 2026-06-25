Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB154CDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 16:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcmZW-0001SU-39; Thu, 25 Jun 2026 12:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcmZV-0001SI-37
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:04:57 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcmZR-0007Av-Ny
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 12:04:56 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6603d8697d2so36431d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 09:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403492; cv=none;
 d=google.com; s=arc-20260327;
 b=R0TZNu6p70wSI5963l3x4aTHlBpz4UnHehkYJq37Wyw158GDiwS+ydeod+pP6vaUTf
 OBpkzq0ikFLI0qDhrn9xneyQxX7q+XTINpcOFGnFSJSvq6SJVZ2Z5sIOYR1wRvHl+IOB
 xAEmxOfKKSdYPkKH1Ie9Bzi20fNlQ3T6LHWbftQxc4Rgqk/GlpXiAzQkMPe1UBbbc5KU
 h0ZuRS3sKDEWSmiDUO0TTs4VVdhz4D/UX6blyLrUQ1I+cX7lb+bOFBT04WtwQPW48PoF
 yWPnfmRM4teLaXathTQyrj+rJ0i6BnE4+hdikiyWnXnDhx6Q45QkhQg/j/QZlVdDr6+7
 jnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qYu1r2rbd0BJ4SGjG+77dP660Is14aPI/TuYU8GFULQ=;
 fh=lIqBCeHsGzm4xQBmIPSk03zrANU8tszswJl3TcFSf3k=;
 b=SrQ2mrz59gN2fJK7hCc7EG778MngsKViKUoNGBeKJ06MBRqqvHbifSz2NxXyPd+TTy
 qpEBDMqwY7kvsegaFaGf9kU3sTVWmHFnWvNMiBt1EhOpK4nh+dyHwv7rnrJK6HaLSkz0
 1VBC2jxgahFfk9w3ElU/wslwrCzxjxOOcj3D089cEo1QSXvxdKICjY7Qki/oqNEm/rcy
 R8OHW+S59ezTqyIYPaKmP0Y+n957Dg6VIIl2vNljWaBsg2PLN3ClNW2D7RHHbE+LPH5Z
 2ec/dKJrpW0Z8IFnLLCj1/k6yZdgQzlDLg+UvIy0LMrHyUYVwIiyuvw+HRwURK5OAh0C
 BLlw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782403492; x=1783008292; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qYu1r2rbd0BJ4SGjG+77dP660Is14aPI/TuYU8GFULQ=;
 b=DBz0kdEh8K4LS/ZS+XRaeO5vev06ll3OY6AvZnDLSH7HsHfYhXW5Y+Eb3NBgAKgmQ9
 lDqkGBB4ByXgpWNHtk/B0F7dSIBHykwFkkS9tH0480z/WWq9RuovBfE3MyGFrOBBv/Mp
 n2XOm+65e1WNVk7awMpitJNh/Y+jx52vZZ5k+0LVLyKqwHSoOsv98kCizZXYkKQnzR66
 1HaK7P0qXvONaZEftCAjVyyz2lFPb27N6Dot/A/iJiZjT4nmd8fkFP7UPuMVM0v34zMe
 STzq1m/6R2g+ypfIo9V57uDZCEpMDWzdd9R8tGkx5I/gEbB5XbLn0e/A/7e11QBWcww2
 sglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782403492; x=1783008292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYu1r2rbd0BJ4SGjG+77dP660Is14aPI/TuYU8GFULQ=;
 b=OSjINyP8vWZTk7UCUMxH1sgSnz//QcZumnbj8D1ajbbK4Qs4b79IQwy3sruAqbre7h
 8dhQOmKqh+jfxtKBu1ocf9Y2Xxwlf8qJdrfmzP/InooyhRteHkVrfIos1ES99O2Ls2Ds
 9rmstBy3W84i6d21mmgOX79oUX/UZz/4C9gDf1o9z6SeyXrIq4IaxNznBNMNmWBvB+F1
 qvnUQRrzqWAIRa0/NKJwfm/W/yC8Oc4wukWcScZd5EBtKu/09gQNwCAYJTpDUA+t28fS
 Q+O0yTmGJliat3jj+XqszE6SPu1hIQURsl7ZNJWNLfmR4ezItCwAElgBB0BNNcnHNuuC
 dXkw==
X-Gm-Message-State: AOJu0Yz7Id4RLugmsVj2EBnXtVzzfD+5QZzy9C0hl4JAMKoVnPdNv5ZL
 Y/po14+ZiWvh3kwhlAzXokP60HHpkitvf1RWkc07SW4+mpGLPyG4q5EiAPAifXoo+sKrl0r1Bzk
 ArehePTXxb6dNDaJS7ri5wl96eziFzglEJ1Mm03GyGRXNPklOGw32MjlbFSaebvc=
X-Gm-Gg: AfdE7ckKUwDr8VMkESzj3G6JHw04FFtA7jQ5LJ3A/nrdcN2AZrdhft30jzkt51MTaI8
 pgt40vbSevJlTUYSEmrm5aiyffD0tHvl5eJu6lAUNu5TbMVESGRQ8PuLqOs84snrssEGxBcLfF/
 zOAFmoHsl861/3Z2vmDNSbtS3dGfGaregITAKgJx9oc7Fq2AsvHdWz63Ctex18Vrvl06JrJ6WZp
 JI6hLlvhegPEr2PX2kxiBjAUznvRCJfBcZTdhGuOIDJaRif//1oCpvtWK9uzqefyKK5q3mg0tNB
 RSGLRlXHFh1AUFs5dHBAL2n0cnUzlO8JRLyiAr9XmuH77y6mOwwTYnipHL4glaWO2Q8=
X-Received: by 2002:a53:ac9a:0:b0:65e:1d95:29d5 with SMTP id
 956f58d0204a3-66487d9d7b8mr2507634d50.41.1782403491659; Thu, 25 Jun 2026
 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260625160144.94565-1-163wangjack@gmail.com>
In-Reply-To: <20260625160144.94565-1-163wangjack@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2026 17:04:39 +0100
X-Gm-Features: AVVi8Cfw3E-Rkik7ZSjgp29hndsP18NTNhB6b29Zth_8LS-KtoeKJWLmXSnTeNY
Message-ID: <CAFEAcA8pkOuWQPVosC+6wzODHFDHf7m9XNNoxr6HnrtgxvygmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/misc: Replace DPRINTF with trace events for
 imx_ccm
To: jack wang <163wangjack@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Thu, 25 Jun 2026 at 17:02, jack wang <163wangjack@gmail.com> wrote:
>
> This series replaces DPRINTF macros with trace events for imx_ccm, imx25_ccm and imx31_ccm.
>
> v2 changes(based on feedback from v1 reviewer):
> - Added missing Signed-off-by tags.
> - Fixed code style space issue in imx_ccm.
> - Dropped unnecessary uint32_t cast in imx25_ccm.
>
>
> jack wang (3):
>   hw/misc/imx_ccm: Replace DPRINTF with trace events
>   hw/misc/imx25_ccm: Replace DPRINTF with trace events
>   hw/misc/imx31_ccm: Replace DPRINTF with trace events

I reviewed these but you have dropped all my
Reviewed-by tags...

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

-- PMM

