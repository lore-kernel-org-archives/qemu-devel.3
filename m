Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3234DCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrM5a-0000ij-MS; Mon, 01 Apr 2024 14:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrM5Z-0000iW-FX
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:08:57 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ilg@livius.net>) id 1rrM5X-00083a-5x
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:08:57 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a44f2d894b7so489605666b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=livius-net.20230601.gappssmtp.com; s=20230601; t=1711994933; x=1712599733;
 darn=nongnu.org; 
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dVj3GNVBx68aIvQ+tyRkpLNGKSXxcXA5snINpERUkGs=;
 b=SlZUz6C5VEyoCDFRBN59uh6OU+6PGaRlDVkOvsu3KhWsv6zMJvehipjwKJiLxr+QOv
 y9tgUMHzfIUqW0wojsYSdGszMHKN6ISFU3K60HN2nXptSQpzHupMhEzULb8x38LXMplO
 bCYR8TBssYgzBmLsLADSRESWxNjYMdCFEDo9l4Of6RYlUZUdtAAScZc26zeadd6Y/U70
 VEvvNFFJgWWQRns2VZTptRUiX4qkFvAeDF/80qrpEx7aQzXM4NHC1vF/Qk0svoCi40ck
 evay20NaCtwDl7BDIFTIQZLjEEUw1giNs2V+WDELI9c7kSnqvoydI3IvaCR4nPgyftVE
 AZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711994933; x=1712599733;
 h=message-id:in-reply-to:to:references:date:subject:mime-version
 :content-transfer-encoding:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVj3GNVBx68aIvQ+tyRkpLNGKSXxcXA5snINpERUkGs=;
 b=iF2Bgrwsh+GkF6YecHwpL+sX5lr4anjmrYlvcYbMRrIZ+1vEO97fQSbFbSOpfZl2dd
 gRvZ8gPcySUv+HiP+TIesyW9QRn96r89OIas+uU89ZzwRurBAEwivzjlYAWmlcAihuDe
 oNZw4MKX0bb2D0BO2YY4iOW7PxzXPuMr+1obqZEf5NQcFFFGSNkfoEZmoKS8WUCNU2mr
 IzFdAsdoIJ7NVEfwo4sTEdo0kTjF+V88nWgq4V+bNUG2VGwGe9yt3+08q0mWQU7zEind
 8uIvwPrzDtEAdmjd38azbNMNCsBS88gkVdC51uAFINQeNgJe4ox3NqSSkeFAi4WCQEYq
 92UA==
X-Gm-Message-State: AOJu0YwM0EhL6ji4PUQL8AeVcTsnd5IvuiG6AC/jJxj17N8TsynaMCm/
 SmAguRRC0lXJcVjiCefteFbUi6HS4n9SG4tXs9G+xWAzyGGIaTLhwu4/QqBZqTdKmdsCGrfa550
 Z
X-Google-Smtp-Source: AGHT+IE6JZs8OXVYqT8467zU7J8s3KBE9cRNSTnm+82dZeLIZJe2xIl5dk702hDvUSxr7Fn8kGZhTg==
X-Received: by 2002:a17:906:3e4b:b0:a4e:474c:428e with SMTP id
 t11-20020a1709063e4b00b00a4e474c428emr4819765eji.64.1711994932661; 
 Mon, 01 Apr 2024 11:08:52 -0700 (PDT)
Received: from smtpclient.apple ([5.12.109.62])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm5512923ejb.61.2024.04.01.11.08.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Apr 2024 11:08:52 -0700 (PDT)
From: Liviu Ionescu <ilg@livius.net>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
Date: Mon, 1 Apr 2024 21:08:41 +0300
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
To: QEMU Developers <qemu-devel@nongnu.org>
In-Reply-To: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
Message-Id: <A2BE1ACE-3764-454F-99B4-53FCA9127F0B@livius.net>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: none client-ip=2a00:1450:4864:20::62d;
 envelope-from=ilg@livius.net; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

same behaviour for 8.2.2; same workaround.

