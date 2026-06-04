Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EC1CD6E75
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVEXH-0004xc-8e; Thu, 04 Jun 2026 16:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wVEX8-0004wQ-A6
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:19:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wVEX3-0008VE-AF
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 16:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780604348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGb0pF5fCoc8Xphf8+C05LuxpJdSgch3VJ/ZP7ug5Dw=;
 b=HMkVj8Rt2pO/++9Btxlq2hue5JWSasL/lO/mRqeq1ay7+eg2dF9JNp2djH6koCSMJZf0Yq
 jDanaxaoSZBOhut73xCj2/cIQOae6JVGO4VV84xnWo/kyc1iGjFanmbONVTNiA23nEN3Jz
 OeTK70Fq2ATOqZmrnRGylJdzWvhf4sM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-GkGd99XBNVy7-cU_0QOIFw-1; Thu, 04 Jun 2026 16:19:03 -0400
X-MC-Unique: GkGd99XBNVy7-cU_0QOIFw-1
X-Mimecast-MFC-AGG-ID: GkGd99XBNVy7-cU_0QOIFw_1780604342
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85798977dcso808765a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 13:19:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780604342; cv=none;
 d=google.com; s=arc-20240605;
 b=j/XBQZHcYViCqHPmARMauku9SkPdqL8EuxxNxo6TV8A2UEjbr1iEhCEsKEgiC2C42Y
 O/TJnIyieQKsK7wfWntzO3IBkjViYnTYkzZkG3L/PI341pgyTbR2eNvirA7G1KeOKuvW
 yhi1YfvsD3zSm1tLhePb8vfAlAP2s6seW1d5jinib07At6DoILXmXJ+bqdcCmtEmwnaz
 3X+EI7SNZN+lF6mNFXHG/mMxUTs6lZ0WUpaaPH79/u1kSB4y9cSrpFwLdfPabrNkpZDd
 Bb7TemHlI8/DpJaGQjTybCae+oNUsyUoqIFJbtw5JKOl04Gx3PaOH3KCoyeBniLDQZ6L
 tdAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GGb0pF5fCoc8Xphf8+C05LuxpJdSgch3VJ/ZP7ug5Dw=;
 fh=2AXKKvs6UPMWapHrr90pEv7S+1yePIF3Y2IBZ3MMSHo=;
 b=NgLpmBiz429Ft+eiiZP9uOF9iIfZKDelJ3eCsMCDl1/7TPRUrIYZ8Cl+t5bPrPp0jI
 fZyeco4z3Gi2rJP7F/WUXRcb3zDhRsqlC0uVJ3SwRPbeolC+nK0mLHIKg4qnuWpcicnA
 hJwj7tIclOdyX6+pMNZBNjD9aIiogk/wVigvEMvShu2+eDQq0hlY3611erq2WAs0/grn
 lO6y/x4nn9VxwsuxQ9cR4ZQ++Igybwy4Qhw7DNMBNnR+Tca8mBosLXdvZS4YH3X/HWRC
 8Xj5OFC8ALMAtLBHSt7tEQFQIiqad342hZxYnzZqHRZhu4Yz3rQ3Hrxo+KzYaE3jeQ3k
 bbVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780604342; x=1781209142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGb0pF5fCoc8Xphf8+C05LuxpJdSgch3VJ/ZP7ug5Dw=;
 b=RB2BtBPcu70p9+hzvAN3qL6dA1Xnk6SVYcXT//LJohmUo99hVkzDlcrunCrw2MCZ4C
 Y14sboyJfblSufFCTOrMF8RNBOH43h/W+AhGd0qkyuhn48hr8hQ22Ft9jPnqTuF4DrHh
 +ERxodOAVMt3V/TOhvmlEHN6biwXRDh0kcPzlpexJrK6Ya+DnStvQ8x4v+6R2/LE0bXf
 LMDDbZLjiTx0F8u0w3z4P//WB4Za1Q6yr8cmmG/7brYBqIcL9aZi7/eD8bdOxrokqjAS
 5RwyNWK+IkAxaxWkGP5f6GbjiN/hahO1bUwtXi3BQnM0hCRd84g7vwUq/QfMUg0Vmo+b
 IpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780604342; x=1781209142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGb0pF5fCoc8Xphf8+C05LuxpJdSgch3VJ/ZP7ug5Dw=;
 b=knfNZ+dB62DwqQzBvP2Xoisfj4YDIyGZQnwBInwRMEf1hqRqthX6j4cXOfBempx52e
 ZawNUBac5Vx1Z2jUvIlB6jCGQpuh+diw4zw89ZN3QBXRgXo2v4TCK0HRXE/B4Cw5AQOB
 yFwL0Q56r8GeAyXoYdWEYb8Oox3teNKOz3o36raMt+BRFD2wkTqwFDN1FbuIlMSSj8HT
 vAKOZ/LcAj+phNY9wpLBw1jpp8fIiC5z9WUEVRTXhjkgacFJRV6U4IpjCiXISWN1/MGT
 UAMh3qqt23O5tBVMrEvjsn5kWEFVUlUpOv7mSICBzq6vrG5dtaMnjV/+n1+XMEScrpaq
 N8zw==
