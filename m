Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F7C55165
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpPsn-0005q0-RI; Thu, 30 Jul 2026 08:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpPsj-0005pe-MH
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:29:02 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpPsi-0001uM-5u
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 08:29:01 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81e6f2ee60bso10475277b3.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 05:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785414537; cv=none;
 d=google.com; s=arc-20260327;
 b=cwMe4ti2rJ4+aCaDOozQ83Kz575HP7wpStT4KoMRgybCjgg2LAhHA8mN4Co9fBWTXj
 4I5bPu6/LASYe21DfrLgGoxObBFccRd9xauoCVFsX61XyV54Fsf/s1k6YBQXmDZ9wFh5
 W9NclDd69JsmFxhyIYayOQ56H2j+G1/eCkw/QS2tpvv/YvyTM3DNUP4VYlichEg3B1ck
 vEw7SJ/1MOHCXpXDq6In4JOtX/gDNKie0Ep6jX5DrycysSRgF4fKQpUEKcJq2VET6NoQ
 lGYKWogrRi7W8RVsZu5zvRyVgURxbgK/4de7Xu1ewfmuumJmAyxtRic0JSOVMpFNjN7e
 2VgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QZvCRAOYx7Jmy32zGIW5M7L3b+vFulkwPEDTw/NPeRo=;
 fh=RWwcVw9W2H3ZVRYMXx33lzVj80iAwOWlXehQfCa1Gx8=;
 b=K0dX73ZdxcavBJDBErYqSKfuXaf4Gas3O672TNZMpMcJFQya4ooGpgrrmmW3Vsy5G+
 YDswehMm8QqmVN88KA6QVyKIri+zVoZdXfn3BgAyfRooFLhv3+aGO1rG1LVG7XhmjK1W
 w9gj0IOhHGcjklezLcQFC6QtBsqqir7GiDMLG/zCf1yQIJL3WjL9/iaFtBSDWFcvVFkL
 rs65ujb4k+zQgYxv7eZ5Yko5qm+ongZiENrltXVo+m7qPH4BFYvQ5saFUhuzTa/YGsIZ
 8+hx8+ToZ5Wi1AdGopQzPr8d3L3ZOY3m+F/NrZug3U9bI0Yik1SqgDqoYmJAV9Xr9g/G
 KWhQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785414537; x=1786019337; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QZvCRAOYx7Jmy32zGIW5M7L3b+vFulkwPEDTw/NPeRo=;
 b=OyFYPhYSlVM2esDCg9knRHEq/dEmHPywU3X0IHOQdYwqODdLUp/wzE3+0MOQmBqqjQ
 lleKrWk52HvL0d6oUKcw2NpCy1a9wUHTlgNog/H+FkeXPxrnIeqR/iC/mLH6MX4ANV8K
 uP+YfHmvjzmOj/Yhv1u7JlYfFAY98GfZQkF9AmTh+FTobFw11AUhGBSGAujAKKHV5Deu
 KJbxAlPDakd0CvhqGuoo3+hOrtytNRsuoxGsMASSShlUHm9AJB+47SwS7hIZ34Oyy8Dt
 7OpTZX88LPUTdblKPqGOgw5aItOmqF+/nFzASopUqMGEiAXOfWK0CvYTGKNqlL0TNgfr
 r/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785414537; x=1786019337;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QZvCRAOYx7Jmy32zGIW5M7L3b+vFulkwPEDTw/NPeRo=;
 b=f900QEYOhY5WooYu14+2U2aIdEL9DGqWPsbsaRaT3a6Zs73eZcIx/qpe7MPd21b6px
 OIJHNr8tTZSouJFIdkvGj3Tso5D08GefKi0Wfi/7vbrJrujM6Ql0d0mROw3k0QJdOhUj
 gezD4uPlSCiaLUOmydShSaT4Rd1W14+T0HLJg6On/p2Khf3nqw1OvT7S4o1rSKxzrFNq
 Jf5olNaCqDiusIkKu0DFDTiv0gX1It80HIJCQMZ6DSoWJfZoBrhV3BbJqLDeGHbZ49kI
 2U3+rC60xq4uuJHWF1MeLHDIGLiXWgBO7ZtkCq50TvIUbcCnGWxkyZn58XpbUKd+lRwe
 ij9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1f/UINM5nI1+Jh3Hep6oNmv7NEPUhsc+5hYKvMwrN2bBPRL0uKD4JMNHUQiae2oUx+OglYyNeB8v5@nongnu.org
