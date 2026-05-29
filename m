Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95876CD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSus7-0005VO-7y; Fri, 29 May 2026 06:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wSus6-0005Uv-3d
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:55:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wSus4-0002jg-1t
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780052117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3uy6EqbsfIsMIn3neHjOrXRJMIft9JteE0qdyBFaDgs=;
 b=MqkzRNF9Rdvb7rYP9Q7VIbwfFUgruxhozLTKaff84BXVN6o8vWMiCmn4Dv00VKP7gpKSTD
 581qXuI2rKtFm/JJaUhNfuop+4lY5FtpXrwT10Zpw423u6cW+i88zqN+tPv23duDcZSQNn
 H4axMkoyYoxKGwfZbYCyQIX+lbqbrOY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-vZxwQvltMaqqYeDtxnc8WQ-1; Fri, 29 May 2026 06:55:15 -0400
X-MC-Unique: vZxwQvltMaqqYeDtxnc8WQ-1
X-Mimecast-MFC-AGG-ID: vZxwQvltMaqqYeDtxnc8WQ_1780052114
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-841f09a96ecso1338467b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:55:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780052114; cv=none;
 d=google.com; s=arc-20240605;
 b=CU1aySPiiGFz8qDiqQjlNzz2M7qpyVDWOPDvEwQeFdfE6Y0VHBVeGEEhDglkKgA5Ge
 5CXx48X9Q0Merksdj3gW0AFnDln2OOl9/2XlTYktT2WEe/mD5C2WbyTVtHIe8fkyAonR
 BoMdqXHqa+1fi0kQCDFU2IDBc7MLc7KXROaIXOeMCH+VjIj1X7yjAfzkTfN/gkPvIRVR
 vVGwIzvTDeHQyymJAiszE0hennlbxm2e4+Ir7eTgpkxL2ZkgdS9876XwI+frx+4pIUGd
 K2thBpOBgX56108yEb228ajK3MiqvPiY8JapWtyba6kfocMgNlyGSwBjImoSCT/A7Jrh
 NwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3uy6EqbsfIsMIn3neHjOrXRJMIft9JteE0qdyBFaDgs=;
 fh=IIVq14YtGeHsqR1qXM8TWLElWWlW0t0XUfvIwOGX8mQ=;
 b=SIEB5OXRq/s2giq7bsyAaxfbMb7BHiUVhj0dIvPLBFv9uQzGUC8LVu6/YVM41RvVN9
 n+dLslEvBNLkxjGDlQ8hgN7VB2jD1dYTrCoAdntyCockBLOcWtGZLsqHZp/GHfrwwINN
 CfLanCgwSorUHyvFjbbBcFtC/lRaH61v1dX11s7BXkxcBXjMZahv6sPBD2DjuwBHrLSo
 nh2m8OnN4pUgT5tjDqGkqs7a9dw2ZDED55f6DI9ZZXvbzIZz3lWwRS4gzNGr5yaR9vv+
 V77e2gTl2ssw8WSPtkqXewOJyZyzYDQSeoal1ljMh62Y4FHUdsQdDllEZSDRDCGwO7mB
 u0uw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780052114; x=1780656914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uy6EqbsfIsMIn3neHjOrXRJMIft9JteE0qdyBFaDgs=;
 b=d0PXYCRfI/2rp/5QfmoI9Y2P4KmNZJJKwlZYw2TxMBYLn4TOMrp9KL8QFD3AdPivsM
 aQftYa5+GW79j79fa6cnu69vTUIZerjqyoboikxSe5vj1+Z13pNfkCekxzuALrvif8f7
 9p//Lfata+nbUr9lEOh29xwCsGSz025gq7kGHm7R/97iMTpsIGy/TvOOltGfFukkcFft
 Sn7DwoeEB6XVIA3Irp8XmZLVPlueamAn2Ta6CBHvVrDn1UW5UKA1yDtH1cajBgyQKI7e
 Ot1jTPK2/Th3R+F4ckVnGc8Ud8EX02YjxmQt/9+lra8urvcwMSkRebYnOcIDTdNULOt4
 J+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780052114; x=1780656914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3uy6EqbsfIsMIn3neHjOrXRJMIft9JteE0qdyBFaDgs=;
 b=kWetcROqDEITifeD+yA+/tpj9gK1kPhdlnGlyHYTWzi5ZkrZqpnJuztz/0Rm9h0nHK
 Z2KDw8eIiiS0hRYDJ90PW4hZrOT4S75Tt2IT5u5kA9e6sUNsqDYJSGKarvIEb1mTBUOl
 xw7Sy06MdTiKE/cwhV0cdKVpfIiSeLk2KzC5EYHSa8NZZOgez0+9I0cQ5CyJwr28PaK6
 U7bLqgbJDsssWO8ivg0KKxs5RpD9QjREeDvcI21bncfR9e9EPUqVulVnM6XZYNuYINDC
 +BYU8Y8Dc1YeJ8+tCEbwP2otLRIqSDObHpsEbkEzeXc8S5/8MhmYWC320+OihqW0UzFa
 p9yA==
