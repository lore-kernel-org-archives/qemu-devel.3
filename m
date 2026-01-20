Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288E0CA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viG9z-0004vU-DW; Tue, 20 Jan 2026 13:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viG9x-0004tJ-UQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1viG9w-0001A7-BZ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768932535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mouOSSzzI0UCtLoFDGRHKVw71uuJyZrJ1WDNIuybGig=;
 b=EcU7l3zvxdsx0NY3Gn0o2vWT99Y3hqcMuJyyMgTOQWxASRdokMEndYp2yXcsix4Ca+330s
 1AlgMElzRjcDa0+sWbNBJ3fuHzbzCzr5FH/n9bcBM8fceQIl2EXT2d2z/CbSO7mSpivzH5
 SJvRlFb/jQxE0sFbOob7WslHKCiztF0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-QbxpF84mMYyzozJjUz3FQw-1; Tue, 20 Jan 2026 13:08:54 -0500
X-MC-Unique: QbxpF84mMYyzozJjUz3FQw-1
X-Mimecast-MFC-AGG-ID: QbxpF84mMYyzozJjUz3FQw_1768932532
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79269803c05so65165387b3.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:08:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768932532; cv=none;
 d=google.com; s=arc-20240605;
 b=NjgkiZNJn58prTz6llIEqOpZ1eZwhv/8jAoXSal5EvNpaKtamaZ9ynKrnk9rKR4DIE
 jRISywOgREEePomz5dtHivPSz/RqAgU7lsAkmq2zSFCg9IIoHZj4LjUN1halntTt+31i
 5KAfz2JedQyVPpyPKPWVdIU/pVaCS9l/kkJpskqhMDNeh3DVR6K/MkiVQ+XMn38d2poF
 Hgn/4oEr1ItVpE3odhR1YziGi02480+rX2VkunJ+CEvCnf6Q29v6jldM0J2EzjQx4fgl
 pwXcnkLrkP3pC7jBAZGY0gnMqD2mJ+GF+UhPvnhc7SzChTtd4ea0qX2bD5a44VBb69M7
 8yDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mouOSSzzI0UCtLoFDGRHKVw71uuJyZrJ1WDNIuybGig=;
 fh=ABFaPHFUGftIDeuiwfhdCvWwlDIqwEOXtW9ZV6M/MzU=;
 b=fWPFfACCsnXT5ri/gileaG7W7pSm9I9pu0UUz7RpcWsqbDnr9mnPdn3X5q6ymCNxXV
 1R6ww525feSmuK25tjpaPbGw6bDay5nZXTSbdLRC6I8Urb+fV3O3nXfJfDRYUm5r9hNg
 KP+D+uu6nhjdQtcuKatWt1aK1gVyGHyCg3vFsqQAIQGPVpM31OpWZ/JDRDb4YS9OneSb
 ME65XhXx5+sX/y7vRXnvBs9+MiuNgwdiMTR4QGdchti2F6uG/XGGkQ19v7KuuSRXMWy7
 pMvOlXVfcm23xUmJsMpjygAbkcJUyehgMMLckM2zORLpANz0wqhWBHNEl5mHskgw8+SE
 d97w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768932532; x=1769537332; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mouOSSzzI0UCtLoFDGRHKVw71uuJyZrJ1WDNIuybGig=;
 b=QxW6zroqFLTkov4tD8mq2DnPUXPBaC1QM3RIxG6QDDDmP3nBKGpcTbg9suGgJ8iZ7h
 sUv3EveeRs87AVToL4LTNFmwySy39JaXaQqeyx30klT7Ur01Wwqi4GaI8H4qKuTD4xU3
 JjzBnu/z+2j+ImjxrtRxY82ISBDrokjw2yYUzb4gvEFoZZvwfa1OuMwApt0i45ZM6vTH
 XYhlLgMDgRhQPHo7Yji87nasDj+LRjKmZBmlI1DXP3Eku+J7WxeeMT34b8bFiuVPt8sv
 gnPAErBmbTBkKyt348P2ZftQWCJF5UQ9Fy45LRbydMqYwMiUXuyNhiQeHF2GF+XGUSUk
 TaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768932532; x=1769537332;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mouOSSzzI0UCtLoFDGRHKVw71uuJyZrJ1WDNIuybGig=;
 b=PFGT2VHWFDamfNbbUw5SVeRriB5Lo0E8tueM4hUvN6nAS7n98GKe9RjRMRAFXtQ+Mv
 ypMRPAFogyJabliDF80BI1ITwihRRu2Ah/ZIDBG6XWvaxV5D9WFPCj2j5v8XLmh1cRII
 XTlyzB1jq7QjbxqdSJXTTrKPC/Zn2bM8Hf69lByIvtrsGBJWL/4BUp1WLB/hvLDve4cr
 VifyRv8ExyA15rs1XPb6zUFG4yUPzi/B5Qp9kzo1bu3NvWWJjDR+d8Hs/4KCJlmc4UL4
 Hr1f7xLkKbEs9j73wbQ14vtXjK75W2NV68Yvrxcs2q0XBEqjkonE14AsKkWRCkoGbb4U
 +ycg==
