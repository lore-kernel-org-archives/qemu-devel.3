Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F02EC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrhI-00086S-NV; Mon, 22 Jul 2024 07:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1sVrhG-0007vZ-QM
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slopezpa@redhat.com>)
 id 1sVrhE-0005ns-QC
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721649555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhfsnpSNnCGEtcwghUOCEcNIYD417hcb83o28ux0s3Q=;
 b=RqU9W3PfjkKZ/uDTU3tvuGoIeDPex0qM1AAb8yXh1xLMnp88dGml7gHb0RvtI69PKZmdga
 ltIUHDmSIqDfiqE5Xxf+2W50/dk3WMBP8AaM4ANrVeTAEMkO7syN1ipVO24osYd1h8ydqs
 3dysUwy7MuTOXPAE4BYrXqoR5gyPurQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-0dCjp0QQO22DxyP5epeJUw-1; Mon, 22 Jul 2024 07:58:07 -0400
X-MC-Unique: 0dCjp0QQO22DxyP5epeJUw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-70d1a747ee6so1720264b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721649486; x=1722254286;
 h=content-transfer-encoding:cc:to:subject:message-id:date
 :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nhfsnpSNnCGEtcwghUOCEcNIYD417hcb83o28ux0s3Q=;
 b=IHwiJZKzsdeMOxda1d7wKsLfCChftooXMpFLHEHkiN9Oy23FurPE4s7fBZHfUu1ZQ2
 3v6zbzxlkPSm6yzuvU3GJsa67Y7ByQV4FmqJAOcBBsOLXw3Lg1wWOMSxNroPuNOw81Bm
 V46RfmNe0PFqRAn2+T5ziUluwvlEwiyndFH8/ogldFGoZXCckcc7/Nv9Sf6Uez9dDugn
 UFUVEoL1hrbfYTxWhNNsaN7V19uFFr9Pqi4VK9YrNSnp9+eTM6gXjMERkBtasYn8Vcn9
 QcKuM/uw7e99FZ6EihuZ3jn6BvkrCqefYtyHkhraZQEsFDGXYsWNAlnr5mNLleuOmNZV
 9B3w==
X-Gm-Message-State: AOJu0Yy/m5EdbGAZvUyQtCYwMZRuOGPku6tTYdPvfdSCBpG/aF+EFuJv
 RMmUJJTub/J0Z/o9dMJB+MJM3zl8O2DUEE4vU7TRfBsiAiSY/EXL5q/XdUXJ15MfPWc69r6T2ql
 vhpTkihOSdB7nKXdnas3PqkPXN9cFmwCirHA9LJLv8YO3iljEmlzNxOxNMPaXZHMlHqTyDno2w0
 FqXnFQT7VlntVjjRcnw+wgR2HjrLA18d26lQc=
X-Received: by 2002:a05:6a00:1789:b0:70d:2a5d:867f with SMTP id
 d2e1a72fcca58-70d2a5d8981mr3742218b3a.21.1721649485949; 
 Mon, 22 Jul 2024 04:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfcO950sRWZ5Bu2kubDRKGTZSeJA1uGuiBqsXlfK6I02JX0dk4hh9SDW49oEaqPSyMgLSZTY1cP33HgrI4KG0=
X-Received: by 2002:a05:6a00:1789:b0:70d:2a5d:867f with SMTP id
 d2e1a72fcca58-70d2a5d8981mr3742199b3a.21.1721649485543; Mon, 22 Jul 2024
 04:58:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jul 2024 06:58:04 -0500
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CAJ+F1CJrhUD5wyQDDauoTY=hok0BM7hUx99+5mK4tC4YkhtM4g@mail.gmail.com>
References: <172150520664.2040.13953223569736513482-0@git.sr.ht>
 <CAJ+F1CJrhUD5wyQDDauoTY=hok0BM7hUx99+5mK4tC4YkhtM4g@mail.gmail.com>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 06:58:04 -0500
Message-ID: <CAAiTLFVv8_i4ucbRQOSi9=ARz7kPzV--8HNzZ05zoeKvuOkt5w@mail.gmail.com>
Subject: Re: [PATCH qemu] ui/gtk: Reuse input event slots for GdkEventTouch
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 "~katharine_chui" <kwchuiaa@connect.ust.hk>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slopezpa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> Adding Sergio in CC, who wrote that code. I don't have means to test it,
> which also limits my understanding and ability to check this.
>
> On Sat, Jul 20, 2024 at 11:58=E2=80=AFPM ~katharine_chui <katharine_chui@=
git.sr.ht>
> wrote:
>
>> From: Katharine Chui <kwchuiaa@connect.ust.hk>
>>
>> There seems to be no guarantee as to how GdkEventTouch.sequence
>> would progress https://docs.gtk.org/gdk3/struct.EventTouch.html
>>
>>
> True, we also abuse the internal implementation which stores low integers
> in the sequence pointer.
>
> In the case of steam gamescope session, touch input would
>> increment the number every touch, resulting in all touch inputs
>> after the 10th touch to get dropped
>>
>> ...
>> qemu: warning: Unexpected touch slot number:  10 >=3D 10
>> qemu: warning: Unexpected touch slot number:  11 >=3D 10
>> qemu: warning: Unexpected touch slot number:  12 >=3D 10
>> qemu: warning: Unexpected touch slot number:  13 >=3D 10
>> qemu: warning: Unexpected touch slot number:  14 >=3D 10
>> ...
>>
>> Reuse the slots on gtk to avoid that
>>
>
> But doing modulo like this, there is a chance of conflict with already us=
ed
> slots.
>
> Maybe it's time for a better gtk implementation which would handle a prop=
er
> sequence pointer to slot mapping.

The problem with slots vs. sequences is that, from what I can see,
there's not way to obtain the slot number from EventTouch, which makes
me thing we're a little to high in the abstraction layer to emulate
multi-touch properly. And with GTK4 it seems to be even worse, because
it tries harder to process gestures on its own (we need them to be
processed by the guest instead).

Under some compositors, we were lucky enough that indeed slots =3D=3D
sequences, so we could actually pass those events as that and have the
guest process and recognize simple gestures (i.e. pinching) properly.

The "right" solution would be finding a way to operate at a lower level
than what EventTouch provides us today, but I don't know how feasible is
that from within the limits of the ui/gtk3.c.

In case that's not possible, the modulo workaround is probably as good
as we can get.

Sergio.


