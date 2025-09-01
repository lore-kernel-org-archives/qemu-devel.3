Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A5CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 16:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut780-0006kx-VM; Mon, 01 Sep 2025 12:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut77w-0006j3-HB
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:11:30 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut77u-00059F-Je
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 12:11:28 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71d60528734so33906667b3.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756743084; x=1757347884; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7sQDSMaIB+/AzJvOG6iWt+SKBMb5qXkYgbO2mfOkf0=;
 b=k6lvdt7qZVq+3rMXzpBYthgZKPTSM/SJstj6cBLU4lr7/38lvgPJzZVYQStVUFXCQC
 yNPduR/+LepBUiBt5NLlUpKT3E2M5kzB8GuQDci8m7uuVQkMiA71eKBZGlu2QJgYFcWh
 YKi0rNjqmD1jd8okNEwijgmJxBK4FtSSDGO9fDhr9CIg8IuBWuOKjrHuuvr7hlLz8fYD
 q+h3AMtRtg44m6M4I4yMClEBXapVXZE2vFqY+ZgL0WV+0I0yhJlTW9Ou/QGd2tRAmsam
 uxOLqgjSYYx8bnA+JzC9QS+ed1Kpr0IIjDB2yeGItCSGTANCpG7l/ochHyC2TcZQKm+l
 XJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756743084; x=1757347884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7sQDSMaIB+/AzJvOG6iWt+SKBMb5qXkYgbO2mfOkf0=;
 b=NqNXY+wWuCagwxp7c3JxdWKEpYI+bgAp5Gr+ymQHgrgxp5KSxZxuoZGOb/lL5HCA21
 UqrLTuz3JcrjsMtfI8PMdsWrG8sWCY+CCdhXcPqk46CIHaQNPUxstJY/g2mFCDf/CUwT
 Z/nIDhepgkxJuDMMifjrIZgGT68tFMdaY3JS6LbXKMUavoY3XXumTZ9TnWoKc6TWGBF8
 hoYb5NXm6ptT64lT5zgX9vrAe9grRjpLkm9/qlyJemJiP/j3TzegJ4dAJmtbmCp6fdVb
 s9ZnqK5ADCHkg+FLSDt3Kw+4JAq4v8DgVPkgSzle/YXZIftAgWdaFU/YZcB2DjRYTE3i
 InCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMwFSYryuh07vBS2ImeQAzxCsQSgwanOvsU5x6EXoqldXOwcCcFh+wvpy3Wu7Pc+p4nE5AHvW6ln2P@nongnu.org
X-Gm-Message-State: AOJu0YwCO8+lfmjzhHTuBDV1DvCBdWkjs8b98gWtcktR0nCKhswygOOn
 TwbTldvLoxnX5ZWOmEd7U3J8X+8co4LFf48icdi8MH5oR0t3CjWX4ScUg8f+aCqAwZZdFNImigT
 t7zuVX3SNO6JBLyzJfD9B0HfcD7/RLlwvC1pCXmNP4w==
X-Gm-Gg: ASbGnctZ6YnKVeZmPYY9sBSQaIie3Nt2vZm4oYqxiQjrvtmvH1A5WUkHQ94zQNZ8PGb
 9XTq36A5abhN479qSncOdRCUnfmAdyQKqb+bYZVfQrtcEaOMPOkYo4Ll4CY4S3mNjvfZlnUqtzU
 nqA5AcfrIxPpVU8/wmUT+UKNzKQZLNTxadDcjlWcwKIEh0q6IRAArXZqE7EIx0tVsZW3Es6X6v7
 aP9hOdSkjjK2QUx1GQ=
X-Google-Smtp-Source: AGHT+IFYPXOQL4L7sdj440lSyYEe+Ga3eUnYe4/WMeY2ibWjAKyjhXKwUwn8kjvmN5xiVhTCUsUT+sEbc/kBtUu4uYQ=
X-Received: by 2002:a05:690c:368d:b0:71e:7053:262 with SMTP id
 00721157ae682-72276500db1mr97959017b3.26.1756743084077; Mon, 01 Sep 2025
 09:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250506164602.3897164-1-stgraber@stgraber.org>
 <aBsduLe2QDbr4Ol1@redhat.com>
 <CAFEAcA-3kqoLWA3WRuL+Lwk_ozo2cYOh_A3_AsPB=Crxu1Zhgg@mail.gmail.com>
