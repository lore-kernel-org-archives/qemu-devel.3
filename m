Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A496FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHK6d-0002Aj-Os; Mon, 27 Apr 2026 07:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHK6Z-00029k-Bp
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:26:23 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHK6W-00014o-E1
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 07:26:21 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6501547d7edso9113608d50.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 04:26:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777289179; cv=none;
 d=google.com; s=arc-20240605;
 b=Bk9HNxEK13SqjVl1aiMQ5JBAAwq3TnV2cTQzJ0WClxade8L3x7+kSzJdpypi+jdT3I
 6osTTPcmGQ9YTouNRcanbgqBVpSqRtS9nIdaF9g+/L7qiV4x/Dt0PVbfqHetTGar8G8U
 VMHxb9f0XWlNZCE8pD6SuiU4GOfNO3VSI02vMeEuslwdFVbBUyIadk+JmGDAgGGm/dXO
 l9ds5Wh3KmeH+LNjBRZwaW7wsBADwqvoQMOCzDjzkYsvE6ojx9Vr1877ls+vDKRf6N5L
 hEe+phSrfYq9IaLVTH7auIVpCkTcO1itEHJAZGFboc0n7aJLMTWAAm027i9LkGfDBIq4
 4+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jQUSsqYVd7Cvs5s1VaZAfjWliG6udHgREMh34HOJ6vA=;
 fh=zl9pJMKyv4GHQFXbijtF/rfJMXjLyvsMxBNITxP9tw8=;
 b=NknQckwheTKB60CK+TTKxHdcoXT4vDD9+57OT2stOcl9NOeF0EEbsp9IEWgA646sBf
 56Gvv/nYwKU1H5wQUQTZ3UvvDGbc2bDevt47moef7GjqKD0dhaR98jSfXxJtq/MhSRIa
 vcVhjvdXm/yVROAmkKtWZfpdkk27o0kS38q+b9dM3DZriinuFUCvbM4lP/6BnQt0N+5K
 3nt4wvfuNV9+RaUfH7sDm93zVpHlBf8sawcf3+cIP/5/fLFdaLlgxyyFgxD2tXCVO+K3
 6WzuM3hyuaE/WuraK0BDu5Hh8N3iuU3l/6Qpkx4kUNEf5voCrsrK+xNF1DFagWAJrwuH
 tjuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777289179; x=1777893979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQUSsqYVd7Cvs5s1VaZAfjWliG6udHgREMh34HOJ6vA=;
 b=JA2Nc4P2DIB93d7sq92mf7zsfOXxhmBiy+nLncpwM7MD/P2wHGKuS/V1GlaPHW2amR
 cH0MdNW7vQXq4kDCkeWGUpjtpr7rsy4DjmLZPcfbFJPkgdglpsEBeeOv1liifYgv0Wck
 NpaFg9D048GGfdFH+bAqQFrQB4Ls9f/5NhWx0fhI/7g2SEO1fzSkc9f/U3gv7pa56pGx
 VK26Pf44IMyThPqxiJbzdOXOnm4kDCQK6av1AM8W29zGRAGF0j4QCMtvDgoEAICXU2w3
 orRGA8i6DVylOSdi2cdIqTtBhP30C5DvU1oZWESaHctipCMiB8c/Aa2fRLAqPcJXR7Sa
 GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777289179; x=1777893979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jQUSsqYVd7Cvs5s1VaZAfjWliG6udHgREMh34HOJ6vA=;
 b=aHPxMVkeWhzfk+CD+KytUDbP/2rDYZV09x34GiopUJwhKkJtHeIce+Vtz6bO6iCmi1
 lWCqs2U8PG1wkDDBwAyYAdSYcZ5LLn9+w0hGD1z/nvzhMoJEU1MAJFFQqxRgyfghbV6z
 wN6zRHBS5oS9IsDtREca+W/053caHhBWFDBHa4UatWebpJf2K77BeYfI/xImYczlD9/9
 s8pqG6PbSnO42gn3vAO6drIg22siundKRt01dAzNiU4loTuMqexDCF8qgAEfRd42ov43
 H5EmCqr/tOoib+zrjrolkybIqMWPoI/ncsWUvsM6O+NdRDXTZuALwl7f7ivl0zP1ApqP
 OS5A==
X-Gm-Message-State: AOJu0Yw9pC7IzFnyhlRZBWfeSvO1CJpZLjZGTIXcgk93wsE/PYmRdyXU
 TnJ99P9Df59b1HqbTQriBKv5fiFLLrMJQQxefLdgAEmO/KGWVsKzjVEQVPeZvy3EV6RJTJIXjx4
 thAiuVWkIKsQOwzMHg6np3SNqJsTNhS95DZ8IW/mtBQ==
X-Gm-Gg: AeBDievEAtZp4uhTwIFvbSm4nIDJpo3TzNVbNhjo4dvwkNdPt6o6MzomQXLjIWybk2G
 IwnQFUf1bEamIsFRzR6zg51kWXJB7K8kgNW0rH12GoRo8byk1hDw88GLUEQu/Og1XMRPgVHZecX
 kVHGzhcP5f2GHTpLbNaGHtQvmGSSuuwUKqnRNNk8+BOgPL4ZieW299gvazVBiRP6OQaPxc3xgA6
 W6JjQJBPi96TN+ANJbkZgf4gWLNHVDOpK8amLu6QkTwiDR1c1+UEBbGUAcJerZe1SBHeoSGg2M9
 OlAwTedn0ii9X8KEl0Deg9v1dUZG+EcsIGNeO54BIuqNzHYt87YOFMoS7zmVjST7Gyv2sTMJFXy
 q/w==
X-Received: by 2002:a05:690e:204f:b0:64a:e222:d3fa with SMTP id
 956f58d0204a3-65310b4ff1cmr29494611d50.58.1777289178761; Mon, 27 Apr 2026
 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260423170229.64655-1-philmd@linaro.org>
In-Reply-To: <20260423170229.64655-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 12:26:07 +0100
X-Gm-Features: AVHnY4JKpg_C5wnQkuVyGK1Vz1-Zobn8go7bYIwEPNotdyrFKeMgQ5BIaEdx5zM
Message-ID: <CAFEAcA-fnfCOri8nKJ11z+xnOpfW6J+6DTOW11LxQW9Nek5Gcg@mail.gmail.com>
Subject: Re: [PATCH 00/16] accel/hvf: Assorted collection of patches queued
 before v11 release
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>
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

On Thu, 23 Apr 2026 at 18:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Various patches related to HVF I'm carrying.
> Some are already reviewed, some aren't :)
>
> Except the last one (RFC) I plan to eventually send
> a PR with them once reviewed / tested.

>   target/arm/hvf: Fix WFI halting to stop idle vCPU spinning

I didn't notice you picked this one up in this omnibus
patchset; I just sent some review comments on it to the v2
thread:

https://lore.kernel.org/qemu-devel/CAFEAcA9RHQ+7++=3DkLn2goJwcgzDnaqdkQtQBt=
xQ2Rw1-uiKY=3Dg@mail.gmail.com/T/#u

thanks
-- PMM

