Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097A3CCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjvp-0003JB-M7; Mon, 19 Oct 2026 05:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjvn-0003IS-Ox
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:45:23 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIjvl-00051S-Qa
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:45:23 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8a83d2706fdso11524267b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792403120; cv=none;
 d=google.com; s=arc-20260327;
 b=BwBZ/UWLUjAZmJrsNbZ88Zw1sSHW9fTsygk9PZqJRottj9M44FgL+bKG+3msbReuf6
 VZLVez59SWRhV6mVjS8P3O3V1PyeuVC3ESWni9mqMe19KQ67Ln6uaDRN7MLlaqp2PifS
 CiNhaA4xF96m+GxJx6sE07LIKF7yJIKUJy5xRYfgt1GiJCgipO+qjn3qOVf+8zOCupju
 engcllJnNDpK54qw5RJf0WevKXvo11yTqiGOlLmp2sKln2ewgnU+o0L82qW11+Jh3UJ7
 QL0E7thQhKGQkcHZhe47tJbxIe6JGi3z9ymjCYwHwSseQshT7lT0OGwVsQnDH1c1cz6f
 dFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xKo/4l25o62uaIDmPhFxXtrVUZ8/fCH7zbFgnGgw9jo=;
 fh=vko0/TlqtB25AL5yVaXrsFvz9tTYh/L5jjqDQm79mcA=;
 b=HshCE10Hc9n3UlkcbO4T3TvDyDr7KkX53i7Z4njSfqfj3ZKE0uzsAiumf0dM5t8o65
 26OtUE1Bl8Zvxv7XRiX6qn05/AIBDVmC762OgfnBmioquJ8xwqna5Ex9ppD0bqi3DPMn
 sWYa7xSVF28NUKDE1qzq5lIHjxcXxS6+ZSVSQczz5/1zxxdsgECxClnzlDOjgsQLM8AU
 LoreUZW3/AQEPx4cuUoRUzsF4xC0nX6qNzF46Gm+dWa4PU8yT+a/Ag1jwZXpOzCLuiZu
 6F4YTto5jR7c7TDmPoTMBDVUlkgXVKMg38oZRpoFQ2LvZFAMGNG2khLrHXP7ZDLVKDDP
 HZbA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792403120; x=1793007920; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xKo/4l25o62uaIDmPhFxXtrVUZ8/fCH7zbFgnGgw9jo=;
 b=E1J/w5CuW2pxsHuQnu64nwmiUyn7+yGm8fH+xLZARIAhWT6YOQT1XB0GMUXImKY8Je
 VWNBqn3VMzi1GfVXZcsjzt7gXIsouj+46jwDKYk6mTJStSE5F2surIblM3HKxhju8ivi
 NuSaSojTJofxclLu+Rzrm614seUNFd5YlDxz6mSOawiJ4vW1l1+yW3vgrtjoEOUX/RdZ
 wGL0YCqQ86HKcgszbQ2z1mwC0qec2sZ7A9/KJACTCUkvxsxBavF3drOZ3Ga/O819Ppmg
 +O5xmhvoa7eU414aDZsxv7diN00QXG3xZlvzhfZj7mWsppoebvv3VRJMd9mzk6SIUzYB
 LAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403120; x=1793007920;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xKo/4l25o62uaIDmPhFxXtrVUZ8/fCH7zbFgnGgw9jo=;
 b=ueEsKVtV4apy163HoXu8jUoq+rJGDIXG5URVpfpZBcUV7aSXw2dEfURwOQROSB3XEC
 INhwhNROVvYcUDrTVGPkuu9yc5yPJdeE0DJq5rwY+Ri+kuuBj96TTxkLgm9pVenbgFjd
 yn/C7NlnNO7ubOrjVkCjnVWimAVdpQB7JrBG7gQ16dxLR9gq7E68+gQCKQbSX/w+oIKl
 7yq2EjBUJ6RjWyIa0HC0wnOYtBNdJk31NSCM+X9idxrvt50flKlNFko2eM3JQkJj+iPY
 TcQ+qgYYnl9MsVcPsHpAvEcb1CsyHNLmziONSgOU4h1/OKKlR8efYgMvspldRjzTreu3
 ZuNQ==
X-Gm-Message-State: AFq9FYJur4vPeXlFv3f1ZBE7OnbYxLZ4dwvevEwM394Yj3ADaud0PK3E
 m/7y7Ir43Xvc5u81m3QnwpDqvUDgvYTenMuQRKMUtL6WvMaKVZO6rj1EuEdnikFW1Jtgj0NgZY9
 SnGWIAGuyhsvcoQcdlZh1XiNV5MmxJnfDf4DgMqK8Vg==