X-Gm-Message-State: AOJu0Yy3EtMYHKCUSjRdWPZa81iHvv5fqoYXf3KbY1oUqYnvw1pqHEU+
 449GsA5iT570pJ3PoitNfQIrp/LfnoaEtngrJmgi7rZLt1yV/Ai+iDXeTV7eFoWzoZTdO3ZQneM
 9FTLZvKvJh+xwnM03rMophVCzs8MGn6wN451cltY4XKZmistnbGF/ogJUFCP3egWazsbRqQbQB6
 5AqdPbfJkECk/sVgYHEWH4zdweoNrieRc=
X-Gm-Gg: Acq92OEmNistaBNHcBhLv9QpAgA9QuO7CamAGf9XHyUg4hHSoEibMc4viglp0Z1rk+R
 krw5YsgcqkrufbOHBK1v8ogPtE0vYOWSAeD37X9jW9VErmReBebE3tQYUV54biqN6n7vC9Rp9yM
 fO8cCu6x4oH8ytbAJKPeRKZaWaJyKldidrl+jznhM/QB6+p6Sei+x+k+xr2P/XVIQDe0tHcdv3w
 3PW5KLvAUBFntX9R3nIysOSiRSbPU6+2OJSDRt4U4lu4u923GarSVRcyDF1fQFhH3UXSZQVLThX
 Q5UG7mA/2weafN7TeJAu8KXDYaJJiiA5/A==
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3b4ccf8e5ecmr713547637.22.1780604342003; 
 Thu, 04 Jun 2026 13:19:02 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc3:b0:3b3:be1f:c89b with SMTP id
 adf61e73a8af0-3b4ccf8e5ecmr713520637.22.1780604341520; Thu, 04 Jun 2026
 13:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-16-3f20c3a029a7@redhat.com>
 <aiGTNf5iyWnk1OS1@redhat.com>
In-Reply-To: <aiGTNf5iyWnk1OS1@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jun 2026 00:18:50 +0400
X-Gm-Features: AVHnY4I1KzFp65Ee8xeEfdc4-_ylcVTXlhecny0GPlJq1k91UuAhT_4i_iI15uo
Message-ID: <CAMxuvazn3f8y+wR0YuBXjypHBpj3uGVPwHv_rAskH41FCumZig@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] hw/i386/nitro_enclave: add instance finalize
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 4, 2026 at 7:01=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Sat, May 16, 2026 at 11:59:15AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Property setter strings (vsock, id, parent_role, parent_id) were
> > never freed because nitro_enclave_machine_info had no
> > instance_finalize.
> >
> > Fixes: f1826463d2e8 ("machine/nitro-enclave: New machine type for AWS N=
itro Enclaves")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/i386/nitro_enclave.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
> > index a29f0044d0e..1ce9ee3358a 100644
> > --- a/hw/i386/nitro_enclave.c
> > +++ b/hw/i386/nitro_enclave.c
> > @@ -337,11 +337,22 @@ static void nitro_enclave_class_init(ObjectClass =
*oc, const void *data)
> >                                            "Set parent instance identif=
ier");
> >  }
> >
> > +static void nitro_enclave_machine_finalize(Object *obj)
> > +{
> > +    NitroEnclaveMachineState *nems =3D NITRO_ENCLAVE_MACHINE(obj);
> > +
> > +    g_free(nems->vsock);
> > +    g_free(nems->id);
> > +    g_free(nems->parent_role);
> > +    g_free(nems->parent_id);
> > +}
>
>
> Beyond these strings, nems->vnsm is initialized from
> qdev_new(...) and I'm not seeing what frees that
> device.

Correct, but it is followed by qdev_realize_and_unref(), thus it
doesn't own a reference.

>
> I presume the qom test at the end only exposed the
> string leaks ?

yes

thanks

>
>
> > +
> >  static const TypeInfo nitro_enclave_machine_info =3D {
> >      .name          =3D TYPE_NITRO_ENCLAVE_MACHINE,
> >      .parent        =3D TYPE_MICROVM_MACHINE,
> >      .instance_size =3D sizeof(NitroEnclaveMachineState),
> >      .instance_init =3D nitro_enclave_machine_initfn,
> > +    .instance_finalize =3D nitro_enclave_machine_finalize,
> >      .class_size    =3D sizeof(NitroEnclaveMachineClass),
> >      .class_init    =3D nitro_enclave_class_init,
> >  };
> >
> > --
> > 2.54.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


