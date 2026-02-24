Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5210E9B24D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 11:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuqJx-0007T8-Ux; Tue, 24 Feb 2026 06:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqJS-0006lr-0j
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:10:46 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuqJQ-0007hV-3h
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 06:10:45 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ad79df972so5179530d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 03:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771931443; cv=none;
 d=google.com; s=arc-20240605;
 b=br+e5kp+FeaibiDr2plYpZyzyvS68tT4+EK4rTshZeSt0mkcBcdqLz1WHK8Ng5dooc
 XdIfNIXpdtcXQWUIoAfKTda493fJJI3SHSNcRD27bHim1QA/FEAIa1Huw0ib/Bx/7C7n
 /9fMHkyRMj6vlY4W3H6T0X//H4KKx4qx3UT0Ei43I65ycKJx6UKpJr/fx8WWhE3uCbLb
 2Qt/WpR77TYgvJ2uZXFiC3Ad0lIa054U8ZWXS3tKhqvBb+DnNxzgCRPYZYAqsPJw3B6P
 2H6AGGq6m7W4oz267vJwRlTthQAy9mUYL7WXi9XJStykSkqUo5FF+cFagFDM/6cZKHPp
 Hoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xZRJ3ctSxbaUT75oXf9/WXyNPxvyS5YOHZ8QzeSyhvE=;
 fh=AGjDL07dZWDPdZMyc06pYmsaltCt24gRvPp391ZTe+E=;
 b=CMQVN9QwwqrqBWuvXtecztQyLsZf01Hye7KReEPhhgjrf8R7oYJGkSamR0opGnbBL/
 Rf/ZA/j+PMhJnSNEANL8ZJ8XL3K7aHppi0cPLWfQv6KRJA7lI6Xqx4ymE14Bg1/RG3ed
 j7HoE51dNwckxTTmzTcGEKyHI5GZtM5Dxa0NgHac8CvvaACthlUAa0nYqr7vg5M8ZPZ5
 ad7NLkA6RNfuMTh5xxkrGYLQeYafbFDS7DuXJnOwzdAznqZgiLmZ59OeZ4AyroU8/JB2
 scQ3iMgEHsZCcRAnAoGBHo47wvD/48v3yWkbSPF/7Cmc8F6jV0UZdH32yLRugOWVoqes
 kTyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771931443; x=1772536243; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xZRJ3ctSxbaUT75oXf9/WXyNPxvyS5YOHZ8QzeSyhvE=;
 b=OUYMwRGZMSGnexXUxQzZ7JVbzH5uijcm/0s0NOV3ywoWT+us/DNlz6GE+0FX32AItT
 tCEy/xzMWjah1Dky+1kiqn56bp2MVvMyOMWdu/tamlZh/9vzhiD1sKu9r2AMgl5XoN6l
 QSNPITOOqDrN1tU3xkPOoPkzNSWVRqXWyvLz62rPDNCJaUolRZ7AQArr8813HX+KJf0T
 xxY6Wtj91IPaEgASL/IHgkYbYYmmg/s/jOGaYs38yoxfnQKN05spWNOGr8sZw0K+T4u0
 LDQN5SH4cCduKs7WQ2dZ1/uJeICsvVnJsygDIBjVdePI65FIJHNyV2OgicUDEkWe21Vd
 z0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771931443; x=1772536243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xZRJ3ctSxbaUT75oXf9/WXyNPxvyS5YOHZ8QzeSyhvE=;
 b=WzI80XzlA/cWhyDG16eygcGDFEKnAsD9zCJRXn87XUCaIqBsCxBBNQV09ov50L62gY
 DRQyKruVZEmeGfidk/DLHxBMtYls/fLZ6tglXwjFD2HMl4c729094DPkjsKoZIFm+Pzy
 acFItijNE7YWqu9VZW0t0RhqNIgMBKHlY5AybsPpapngzdmgTtrj+sEyPedxnV/Y2/75
 gsSqRgHI0kpEgFXw2YyzH0nnrdPHoHIr1Ydy6kPGQ3jJLiFZV//RBD6a40AVo8mu8XWC
 6EFapkd2W48cbMP3J3xs/Oofx34FlzjpFfHXTd0arD1kaDRgBXBq4igivk0YbDO54LPi
 SB1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy0DweZSc69lzFVzXopshjjSHegtLt3YurHu9f8+JPwWCNISU0DJffN+snWDPLisu0ea3pvh12AW7H@nongnu.org
