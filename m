Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431C6F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:31:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iB8-00035O-Mj; Mon, 23 Mar 2026 12:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4iAy-00034c-1i
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:30:48 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4iAv-0003Nv-W0
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:30:47 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-793fdbb8d3aso41962797b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774283445; cv=none;
 d=google.com; s=arc-20240605;
 b=XGLQsaD1gmMuFNHwFUCWqvSm2QAIp3u5T8W+nel6iyGizjiL/wp6iy3Drf2WEzjEi8
 EojqslxpPuVVtID6nKaI0+sy5mqqNWDj8YemDUINWSbj2haZDO6dLaCMCoZodhUe0vKx
 hv3XGx0bEWYRG5Xr1pD0639AxuFapknd0uTj8635phG0cfNYVW2iPX4fIxXDTyEBkbg9
 SkL3YiYv8aP0b7j8cUQgxGIprVmE/MbR/ygIAi/2IjMZkv2AxoUOT1UEICtR+pyI7/qA
 eJX8YStEWtvtaZmm1sGIGC6BD+PzJPWqY4pPM73O1ElTRTmd8/rwnihbp93YxU5F/NZj
 xlTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BjTfIR3FcDKC2v/Bqgfw5wm7NsKRK5rG3Ew0Q0qN/5w=;
 fh=PijJ7Z88w7YsiOVm9RiLAS31W5H4oQhvkga0H5hRzCg=;
 b=B+vSK9PQpffiUQ3ZDeuV0ftWS6Voxya1Mjq9en44Wd7hjj1unewGETNcSW4tgDHkbL
 P/QJKqaf713RvyrCnDbswVZLrB8P0z8+bjaCeZb+nFtO/m5I6Lh3QonHwjXXIrG0Z9fQ
 Kiy756uxuH/jQ6lsvfhkJyz2Tsm6gKUhASTaTiQC0qRuHC9THV0yyOcaUataB1m+z64x
 WZpXIygLaiIzTZFvId7EOCKkj0/j+D8cHFTanpWJS19Ny4Z59Ar7WQrAX9gjSCHdQLJF
 qnG6VRtBmOm8/EJ+TpWXMabB7CoSPHvP3XvAaT1x+O3WnHQGZBwfddkLYldMJFmjqoyq
 4KfA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774283445; x=1774888245; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjTfIR3FcDKC2v/Bqgfw5wm7NsKRK5rG3Ew0Q0qN/5w=;
 b=VuxMvZtNj04zesI3ctcJTrcRljkxbMU8zoTGonPoASDNyyDdZ8np173Pgcr/LEyCJc
 60MSSl8Wq0Vvarsb/0RU2RYofqIky8NAxcQkJR7jH5L0GN/jPWxTApI+RNudvA8yZtzb
 XBJE0kGFM5tT0rjODo39H4wShjLM4nRWrCYU88HtAh62o0VBUBP6PxMxKytTNnU+ZAdm
 zPJInvW68O7JC0knVeP39zCCfZi+GaTgXHBTJRKwii+dTnzrlHI9wRCABHF7gSt9lpBK
 a0Lmk6vny5pYMWfiLo9QrmTG/iN+8m/YTusAU0/ckoOmdwiNUZaJeZBiWscJ/v4E1uLB
 cTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774283445; x=1774888245;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BjTfIR3FcDKC2v/Bqgfw5wm7NsKRK5rG3Ew0Q0qN/5w=;
 b=R9C+ISOA+sdy0Rrj1kahCYeUn+vHVuSCa4HpJSr5/ngyy5JobjzCfFPEI4sLqmY3zm
 6R7a+mJlo07WyDoq7+juY6Grw2Sxf8mR+KpgD+eLfdi8Gu6yOlIl4AitvhHOgJAGBOr9
 6/pV5HMAeaTbXSmCN0In4n+DmgAyFldOZLSmXG1fZntCbKcD1HAdCEbbBXbC4eQI89Id
 eNdDa1pmy2p48FUtcUUkgHLYmVAgCisj61hZigNE/KOYjuJAUlHslQONKhbW5EJ6aLLZ
 RO4xVRbDpzmhfogZTwU0WyBOhFh2rZxDOjVve0uTKaM3g3E+TkhFfmvmyqLZnavlaECD
 Gj/A==
X-Gm-Message-State: AOJu0YyMF7xp1QkmjIBVvxOYxng062ks6eAExC/woDQsFI1uaA7u+Ksi
 v0vYW0oloNjm5rM207C+i9OWpt6Q7cZRlYJbS67OSyr5sfQAgXjsDB+lH9ygml/yVyhIqAATZov
 XsWcZ9WmulIcL0GKJVSqzGRjvFzp6R5wflTFEgNidGQ==
X-Gm-Gg: ATEYQzzX7jabY7lSyeTqidrJ04orMapNo0CY7QwtLmDknkCJV7lZ/q/tZXxOsgumPb4
 EOo/7ZmAPyWlkucyOr7AGq+Pego/vZMnBXspxCv5yz+MBMyToTvALT5ersRZYh0D6ZhS5UY4d2I
 Z19PWHiObiZO2gG6kSfb1KQWHHiu/xLUtnxWsdFFNUVAXeFggiTrHcxBX5n8H9K351T4zLlgpiu
 nlrxwUwE+7ResNFwDnV62u8yqPb4ucAhWEQmQWIxNpoYNU5FlbwIOImkWv+Pk4XMClENbiqNCs9
 XNU68utrUWvqmP/GVwMHYOM7xPX1KGQGWXiUId+VkZtZr+8ApcbONWUMoFKuMQ1O36ToceEv4V5
 XAA==
X-Received: by 2002:a05:690c:a04d:b0:798:980f:6706 with SMTP id
 00721157ae682-79a90aeabc5mr106039537b3.22.1774283444591; Mon, 23 Mar 2026
 09:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260323151934.92880-1-philmd@linaro.org>
In-Reply-To: <20260323151934.92880-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 16:30:32 +0000
X-Gm-Features: AaiRm52OZ6OTvfufyhOAhH6TNld_58lkrJ0k4ZRdP7nOF5N_s8dEf4A6KK-ZfTA
Message-ID: <CAFEAcA-F8_B8ni2kNefoG2f9dwB9NXXCV9M_V3sd2k=KWYf6SA@mail.gmail.com>
Subject: Re: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 23 Mar 2026 at 15:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> We use "deprecated since ..." and "removed in ...".
> Replace "since" by "removed in" for removed features.
>
> Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
> Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
> Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
> Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
> Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
> Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
> Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
> Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument @det=
ach")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I checked these commits to confirm that none of them were cases
where the "since X.Y" had just been moved over to removed.rst
without updating it from the "version we deprecated this in"
value to "version we actually removed it" value.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

