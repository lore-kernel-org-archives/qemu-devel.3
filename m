Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5319C606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QW7Il2sk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SnCLeT9P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPOH5-0004vF-CC; Fri, 06 Nov 2026 13:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPOH4-0004v6-46
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:02:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xPOH2-00005Z-9L
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 13:02:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793988166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUQsgGk4laUR02Tf1MlIpkZNp22qQO/ItLpjFv7nYe4=;
 b=QW7Il2sk6T/lCHw6vsY5upOTXvBID57AA/wM7/LDyrTFAAauBuk1jt2QEAOn+I/J6JhUiC
 cZ4yXRF86P5ai6JyBao2SDHaD5Jp8eRUfS/cOeMhKu6GTnxI6LO12vUVVhcBsF+C1scjbv
 5AE2svZGNOh2bKm8npdIaTxDsUb+pQA=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-9TEOMIJ6OdmeE9wpkuerKQ-1; Fri, 06 Nov 2026 13:02:45 -0500
X-MC-Unique: 9TEOMIJ6OdmeE9wpkuerKQ-1
X-Mimecast-MFC-AGG-ID: 9TEOMIJ6OdmeE9wpkuerKQ_1793988165
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6798fd97f3aso1516631d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 10:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793988165; cv=none;
 d=google.com; s=arc-20260327;
 b=NRq2e/bOv3W+e9LZtd4pRnB8MAmqXH/8URzlSyQAF7+WFqljBMt+o+Wxem4yS+SesL
 usqe7s8hEFwbkGqGxNjTpS4avkaDVePgKbuSA+NpUt/QkyzxSZDhe66FcxcdG0SOsXrQ
 TJnw9eUXxVuMis7KLgQvqX+06Ef5GHDwUr7WELfMNEcCKzZ/39F9y6GxE2FY1APY8RlX
 VnAVGoXjfYwqZtbq3qzkf4y5KhbqLpVvGOjBHrF6AoKWelOCR7DdeBZp5TYJqN81Gl92
 fgjaC0O1kauHS2hjuWvOeFCx3PT2ZsVlpdG5kGFgWCDcf9ZLXra+u5S3vtFNqkf5miUx
 YjLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zUQsgGk4laUR02Tf1MlIpkZNp22qQO/ItLpjFv7nYe4=;
 fh=WoI/ACOhU3eHZYq9MTnqXgqLXSFenIguNnbSsHkimMc=;
 b=ciPPNoEj56Mw0pJBCKB1jvdx+/sgELPGhRyGCno9AC6heEapCHjRoGveDw88Fz5Iiw
 3g8TEgLQHCInSh79tXTw2b6ftDiiFd1E4wG+Femx3gXZZ/6axBIlckNSVLgSXK8DJau4
 Q1poz/Qmf08S+g2DAks1BYLNFUWLh3cSRkqkx7nHxfrhDO4HmG0M0kODEf5dVcqzJby4
 wVygFuecqQW9s+7MVx4vwnZUumjMqckDwANuYM0h3TrrPpZyoayjAuIXBbQ8KJ3y2YZb
 qh/g8ceaE83kM83MK77ZV/cfVNf/474RnZn1QAGAF2z7gHeIBrEMo+OyFnsd8q3aUQ8j
 iCJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793988165; x=1794592965; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zUQsgGk4laUR02Tf1MlIpkZNp22qQO/ItLpjFv7nYe4=;
 b=SnCLeT9PuN7hST0mvsqFEhi4C71sYVhvLIhdOV+iNEGKX5WgMLtLSF9/Wx2uoJAlqA
 vXp1QCI6G3etc+e6mb921qSZYf9sJDshojSLq1GTxphS+SJmfoaxAAVDFuAEHode8Cbt
 SepF36L8C36KBQWfjtUl9YeVIiGoknrc5VQNIqrg9f3f8Lo1/GuZyqwA2AMqxqtQwI+Y
 Bgz2SKI/+RxkL8A498Ve8c660sx0jiwnzbzwGpEqRdXA1Udr7HGtBmB8rq/a+MhXSoTw
 9NJjZgrCS+/EzIgjPE0zay9wcJnCxKD8ii8VwO6PJjPulotxPlo/HUw9dtsPbIGw+q74
 a5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793988165; x=1794592965;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zUQsgGk4laUR02Tf1MlIpkZNp22qQO/ItLpjFv7nYe4=;
 b=zncpZrv2Hcyv3wLNGxkWleHqfT+1r57qU2RY9dWS9cfjkNhBJRwiIbk6olifOh7j08
 8xPKmHTwIU14dIck5iexnD70eXC0EbaG8gNQxV17L+kokCZe3nsnz9U76L3cX5oAKU5U
 Yld9bGzZQz6uTihcduEES09nhEK3k6VLizxMKPuexIXY2t0O/Rw/kjjd067m6JRPLxaP
 9K3ta9afMTJZOxNPaRb3pK5h7GS+tuMgB5lMJxbv+XIWTHc8DRbjcDRvZ+AroIz/mXZV
 CXLYewjP7FXOTiVTb/OWVySFXp3I2WdPbg5XcJCh2TOdzbYLof0kj2dv95RjYhzukKSE
 PfUw==
