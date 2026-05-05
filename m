Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BBEFF885A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCZe-0008Ax-Po; Tue, 05 May 2026 06:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCZc-000895-5T
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:00:16 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKCZY-0007JX-Ho
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:00:15 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-651c366f7efso4814700d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777975210; cv=none;
 d=google.com; s=arc-20240605;
 b=fqlgqUUmRCCJTun4278GquthCz0VTbeEoQNB/H+WGGScbZsDRie8oWwT6WCGjdw+p7
 h5Oa6Nyh00rno8EYlu3RTt9c/99/bO9jA1j9AyV2DwpMghT4OtSY8Fr8Xn8BfdKq0cwY
 ccWl+v17kkPCXnixU3rA8Ahi1/dDsqdQhZ34XX9i4lPNpxtzx1WrbI0xo8BVv/3r2t0p
 cgMi51snZClZEjIQOecSBrYFLI1c5krJZsRgtMHmh85n7GmOjqlsOrwFTCSZliIkPLcN
 IcmguM2PtdnV01GDCrJIxbvBoSptqi5RW7S/5nGfBTEa+UGw7+tajf7OkcNcT+VOICGP
 RZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KIFqDUO44WzNVPm5T2GxqemIW0fqI5WHUx4DTYFfzjY=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=dOUXB0MU0Q7kSeEHFXbGKn0JTpCprsMNWyG/GFN/1MuMrTGLpanl6/gE/aRKq/twgj
 94nLL8PeUPmeFOZlfOLzI9wlAVWmJDCGWahq6IusST3VK4z1ZkMx9zG9NNcDRz5R0iCt
 Ohzx3QRjGSi+0VSnAfYI3v/mmRxtaaWNStRFupvqJS1DBPyY92I95phCAE/a3IONGqw1
 pndeGwx5H4aMfTur4QROf+wpdZx7E3o/fIDzoE15DOVr+G1Up/iZncg/wh3AzZSiOAHp
 PQEhxDbdDDfVSMmUphRQ+AEXjojROb9fFWlBpyRdO+vFDkaOKz1rEX7Ee5xoZwvMvp0K
 sdig==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777975210; x=1778580010; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KIFqDUO44WzNVPm5T2GxqemIW0fqI5WHUx4DTYFfzjY=;
 b=gsgtqR7UbBhQbylmRbdTPNowSFibsV3sqVE6GKScfjUzRPono6STRNLRxOPJ34raPc
 DdFN4Egx8NDxhuWYWCwmZEfQvWFdLpavm/Yym1P4o5WKREnds/PP5L54AkIEQpleCtTP
 n7zkyG6WRl7Tdfa5/q8UwZKMQvIyvP8oV6nr4JXiQeud403ibwxbPSyDaspBU4AUpM0t
 Vk6ZSCMG8stkSs8rHriWu5PJEOYIuG/zoshCo767YXCmFbVjY8e6o8GO/wZfykj1dOoT
 3ZeY7ze+uapf2ZT8R0Q8PB9d6/cwsb0Q+G1SENmAITwzgFDV1uQ7teQ0Y+dKR/mO2X56
 STmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975210; x=1778580010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KIFqDUO44WzNVPm5T2GxqemIW0fqI5WHUx4DTYFfzjY=;
 b=gw8hCkDtt56YUx0IYKuGGy8m0Ckwhdq2DxGON/zNeFuWemhv/Mnvk/NzdmwfkJscrY
 4kQFr2hlu4HDGmRGsC+aJodXS19g0REKiDAd9C01YtaKcpM7i94tNsRlDL1gL026i015
 JvUbLUJKVE0cV6Iw9Bx5qWH6gXldlGdDZldC5joPDmRlCn1hvMbeluqVZ3jn8MnT/LEd
 ijFsmp5taJF0ceV9oJRM6moHXPhOVOA021NCX8tPI6BUt6XtR3/OXQLz2s/nI5555Ssl
 i/mSA+er5q7Sn40FLWQLGhIlifd1Ftn4FRSfjhsmoRuI5sfQQmyvfUEHoWpT/iiT1dcM
 yAjg==
