Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF10D16271
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 13:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0LXU-0000aX-TD; Mon, 14 Oct 2024 09:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0LXS-0000Yo-Uw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:55:10 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0LXR-0005xG-4g
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 09:55:10 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso6467387a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 06:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728914107; x=1729518907; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIh1tvXJS8eOG3Xl0S3ukK+nnDMSKc+no7JJrKlUCGQ=;
 b=CB19mX0ddDB/R+ZPJAaidAry+j0DPIOlDTqIYebaUsn6hXPq7CmKA2cQHWLFaQwAF2
 gl4gHg+RFoS/nJjs2G+MUWZbDns3ipZFXQmY3RQyIKPJpBlCClKJXWcFVrUTm1F76kh2
 UkMGFBVOFStxKfvIvTAQUDvuExTxGrr5dwhWa8OJ8GM9T7N/4RQncNapyda2980OBe+2
 LRlYx4dXpSfpXj771QmDzky/BcItQ+9xTqq8b65Xum9sTWZyVO1xWqW03S+Y48XYE7lH
 jROInDUXl4ltfNzkDFr6MtenrRdn0nJ0FtPligFZ1riQOtzG3Hu9OyPBMce3wuO9QbOW
 kvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728914107; x=1729518907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mIh1tvXJS8eOG3Xl0S3ukK+nnDMSKc+no7JJrKlUCGQ=;
 b=tIZI5mW/3dh3B/eqlx54jros4H/AWWE3Hr7nsUnKZFh8Owf4E9hlBHUEUQulwVckRC
 iIGnOpZ4l5eEuRw25iosfV1HctWtjI2iIKHNP6NU6MkljrLPLBLVHWfuECbpHsrj2PTT
 SWGPCffsno/4boHA/dewqssOBe+HZCoyzdAe2NFLJzZqbA/+88JtJ1OzR7IIBwctQQEM
 iYxNaIg+Y1arIaVej6jvhUiaVnw79qwqukAinf4KFt1nLs180e41a8/VZUwpWZhOf3si
 uEHjusn7/r9kZWhxVmfYWsm1lYLjEKHPNODN/BlGVyPO4+3RQRNMw+BkvzyVRTM2nJo/
 u3PQ==
X-Gm-Message-State: AOJu0YzHD6tuD4JM3h7HE50K+fd9MzSiefeq0DW3HRcXlP7n37s6yKAP
 vbYYG++UdWRVa00PbgtGs095d95ek7Cq1KEXPMSfreXaV52+fTImPo/DyhkjcEMlS66S7PMQJkx
 sgjI0j2Pj/D6gKGykxeNJ9OMIDcc7BOKerIY0pub4RBOFG6M5
X-Google-Smtp-Source: AGHT+IEar5XS48qlERsTQgD21+98rhTv8j5E3NooTZuctZf16kKzgXPfQ3eWLSK96tb4DDYIMPB2gpA+eH/sojRSzB4=
X-Received: by 2002:a05:6402:5188:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5c959e6f56amr7109237a12.6.1728914107522; Mon, 14 Oct 2024
 06:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241014110113.173946-1-pbonzini@redhat.com>
 <CAFEAcA-8wdDV4fziAj5FqfR2isjdAvLxXZHvqN0=GewDNS9iLA@mail.gmail.com>
 <CAFEAcA_vUxNXRNnWtDd1DeWmC8dDT64VwvB8yswnjp5QzyOt0w@mail.gmail.com>
In-Reply-To: <CAFEAcA_vUxNXRNnWtDd1DeWmC8dDT64VwvB8yswnjp5QzyOt0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 14:54:55 +0100
Message-ID: <CAFEAcA8h-ahm2_dO3b+KV+MdqtN4N6E0-C9jKS7B0n8L+3jS+A@mail.gmail.com>
Subject: Re: [PATCH] configure, meson: synchronize defaults for configure and
 Meson Rust options
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 14 Oct 2024 at 13:09, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> On Mon, 14 Oct 2024 at 12:45, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> >
> > On Mon, 14 Oct 2024 at 12:01, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> > >
> > > If the defaults for --enable-rust ($rust in configure) and Meson's ru=
st
> > > option are out of sync, incremental builds will pick Meson's default.
> > >
> > > This happens because, on an incremental build, configure does not run
> > > Meson, Make does instead.  Meson then gets the command line options
> > > from either coredata.dat (which has everything cached in Python's pic=
kle
> > > format) or cmd_line.txt (slow path when Meson version is upgraded), b=
ut
> > > neither knows about the rust option, and the meson_options.txt defaul=
t
> > > is used.
> > >
> > > This will cause have_rust to be true if rustc is available; and the b=
uild
> > > to fail because configure did not put a RUST_TARGET_TRIPLE in config-=
host.mak.
> > >
> > > When in the Rust pull request I changed the $rust default from auto
> > > to disabled, I should have made the same change to meson_options.txt;
> > > do it now.
> > >
> > > Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >
> > This fixes the issue I was seeing with my local
> > incremental rebuild.
> >
> > Tested-by: Peter Maydell <peter.maydell@linaro.org>
>
> ...but this change broke 'make vm-build-openbsd', because
> meson-buildoptions.py fell over with an error from the JSON
> decoder:
>
> make: Entering directory '/home/peter.maydell/qemu-openbsd/build'
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/meson introspect
> --buildoptions /home/peter.maydell/qemu-openbsd/meson.build |
> /home/peter.maydell/qemu-openbsd/build/pyvenv/bin/python3 -B \
>   scripts/meson-buildoptions.py >
> /home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh.tmp &&
> mv /home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh.tmp
> /home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh
> Trying to enter hw/core which has already been visited --> Skipping
> Unable to evaluate subdir([]) in AstInterpreter --> Skipping
> Traceback (most recent call last):
>   File "/home/peter.maydell/qemu-openbsd/build/scripts/meson-buildoptions=
.py",
> line 245, in <module>
>     options =3D load_options(json.load(sys.stdin))
>   File "/usr/lib/python3.10/json/__init__.py", line 293, in load
>     return loads(fp.read(),
>   File "/usr/lib/python3.10/json/__init__.py", line 346, in loads
>     return _default_decoder.decode(s)
>   File "/usr/lib/python3.10/json/decoder.py", line 337, in decode
>     obj, end =3D self.raw_decode(s, idx=3D_w(s, 0).end())
>   File "/usr/lib/python3.10/json/decoder.py", line 355, in raw_decode
>     raise JSONDecodeError("Expecting value", s, err.value) from None
> json.decoder.JSONDecodeError: Expecting value: line 2 column 1 (char 1)
> make: *** No rule to make target
> '/home/peter.maydell/qemu-openbsd/scripts/meson-buildoptions.sh',
> needed by 'config-host.mak'.  Stop.
> make: Leaving directory '/home/peter.maydell/qemu-openbsd/build'

Trying to debug this I tried running 'meson introspect --buildoptions'
by hand on that machine, which falls over like this:

~/qemu-openbsd/build$ ./pyvenv/bin/meson introspect --buildoptions
../meson.build
Trying to enter hw/core which has already been visited --> Skipping
Unable to evaluate subdir([]) in AstInterpreter --> Skipping

../rust/qemu-api-macros/meson.build:1:0: ERROR: Unknown compiler(s): [['rus=
tc']]
The following exception(s) were encountered:
Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc=
'"

-- PMM

