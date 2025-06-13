Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B62C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 05:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPwrp-0006OP-LX; Fri, 13 Jun 2025 01:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uPwrd-0006Nq-7e
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 01:22:08 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uPwra-0002B2-N8
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 01:22:04 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b2fb8226e1cso2780585a12.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 22:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749792120; x=1750396920;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OIJdJB/To0+EFq3p/Bf04hNgiEcBJvYkfqKaLcJcG/g=;
 b=GVEEmxaPyrIlJvhMDpXeGBHDB3k4DniVDEpArIH8vvaFpAJZ4jdtKcaVJwxmbNEmGJ
 EM/XBjB5GuNjnetPkKxkthvwr48qm8YNJeH/UZesHF2pWsAr7RYNH/ZqKF02dT4ar0Ov
 rLKoVz/feh0XNWxFU8qp/YrfAVeBho4s4bA3SM49wfSGyPVljnvD3gPE9kDx0XUbprGM
 OAXKQcfozDWG00D9WlaS08Jf7ayVzNBWlwlmBhkmxZ9DPjDFTSg4Hy1UW4q/YWAqEJbu
 RdzxbnXgm+54Lcn5D/F/YEwHSK6mllV/rD1KhGAG9+4m7M1oTEONmBniC8PDMXBrDN4f
 OcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749792120; x=1750396920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OIJdJB/To0+EFq3p/Bf04hNgiEcBJvYkfqKaLcJcG/g=;
 b=qLCFvjjbeSRLsNnSuykBc9tKrTsrv6fG7WvnDKapPJjXcfNbD4rg56UVV1nLysU+s7
 Rr9QUUy5rNrilJgyerNic2+P2zFURNdGUM2pBhZV3X1WDQIRNite+EcuiiH3rA1VifzK
 mco6TquhFVIjTAGIyPCJhA3nnDkE6HCFEYpP6pMYnFEe6RNSYiihRFKoS53FK3oEnTkb
 zZXo8cPKLeU76715CrARVlLfLbY6F8BXB4zcdOJZoBgBVerYk31nm1Y6jbm1WgIk78EV
 so8/yhiyFKGLPgYNpFj8njhnl+P+fKVj61TGq7IMFh9qBCKLYQU3nDHJ/f8Q1pp6Qsno
 wNnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcn71R4Mqz9PjRwC3ndu10zQ7UKOLG5FRzzvBpbiELdCNkabLLIXwKZzcJc38RYZiYBd4UxFDHFMuP@nongnu.org
X-Gm-Message-State: AOJu0Yw0SANOR6XSXzvwblcXF/Cp5E9gpt4z5oZwPGMkZGt3t7dTq1Zl
 +bKCOsZioMfDaWHWv2D5h+45o8bxiYcTcE0vKwip9Lo8aufNlZFzKQ8+5jf8vNrTzHo=
X-Gm-Gg: ASbGnct1sk/J4OIdy8QWs3h+8CtjVrnqaHBBvfzT8BH4pkeTntuKfDeNqwk3svcdtpb
 HJyz9sFrOPCgSBPQof6NrqcL69THfCew1JaUYsttfQca23WwKacGCfHvwU7hlTTnYShqlFXPpgO
 OGN2M4eppG7IBz5HV8+ZN8BySuw+z9n2RJElGMgRleL3UuJG3Y0vLOYT6lVTFyyEYdDK17rMx4v
 kG1uH+T8c2ThsHBiYgoq0wDG5sqOODYHZS4Gq6rPSMhjwpkhRiwkCNXPa1yODHkW5Mdy+nELRRu
 E7cBCx0RoE5kvLusMl5iXvofjw8OZmp+c+iNZDQkqvlmOCGeq7d36KSkOvK3vLd5zfWN8KxE
X-Google-Smtp-Source: AGHT+IFOhijwB82xKKqulYtyBwSKw69AkZhtAaCt8mJ0I2yFQCiqdSEMPOmINWezzK1jonChaMrwJA==
X-Received: by 2002:a17:90b:3c8e:b0:312:dbcd:b93d with SMTP id
 98e67ed59e1d1-313dc2ba637mr1936290a91.14.1749792120479; 
 Thu, 12 Jun 2025 22:22:00 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-313c1c5fd7esm2447761a91.37.2025.06.12.22.21.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 22:22:00 -0700 (PDT)
Message-ID: <392b4ec1-b347-4b0a-8863-8480e52b20aa@daynix.com>
Date: Fri, 13 Jun 2025 14:21:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build platform guarantees, docs, tests, and snakes in the garden
To: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
References: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFn=p-YuqzXvWF-cGLUc0LVVMe2Rinx9+LOjvpHRY-vRrPyJow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
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

