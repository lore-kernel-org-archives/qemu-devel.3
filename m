Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FF0C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgKL-0008Ct-1s; Thu, 29 Feb 2024 08:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfgKJ-0008Bo-RW
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:55 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfgK4-0003pG-FE
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:55 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51326436876so647928e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 05:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709212778; x=1709817578; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iflQDWhiv1xsdwyJ2pi12LrMSTkj11MoqFlUX9IDEPg=;
 b=T9WYKIPvskfOOYKNVUSLQhO6slju2BOwTL/wcgcwSheVgapG/HFSndwqgxlF80f2lv
 BvbYwaGdE1KemVDgzGYszc7I4hm1E3shkgcxHSzEhbHawb4c6V6qd2IaWaNKtmhxiGdV
 2ywy+ZGGOKbuqysl8lxEdFkF3ku3fuXMAyMLdu+e1CzSrpnZidQXmfMzvezppPAC/Hb3
 qsWHZq1d6ZAZvwYzmwvVDPi4oh6DI7Q1TlSOyW6GHVaIOd4xm7cYzYS3MiWAQueZvA6W
 N19JmWLMwY1y67Oj4eWO4vZtsKQqW1hwmyqg/lsPxp6t+jbgUJQjr5tauZPK5627rcFn
 u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709212778; x=1709817578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iflQDWhiv1xsdwyJ2pi12LrMSTkj11MoqFlUX9IDEPg=;
 b=cobglRdEhd31jemQ0Akjcy9noSBtFQ982j88is6jM+1qplw1WLXhE2KWK4WepwOEZb
 es5tBedwTz7Nbe9iQJH90nO6a5nmu9eCT2nhVGXbXKbo73UQ2iXkPZZgZ1beXG8CVFDQ
 9MPMG66GMi/PcxriABHpdKXXKjSfmFkmSzHbwLFBKTu6FjfcweyVVgivKMYDWByLr9ZO
 vpi/F0Gl7qQSXymzr4bR/32WQccuP0N6r/jl2ir3HX5dReZXzNWL7UnAIjZzMlwBB205
 I0xv13tLJiP3XQLwKkFi3BWp89dbT28OQvB+h/+O3/Z/Dsm44Ax5KK3uX9FXWVYxNdkm
 xGzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCB/7T00p/y8qj2u+ySuuYC/jU2xXxmw0vD0fc80OpL4PpyvqvzbXCY49Zt0p3enbEvVzFykM3O/b4tWpqWFT0Ty3P1R0=
X-Gm-Message-State: AOJu0Yy14l6od2eVzCDkPjUUnVpYiANsojxYWTk4NGq/20U6WNrkZcnT
 LWrF2duKvS8kP4ULh5xcIIoNojiHl/UjZsBSkwk/cXSg6c5Bk5naPNIOzFMcqM0lhSOa0/ZKxPU
 PQdqE/iiKQOLsCDAM1o+rkfEpVoy6MHyU83qZnw==
X-Google-Smtp-Source: AGHT+IG9Q8cPMjr8Ytv7Le6sWjwjKsi/vAQe9a9G6ufk3al9CIhdVEe9fi31vaqjGCFWNY4OxGHVxACHIIILcLW8kwE=
X-Received: by 2002:a05:6512:21c7:b0:513:2c59:c6d5 with SMTP id
 d7-20020a05651221c700b005132c59c6d5mr69368lft.5.1709212778444; Thu, 29 Feb
 2024 05:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
 <bf3e44c8-a6ad-48b6-8825-ba8ce0dd19f8@canonical.com>
 <CAFEAcA85nwJ-qfzFVYBY0kiD7mEtr5UHRD_X_s=Vv7eaoHD_bA@mail.gmail.com>
 <CAGNS4TbE8dyUv0OkwwY=g2=qea_mxj07=0W4macVRXsBMicgCA@mail.gmail.com>
In-Reply-To: <CAGNS4TbE8dyUv0OkwwY=g2=qea_mxj07=0W4macVRXsBMicgCA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 13:19:27 +0000
Message-ID: <CAFEAcA9BJamzk4xpmJx-CGqXd+T5g0WvySU8T8r1cAA0zC7tEQ@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 29 Feb 2024 at 12:52, Mattias Nissler <mnissler@rivosinc.com> wrote=
:
>
> On Thu, Feb 29, 2024 at 1:35=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Thu, 29 Feb 2024 at 11:17, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > > > But yes, I'm not surprised that CXL runs into this. Heinrich,
> > > > are you doing CXL testing, or is this some other workload?
> > >
> > > I am running the UEFI Self-Certification Tests (SCT) on EDK 2 using:
> > >
> > > qemu-system-riscv64 \
> > >        -M virt,acpi=3Doff -accel tcg -m 4096 \
> > >        -serial mon:stdio \
> > >        -device virtio-gpu-pci \
> > >        -device qemu-xhci \
> > >        -device usb-kbd \
> > >        -drive
> > > if=3Dpflash,format=3Draw,unit=3D0,file=3DRISCV_VIRT_CODE.fd,readonly=
=3Don \
> > >        -drive if=3Dpflash,format=3Draw,unit=3D1,file=3DRISCV_VIRT_VAR=
S.fd \
> > >        -drive file=3Dsct.img,format=3Draw,if=3Dvirtio \
> > >        -device virtio-net-device,netdev=3Dnet0 \
> > >        -netdev user,id=3Dnet0
> > >
> > > This does not invoke any CXL related stuff.
> >
> > Hmm, that doesn't seem like it ought to be running into this.
> > What underlying memory region is the guest trying to do
> > the virtio queue access to?
>
> FWIW, I have seen multiple bounce buffer usage with the generic net TX
> path as well as the XHCI controller, so it might be either of these.
> Bounce buffering should only take place when the memory region can't
> be accessed directly though - I don't see why that's the case for the
> given command line.

Yeah, exactly -- the only thing I can see there where a reasonable
guest program ought to be trying to do DMA to/from non-host-RAM
would be if (a) it's reading data from directly out of the pflash image
and (b) the flash device has got itself into programming mode
somehow. But that doesn't happen for the other architectures that
have pflash for boot firmware as far as I know. The bounce buffering
stuff does need to be fixed but it's also worth looking at why we're
hitting the code path at all here, because even if it works the
performance is terrible (doubly so if you try to execute code out of
that MR).

-- PMM

