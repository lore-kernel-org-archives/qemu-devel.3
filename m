Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9528CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoIE-00054B-65; Tue, 26 May 2026 05:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRoIC-000543-HX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:41:44 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRoIA-0001Xi-Jw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:41:44 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-65c52bb5dd7so9872504d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779788500; cv=none;
 d=google.com; s=arc-20240605;
 b=S9snEqnc8YIU0ODcMENPl0PntB/z2iLPzdS9Yn+TWr7XNre/1/Pdy0DkUTXBMnA9x5
 xrYQvuJbUARbYu+NQOXN5fwpAysT+AXtJrT3rmRfjlUvHs9K3+lcaJXfDmcrS+KXTu2Z
 jap7v8TtP+JchcBhMOnKDZaSa45436KAyignooANdE3JTl/MEGQIAairinIED6mup1Du
 7j4S2kgX3q5l7sEs3F3jFtd8AvkjMQICGQYt1cf6nVMB3vTAQ4a9Vvifg8KQm9hgtPh0
 usSy7Gyhdc0kBKUWagPY4V7g4pUOg8kbuJHRAtCYWkS1F4B4lOvNMYaQVGahDBjYhC4c
 uYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xpWlUl4jTWR+abcNiS2POVhGjXqsiCxExM44RLhMxXs=;
 fh=2Ql2JQXYYxz1RYoZmvk1GClubAUYYhKeJe346T0P6v0=;
 b=lcuBM1hBqinMj7hmmVww8yPcn4Tum6uCPmxIDcLolmzqYI5LZRVp7tE528mXqCugL6
 Pmv1h06fNiMsMjPz9zRZXQv09K2yY30Y3sHZIKypCY93ELu1/wNQcV6Xw3XmIrx7bDlz
 oPFSpBZweeNSpIxx3jOAPcsaok0Edus/7TjIERsfkn1hgqScqc2NChyekP4inYExJzBl
 2kJnZG+2CBrbUbgsIxOUqnx0cLZ/rLFLicVyKvXY2MFkGN7DPYNQbmon789mqmlnCmRS
 4AH7E5B07XA3HM2H1KUFu6cgoFZK3dJeVUycetrx2f8B3ZLtOC9NBiHGcmcJkRA1/riv
 /Fdw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779788500; x=1780393300; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xpWlUl4jTWR+abcNiS2POVhGjXqsiCxExM44RLhMxXs=;
 b=PVzcqPp9RvluPMJ5dCDEr4MYBpiHB2j9UjncWZewpNanTDzPRT8bJVYvf6eiw2mCVY
 SlN5k/vE1ixxjgBAHwJFYvLP9QCy/VE313KsitukSOyLIaM2U1cp+g/vOWZm+paOazTe
 oNRz4alDfh3TKMq2L4DjctsQ3abQM8Q6X21cY7yxQr1sRvddou0yQfbvaPrkwN6yBJwG
 MjOIaxVlzkP46fAnLBKkVDO14XyoF4u4arZqYwmPOaSiM4+dSmS0RU6/lbLa/pIkYcQs
 8iXhfzQaqChsAXo2glgQCANQ4T6mfJNR1UbarAIcD30BZoEEOzis8hVugaAfEDdaauPI
 Iy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779788500; x=1780393300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xpWlUl4jTWR+abcNiS2POVhGjXqsiCxExM44RLhMxXs=;
 b=jzWfXBoJDiWoOFt/4NIwitRvM09bDqbXWAXHt5uxHUjPAtLggvfF3cTIWA9ZtHHMas
 uB+QDO2c/FH9Twlx+myVsn+UMYEwgUdc31+MhhnorZ9I/cUGY1YiZ0Y/I+tCrZgbPW/P
 Hj4UR+0hjNFd0rFG9aicc6Bv+j8bcWSaCiF2bfM3swYWvBmf1gcA5JvPw/eFUBZD6Are
 c2fnVFQBuJoKgnn828dorQazePcO4lK6p80KUXqDlH0C6t7FdefxmzhiHKqOZzRJbLR9
 rqm9zi79thNynFOCbjw/uVCi1laeJ868fRPE5wnESRogb9y6OFnGJNmu2keaLWK9YNOi
 YvXQ==
