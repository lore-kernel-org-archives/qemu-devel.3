Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0502CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbOZ-00076m-MH; Thu, 28 May 2026 10:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbOL-00075U-9x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:07:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbOF-0003CA-Q3
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:07:17 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7c0de780bf1so114573367b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779977234; cv=none;
 d=google.com; s=arc-20240605;
 b=kCyvMevU4wp9S67Fk6wzk+R7RU57pXU8id7AhpqpegdGTToH0ICMVOE2bFmOoo7p9O
 T4vyo/PdVhu/Ue1YxHhRIJTa9a+ph08+AjBL73hB0XZwksNxUAe98eLK5I9wWeQGC9Sy
 YTFt8qCexST23aOV/BHcAoJcn18zHDxrwYwTwuZjhQoYbKXdTW2PW/Gx307WMoeaOqce
 K/IxoNkfj7EajKDGzECfp/ra65oT494OenFtsfHI5naZVsf696eZFEK9pI/239erDzXp
 4aWFelEBbNmrc3QaNPakEtXC87OUWq4IpScXC+pt0avlH9ppdjjW5er55JotRZAiEx/s
 IiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LYReXnL8/JT1YFIhzytVzBrwfmVY7OdGo4mUDZ5tpew=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=KLSBXA65UPz+eZPo4c3Vp4SmLT4MW0jEgMDJBrVC34/wcLoikKmNtI3nDH+rHNzO4R
 oXafeRUrR/7emJJvsnR1u1bfAEQ6NDj+l1Amd+WI5SE0SzWXZOP0TH8lmXyZuxt9/51j
 YJiZ+AYWhn7DqjPH5oQuyn1dqIYDqUncTb882HCY6J8ugiRygh8NoixThLGnFOAr7FT/
 G8jSkZdC/lQoJTWqmImwlJgmek26HxEEKT/7a0Wmu7vFHFo5+7CFMQhonwrg5X8tJ+2N
 oYpeWPt4g+6KxRMgEu+C66kET3nO1cx/WkuNowCQq20lZ9sc45B9Z5JIO2TdcNCXgOO2
 28Qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779977234; x=1780582034; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LYReXnL8/JT1YFIhzytVzBrwfmVY7OdGo4mUDZ5tpew=;
 b=TyJLZMzQ3RewDsxQHaNDRxCgpwy6QooYUW4RIqv8RNtfEQedDZWUY6l8LnsumO4xML
 iUnKBvlGoalkwuYYnX2+wvcOOeqE38jFl69TLxM3HUOErLpg2WcdfEul0sjcu6twT0Iv
 oTwUfMm4FH7wZ+pTuKiVVTjG4W2dGCqpJIRjVIha5D6IqX8qEwzHdJrC9i5EFn3JhXg+
 jtDJoosjugtrL9aDtRQFaP5XHGORCNJlA6CJhMDDmZgv8BsIDZeeVOzXh4FntSSP2PQy
 bdy+WS1YL4HtqQ8yoEEU2VVLaACPEMkgLohxgCvJfDUnFgLNK4EY/xi2nBQk3uU+c5B6
 F+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779977234; x=1780582034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYReXnL8/JT1YFIhzytVzBrwfmVY7OdGo4mUDZ5tpew=;
 b=UNbrUVOS+R1RB8E3yW1Z03Wje8b2S4+yukWbugGMMvWedrNUcmpW6dae0zvdlNJeJ+
 U1fsqFaexwcja3keZWo5L6q8my0idtDIi/bi2BbHqAgWvmLwsSC297lMScSDgpf1Aem8
 D74x+1v+64TDtyB5lS2ItVPNoBzYZO9VQL5fg/hDhXphpMQo9GBLkSSmQ6KHu1a/Q45j
 alzL/4Vj/jIDmTh+BRp0Ek8gV0J0oxeMrMzcGPWh8QzECEyzu69IB1jWT71gR+8xPJJz
 Ts0GseV7BOgg5348Gis5O/NPIb7EWMVbSfeFVH85OSvzo1nu/VC5IS9IcgYwxxxE0AgZ
 cBDQ==
X-Gm-Message-State: AOJu0YxMoS6KVBnlUHryX+ttGqMVMSJFKv7wh0cVrs7faFH8luudcN+H
 Iq3129cKJdv0K41FKGbhruJ32dvaPEs6BFaQ/d6pRM+U44vEoYPIyMW+E9zQiQXee6h+OtLGC/T
 UqRXXN8YEk/Mm+0xAtWo+NDK+apN7fkaWTYzgcdha9uyUoogA4k6A
X-Gm-Gg: Acq92OGPxE+dPwy/kO7+hHyp8piJQWjAe0hlAAlq6/039t7vx/NSGOG0rdgUJtb1M+H
 SUUw1Rt2vXwEx4mA8YMEyQ1hZ3IPesPw56MlsWOq9nDZtvWY9GbKVBFWn1l6Rq/CD4N6LFHn9lu
 bnOJMAYk3iGzTlCaY4kBR/bG2aMS1T42BMxwsP36ldpd/f5HXWwMEBRPHBrI0jgWT+gasTKPZfJ
 TiNMRBzHdJGUWFCMBtZ7fQVO7gDeGqb+zy2YJbI3Cob976fHi4DQKp2mDcXi5Bafw0L8Ekyo6o2
 5srPGagR0Sct0bMfsIT3eJZtQjn/D7tcNrAtQX6vv5NbR3lVyDs9hVrDAIoZl244E/qwGm7MzSW
 Cjw==
X-Received: by 2002:a05:690c:4b83:b0:7d0:1b14:2ccc with SMTP id
 00721157ae682-7d33b449324mr298884387b3.47.1779977234420; Thu, 28 May 2026
 07:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260518174750.660258-1-richard.henderson@linaro.org>
In-Reply-To: <20260518174750.660258-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 15:07:02 +0100
X-Gm-Features: AVHnY4JPlaOvA9I-g5HN0Z0qoa7H7f3mrtfbUwVaunnPmlkigCYtYPkwfWGyC-M
Message-ID: <CAFEAcA9taamCZKHjDkchpNzs_sdOrZm=960gYizd6B17ukFLMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] target/arm: Implement FEAT_CMPBR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Mon, 18 May 2026 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> v1: https://lore.kernel.org/qemu-devel/20250803014019.416797-1-richard.henderson@linaro.org/
>
> Changes for v2:
>   - v9.6 to be included in Arm ARM.
>   - Reorg CB_cond to avoid argument ordering error (paolo).
>
>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Add feature predicate for FEAT_CMPBR
>   target/arm: Implement CB, CBB, CBH
>   target/arm: Implement CB (immediate)
>   target/arm: Enable FEAT_CMPBR for -cpu max

Since my review comments were trivial, I've applied this series
to target-arm.next and made the minor tweaks to them there.

thanks
-- PMM