X-Gm-Message-State: AOJu0YydFMSprH/MdfmcAeOooQC37aTs8/hTKO2ExuDBhhpVd9/OGzT4
 R9iPe+JXOBdT+m8JWmXr5KzIJ4aWm31vKIJkZQkNKDgq3akbWTtIows4k4aewWE5aRzxbe+i7Pg
 q5t+oPIYtV4y75J/mG4R1CCd+euN8j9y4ijgAKPObqK4qbbIhmkZmhOq6AWUB0LYoFQgjWDZ+Io
 AmUv297DcO5wRUoi2tv4+E+fVwMiMucq4=
X-Gm-Gg: AZuq6aLnX3eyWmlq/6UvTtLDiFj5uedHYSFyY1O+h2sH2kP4uQZ0JpmQNDjNhZMqCap
 S4Q6kylvgmdg2hZywrIGxF+RUhgxn2yG2e9iFn9uinBv1gTbEBgsVg3/MhV5LnbL7YtG0uUaW5Y
 t2y5u8AYJRwy8q8Rz/5kp9DhBal3dDchNS9+AqTGrzBAk3tbH9azaOIL7GlNNwyqFgB07zOqXNp
 qWVAAwUjvCMN4xTZtXDM9Xcjw==
X-Received: by 2002:a05:690e:138b:b0:649:422e:a68d with SMTP id
 956f58d0204a3-649422ea842mr900234d50.69.1768932532269; 
 Tue, 20 Jan 2026 10:08:52 -0800 (PST)
X-Received: by 2002:a05:690e:138b:b0:649:422e:a68d with SMTP id
 956f58d0204a3-649422ea842mr900176d50.69.1768932531165; Tue, 20 Jan 2026
 10:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20260119212744.1275455-1-jsnow@redhat.com>
 <20260119212744.1275455-17-jsnow@redhat.com>
 <aW9FXOvNIvKyfYPn@redhat.com>
In-Reply-To: <aW9FXOvNIvKyfYPn@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 20 Jan 2026 13:08:40 -0500
X-Gm-Features: AZwV_QiVMRFoZxfRqjZb_ot553G9lN97x6QDJBnapHIu9t_cvje1QfxRGbr_Nsc
Message-ID: <CAFn=p-aZeH6RFNxatEYTueX-kTP3davDb06MykJJ-DRqQ31a-w@mail.gmail.com>
Subject: Re: [PATCH v4 16/17] python: update README.rst to reflect qemu.qmp's
 removal
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>, Li-Wen Hsu <lwhsu@freebsd.org>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, Ed Maste <emaste@freebsd.org>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 20, 2026 at 4:05=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Mon, Jan 19, 2026 at 04:27:42PM -0500, John Snow wrote:
> > It is no longer simply possible to just use this directory as if it wer=
e
> > an installed package now that it has dependencies, so update the README
> > to reflect this.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/README.rst | 50 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 43 insertions(+), 7 deletions(-)
> >
> > diff --git a/python/README.rst b/python/README.rst
> > index d62e71528d2..2accfd7760e 100644
> > --- a/python/README.rst
> > +++ b/python/README.rst
> > @@ -3,7 +3,17 @@ QEMU Python Tooling
> >
> >  This directory houses Python tooling used by the QEMU project to build=
,
> >  configure, and test QEMU. It is organized by namespace (``qemu``), and
> > -then by package (e.g. ``qemu/machine``, ``qemu/qmp``, etc).
> > +then by package (e.g. ``qemu/machine``, ``qemu/utils``, etc).
> > +
> > +These tools and libraries are installed to the QEMU configure-time
> > +Python virtual environment by default (see qemu.git/pythondeps.toml
> > +"tooling" group), and are available for use by any Python script
> > +executed by the build system. To have these libraries available for
> > +manual invocations of scripts, use of the "run" script executable in
> > +your build directory is recommended.
>
> s/executable//, it is just a "script"

ATM machine, HIV virus, LCD display ... (oops)

>
> > @@ -61,8 +81,24 @@ invoke them without installation, you can invoke e.g=
.:
> >
> >  ``> PYTHONPATH=3D~/src/qemu/python python3 -m qemu.qmp.qmp_shell``
> >
> > +Or, with the runscript available in the QEMU build directory, simply:
>
> s/runscript/run script/
>
> > +
> > +``> $builddir/run qmp-shell``
> > +
> >  The mappings between console script name and python module path can be
> > -found in ``setup.cfg``.
> > +found in ``setup.cfg``, but the console scripts available are listed
> > +here for reference:
> > +
> > +* ``qemu-ga-client``
> > +* ``qmp-shell``
> > +* ``qmp-shell-wrap``
> > +* ``qmp-tui`` (prototype urwid interface for async QMP)
> > +* ``qom``
> > +* ``qom-fuse`` (requires fusepy to be installed!)
> > +* ``qom-get``
> > +* ``qom-list``
> > +* ``qom-set``
> > +* ``qom-tree``
>
> Those scripts all exist in $GIT/scripts/qmp/.  Are you saying that
> they get installed into the venv now ? If so, should this series
> also delete scripts/qmp ?

Right, those files are all long since obsolete. For the past several
years, they've been simple forwarders to the real scripts. However, I
thought it was good to leave the stubs there for a little while to
teach people where they now live as a bid to increase discoverability
of the scripts. I was afraid that if I deleted them outright, they'd
become functionally invisible to most people. After all, we only JUST
added that run script, so it may not yet be established knowledge that
the meson development venv comes with various "goodies" that we
promise will work, so I was concerned people may not know how to find
them.

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