X-Gm-Message-State: AOJu0YwqcQHPAP+FTxOKou1JulQqaYGzV24/q47zPffjKriMqplTguRV
 LMFqHsTCfnebzaoGZrFZZk5Pd4RahNfihprdjoKMbuk++mNPiV0isdg0jXNWb5flRE2VSMsc7so
 9sqJ96LUicpzk2/SWY7vhfHi74rShl2mNg97DwTBobA==
X-Gm-Gg: Acq92OEYBYfurinNojLMgAungSRvfy7MmNqLchIfRE8OAOAT/n7PAwNErTB0jaFM9r5
 LHLXv2GzzWCMRVJh2MjoSETIel3ZFFwJ5vp/n4UC6cp/lxCROBhNw4N2HE8M6gkBZAZPc7Wl308
 GPUizysrlFpKzPgE7Nyf1lFVH0OEFA0HaQhTO1ouF5Gdumr4DOhPNLPQQ7xyiOM5lTxp/cORDtx
 p78h2nW/Nn0gB82vuF2IDUf6+STGBRalouIlUTDo9pnP4oaGRdFiFUqrbMvKQDCuoETfsYcFMh5
 DZQ0nt80/6OT7esJAmVfo1fy9JkygoJpA7/2uq6D/RTtQ+tDoJjh9TX7ceZ7XCkQpX0=
X-Received: by 2002:a05:690e:140d:b0:650:6cb:a720 with SMTP id
 956f58d0204a3-65ec98c44efmr16646530d50.39.1779788500328; Tue, 26 May 2026
 02:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260521172032.85047-2-hemanshu.khilari.foss@gmail.com>
In-Reply-To: <20260521172032.85047-2-hemanshu.khilari.foss@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 10:41:28 +0100
X-Gm-Features: AVHnY4Kds6Wo04G376xgIDZx3i9pn7tdWoLBXRpVxgvUUCAzzx30CpnmwQHI7wk
Message-ID: <CAFEAcA-UtcxQewr0y9Ohqfqjez3eDenMhG4+r_DTVTLxe9NhxA@mail.gmail.com>
Subject: Re: [PATCH] hw/core/qdev-clock: Fix potential null pointer dereference
To: "hemanshu.khilari.foss" <hemanshu.khilari.foss@gmail.com>
Cc: qemu-devel@nongnu.org, luc@lmichel.fr, hemanshu_dev@proton.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Thu, 21 May 2026 at 19:13, hemanshu.khilari.foss
<hemanshu.khilari.foss@gmail.com> wrote:

Hi; thanks for this patch. It looks good, except for a couple
of minor things that I've noted below.

> qdev_get_clocklist function returns a pointer to the NamedClockList
> struct. This function is called in qdev_alias_clock and the returned
> pointer is immidiately dereferenced without a null check.

"immediately".

You should mention in the commit message that passing the function
a clock name that doesn't exist is a programming error, and so
this change is not fixing a bug, only making the reporting of
that programming error a bit more helpful and bringing it in to
line with qdev_get_clock_in() and qdev_get_clock_out().

> A null check is added after qdev_get_clocklist is called which prints an
> error message and the function is aborted.
>
> Cc: luc@lmichel.fr
> Cc: hemanshu_dev@proton.me
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2342
> Signed-off-by: hemanshu.khilari.foss <hemanshu.khilari.foss@gmail.com>
> ---
>  hw/core/qdev-clock.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
> index 6e2967e433..cf09f3d09e 100644
> --- a/hw/core/qdev-clock.c
> +++ b/hw/core/qdev-clock.c
> @@ -157,6 +157,11 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
>                          DeviceState *alias_dev, const char *alias_name)
>  {
>      NamedClockList *ncl = qdev_get_clocklist(dev, name);
> +    if (!ncl) {
> +        error_report("Can not find clock-in '%s' for device type '%s'",
> +                     name, object_get_typename(OBJECT(dev)));

The message should say "clock", not "clock-in", since this is
for clock aliasing and it works for both input and output clocks.

> +        abort();
> +    }
>      Clock *clk = ncl->clock;

Our coding style (docs/devel/style.rst) requires that all
variable declarations go at the top of a function or code block,
so you can't put this if() above the "Clock *clk" declaration.
Instead you can put "Clock *clk;" above, and then the
"clk = ncl->clock;" initializer below.

thanks
-- PMM

