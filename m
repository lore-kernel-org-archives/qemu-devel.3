Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A106CCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQCq-0005oK-P3; Mon, 10 Nov 2025 06:37:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIPs1-0007dt-0U
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:15:42 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vIPrx-00054f-49
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:15:36 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b72134a5125so414084066b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 03:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762773331; x=1763378131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZPywwabZb+QCHESBwj0/v4EggNmWHyi2nYsN2LNmVDU=;
 b=hM8dNe0oeup9A8w/uZy0c0/tqmQxBrDCFIM1zy4wyNWnZThT0+vVRj5ej32bxUg0Iq
 UfWxU5CLH4iKzloXVWQnWPpVrEdvs12XHyLEFp65ijrXyHIoayMiv4HFG8oIMLzOOFSl
 tUT9UQgwQf6omn4eoTUTepsIycs+bpy7q9oW4+jW4dRBVU3qtZlvLcTAXCMrhyLXHuet
 6Hzvkz6Kd8WrxutFO0rdtq8oS5beXXH89IUnX5W2FCqNZKx0sGofJDiSj5gS52kF/foT
 OoGy/rAkRPUHKEiJYUw1j7uWwLmTbxHyt/z4dIVunlTCbPkBVpiB+j1nxmvddfvb9wqr
 H/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773331; x=1763378131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZPywwabZb+QCHESBwj0/v4EggNmWHyi2nYsN2LNmVDU=;
 b=KJB71flvob/dRLQI2PD68wf7SYOn5J09XWct9ftOA/9+7Cm7whECA6pZT72r/J9Fbg
 swr310TxMpuo+3uHmHENnrrjp/PH25zpU6fqgs0OHpV3ki0rCBoUtUH3FjMpLveurXkV
 RqiQhn+JncfjJJrt200/pj2qWSYX9irTYrxZFFDfF3KsjF2mVj21zJDAPLbfi5EuESGs
 F/08kJkGZbc1bRuz8yUTSeqA3v2bltGwpIENjKTIOrUr1S5u2JOEn5GFH/VuWnbIn46g
 wZOkiW3jpb0rw6OvweIrcgJAtwOgntJgp6QS6VQMQKNdbsXJm+mC17dV0jTqKiiwT/AK
 5o/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSKtH8+7xvlFYt1nbf8ZaGosBsDG1xNS7fUyR+1Pj8uxZD3l1zIaF/VQrYwcIfDqanF58VT+F2+fxn@nongnu.org
X-Gm-Message-State: AOJu0YziYAlYAC1h4BsDICWTzQAUAdlm65GCeCGM6gzocsFEJAd0ESQ7
 M177TVH72YdP1i8ZfmEOgaZ4Z+bRdKFG6iEX8nBrJC0f+lyaWvdC1yh/20420jlxvSnJqwAyWj2
 HyCwRf7NsL7wnYECazk0I8aMd4o0fsuycUUd+6SDr
X-Gm-Gg: ASbGncvw+1nbL25mJ6JKp5eRjs5sirY0FcoGA+zsUOj2s4kOaESKSszy5zQqg48/VXH
 JgZxkzESx3SlgNHj/0SBkuQSGSF0y+/U6V9IH2ZIO2GTRj2ASfYqEtkcgvBEEnBIY4r+HH3mmmv
 inO+uFFEnj678uPXd+RY/XIew/8tjDNIm0yRSuvd7/awOnFkLcEVJf/W5hR12+et3pftcKK+vJL
 QR3AjUYf7Z58ZCIQivXmxCvaA/6HM7OEsTdi1V6NEwSOzGm7pRwENRq+3kl
X-Google-Smtp-Source: AGHT+IFbQFDzTXiiY1iP0OE4DHU4pzOC06VlRgtFTCEQqVtW8Y7QKK4DXgZRrnRpUhxmnWh3oz9KbFNUC2L/kI+pJTQ=
X-Received: by 2002:a17:907:da3:b0:b72:b389:b799 with SMTP id
 a640c23a62f3a-b72e03617ffmr694553366b.23.1762773331556; Mon, 10 Nov 2025
 03:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20251107145327.539481-1-chigot@adacore.com>
 <20251107145327.539481-3-chigot@adacore.com>
 <874ir2nqr9.fsf@pond.sub.org>
In-Reply-To: <874ir2nqr9.fsf@pond.sub.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 10 Nov 2025 12:15:20 +0100
X-Gm-Features: AWmQ_bmoUDKj7Iocm7bn99SNNEZLUzgcAIb00YYfFpP9_6ayNoXWGIanHsOqfp4
Message-ID: <CAJ307Ej8oNXjOZt2fkBMjR6bKSf=C2M6ncFFLCfy=Wk6+KMhNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vvfat: move fat_type check prior to size setup
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=chigot@adacore.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 10, 2025 at 11:09=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Cl=C3=A9ment Chigot <chigot@adacore.com> writes:
>
> > This allows to handle the default FAT size in a single place and make t=
he
> > following part taking care only about size parameters. It will be later
> > moved away in a specific function.
> >
> > The selection of floppy size was a bit unusual:
> >  - fat-type undefined: a FAT 12 2880 Kib disk (default)
> >  - fat-type=3D16: a FAT 16 2880 Kib disk
> >  - fat-type=3D12: a FAT 12 1440 Kib disk
> >
> > Now, that fat-type undefined means fat-type=3D12, it's no longer possib=
le
> > to make that size distinction. Therefore, it's being changed for the
> > following:
> >  - fat-type=3D12: a FAT 12 1440 Kib disk (default)
> >  - fat-type=3D16: a FAT 16 2880 Kib dis
> >
> > This has been choosen for two reasons: keep fat-type=3D12 the default a=
nd
> > creates a more usual size for it: 1440 Kib.
> >
> > The possibility to create a FAT 12 2880 Kib floppy will be added back
> > later, through the fat-size parameter.
> >
> > Side note to mention that s->sectors_per_cluster assignments are
> > removed because they are overidden a few line further.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
>
> Is this a user-visible change?

Yes, just "floppy" will now result in a 1440 KiB instead of the
previous 2880 KiB. However, Kevin mentions in V1 that it would make
more sense and vvfat being known to be unstable, this would be fine.
FTR, here is the complete comment:

> On Wed, Oct 29, 2025 at 5:06=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wro=
te:
> > In general, our stance is that we can change defaults whenever we want
> > to, and if you don't want to be surprised by changing defaults, you nee=
d
> > to specify the option explicitly. What's a bit strange about the vvfat
> > interface is that the default actually represents a configuration that
> > can't even be expressed explicitly at the moment.
> >
> > So it is a special case in a way, but given that this is vvfat, which i=
s
> > known to be unstable, not widely used outside of the occasional manual
> > use and not supported by libvirt, I'm willing to just make the change.

