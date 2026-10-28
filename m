Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3741606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZPJ5XP80;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UJ1khERj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM59i-0002of-Qv; Wed, 28 Oct 2026 11:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xM59h-0002oO-IG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xM59f-0007TV-Nj
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793199689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgvID3reoobkONmEHMyi5UPD3QLe0tC4nZUn6CqZjsc=;
 b=ZPJ5XP80wFVyV61ieMAAEvXciTMNYVxda1GvgohgvvhctCfxbt5P7ACr5hNOXvAulbGAL8
 cKdZGLJDey+LDKoK1ZmS0azItUhx1IkHCfh20UV2QV8MiAYtUI0kv6ZS1BM7JTROdHIEEt
 b8sbVT53OeLn1Af4FzvHCD56cZOmtoY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-UW_nF8aLO3mAq9v8CDp9-A-1; Wed, 28 Oct 2026 11:01:26 -0400
X-MC-Unique: UW_nF8aLO3mAq9v8CDp9-A-1
X-Mimecast-MFC-AGG-ID: UW_nF8aLO3mAq9v8CDp9-A_1793199686
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-6768601940bso4096522d50.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:01:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793199686; cv=none;
 d=google.com; s=arc-20260327;
 b=hOyorcENs4NrIylfee3oyjhvnHAShPPJxXPIwebGZNvvJwla3hBqPjnwWV0+bweYhT
 SrU1P7s61XL8jDDSf2TUItx4iFhcPJ8n4tQJY35hOj+8+FnHGkyPTbHt7jJw/TP9H9lY
 11WFvgUwD1DVdvMKTEFCFTAaXBstdQAdOtQhe7Z9O8DBpGUepMO9A1GgahKaOqRWNtEa
 rFu5/bMBc6clnGoNjISCLcJiwDh3I58Xj3FN+BHbkAFl1tnYXHcYQwQxs5nJE3L9sA34
 vWIHHSNTSkOvZULjcgBCGxlZdYVIPZlQGzd1vyG6RLXCfBKgGxRHsvBBP1N4LFfzS2rT
 JT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bgvID3reoobkONmEHMyi5UPD3QLe0tC4nZUn6CqZjsc=;
 fh=0UN3jtqc32PbdO/Tc9WDC3GmPLzwDVSFpbcVwu9URBU=;
 b=PiBeK6hecvPal0KuL1UFfbVE42DXUPlJRDOoznqd4kWhMIiVUQVsaADEtHwzwo0d5d
 qzWF+Y77llSXoXls8N9+B0S85Gu9de69a4FQzZngm68OatnFL4DmcexX5Ryx5qVRFyaP
 oeqhRX1k8whUO53iRcG1hTVCm+radfkqL72oFjw88USyQ0hMw+yQHr2Vvp/w0whh1PRL
 titdmzQLI9wSeohQ994tjtXLs0zeVMPrnubcETM0ItS1QYPtpGTR8tkKhAWNmgos6wsU
 UgQdwdp7CMlKZOqTZ+/xLq1RUXAeAH+nPJ/pStIuQlDAb298piJPNNG/gVX8wLQR26lU
 4tWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793199686; x=1793804486; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bgvID3reoobkONmEHMyi5UPD3QLe0tC4nZUn6CqZjsc=;
 b=UJ1khERj+TOrixEtVyQBCFKQuN7Y59ChYM4mjYUk0i87Yuqypyb68ZBzbNWM2dmbhj
 VigW8mGGX+uenPKLc7j+D//5U5BPq0wdwfx7+ScFACF295OlKN4AStwj882amsuLmlkw
 giKJ3b9WjMKzE1/HHcJM5AZ/jpw5fqtP4LMa5454Q4FHFHEo5hna0J5PDAZKjZT3YZoF
 R9JvRaGe7hun9Rj6B76psdCCQ362cO0VElzbp4V1aRMZnEktJ2KT93FC3QPD4t86byOm
 X/4h61fNBr3DDSBHxrUjkkZaKZ+LmoZlqw4RsIX2x2LJlFCcbuSIXk078vVBJ5KuXDaL
 Pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199686; x=1793804486;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bgvID3reoobkONmEHMyi5UPD3QLe0tC4nZUn6CqZjsc=;
 b=sZTqvFhCXFmThTDtxeNYHxStyGih0WjKUNcLCIMcpGbWPSLro5zH0qXuQOw5S/jsT5
 gC198t9oY8vuABZv6fgdzbWpHVn7CUe00wcWWJQHVlOZ5gR7UVyJZ7NLAhN/XKEFZDiI
 Mcm2r97oaJG4V6gxM00J/jzIf46xMTD44FtffQx0znB25eP7yy7RfzjzcFdYRVO1k6Nd
 w7TZXHndhBLx4+GY6QllDFu8Y+GQxdYnFRCaLQVXHFIgnDWdo6Kf6ktec/beLQTAXtKY
 GxLkpScUSGu/TLP18Y+pvkc4oCVAjJ4qI9KUD2U6pkwQMmLc8slKu6OQ5JbMdz88JFP3
 zb8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU+03PPLIpuCE5S3pS6ohMn2+h9Z1D2IxHt3o9gz84QgsyGQK+XpK12AS/fK21ciqFQK2DgwbhAcSO@nongnu.org
