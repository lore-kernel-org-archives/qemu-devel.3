Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBE7FCEE8D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 11:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvDFW-00009L-A6; Wed, 25 Feb 2026 06:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvDFV-00009A-GI
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:40:13 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vvDFT-0000AS-Ll
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 06:40:13 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-65f71ed7c6cso2536149a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 03:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772019610; cv=none;
 d=google.com; s=arc-20240605;
 b=Y6ZYR+Dg0Igk0nL1jNs8mzz2vmUtiklQhA6j6MvJOWdYwbeCEGqgxw5ylW8GM5LR5u
 Vr6V7UjQ55BOc/k7g5dK1+FzzATYPfr4TKj8Zaj806z1Vr+1PJOU300VKr1Ih17i8XKN
 kw6VYVb+0D644zt9A6GDRdI6xM23cv56nMdxjz+nx8bJ4hm3f5wJKwa/VpPQWqz0WiZ1
 mizP/HSG6rVfSFFtcDbMXVzWA6A9M8lCw4IPuig401H7lSRUV0ifXkih7fWs3ZM1ufvR
 MhzmLlKGYA2tMJnKdqCSbDRsmYkW4bgYIcN8eefgWngOykFqPmxFFqeCX8tsVCDfbzfR
 vg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZWcgbGvxUsjGVL6JWys9m+9O0kSpvi+Ac49KQu1AM04=;
 fh=2vCTedxg5r0JPg5LnC8s7len6poc60rIFIIE/ngH4cY=;
 b=AIvnaqj0dVBlyBrAhZVjhtPQtJa+xTB0ue5X1NC+hJgyOBdQ6rj+U7qXz8GwzWkkdM
 a6hpo4T58JzEX15z4kDhYrKuoNVoz9zfF68bhvhso5AtMSL6MINTGjgjI1ijYI+yEvPU
 wrEUEOIbelyIf7mVQNoj0UualKlGg/RWneVuNwCkY2yeleh2Ju8A4WzGionFssT3o7Db
 kV5kOO9YNtvo/aeYWsogD6o4MapD1Tjyo3LT0FLFc8mE03cZmGvTqT5qm+XmabfdFmnw
 ZjRQ4Av3f0hqI/B3y+1KILK1ZdxuPe2LLvcC+/Pw5vgQaCiyDbFp067beNlGLINSvUQL
 6d/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772019610; x=1772624410; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWcgbGvxUsjGVL6JWys9m+9O0kSpvi+Ac49KQu1AM04=;
 b=hzpZFiml6LS+2sml1du1/CsCLgK2LjlT/FNdWVj3mJx7U5lLUlDfwl5lGzTZvWc/Ip
 pRR87kRCS8eBTyI6gM0wBtntbCpHOXjtbID20I9q5ISvRPOGRXASElngW9FC5QeM6+ir
 Ny4OcHakhaBaEdK8LnTF6miSicu64Pf+m3S6ISUGVHZOfXjdSD6mttAjDf8QzFV4T0Ib
 V87jYa+WMc1Qjcgqm/Q6b6Q8dRToo7k0htnY/9o347M+C6f8c00UTYD5ETJvwVQbizGY
 2ZSMMTR+Vs3JCJ5YF2r4be7HIyDKVrelpfwSRcCfcb6oSEPeiTegA0OwwTV58vpvo434
 /FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772019610; x=1772624410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZWcgbGvxUsjGVL6JWys9m+9O0kSpvi+Ac49KQu1AM04=;
 b=R7JXfWKh/XvkCuS8bbNxdvEqPJVBKpAdluoPZHYSCKOzYDGBHlqc2gedIoqOvhneRz
 dEa9DBYNPS06adv9y1yK9icF3ZaWZQkw75XAdQmkLz4K/qXWCGQQEvwqKM5fBdfuDKWM
 7tgTQdXufu6EtndWLGLo1vLei3fqnAB1hwKcUNlMsT0hcK9cmp4ZDuZvP734QCPq0dPp
 uZwpZF70P2D19j3NcG/NUFCLAHzHCq5IDYuqiutlYMwX3WRlPQGT54sai0OToPIamS2L
 OZvjJLyY1QfxIol1rDPXAOWalqE32Xa4iYGcgWF/Hh/n+4WB743gYPYvgyJKXf+DQULb
 7dxQ==
X-Gm-Message-State: AOJu0YzJr0emqQ46p260AUO9GOSku9QnB7AUWi3rv985JGxZeJLxLaSu
 dKxz9fV9UKzxm+tOwP5cl3emSPYEZFlscThVhQOzgeJWl8now7oUBXdcx6L75jsnh6xFSxCpAGk
 cHgsPL29SjtJLjz++sRDyqqwRK8jwWo8=
X-Gm-Gg: ATEYQzxPk54xd+K9I2NzpiIcYkszlwh7ytMXb/v9JrbvUnLfAcEnQRZfU0R/B8QRZtZ
 ZygBtMH17D3fTO+nhv2NwpicCzzrKmhkpfmQx36aLonzWnuU+TbVz6v0YLkFkQh7tDLhL+C+/jv
 reoQ5h+zF/fNmxibK8poxkSGW447PCYD3OG8LFkiyxl2DGEgqudVRuDyiPhwH7mWwA6+PHDF65L
 nu3GxKZzA5oO+jzHhtuDnvXMhLYhuStMXh3Bu3itdNUuFpeBwdSgyv/1Iq76h82aZKEx3Qmlu2R
 HpLCZ80F
