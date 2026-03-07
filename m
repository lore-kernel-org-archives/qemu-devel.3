Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0DCFC9EF8
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 11:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vypjg-00027O-PE; Sat, 07 Mar 2026 06:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypje-00025n-F0
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:22:18 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vypjb-00054g-14
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 06:22:17 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ae222d978so9749025d50.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 03:22:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772882534; cv=none;
 d=google.com; s=arc-20240605;
 b=lnmM9UJqc4qMh+W5sPmRVBMbanXX1W4MSkDvKdASwFB6Ve71KX/vzwmiofLjkdxUVi
 tNX1i9zKBqvXLJvVsaCIhbHAmUvEVwfv0jkbmDd6l312EcuxLFphGltr90W/0COf7XvK
 i03PnOrHmT89Z6H/jwlvPmq+HMaENa1Jf8HggPw9bJ4J0Eft+3MjWcfpGLDcqy+Dj7iC
 SQyqJT4YA/xdbE/hDgcCZL7HWdvGecStRaJdBOpajUXu7XGfGuU1jj3sXaP7JMFBBuE4
 99BcA2tXpZng6S2WbTOFF90rvTGpu2uUModhsudWddAlbF0QmZV/YPiOE/5s5Qk2ot52
 xCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cA4JW92ZN7MjCnFvNCCHGXR7yLpUlUxElD35nZpVUJ4=;
 fh=tpRpQy4pEFNHzlr85ibgFGwvzqttglUW5jtcMPpLvPU=;
 b=DBifYU0YcLW56DVnHz4e1uM/Q93NJbQtQIqVukkth01xquOXQQ4Eimdmw/tmDwHTZ4
 eck2xhA1SoPHw4DFaWyaEkO1TfPEbVQlR+q8WNevvTSRl4LTcxG5X0LIzX26GvtyxNze
 vGquwXEbCuAi4LnhbEnMD7hxtHcKtuMJAbrTsrbxb1/5N2Xvey8UsgDWxlHNEuFHeGOI
 PvAVu4MgtSNeHVO1ilwaZcaDdBgiiS1JHR3w/NthY9/iagRjkaFnyhbPg9kTQ6JKNgMh
 V8ozUE2xrATdyg77TBUC2IXq9nmt6FcaVX2QsyDLXAof3MjRmbGY8p+KSnf0SoeAAedk
 1hjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772882534; x=1773487334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cA4JW92ZN7MjCnFvNCCHGXR7yLpUlUxElD35nZpVUJ4=;
 b=xe8rIiDUgnUxyNHiG1LaAc/It1ImOnGGjEw8TFD0NPvwrylhnv1gDwxc2I5dp9Az2V
 t6BHxryWXZtom/d+rXVguxPRPnE5qN+fgeh5jo3O1mHWRX9fgE0WBRvuivrDUShzenc7
 ZVkxR0sYWvz92xwdwPTSDDSRRxL7QIPRJdURMC2IFereHJwObs+r04iJRAKWBLKl6EJC
 CEfMMR86nVzNKJYOoCUde+BCy/lx9eS6RzfRqwPpDQRJXyT1JVYYIxw4qm8BqTlO9fuB
 QElwGCbUpX4NGE1yQXuqrGoOtUinSyOS0tNugMW5lPWLz2Ve0eTVEQHdpjxpbycCAvR9
 Nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772882534; x=1773487334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cA4JW92ZN7MjCnFvNCCHGXR7yLpUlUxElD35nZpVUJ4=;
 b=sG1I7JRa6ZVuDH7WLLravt+YnvN3f3mnKsGwTJg4wlpbvOMRS+v2EMjFcSpWZ7hGAn
 HbAqBZmCtvquZz+WqchwGAwLTVT0V7HZbjinMi4cqJ/nD5ZtU+2RS4LL4oDquiHCAIn3
 8z5bgdYeA2wj7nWqxI6wseEGhQU5orpAOeHQjdHLphAMbmtK0/TqL8TUVH5RiGGyVnj9
 HsJA81eCahLa/D9xHnZIQd9a+hEobSNQ4p5Bn5bx3UqS0FMVxSZ1G+sAWt2/KeWuo44+
 BH376wotgmGYslHQOGkR9LFpoFWPRHT5Lo+fo6Zv+SVIfCdNX+D9hD2rhcJNs2NKN9HV
 34yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVusBrSsG5wbvECKmXS9OCIYIsQ4JuzGCj7OdDdTrwbuFAd7g/bpJyuo+6MmQ3/9xJQRgdJ50GR+l1Z@nongnu.org
X-Gm-Message-State: AOJu0YyPbyKaXGFl0naOTlYAe/o6puiCH9whjchbmfX5JgBVIMd8UmIr
 WS42acsPunTA68xUA33+gFAJfNvnY3cNe3imDFx2isjDW6K6jCtynY4/bswRZCshz2yaIhcgKPQ
 FHGltfxEfI8+AgC9lfZBdDJzhsDXDY0xwvNIKWRfzoA==
X-Gm-Gg: ATEYQzxpk9vPBRBa9XvajNGy3yoL+eE6o464J8mFeOrFVJYO6SLPUrwgRRDWBSJl/9U
 9wY0YRgPZy74IwPX7rjWxm9CRYCD9sBe0r4RQFRQoxN+fm7Ix8BxvUFU+Qc/i/vsI3drWEC9mlb
 LRQ7SLdZQkehsQKEHm4zJXTTzlHqhXz9ceYOLaIkfVkREtcMLh9jHKCgHkuyiiS6elESSw+pHBh
 qVSG3CX988hD1CISdAEoFM4XceeXUARApWagjUomkjISADIV+btSb6alQ58PACINnNPAkqEuWG/
 957G+hG+/969PX4EKo0tv2ZOLqvMcdK8jnYt9x931XOnd8uYXuc4kb76onB+k2vsTlxNaop5rqz
 21g==
X-Received: by 2002:a53:ee49:0:b0:64c:afb7:4ae with SMTP id
 956f58d0204a3-64d1439e912mr4202822d50.83.1772882533678; Sat, 07 Mar 2026
 03:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20260306183705.410357-1-kwolf@redhat.com>
In-Reply-To: <20260306183705.410357-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Mar 2026 11:22:02 +0000
X-Gm-Features: AaiRm51-tA2q3R0dWXah87c-FiyWy_PgZlCKlE7zPAo1MGSRJEcMPw4TTGyrQPM
Message-ID: <CAFEAcA_MZhh=wDhhj3ww_N4=YQEnRX1iiX=ShvX2LeXgK+oR+A@mail.gmail.com>
Subject: Re: [PULL 00/12] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 6 Mar 2026 at 18:39, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9:
>
>   Merge tag 'pull-request-2026-03-02' of https://gitlab.com/thuth/qemu into staging (2026-03-02 14:01:46 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kmwolf/qemu.git tags/for-upstream
>
> for you to fetch changes up to a844ad5da2d0d16bab819c6b50c9cba0012ed202:
>
>   iotests/244: Add test cases for keep_data_file (2026-03-06 17:45:16 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Wire up 'flat' mode also for 'query-block'
> - Never drop BLOCK_IO_ERROR with action=stop for rate limiting
> - qcow2: Add keep_data_file command-line option
> - vmdk: fix OOB read in vmdk_read_extent()
> - curl: fix concurrent completion handling
> - nfs: Fix deadlock
> - mirror: Fix missed dirty bitmap writes during startup
> - throttle-groups: fix deadlock with iolimits and muliple iothreads
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

