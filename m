Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D665BCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 14:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKH5g-0007lq-VJ; Tue, 05 May 2026 10:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wKH5e-0007jy-HK
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:49:38 -0400
Received: from mail-dy1-x132a.google.com ([2607:f8b0:4864:20::132a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wKH5b-0000tR-T9
 for qemu-devel@nongnu.org; Tue, 05 May 2026 10:49:37 -0400
Received: by mail-dy1-x132a.google.com with SMTP id
 5a478bee46e88-2bdd40d3c61so6776084eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 07:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777992573; cv=none;
 d=google.com; s=arc-20240605;
 b=MOJ5tf4aHMZLpJ/Q8Wxmd3L/dPZagqyrY9AsVNjphE1K2QM44/xbg0y/FZDugsXExc
 FOgYXHv7zbTWJ63QIe2GpNOJDL2U+PdRECwgl+9OwwcPS362pb99wyQ1VFltHh6VwxdJ
 1mFpisPr71Hhph82Yls9qS0hcFP86xNwX78F8hc11DZNX2U9n+f1l264P2NLptVdxkDM
 pj81tVsWMwZygukzoWD0bIVw570EY5KpGVog8Rr7czSugA8VYlJRllqwnYG67NuDAJR9
 p6JQ1vtcOaCwMOu7KV5LEG5lANBXrUhRn67aZXwoIc+FHugWz/kgw79UV7ZZXkgHWm59
 lzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ffLEURxJLUDCP+jGetay6D1/gTP4RY+dTCMHslCt8GY=;
 fh=IIVq14YtGeHsqR1qXM8TWLElWWlW0t0XUfvIwOGX8mQ=;
 b=FsrNAop4qpB92LKa85412jxst3ToiyLr+fjkinS8vAaOmARprz/U/7sXJgpCrYb9v/
 4qL4a1amNBbOHf7JAWzHaLRRTBStw5muYUpsVCjHTux4aL1x/zW/eYIpcdn1W+aFRf2+
 DT92m8cNOkbMf24E+UbUJJVGyNZpBb96HnuNRTZ0aU0p84fUSmZDYy8apsLs2Bnaj9p4
 yfufSRuPb3WqCBN5hngKUDoLlJSgnd3y6xXwN5J6xFf3ocyqZt75BkQaIowwxdWcH9eV
 EV/R84dDtKxdGKa5MzgEllGvneHg2eW6R3ZMNPR5V8h8Rrk+TuAcZTfRx8WGVz7OZYZs
 H97Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777992573; x=1778597373; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffLEURxJLUDCP+jGetay6D1/gTP4RY+dTCMHslCt8GY=;
 b=ibs/IfMFuL+IguzQMyiY/iNYtcX1Pm/twzxpsmyPQzuXb13ZJzyhgExiXiFhsNRT7P
 D7GlwGM2CvgXyux2JYQ22yVW04kyki+tbI08vc3d/kE2RnahKcxCTYM10g7SSXLZnakd
 Mt9T25Tch6ox1qzUhQdweM1RInidaKxn8NFNUkeSGiY/x+jc6hCXdtHXaqZ+CzuSZU+Q
 e4U2kL38+J2xTh45tY96X0bxTN8vkWgikqL3cOF0e+BfMlASHUiGIQhz/JcxNRpxhCw6
 rOLgwwM4kpuwqzSlKD7vfc85VkMrYKHCaa3PrcDTivCM/95pcbpTTCVaY5KJ7Gkqu0Pl
 kS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777992573; x=1778597373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ffLEURxJLUDCP+jGetay6D1/gTP4RY+dTCMHslCt8GY=;
 b=VzQ2s1EKJCHtlb542MF+11ZLB8nu12wzpBZ1YFKFts1NEarhzA+mqMvmPSBJML6XaM
 VXmH8L/0r7Fifj4AGJijUY0Ql+Dx5eUJSzxVKyvNk6arYtOyYXN2ggbqg6nfIqc1vLqc
 xbcJBYo9xov7JKy8dzcTpwFu2XP//0Y03OKvFkKAnjwT24EIn8Dv7C2YWhF3qdG6lKtq
 qDwKQjbCdcrUUa3SrNi/FMeLXdOVfjfo7yW2+yLzVNHk9Zglf+jWcz3NbxTbsjKWLOty
 iLdf55/U/xB7zVDex3n+KQMvOLaMbuf944mpvGD6Yipg/Jfc23OJwS2xyZY7C/ZMLAgr
 PBEg==
X-Gm-Message-State: AOJu0Yyl+aXhlCKqDSsB5u7MJ/T9NvcEANgjKl+5ypxiUNJFvmIvSGbY
 nH6K1IZ1HelMJsifdgvZA66ynAAFSDQmLq0lcZsbhwy1FDUQQOmSvEOdMERbJZewrBkFU8Wa57F
 bwR1Ubb4W/WkKJxwzkUjNK8FSU7zNfw8=
X-Gm-Gg: AeBDiesTkfx/sGJzZtAQedx1dN5oh3oscEkr0f/hRCeop23BH7PmPzGFeTePxx2r+lR
 +XsZc7UTQQ5I2gwDwbLMLWWBn/Npogzc6guiktZpSDUNw/UmG6+GzOyKWQtTX5d1bGB8WZ0Darm
 +o7EFzef5ll4fDqgK8ReyrPNonkWuYdsEQ/Uz0fbWcMM/nBhR4O5QXApDSXHqPygMkmyHAEbvl7
 mA07FFA9t0YE+c03t/ZR6UBfPRv+jruILU6K+2pMOJquldEybIZAeweke639Uj93vL4plMgsi+5
 4kH7n2mnqjanGpjG3Bq04GdCMyI=
X-Received: by 2002:a05:7300:dc98:b0:2ee:f85:ec3c with SMTP id
 5a478bee46e88-2f40a18f78dmr1502313eec.30.1777992572955; Tue, 05 May 2026
 07:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-8-ef7e3dc94f7a@redhat.com>
 <CAFEAcA9PWJOtiw4-iJ0GZs7=3ZnbH1RdH-GWXi2hFA1jetcOpw@mail.gmail.com>
In-Reply-To: <CAFEAcA9PWJOtiw4-iJ0GZs7=3ZnbH1RdH-GWXi2hFA1jetcOpw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 May 2026 18:49:19 +0400
X-Gm-Features: AVHnY4K5-VzbbU10jT1Qqi-2OUU6m8CX8XKx3aA8wewQtLRR_Abxg9RTQS78mjo
Message-ID: <CAJ+F1CKOjP65rO2_gXJ-yuXZ2N_gUy9ez5er4ZJofHmXekwZeg@mail.gmail.com>
Subject: Re: [PATCH v2 08/46] hw/xlnx_dp: reject NULL 'dpdma' property rather
 than crash
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Tue, May 5, 2026 at 6:44=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Mon, 4 May 2026 at 12:38, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The type-checking macros (XLNX_DPDMA(val)) which crash on NULL.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/xlnx_dp.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> > index 50e6ef10984..876cb3d6642 100644
> > --- a/hw/display/xlnx_dp.c
> > +++ b/hw/display/xlnx_dp.c
> > @@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, c=
onst char *name, Object *val,
> >                                Error **errp)
> >  {
> >      XlnxDPState *s =3D XLNX_DP(obj);
> > +
> > +    if (!val) {
> > +        error_setg(errp, "%s cannot be set to NULL", name);
> > +        return;
> > +    }
> > +
> >      if (s->console) {
> >          DisplaySurface *surface =3D qemu_console_surface(s->console);
> >          XlnxDPDMAState *dma =3D XLNX_DPDMA(val);
>
> What fails here? XLNX_DPDMA(val) should handle NULL, as mentioned
> on the other patch. And xlnx_dpdma_set_host_data_location() checks
> for a NULL argument.
>

Right, it doesn't crash. I did it mechanically because you reported it
as one of the custom add_link setters.
I'll drop it.

Thanks

