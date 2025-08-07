Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024BFC87FD3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 01:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujpJU-0007Hn-T8; Wed, 06 Aug 2025 21:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ujpJL-0007G4-WA
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 21:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1ujpJK-0004WG-15
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 21:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754529647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEWrYjjWGNjohxH9R8UlGTMdvalBWlYjle/WluhTEow=;
 b=EP6jSgcjdNSCI/Lua8wHzgRU9x7NmOqftx1XUtmz/gXWI8PBSIQsgNsRSBVyOjsYD7Nvei
 SOjW8ebNgvnA2FzkHEgvJ7/tCGMaccijZVACDnh2/YBnB0nUVpjVqU5f+JxR6NQ1fnbIeW
 jwCK8m8FCHt0DX+BM6fMXWnfjOacb4o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-nC83IRFuPbadkrXQW_lDTA-1; Wed, 06 Aug 2025 21:20:45 -0400
X-MC-Unique: nC83IRFuPbadkrXQW_lDTA-1
X-Mimecast-MFC-AGG-ID: nC83IRFuPbadkrXQW_lDTA_1754529644
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-615a06a4bf4so465188a12.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 18:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754529644; x=1755134444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WEWrYjjWGNjohxH9R8UlGTMdvalBWlYjle/WluhTEow=;
 b=Lz+NexNajrM+VFNicuQvxhpvB4hSXziA8voL5+fFtQPupvuOtG+JMGmokjgVSVp+hU
 GhIGahFP2kNJtFzQU4G7p+r12Sx6XYWCQyKnDed1MvXpwYMJM3QuGJZPINMUFOr2cnrd
 gmIb/FKL3MTN02EArJI69KrOfGgdmhkGsHaeI2uT9XITz5Sdp1QlcEHhLgTrQwgnm/MI
 O3BkIhRjPNCGcW7jwUONXVnN4NDOD0WpfBb52DcrfIcQesXtRkscep37hjPZ555BcpI3
 pT/7WSg9skMx/obGGLl0I4P62JZkVQXln691rlG82j5hC9I/xkYLTqC0BsVccJUszc0i
 lHrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiOaNwO12aZkLH192d2h043VIfYV8Zemx0Yhh4od9Yi3IRHYliHw4TBOYgiJkGvC15ns9S5KPMBvo8@nongnu.org
X-Gm-Message-State: AOJu0Yy2QrfD/fVeyL/sJI/J4IxwdQE0Dt5CkyvW5H1ZFbDQNp3g2Brl
 0GeC4XgG1MXrY2ix8ceNKMf7FG9svTl7YdPkXLoJj0jJX9xv7PHS5MDO77LNgL7FTQVwiqDE8XT
 DbQSbGBbc29QZYw6dh3GbtIJuJEA9ZcKCnaH3hiZ30DvSImU24jgPSA2u0kIKy4ZOilBiWEjqRd
 CN/ZVPd2fdO/wbHcCDJSzw8eZHCfc4HAA=
X-Gm-Gg: ASbGnctGj5QnFeFor86Ckpdeg7me7yz3XL9UIO68K3AjhLM2YThTrGr4TOXHi6j8+pc
 4ReWLNsgx/TBnPQaZ8a1k/aPiKFHjxYSB8zSfjTohVVQeGWQ9II89NNrfDbSJQskoR2AOn9H5sC
 Dcb8zYUloR2kBoLDPiICz1Fg==
X-Received: by 2002:a17:906:478b:b0:ae1:f1e0:8730 with SMTP id
 a640c23a62f3a-af992c6c33amr362296066b.57.1754529644121; 
 Wed, 06 Aug 2025 18:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuVKYcqXyRGEOsTk+t3Ivio5HYohT/1PPb5lwl05ILoEYx6eYSe0xYK8By9jiCL6X1UkZ8aNd9kBreFrsaNRE=
X-Received: by 2002:a17:906:478b:b0:ae1:f1e0:8730 with SMTP id
 a640c23a62f3a-af992c6c33amr362295166b.57.1754529643803; Wed, 06 Aug 2025
 18:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250727-vlan-v3-1-bbee738619b1@rsg.ci.i.u-tokyo.ac.jp>
 <7b657acb-7186-42bf-9be5-8c1253c6316c@tls.msk.ru>
 <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <91aec5d7-7647-41d1-ae12-c86020be4537@rsg.ci.i.u-tokyo.ac.jp>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 7 Aug 2025 09:20:07 +0800
X-Gm-Features: Ac12FXxj7g2hGybmIndLW3D3NWQkijy579ZCYNkErpeCG-tTNz7HqsXyOOt1tgs
Message-ID: <CAPpAL=xEZ+U4PnOWXP0Dtk1p6TmU4F+NxZZug+-wmYBsb1KvaQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-net: Fix VLAN filter table reset timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Konstantin Shkolnyy <kshk@linux.ibm.com>,
 qemu-devel@nongnu.org, 
 yin31149@gmail.com, eperezma@redhat.com, mst@redhat.com, jasowang@redhat.com, 
 virtualization@lists.linux.dev, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Tested pass this patch with virtio-net regression tests, everything works w=
ell.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sat, Aug 2, 2025 at 5:43=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/08/02 16:26, Michael Tokarev wrote:
> > On 27.07.2025 09:22, Akihiko Odaki wrote:
> > ...
> >> @@ -3942,6 +3943,7 @@ static void
> >> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >>       n->mac_table.macs =3D g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
> >>       n->vlans =3D g_malloc0(MAX_VLAN >> 3);
> >> +    memset(n->vlans, 0xff, MAX_VLAN >> 3);
> >
> > A nitpick: we don't need to init this memory with 0 before
> > initing it with 0xff.
> >
> > But looking at this, why can't we embed n->vlans directly into
> > this structure, something like the attached patch?
>
> VMState also needs a change: VMSTATE_BUFFER_POINTER_UNSAFE() should be
> replaced with plain VMSTATE_BUFFER(). Actually this is the only user of
> VMSTATE_BUFFER_POINTER_UNSAFE().
>
> I appreciate if you submit the patch with this VMState change and patch
> message.
>
> >
> > This, and maybe a few other fields like it?
>
> There is another candidate: n->mac_table.macs
>
> But it is not straightforward to embed this array because it uses
> VMSTATE_VBUFFER_MULTIPLY().
>
> Regards,
> Akihiko Odaki
>


