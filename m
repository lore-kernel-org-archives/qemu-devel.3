Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F81CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIj8L-0005th-4y; Mon, 19 Oct 2026 04:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8F-0005q3-G7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xIj8B-0008Pn-Tf
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 04:54:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so20001545e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792400044; x=1793004844; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5tfUTlQFhkGksJXCCGfVpd5pHgp8SYfBGGlQdGV3Jw=;
 b=MxN69kFt7tmlNd7H8vdgViOEMtWyLcUDahCO8aEhfZbEaivurQr7JtkyJFP+6l+oA8
 cX5U3+yolTAQwYl7ihv3Z2WoBVt8hNlCZ4HNkNbpArjBx07Dng40jZjkua7Yf6qEBs3/
 v4JZC6Buls+yvyVKWciT3tnsa37HCuSlnQDKw9UUdNFnpNgFJljvRAD9J7teKelXB3OR
 ohwPhnNDBRFNg3FHJa4PBmkfelDjH5L9erXERUQpyA5Tyd0Z6BG9Pk1SrS0nMnRmj2xe
 hq0xqRhr2UPQOVhOd8zuINLbosiI2DYyMrQCQAWa4+UmYtgwu5FYkI6BWdLchklRmFMr
 Cn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792400044; x=1793004844;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5tfUTlQFhkGksJXCCGfVpd5pHgp8SYfBGGlQdGV3Jw=;
 b=LKTtlXGH0CQDug+74fUtQgFotZDIuGI4G30fW4Ke9FWtmbTnSpxc2qe88u21GV7MDd
 J3u/BL9KiLpVwfa1ezg7uoPuZcqCHy2z6wUnTnAWMsZpv+TeRDI4yivleTy27iTrQjIb
 vs6eU0gZ3evrFOS/gqz1Z72+pWjmDQMiCF8Qwos4Ex5Y4isdXXp4VF7opcF/A/b6+/IB
 Bqjt6AnUXcwDWNfxu7EFdcR/iFB0Vd/yux45NTLi609ZXZnpdnECCT73dvJNI9L6FadR
 80w2VLNPw0Zut9VoqxdtzaX4TtGLgnuVG9ZdqE01k3dlYRjEyPIq9KVq8GGUkhyK260+
 64Lw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFlh1FPuuyG0EJfY48pQ308AxNygEtz9npNMWVe+xgxIUWQR7Zpg35fB+r4QNxFpuv+1INuhMd0hmS@nongnu.org
X-Gm-Message-State: AFq9FYJggtalAoZ3Xu0i5HT9pIYB1hvYROoOB+/gPC2f9p4KMKyZoxKY
 2LyEr0CHEPYRgtjFNsnDOR9bTmrjUHgb3BrVMul0sXjLs1zXIaarop/AM1tn25jrrlo=
X-Gm-Gg: AYBFou0V/uzvXjfzbmBa1iLkq1UtO7o8enazFqIQRQt8P9NwuJ6hdspknGbaB2/XJAq
 SWdKE6l2hc20VWTO2BVW4WwndQVmCEpsP8nnjqfLACgS6ct7fA0yA8BJi449kKWRz0UnlONyEoe
 CPqS6sYmh4THtlqLBivgvTHE0mcI7wyPhM3i6aPdVFzwrFi1YpUrphQNMWdlU6Pm0VCOr7dO2+/
 sVFjEE7U6WZslXRc4I3veyRIKR4t4C1mbA5quN6ZAFVKvWPRwt0VJ4yYI2V+pk/VylCUvMzlkkG
 PAW6fgy/fXMJCaV5Q2xt/6jCLNfKNWDFFr9A6LRMlIw9+CzvRhXPkAw153iANPsx6EOAKhLpUa/
 JCO1gZ5BJf21qFgyi5C5WvQmTbMKLpAUAr9Vh1WjMteAUAt9UcThZt/M8eX1PGpBtpTjsdUK72f
 R1YEiyoDDPMdNnbf3x7SEGV133H7nDaPKexYyg+o96hJ2V9e0F0Xfe4yRilt7QshsF1Zc1LOz72
 zygp3kHiPZ2zhEgLXdf+Hnzo7xx9tWgW2ac5G0cdziug/jDdSxcTnnxbtv67g==
X-Received: by 2002:a05:600c:524e:b0:4a1:db17:c7e6 with SMTP id
 5b1f17b1804b1-4a1db17ca8cmr115601865e9.2.1792400044346; 
 Mon, 19 Oct 2026 01:54:04 -0700 (PDT)
Received: from [10.89.180.227] (cust-east-par-46-193-64-64.cust.wifirst.net.
 [46.193.64.64]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca30aa4sm118156715e9.2.2026.10.19.01.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 01:54:03 -0700 (PDT)
Message-ID: <43d72813-e7d2-4bc7-975c-bd7efa47ec52@linaro.org>
Date: Mon, 19 Oct 2026 10:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] block: block-jobs and bitmaps patches
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20261019065828.16335-1-vsementsov@yandex-team.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261019065828.16335-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/19/26 08:58, Vladimir Sementsov-Ogievskiy wrote:
> The following changes since commit 62c31d1b6aa8e255c528df41c51a35dec9516be9:
> 
>    Merge tag 'pull-riscv-to-apply-20261016' ofhttps://github.com/alistair23/qemu into staging (2026-10-16 06:09:05 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/vsementsov/qemu.git tags/pull-block-2026-10-16
> 
> for you to fetch changes up to 5689c59055e7652cc4b6ac0a47b6e48faad4d59d:
> 
>    block/mirror: inherit the source node discard flag in mirror_top (2026-10-16 09:46:54 +0300)
> 
> ----------------------------------------------------------------
> block: block-jobs and bitmaps patches

Applied, thanks.

r~

