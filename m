Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3048606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TXpIz3oI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=gYN//7Us
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXTE-0004qw-9E; Wed, 21 Oct 2026 10:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xJXSR-0004G8-D2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xJXSM-0003Yg-6g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792593496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVN1X17uZN4IO4cEWvUcr4Ua8ohmNUDHAdrGr9yqb40=;
 b=TXpIz3oIXYlU/1NquwFGeXFXz09u2sgMlL1ZQql0eJwltJEuiCvsugkyTohv7Vhdq/NdHJ
 S4F22b82ozBou31zgAuzFgIgF9RG5xcptE+i5U3V1a25Rf7Cm/CRxJUECsUog+oCR+2vCv
 OBpiEZAlQHJmKEwmrlDbrcT83xjY98A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-xAk4k_gLNpO7BL4dNw2AQg-1; Wed, 21 Oct 2026 10:38:15 -0400
X-MC-Unique: xAk4k_gLNpO7BL4dNw2AQg-1
X-Mimecast-MFC-AGG-ID: xAk4k_gLNpO7BL4dNw2AQg_1792593494
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so991662a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792593494; cv=none;
 d=google.com; s=arc-20260327;
 b=NmU7mcM5A5yYqzhQfeBpDbtfErZgpvfVDGVWvt0kWSOaGU8XJMiydaSjBiFpEmZM0B
 YE1LLljWCgSH44bk0TojHKVNB26yjo6MEZM1IRDhUJp9ddS+oXV3vsWqdmtsLihUf8Me
 uQRBfP/fQn8q4H45z7E6oEeDYD+CYzUlZyYlKGy6RBrpk76h7zrbuO75+PlqkMcwQOUk
 5ZZXoBUfsq6Egm2teTcmgCHylA8VJ1n06IKbq8hRKrC3UggpMVwmGe5eH5ome5yxjJF8
 RcUI1LNEXAvutGSJVeibY/RpHroetIzW50YndpbhZlWlN3toNwZ724HadvxsK5ltMVUa
 /pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EVN1X17uZN4IO4cEWvUcr4Ua8ohmNUDHAdrGr9yqb40=;
 fh=YuzglP8TNA3p5kbzSDkrMTD0hcQ6A7tGbIl0cIwKhWg=;
 b=NpAGxFX374Axh0hWJ/7K2SKdfqmSF/UgFhTNIYDBAhn8k55bJVMVQUCr8q8Bfsk+jy
 F9M6LrrzXXAggZD51yPxVwiizN5YrJF61pB9RwkOv0t6x5l5n8kpfzbuEdGANG1i1iU0
 4rIVC2WKgqK9Pl/ZLTOHg6vqaXPpRyl+izeQ0XKg9hve3hWwyHFMF0DJB1FltRtnjUCA
 XDAmyxEu0z5fiP6mY8Bm0MKaZhucUS4UpMdeqE7Na1GU2rinufgBxy3X76ofMHgifXkj
 Bth12EfusSwysrY1sc3A41Yh61Kuu42BD9YC5cb7wTSCJKh/YydmWWjp0layHWpP6MEL
 IEHg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792593494; x=1793198294; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EVN1X17uZN4IO4cEWvUcr4Ua8ohmNUDHAdrGr9yqb40=;
 b=gYN//7Uszpbl7sBD/PBPlc9vmCrmmrK31aQQObJ5ASNMEHa2OUZN4EnoZX9PGr6QOo
 GEltNjqX4RaIRi2PmPWp3sUVg/9rEt4Awkx9B9t9EzNFekPm0h+xH89DIq7JxrV05Yqg
 O5E6gI3tSDjcNCCrs+XOE6Ifhhn51DF+LdTzNvZ0sCEsKbfPsVwx+gtaXKK2CwWBFq9C
 H9/pwzofPfruAKswOZzWrWMvoN6Rtlb1UEVGN3wjrw/oWNbnZDrtcM80EaofMK/nSstP
 1V2Mi/Jem4/fC/Nh8X9DXn8i4vzA7ZqFIUvPypZIDo5Xj3Ig4czRhXgBGdjRd7xs7EVs
 Fjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792593494; x=1793198294;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EVN1X17uZN4IO4cEWvUcr4Ua8ohmNUDHAdrGr9yqb40=;
 b=lYdzmDslYevPwSCwQ3A5xcs+vQqHL74WcbVf6WW80+pFYOEQTCjPdTxo9jwT7CANA4
 A+K3VTkIQvBD7b00lQRJAvFpgW0t59TY0r4C4jogU6blPypU8lT6ptFrZkhV/htyc8th
 6FBKPpXfDQqG/I+0M90vud6ziiKoiSkNB7gtMTlYekAHktpzzOsQuIpaA0aE/awgITYW
 RVN0Xo4gDb4vGE1DzTCLWXKu3VNZsyGEJnWGQyCSScDur/q4nbcXo5AQ1IhNj4D8jcKh
 BG0LggaxynADPZRavQbvenA+ZMMtABbv2AE+WHwMFh1pKiZRkW78lZbGNVCKKArTsOup
 TVOA==