X-Gm-Message-State: AFq9FYLCOsI+t0UFWSk9ohbX00BgQdjlmlb8tmPBuLM4W9pA4LPYm5ql
 31mbfotkfvW+YYjCComlucQmqI05ZL2zGXrSY0zTEV9WHJE6pjanSXJlB8KsuC8C/fpxX3EUXqY
 OJmPdE2zsm8MUW51IRHHcNxIWIYLIxSPD7B+aJyuoauvecLC0tyXQv/ZNaNRF8b70iSOmNBtL5e
 by+JxSlCLmiN1RBrtQB7vt6r8zeVBBlt8=
X-Gm-Gg: AYBFou1LlKvj0Y12tF5Rx9Or/mhVq7BnTtXD9yWy+YDviONo+ObkZjuewiuJNgXH7Gl
 Tv1TztVvNrxW5KrDPHS3BsnJFOfUwFSJN2a0RLPW+YNaES49AUBc2SJ65fMzVfE99yJ6yEJxlWB
 ynNleSvk8wpNcm5Fnkc3DlDFliRkFqCx9/u3giBYURjcRjvB27b7BBhSCDFFDCKtQlCc7jq8WCX
 N2oSz6syWJGRPDH
X-Received: by 2002:a05:690e:1446:b0:677:df02:fce with SMTP id
 956f58d0204a3-67a813f7010mr1316027d50.5.1793199685853; 
 Wed, 28 Oct 2026 08:01:25 -0700 (PDT)
X-Received: by 2002:a05:690e:1446:b0:677:df02:fce with SMTP id
 956f58d0204a3-67a813f7010mr1315980d50.5.1793199685115; Wed, 28 Oct 2026
 08:01:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
 <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
 <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
 <CAFn=p-ZkTd5iv9UZCondYbBe6Y3Gudcv8oE-95Ttnh2O8dujEQ@mail.gmail.com>
 <419c14e6-cf06-4502-bad8-903d6896d4f6@oss.qualcomm.com>
 <e341734d-a96a-40a4-a54c-c0539c27c4e6@oss.qualcomm.com>
