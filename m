Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2A0C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVhJ-0003Zh-3r; Thu, 18 Apr 2024 13:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.sherrill@gmail.com>)
 id 1rxU8o-0004EL-3O
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:57:39 -0400
Received: from mail-yw1-f169.google.com ([209.85.128.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.sherrill@gmail.com>)
 id 1rxU8k-0004Gc-Nn
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 11:57:36 -0400
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-61804067da0so10592457b3.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713455852; x=1714060652;
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aKE3FfAU9rvUElpVHgXd8XnxJBwRaJLtpAS/f9whd2w=;
 b=KQfA7q9jXQGJ4FOZn8UR9taxsVr8DlcnM8DpOOOnXVl/cwwHUnCZRHD8pemCcJl+NQ
 eZVn86OYAyhEJ5WN6ObfQymfi3rtGkSOnzHtLVaLL4v9pbXZMULIIg84ZUruuCoAA2hj
 d6BR91b51IA9zoDTUBpp11XIm9q4DIrBVNcFZICf/iSv0+lJRkRu43+wvmPKE1BmJAjX
 egGZKtK6CetzijxJ3TGPj1Qip/boD0sK/yn2IYp/XoYQYMG/prCazH6xbzJQB2phHCox
 DcD3DcgVURRvDsdo4IZ1VOcKBakpMPmRjZzQVfgSjq+qz/UDteYZOR7x/2wz7px7M/p7
 ZNsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX5AhjrRUekDpq+nqM8kq+O3NcWHYndPcBw8BccFNdtER5S+v1mGFIv8BAhW89qXiGf8Hqq8rvCdiqm9qnpllBCC7lAug=
X-Gm-Message-State: AOJu0YwkD9znERXos0f345Nd2aCjsfr7vE2h2VZKEafWFvRrQ7r8xZsP
 Y07FTKAfOW8vIcGGo1ysDdwFm1WDBPolRQY8wzOCHxZh/Fhuyu/pfcdrk3tM
X-Google-Smtp-Source: AGHT+IHJb3+JNVndiWZJGwJqFo2BoB3Z7p9oJvQSch+s6KnMt5o/CQ/FO8iCTwSuNwNnlMaMCvGm5A==
X-Received: by 2002:a05:690c:c82:b0:615:b6c:b4bc with SMTP id
 cm2-20020a05690c0c8200b006150b6cb4bcmr3273794ywb.5.1713455851688; 
 Thu, 18 Apr 2024 08:57:31 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com.
 [209.85.219.177]) by smtp.gmail.com with ESMTPSA id
 l12-20020a81ad4c000000b00617be0a2bf2sm388619ywk.72.2024.04.18.08.57.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 08:57:31 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id
 3f1490d57ef6-de466c641aaso872911276.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 08:57:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV9MfeFG2CSvYzLn2NI84OyRkvStfaKZW6gqIkV3jsNznjHZpmSs6RTW8CfmIqqQbCYwYgJGSzYbnppczhsbtExSAiXMBc=
X-Received: by 2002:a25:3628:0:b0:dc7:497e:cddf with SMTP id
 d40-20020a253628000000b00dc7497ecddfmr3579938yba.33.1713455850780; Thu, 18
 Apr 2024 08:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <55a1bc52-b435-463e-8be1-4b23e44393a0@baylibre.com>
 <b5d375ed-283-974a-febf-892760ff855@redhat.com>
In-Reply-To: <b5d375ed-283-974a-febf-892760ff855@redhat.com>
From: Joel Sherrill <joel@rtems.org>
Date: Thu, 18 Apr 2024 10:57:18 -0500
X-Gmail-Original-Message-ID: <CAF9ehCVZddmGe0emH8H6ChjuUxia-NOpxa0dCA=5+2PAnvytZA@mail.gmail.com>
Message-ID: <CAF9ehCVZddmGe0emH8H6ChjuUxia-NOpxa0dCA=5+2PAnvytZA@mail.gmail.com>
Subject: Re: Deprecation/removal of nios2 target support
To: Joseph Myers <josmyers@redhat.com>
Cc: Sandra Loosemore <sloosemore@baylibre.com>, gcc@gcc.gnu.org,
 binutils@sourceware.org, 
 gdb-patches@sourceware.org, libc-alpha@sourceware.org, 
 Chung-Lin Tang <cltang@baylibre.com>, andrew@reenigne.org,
 Yao Qi <qiyaoltc@gmail.com>, 
 Dinh Nguyen <dinguyen@kernel.org>, qemu-devel@nongnu.org, newlib@sourceware.org,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/alternative; boundary="00000000000053094c0616610725"
Received-SPF: pass client-ip=209.85.128.169;
 envelope-from=joel.sherrill@gmail.com; helo=mail-yw1-f169.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Apr 2024 13:37:15 -0400
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
Reply-To: joel@rtems.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000053094c0616610725
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 10:46=E2=80=AFAM Joseph Myers <josmyers@redhat.com>=
 wrote:

> On Wed, 17 Apr 2024, Sandra Loosemore wrote:
>
> > Therefore I'd like to mark Nios II as obsolete in GCC 14 now, and remov=
e
> > support from all toolchain components after the release is made.  I'm
> not sure
> > there is an established process for obsoleting/removing support in othe=
r
> > components; besides binutils, GDB, and GLIBC, there's QEMU,
> newlib/libgloss,
> > and the Linux kernel.  But, we need to get the ball rolling somewhere.
>
> CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.
>

Just an FYI that the RTEMS Project plans to drop NIOS II support based
on what happens with the tooling.

--joel

>
> --
> Joseph S. Myers
> josmyers@redhat.com
>
>

--00000000000053094c0616610725
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 18, 2024 at 10:46=E2=80=
=AFAM Joseph Myers &lt;<a href=3D"mailto:josmyers@redhat.com">josmyers@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On Wed, 17 Apr 2024, Sandra Loosemore wrote:<br>
<br>
&gt; Therefore I&#39;d like to mark Nios II as obsolete in GCC 14 now, and =
remove<br>
&gt; support from all toolchain components after the release is made.=C2=A0=
 I&#39;m not sure<br>
&gt; there is an established process for obsoleting/removing support in oth=
er<br>
&gt; components; besides binutils, GDB, and GLIBC, there&#39;s QEMU, newlib=
/libgloss,<br>
&gt; and the Linux kernel.=C2=A0 But, we need to get the ball rolling somew=
here.<br>
<br>
CC:ing Arnd Bergmann regarding the obsolescence in the Linux kernel.<br></b=
lockquote><div><br></div><div>Just an FYI that the RTEMS Project plans to d=
rop NIOS II support based</div><div>on what happens with the tooling.</div>=
<div><br></div><div>--joel=C2=A0=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
-- <br>
Joseph S. Myers<br>
<a href=3D"mailto:josmyers@redhat.com" target=3D"_blank">josmyers@redhat.co=
m</a><br>
<br>
</blockquote></div></div>

--00000000000053094c0616610725--