X-Gm-Message-State: AOJu0Yzunp4wEHQUfzQfIU2Kgn178nbtH+f4w0IYIkfHsDixqPqOxyyY
 1waz2mFfNuefkQv2t42Pj3gDfxtd+tIP9tBPdGj31OmI//B/t23KQoD8XOTi9DZwfh4wO4ZKeaC
 QB5ROflkLq2OqP8mXsexNzTPynNsl/8NjhM11ctjKpw==
X-Gm-Gg: ATEYQzxXre6oyMVZloZNYsRXbjrEVT4FZeEAtYlF2gRLg+iaMLkNKkHEXHgR+kigAcC
 xeOdTj22n/+vAGPuC5jtPBqLV+5eSjOxkl7ahjiAeX7D7kv3QWLgJzjdtzgorbYI6opVf+B29aO
 HvmorZu44U1oG907YJikvZcES7LTCAUMZPKgX0+mQbRCvRzNG54ntrHY6Y70/j7jQfDYZwTcg23
 wiLsytBz70cDw8fB32VoVZO00GuwlYqfOuhYodgSjhckwqyb6QpW/9zVkFz4GpFpX6Gs3zeYMf4
 OiAEhoS46nlFBBT8RFBOBxSshMIaitvvUAgVGq6r2etL/+lGFuP7mfYC8BGdTrVvYWzMkQAlGha
 jMA==
X-Received: by 2002:a05:690e:e8b:b0:64c:985f:9d5b with SMTP id
 956f58d0204a3-64c985f9ff7mr2642806d50.52.1771931442472; Tue, 24 Feb 2026
 03:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
In-Reply-To: <aZ1zsoyKcD1ChK--@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 11:10:31 +0000
X-Gm-Features: AaiRm5397zwx6nc7MKjuKi_kV8uw6DlcWVDirXzyO3aT_qRVi0ptex5TKcXoV58
Message-ID: <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/core: Avoid attaching qdevs to /machine/unattached
 if they have a bus
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Tue, 24 Feb 2026 at 09:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> IMHO, it is slightly more subtle - people believe they are already
> adding children.
>
> Consider this code.
>
>     port92 =3D isa_create_simple(isa_bus, TYPE_PORT92);
>
> my reading of that is that I'm creating a "port92" device that is a
> child of "isa_bus". Why would I need to tell QEMU that it is a child
> for a second time ?
>
> If I trace calls through isa_create_simple I get to a call to:
>
>    qdev_realize_and_unref(dev, parent, errp);
>
> and once I again I'm left wondering why I would need to tell
> QEMU 'dev' is a child of 'parent' a second time.
>
> Of course I know the answer. We need to give a name for the
> child and it isn't trivial to "do the right thing" to invent
> an automatic name.
>
> Still, overall I'm inclined to largely blame our API designs for
> not guiding people into doing the right thing.
>
>
> Picking another random unattached set of objects "smbus-eeprom"
> I again find they've being created with qdev_realize_and_unref.
>
> Pick another unattached device 'i8259_init_chip', and again
> we end up calling into qdev_realize_and_unref()
>
>
> It feels like qdev_realize_and_unref() is a common point of
> blame in unattached devices. IMHO it ought to be taking a
> "const char *name" parameter.

I think that is because this is the function that is used
in older code that predates the "everything should be in
the QOM tree" model. Newer code doesn't use it, I think;
and it's not surprising that old pre-QOM code doesn't do
anything to put objects into the QOM tree.

The two patterns are:

 dev =3D qdev_new(...);
 ...
 qdev_realize_and_unref(dev, bus, errp);

and

 object_initialize_child(...);
 ...
 qdev_realize(dev, bus, errp);

This also is somewhat tangled up with the question of whether you want:

 * call a function which allocates memory and initializes it
   with an object of this type
 * I have the memory here, init the object in-place

If we could come to a definite conclusion on what we want then
we would probably be in a better position to try to enforce it.

thanks
-- PMM

