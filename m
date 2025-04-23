Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C151C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WUF-0005la-F9; Wed, 23 Apr 2025 05:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WUA-0005im-Ej
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:33:42 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WU4-0007TP-7J
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:33:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so45713325e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400814; x=1746005614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DZZs0y1TaJQNYxvZjM/6Yfy4bnaLAls0Q3Ge8QySUkk=;
 b=VTWcQcMrBQBbwicA85yYi8eRwpGo8W8NjrkDHM3ou8cfEDnzGhC7NJ0ykVGIXr5Qgc
 Id3ZiKi4zfdr024XdqZiea7/oKHNrdiqCQwbYc2NpRL6Aj8ZW41k4lQ+uWDsbQwjz3t+
 +19cg6cRJ960WCvbB8GixOs6nLusFBUIeDsf6+VdO0oa8i7CqF72xLwTG+O/kHXsGrPL
 Od90B3K5Z1HjZ5Hjj7DAuBcLPYNqnOGBKkfqSGLb1nsEgniRsdr5Ndb/6rwuynN2XDt/
 krbYjCy4e/0PhkKeJpj2eqOXUnUFgJhBKcrX7Sx845C7v77yO8ozhB22bdcqk2s9VCD+
 SKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400814; x=1746005614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DZZs0y1TaJQNYxvZjM/6Yfy4bnaLAls0Q3Ge8QySUkk=;
 b=iTUElXjyhR15Kk+kOmWz6fpJBLXpM82j9sN6R4nvl4rypILI6ul5VvBI/teyXLOyqA
 miOa3v8X7l52qE+x+8bXAAb3g0as7fWZNQE+D5DuVStJFL0bQjG1UNM7VIxp5dh1qrfH
 fFKUpXcwncuaAznlzN4GsFf2YyK8YopAUqOATZ1mOdLvhanCj8li7RyW423JnCUE1Qvp
 jwd4XfD9dWZXz/gUbjXtDZSX9DukFBIHLbXyWo63i+7rJ5paU73D4Nr2rDiPuOsFt6c/
 wUcNJvsjiiRX0cbOJNm0F1coEOn6KWBv78a1z65q84fKa8inKcMT68mCN+VcX+9izl2N
 Pj6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWe9DaGDoj17K14+ivS2chS4zag3oLRDguw1N35+UWZAHjjN5IPeM1q38/KrNnjbwr3ycKAi5sVzdsy@nongnu.org
X-Gm-Message-State: AOJu0YyRL6P5bqDRVYPhg6LeZz97lDMwpWxN+boLkBqNfr/CX8iyhFkz
 kwkv5oK3v7UW+m3eYX+bxdW11pP8pIUHmcMt8eVkdlhQxoVFuru14qItUb62gjU=
X-Gm-Gg: ASbGncszgsiXWCU1CK7OIJxC3pKgr41D2WfhWpU7Mt4UEvJej/tFH0ZpdWhYzMP9lCI
 KFGZ5CdXjcUtMHVdr9je8GmStgNnNU0fYYDOkwhr6TFwQmmg+k9JV561L2E7e4bWsggpO6sI+Cm
 ZMaut1aUh5LfD979l0jnDeNZTU7Uab68FwahkaNNDyAAk9xgvcehyj6ddsUNYKr8eV3ZFMVk2i3
 WhJYKmw65IF48hemq/7ofSzfNDPfswUxworeAR8Yc+lxwp4iPYcdl7XDar9wxJuP2lj5ZIirKyA
 1l9kwNHj3vtBF3GFB9nRZgAPBNVjK1+YoGB98jMLCCgv4ylfVmJ2zO9Y34IuIGUGfkNb46deb3L
 4vy1YP7kk
X-Google-Smtp-Source: AGHT+IGETeHRFR3lHySaPxq4y7ZZUbF4QcsrfS+S9oIp9EPCWQgG7YKguwyPzOAf/wWRkGLbIlxRkA==
X-Received: by 2002:a05:6000:184c:b0:39e:cbd2:986e with SMTP id
 ffacd0b85a97d-39efba26215mr18485141f8f.5.1745400813748; 
 Wed, 23 Apr 2025 02:33:33 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2f2e1sm19096445e9.22.2025.04.23.02.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:33:32 -0700 (PDT)
Message-ID: <ae3db814-271d-424e-b9d6-869d7e05989a@linaro.org>
Date: Wed, 23 Apr 2025 11:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 038/147] include/system: Move exec/ramblock.h to
 system/ramblock.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-39-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-39-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/system/ram_addr.h           | 2 +-
>   include/{exec => system}/ramblock.h | 9 ++++-----
>   hw/display/virtio-gpu-udmabuf.c     | 2 +-
>   hw/hyperv/hv-balloon.c              | 2 +-
>   hw/virtio/vhost-user.c              | 2 +-
>   migration/dirtyrate.c               | 2 +-
>   migration/file.c                    | 2 +-
>   migration/multifd-nocomp.c          | 2 +-
>   migration/multifd-qatzip.c          | 2 +-
>   migration/multifd-qpl.c             | 2 +-
>   migration/multifd-uadk.c            | 2 +-
>   migration/multifd-zero-page.c       | 2 +-
>   migration/multifd-zlib.c            | 2 +-
>   migration/multifd-zstd.c            | 2 +-
>   migration/multifd.c                 | 2 +-
>   migration/postcopy-ram.c            | 2 +-
>   tests/qtest/fuzz/generic_fuzz.c     | 2 +-
>   MAINTAINERS                         | 2 +-
>   18 files changed, 21 insertions(+), 22 deletions(-)
>   rename include/{exec => system}/ramblock.h (96%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