X-Gm-Message-State: APuU4Z9Ghj6+zdrweaMeLPIr8SiVVu7WPXceHupR7qLv0s6ipR+VXzrv
 MHuNtXFhuqupvsoJzvrBnbbqKFUzVVBuvQpD+7U8VPdfqcFx3Znug+8TUvo3ytvrSUGv5pCOAHS
 tiM+pXqbW/Oc76fISJ9EDUzLRUImX5Ow6+GrPy2FK2XkVlZfzHEcm7fMvUTje4rtPrp4EVH78wY
 MFZOHYl54urWnx1ISicXM1j5rg63Xrpk8=
X-Gm-Gg: AYBFou3bz9xYncTStwfSEaXM9C4ilQNljD4lN2ARkck5OAC9W6L/i9wDLYrUbQzVv2l
 Iy8ZYOsyVg3pZOH2nhcSFWfsqP8EKdgsdQcfLa6Dp3NqwYjcOg2Bzl/11x+YdqvLHF5ZrudYNob
 jWw7h4qzDnu9pdDybyvHNwalNgbFfbKsvtiEacQXaJSFCQSe7+ZTG1wyuvb/ssUfy9BvNxOuv8Z
 lQYWL6VBimscgo8
X-Received: by 2002:a05:690e:d4e:b0:67b:ee77:8cef with SMTP id
 956f58d0204a3-67c1465090amr1471688d50.155.1793988164768; 
 Fri, 06 Nov 2026 10:02:44 -0800 (PST)
X-Received: by 2002:a05:690e:d4e:b0:67b:ee77:8cef with SMTP id
 956f58d0204a3-67c1465090amr1471674d50.155.1793988164247; Fri, 06 Nov 2026
 10:02:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021063105.102520-1-kraxel@redhat.com>
 <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
In-Reply-To: <CAFn=p-anhY5nzcjqeVjqvmVkbi1c3=SeUYxJoFqDhCXmbRM4VA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Fri, 6 Nov 2026 13:02:33 -0500
X-Gm-Features: AclHuK8xtr8QsWbXLeuGDd5d_pmBdW6VxuJxzR80tI9Tw7KJeq0UK3EYKmDPDL0
Message-ID: <CAFn=p-ZKX81fjQH8OdGAq7ErJ9bc2BsLtn2jEicUmgwWdjQYEA@mail.gmail.com>
Subject: Re: [PATCH] x86: mmap kernel for direct kernel boot
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 12:02=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
>
> On Wed, Oct 21, 2026 at 2:31=E2=80=AFAM Gerd Hoffmann <kraxel@redhat.com>=
 wrote:
> >
> > Reduce memory footprint by mapping the kernel into memory instead of
> > reading into allocated memory in the common case (no -dtb $file on the
> > qemu command line).
> >
> > Cc: John Snow <jsnow@redhat.com>
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Tested-by: John Snow <jsnow@redhat.com>
>

Ping, is someone going to pick up this patch?

--js

> Using this patch, I shifted about 19MiB of resources from RssAnon to
> RssFile. This theoretically allows sharing resources between multiple
> QEMU instances in the trivial case using -kernel and -initrd. This
> matches how we already load initrd.
>
> --js
>
> > ---
> >  hw/i386/x86-common.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> > index fa18bf1aeceb..25e141aa8537 100644
> > --- a/hw/i386/x86-common.c
> > +++ b/hw/i386/x86-common.c
> > @@ -911,16 +911,31 @@ void x86_load_linux(X86MachineState *x86ms,
> >      }
> >
> >      setup  =3D g_malloc(setup_size);
> > -    kernel =3D g_malloc(kernel_size);
> >      fseek(f, 0, SEEK_SET);
> >      if (fread(setup, 1, setup_size, f) !=3D setup_size) {
> >          fprintf(stderr, "fread() failed\n");
> >          exit(1);
> >      }
> > -    fseek(f, 0, SEEK_SET);
> > -    if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> > -        fprintf(stderr, "fread() failed\n");
> > -        exit(1);
> > +    if (dtb_filename) {
> > +        /* read kernel into allocated memory, so we can realloc for th=
e dtb */
> > +        kernel =3D g_malloc(kernel_size);
> > +        fseek(f, 0, SEEK_SET);
> > +        if (fread(kernel, 1, kernel_size, f) !=3D kernel_size) {
> > +            fprintf(stderr, "fread() failed\n");
> > +            exit(1);
> > +        }
> > +    } else {
> > +        /* mmap kernel */
> > +        GMappedFile *mapped_file;
> > +        GError *gerr =3D NULL;
> > +
> > +        mapped_file =3D g_mapped_file_new(kernel_filename, false, &ger=
r);
> > +        if (!mapped_file) {
> > +            fprintf(stderr, "qemu: error reading kernel %s: %s\n",
> > +                    kernel_filename, gerr->message);
> > +            exit(1);
> > +        }
> > +        kernel =3D (uint8_t *)g_mapped_file_get_contents(mapped_file);
> >      }
> >      fclose(f);
> >
> > --
> > 2.56.0
> >


