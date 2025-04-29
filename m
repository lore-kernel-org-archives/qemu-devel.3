Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A6D1C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 14:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9m5b-0003Qk-Kq; Tue, 29 Apr 2025 10:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u9m5R-0003Pw-Ep
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:37:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1u9m5O-0004Rb-5X
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745937441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BltxbORp3dU4O4Pqs/IE9o/fPooMKUc/0lnLwVGWTro=;
 b=Qg6vnpvEWbfeDrmgBAvjLrQRMZaL6HYPhc6emGKCQOpHmk57kcJL/tiIe+qqpL0ufY/i99
 R1/lWjfhNNFl9feC8poKG2b2JasA9OgGcfGZtdOT0TyMwwzj5mP0Ys+tOYZOSMTYlJbVhh
 YAFOZ7oBj10vOSMpDmQ6ldemuuJ2JPY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-0WFYeJnyOMKrAVQmhndiAg-1; Tue, 29 Apr 2025 10:37:19 -0400
X-MC-Unique: 0WFYeJnyOMKrAVQmhndiAg-1
X-Mimecast-MFC-AGG-ID: 0WFYeJnyOMKrAVQmhndiAg_1745937438
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6eeb5e86c5fso65496226d6.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745937438; x=1746542238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BltxbORp3dU4O4Pqs/IE9o/fPooMKUc/0lnLwVGWTro=;
 b=QNmB9Vyf/v5E2bONHvwTPz65o4ey4uO+tsMZeA2MNB1R7pjj3G5nvusAseg8IOc/Wq
 ZKC8L1NQeYMTudbzN8f1FFVuLt5Kynhag0rPwFhT0NCyGa7POYrQFXuyK5mD9eXXlAGZ
 gNQpjAQOmlXIb16GqyPLR8itH+ACUOCNtrNyI98JNzdoKlWSZarVc6ABU7g5kz9tyflS
 bPmbb6rTcN+ek3mnchA3XK1o2FJ29JAR9Kikc2r0C/Khn5+iqYEGoPG+J8I8T65WDSo6
 5sCgBATm1mxEx3bZjg6TM+IzDs/5BfLOEsfC8MuOviy176nWMef4E0aL6uM6vC25zzTf
 /wZw==
X-Gm-Message-State: AOJu0Yx/YKH3QsFS6GWvdPmDm39O6U+J8+652lXNaoP7zgNTWEUPeaAt
 supA7GvPOJ7tk37nileBG/Z8JwHZ2CKP8a21Gc+PCrQEw+iIIy1jafeu4hpJ3cE3bdLwABBvRwv
 juGuWifif3N8szdo1dBZB3+4hoPyQDb/xc4jAsqmZWMOW3IStKcemR8fM4rRV4yTOomHNO2jUY6
 sVW+C+Rll7f8aGkTsn/4AxEU56kaI=
X-Gm-Gg: ASbGncui2BYQ9aQPcJausL7CpLvSxNeFeVSsGBW58qxiO1GF02o+8iqelVntYaIZ3IB
 /96hQkjZQsBODiL0RXyGAnn5Ya1UFmeCdiBqhwuQ2I+weUz+DzFOW8eM4u/koM8fBckWDz0yIuH
 VAp3WPS0k61ovKKLuSj5SrIs7zKA==
X-Received: by 2002:a05:6214:2528:b0:6e8:fe60:fdeb with SMTP id
 6a1803df08f44-6f4f0596e09mr60654926d6.17.1745937438481; 
 Tue, 29 Apr 2025 07:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuYsk5hmw2BpMGnaqJljYKyl5KEI4sF4Xv42SDMaT7Wn7OJiyNRwVKQk9jAzr7R81Va6CJnYgUk7qto1TVaw8=
X-Received: by 2002:a05:6214:2528:b0:6e8:fe60:fdeb with SMTP id
 6a1803df08f44-6f4f0596e09mr60654606d6.17.1745937438197; Tue, 29 Apr 2025
 07:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
 <20250429140306.190384-7-marcandre.lureau@redhat.com>
 <CABgObfY03pS2DV6ttABt0-82RGvRbVKq8atM9Eoki2-WFELhXA@mail.gmail.com>
In-Reply-To: <CABgObfY03pS2DV6ttABt0-82RGvRbVKq8atM9Eoki2-WFELhXA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 29 Apr 2025 18:37:06 +0400
X-Gm-Features: ATxdqUGiN_HnZNspYaAhvwQ2qTdILmxVrUxDbNBRUEE4Lw4jnOTJFtSi-sE3RsE
Message-ID: <CAMxuvaxn83Fmx2DPhYrYuHJJDyCLAxJtuz_Sjrt3Y=CoiEu73w@mail.gmail.com>
Subject: Re: [PATCH 6/6] RFC: qom/object: simplify object_property_del_all()
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi

On Tue, Apr 29, 2025 at 6:23=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
>
>
> Il mar 29 apr 2025, 16:03 <marcandre.lureau@redhat.com> ha scritto:
>>
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Since commit 9859fac ("object: release all props"), the code was changed
>> to tracks the already released properties in a hash table. I am not sure
>> why this was done, perhaps to prevent from potential crashes if
>> properties are being added dynamically during release. I am not sure if
>> it's a valid concern though.
>
>
> You always need object_property_iter_init in case prop->release deletes a=
 property, thus invalidating the GHashTable iterator. The hash table instea=
d is needed in case prop->release does *not* delete a property, because the=
n the property reappears on subsequent recreations of the iterator.

Yes, changing the properties while they are being removed is I think
the reason I added the HashTable/Set. But is this a valid concern?
(the penalty is a bit sad)