In-Reply-To: <CAFEAcA-3kqoLWA3WRuL+Lwk_ozo2cYOh_A3_AsPB=Crxu1Zhgg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 17:11:12 +0100
X-Gm-Features: Ac12FXzyJhVUVKzoto3_Sx-cnSwoCdvXP7e1HQgNvGrDJ7Xe3XP-rKmlUfxa5iI
Message-ID: <CAFEAcA9twir+TeeiYVmdMVy0s0FcMuSDAmAun7uj3Bw8+Br9PA@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/network: Remove hardcoded 0x40 prefix
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 12 May 2025 at 15:10, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Wed, 7 May 2025 at 09:46, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> >
> > On Tue, May 06, 2025 at 12:45:53PM -0400, St=C3=A9phane Graber via wrot=
e:
> > > USB NICs have a "40:" prefix hardcoded for all MAC addresses.
> > >
> > > This overrides user-provided configuration and leads to an inconsiste=
nt
> > > experience.
> > >
> > > I couldn't find any documented reason (comment or git commits) for th=
is
> > > behavior. It seems like everyone is just expecting the MAC address to=
 be
> > > fully passed through to the guest, but it isn't.
> > >
> > > This is also particularly problematic as the "40:" prefix isn't a
> > > reserved prefix for MAC addresses (IEEE OUI). There are a number of
> > > valid allocations out there which use this prefix, meaning that QEMU =
may
> > > be causing MAC address conflicts.
> > >
> > > Signed-off-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
> > > ---
> > >  hw/usb/dev-network.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
> > > index 81cc09dcac..1df2454181 100644
> > > --- a/hw/usb/dev-network.c
> > > +++ b/hw/usb/dev-network.c
> > > @@ -1383,7 +1383,7 @@ static void usb_net_realize(USBDevice *dev, Err=
or **errp)
> > >      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr=
.a);
> > >      snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
> > >               "%02x%02x%02x%02x%02x%02x",
> > > -             0x40,
> > > +             s->conf.macaddr.a[0],
> > >               s->conf.macaddr.a[1],
> > >               s->conf.macaddr.a[2],
> > >               s->conf.macaddr.a[3],
>
> Note in particular that this string is used *only* for
> what we return to the guest if it queries the STRING_ETHADDR
> USB string property. It's not used for what we return for
> the OID_802_3_PERMANENT_ADDRESS or OID_802_3_CURRENT_ADDRESS OIDs
> for NDIS, or for the MAC address we actually use in the QEMU networking
> code to send/receive packets for this device, or in the NIC info
> string we print for users. In all those other places we directly
> use s->conf.macaddr.a, which is the full thing the user asks for.
>
> > To repeat what I said in the ticket, the 0x40 byte originates from when
> > this was first committed to QEMU. We can see the finall accepted patch
> >
> >   https://lists.nongnu.org/archive/html/qemu-devel/2008-07/msg00385.htm=
l
> >
> > but tracing the history back further, this was *not* in the version of
> > the patches submitted by the original author 2 years earlier:
> >
> >  https://lists.nongnu.org/archive/html/qemu-devel/2006-10/msg00339.html
> >
> > There's no explanation of this difference. Could easily be a left-over
> > hack from some debugging attempt that no one noticed until now.
>
> That original version of the patches is even odder, because it
> does this for the STRING_ETHADDR:
>
> +                       case STRING_ETHADDR:
> +                               ret =3D set_usb_string(data, "40010203040=
5");
> +                               break;
>
> i.e. hardcodes it entirely.
>
> I think we should note in the commit message that the hardcoded
> 0x40 is only used for STRING_ETHADDR and not for any of the
> other ways we use the MAC address. But otherwise
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I just noticed that we never picked up this patch. I've taken
it into target-arm.next (and added some text to the commit message
to reflect the comments in this thread).

thanks
-- PMM

