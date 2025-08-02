Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F1DC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ3V-00083e-GL; Sat, 02 Aug 2025 16:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ3U-00082P-ET
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:42:12 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ3S-0006PC-UR
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:42:12 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71b691a40a8so20507307b3.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167330; x=1754772130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xwdnkQuBlo41wL9lSgcfGYq8ZCMrSFo+v4ydwfMswSc=;
 b=ZuXbtxSL82bp+I0zZAgrADJu0rWq945QC0nYEO/wpCSTP+4wMv7h+yPI8CFox8vIDi
 bNqRmvHHDvhjrd0oDLGbbVh4YRAp1WWCSxRhlOlXUP6OT5+bu0W6YxpezKgGwscJkPgF
 iRHRIWuY816IZ2xbZh20LA8c4D0gWO7aXTTCnCZq8wsZkAoKm+702wJ3hQsDVFU9iqgQ
 0U9k/r6lJhaeZnXN+S+VuDvA8co84U3vtdazuqMedcTP66cEAvXh1V5VfYzI1z2emLxr
 e2Yps0KELZuIEBdcIB97PZMVucxMB63dKmfz05TZjBqzyZhwgw6Evai9KpGGW+ise5h0
 6zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167330; x=1754772130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xwdnkQuBlo41wL9lSgcfGYq8ZCMrSFo+v4ydwfMswSc=;
 b=hM90r72pe8JCl2ECSL1NM3V/mrDttA9q1kW5EDJZY0l2Rfn3Lwfau1jl/rUnKLLsWX
 3U/VWbeI86/ZtZIQlxqEinEdLa1FORKciRLrmt1+tkspamOYWi+tv0mL4LE3jIPZwHvJ
 X4CG7th4pf5rMfEhhfwiJCcFbTCmvU82j/QU6BNs4pEXuJSjWkmaJyLrqG/hu8ucXKd/
 mFbamg0AQshhOvgzz9Ji/GbzHKXkzL01xDG5RRDrLP39nXBpnoVmQcQeTBKgKyB9rAHA
 HN4qgXDZiFA7VF0hWOPA9ad/bQG+JmIu28WfKS6IayAEjAFCrVqgz46dUgBR5pZ9BxQx
 HO7A==
X-Gm-Message-State: AOJu0YzSKYKqfEQpzQxEAd5tf9NfidHi4fF8y9CPMIuH+I5qCtGYx/yX
 VRpQjqkaRpAIJWxyNTiyO/4rRNMlwcO4Q0bCiayBGRQc0YWRQynrFEAlNxXm9d8g1E0UipvHGrP
 Alzet2KMXBgKNqJOKq94I1TkA1299c1RQpgH1RmK+uQ==
X-Gm-Gg: ASbGnctnFFSWqXw4cbZf8bISov3VFkCRPGjNORc5M/O8l0UyCxBVHuMwFxw/OxxSy3u
 K1Wh87CncRggwbSqZwUBbc3iI2ixrPt5PHmzFlhVhSBkPpd1hfxv0UWfaxAnFgXygAgowjV0szp
 KHluwgADk4Yr+EJFV6MBKCXkslQWk9Zj6F0PGxi8LO5UblSFCR3lw9iPLofL22B8jNHUHM+N2nY
 utaGnL5
X-Google-Smtp-Source: AGHT+IF64ijk8jIwqHLqYZGePPRR+ivDnJsRApL/MHiL8Ur4UgOnekrxk3cat2Wm8tIsX9rHWBr9iDKge2BJXac3lLI=
X-Received: by 2002:a05:690c:d93:b0:71a:8c1:fc8 with SMTP id
 00721157ae682-71b7ecdab07mr77177337b3.2.1754167329823; Sat, 02 Aug 2025
 13:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-86-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-86-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:41:57 +0100
X-Gm-Features: Ac12FXxt_jj9wccqWh5WARke4zU8WhwV3AdHtmeGel9QlR2yy9drE8s9y0F7PGM
Message-ID: <CAFEAcA-roF0i2jDX8AUVKpYTQoUkJbaey+1x6YHfc=CzXm9ZJw@mail.gmail.com>
Subject: Re: [PATCH 85/89] linux-user/sparc: Move target_pt_regs to signal.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Wed, 30 Jul 2025 at 01:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This structure is part of the sparc signal frame.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