X-Gm-Message-State: AOJu0Yzqsaj4Is6ueOEXyR2R/cux9MzekvG0Kc6vf/Hn/oylgfif+ESj
 cfUBoAvgZ7O5UhpfOtUeKTVZXfZ0ROpwS4tjS8NfPvdPNJ565yj1MWsOx/6OFMtvtAqBOIiznpW
 cu5XHHe4C7nPGwqyg0jOA7kMRKeQ39JOdyDR/4sLbLQ==
X-Gm-Gg: AR+sD1040WNQywrSn96cXVI4V3a9ZVWvM96Fcx8QyzbANgeS9rnWBpy41TMC9j+QAcR
 HwcOyXRbfWbk4cv0mSdSjXEiBVpWDUBJp90pDc9PVOYya9d/moUEcFMq8iiAnFY344lNyPhWXUx
 SQWRusYFyg07JftWXgIIsbKZ+AtPxIKPCfwUuzbA2SmTxDpqdsuiRigdmPmAthEvjvhuIDQPFUX
 bqrNOHtqWtsBnSbbMkqvJ8F3QgX1PWz0VwiYouMOeNcKSSewYlyfHrLsTTZBJl53zHTZnx5eS+d
 mvksKr2GFe7RtN+HDUFqtwkh0Mbh/lOl1mOkOmN99mIJ1clwIEV9RyXFYUSvyOdZtfVDkFX9YxO
 AU9ESGcW3hmYyK9xq7iJxJ9InFivc
X-Received: by 2002:a05:690c:3:b0:7dc:3d2b:2e94 with SMTP id
 00721157ae682-81fc17225b0mr1160337b3.13.1785414537543; Thu, 30 Jul 2026
 05:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260729231325.3808993-1-titusr@google.com>
 <20260729231325.3808993-2-titusr@google.com>
In-Reply-To: <20260729231325.3808993-2-titusr@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2026 13:28:45 +0100
X-Gm-Features: AUfX_mwI_IS-Mn2a8oByyTgSM13U4AxSHNIP4pfwReWSWAIpdNuxLntZ6e99kio
Message-ID: <CAFEAcA9Omor0pJ5LTyYbk-41W9b707P9t1zATPto3M=a7j1Pyw@mail.gmail.com>
Subject: Re: [PATCH 1/8] osdep: add DIV_ROUND_CLOSEST
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 imaginos32@gmail.com, wuhaotsh@google.com, philmd@mailo.com, 
 fanjason@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Thu, 30 Jul 2026 at 00:13, Titus Rwantare <titusr@google.com> wrote:
>
> This is taken from linux/include/uapi/linux/const.h to match the driver
> behaviour when reading sensor values.
>
> Signed-off-by: Titus Rwantare <titusr@google.com>
> ---
>  include/qemu/osdep.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1ec5b42230..08f87c9d61 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -522,6 +522,19 @@ void QEMU_ERROR("code path is reachable")
>  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  #endif
>
> +#ifndef DIV_ROUND_CLOSEST
> +#define DIV_ROUND_CLOSEST(n, d) \
> +({ \
> +    typeof(n) __n = n; \
> +    typeof(d) __d = d; \
> +    (((typeof(n))-1) > 0 || \
> +     ((typeof(d))-1) > 0 || \
> +     (((__n) > 0) == ((__d) > 0))) ? \
> +        (((__n) + ((__d) / 2)) / (__d)) : \
> +        (((__n) - ((__d) / 2)) / (__d)); \
> +})
> +#endif

This is still missing the documentation comment that the kernel's
version has. (We could also mention in that comment that this is
from the kernel and so GPL-2-only.)

-- PMM