In-Reply-To: <e341734d-a96a-40a4-a54c-c0539c27c4e6@oss.qualcomm.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 28 Oct 2026 11:01:13 -0400
X-Gm-Features: AclHuK-kHgOhY64BYPqOeGXIHoZMCgIwB80Y0ySzSx_nxgZMPcDPOf6ChheE-CQ
Message-ID: <CAFn=p-atDbXxoiAYxXTN1tC-xixzS6t0N2m2kFqAwOgR8pbhCg@mail.gmail.com>
Subject: Re: Issue with PyPI when working offline
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 1:17=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 2026-10-23 14:55, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > On 2026-07-29 18:01, John Snow wrote:
> >> On Wed, Jul 29, 2026 at 9:30=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> >> <philmd@oss.qualcomm.com> wrote:
> >>>
> >>> Hi Paolo,
> >>>
> >>> On 13/5/26 15:36, Paolo Bonzini wrote:
> >>>> On 5/13/26 15:04, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> Hi,
> >>>>>
> >>>>> This is the second time I'm working offline and do a simple
> >>>>> rebase, which triggers a re-configure, and then I'm stuck because
> >>>>> PyPI tries to access the Internet and do not allow me to neither
> >>>>> build nor test:
> >>>>
> >>>> Does it work if you configure with --disable-download?
> >>>
> >>> I got this issue again today:
> >>>
> >>> $ ../configure --disable-docs --enable-plugins
> >>> --target-list=3Daarch64-softmmu --enable-tcg --enable-kvm
> >>> python determined to be '/usr/bin/python3'
> >>> python version: Python 3.14.4
> >>> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> >>> mkvenv: checking for meson>=3D1.5.0
> >>> mkvenv: checking for pycotap>=3D1.1.0
> >>> mkvenv: installing meson=3D=3D1.11.1, pycotap=3D=3D1.3.1
> >>> mkvenv: checking for qemu.qmp>=3D0.0.5
> >>> mkvenv: checking for setuptools>=3D44.1.1
> >>> mkvenv: checking for wheel>=3D0.34.2
> >>> mkvenv: checking for pip>=3D20.3.4
> >>> mkvenv: installing qemu.qmp=3D=3D0.0.6
> >>> WARNING: Retrying (Retry(total=3D4, connect=3DNone, read=3DNone,
> >>> redirect=3DNone, status=3DNone)) after connection broken by
> >>> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443)=
: Read
> >>> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> >>> WARNING: Retrying (Retry(total=3D3, connect=3DNone, read=3DNone,
> >>> redirect=3DNone, status=3DNone)) after connection broken by
> >>> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443)=
: Read
> >>> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> >>> WARNING: Retrying (Retry(total=3D2, connect=3DNone, read=3DNone,
> >>> redirect=3DNone, status=3DNone)) after connection broken by
> >>> 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443)=
: Read
> >>> timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> >>>
> >>> Indeed using --disable-download fixed it.
> > As of today's b6c4b7e86dec:
> >
> > $ ../configure
> > python determined to be '/usr/bin/python3'
> > python version: Python 3.14.4
> > mkvenv: Creating non-isolated virtual environment at 'pyvenv'
> > mkvenv: checking for meson>=3D1.6.0
> > mkvenv: checking for pycotap>=3D1.1.0
> > mkvenv: installing meson=3D=3D1.12.0, pycotap=3D=3D1.3.1
> > mkvenv: checking for qemu.qmp>=3D0.0.5
> > mkvenv: checking for setuptools>=3D63.1.0
> > mkvenv: checking for wheel>=3D0.41.2
> > mkvenv: checking for pip>=3D23.2.1
> > mkvenv: installing qemu.qmp=3D=3D0.0.6
> > WARNING: Retrying (Retry(total=3D4, connect=3DNone, read=3DNone,
> > redirect=3DNone, status=3DNone)) after connection broken by
> > 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): =
Read
> > timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> > WARNING: Retrying (Retry(total=3D3, connect=3DNone, read=3DNone,
> > redirect=3DNone, status=3DNone)) after connection broken by
> > 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): =
Read
> > timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> > WARNING: Retrying (Retry(total=3D2, connect=3DNone, read=3DNone,
> > redirect=3DNone, status=3DNone)) after connection broken by
> > 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): =
Read
> > timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> > WARNING: Retrying (Retry(total=3D1, connect=3DNone, read=3DNone,
> > redirect=3DNone, status=3DNone)) after connection broken by
> > 'ReadTimeoutError("HTTPSConnectionPool(host=3D'pypi.org', port=3D443): =
Read
> > timed out. (read timeout=3D15)")': /simple/qemu-qmp/
> > ^CERROR: Operation cancelled by user
>
> This happens when I rebase on mainstream 'master'; something
> triggers a refresh while likely not necessary.
>
> Obviously this is in an offline environment so not easy to debug there.
>
> >
> > $ ../configure --disable-download
> >
> > ERROR: missing subprojects
> >
> > --disable-download specified but subprojects were not
> > checked out.  Please invoke "meson subprojects download"
> > before configuring QEMU, or remove --disable-download
> > from the command line.
> >
> > $ pyvenv/bin/meson subprojects down
> > load
> > ERROR: Directory . does not seem to be a Meson source directory.
> >
> > $
>

Phil, can you try with DEBUG=3D1 V=3D1 in your configure line so I can see
where exactly mkvenv is choking?


