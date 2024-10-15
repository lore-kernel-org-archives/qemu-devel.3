Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC4C8D20680
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 22:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0pfb-0004ms-4J; Tue, 15 Oct 2024 18:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pfY-0004mX-Gu
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:05:32 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1t0pfW-0006NF-H0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 18:05:32 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-6e3a97a6010so25415157b3.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1729029929; x=1729634729; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B6ao+1lr+NlCNFROx1SFZxEJrgWLdXXe4yefsv9G2BY=;
 b=DWpUlhRX0MdeD7IYYZCwS4aSA+LihDGw9yzFPBJaxmO5xM62wSzE5IJE+eZdzr9srY
 8r3DHy+3fnkefqdF5rGPdIPpPuaFbJdUqlg4PBbe5mCNJdkOCkaK1dhUXWjE0pCLqABQ
 jfaz8r1QBZO+mkjXN3MSdAR2GOt2Q8bb0VpfU7bev3OgC+d2ZICkdb0XXWBcVELiKgeo
 rEIYZnYR2RYQL12sARI2nGtXT2FYmqXZWzrrvBdMLmzVaIvbkmBmJeI4AyZH5h8iOGED
 w+ljxQjbxN6BXOxxVc6dOgzD73cDMSOdCVYX9n9U3vTUByfsn91Ax+2J95qZdtOquw4z
 hljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729029929; x=1729634729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B6ao+1lr+NlCNFROx1SFZxEJrgWLdXXe4yefsv9G2BY=;
 b=GBMjcheUJ5b+vQt4FIH816INh26/4uL5JcI7O6ONYgqAMj9vXrM+LcG9lTbzqBDpiI
 U+U/c33VdhEfB0Ihv9kvb8D1Uj+rYMe+kTeY46/4RUJguFRDDgXrQP4kzuwj1MaII1/X
 CE0wsoJZ/TZ2e+lh7Bt+cKH9b+9zn9zaizXksA9dbnry7uJ/2dHoz1qkzRU5GD58FybZ
 Muk5wTByBG4GUO4L5Iu28g5/vgVq60VfBryKHMd0FltBlN+rKHtXelHwfvyTRqlVqaXX
 1BWEmTmmgwqfp/Q4vfOdnWqQJqbJuMNhoW02iykub8NZcahZw/ii5/m1H9is03xOeCea
 DWkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFyy1dUuaGeRRhoeKySkT81jDQ+MdWLsU95bt/QGeIILNOAPonqLZxzMrrtb5ZzCGUJDwB0Xz4Devo@nongnu.org
X-Gm-Message-State: AOJu0YwCUBanUrQJ/YWUDa/UdwEWsllUuiVGFtpHPWMS51YAc9jIluf5
 8HI29KqJ9HpbmJMfSIZkHmJBmzTGQx67xx9ut3K3ULWD5RNYCFpC4MH3fh1tg9iKVOPS23GFGaQ
 LmhNwb3fvBzZYz8HQTYhYoGv05d7J/EkIX2Bx3g==
X-Google-Smtp-Source: AGHT+IErOEqj+JfCCq7JY3pQdmaHnfLJZY8UoXjm0OVQOpDBgGyd1IJAlrUFH5omVAMgTYk3vV+yyWdd5O/jEW4Mwtc=
X-Received: by 2002:a05:690c:4d03:b0:6db:db7b:891c with SMTP id
 00721157ae682-6e3d40a0294mr25512817b3.14.1729029929408; Tue, 15 Oct 2024
 15:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20241009234610.27039-1-yichen.wang@bytedance.com>
 <874j5isp5k.fsf@suse.de>
In-Reply-To: <874j5isp5k.fsf@suse.de>
From: Yichen Wang <yichen.wang@bytedance.com>
Date: Tue, 15 Oct 2024 15:05:18 -0700
Message-ID: <CAHObMVZx4Nz+pgcDE0dZ30t7_c0Rud92ND5gzrS6jchDKFsfNw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6 00/12] Use Intel DSA accelerator to
 offload zero page checking in multifd live migration.
To: Fabiano Rosas <farosas@suse.de>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 qemu-devel@nongnu.org, Hao Xiang <hao.xiang@linux.dev>, 
 "Liu, Yuan1" <yuan1.liu@intel.com>, Shivam Kumar <shivam.kumar1@nutanix.com>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=yichen.wang@bytedance.com; helo=mail-yw1-x112f.google.com
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

On Fri, Oct 11, 2024 at 7:14=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wro=
te:
>
> Yichen Wang <yichen.wang@bytedance.com> writes:
>
>
> Still doesn't build without DSA:
>
> qemu/include/qemu/dsa.h: In function
> =E2=80=98buffer_is_zero_dsa_batch_sync=E2=80=99:
> /home/fabiano/kvm/qemu/include/qemu/dsa.h:183:16: error: =E2=80=98errp=E2=
=80=99
> undeclared (first use in this function); did you mean =E2=80=98errno=E2=
=80=99?
>
>      error_setg(errp, "DSA accelerator is not enabled.");
>                 ^
> qemu/include/qapi/error.h:318:26: note: in definition of macro =E2=80=98e=
rror_setg=E2=80=99
>      error_setg_internal((errp), __FILE__, __LINE__, __func__,   \
>                           ^~~~
> qemu/include/qemu/dsa.h:183:16: note: each undeclared identifier is repor=
ted only once for each function it appears in
>      error_setg(errp, "DSA accelerator is not enabled.");
>                 ^
> qemu/include/qapi/error.h:318:26: note: in definition of macro =E2=80=98e=
rror_setg=E2=80=99
>      error_setg_internal((errp), __FILE__, __LINE__, __func__,   \
>                           ^~~~

Sorry for that, I will make sure I test both for my last version
before git send-mail...

