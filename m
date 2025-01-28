Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD534C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 10:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcjAy-0001kv-C8; Tue, 28 Jan 2025 05:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcjAx-0001kc-5v
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:50:35 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcjAo-0004yO-NC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 05:50:27 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso8131641276.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 02:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738061425; x=1738666225; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3v34krr+R/W/GJLfn6JaO0A1nQiepmfIj00rt+nc7XI=;
 b=e0ub/p/HtKt9vAt6VRySDThmwxmSDBrxgn4r8fcG3+1EsSdndpeZqEdJEX6acge+xd
 fop3Z9LWzUo7/KumboUk+rKmYopKV4b2/dbJwwqPvlHKUXAcxqtMGfpVh+Pn1ZRfMtKQ
 4HVhM8Uof5X8Q1r3stOnyqRxZYk5aaW8yiCYbRG1N1kAwpBljHDs4w/LxwclUxNGN6S3
 yibm14LvspW+twv9Zmg0Aeb1hexvfqmEffGGsORWiHPBTb5G0Y3itWVooXi6u7Uzk97q
 xHhQ+iTbh/IENzqBrLaWDbmwrGV6XHfa88w1hQzBWfswCMJO3objMVhac1Jz3G7fBloA
 blTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738061425; x=1738666225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3v34krr+R/W/GJLfn6JaO0A1nQiepmfIj00rt+nc7XI=;
 b=llFT2zxeGWrvENNTJwnEd+bMta4fxvOc736cfGC06XcJv0PnWPBHVwaYskj/sERBWZ
 u3OrKwUOcKgQ+JrsKQKGYBWRZwWf+8ley1hu1l9xiqScO1zLrsVYIT+f3zlwHs2VjfcL
 VDMk/EexPay3/n0uS0yh4IdKG3J+r2x+NQpJ/iVdAYiFhCdW0sCfv3QPRv5LnsR0JnKe
 VPllgmgEdtWligqHMU3LBe/oRQh0Gs8Qq5Z7n2H6QDpLMGSIyrWbkEsnQ9tpyAx6YjKI
 ohUau9bWzbvUGuyFgzSdAJfq6sLInn7rexMsjqLrvKBUsv1xBCwtctbhISQXsNnc1u6j
 Sb+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKhf510gtObmLbYZZRQs11NyHOv7dMbcWIWyneomVmhzBttWktYlGN2IXD7uiBZ7lti2SJR8puoLo9@nongnu.org
X-Gm-Message-State: AOJu0YwbClmJTcIKBjKTuTSFSm5/1G/ScJHpsYs1wFzPqKrxgdKZhAlC
 UPQBIbSFbds/KLwqtkbbNbCu7OI37FE/F0gSbL0pJ4Fr5PrnKIoZymav2TD6MNqQ+X+MsngX8rR
 J++QWyni9SSX/7rrNugPZ3jCgp5hsdr8r2uiibg==
X-Gm-Gg: ASbGnctuGC0ffHGEpGCQDq3nrqbRzOcEoJDXWoUwFpfBVI6lKuea4gL0KDZYTlJO41Y
 tvfAR/aYrryrKkvxfHn4uN00aOrdS3kOtT2n46eIy/+h1wG3ELc/IgTeiI+GCaXVgDWJeLCAuow
 ==
X-Google-Smtp-Source: AGHT+IGf0QlTdyAwJ7XFE9WBWDnIZoVSKqzGdakhyKNC/XpP9riGmVHzhlBgZYEGGXx14ZaPvjqXAQBpwZ1OiMaZNEw=
X-Received: by 2002:a05:6902:12c5:b0:e58:173e:abcf with SMTP id
 3f1490d57ef6-e58173ead2fmr17795541276.8.1738061425452; Tue, 28 Jan 2025
 02:50:25 -0800 (PST)
MIME-Version: 1.0
References: <20250125181343.59151-1-philmd@linaro.org>
 <wkb53fhvfchqa4uvmifgitvcr7t7rfpc3hcohdhzczkzvktetx@yjveswjel3s4>
In-Reply-To: <wkb53fhvfchqa4uvmifgitvcr7t7rfpc3hcohdhzczkzvktetx@yjveswjel3s4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jan 2025 10:50:14 +0000
X-Gm-Features: AWEUYZml6bfUrxGGjA2uylNFRM6bH2fiw1eM--KZHV8IsWc8hLbPBULX6GMnCq4
Message-ID: <CAFEAcA-QOYcnJi=joKHbRmUCXK1UFOgQRgYP-fDq4h_1SkMGyQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Yi Liu <yi.l.liu@intel.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu=2D=2DDrif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 28 Jan 2025 at 10:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Sat, Jan 25, 2025 at 07:13:34PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Some SysBus devices can optionally be dynamically plugged onto
> > the sysbus-platform-bus (then virtual guests are aware of
> > mmio mapping and IRQs via device tree / ACPI rules).
>
> Do we have some sane way to have user-pluggable sysbus devices on arm?

The answer in a general sense is "no, because user pluggable
sysbus is a weird idea". "sysbus" means "it's wired into a
specific bit of the memory map and to specific IRQs, and whoever
does that needs to know what IRQs and bits of memory are usable,
and the guest OS needs to know it's there". "user-pluggable" means
"it's all automatic and the guest can just do some kind of
probing for what is or isn't present". All the platform bus stuff
is a nasty mess that's working around the things people want
to plug in not being clean devices on probeable buses :-(
And the platform bus is only supported on the "virt" board,
because that's the only one where QEMU is generating its
own dtb or ACPI tables where it can tell the guest "hey,
there's some device here".

-- PMM

