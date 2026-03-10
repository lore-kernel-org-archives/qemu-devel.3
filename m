Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAECEB104F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 11:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvQ9-0000vL-Ks; Tue, 10 Mar 2026 07:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzvPq-0000rD-1X
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:38:22 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzvPo-0005nQ-Dg
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 07:38:21 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso12232102d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 04:38:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773142698; cv=none;
 d=google.com; s=arc-20240605;
 b=ccPCarhzKR0WJYaqP0VFlq+JwyHcG+1C2RNm/4jRbT5LlB+8gAACjAYCPasnxvk/1u
 ON4CXHQm57fKwmclyEFyEHmOiM0VdXBXynVgk1+yyQS9wSrfYiIK2pM/2OVZjZ/ywG0S
 0Hti/lNaYyP18NLUT2sdboyeUFCOyj2PPxWAzBHTzDNZAp/pHvpR1bv05pGwSfoBzDrw
 Kcw/GGAJb7GrlnX/XLQqHwZpotpZDBaTF7nWVcIYRrq8cjdnrsLFmpuoQi+pSieBjCqe
 GtNgaVj+KMA3GtZQiAePtxCtoaSDAhSkzx+3wDj7SAX5FlZyHjNNMb/gnZcY3TTfXT03
 YoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aQI1HbEtkb/johi2V2zKTPAVMbIU+T3IoKMUDViE3w8=;
 fh=SqMavYMIshv1lEV5BmuGm+2M2MhT8VTVH4Vn1CaMaL4=;
 b=i5wyYoixgqv3J9mO/AA3zUMTSZdVHK0ozvcy8DyhEGWu/mvGuFhmrHp35EYshMjyAb
 Ep/D0fcAoiVvSYVMjV2UGaiAccHuHaMo7FXXo6K/NscKOimrN9xTK1+/0/wCm52uUCK7
 eQEm45PVFCNPxOO1aNgPLAF7x5vOk9ebVQFTC57JTezZcPecU2GMygdlPcVv1J0ZN78S
 Msv76Sk6VxBQ00moY0SS5BGdMDhBgtPSgpkubEKKdCm40lhd8kRWOWXVoRHnoSR/LwTJ
 ZmGl0fLVwhL5OIhKGKa49za8YvKt4dPWR76AGx+mkED4xx077kNNfPdCMt+msDCo+Vlu
 EkGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773142698; x=1773747498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQI1HbEtkb/johi2V2zKTPAVMbIU+T3IoKMUDViE3w8=;
 b=xSe1AEZkdWeAAE4Jc3LTGXS6/poZ9I9jpv6JH4es7OmbQMY9Wo70SHuXSHyLCDFy4K
 sp22Llnj+ujPuSNeBVWblsLGqKv8qJwBZvrFUfdQkJQUpT1GHFpadsHTzQUrhbPsLTgd
 QQ69Gw3JuKagpmA1Gk9nFbuW3wW/Mai3d+YnPHB4/bJwXNzMlC1u3jEryDCPjqvYlvvQ
 FLzOZHUJTOIf0j0LZEzwK5yLK1VEvzB17uLGOpVeI87sMdYgx5N9+zl6Sp4oy2gTWMQG
 udmXsEuyy8ASfm5Yok96qZFjiSDugHVK6XXQYYcbZaV21w4s6DUDUONVhxZ6npClUeo/
 GzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773142698; x=1773747498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aQI1HbEtkb/johi2V2zKTPAVMbIU+T3IoKMUDViE3w8=;
 b=WskK5NFUQbiY+ozfW8Ix3Nh15fKrJS7MKtdOjEsigBsFAyi/i1vR2XuMitz8dyy8UU
 ZEAnngkHOO2NYD8ZVLiYAw/AMpmPWt3LUJO0HwRzdAvGsR5fGlG7zKFP+4RAK3d7CxHp
 hua89gQAOFBeiD8gwMJVxJcF2NcDyVVREvH9TSP3+4xmhqPUpIyGl7wy9TW0mAICV9BU
 ERsj1RR/rVqGQFv+sddSW5dZRQHCOgZfyamd/KpsBUFNPzAcY442g8OXLhwveLq8Kyaw
 cVh7GfVOrhimrKm9Ko5wgCdGLC5D+51D3qQCs883A9EWfcPAfxxpl72GAAV9j0jiNasw
 c3VA==
X-Gm-Message-State: AOJu0Ywp+H9o4tJDsq9+SW5OsQXWlz2AbU8rfWyynZvMJPuatsf1aDU/
 POMlIlCSE1/fmP8NENkCKIi/GbjoWqcHe2wx7SlHRK3tfDdsmLf3lid+hQkxaHvZx65Vc68h4pl
 Z1nojF+hH2bI962mIHzzXz2D+iBSKntBQIxF98OnBSw==
X-Gm-Gg: ATEYQzwD/uGnfBbY3OCJ9BrndPjoqie71U0q4kZuyKVLNXSWKeqFfPXMGM7snC98WTl
 CyZocv0LHzRat8OsjEXCPwshW51Z7ZEnLN0zKnW76K64uH8+N1AYbxB7E0iWD/mytPevWAvGnSR
 ZXHACRcnHLc4rH3HLchyBsd/29f+s3Pao+GXMKjvTNkDIWSJULayGN3hkX+J3jrzV34euhi6t4t
 0L+BwzayYluJWBa4/JHUrzahfdGr6xL1wPEkSo2LZRTLaElH3bIrOMqAcHqAXGMf7FGMPq8KRad
 oFXbjFi/SmHlhydyBzfpKyuFHaXILQvl7j0iwnfCTgf7gVv4yA97IKPHtH0QFYNHjHg=
X-Received: by 2002:a05:690e:4193:b0:64c:975b:ecac with SMTP id
 956f58d0204a3-64d143334edmr12125557d50.74.1773142697998; Tue, 10 Mar 2026
 04:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260309180601.164435-1-jsnow@redhat.com>
In-Reply-To: <20260309180601.164435-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Mar 2026 11:38:06 +0000
X-Gm-Features: AaiRm53SmDZHr9eBU7INTqSO7jshEJPXC3ZxAboCO_nU3MVIC9sI2zZYCHbNs9s
Message-ID: <CAFEAcA8yxs+A0FZGGV56iUMY1UFveZKbx51wPT6DiEzBzX6Ocw@mail.gmail.com>
Subject: Re: [PULL 0/4] Python patches
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Kyle Evans <kevans@freebsd.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ed Maste <emaste@freebsd.org>, Maksim Davydov <davydov-max@yandex-team.ru>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, 
 Li-Wen Hsu <lwhsu@freebsd.org>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Mon, 9 Mar 2026 at 18:06, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit de61484ec39f418e5c0d4603017695f9ffb8fe24:
>
>   Merge tag 'linux-user-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-09 14:53:42 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jsnow/qemu.git tags/python-pull-request
>
> for you to fetch changes up to 191d4ceb40f8c80ae402a365a41300dcf1344125:
>
>   python: add formal python3.14 support and testing (2026-03-09 14:04:25 -0400)
>
> ----------------------------------------------------------------
> Python pullreq
>
> Drop avocado, support Python3.14. Fixes optional check-python-tox GitLab
> CI test.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