X-Gm-Message-State: AOJu0YxpJPIsGJQlRUvBYeeD4z/ydjBtAHLvmQ4hqX1LxMe1L6CBk8n3
 0ppuSRG6wd37bDJ4SGYG73LGiI8kEsoPRwl+g+VJgD17zqY8qf2Pu6jGlUSyTOIBLPmaPuR/y3n
 vwdnPtMgRkDeMKahSxaTfu8LWdzfuWk3wS1tqLPNxZbKnfna/Q4J2
X-Gm-Gg: AeBDieuwBFHP3obBk0V3JnI9RTLtKmcTx981CwZdwm8MuQD0Y7fku+ofMAevn0sLsAA
 y+v0Z8Z/RvtVWjvl7bZL+hkcKH0hEbIfOUq/ndwCL9Alm0T7cqqO4/6SQZR5tESSc5yKaHN7F+N
 UomEliRalV0OZ2jix5OMjVesg7p8zMPyD8YG/KIMkOAVVa0v/mmZmQeuvrH/QQ+LoxrDPo7h89s
 z2COPUWHYCsZ6hkqJXifVfDTXaVEMCFS3gbjfKmVPlkXe57KMzMH/GDz4XpduNGbraPE3BjZ0O0
 PkAG+rex0gUOmIs4CGqrdtlxPiU14XU3Nz63mZbE8f5wPnAc3KGAOcFZ5n29kM4K/4Iph+iCFqR
 8jQ==
X-Received: by 2002:a53:d789:0:b0:65c:391:571c with SMTP id
 956f58d0204a3-65c3db4fd58mr10015628d50.49.1777975210208; Tue, 05 May 2026
 03:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-9-ef7e3dc94f7a@redhat.com>
 <CAFEAcA_JV6n=QwBRCGD2wVVkG9V8GMz9Es8sik9gTcf=NOxDPA@mail.gmail.com>
In-Reply-To: <CAFEAcA_JV6n=QwBRCGD2wVVkG9V8GMz9Es8sik9gTcf=NOxDPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 10:59:59 +0100
X-Gm-Features: AVHnY4KP4DLFPHRabIPYSlyUGg2xAAJdsDVs_DGU8lxlOEFP6k177Q7GjMMCh7M
Message-ID: <CAFEAcA8B+Ma0p6Ws=ZBYJX4xvQq9jLHXC6WKKeMVQw0h8FcjRA@mail.gmail.com>
Subject: Re: [PATCH v2 09/46] qom/object: update doc about NULL values in link
 properties
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 5 May 2026 at 10:42, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 4 May 2026 at 12:37, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/qom/object.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index 510885218ba..0a82e160cd0 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1714,10 +1714,10 @@ void object_property_allow_set_link(const Objec=
t *obj, const char *name,
> >   *
> >   * Links form the graph in the object model.
> >   *
> > - * The @check() callback is invoked when
> > - * object_property_set_link() is called and can raise an error to prev=
ent the
> > - * link being set.  If @check is NULL, the property is read-only
> > - * and cannot be set.
> > + * The @check() callback is invoked when object_property_set_link() is=
 called
> > + * and can raise an error to prevent the link being set. If @check is =
NULL, the
> > + * property is read-only and cannot be set. Care must be taken to hand=
le NULL
> > + * values for @val.
>
> I think we could perhaps expand this a bit to be more explicit about
> the lurking bug potential here:
>
>  Remember that the usual QOM type-casting macros will assert on NULL, so
>  you need to either explicitly NULL check before using the cast macro, or
>  use object_dynamic_cast() instead.

Actually I think this is wrong, see my comment on patch 7.

-- PMM

