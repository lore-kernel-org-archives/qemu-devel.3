Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFFAC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 19:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZ6V-0003IK-Ck; Thu, 31 Jul 2025 15:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhXHC-0001yp-Fv
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:41:13 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhXH8-0002ty-4i
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 13:41:09 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e8e2a260926so1191275276.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 10:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753983663; x=1754588463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jLDTzs9wkSgE2Lf+TGCjTVwXOMrEGIgO9B22NpyXmhQ=;
 b=ue641nJHtt8RAM6VQD+VzohE/FBg1aJ6MJR0D1K5ShpmWXsV8JwjMmZ4Ob4Z9Ls1mC
 7mT6TAFk4y3WltKQcMoXMXZ2q0RKcp6t2gZKJDuK6Fh0ZjYYYS9oSbUue5grv3VdfcHO
 IbBqpp3uw01iSFMVWPdkRPbndhENuRikQc26Yg0hMC9LEZss/t9zb10Lkp+BLYKADweY
 Av+LHVX2gq/5yjYbhnVkIM+5Y/r6QSHBmVSzZ698k8etCKvY1zz1gL9TUO6c9uvKAP8I
 ntb5tPPhuOBbJnvi840KdOPnfQR0Zmx8tdrUu1QojCrCAhGkz9UFtupSWTaY1l7Kb0Bh
 2VTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753983663; x=1754588463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jLDTzs9wkSgE2Lf+TGCjTVwXOMrEGIgO9B22NpyXmhQ=;
 b=KsFXMHje41xZxbYfxT6+rBrQrqYXzxesjyp50U5vJX1HQaa5L+VUAhrffXD+BfvCST
 9yO90gqZvBH7Toc8jHfE04zmQv1nRwsG27wyBD5QnszhzsJS5xVUCcQF6/OXZTzdTQ9o
 Fp1wSaatYsNsC1p8buOFBW2Sbz2Cykq6GHAahRa9BqNkFc9VGI7+BcjEDhHDl7xdUX1U
 MjEL05/DhIbDSvIHzbjyv5hpe6XoA2kqcUT/ORVcKkdMCDqbqCBWBIWYEZuZwsfpKC4c
 ha+FBY0uKdPMsFEE/3HfIYzH0LRF0pB6FkhN7QUnMt6SJLAPmj3WOB/3J+26BycIlySQ
 dbXQ==
X-Gm-Message-State: AOJu0Ywo5EMdMFBtTzgQ/zSn6s3xonKub2Gab/do1zQz9KKh7YPJGV/F
 xhSh1S6fBN/riLdcvBgSrKbvRfI40kSSW1vR1TNzcrkJm20b5PAhFuXThRlxksxwl1OmlbmR11d
 2U/IjHZaUX/IPOLAfDN9R1UoUwLQE11x/GOgUYBrJz33DoH4JC2PN
X-Gm-Gg: ASbGncsQK0oEbDhCA8F5WaTonXF38T9jkabVcsRP4YptQuBdw5S59COJnBk21f6R8+G
 Z30Cg/8iD8cLCu4PauM2IcKmz9sY6kGw2KdWW8thyUTV6SYKlpFFifSVyS7SYyuXNMim8txchmC
 KsOTzekhjLj6orgZldFQ4rHPOHFYDPY339f1Kduz/8D56QLiHVOhNGUU04Hdxa1+IeLP4KLCxi+
 NkJLA4u
X-Google-Smtp-Source: AGHT+IGRyCNPW/oRDoMyT39srEbrRPilnP0iniU20zpog7wbgezEd7O016gA9ebOy4w+yv2b0AuClfA4lrt1+F5Z+Pc=
X-Received: by 2002:a05:690c:6c85:b0:71a:413d:5668 with SMTP id
 00721157ae682-71a4656c4e6mr101717487b3.11.1753983662944; Thu, 31 Jul 2025
 10:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250721153341.2910800-1-peter.maydell@linaro.org>
