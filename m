Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59BBF34C53
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGh3-0008WB-71; Mon, 13 Apr 2026 08:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCGh2-0008VH-2S
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:47:08 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCGgz-0007GA-8v
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:47:07 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-650775f427eso4163442d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776084424; cv=none;
 d=google.com; s=arc-20240605;
 b=hEbtJRKmtcNxMLCeoJ+D+75yMxA88fnrkCLG9Nhalr9JHBf/VW3H0ZxqwF99u2lx4H
 szxHIDBqSUYsKFUcj/SAoCLL7Q3ICatAmAzKqNIPrw7zitgdzd3RxRpXzJ2zaiJuc3Jp
 zOY7BqmFyOA5jvIwHsS7M6LhpCmEyxz/SITgVIfnxHBeeh0Hlhe7nhFnbVgyJCONCy+Y
 syVsCvEt7zX9fhjMh4iwRu2E7yZy9WloznkAvUB8r0MT7G2esJ5+NA8HQuKHdh24F/pI
 y2JNxae8r5I44+RozBJw5Trl58xpQV0FD22PM2DLUfKR2+oy6YvFxjIc7ikD4Ba+zzGV
 mWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P9SfDODrg+jU7CtvNxi+2AkCj3XkzSgbstz7nseOBF8=;
 fh=fJ2PWDO4LEacSGpatHtT8Ajy0y2AFDGYC6jomcdQhXk=;
 b=Q+ujJCRvclaMOOQwfGfv0o9QxxmFfxzW6NTxn1D0U8U2Btgx9yAeXPXQvhOyr8vG8r
 rvjEjbYo7XCOhL3n/s+LmbesyEYxx1K4fgT4CW96XsdDWzp+1LZvhg8loS34BevbBZvz
 37hu5s8jILFXDR7xFMZH+llUq1PgivkPgsqdDsMHQfPibtZRVUntGSmAv+sErHJdAs+s
 EBfy4yewvZGH5CMXKuQENm33ZM6kc501rhiM+Y8rnlHEozvni6huJwAfDgYUf6P/aUDI
 76y0m5ZxmQoJIDL/amC+sNyXByJWayMH/3VEWdiMtDyHqnfmcQz3msIVquIoD46Gf0iY
 AZQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776084424; x=1776689224; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P9SfDODrg+jU7CtvNxi+2AkCj3XkzSgbstz7nseOBF8=;
 b=nbc5QEI9JT3Gcmrj5MWEac0SYR3d7BYaikEtxmdHG8TtcLSrt06jMy2f1dvminxopp
 ER1dDuT9lSnOgv2wKL7YbcotuIMSPKuaMRuX+8kJFqjfiBpRluQgu1mo7AhK0ZJSxr7Z
 Qay0vayGtHaCGkxIJq7UFxOxovg5mSlFWsnE7ecxxVeJv8v3+HdlZ5R5kmoJqajRoqm2
 K7xoxKMOgiw59RgeBqgV0kY1v9WojWa98dAZhCEUIEmuu0mlmygwex5k/DG801peqiKF
 Ssr+eGpu5F9VqALOys63IW0y/lNIxJfXywcZ2C9gT9tstgLuSfI6nAz2or24qTvWY4rG
 m7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776084424; x=1776689224;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9SfDODrg+jU7CtvNxi+2AkCj3XkzSgbstz7nseOBF8=;
 b=V201J/Yi4dtgQhlkHqQrDrsSIKWcXRTHTi/JQzUVqByMH+/CnFh9R7QOho/YF5b2ot
 Kj0kebKDVHbrLF5YEC3E+wcrlL+dO6Jyvgh8KhoH2B//KAc8qpbBIpsdhIT8fzndQOzd
 NWalgn3arc2aiz8+knAsx/bpxJv9H6YYdjnuXKw1vAgH7zLWqL10iWrcQZtJw2IG0IPp
 6qbPK8/rH/XMBWRvVp18PANyrgauONErgNR/V7QsY6k6b4ZI9VKZ1rZsdIPZAouUsaUQ
 HvRuplH2iDVVIr0AZyf0PowLNd+Y6JPCvlC7V0dXPE2QA/Yu+WLV0HZxfL/iOepO1TrL
 qKNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9p+1nHga/DpDDbUcI1ERqIRQI/SThz2w4+3rZDk+BmrTi+BnptDkhdvtX/DUZDk8qDeLhRRJtNeNZI@nongnu.org
