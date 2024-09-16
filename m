Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C8C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 12:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqB3C-0008ON-PT; Mon, 16 Sep 2024 08:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqB31-0008Lp-IZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:41:46 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sqB2t-00033M-0q
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 08:41:43 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1b35030aeso2436413eaf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726490478; x=1727095278;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3TKxBmAcsMaPXKdgzgK0xmVGDJFZ69y2foOWxQ36TU=;
 b=DcTRJO1uCTFfkpOr4n/Xrx/SacaEsqqIIzdQ1NgtazH7K8GcxcDopcPaSBIcoVHD89
 caNuwHM9hcbTfV9b1xgKhRq0ohZ5sX2+oI29ATjxNIz14Q+RWLVLnEicUmP7yXGqsAr4
 Qi2UKTSw0IgTXu0MIQ0VylpHP5DQTg7qJPKZyFWTFGnngDEFuzaNVm+rKjJwuQYAGqUD
 kaAJseUCfU21DRjRVdCzU1yHh5hqaJ5RXrUiMROY9ZAAdUJyRaiAUbFQuvWRSkAZ01eO
 nPdvvGyMQdyDLo+YfLKancJcxZf58qNDNmZH+61VqFH9szYGMEo3knU7LgwkGv5O+5xL
 tZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726490478; x=1727095278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3TKxBmAcsMaPXKdgzgK0xmVGDJFZ69y2foOWxQ36TU=;
 b=NHgODLqvk/egIV+cJ0gvrbSYv0z8Epi9XGhMUfnn5e6kPsAUh16MyRXJKCJIZIJ6B5
 Hs0hOCoDEASndnbVEwprS1UmbV0O9+qe+6Nv6w7ZWoNCptffQDsT2CKX9CF8wnonVe/9
 eXFl4aGgyYsN3xUgANDmDh1uzofpMxxcKyRAdumkc7uANBlfaXtDL07vNrMGGgUUND7Z
 aAcocpiR4LTg+0n8O/cjpIL3yIJbE0WdhuglLzUYwz6RFw+kF4l6KTAIksUk88jp6yoV
 Bz284W+9mM5lk2IJCE0Zxr94nwXg/S8tuwQ9LxcC2xn3j9z4fiJkTTtVd2q0e2f9NQgp
 4O7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYFNnfVplMVSbeIe26KAJ8Np3+/t6bTY2JpApF+0sMV5rAh+cnLTk7X/6MHoAj0bzxcg6WXoolP1Ga@nongnu.org
X-Gm-Message-State: AOJu0Ywa2QGbG6m8PA1fmhNncvQ+R0oxc4Ome0Y95l2kV7Z6eYur02te
 jPCaPwMXOxYPyTlSLOg/ji2tQEdDw+/HiJM7iZm/he9DC4UldJRNH0FhTUJeCfd0KME/V+C6ATb
 WGfi8Hid88t7nmSr0ZTSOi5uHEYJCYNMJp2D5yg==
X-Google-Smtp-Source: AGHT+IEvdy5ieoANzoWNpMiRnuySEgRTMSSwGyKyOmf8HmTlTmUzVM7Xdov80S3D0y8CvVEnisE2efxv6CYDCNtNvvU=
X-Received: by 2002:a05:6820:162c:b0:5e1:ecda:a521 with SMTP id
 006d021491bc7-5e201487158mr6950037eaf.8.1726490478085; Mon, 16 Sep 2024
 05:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240909201147.3761639-1-peterx@redhat.com>
 <20240909201147.3761639-2-peterx@redhat.com>
 <441f797f-a377-45de-bfe6-042542c917d8@kaod.org> <ZuRQirmjwWGj1N2D@x1n>
 <CAGNS4TaDVs9eqb9jO5kgi9bL1t1tmc-GywiyP3xpbgFGgvbkLg@mail.gmail.com>
 <881df54b-c98c-4ce0-a434-05d055cc27bb@kaod.org>
 <c488c507-ae5f-4a95-bbb8-c92799f25630@kaod.org>
In-Reply-To: <c488c507-ae5f-4a95-bbb8-c92799f25630@kaod.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 16 Sep 2024 14:41:07 +0200
Message-ID: <CAGNS4TZew-JwCatS6JpUq29JOPidYwXkB110X7qabjG0Mc6A5g@mail.gmail.com>
Subject: Re: [PULL 1/9] softmmu: Support concurrent bounce buffers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Thanks C=C3=A9dric, I can reproduce now, and my proposed patch fixes avoids
the crash as expected.

On Mon, Sep 16, 2024 at 2:28=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Mattias,
>
>
> > C=C3=A9dric, can you try with the above patch and/or
> >
> > crash seems gone.
> >
> >> share more details of your setup so I can verify
> >
> > You will need a Linnux powerpc or powerpc64 image for mac machines,
> > which are not common now days, or MacOS images. My debian images
> > are big. I will try to build you a small one for more tests.
>
> Grab :
>
>    https://cdimage.debian.org/cdimage/ports/10.0/powerpc/iso-cd/debian-10=
.0-powerpc-NETINST-1.iso
>
> and run :
>
>    qemu-system-ppc -M mac99 -cpu g4 -cdrom debian-10.0.0-powerpc-NETINST-=
1.iso -nographic -boot d
>
> Thanks,
>
> C.
>
>

