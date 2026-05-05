Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4820CCD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDFN-0005xq-NI; Tue, 05 May 2026 06:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKDFM-0005x2-Bl
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:43:24 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wKDFJ-0003RW-NP
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:43:23 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65c24be9e4bso4255195d50.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777977800; cv=none;
 d=google.com; s=arc-20240605;
 b=iXP11ax1C0r4TSt7ZGk0wZqOzydbL0rltbchtO9OUyj0zo4X4f3FpJPmKxN2nNNf4e
 0FANNtM8L1KYj+3X2Noh2US61HkS7hWevd7BIFser1clQZYBabj3VsFDT+7mFfFPsL4G
 +9iNPD+k2NNuWR3gp6O0oVPMA17XeDmkP18wturx77CguPlNKQ1bp6dxOc29Slwg20OD
 oxRPTPWq2qhN9xCEduw4FLmhG99S0XFgiYD5aKbKaUhO0H3G7o/0I7ozKtC31Q3emT/p
 21jilJuKo4A1ksWkVJAlBiHAoPQQEnnbb8kr1BU3OMseX/Gq9O+oSomgig68mdndolZ4
 QcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=teRU8rk5MOHTky9u3q2n9Q0lB+lXbes576S+k8BVAS0=;
 fh=5Wv4duMH+rgimKaOVxwvVVg74khZ6ldBwL5uRPFajh8=;
 b=Zzi/fmUIx6VFdvIh9xGErZG9Kmqv6I1F0lfR8H2jrjmNCXYosbKHhq7PSYWUhWsI2+
 +TDoMbChpZuxvn793FWeCDhqI+3qxc1LA03mFe+kVtPE49zyALcirytPHm+RwmD1nJDJ
 Pb4fwwY8946D8OHhSOA/Je1BPZOShop8Iy3TLOGBQZuHL/+wSoC92p/Jy0rNm8299vQ8
 ygf9SVkv36YB8OtNZ+x7EdgeqNXL+jEk685eGoRcrKNrBcL0oCShiPeWKxEjCqAFGpJm
 A36d4z6VegHHu3i3SLMtqGLtutr3gUHz3ea535Pl/Fs8qt8UVI1sPzN57hWe8NDnAz08
 RSPA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777977800; x=1778582600; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teRU8rk5MOHTky9u3q2n9Q0lB+lXbes576S+k8BVAS0=;
 b=nRLkey2xLN0wd662lSBgNjtrr1H7Jk6U6MXiyhSmrs6tg2gFUh2eDDgNwvUmfVhss7
 B1fIeeYGk+RFKRqEofPfBqdUHbcyd+o92Zax6F5e8iSVTFcNpIuE3++tDeaGc/c8r/J9
 x8TDJveH0U7XUApGxWm+eOltkxUt2Xn2JPIpfe/W3NgG9Zaqogu7uQfkfLNQCDyFtDXa
 i51mKI2C12CqQi4nUWguo0A3E+VZIGUPlSfJTQVI54MBA1jfI2fVuXnxG4uUraqG4Rzd
 4SkWjZ60ei1KyjRfCbsKlM8luN2EDaNiUAHHWLqd1GhXqNBd0jY50L38qixXvF0+Quey
 me+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777977800; x=1778582600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teRU8rk5MOHTky9u3q2n9Q0lB+lXbes576S+k8BVAS0=;
 b=qojGJMWYgNmlOTW/cCAXcQvHCmzVz83oZXH9b8RGS8ibx5IkgtAfP/2On9i7ouSoz7
 xHrqgWfHltDYPB1hkqAmxht8by8DDfQun/1MFxl5K+tfb3GYzZUUPhjTt//VEUyyFQRI
 vowRjr7bcsRhzoR4X6kYwOvAmnZgN2j2PoUsgqF/IBTnfZzEXarSoynlrgtqRbB6ZhZ2
 ctbMXu3Oj7VutX7BnnErX8GNEBIPzQIsWAw02NtDiHHr+cveL35o3nUOUtCSWoUz4wcn
 I9b1+1bxd5+NqOJOfBuOmWV4Cso1XCpxmDxyfQbZdgAJJRj2qOZfO502GxN5o5bClVgG
 MhIw==
X-Gm-Message-State: AOJu0YwjLg6TCNYKPWhlNNwH3SsemZr7QNufWbygjeZ5wC1bxd/I5Z1p
 2VSW90Ip7vfWVeK0m+ww+bPozuYu/iIQJicgP3gYhK3fY06LmImOj7ZM2IJnD8DG8qRlHXFVswO
 X/thiRxUWVH4zw5GDHWqD3M+n9wQf1OYtewGYa9iTpQ==
X-Gm-Gg: AeBDievpxOx7YDKxCcjta+dm/u4lUJszPlJGmLBnqEBN3k/BYHep6bx+0ZRp5wAnyS9
 81zDhItjtlAC1HiA8XfGMCl5fsogiSHS0nirVhFwa/Dkx85JFM8Fi72EdVx2lSr2NeNo1IOmYOS
 x6SpQ7ydpShClWbqwIQzxZfJBHUSLMhBLTQfzaYWybsqgpXAlh7Tt9KS4tm2ns2TcZBZXHS7O0A
 8STXLWSs2HHqEmFqHOGWBicvFhSzOHwhcj5KsxURPcrhHtGrmXvs5tiTcg9BH0Q4W+c6dxaJW8a
 j18l+z1KvM/kzvk/SDA7d5N0ACNAraD5cfFBbmEPpFUsQDLWSb6pjt+p5sANheCvdDGmCRpQfN+
 lHA==
X-Received: by 2002:a05:690e:4141:b0:657:4568:c4c4 with SMTP id
 956f58d0204a3-65c69c8c288mr2852351d50.18.1777977800404; Tue, 05 May 2026
 03:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-2-alex.bennee@linaro.org>
In-Reply-To: <20260505103649.68361-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 May 2026 11:43:08 +0100
X-Gm-Features: AVHnY4Ls6_-k7RaEWNQxYbQZriOGVLpDj94R0xrIT_Yg1eU1XrIhDMRH_WiV6nk
Message-ID: <CAFEAcA-rFhHmS2+ToEZkr1+HE_e710-ZyyPESHLzCeW0QopY_A@mail.gmail.com>
Subject: Re: [PATCH 1/5] configure: report unsigned qemu binaries for check-tcg
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Thomas Huth <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brad Smith <brad@comstyle.com>, 
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Tue, 5 May 2026 at 11:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> On MacOS the initial binaries are created with the unsigned suffix.
> The user is expected to sign them before they can access the
> hypervisor APIs. However for TCG testing we can run the unsigned
> binaries so lets make sure the make variable is correctly set so we
> can run the TCG tests.

We have a scripts/entitlement.sh, and this seems to have
at least some plumbing into meson.build. What stops us from
running this at build time so that macos users, like everybody
else, have a working "qemu-system-foo" in the build tree ?
Having to work around this by knowing that you have an
"-unsigned" suffix until install is awkward for our own
scripts and for humans.

thanks
-- PMM

