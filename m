Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355BEEE57F8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soj9q-0005Xu-GX; Thu, 12 Sep 2024 08:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soj9o-0005Wj-1t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soj9l-0001fv-W5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726144960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8nfejZavA0hL03c+N7MeOGb8mfUCS+H6+ty6eZ3ps4=;
 b=jF3X+QsElWT+TUqTnXX0fnZfiD/ERdnO/+beYO5pBdpD0i5bg3Init0fWf67UvG1nUhroc
 kq21FAdQTi9qQY3jKLtfxRYHEPbV2CBUxBGPG6vLXPg94QjkpUsByHyVXoPKjgZKiMBIqD
 bKbOIuGxEPAzdS4cGDTkD8DjNZ6GCw8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-GwR_o1VVPcO0iB8-0zCMBg-1; Thu, 12 Sep 2024 08:42:36 -0400
X-MC-Unique: GwR_o1VVPcO0iB8-0zCMBg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374bb2f100fso430675f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 05:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726144956; x=1726749756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8nfejZavA0hL03c+N7MeOGb8mfUCS+H6+ty6eZ3ps4=;
 b=pl4lKmVrZLSonO/3YUGyl3jdeBo1cXCT56nYPA/QHXkI5liM4x18Dz+CU33B8s0Ul3
 zmoYTL8AS2oL45M8G+DnwYiskqC9LdrUZwGUnx6a/mbYI6GzJuDAo8RuAjPf7jyiHmnj
 wbtigoi3OoYSt645g0yBOAQ5e1OcWuh2rzVLMynQzGwhraCrCtCwERP32A/dljGb3TM/
 h1KCgswka8Nf0Vz2RKC4swkLF4p1c56vYLxEkvgfKVFmdPVN+H0bkXoEC4Msc8mSTUTy
 XxleyA4oSoK74ecZLIbRWGGnhuKoYfwrt3MIOdP1xsR2wd/n9ZfABGp1lnXaZJh9D+SS
 6ffA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzU4dsrM0pHj7GaHNb95cxH8aY5jvADjYAsClDGQ+DYjrmjtOZjneOOgoQEZFguqIQROXG/Wl1QrpP@nongnu.org
X-Gm-Message-State: AOJu0YxeP5XRRkYQxuyxhADp6sLdS6Omeg00QaVTWEeQHC1P8DNSLXA1
 YYghEElR7CvHiNGr2WPE25UzcqGs9j2q6pYcKT/T2HZUSU74rafMJAQvymNxzRR+CsLnWnkWBYK
 YDfB5OI6V+e2O5TgTHGeZTTJRcv4b77WxO7ES0tW3QRa7KjBbJ5z5
X-Received: by 2002:a5d:42cb:0:b0:371:88e5:6d34 with SMTP id
 ffacd0b85a97d-378c2cd5f09mr1419770f8f.7.1726144955750; 
 Thu, 12 Sep 2024 05:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMyehhqSAF1+7J1WexqM4IbLvLeTZtyCqD7Mk4Ku3Jw3VzVKKstGlTStD3RLALeuMBNY5dpQ==
X-Received: by 2002:a5d:42cb:0:b0:371:88e5:6d34 with SMTP id
 ffacd0b85a97d-378c2cd5f09mr1419735f8f.7.1726144955123; 
 Thu, 12 Sep 2024 05:42:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb1e3a5fdsm159348345e9.48.2024.09.12.05.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 05:42:34 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:42:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240912144233.675d6b63@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240911163436.00004738@Huawei.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
 <20240825052923.715f88bc@sal.lan>
 <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
 <20240911163436.00004738@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Wed, 11 Sep 2024 16:34:36 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 11 Sep 2024 15:21:32 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > On Sun, 25 Aug 2024 05:29:23 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >  =20
> > > Em Mon, 19 Aug 2024 14:51:36 +0200
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >    =20
> > > > > +        read_ack =3D 1;
> > > > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > > > +                                  &read_ack, (uint64_t));       =
=20
> > > > we don't do this for SEV so, why are you setting it to 1 here?     =
=20
> > >=20
> > > According with:
> > > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#gen=
eric-hardware-error-source-version-2-ghesv2-type-10
> > >=20
> > >    "These are the steps the OS must take once detecting an error from=
 a particular GHESv2 error source:
> > >=20
> > >     OSPM detects error (via interrupt/exception or polling the block =
status)
> > >=20
> > >     OSPM copies the error status block
> > >=20
> > >     OSPM clears the block status field of the error status block
> > >=20
> > >     OSPM acknowledges the error via Read Ack register. For example:
> > >=20
> > >         OSPM reads the Read Ack register =E2=80=93> X
> > >=20
> > >         OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite=
)"
> > >=20
> > >=20
> > > So, basically the guest OS takes some time to detect that an error
> > > is raised. When it detects, it needs to mark that the error was
> > > handled.   =20
> >=20
> > what you are doing here by setting read_ack =3D 1,
> > is making ack on behalf of OSPM when OSPM haven't handled existing erro=
r yet.
> >=20
> > Essentially making HW/FW do the job of OSPM. That looks wrong to me.
> > From HW/FW side read_ack register should be thought as read-only. =20
>=20
> It's not read-only because HW/FW has to clear it so that HW/FW can detect
> when the OSPM next writes it.

By readonly, I've meant that hw shall not do above mentioned write
(bad phrasing on my side).

>=20
> Agreed this write to 1 looks wrong, but the one a few lines further down =
(to zero
> it) is correct.

yep, hw should clear register.
It would be better to so on OSPM ACK, but alas we can't intercept that,
so the next option would be to do that at the time when we add a new error =
block

>=20
> My bug a long time back I think.
>=20
> Jonathan
>=20
> >  =20
> > >=20
> > > IMO, this is needed, independently of the notification mechanism.
> > >=20
> > > Regards,
> > > Mauro
> > >    =20
> >=20
> >  =20
>=20


