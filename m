Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5406CCE8E7F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 14:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3yiC-0008Vj-DG; Thu, 24 Oct 2024 10:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3yiB-0008VS-6S
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:21:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t3yi8-0006OY-8N
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 10:21:14 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso1827700a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729779670; x=1730384470; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01LNpV0J5i2+mW4L0tTjXQrlSr+AmryCspQKyFFkmyk=;
 b=ELDZlrdw+rf57/jperjqVFo44D0P0yDZqgfWpzTySqNgu/qsAx/6kvNha2hqqJ+dg0
 5crcbpQpMryD1IerwGuH9aoBjs2q9oyg/fg1uxag0jmU1Gyj860FTQ7S3VDm0YTvi7Lf
 uahcuYwZm7VZeIvt/Ogy/cs20JfYAMLuRZhR/PGmVXICDZle9fj5ZCdtkL9ETxrULDuW
 QSEEIcF5Oi6BbUJXdNeUwKx3jIX0L4yaZCHE3uVLNG95VdFrF+Xxk8kHhQNiYOAEgddt
 2y8iKY8ZGVLewDIyRpcwd+NDw8lBzkNP5Etq9mrGQwt2oGIebgLpJ5MhknkjsAu1Nml2
 NZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729779670; x=1730384470;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=01LNpV0J5i2+mW4L0tTjXQrlSr+AmryCspQKyFFkmyk=;
 b=U49UNvOsOwPkfgXSXxXZWD+qsjj0vmHTgvFht28pq51XVVQiu+t4PniZnx5cmTgB92
 zsONMwGYC+utSKH9WVVHGBSy9GO7/41gIwlbW5jcPwx3y3ueAP9+kHiHaIwxB14ct2zx
 fNbOgoqyvoxBJhFvnPVcdPdm73HmL/LGP7I5cGbxqQ2lH8jOLlKb7qzrrtlq9LYMPaVC
 0/aZUDmMd04y1u2B9FfnkqeVvuYyknJHuPswZ8MjC2SLMKYM8onXFix2JYHwKsmrjrnH
 7LNqqOTqMwnZf0mX4T0LRk+lflo0ipqKsIvY+6bKWS7u4qAJ8RYs8blvRQYb4n61p4+l
 /Vxg==
X-Gm-Message-State: AOJu0Yx4pD6nqgkv8hf4/mnRjKfiJXNP9gtwBjoa+WeUzGynR/pViNjq
 b/rUsS4QxAqS2oa4mQhuE/VY4vJidxKeFxynJOESXL7u0qnjm7shG4kqCKPg2bkgSj8GIvR6Beb
 rn7MoXyJppkIURIKrZk5fxnNTIdBpuI8ZcYfbSw==
X-Google-Smtp-Source: AGHT+IGHhq6Qvof2pqDPVtU75qSOjwxphckJbPYbk9jVwNcKPCIbH+nSHpef7liMF0YUjq6SBIn/l/gDbYlxwu/npgk=
X-Received: by 2002:a05:6402:2344:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5cb8ac5e8ebmr6287169a12.6.1729779670156; Thu, 24 Oct 2024
 07:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20241022152415.1632556-1-berrange@redhat.com>
In-Reply-To: <20241022152415.1632556-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2024 15:20:58 +0100
Message-ID: <CAFEAcA-nWDcFrLy21cme6+T1H_9oaHtYE3MtT8D5ucr+o2kn9A@mail.gmail.com>
Subject: Re: [PULL 00/14] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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

On Tue, 22 Oct 2024 at 16:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit cc5adbbd50d81555b8eb73602ec16fde40b55b=
e4:
>
>   Merge tag 'pull-tpm-2024-10-18-1' of https://github.com/stefanberger/qe=
mu-tpm into staging (2024-10-18 15:45:02 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to c64df333f92798823c4897ae6d4bd7f49d060225:
>
>   gitlab: enable afalg tests in fedora system test (2024-10-22 13:02:33 +=
0100)
>
> ----------------------------------------------------------------
> Misc sockets, crypto and VNC fixes
>
> * Fix rare EADDRINUSE failures on OpenBSD platforms seen
>   with migration
> * Fix & test overwriting of hash output buffer
> * Close connection instead of returning empty SASL mechlist to
>   VNC clients
> * Fix handling of SASL SSF on VNC server UNIX sockets
> * Fix handling of NULL SASL server data in VNC server
> * Validate trailing NUL padding byte from SASL client
> * Fix & test AF_ALG crypto backend build
> * Remove unused code in sockets and crypto subsystems
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

