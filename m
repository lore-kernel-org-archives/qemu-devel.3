Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521DAC44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1virfj-00069L-Hb; Thu, 22 Jan 2026 05:12:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1virfi-00065q-KL
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1virfg-0007WS-H0
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769076730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RSoYsSxmV6NW/W4JTETo9GWsrA5GKc523TA77g8X2kA=;
 b=f2GdDWcnWOoXlVxhsGRI2k7fgBJ/OOQTUCEFJtmKBBtm7t4D4hYQfneMVC0ZcKfkSzOlVY
 JgUidiWTNBUg9nMgQ+or2mHlUd9dziFknGihsxAFGUlMUxXCc1oJqzSiI/AapeHYjoW1ot
 S0RYRnsNlQs1cAHRb2FCWxw3D0TClQU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-kgFBs-_KNqS71PNkrg7clg-1; Thu, 22 Jan 2026 05:12:09 -0500
X-MC-Unique: kgFBs-_KNqS71PNkrg7clg-1
X-Mimecast-MFC-AGG-ID: kgFBs-_KNqS71PNkrg7clg_1769076728
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-34c64cd48a8so988936a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769076728; cv=none;
 d=google.com; s=arc-20240605;
 b=P0jqlCEeXeoqOuumI/vT9qE6Mx9uFYcgLFrRUKzoDHsSgjVUE7j4EQ2y7pT/L81u5v
 atmHzn/tqrgPUshOw304Pzfhq/ZqxgIVy2Mb0Vv8zx2adjoT2++5q7loKqYjyVPrfdZA
 OsH46UCErd3M3NlrYbCqGT42ClvFreeXyzaqYbH7La88Q+qv1ZmkDYGyo2jAsKyTilvs
 3atr7GPmDo+MWdHxjAwXBz/5eirXqe1SPNOJZBHh8fXW+a4Aef975c+6fVAmzwK4tes8
 hSYDnDHgaX3d9qmawiGes+Oc3QzMIbFZMYz47R7eh+XuR7RX3F1px1eApSLbK5FeGLkC
 +DSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RSoYsSxmV6NW/W4JTETo9GWsrA5GKc523TA77g8X2kA=;
 fh=kQ48tpsSf4HApycdsTZd1vCC6Lu9wZJw641Ev6sFXLs=;
 b=FIyNvVmCh223OHoBtGuOF8iy6IcxMGYTeCg6Xc01ySeTZEtov2SRyLdoSJnsquT1kV
 QF7WHG1mVsXOMNjFIrHw/Fp55/w3wbpS/nduHCgvbQDYLgpv6ifZhaWm9KMdRAXOqe48
 fj+r9THERb0XwKG6LGgHocPSaV1zfQFN4xpzHvxrd6uKOBsoACuP6J54M4g1Tm6Yq6WT
 RRLyNgT5rHWFk/rwLwpKW6MAjND7i3tOkB6ICbcAolJeYAd+lbtxsJ6ea3F+6OD4BMr4
 fJhQAiVLzqBL8sQNc1r8a/qznSb96ENbUYRtiPs2/qU+8CI67nJ9G8CLah7q3UTSOUgZ
 Z+QQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769076728; x=1769681528; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RSoYsSxmV6NW/W4JTETo9GWsrA5GKc523TA77g8X2kA=;
 b=iC9k8oaUHz+WSpgUhjCiEIP1avmgj8gmonCg3YqYrgJCBfZbamFN6Bws//mO+QJ/R8
 5CPm23FJ1eJAprTadmhJlUXmZQSssnMLgfA0Mt357irgFP91pGrja1+cNSli68BosyR3
 EK1Qy+kyYfq1owOFMLi4JfDsPDuWSXQ1W2eb8r4WhFPz72NO/9WW9ZA8dy+uw87tPUUP
 p9tGiNSSBEYay3DLugt3vbaeTTesVAL6Xwtr9IASSvPMNWKNvkcUCsp3ELOUg+rY1662
 0ue/9QF2iRjrN2D5LHDQV4SdtlvETrUS35b2Sei0Ag8xOHO7RbqmH9DfPxDbwgYmSc+H
 YIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769076728; x=1769681528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RSoYsSxmV6NW/W4JTETo9GWsrA5GKc523TA77g8X2kA=;
 b=VoZydroeFTaUH8RaNMap2H9GfnO4VY83cwh5t15Zjy4SjWVzB3w8xIcnraxfR4GoNI
 DQ6BTkYvZEbD/DLI1uMyjq0dhNlWYXUN+cl3CkE0BUSiKZo1Tx+HLTG3qnuL+CODQEV0
 ltpMUoYQVSFmlXvGfwyAETwDvnVusB//SmJWMq30Cz8QNzBORGYlXEcCUzVZxYtya30Y
 yobshpSiMaz9wivPwvsCfLidkWZBVnO4jdaSCVatimIG6HE5nl8N2790QwnaI6pCqfHp
 f51L0+S0mdanfaAj1CjJ3nczWCgNMC3MiU8uVXCPZV/a/iEa/t2bJ4lRZGDaqYpeMUQQ
 WhQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9ifBNJqPjkC+GmXBbQ4kqK9Ri1+4wBTqkUDyWoqhZ7MD6I78Es8Y1hmB2LT1nPB44k74Bm2DnNE/m@nongnu.org
