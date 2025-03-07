Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479CEC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaFp-0001A8-J6; Fri, 07 Mar 2025 11:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqaFl-00019a-Sp
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:08:49 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqaFj-0005ue-U6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:08:49 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6feb229b716so18968447b3.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741363726; x=1741968526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oNYTeE9ZWn4D3E5FlK9DC4Zjn41RGFHavasAyF51jr0=;
 b=pdRQhfGgdb9RJPq0K7NOTEHQUpPtH/x/dldC15kgG3QstTGWLSY6akzQ9Xkv/NkqnK
 wXz1VgRX6mGa86laHKSLSn63/MRlbEFoS5lrk+QFQKLE2+7EZSr0vzEe26jHMFgLrgLl
 etWC0ZdnDHrQHsl+Ukn5y8+cE+icit76SMhoD/4I8Vc74kYMfoCsWofmYc3zV9+25qs8
 x7WSFlihckC8SFQewqVUWdhD1Cy5zK8hRKNhwT8BdUAppWylE5fVrbaQYO2VlKSVkZqs
 GkeLhZ90XI2Fs1mFBnl6tXL+bvy5hgVMxCkhWNbAy555Jo5HLcEOoWmoUInrAzxrfZBn
 p3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741363726; x=1741968526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oNYTeE9ZWn4D3E5FlK9DC4Zjn41RGFHavasAyF51jr0=;
 b=uUbOt5p5a8HNSi524LLztbyHMMG5Jn5OcI9Yhib89S7KLaGN0S2sclpuyjiM2Q+ugu
 DiEoiq0oILL20eKw4Jl1KCc0y7md6TNN4la4XJo2aW68axepohBLIw9Izx/8lcPiugRE
 VXkIs6qH0tn6NefkaZPwgzC0a81qvVpgYq5m/XUw13R/elMMwgnFyBCDNnjD94FjZU+r
 k6BbA5OuBMZMUJfzATDPibDVvxe6cC0+JYHLCA+ZLTJ5L3QPb16fbhXR+gw6ZmuAXLZO
 MVCSklZEvcTvMT98GOExaDgKChjs1vXRY9hxcRAlufGMEtsZk3wfkW4bbthgzepYEUOm
 F5hA==
X-Gm-Message-State: AOJu0Yy9vYm9a9pQV4M5JJDQt3mNRzhCcpZZ+OLbYnHrd98A/Tq13ZbE
 xlyYvgZIcv7VororyrQMArsYBhUGJyqI5G6Shc7iJJ056PAkIDYfYNrMGkT5X/c2JGUxr7o7J9H
 0
X-Gm-Gg: ASbGncvIJ6LLtV4j+Sail1wnusQMX8I689qyvIuYQ4F2a/geEOkmBSMvVUtCy1YpHrN
 fRa7VKhpvu7OxqEOg7dizHn+j38DYiIZ2ojh0hS0Tis5KccW7FCC41m+8qadx+FSw3eGJipOr4a
 qa+Osbvfg4rgLCNFSvWX4i9s57uGZEUEWDZLHh2q5+ZKxzdLpb/LB7flRIOvutS4XHpGq+h9Bj2
 v1LX+yP4OV4gmgZDvVvh1gr8zhK5azQwjfGlp5b8/E80TXoV/kJnEAnGaMn60Q8Km9b6voYTFKv
 87ukf3+qK8CZWylydqyba0Vj5UIniZ+3n+qs9VOqsPnvU65bhbOkCxe+/6+UrArdnK2j016HAC0
 P5L9DZij8aB9NS/ucu95OVC4umeM=
X-Google-Smtp-Source: AGHT+IHTVImvxg10OazxJYwQTquRewo8AowfW0rD1AJbi0rkPvyLnsI03ZdFwlTkAyJM0bI/Wi3yag==
X-Received: by 2002:a05:690c:c96:b0:6fd:a226:fb24 with SMTP id
 00721157ae682-6febf2d5d54mr56829657b3.10.1741363726567; 
 Fri, 07 Mar 2025 08:08:46 -0800 (PST)
Received: from ?IPV6:2607:fb91:1ec0:4c05:eee0:848:a879:417f?
 ([2607:fb91:1ec0:4c05:eee0:848:a879:417f])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6feb2a8f963sm7735857b3.65.2025.03.07.08.08.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 08:08:46 -0800 (PST)
Message-ID: <3792e6ce-3dd8-41ad-bbc8-313fe4309e2f@linaro.org>
Date: Fri, 7 Mar 2025 08:08:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
To: qemu-devel@nongnu.org
References: <20250307130951.4816-1-philmd@linaro.org>
 <20250307130951.4816-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307130951.4816-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1130.google.com
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

On 3/7/25 05:09, Philippe Mathieu-Daudé wrote:
> Propagate the alignment to mmap_find_vma(), effectively
> embedding mmap_find_vma_aligned() within mmap_find_vma().
> 
> Since we ignore the alignment in do_bsd_shmat(), leave a
> FIXME comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/bsd-mem.h |  2 +-
>   bsd-user/qemu.h    |  2 +-
>   bsd-user/mmap.c    | 10 ++--------
>   3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index f5ec0de24ca..87219da2919 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -372,7 +372,7 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
>           } else {
>               abi_ulong mmap_start;
>   
> -            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
> +            mmap_start = mmap_find_vma(0, shm_info.shm_segsz, 0 /* FIXME??? */);

It's not really ignoring the alignment, but not requiring alignment above page size.

Traditionally, the alignment for shmat should be SHMLBA.
But in current freebsd sources,

sys/sys/shm.h:#define SHMLBA      PAGE_SIZE /* Segment low boundary address multiple */

there are no crazy broken old architectures to worry about.


r~