X-Gm-Message-State: AOJu0YxleltB1chnpv6fPWGhgLgX1RtFi3B4i06x0OASa8XAN1pj9q9o
 E2FZmrCf7HzatoQDLyCnHCuAwAubKi2VofaHW5gFSnSgqvDhtxNwgwP5YeQoU25Vnr+0GmfpgG4
 t/nkNCW3prxFdhuTb54LphUDW9WkAZ+Az2cML2u6mSA==
X-Gm-Gg: AeBDiesY2yLSIdk0R1W9zOUmovuoaz2I4PlU/DohJPtOJisyLBqtNMX5Mcq6pIrgktp
 +a4P6UbqGjT0MuXzRUtduNTvbjUM94OhlYS7GdWvqNg/ITTCx1YUl8CtxfmWnQuNGEuUqBDTgGv
 h+y0LRgmwQ7cGc0bpJbsSF3D3WWIKXjBJ9UvZHePTA/PfVf2OySEHPzr389wE9yYQ7p6vgT7Imd
 m5VXDahPFumiaoHOgx6kA2scOBAEPj/LpOSci8I+rv1ul3dRuSjzpWRNshXhdqaYDdOYHhTyqvj
 1PrskUdl6qKOGKDnGM1n36GstdEBVKXMZmGyt3UHb3jonhrCGvAwy8h9VyWW45/OTmAyQEuy7St
 YxA==
X-Received: by 2002:a05:690e:bca:b0:651:b526:7a2 with SMTP id
 956f58d0204a3-651b526090fmr7351472d50.4.1776084423574; Mon, 13 Apr 2026
 05:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
 <20260302092225.4088227-3-peter.maydell@linaro.org>
 <CAJ+F1CK+_e34KDeWJ4uc2Lypo32_MFPOHMk7aAvvc5jyWxxfcw@mail.gmail.com>
In-Reply-To: <CAJ+F1CK+_e34KDeWJ4uc2Lypo32_MFPOHMk7aAvvc5jyWxxfcw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:46:50 +0100
X-Gm-Features: AQROBzBG6jUkaIBwcpsfr_54R_M2Bvx70yVeuQnIv41rHPKRMRmMd0XCATVz0Eo
Message-ID: <CAFEAcA_isVOyJam45Xnom=y9wGdkONpGCAnx9q6jS9C37au-yg@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] scripts/lsan_suppressions.txt: Add more leaks
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, Yodel Eldar <yodel.eldar@yodel.dev>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 13 Apr 2026 at 13:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi Peter
>
> On Mon, Mar 2, 2026 at 1:24=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > Running "make check" with the clang leak sanitizer reveals some
> > leak reports which are either not our problem or else not
> > a leak which is worth our time to fix. Add some suppressions
> > for these.
> >
> > While we're touching the file, add the usual SPDX header
> > and a comment explaining how to use it.
> >
>
> Why not wire it to meson.build tests? something like this:
>
> +lsan_suppress =3D 'LSAN_OPTIONS=3Dsuppressions=3D' + \
> +                meson.project_source_root() / 'scripts/lsan_suppressions=
.txt'

Mostly because I didn't want to do more here than I had to.

But also:
 (1) this isn't the only thing you might want to set in LSAN_OPTIONS:
you probably also want "fast_unwind_on_malloc=3D0" and maybe
to set other ones like abort_on_error or print_stacktrace

 (2) as a user you need to set all this stuff anyway if you want
to check a single test run, so hiding half of it in the meson.build
files wouldn't really gain me anything

 (3) meson itself sets sanitizer option flags if the user hasn't:
see pyvenv/lib/python3.12/site-packages/mesonbuild/mtest.py or
equivalent in your build/ directory. At the moment it doesn't
set anything in LSAN_OPTIONS, but it might in future...

If we can get to the point of having a CI job which builds with
the leak sanitizer then I vaguely asusmed we'd set LSAN_OPTIONS
in the gitlab CI yaml, as we do in the build-oss-fuzz template.

thanks
-- PMM