X-Gm-Message-State: AOJu0YxP3NsmiQ1/W5w5k49jCYl6/P7L4MV4uQM0TgY4R+RndsJ8yIs3
 oYrEXll7f8AkCUkPQLi+42Emq0Ztt6REPsEOmkHWKQKXGGOf7eyPBkAo9cInMIsgFQUVon/cyYj
 TGDN74iR8t5v+4aZ/rh4Fq7Rac9YuvDXKEBN6vwBTZvOvWPeod+nFZvVfdxIyH41G4WGsIpn+RT
 RL3I0dKWYDb8QQA6Ca97xre91AD1CiUM4=
X-Gm-Gg: AZuq6aJ/NsR97iWnsnltEUaY/D5kWyVQCz+83dnRuXdSXE+ZAwY1+oYNJLMGKmDQ/00
 NNxafVKajv+aWjTIDH86c1OJBNkyI5I7BTunLl9xYopebjl8QLuidv3aoQTAF/J3iuAUNEhvCaB
 cPXFYbG0SClhIGVSRRTKl10KdxoIsOSDk7gJ5AVfdPv2WTxZvubrqZHaXA0eRTOU24a36GzEE7X
 SaU4UZZ0AeaFop1emcs+0g4mA==
X-Received: by 2002:a17:90a:c2c6:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-35272f97198mr17809987a91.20.1769076727993; 
 Thu, 22 Jan 2026 02:12:07 -0800 (PST)
X-Received: by 2002:a17:90a:c2c6:b0:341:8bda:d0ae with SMTP id
 98e67ed59e1d1-35272f97198mr17809966a91.20.1769076727638; Thu, 22 Jan 2026
 02:12:07 -0800 (PST)
MIME-Version: 1.0
References: <20260122090352.9901-1-thuth@redhat.com>
 <aXHtxBfuIRsJ3P_M@redhat.com>
In-Reply-To: <aXHtxBfuIRsJ3P_M@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jan 2026 14:11:56 +0400
X-Gm-Features: AZwV_QgVz5uh-JRUzNeRMk49kFEeyLXxxpBcj5yngyQr5YvkB0bBnZN0oFHFVcU
Message-ID: <CAMxuvaygPAOJiZcRCZ=W+Ly=b8Nq9L1y2sRtraz_+hfiXwLVvQ@mail.gmail.com>
Subject: Re: [PATCH] Replace CONFIG_WIN32 with CONFIG_WIN64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Kostiantyn Kostiuk <kkostiuk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 22, 2026 at 1:28=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Thu, Jan 22, 2026 at 10:03:52AM +0100, Thomas Huth wrote:
> > From: Thomas Huth <thuth@redhat.com>
> >
> > We stopped supported 32-bit Windows hosts a while ago already, so
> > let's rename CONFIG_WIN32 to CONFIG_WIN64 now to make it clear
> > that this switch is not about 32-bit Windows anymore.
> >
> > The patch has been created with a simple sed statement:
> >
> >  sed -i s/CONFIG_WIN32/CONFIG_WIN64/g $(grep -rl CONFIG_WIN32 *)
> >
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  meson.build           |  2 +-
> >  qapi/char.json        |  4 +--
> >  qapi/misc.json        |  2 +-
> >  qga/qapi-schema.json  | 76 +++++++++++++++++++++----------------------
> >  include/qemu/futex.h  |  2 +-
> >  include/qemu/xattr.h  |  2 +-
> >  hw/usb/host-libusb.c  | 18 +++++-----
> >  io/channel-watch.c    | 10 +++---
> >  ui/gtk.c              |  2 +-
> >  util/cacheflush.c     |  4 +--
> >  util/sys_membarrier.c |  2 +-
> >  scripts/checkpatch.pl |  2 +-
> >  12 files changed, 63 insertions(+), 63 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index a84f14258b0..01b9a5c22ce 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2422,7 +2422,7 @@ config_host_data.set('CONFIG_GCOV', get_option('b=
_coverage'))
> >  config_host_data.set('CONFIG_LIBUDEV', libudev.found())
> >  config_host_data.set('CONFIG_LINUX', host_os =3D=3D 'linux')
> >  config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
> > -config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
> > +config_host_data.set('CONFIG_WIN64', host_os =3D=3D 'windows')
>
> While relevant to qapi file conditions, from a C code pov all of these
> are redundant as the compiler has all these facts built-in
>
>   #ifdef CONFIG_LINUX =3D>    #ifdef __linux__
>   #ifdef CONFIG_POSIX =3D>    #if !defined(_WIN32)
>   #ifdef CONFIG_WIN32 =3D>    #ifdef _WIN32
>
> NB,  _WIN32 *is* set on 64-bit Windows platforms too, so using
> _WIN64 is only needed if you have a code path that is exclusively
> 64-bit only, so there's little need for us to use _WIN64.
>
> And of course we are horribly inconsistent in what we use:
>
> $ git grep -E '#if.*_WIN32' | wc -l
> 284
>
> $ git grep -E '#if.*__linux__' | wc -l
> 90
>
> $ git grep -E '#if.*CONFIG_LINUX' | wc -l
> 142
> $ git grep -E '#if.*CONFIG_WIN' | wc -l
> 16
>

There is also G_OS_*
$ git grep G_OS_UNIX | wc -l
15
$ git grep G_OS_WIN32 | wc -l
23

Replacing WIN32 with WIN64 doesn't make much sense. It should be
either WINDOWS or WIN32.

The Windows API is still called that way, even on 64-bit systems:
https://learn.microsoft.com/en-us/windows/win32/

> I'm inclined to posion all these from the C source though, and only
> these them from non-C locations.
>
> Also IMHO  CONFIG_WIN  or CONFIG_WINDOWS is preferrable - we don't
> add '32' or '64' suffixes to CONFIG_LINUX or CONFIG_POSIX, so I don't
> see a reason to keep doing it for Windows.
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


