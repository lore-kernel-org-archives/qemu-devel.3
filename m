Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5D2EE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soONX-0000gg-WD; Wed, 11 Sep 2024 10:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soON8-0007eK-UW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soON6-00047X-0r
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lUp0+vKj46QzTJpymXewxcq+r1OcyQKVigOaH5OB8Rg=;
 b=B3zeu4re9+BVT0UkGQakDUrz3wOhtK3fcySzBNmxruv4R+mu0DaLvpgbzLiV4VYD0zOBZN
 WQp9UmVaLJYonE+ek9a5/DO+H6nw8m9iu5LFaFEVl8goH0HDPJOKvsNdqnbu3TN1WYlQZX
 kd6uzyVKWNp8203ch+yt9D5smNBsaOc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-4X0XiPDpMzy-S1WlDbbnaw-1; Wed, 11 Sep 2024 09:21:37 -0400
X-MC-Unique: 4X0XiPDpMzy-S1WlDbbnaw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cceb06940so6903675e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726060895; x=1726665695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lUp0+vKj46QzTJpymXewxcq+r1OcyQKVigOaH5OB8Rg=;
 b=ggOionJ7IdbFI9vC+ATw6NeO0klaCXpS60vjaaZZrLOamEpWtFTxFO4FEFM5bJztzD
 gI+OKMpjmpJ4Cbr+mUyYlURYJo3t3EJb2HY2bnKPn2mG3XpbdHb0T7KnqxFGz9ISPj8m
 btAEQZMMzbPUhSxZA5JDmVoWisz9SHq7mGQU92NR0TwsbpUFX+vmjw5Eilx9pFsUKojE
 Jv4Ue0LVypkpoG9Kdut5rz3kTwbQq3p/EKvTHP6LokBRP72m0th8SctbGmjikbixM6f4
 i7OH61PgeqpZyC2EJHDOT91VKf2k0vbK7lT3kKoG1xTTdaXzKOMy7D6ljVeaM2ArlMZs
 Ehhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkU4O+gX1JgIFWLleQqNJkb+PbASDYvjFxy3GEGari1NP+9pkuejZr1C75gcJlJsX/lfIEqfc/0NAC@nongnu.org
X-Gm-Message-State: AOJu0YzjiI9ttLy7Dp0xLJWqCA54ox6NwoxgRc7cj0J4RGKQguN02lnO
 Ol9rUpiC/tfm2XogNoulYOERDs4abvcaTxCZdXQZfXlj/2vQMlmpy7J95DF43Bg9g0XP4ewsSij
 EyFcz4NsxlfuxneBcJ4QWNSHobYcSSXazE3Bz4bw3lIvyqCMPTlSJ
X-Received: by 2002:a05:600c:1c06:b0:42b:a9d7:93 with SMTP id
 5b1f17b1804b1-42ccd35ad4fmr23464765e9.28.1726060894861; 
 Wed, 11 Sep 2024 06:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0mLr0qMg3MPTkdh+vXATBEx6fiAHYclLoKaceiQpiJ8kCVq4XaEUJhF96h2BsFFN80TIf8A==
X-Received: by 2002:a05:600c:1c06:b0:42b:a9d7:93 with SMTP id
 5b1f17b1804b1-42ccd35ad4fmr23464235e9.28.1726060893936; 
 Wed, 11 Sep 2024 06:21:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956e8644sm11551998f8f.114.2024.09.11.06.21.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:21:33 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:21:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240825052923.715f88bc@sal.lan>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
 <20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
 <20240825052923.715f88bc@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, 25 Aug 2024 05:29:23 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 19 Aug 2024 14:51:36 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
>=20
> > > +        read_ack =3D 1;
> > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > +                                  &read_ack, (uint64_t));   =20
> > we don't do this for SEV so, why are you setting it to 1 here? =20
>=20
> According with:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic=
-hardware-error-source-version-2-ghesv2-type-10
>=20
>    "These are the steps the OS must take once detecting an error from a p=
articular GHESv2 error source:
>=20
>     OSPM detects error (via interrupt/exception or polling the block stat=
us)
>=20
>     OSPM copies the error status block
>=20
>     OSPM clears the block status field of the error status block
>=20
>     OSPM acknowledges the error via Read Ack register. For example:
>=20
>         OSPM reads the Read Ack register =E2=80=93> X
>=20
>         OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)"
>=20
>=20
> So, basically the guest OS takes some time to detect that an error
> is raised. When it detects, it needs to mark that the error was
> handled.

what you are doing here by setting read_ack =3D 1,
is making ack on behalf of OSPM when OSPM haven't handled existing error ye=
t.

Essentially making HW/FW do the job of OSPM. That looks wrong to me.
=46rom HW/FW side read_ack register should be thought as read-only.

>=20
> IMO, this is needed, independently of the notification mechanism.
>=20
> Regards,
> Mauro
>=20