X-Gm-Message-State: AFq9FYJqv8y3Mm8qYEJJlMF3Tz36ubhvwr8hBqdnnAkJ2K7tkHMmljKO
 VKSnKaVNqTcpkybZliPIXeSPh4pPMO01UjYhPot84XV9rIeqr+6qH4cNFdI7mo/IPw9HiNL1wx9
 Y/Gsd/8Jv8vvtQikqz3g00dIsa0hzcOzVGUrlwGLWGPhns4RvEKY8qB3ZxpufosM8LdArJ6uk7m
 GlrAr1qt5nBO/nCkvTFTY+XpZzvGeeMEw=
X-Gm-Gg: AYBFou34Vx7jiAX75T/xXd6wNqf1woq0VWqU2tFJMvsLvjpILNyNOaOTwAPo+nymN0/
 VsPxmZPLPMjK9cBy5NBFhrD12Kkd+e1CWBJszXOgASWSXwWRK8PuLjH2rMKj+TWybHwrvdZ4G33
 pfl6DnNex/jvbPnKKpwCmiKrDSGnqkrfH8YHH8SvAbyywDXrfrX9N7TtGSk5zr6zmXJVtrgezEE
 RjAsvX7er8tvd9l4iulITo9FSba/mUfmHNeTrYoPTnwPY2q18JWBKrLb0e70dFPSqNF9NYEUNqZ
 iA==
X-Received: by 2002:a17:90b:3904:b0:3a4:ca46:840f with SMTP id
 98e67ed59e1d1-3ad86cd60b3mr2044972a91.8.1792593493897; 
 Wed, 21 Oct 2026 07:38:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3904:b0:3a4:ca46:840f with SMTP id
 98e67ed59e1d1-3ad86cd60b3mr2044948a91.8.1792593493431; Wed, 21 Oct 2026
 07:38:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
 <179251177300.3780647.2268008186453794133.b4-review@b4>
 <c668c6e8a78145d5e77078aa355c1fd7999b0ecb.camel@gmail.com>
In-Reply-To: <c668c6e8a78145d5e77078aa355c1fd7999b0ecb.camel@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Oct 2026 18:38:01 +0400
X-Gm-Features: AclHuK-FrsSrGitWtujBsRH7dJ1XvhCkg4AXgTIlOrZZ9NlulmqChdLq0Wo9ENw
Message-ID: <CAMxuvayxVNzs_JXaHmjG7=-mpEmANqG=DBeyMJJoxnp3KnshyA@mail.gmail.com>
Subject: Re: [PATCH v10 11/12] virtio-serial-bus: add terminal resize messages
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Max Brandtner <maximilian.immanuel.brandtner@protonmail.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi

