Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A057ECF34BA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 21:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLpXY-0007ad-EY; Wed, 19 Nov 2025 16:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpXX-0007aN-Ez
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:16:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vLpXW-0006QK-3T
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 16:16:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763586992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZU0cYpUKibMgIkOkyBk+sZaW4964Va6Pih1JUDjQCw=;
 b=BcS13KD3GgBuRa636EPQaZs1tOFrpd7h27+WV731M8WXFRy1NPfaVQEZsVAEQqClAgNEHJ
 5aPVAGnFwO4FkAwyMJ2FvuFkMTMjoacf4pj7CwI78vKyeZBTpvTUgN3B2nvCiOHSW/LHxN
 qs4oyqKUIavTnKgah+yBnduv++LJr0M=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-LrkcoSD-M62GCHOpoMO5WA-1; Wed, 19 Nov 2025 16:16:31 -0500
X-MC-Unique: LrkcoSD-M62GCHOpoMO5WA-1
X-Mimecast-MFC-AGG-ID: LrkcoSD-M62GCHOpoMO5WA_1763586990
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-787f38dba90so2772747b3.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763586990; x=1764191790; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZU0cYpUKibMgIkOkyBk+sZaW4964Va6Pih1JUDjQCw=;
 b=t4zlRwOO1Dv68jVK0gVoY6DHdwsKDNJASXMl4fsGCxChxhwXRLs0vrOcKYYIXUZNUN
 AYxrHctaLqvMtj47r1XViCygHMcLHPzXTLPhsQ8nZ3Xj5zf5G58D8Px1lPN5I5qThllz
 YA28Q2coePXFL/kxa9dHXdZVZ3+8sYugK5S/6HrjGAa5nxRmQo/ZfezoBBwb9Dzo2Lgk
 65Rr+sqS0twEwhGb9CyBdDdmFjO44/75+lFLzh0g9BHYbIS06alwdfrbz6kZjT9RcXOw
 iPLKk8n7Ooyz34fxb68fpip/GwUoGL8WCT0uMGL9yBRg5UAAz6i3zWml+fQ7z/0GsnOM
 kSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763586990; x=1764191790;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8ZU0cYpUKibMgIkOkyBk+sZaW4964Va6Pih1JUDjQCw=;
 b=jPWkY85agYJLKXOWpCfYlcZU3Q3otx6jVtMfiqIlBFVYzjKvEfltdghHAdYMrInNVf
 M0Zv/zTwdtWV8O/XckMMtmrMRyv77enr++zKW073lcFdf5Cb9EtckYmtFoEW88vqCRT2
 UkLiGoMGhmvHv05GQaMMWZXDtuqx1sIIoAW2//7iPvcLLbGOOSn6el6EQEIBAPNrDEOo
 4UHd/ymwH1mUUGaRmLWX2rmdGHh0YSfMfdPno7TPg4Tyg1kw8aUjHTRzHNj5IAhaEpuw
 5/0QwYBflx5M4b5kdxXpPpu3Mgeo3STP9R2IqtfH8N3zU2m34JuttaDujMJ92sQGClRf
 WarQ==
X-Gm-Message-State: AOJu0YzSyRDULfUDg0D+qBW6BtNkT43AgZrIth2etwtsRopQlzSrez2C
 2Hdigeh3b+8/zZPOeQ31Bl+OSq5MShYwjgtqN9RVUGyBP0K0vZ5QBlE0HyLoHLehJMSFUZKvZrm
 En4xxKJcL/brnBBJ5KWfuZLfdnrt/ZYxrzCRfZJAnP9HucyUQpHD8smgU/O4Soad8QRL7JZE/ke
 cAl89LVqc4sK1Zoy9P4dX0AjMPjhoewnY=
X-Gm-Gg: ASbGncv+Kqk3VcCkDY+7zWm+tL/cwJuK9qAHuO22TY/DdnszCDkA3jnJfuc8qAAlTEb
 /C+cafOB0/MagzXNZgJXNjFF9BBYNGYVe6Maj3IkVNwcKE7NpESPutooS6coGTwe1K2vlxC9Clw
 q6/WnJGGKZiRErfIrm5kjvsaVWhDT6sbWvmS3jr4oqth1WNPiI6LkcAAIL+W7wrVGYwL/adgf8u
 RLcsOezuDQq8KQyaDhoqU1u4w==
X-Received: by 2002:a05:690c:a085:10b0:785:fe77:ccce with SMTP id
 00721157ae682-78a7960d8bfmr6932747b3.44.1763586990536; 
 Wed, 19 Nov 2025 13:16:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+NNfKfJbdrxxohxkBhXOdFsqMehqXdZd3svmoB6EKreEyh8aC3/XuB+4y8xy0E0JVRlKD62I2TCa/kCX+ciY=
X-Received: by 2002:a05:690c:a085:10b0:785:fe77:ccce with SMTP id
 00721157ae682-78a7960d8bfmr6932587b3.44.1763586990280; Wed, 19 Nov 2025
 13:16:30 -0800 (PST)
MIME-Version: 1.0
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-12-jsnow@redhat.com>
 <5858b3a2-f92a-4dcd-b401-585250821032@redhat.com>
In-Reply-To: <5858b3a2-f92a-4dcd-b401-585250821032@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Nov 2025 16:16:19 -0500
X-Gm-Features: AWmQ_bmf6zM3MqwCD61kzQ2EtI3hKM22wKN7oSTIywG18KGN6YEbPvSCPCWxQws
Message-ID: <CAFn=p-auf2T7NFizFhaaoW4uxr2Z3v4XdgUAj1SVYFv8Mg3Kfg@mail.gmail.com>
Subject: Re: [PATCH 11/22] python: add vendored qemu.qmp package
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 19, 2025 at 4:29=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 17/11/2025 19.51, John Snow wrote:
> > In anticipation of deleting the python/qemu/qmp source from the tree,
> > add a vendored version of the qemu.qmp package to ensure that "make
> > check" can be run in isolated build environments, offline.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >   python/scripts/vendor.py                      |   2 ++
> >   python/wheels/qemu_qmp-0.0.5-py3-none-any.whl | Bin 0 -> 72263 bytes
> >   2 files changed, 2 insertions(+)
> >   create mode 100644 python/wheels/qemu_qmp-0.0.5-py3-none-any.whl
> >
> > diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
> > index 33ac7a45de0..36cd27046e7 100755
> > --- a/python/scripts/vendor.py
> > +++ b/python/scripts/vendor.py
> > @@ -43,6 +43,8 @@ def main() -> int:
> >       packages =3D {
> >           "meson=3D=3D1.9.0":
> >           "45e51ddc41e37d961582d06e78c48e0f9039011587f3495c4d6b0781dad9=
2357",
> > +        "qemu.qmp=3D=3D0.0.5":
> > +        "e05782d6df5844b34e0d2f7c68693525da074deef7b641c1401dda6e4e3d6=
303",
> >       }
>
> I wonder why I did not have to add pycotap here when I added a wheel for
> that...?

It's only a script we run manually - it doesn't break anything to skip
over it. It just helps to have a script available that can do the
vendoring for you and verify the checksums. Ease of convenience for
future maintainers, etc.

>
> Anyway, for your patch, FWIW:
> Acked-by: Thomas Huth <thuth@redhat.com>
>


