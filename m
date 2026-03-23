Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CCDEC01CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dX9-00011J-JM; Mon, 23 Mar 2026 07:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1w4dX5-00010j-Qq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:33:19 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <josemartins90@gmail.com>)
 id 1w4dX2-0008Bz-7A
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:33:18 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-79860421382so32970167b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774265594; cv=none;
 d=google.com; s=arc-20240605;
 b=Yam3RieSHldmqItdUp2NUMOhp3krRoq5KxHrCL/4ZO/OURoOOR14pu2YFpTZtTUkce
 j7EPpNg5PziE3QOWmeBmjOLV+uLlC+MOe3bRtm2pxlmQo7TGjEBh9y5tFIzsXbxCE2Oe
 zD/YU9blzBR3SStL9rJaBNZ+Sezb/CEJ7DUU8UOw0p1ADweJAHzwk8tFZOrJCho1WzM3
 myzu/tgPxwiYqq4sW1SdsipEku3deUMYZMiFrG/HstIHWovUwuNHmrhrtGgu2RzAwP5b
 MBFninvLeGfZAco2i7cf/7HZFvFsF6eRkf3ngADcCGFiRYYh71skeAzUpijZKTLmqk2c
 fgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FhM62Tt4VB7nZIE5qlF0vGKxBb8fB58ACt30oAn51J0=;
 fh=mcrN8lquO3LNOg8aTI08L1CauaITl5lMGTZ0gWUbNLo=;
 b=GB2rc4d427XdmI8X4QE0bEB6I4tJWPMplS4QvGBeIvEiNuxOmyOxjXtSV483vcKe36
 Zp0kZlT064ra2/Wm24VATVYtqTs3TZdLbttG6ARJUHtKlIzSX/0dAyWaYUagUn+Ax4qr
 I8tMosg4m33MmEgI4YLhF59TmIjSVLinm+zpWv4TngD5HU925FBrGzbo+QkCxs0DKQmT
 DLxAoiTsdLHwM+MH6YEcD4pLWDDws+MeZjBLRXtBRq1mrOpTNdCV5QxULHI9FL2Nq+cP
 YxpdJSJ2hbzNPSF9uVQLLg6X3btExU+4RLzp0NrHUrIaMheCGH247ISC5H/8O5kN9p/t
 4LHA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774265594; x=1774870394; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FhM62Tt4VB7nZIE5qlF0vGKxBb8fB58ACt30oAn51J0=;
 b=UIozqCDFKfXQbmXNo/x0cwrmI7Q0m+Di0EOYsrxx5h1W8jjeQvdzzHE0PlfjYtdgfq
 ElKClrxRsiN2bJDivNjkCk6adNE67WApP+zNGIZR8QnqXinc6FSsj/+hQRZGSrgnOTf3
 jhYKoilnXOxUaFncfWakSoLhSBKkoQ++/PXC/my2hgj2mPkdwjQvqUdRVN6PvnXf5tug
 X6VXcPTPTgzbG3kjY82hP0e8XnuN6A/srqI6xRtryHLEiAesUWR1dwNT8itYCxaGSNGr
 c06JsQopKaQ4NUyEKNkL//OEoJG1tfH6kogZlDXCyFJFktJ5tFoXR40XIw085lW9ope7
 kgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774265594; x=1774870394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhM62Tt4VB7nZIE5qlF0vGKxBb8fB58ACt30oAn51J0=;
 b=rDYV+ZeF4LDvV+dVVjEC8spVSdqpnjsCSJrEA0u5w7Zho8EyKj1CLdr7v+F915OZ5m
 daqJCxA7M0bik0swesi/bp5pisT6N+hA75ku7YEbJXuAz106iPk5xk2zk250n3LzQEsh
 tMJw5aSspsA1RTnwvhMXhsfl1biWhJRZtrJhFLiibSS3jd7CGDyOKxDD5dVMV3wJ78A/
 lhTBJ7lQIfmqkcxqdEQEaD3fHItrt8Zhxk3B+Cse/CLUbSdwlC//39wwEHGTbLX9aJIk
 Yr3xCee3kHLff1pmH94OCgAYt8jO4TwEsQMzS9sknnRpU8hbNPKiGhhmeb7yty5qY5no
 JRZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYsHTlufdnN/UuJCF//zSvh1NbfML39EIbUt+AIMrrIoOehqUByHB3Wh05x26UwC+wI94dy12ThTh@nongnu.org
X-Gm-Message-State: AOJu0YzthesHZqE8aKuQuOY6gqxvF17YzEDwDxk4QZMGNJ6dGplOvqe9
 IWmEBVaArLDrffFTnEQexEOIgeD0EeTktZ0MDKGqhy+ANkFETVrJsPUT8hK7pZxYYjOJC9DjwZR
 hadh0fwAnIloxZmGFYju99pMHzhsSfig=
X-Gm-Gg: ATEYQzzzaH++s4eop3WyfKr+h3fwr10Qmo1NR2MPy4whvKRZvV8YMV0QXA13gf/bveg
 6pHzSVaOqMMAk2bC0L2TyeEvQVU1suK4rIqTkEZkk+IFIHgnanKmVrmfPhR0BgIEuO1Na+IlAhw
 dqGsp4/xi24lY9IWhGNwIZe3EK19JgKucdnEhnq5u99zS35J4zv5lWadlvD/rsfWzKw3KEsoPcZ
 g99XAxNHt8Da4ixH9ABN5AA7tCfJGctyR7aiknR8aDZW8qmg1bZKj6LFE6jXXP97ibc7z6zdRq5
 1ESMP9b4ZB3nRKydoOE=
X-Received: by 2002:a05:690c:6e83:b0:79a:7cff:7b81 with SMTP id
 00721157ae682-79a90b0de31mr122129717b3.27.1774265589657; Mon, 23 Mar 2026
 04:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260321231916.2852653-1-josemartins90@gmail.com>
 <CAFEAcA8N4kMYW1zNmSpiMPXG-MUjh2awiZbZuFtOnqzRW+ir=w@mail.gmail.com>
In-Reply-To: <CAFEAcA8N4kMYW1zNmSpiMPXG-MUjh2awiZbZuFtOnqzRW+ir=w@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Mon, 23 Mar 2026 11:32:58 +0000
X-Gm-Features: AaiRm527RYpJdtz7zSltK3zpo_1iyvXFpQonttQfXX6d5LjRDX4pAf3qLiLwxKs
Message-ID: <CAC41xo14hePcRU_=FMug5tCfJjygo052EZc88MzBEukfcMxUyA@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/arm: fix s2prot not set for two-stage PMSA
 translations
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=josemartins90@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> Hmm? That commit doesn't add the s2prot field or touch the
> get_phys_addr_twostage() function. I guess you mean
> a811c5dafb7 ("target/arm: Implement get_S2prot_indirect") ?

Yes, sorry about the confusion.

> The code change looks correct:

Perfect. Any other actions points on my side?

Also, to clarify, to reproduce the issue, the bao-tests repository
branch to be used is at [2].

[2] https://github.com/bao-project/bao-demos/tree/feat/mps3-an536

Thanks