> On 2 Sep 2023, at 21:11, Liviu Ionescu <ilg@livius.net> wrote:
>=20
> When trying to build 8.1.0 on an Ubuntu 18.04 aarch64, I get the above =
error.
>=20
> The offending code in `/util/cpuinfo-aarch64.c` is:
>=20
> ```c
> #ifdef CONFIG_LINUX
>    unsigned long hwcap =3D qemu_getauxval(AT_HWCAP);
>    info |=3D (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
>    info |=3D (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
>    info |=3D (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
> #endif
> ```
>=20
> The reason is that on this distribution the <bits/hwcap.h> header file =
does not define HWCAP_USCAT:
>=20
> ```
> root@9c7ad90af4f8:/# cat /usr/include/aarch64-linux-gnu/bits/hwcap.h
> /* Defines for bits in AT_HWCAP.  AArch64 Linux version.
>   Copyright (C) 2016-2018 Free Software Foundation, Inc.
>   This file is part of the GNU C Library.
>=20
>   The GNU C Library is free software; you can redistribute it and/or
>   modify it under the terms of the GNU Lesser General Public
>   License as published by the Free Software Foundation; either
>   version 2.1 of the License, or (at your option) any later version.
>=20
>   The GNU C Library is distributed in the hope that it will be useful,
>   but WITHOUT ANY WARRANTY; without even the implied warranty of
>   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   Lesser General Public License for more details.
>=20
>   You should have received a copy of the GNU Lesser General Public
>   License along with the GNU C Library; if not, see
>   <http://www.gnu.org/licenses/>.  */
>=20
> #if !defined (_SYS_AUXV_H)
> # error "Never include <bits/hwcap.h> directly; use <sys/auxv.h> =
instead."
> #endif
>=20
> /* The following must match the kernel's <asm/hwcap.h>.  */
> #define HWCAP_FP (1 << 0)
> #define HWCAP_ASIMD (1 << 1)
> #define HWCAP_EVTSTRM (1 << 2)
> #define HWCAP_AES (1 << 3)
> #define HWCAP_PMULL (1 << 4)
> #define HWCAP_SHA1 (1 << 5)
> #define HWCAP_SHA2 (1 << 6)
> #define HWCAP_CRC32 (1 << 7)
> #define HWCAP_ATOMICS (1 << 8)
> #define HWCAP_FPHP (1 << 9)
> #define HWCAP_ASIMDHP (1 << 10)
> #define HWCAP_CPUID (1 << 11)
> #define HWCAP_ASIMDRDM (1 << 12)
> #define HWCAP_JSCVT (1 << 13)
> #define HWCAP_FCMA (1 << 14)
> #define HWCAP_LRCPC (1 << 15)
> #define HWCAP_DCPOP (1 << 16)
> #define HWCAP_SHA3 (1 << 17)
> #define HWCAP_SM3 (1 << 18)
> #define HWCAP_SM4 (1 << 19)
> #define HWCAP_ASIMDDP (1 << 20)
> #define HWCAP_SHA512 (1 << 21)
> #define HWCAP_SVE (1 << 22)
> root@9c7ad90af4f8:/#=20
> ```
>=20
> The full list of definitions should include:
>=20
> ```
> #define HWCAP_ASIMDFHM (1 << 23)
> #define HWCAP_DIT (1 << 24)
> #define HWCAP_USCAT (1 << 25)
> #define HWCAP_ILRCPC (1 << 26)
> #define HWCAP_FLAGM (1 << 27)
> #define HWCAP_SSBS (1 << 28)
> ```
>=20
> I don't know the meaning behind these bits, and how important is for =
QEMU to correctly identify them all.
>=20
> Since I know my build environment, my quick and dirty workaround was =
to pass the definition via the preprocessor options:
>=20
> ```
> CPPFLAGS+=3D" -DHWCAP_USCAT=3D(1<<25)"
> ```
>=20
> However, for QEMU this is not a solution.
>=20
> A possible solution would be to compile the code conditionally:
>=20
> ```
> #ifdef CONFIG_LINUX
>    unsigned long hwcap =3D qemu_getauxval(AT_HWCAP);
>    info |=3D (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
> #ifdef HWCAP_USCAT
>    info |=3D (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
> #endif
>    info |=3D (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
> #endif
> ```
>=20
> I don't know if other distributions are also affected, my build =
platform for all xPack standalone binaries is Ubuntu 18.04 LTS.
>=20
> I know that 18.04 is an old version, but I use the xPack QEMU mainly =
to run unit tests, and in some enterprise environments the machines used =
for testing are sometimes pretty outdated, thus 18.04 will remain the =
base build platform for a while.
>=20
> It would be very nice if QEMU would still compile on Ubuntu 18.04, as =
it did before 8.1.0.
>=20
>=20
>=20
> Regards,
>=20
> Liviu
>=20


