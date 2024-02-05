Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1B8C48297
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:55:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2F2-0003n1-No; Mon, 05 Feb 2024 11:54:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2F0-0003ms-88
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:54:42 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2Ex-0000TP-Oa
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:54:41 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2a17f3217aso622214266b.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152078; x=1707756878;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWshMZuaQU6ApJW4M686vXIXabvTwj1m/34vJ8RbgzU=;
 b=MQw5B5LJCWQwntZg3Ivzo5Gs6+jhgP4shFeG1xlpvWqhAOMSrBzPdMgyLnCXPdyUM1
 RQvu94by4DmxSHz89bKx/w/Alh7oYF1qXUobmKuj1+CYcnyHl24MLfW3l0apf+af+wp3
 Lppow56ncvondWaKyD9HuRQ9BGBkw8Uwa7AvtsKKCTxqmwh4NUnmtd/bwQ9185CtonVN
 AbvkRIKXlczHBNqTMBzKatc9n71NibrWXsNOcysrekHTW+ekdLfC8dKCw+AGNN+p9788
 MeTPx5BuTY+xWzOIVnc7Tfj6dy/3mZYMMRFtLY3n61XU+3SWuKz2LEmcpc/XTPBHDLcY
 eajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152078; x=1707756878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWshMZuaQU6ApJW4M686vXIXabvTwj1m/34vJ8RbgzU=;
 b=mb5J2Vx0TVgivnQDfDOxnwooWeToJ/tPkpwcCrrOfo9M3IgSYv7YdBpa+T1tPmt01B
 az06WdVA3aCnNj6TRXYtn2hO4h3JQfbeN1vMTDtyLP1kSya95T/iSngZc+O6LQ8mlcyA
 iBZd/WXRNz+tJpsB3ADJSEKBDPfQzWwshu7SV61vBy7xA4Y/MzWMKpymHfBItOEbg+GZ
 6lTNUkRNPO1r8yUNJq104YYAFpmWVZQaBuOiXggGdIBXoLKS8ufuWZvAOAskDWkvebC9
 n3CGA57niufy6bHQ+UGQybR/P/X07vSAoD0v++oBohCp2u6ioEbNJbtFwcWKZX9wu2PA
 jBPw==
X-Gm-Message-State: AOJu0Yyrs0stkuJ1xBIwFldYxPCIN+PXxKCpxSw1VLmcv2Zod/Oc5oze
 zNJRPKZyG8/KbxdZCxD53Z7ARfYt5HQThno8TkbKD8v0C5x0vkBoFJwqGTVCrDK5JnJsTcIAkY2
 2lhs/ohqoyEZfEn4B0Mde+tv71TVuhtfZDd0lGIHT1nacMEV+
X-Google-Smtp-Source: AGHT+IESB1GdWyfCmwevFndSFSWvnx36muJEb+cQwadBvNdBlqsXe8MZr/IRiwTByN3YiVEkWMAZnrLa+4LvEPUKTk4=
X-Received: by 2002:a17:906:e252:b0:a36:927e:cc0 with SMTP id
 gq18-20020a170906e25200b00a36927e0cc0mr17894ejb.9.1707152077826; Mon, 05 Feb
 2024 08:54:37 -0800 (PST)
MIME-Version: 1.0
References: <20240125130656.425607-1-andrew@daynix.com>
 <20240125130656.425607-2-andrew@daynix.com>
 <ZbjRhyNtjajkYQ8i@redhat.com>
In-Reply-To: <ZbjRhyNtjajkYQ8i@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Mon, 5 Feb 2024 18:54:26 +0200
Message-ID: <CABcq3pHikAHdaMN5k-gLktD_k1LODJuH-ZOojzyxNyv+iuevdQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/5] ebpf: Added eBPF map update through mmap.
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com, 
 qemu-devel@nongnu.org, yuri.benditovich@daynix.com, yan@daynix.com, 
 akihiko.odaki@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::62c;
 envelope-from=andrew@daynix.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all,
I'll revert the license changes and leave SPDX ids only for new files.

On Tue, Jan 30, 2024 at 12:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Thu, Jan 25, 2024 at 03:06:50PM +0200, Andrew Melnychenko wrote:
> > Changed eBPF map updates through mmaped array.
> > Mmaped arrays provide direct access to map data.
> > It should omit using bpf_map_update_elem() call,
> > which may require capabilities that are not present.
> >
> > Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> > ---
> >  ebpf/ebpf_rss.c | 120 ++++++++++++++++++++++++++++++++++++++----------
> >  ebpf/ebpf_rss.h |   8 +++-
> >  2 files changed, 101 insertions(+), 27 deletions(-)
> >
> > diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> > index cee658c158..c6e10265a7 100644
> > --- a/ebpf/ebpf_rss.c
> > +++ b/ebpf/ebpf_rss.c
> > @@ -7,8 +7,7 @@
> >   *  Andrew Melnychenko <andrew@daynix.com>
> >   *  Yuri Benditovich <yuri.benditovich@daynix.com>
> >   *
> > - * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> > - * the COPYING file in the top-level directory.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
>
>
> > diff --git a/ebpf/ebpf_rss.h b/ebpf/ebpf_rss.h
> > index bf3f2572c7..404cf53613 100644
> > --- a/ebpf/ebpf_rss.h
> > +++ b/ebpf/ebpf_rss.h
> > @@ -7,8 +7,7 @@
> >   *  Andrew Melnychenko <andrew@daynix.com>
> >   *  Yuri Benditovich <yuri.benditovich@daynix.com>
> >   *
> > - * This work is licensed under the terms of the GNU GPL, version 2.  S=
ee
> > - * the COPYING file in the top-level directory.
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> >   */
> >
> >  #ifndef QEMU_EBPF_RSS_H
>
> Thee are changing the file license. This *must* be done as a
> standalone commit and show agreement from all contributors
> who could hold copyright over the code. Fortunately I only
> see one other contributor to these file, and the scope of
> their change isn't copyrightable IMHO.
>
>
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

