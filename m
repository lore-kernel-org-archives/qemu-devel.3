Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D17D597A5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 21:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAyHS-00028R-MS; Tue, 12 Nov 2024 16:18:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAyHQ-000282-Ay
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:18:32 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAyHN-0003lo-DO
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 16:18:31 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37d5689eea8so3628529f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 13:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731446307; x=1732051107; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBEDXQIHr58JSmTF4s/1h1xSHIZph2x02RwZ4yllt1c=;
 b=fBZ9IbCsGsusv2Y8dH42TknFAUNEi0phQ1D9wVCrQteHPrWGHkT0XFGwklLUq1nxMD
 MNGqsJJOkaDkkVm+8FK7xKazEavcmneWN8xpxwaDKI8U5aR6dhusy/QuV4p7bqrAF3id
 c87465UUD4kzqHyiV0vucVKYnhsJQNLEW0X91kLFvjopmgAhUAE2DuR/GMtBAUJ30yZs
 nONc8q0H7golstiruby6yglECYoJM9A7NrjYgXkpwHXBoFZ/NKiJF8xH/14jQ7rL6gFw
 /jtoTLHooSmlrCyYozwtdc6LfpzppwVXGwao86LCm7tUc03FS+oxPJAlslDPHVlLEmKk
 5qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731446307; x=1732051107;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oBEDXQIHr58JSmTF4s/1h1xSHIZph2x02RwZ4yllt1c=;
 b=qzRiOTyT25hiHEnqTR56S1XYQv+Icp3y/64anlWUshFfCWvRPNnwF+3JwekZveS/YW
 DaKkMIu1+dd8hLce5auLOdVF+AO19KgF5khQiCp3SjrlUWSYdUhU/xypCvsROw+4SIJW
 wxoaObBtFLHMrAo4QsRGG39DkS/ducgJMe5LcKlFX+S6yq8cwiXVaJc6N7Uk36MRiPzx
 GXIlS1PWegfDC9xhZie5HBj4Fp5OWB7qjLfWvF9SF0tEmWorOlCHCpVKpHXs5SKF52sw
 ARV5kBVqvRZCoggZ4Cg3mt6D+KnjXS5t9ZsiXk7syF0PYesmXQXBZDISGwVvENBaSfvP
 fxRQ==
X-Gm-Message-State: AOJu0Yzd2ke0Qvz5xfMvCcUKDEAkclTsJiLBKXNfX6rGJXJFRTFqZOq1
 nGxnTVYl+yHctYhqOlkiChFTz6uJVAuonDnv/0Exn5upJD32VJrSOO64K42t+RM=
X-Google-Smtp-Source: AGHT+IGS+vqVnjnTvQP4zWKmXz+RdV0gjGgqHHIOdLm2klPfJaS9oEPQhhvWECnIfraHAW7+tQw98A==
X-Received: by 2002:a5d:5e0a:0:b0:382:ce0:a7c8 with SMTP id
 ffacd0b85a97d-3820ce0a843mr1190024f8f.42.1731446307259; 
 Tue, 12 Nov 2024 13:18:27 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed970f85sm16674171f8f.6.2024.11.12.13.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 13:18:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CCFC25F7CB;
 Tue, 12 Nov 2024 21:18:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
Cc: qemu-devel@nongnu.org,  djordje.todorovic@htecgroup.com,  cfu@mips.com,
 arikalo@gmail.com,  philmd@linaro.org,  Aleksandar Rakic
 <aleksandar.rakic@htecgroup.com>,  Faraz Shahbazker
 <fshahbazker@wavecomp.com>
Subject: Re: [PATCH] GTM19-448: Fix script to work without realpath
In-Reply-To: <20241112183849.2577570-1-aleksandar.rakic@htecgroup.com>
 (Aleksandar Rakic's message of "Tue, 12 Nov 2024 19:38:49 +0100")
References: <20241112183849.2577570-1-aleksandar.rakic@htecgroup.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 12 Nov 2024 21:18:25 +0000
Message-ID: <87zfm4tala.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Aleksandar Rakic <rakicaleksandar1999@gmail.com> writes:

> The archive-source.sh script depends on realpath command, which was
> introduced in coreutils-8.15. CentOS-6 build systems use coreutils-4.7,
> which does not have realpath, so fix the script to use 'readlink -e' to
> perform the same action.

Isn't CentOS-6 outside of our supported build platform range? We aim for
latest stable release + 5 years. CentOS got to 8 before being replaced
with CentOS Stream.

>
> Cherry-picked 5d1d5766f0219ce2bec4e41c2467317df920ec0a
> and 8003ab4032772a0e5b46e5983fe06268d3469289
> from https://github.com/MIPS/gnutools-qemu
>
> An instance of a pipeline of QEMU CI jobs run with input
> variable QEMU_CI=3D1 for this patch is available here:
> https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1538854588
> and for the master branch is available here:
> https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1533465414
>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  scripts/archive-source.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 30677c3ec9..bfaa0c1483 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -18,7 +18,13 @@ if test $# -lt 1; then
>      error "Usage: $0 <output tarball>"
>  fi
>=20=20
> -tar_file=3D$(realpath "$1")
> +which realpath
> +if [ $? -eq 0 ]; then
> +    tar_file=3D$(realpath -s "$1")
> +else
> +    d=3D$(dirname "$1")
> +    tar_file=3D$(readlink -e "$d")"/"$(basename "$1")
> +fi
>  sub_tdir=3D$(mktemp -d "${tar_file%.tar}.sub.XXXXXXXX")
>  sub_file=3D"${sub_tdir}/submodule.tar"

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