X-Gm-Message-State: AOJu0YxK5CpP4ETbeRkaW7mV8KLMDVgyfF4Pq2oT46zbXCipkUp9HNCs
 RZvdL3yztduAtl4YIyGL6fMYfQ9GMEuweesJ7nN+FZ/FMuKiINmPmzXNeSnL7QgFoz7DS+pSRU3
 wMgkK2VKooacSNgn7YKI4x2+J06TGkCulyniXH4FOzgmYjwU3WqO/V0QOAVNnZ2F/vYTJkXQtbE
 6Tvh6GmU/E0cXzH6BKJd1NxvZUXonhILo=
X-Gm-Gg: Acq92OHkageYK+h0ToAtWuRUa3jObLqQTcAxkYmOA10fyv+sjvls1d4Vq/xdpv7qwzp
 FAU8yhINqZlZ48PQ5khligHB66F4ChpEYOLBcAEQJpM/qqOumqP96MhdZH5H+qFu1pj6ys6iCtE
 ANYYrt/pchrn3Lu0O1TjwkHpX7RmyRgx+n/RO2vzQG1N4j1Gb7m5vd6P9QuQ2KfWA0u93QHJ0Q7
 VASW630x49fbzKz3bq3rrVAloBvqOBJh/gVB/gbLZKtTRZzlAhTir4Zyk+im2KFeEAAHKSIM607
 ENSygNZcncnsLQ+iE5/NFIoJBAvjjowaRg==
X-Received: by 2002:a05:6a00:bc05:b0:838:c01a:7a4c with SMTP id
 d2e1a72fcca58-84212d5b7f7mr2538758b3a.33.1780052114018; 
 Fri, 29 May 2026 03:55:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc05:b0:838:c01a:7a4c with SMTP id
 d2e1a72fcca58-84212d5b7f7mr2538721b3a.33.1780052113487; Fri, 29 May 2026
 03:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-18-3f20c3a029a7@redhat.com>
 <CAFEAcA-F0m3qUyoURsax-vC+MbasgcMN_wSVSGJCo2KRES=+uw@mail.gmail.com>
In-Reply-To: <CAFEAcA-F0m3qUyoURsax-vC+MbasgcMN_wSVSGJCo2KRES=+uw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 29 May 2026 14:55:01 +0400
X-Gm-Features: AVHnY4IGDn8pnx6rzVRDTRSTt3fEfCsUxWzw7xQ4WKB8GWd7rNygFc2bXYjiLsA
Message-ID: <CAMxuvaw5Z08L1y_LWn-JjGYxsdgNtMuE6fC3-qOtEd0H+t9zpg@mail.gmail.com>
Subject: Re: [PATCH v3 18/24] hw/tpm: free PPI buffer on finalization
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 29, 2026 at 1:17=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Sat, 16 May 2026 at 09:03, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The PPI buffer is allocated with qemu_memalign() in instance_init but
> > never freed when the device is destroyed.
> >
> > Fixes: 46cd2c1050f0 ("hw/tpm: add PPI support to tpm-tis-device for ARM=
64 virt")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/tpm/tpm_tis_sysbus.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
> > index 6bec30c36fc..3984228c42f 100644
> > --- a/hw/tpm/tpm_tis_sysbus.c
> > +++ b/hw/tpm/tpm_tis_sysbus.c
> > @@ -150,11 +150,20 @@ static void tpm_tis_sysbus_class_init(ObjectClass=
 *klass, const void *data)
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >  }
> >
> > +static void tpm_tis_sysbus_finalize(Object *obj)
> > +{
> > +    TPMStateSysBus *sbdev =3D TPM_TIS_SYSBUS(obj);
> > +    TPMState *s =3D &sbdev->state;
> > +
> > +    qemu_vfree(s->ppi.buf);
> > +}
>
> https://patchew.org/QEMU/20260528093123.55403-1-mbawa@redhat.com/
> (likely to land upstream shortly) moves the allocation to
> the realize function, so maybe this free should also be moved to
> unrealize ?

yes, it might be worth getting this reviewed & merged before it rots.
Most patches are trivial, but if we don't have the time/interest,
should I take the responsability and send a MR?


