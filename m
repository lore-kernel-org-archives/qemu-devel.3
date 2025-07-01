Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5E9C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 15:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdFg-0001EW-1E; Tue, 01 Jul 2025 11:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWdFe-0001Dp-Df
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:50:30 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWdFb-0002no-Rd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 11:50:30 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e8187601f85so5084968276.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751385026; x=1751989826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM0m9m6FgXQhqUCQOzdMmZYVj23cYKuGezzGfv9F+qE=;
 b=K9QrTpAWfb8l0jPevomr6Gb8LwJqcENUN2EKrsg5nn3xXAuf0QWM+ospmU5vW0Iwmz
 LDM4YnLsxeHHu4i4d9DX/C7+dxo3wjWn2liGqHOIirJc4iyOH3u2xEHJppNPhi+MC+ci
 EOayFzqLgr8r34Gh1pjGVERHjOlw2XVI88m6SjIRle9qgMM3iyr1dmyusFXgPG+PNKrt
 UH+HSHKUXR5T3z3FXz9/i3ovOGTKOJf9S+CO7VTrryVXbX/IKPN9LWseSYR4nJYpo8R8
 HAaxnnyb9EMwzfsnNIBaTVZGJzOkZjnmsm2cnTW/LwP0nK2gkjhf8OaHpXruk2uZfG81
 q/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751385026; x=1751989826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM0m9m6FgXQhqUCQOzdMmZYVj23cYKuGezzGfv9F+qE=;
 b=QYX04n3itzHKWyRmgb8pjwEdYMReBvNik5JpffyTremkXuOZO1B+q9+fl+o+IN3k65
 nvWQXZ7bcKm9RED0Bfgi9kwtUV7ie5NCs7p9oc14nQMxiIQwz1rrtT/h5k3Q1V+fHP9f
 3RrzNhlJ3HhpnVvH4DKXunG3jhrRxbaAgF+fY1DEI9BSKOGZYj2F/dxjAtuFsV3Mk5r7
 KsUEeLSOxrXHLotZngZgGfk41lJkkSRzlEHmXv5ljTPq4WXKO/vWmDGZXBfmaR4P0mmT
 cW0FdvLB+kod0q+F7M2z7umwoxJdCyfsrBTjIfkxJ4pRI77Syg7HSe4M3PAVvH/A8Hl0
 K6/w==
X-Gm-Message-State: AOJu0YwDVHvEdncgtsfNeR6tqBSn05a4YKB6wgG/Wz+OVrDDTTQ8wYbX
 cZ8eaIeaueYebePvlrjw3yE4QdkzPp0KSGxD22LE00dBrJCAt/R/nhXD7WjCtbEdYMBVo9svnBM
 qDHSeXySWXa5TqzEkLa1iI92Qo9PBTwAuCkTzIc1Vjg==
X-Gm-Gg: ASbGncsq7Qby3Gwkz7MOTfvSfmRKxmt09C8y3L8L6VO94+HgVvcoM3ZUlsCqfG97BIL
 pZ7OAzF1i83b8Vx0jIMJUoNeeP7p5OwZYLthsrRS0RyPWJYZFpeuzKMAl2aQL+NOkajdchXD4ie
 vZ/eU5WNR1PQSAi+EPDoChBMluP7917i7T3+r3PrNEWeDH
X-Google-Smtp-Source: AGHT+IGGy1LiWLJoul/YG8YZ7v1W37zVJZeUDsvzCu+RNL4TBiAeiTy/45xc5PzZQdt8W81oQJcvdTJMl4dmlwVX3uo=
X-Received: by 2002:a05:690c:1e:b0:70f:6ec6:62b2 with SMTP id
 00721157ae682-71517150f8emr253657857b3.8.1751385025700; Tue, 01 Jul 2025
 08:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-26-philmd@linaro.org>
In-Reply-To: <20250623121845.7214-26-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 16:50:14 +0100
X-Gm-Features: Ac12FXxbbgcWVCUlees7q4LLOO8nBn3R6BKx2RlRYHRfsfQHSIdewGI2EN-Bf0M
Message-ID: <CAFEAcA9MLMJBFk+PQCJT8Bd+6R+vaho9_vXmDCjPU5cp6B7LfQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/26] tests/functional: Add hvf_available() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  python/qemu/utils/__init__.py          | 2 +-
>  python/qemu/utils/accel.py             | 8 ++++++++
>  tests/functional/qemu_test/testcase.py | 6 ++++--
>  3 files changed, 13 insertions(+), 3 deletions(-)

This seems to trigger errors in the check-python-minreqs job:
https://gitlab.com/pm215/qemu/-/jobs/10529051338

Log file "stdout" content for test "01-tests/flake8.sh" (FAIL):
qemu/utils/__init__.py:26:1: F401 '.accel.hvf_available' imported but unuse=
d
qemu/utils/accel.py:86:1: E302 expected 2 blank lines, found 1
Log file "stderr" content for test "01-tests/flake8.sh" (FAIL):
Log file "stdout" content for test "04-tests/isort.sh" (FAIL):
ERROR: /builds/pm215/qemu/python/qemu/utils/__init__.py Imports are
incorrectly sorted and/or formatted.

I'll see if I can fix this up locally. (The missing blank line
is easy; I think probably hvf_available needs to be in the
__all__ =3D () list in __init__.py like kvm_available and
tcg_available. Not sure about the incorrectly-sorted warning.)

-- PMM