On 2025/06/06 4:35, John Snow wrote:
> Hi, I've long been a little confused about the specifics of our build 
> platform guarantee and how it applies to documentation and testing.
> 
> My *current* understanding is that our build platform guarantee applies 
> to both unit tests and building documentation, but that this requirement 
> may not be as absolute as I imagine it.
> 
> The way I have endeavored to manage the Python tooling in our tree so 
> far is to preserve, without fail, our ability to perform fully offline 
> builds on all supported platforms (provided that the right distro repo 
> packages are available). The Python virtual environment created at 
> configure time bends over backwards to use system packages *whenever 
> possible*, and the list of exceptions - notably Meson itself - uses 
> vendored packages only in very specific cases where it is possible to 
> vendor such packages. Fetching packages from PyPI is generally offered 
> only as a convenience for developer workstations to, in general, save 
> developers from having to know anything about Python. (I think I've done 
> a good job there, to be honest!)

It is a nice work indeed. I spent substantial time to work on QEMU but 
the Sphinx problem mentioned later was the only problem I encountered.

> 
> (Notably: Meson is pure python and has no dependencies, so it is 
> possible to vendor it for offline builds. Tools like Sphinx, however, 
> have many dependencies and are not so easily vendored. Thus, we have 
> created a tenuous arrangement where we are allowed to use versions of 
> Meson that otherwise would break our build platform guarantee.)
> 
> Lately, we've had some issues with the wide range of Sphinx versions we 
> support presenting various cross-platform difficulties. In particular, 
> Akihiko Odaki has sent patches to bump our Sphinx version to at least 
> 6.2.1, because platforms with Python 3.13.1 can no longer run Sphinx 3.x 
> at all, so having that be our "default install version" causes issues on 
> newer platforms.
> 
> However, if we take as iron-clad our commitment to the build platform 
> promise -- *and* guarantee offline/tarball builds as well -- then Debian 
> 12 (as an example) only offers Sphinx 5.3.0 and not newer unless we 
> allow internet access to fetch Sphinx 6.2.1. This is not a problem for 
> developer workstations at all, but I am unclear on what problems this 
> may cause for tarball releases and downstream offline/isolated/ 
> reproducible builds, if any.
> 
> In this case, we can (probably) "fix" the issue by continuing to allow 
> older Sphinx while preferring a newer Sphinx version when it is missing, 
> but then we lose the ability to make code cleanups and drop a lot of 
> back-compat crud. If memory serves, there were other issues recently 
> where older versions of Sphinx behaved differently from newer versions, 
> causing intermittent failures that were hard to track down.
> 
> What I'd like to know is: what precisely are our options in this 
> scenario? Do we consider it acceptable for some platforms to be unable 
> to build docs offline? How highly do we value the ability to locally 
> build docs for any given release?
> 
> Before I throw my weight behind any given option, I just want to know 
> what we consider our non-negotiable obligations to be.
> 
> Thanks,
> --js
> 

Thank you for detailed explanation. I see a few possible options in this 
situation.

Pretending as a lawyer interpreting docs/about/build-platforms.rst as a 
law, I think it is allowed to require the Internet access. It says:

 > For the purposes of identifying supported software versions available
 > on Linux, the project will look at CentOS, Debian, Fedora, openSUSE,
 > RHEL, SLES and Ubuntu LTS. Other distros will be assumed to ship
 > similar software versions.
 >
 > For FreeBSD and OpenBSD, decisions will be made based on the contents
 > of the respective ports repository, while NetBSD will use the pkgsrc
 > repository.
 >
 > For macOS, `Homebrew`_ will be used, although `MacPorts`_ is expected
 > to carry similar versions.
 >
 > Some build dependencies may follow less conservative rules:

 > Python build dependencies
 >   Some of QEMU's build dependencies are written in Python.  Usually
 >   these are only packaged by distributions for the default Python
 >   runtime.
 >   If QEMU bumps its minimum Python version and a non-default runtime
 >   is required, it may be necessary to fetch python modules from the
 >   Python Package Index (PyPI) via ``pip``, in order to build QEMU.

So it is allowed to require a non-default runtime that is available on 
PyPI but not on Debian.

But it is also allowed to bundle a python module or to keep its version 
requirement low to help users just as we do for Meson, of course.

Another possible option is to provide a mechanism to download the 
required Python packages; users need the Internet to to prepare the 
build platform (e.g., Debian) and QEMU source code anyway, so it makes 
sense to require downloading the Python packages at the same time for 
the future offline usage.

"pip download" is probably for such a use case, and we can make sure 
that nobody get hurt by the Sphinx change or other Python dependency 
changes by wiring up it into python/scripts/mkvenv.py.

In summary, there are the following viable options:
(1) Don't bump the Sphinx version.
(2) Require the Internet access when running ./configure --enable-docs.
(3) Bundle Sphinx.
(4) Let users "pip download".

Skipping into the conclusion, I'm for (2). The other options have their 
own disadvantages:

(1) may cause intermittent failures with old Sphinx versions, which is 
too bad.
(3) is just difficult, according on your description.
(4) is nice, but requires more time and I don't think it's worthwhile to 
take the risk of old Sphinx versions until it is implemented.

In contrast, it seems (2) has the minimum risk and acceptable level of 
annoyance. The documentation is for humans, and any human using QEMU 
should have one computer with the Internet access at least. Perhaps some 
users will be forced to change the build flag to stop building the 
documentation on an offline computer and to prepare a build environment 
on an online computer, but it's acceptable I guess.

Regards,
Akihiko Odaki