X-Received: by 2002:a05:6402:2110:b0:659:4a1f:c6a8 with SMTP id
 4fb4d7f45d1cf-65fa477dbd7mr144015a12.12.1772019609762; Wed, 25 Feb 2026
 03:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20260213171622.55629-1-zhangckid@gmail.com>
 <20260213171622.55629-4-zhangckid@gmail.com>
 <87wm0bq047.fsf@pond.sub.org>
 <CAK3tnvKEJSDMVC4bkEbhfsVXpp7nVbq+Kue9fFVmOrd5f_ugCg@mail.gmail.com>
 <874in65y7r.fsf@pond.sub.org>
 <CAK3tnvJ=_rp-JjkrgMA6cf+WXc0oHFJeQ5CsQsLf-fEd1ikGgw@mail.gmail.com>
 <87jyw1um82.fsf@pond.sub.org>
In-Reply-To: <87jyw1um82.fsf@pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 25 Feb 2026 19:39:33 +0800
X-Gm-Features: AaiRm50_a8gzCRrJt2Zduii7HZZ0fLx7d6w2rkmrL_W03lYKIypjeHYRw2UiFl0
Message-ID: <CAK3tnvLFNw2HvMi_b=huMf3exD1RWPg+kpKSw3ER+6vAXya-bw@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] qapi: examine IOThread attachment status via
 query-iothreads
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Feb 25, 2026 at 6:55=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Tue, Feb 24, 2026 at 4:42=E2=80=AFPM Markus Armbruster <armbru@redha=
t.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > On Tue, Feb 17, 2026 at 3:51=E2=80=AFPM Markus Armbruster <armbru@re=
dhat.com> wrote:
> >> >>
> >> >> Zhang Chen <zhangckid@gmail.com> writes:
> >> >>
> >> >> > Extend the 'IOThreadInfo' structure to include attachment metrics=
.
> >> >> > This allows users to monitor how many devices are associated with
> >> >> > a specific IOThread and identify them by their QOM paths.
> >> >> >
> >> >> > New fields added to IOThreadInfo:
> >> >> > - @attached-cnt: An integer representing the number of devices
> >> >> >   currently using this IOThread's AioContext.
> >> >> > - @attached-dev: A string containing a delimited list ("|") of
> >> >> >   QOM paths for the attached devices.
> >> >> >
> >> >> > These fields are also exposed via the Human Monitor Interface (HM=
P)
> >> >> > command 'info iothreads' to assist with manual debugging and
> >> >> > performance tuning.
> >> >> >
> >> >> > Example QMP output:
> >> >> > {
> >> >> >     "id": "iothread0",
> >> >> >     "thread-id": 3134,
> >> >> >     "attached-cnt": 2,
> >> >> >     "attached-dev": "/machine/peripheral/blk1/virtio-backend | /m=
achine/peripheral/blk0/virtio-backend",
> >> >> >     ...
> >> >> > }
> >> >> >
> >> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> >>
> >> >> [...]
> >> >>
> >> >> > diff --git a/qapi/misc.json b/qapi/misc.json
> >> >> > index 1f5062df2a..ca53638684 100644
> >> >> > --- a/qapi/misc.json
> >> >> > +++ b/qapi/misc.json
> >> >> > @@ -76,6 +76,19 @@
> >> >> >  #
> >> >> >  # @thread-id: ID of the underlying host thread
> >> >> >  #
> >> >> > +# @attached-cnt: The parameter is a counter indicating how many
> >> >> > +#     active devices are currently associated with this iothread
> >> >> > +#     (e.g. virtio-blk).  In hotplug scenarios, users can
> >> >> > +#     pre-allocate multiple iothread objects to serve as a persi=
stent
> >> >> > +#     thread pool.  When a device is hot-unplugged, the correspo=
nding
> >> >> > +#     IOThread is released but remains available, allowing subse=
quent
> >> >> > +#     hot-plugged devices to attach to and reuse the existing th=
read.
> >> >> > +#     (since 11.0)
> >> >> > +#
> >> >> > +# @attached-dev: A list of QOM paths for the devices currently
> >> >> > +#     associated with this IOThread, delimited by " | ".
> >> >> > +#     Returns "none" if no devices are attached. (since 11.0)
>
> [...]
>
> >> >>
> >> >> QAPI schema design maxim: do not encode structured data as strings.
> >> >> @attached-devs should be an array of QOM paths instead.
> >> >
> >> > OK, will fix in next version.
> >>
> >> Thanks!
> >>
> >> >> Unless I misunderstand your docs, @attached-cnt is the number of QO=
M
> >> >> paths in @attached-dev, i.e. @attached-dev is redundant.  If this i=
s the
> >> >> case, drop it.  If it isn't, educate me :)
> >> >
> >> > As Stefan's comments, I try to address more specific needs:
> >> > https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg01892.html
> >>
> >> As far as I can tell, Stefan asked for the QOM paths of attached
> >> devices.  @attached-dev provides it.  Good.  Why have @attached-cnt as
> >> well?
> >>
> >
> > Users can obtain the quantity more conveniently, avoiding the need to
> > count the number of @attached-dev.
> > If you think the @attached-cnt is redundant, I will remove it in next v=
ersion.
>
> Please do.

OK~ Thank you for the suggestion.

Thanks
Chen

>
> [...]
>