In-Reply-To: <20250721153341.2910800-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jul 2025 18:40:51 +0100
X-Gm-Features: Ac12FXyf84gdX23YmUohEl5gRUIAwLeAzJEGc9UebybUEF2Ijwj5Jrz7W4_VZ2o
Message-ID: <CAFEAcA884WUW7u6Ng65hj_cSe++9S+_nok6w2NphzhUuZH3DaQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/make-release: Go back to cloning all the EDK2
 submodules
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Tokarev <mjt@tls.msk.ru>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

Ping for code review on this one? Mike Roth: especially input from
from you on this would be good since you're the one who runs
the make-release script...

thanks
-- PMM

On Mon, 21 Jul 2025 at 16:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit bd0da3a3d4f we changed make-release so that instead of
> cloning every git submodule of EDK2 we only cloned a fixed list.
> The original motivation for this was that one of the submodules:
>  * was from a non-github repo
>  * that repo had a "SSL certificate expired" failure
>  * wasn't actually needed for the set of EDK2 binaries we build
> and at the time we were trying to build the EDK2 binaries in one of
> our CI jobs.
>
> Unfortunately this change meant that we were exposed to bugs where
> EDK2 adds a new submodule and the sources we ship in the release
> tarball won't build any more.  In particular, in EDK2 commit
> c6bb7d54beb05 the MipiSysTLib submodule was added, causing failure of
> the ROM build in our tarball starting from QEMU release 8.2.0:
>
> /tmp/qemu-10.0.0/roms/edk2/MdePkg/MdePkg.dec(32): error 000E: File/directory not found in workspace
>         Library/MipiSysTLib/mipisyst/library/include is not found in packages path:
>         /tmp/qemu-10.0.0/roms/.
>         /tmp/qemu-10.0.0/roms/edk2
>
> (Building from a QEMU git checkout works fine.)
>
> In the intervening time EDK2 moved the submodule that had a problem
> to be one they mirrored themselves (and at time of writing all their
> submodules are hosted on github), and we stopped trying to build
> EDK2 binaries in our own CI jobs with commit 690ceb71936f9037f6.
>
> Go back to cloning every EDK2 submodule, so we don't have an
> untested explicit list of submodules which will break without
> our noticing it.
>
> This increases the size of the QEMU tarball .tar.xz file from
> 133M to 139M in my testing.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3041
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I think ideally we would not ship these rom blobs in our source
> tarball but instead provide them separately. Then we would definitely
> have no reason to ship a huge amount of EDK2 sourcecode that
> 99.9% of the users of the tarball don't want. But that's an
> idea that was floated at least three or four years ago now
> and we don't in practice have time or effort to try to do that.
> So the simple thing is to at least ship the right source...
>
> NB: for me this can build the x86 blobs now, but it then tries
> to build the Arm blobs with the x86 GCC, which obviously doesn't
> work. Perhaps something needs to be set in the environment ?
>
> ---
>  scripts/make-release | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/scripts/make-release b/scripts/make-release
> index 4509a9fabf5..87f563ef5f7 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -62,17 +62,15 @@ meson subprojects download $SUBPROJECTS
>  (cd roms/skiboot && ./make_version.sh > .version)
>  # Fetch edk2 submodule's submodules, since it won't have access to them via
>  # the tarball later.
> -#
> -# A more uniform way to handle this sort of situation would be nice, but we
> -# don't necessarily have much control over how a submodule handles its
> -# submodule dependencies, so we continue to handle these on a case-by-case
> -# basis for now.
> -(cd roms/edk2 && \
> -    git submodule update --init --depth 1 -- \
> -        ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3 \
> -        BaseTools/Source/C/BrotliCompress/brotli \
> -        CryptoPkg/Library/OpensslLib/openssl \
> -        MdeModulePkg/Library/BrotliCustomDecompressLib/brotli)
> +
> +# As recommended by the EDK2 readme, we don't use --recursive here.
> +# EDK2 won't use any code or feature from a submodule of a submodule,
> +# so we don't need to add them to the tarball.
> +# Although we don't necessarily need all of the submodules that EDK2
> +# has, we clone them all, to avoid running into problems where EDK2
> +# adds a new submodule or changes its use of an existing one and
> +# the sources we ship in the tarball then fail to build.
> +(cd roms/edk2 && git submodule update --init --depth 1)
>  popd
>
>  exclude=(--exclude=.git)
> --