On Wed, Oct 21, 2026 at 6:24=E2=80=AFPM Filip Hejsek <filip.hejsek@gmail.co=
m> wrote:
>
> On Tue, 2026-10-20 at 19:56 +0400, marcandre.lureau@redhat.com wrote:
> > > Implement the part of the virtio spec that allows to notify the virti=
o
> > > driver about terminal resizes. Gate the new resize support behind the
> > > console-size property, which defaults to off. To implement the proper=
ty,
> > > restore VirtIOSerial::host_features (previously removed by commit
> > > d0660e5b7fc7e97926232d13d2500a16df32b310).
> > >
> > > The virtio spec contains two methods to inform the guest about consol=
e
> > > size:
> > >
> > > For legacy drivers, we have only one port and we put the terminal siz=
e
> > > in the config space and inject the config changed interrupt.
> > >
> > > For multiport devices, we use the control virtqueue to send a
> > > packet containing the terminal size. Unfortunately, old versions
> > > of the Linux kernel used an incorrect order for the fields (rows
> > > then cols instead of cols then rows), until it was fixed by commit
> > > 5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running a=
n
> > > old guest kernel, the number of rows and columns will be swapped.
> > >
> > > Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.c=
om>,
> > > but partially rewritten to fix various corner cases.
> > >
> > > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> > > Message-ID: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
> > > ---
> > >  hw/char/trace-events              |  1 +
> > >  hw/char/virtio-serial-bus.c       | 81 +++++++++++++++++++++++++++++=
+++++++++-
> > >  include/hw/virtio/virtio-serial.h |  7 ++++
> > >  3 files changed, 87 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/char/trace-events b/hw/char/trace-events
> > > index a3fcc772877a..e387c8853fcf 100644
> > > --- a/hw/char/trace-events
> > > +++ b/hw/char/trace-events
> > > @@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char pa=
rity, int data_bits, int stop
> > >
> > >
> > >  # virtio-serial-bus.c
> > >  virtio_serial_send_control_event(unsigned int port, uint16_t event, =
uint16_t value) "port %u, event %u, value %u"
> > > +virtio_serial_send_console_resize(unsigned int port, uint16_t cols, =
uint16_t rows) "port %u, cols %u, rows %u"
> > >  virtio_serial_throttle_port(unsigned int port, bool throttle) "port =
%u, throttle %d"
> > >  virtio_serial_handle_control_message(uint16_t event, uint16_t value)=
 "event %u, value %u"
> > >  virtio_serial_handle_control_message_port(unsigned int port) "port %=
u"
> > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.=
c
> > > index c36e18a4cfb5..882765ac88ab 100644
> > > --- a/hw/char/virtio-serial-bus.c
> > > +++ b/hw/char/virtio-serial-bus.c
> > > @@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *v=
ser, uint32_t port_id,
> > >      return send_control_msg(vser, &cpkt, sizeof(cpkt));
> > >  }
> > >
> > >
> > > +/*
> > > + * This struct should be added to the Linux kernel uapi headers
> > > + * and later imported to standard-headers/linux/virtio_console.h
> > > + */
> > > +struct virtio_console_resize {
> > > +    __virtio16 cols;
> > > +    __virtio16 rows;
> > > +};
> > > +
> > > +static void send_console_resize(VirtIOSerialPort *port)
> > > +{
> > > +    VirtIOSerial *vser =3D port->vser;
> > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(vser);
> > > +
> > > +    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SI=
ZE)) {
> > > +        return;
> > > +    }
> > > +
> > > +    trace_virtio_serial_send_console_resize(port->id, port->cols, po=
rt->rows);
> > > +
> > > +    if (use_multiport(vser)) {
> >
> > it should probably gate on negotiated virtio_vdev_has_feature(vdev, VIR=
TIO_CONSOLE_F_SIZE) as well
>
> I think the patch is already merged [1]? I'm not familiar with all
> details of the QEMU development process. Should I address this in a
> follow-up commit?
>
> [1]: https://lore.kernel.org/qemu-devel/20261013-ui-v1-0-92da3082ad96@red=
hat.com/

Indeed, so you should rebase your series. Make a new patch for it if
you agree with my review.

thanks


