Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33E4C48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 13:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc3oZ-0002Wk-LN; Mon, 19 Feb 2024 08:36:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc3oX-0002W6-Q1
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:36:09 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rc3oS-0000Zu-UN
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 08:36:09 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5648d92919dso943096a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 05:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708349763; x=1708954563; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wBS7p74C18vfgjZS21+4+584H1doL/iiQgs2ufqQxso=;
 b=YNnXMOtpzttv0KvdT4k8C/MwuU0ij+1ryDlNwtCFsuwrxiLCHZ9nlJZY5POJC3qXQn
 m+5Nz+LIX2Fcq4GyUtr7UtFWec3eSOi7V6alkYkoq8dbnHHIg2wccnbuwY0p0KH68THF
 FVF3a4UdYkwj4kqCK5ZF6PH1pvJz3wLSlIOFEdoFU3pKHd/bwSEdH4pG/cqqR5uNOovH
 IV7J/3NhwsN3J5AJfdgvXPGEB31wrhKqHJuOfSypW7qIqUv14KtR5R8HRJjxnB5rH22s
 +sd7M6M4QeMzxr78PBkPtfW5NUi15Y/2upSA5A/okFIG1hBBWj2M1Sse2DIOTQuLoI6C
 oIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708349763; x=1708954563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wBS7p74C18vfgjZS21+4+584H1doL/iiQgs2ufqQxso=;
 b=HDsmcCYnb25KS+N2yf327GLdr+hisR+P0vu/VgL0GgsaGh1uZ20yaVxMbQa9Gq+l/4
 N3dEcfRDBPC236HQjdN0hhSGuWPVdxHIPfKKQgA9vSci87Jv1rfbrSMXyJsIjnCgtvv+
 bvqG9YJsHDd+UwQK0uZ4kPm8uRrvSTSEkNw7vWRNNMLMYCuA4zL3sMapEhfgpyohMhGM
 Zx6F12UuIA9AXDTLDPJDhWwSX21fKPPO1xhU1yLS81avhSBrSJ7RR4o2D5iFakxqVv/V
 P48A6ft06UgYhHxis+4ADkPuDpCUVxNmIlAUQi/5/Xm2Y/3Qqs7z0DtfOKPG+FcYXna/
 LNLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOOOg3eKe/aPkRvam3ai/cdNq5UZt9wesTv2d19LN5ZQ/13FqopDEvdCTUGv5YEYLT7CwM9GzwcCQcCNjswJ4P/liRDEA=
X-Gm-Message-State: AOJu0Ywiss6iO6k9SR3Jl14lmYu5xJ83AuWQY36qT/Pz39UJPTHxCssk
 HlZv+wvrIF2NyAn8fHMwieyCJSgGhcfYaefg4QbAxm+ukt4X8KMEG03oPOIhgi+X6hhzFRhCV6+
 OeCD48svwKypH2C4EKYmhJzQCYPOpYfdgW5pJWQ==
X-Google-Smtp-Source: AGHT+IEA9qzeFyNa6St5iDH/5EmfmMHd+lQVjAjZAhCGm+7uhOR77otna5NOB/IVvHl9XHDVEEA5ToTdg+leMXF/sss=
X-Received: by 2002:aa7:d455:0:b0:564:2519:5a74 with SMTP id
 q21-20020aa7d455000000b0056425195a74mr3438061edr.11.1708349763342; Mon, 19
 Feb 2024 05:36:03 -0800 (PST)
MIME-Version: 1.0
References: <20240216153517.49422-1-philmd@linaro.org>
 <20240216153517.49422-2-philmd@linaro.org>
 <bcfd3f9d-04e3-79c9-c15f-c3c8d7669bdb@eik.bme.hu>
 <2f8ec2e2-c4c7-48c3-9c3d-3e20bc3d6b9b@linaro.org>
 <b40fd79f-4d41-4e04-90c1-6f4b2fde811d@linaro.org>
 <00e2b898-3c5f-d19c-fddc-e657306e071f@eik.bme.hu>
 <2b9ea923-c4f9-4ee4-8ed2-ba9f62c15579@linaro.org>
 <6b5758d6-f464-2461-f9dd-71d2e15b610a@eik.bme.hu>
 <bc5929e4-1782-4719-8231-fe04a9719c40@ilande.co.uk>
 <CAFEAcA-Mvd4NVY2yDgNEdjZ_YPrN93PDZRyfCi7JyCjmPs4gAQ@mail.gmail.com>
 <0a31f410-415d-474b-bcea-9cb18f41aeb2@ilande.co.uk>
In-Reply-To: <0a31f410-415d-474b-bcea-9cb18f41aeb2@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2024 13:35:51 +0000
Message-ID: <CAFEAcA9v4yh=K9+ND7R+KHC_0=fW39=fK7ScjE+HX-ip-KwQvw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hw/arm: Inline sysbus_create_simple(PL110 / PL111)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 19 Feb 2024 at 13:33, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 19/02/2024 13:05, Peter Maydell wrote:
>
> > On Mon, 19 Feb 2024 at 12:49, Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> On 19/02/2024 12:00, BALATON Zoltan wrote:
> >>> For new people trying to contribute to QEMU QDev is overwhelming so having some way
> >>> to need less of it to do simple things would help them to get started.
> >>
> >> It depends what how you define "simple": for QEMU developers most people search for
> >> similar examples in the codebase and copy/paste them. I'd much rather have a slightly
> >> longer, but consistent API for setting properties rather than coming up with many
> >> special case wrappers that need to be maintained just to keep the line count down for
> >> "simplicity".
> >>
> >> I think that Phil's approach here is the best one for now, particularly given that it
> >> allows us to take another step towards heterogeneous machines. As the work in this
> >> area matures it might be that we can consider other approaches, but that's not a
> >> decision that can be made right now and so shouldn't be a reason to block this change.
> >
> > Mmm. It's unfortunate that we're working with C, so we're a bit limited
> > in what tools we have to try to make a better and lower-boilerplate
> > interface for the "create, configure, realize and wire up devices" task.
> > (I think you could do much better in a higher level language...)
> > sysbus_create_simple() was handy at the time, but it doesn't work so
> > well for more complicated SoC-based boards. It's noticeable that
> > if you look at the code that uses it, it's almost entirely the older
> > and less maintained board models, especially those which don't actually
> > model an SoC and just have the board code create all the devices.
>
> Yeah I was thinking that you'd use the DSL (e.g. YAML templates or similar) to
> provide some of the boilerplating around common actions, rather than the C API
> itself. Even better, once everything has been moved to use a DSL then the C API
> shouldn't really matter so much as it is no longer directly exposed to the user.

That does feel like it's rather a long way away, though, so there
might be scope for improving our C APIs in the meantime. (Also,
doing the boilerplating with fragments of YAML or whatever means
that checking of eg typos and other syntax errors shifts from
compile time to runtime, which is a shame.)

-- PMM

