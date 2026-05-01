Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66541FF885A
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIki9-0007lz-Ho; Fri, 01 May 2026 06:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIki7-0007jq-D8
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:03:03 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIki5-0002j4-FM
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:03:03 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-651cfaa21e6so1560544d50.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:03:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777629780; cv=none;
 d=google.com; s=arc-20240605;
 b=Uq+//BOBMb8XolO5ZbYiSfwFUJdCmSRQneUjDLLEQRroqmufGIh+Wl5fH1w5fLoYuI
 7UfDcCO+Pf4/40TpmF8YaQFxLA8i2pS44gyslqJ0l0BnyFqf96cTUx7NlyHVxKvjyqRX
 5eGz4KT86cYb8szlOvZpg3FxjH6RsQbJ1ZY+C5NGWu8qOkWwhq4MO+GpJx0tdP/M1ll6
 gdlGU0t9/63F6p7TzAsWVdg6YSSObgMVKyPxYbDmgE/rhpxTDbfcNda6J0C9HfRk/iL9
 ezbizIB4g6T6C0MYktwt/sRtgBPdOcC6KBn37aki6dbDh8kToYcqC9Ih3A0fD+G1D9Et
 OfLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z3y8Um76NrCIlYRFZ1rZCahz/rdXRfFXxjrO0xVQ3tg=;
 fh=dxRrAvoCm7O65oBKLkw1x0SaJU4UOdyI8YChmfQ/v3o=;
 b=dJinr7P/MRLrUvBW/D0FKWvThCqxyVJIoV7LSwPS1kn8eK/S8VrBxVgLJhPrcY3Oy/
 vPd+ZVjw2I6+2BWJwCLA+YrMb496k5q05o3i7+1TdJD1VsLYsCvAonrR0peDIeBhAE5O
 q661iWJitC0H3ofWcaZe459BJnAQFpvcwudzm0mF9RJ6xOo1liVtF9RgH5dqNgUOqNhL
 O7bsFbCDx3NA1LMMw7StKJ0TGv7UA2nhXWC1tm5EyDAnXg6Yc6hYB00MiUGtyB/N5HXf
 Pjy/edbG8XS6VPiO1TZDytSyZCfIMl098ahNsiQ2w50gbt+OfjfJkSVc5PtPDVe1bFoY
 9wmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777629780; x=1778234580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3y8Um76NrCIlYRFZ1rZCahz/rdXRfFXxjrO0xVQ3tg=;
 b=Iob6uVb+dpRW53Nh4yt9ZYdlneLjXFb2vDhtYdrir/LrHaX5uUj9OgvgJwiXNXFt8i
 giUQp2HkmjKdK5c3gXdLKova4IhXAOaTGr2skpye30NRhy24Ce2Pf71Eut19sOcqICC+
 h88oP6qRpQ5tQojyyGvyUToOoMitx5WKdMn0lx8pvZj38n9sAsVOdBpagutBTrdCOV6e
 UNcZQFMuZSmaHfZ44b5gsYxGD3EMdKTYflnSctPjByer+JfxbnIKFPhtC1mANznTtow4
 1+62Pv9af4q5JUJ2y1aBVs7ik/JJP+EmJWRp9lOgoRbfO/xmZJv9LwLY8WkQlA1BbG0z
 QbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777629780; x=1778234580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z3y8Um76NrCIlYRFZ1rZCahz/rdXRfFXxjrO0xVQ3tg=;
 b=Xmd7W7qJbikJ1EyCGJONglkHvyasewdCIrqBir4bYOOOC13wuqphVVgGpeVMXTg9xF
 RkdU36+IP1Ag+AWSVN29M41VR9FDyatvFwYEhU7Jx1GdV1wH76xOMXGMwlw04QH6GFMX
 /Xps7yVPEJZtzsHhWsYB0HzzgfUD7in9KrOXKHiUEmTFtc2cniVyrAx296k8vzOKDQUB
 A6WGDK5ZHBByUTby/CWird7Lh565Q1SlFzrXlT96/a+68BxKMeld7n6PXXkrhALdk59r
 GyTlgB79bRwTh3tQp7L4xqqgW4gql75xlkjk6NxD9CaMHoabdTZ0BmUlyVlnj227nvvF
 iJ6Q==
X-Gm-Message-State: AOJu0YyXOOjnmPWTzji73+FUqQVcO4RFqDTxYEyy7oOqrwl7gwxQ9zir
 FDK+tMCGrTtp3+MPzYEJ7v85vdpfmCagRMCvrEdvNA9VroLrgiu0PJVKwjXWpkOAsv6w1J35U0J
 PV/UyCgNrx8aUEEw//F0ykEAeu4V4PXa0pjyB46idT/X77QPn13TMtp4=