X-Gm-Gg: AYBFou0wXHrJCZwRJ84KBzbzbKM8oj7nJHSEv8bVfFsRcaV2oK6hBPQOFa83P5vJkKG
 cme6nQxcvYVdAMrOCH4IxfLMy4O+aHZ1GSS2YSwHv27YyoOsVMfVH4r92eCnNmBUQ1xVC4cmomU
 7UFXxSka1eSc0bs6v5yf5DYwuAU1cfYm07gWIsaKj3xzsYfAxh7+btscKNr/mbD02Wick/aE5G+
 g3QJ127gVQVThcoVCc0QKqG+BexmYRQAGvKp3GqGiF+f8xJEchU+SAQ+ZLkCX60GhjkwmjuDEKB
 7H6FN8YxXWsA0sFOOp3flTicRyHyMqfO3JZLPtO3DRLGIB+2JuIoN+C7khuhIsJ9ipp10J8XtbV
 LoV/eSqywWi3NRtY13jl20P7uG18euMxUKy4jmEaw
X-Received: by 2002:a05:690c:dd5:b0:8b0:f0f6:1476 with SMTP id
 00721157ae682-8b0f2072830mr24054677b3.15.1792403120329; Mon, 19 Oct 2026
 02:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20261015163352.1751191-1-peter.maydell@linaro.org>
 <bdf28ad1-a8ec-4e13-b49c-34b12d7580cc@nutanix.com>
In-Reply-To: <bdf28ad1-a8ec-4e13-b49c-34b12d7580cc@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 10:45:09 +0100
X-Gm-Features: AclHuK_cSWdHeBKoH7OkA17AQD-PzeETwXWYUqulwB2AkvYYU9AjO-ifFf-LPh0
Message-ID: <CAFEAcA_RsNToGACV3vX1Gcr+j51+-Tv3Te+LAOEwhGnBHZED8g@mail.gmail.com>
Subject: Re: [PATCH] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 16 Oct 2026 at 10:09, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> On 15/10/2026 17:33, Peter Maydell wrote:
>
> > The documentation for device_class_set_parent_realize() suggests that
> > the parent realize function pointer is "usually in the instance
> > structure".  This is definitely wrong, because the function pointer
> > is a class thing, and should live in a class struct, not an instance
> > struct.  Update the documentation to correct this, instead
> > recommending that it should be placed in the class struct for the
> > child class.
> >
> > At time of writing, of the 75 or so uses of this function, about 50
> > put the parent_realize pointer in the child class struct, and about
> > 25 in the parent class struct.  We recommend the former both because
> > it is the more common choice, and also because it makes more logical
> > sense: it's the child that knows (a) that it exists at all and that
> > (b) it wants to have a realize method that will mean it needs to
> > chain back to the parent, and we shouldn't need to edit the parent's
> > class struct because we want to add a child class that chains to its
> > realize method.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   include/hw/core/qdev.h | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
> > index 8e91e2fcb08..1330e0153d4 100644
> > --- a/include/hw/core/qdev.h
> > +++ b/include/hw/core/qdev.h
> > @@ -953,9 +953,18 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
> >    *
> >    * This is intended to be used when the new realize function will
> >    * eventually call its parent realization function during creation.
> > - * This requires storing the function call somewhere (usually in the
> > - * instance structure) so you can eventually call
> > - * dc->parent_realize(dev, errp)
> > + * @parent_realize should be where you want to save the pointer to
> > + * the parent class realize function; the recommended location is a
>
> Do we need something stronger than "recommended location" if we want to
> encourage people to always do it this way in future?

I think the discussion here suggests we want to get rid of
this function entirely in the future, so being stronger
than "recommended" is probably a bit moot.

> > + * field named "parent_realize" in your class's class struct.
> > + * (Some existing code puts the field in the parent class's class
> > + * struct; this will work but is not the preferred thing for new code.)
> > + *
> > + * In your realize function you should chain to your parent's
> > + * realize function using something like::
> > + *
> > + *    MyThingClass *mc = MY_THING_GET_CLASS(dev);
> > + *    (do your child class realize actions here)
> > + *    mc->parent_realize(dev, errp);
> >    */
> >   void device_class_set_parent_realize(DeviceClass *dc,
> >                                        DeviceRealize dev_realize,
>
> Otherwise:
>
> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Thanks. I'm going to queue this patch as a fix for this API doc
for the moment, because we clearly aren't going to get
to Daniel's better way of doing this for the 11.2 release.

-- PMM