X-Gm-Gg: AeBDiev2fdVUp5v5vErlDtcRI8zjdX12G99ZHC7uQxi7ffAklknkFYRChwv9//Jndkt
 f8f2Aghr49v8f76EHq3nFFZ5hegzk57HCg8IRxj2CdF2akN/D24u/+qi6DcOP5eT4FO3VnkLzoU
 tQ9Nj5H9aWZ3vvwevDIQdzIsUf8sfYk4Uyjas1eWYh6OATDfKpuv63OqDjKKaQtaaZxUpIw10g2
 9jDPAqv9kfV0POtejAKWFAF6K8+Pe/IhWek6szecs9vUenkz/rKzaNaJo6PndJ1FPehJIDEMTsi
 c/Dhp1mDxxCB7xrIsWqqM/NMouMgpqAkkimwR5KF33RFkdAYRso9Bn/9GFnwBByBv+OsUZwcYQp
 ZE/S1ZpEeaFT+
X-Received: by 2002:a05:690e:2504:10b0:658:8561:d546 with SMTP id
 956f58d0204a3-65c1b0a4af1mr3325398d50.25.1777629779687; Fri, 01 May 2026
 03:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-15-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-15-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2026 11:02:48 +0100
X-Gm-Features: AVHnY4JEHLwwSvxv_jsjYiqGR5feaVQGBcbvQbxoi2bCFaZW8DcbW41kywNLEQ4
Message-ID: <CAFEAcA_TgEt2+=737G_XRU1+bWV=zypHFo0WTTG_Ms_DyyB5+g@mail.gmail.com>
Subject: Re: [PULL 14/42] tests/functional: add a module for handling asset
 download & caching
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 4 Sept 2024 at 11:41, Thomas Huth <thuth@redhat.com> wrote:
>
> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> The 'Asset' class is a simple module that declares a downloadable
> asset that can be cached locally. Downloads are stored in the user's
> home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.
>
> [thuth: Drop sha1 support, use hash on file content for naming instead of=
 URL,
>         add the possibility to specify the cache dir via environment vari=
able]
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20240830133841.142644-15-thuth@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

An old change, but I've just noticed:

> +        try:
> +            with tmp_cache_file.open("wb+") as dst:
> +                copyfileobj(resp, dst)
> +        except:
> +            tmp_cache_file.unlink()
> +            raise
> +        try:
> +            # Set these just for informational purposes
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
> +                        self.url.encode('utf8'))
> +            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
> +                        self.hash.encode('utf8'))

The python docs note that os.setxattr() is Linux only. If
you run 'make check-functional' on macos, for instance, you
get a lot of backtraces like this:

[25/36] Generating tests/functional/func-precache-aarch64-rme_sbsaref
with a custom command (wrapped by meson to set env)
FAILED: tests/functional/aarch64-rme_sbsaref.tstamp
/Users/pm215/src/qemu/build/hvf/pyvenv/bin/meson --internal exe
--unpickle /Users/pm215/src/qemu/build/hvf/meson-private/meson_exe_python3_=
6236aec97e09d842cc925a27128637b665e84f72.dat
while executing
['/Users/pm215/src/qemu/build/hvf/pyvenv/bin/python3.12',
'/Users/pm215/src/qemu/tests/functional/aarch64/test_rme_sbsaref.py']
--- stdout ---
2026-05-01 10:56:33,793 - qemu-test - INFO - Downloading
https://github.com/p-b-o/qemu-linux-stack/releases/download/build/rme_sbsa_=
release-6a2dfc5.tar.xz
to /Users/pm215/.cache/qemu/download/5adba482aa069912292a8da746c6b21268224d=
9d81c97fe7c0bed690579ebdcb...

--- stderr ---
Traceback (most recent call last):
  File "/Users/pm215/src/qemu/tests/functional/aarch64/test_rme_sbsaref.py"=
,
line 76, in <module>
    QemuSystemTest.main()
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/testcase.py",
line 259, in main
    Asset.precache_suites(test_module, cache)
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 290, in precache_suites
    Asset.precache_suite(tests)
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 277, in precache_suite
    Asset.precache_suite(test)
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 277, in precache_suite
    Asset.precache_suite(test)
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 279, in precache_suite
    Asset.precache_test(test)
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 262, in precache_test
    asset.fetch()
  File "/Users/pm215/src/qemu/tests/functional/qemu_test/asset.py",
line 227, in fetch
    os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
    ^^^^^^^^^^^
AttributeError: module 'os' has no attribute 'setxattr'


I guess since they're only for "informational purposes" we can
safely just skip them on non-Linux -- what's the Python way
to check for "do we have this" ?

thanks
-- PMM

