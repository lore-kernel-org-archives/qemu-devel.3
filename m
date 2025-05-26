Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43D1C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJbbC-0003eQ-4I; Mon, 26 May 2025 13:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJbbA-0003eB-JI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:26:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJbb8-0008JX-W0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 13:26:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a375d758a0so2182046f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748280409; x=1748885209; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVGHvn3Q0oUXdsE6xGz8XvF0eUBvZhy127Z32Aw5zLY=;
 b=qFu18DlX1gWBOagJfJValyy2uq0kDKVym4VcbhsY2mmAh/Djwqgpk08UC/ksXHy4qb
 fjqBc2k98+sJ0locI3gJxbhHmMmD5E9ZhZu/4PZpJP21xoarNUl2ZEogqbWWrUTtSUkc
 wFEmifkuG9amZYpmZcIRjVaAn4D8pO4a4EMNaPiDFzOWBbZdeuCasj6k2LA7YTE3Umrh
 8ZkRYCG6XOe9oMYw7Q3So6B5r2kBzoduXVInKGHRFzsV0F4zBT7ji2PJc4KTBAHO25iM
 rnle/VurSGSVNM9rcbRmFLmnIUmee0AZpM469fQxFQkD4VmhwwnCJgZC5Ki17suzrbjD
 xefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748280409; x=1748885209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uVGHvn3Q0oUXdsE6xGz8XvF0eUBvZhy127Z32Aw5zLY=;
 b=wLVLgHXGnId7CX1T/LfWP+U2Rwqb3OsXjrNxSlNCX7usY/1i1kfBugvVKshny51LJO
 4nU+AwKHuzrV2M7GQbG72RZnpVEHkCUtJnM3Ol80vchyWhxq52cVpCt0rxIamBk1xJSu
 +V/n/AJLfUT0Gz3qSYCQEy08RpjKZSmGyLCkHHJPbVQGWuvKYaCAhZwwTtkKHV1nQNfm
 25GHLolksd40ML6QnxlNlN4xJ96XDxug0wqw0eEKLuorfUjBd3/b083nxL7T9kgRoZU9
 tiQF2/Ar3cDZ6gozqZdJdbqwcwIpOujUU/MNSDq8Ez8hvopFLJSdTLo0JKQDu3bVQLgG
 /rWw==
X-Gm-Message-State: AOJu0Yz9HmLVp0pm1RrtxKjYy1HmVeO57qyn7KDZdLR1JgcJwrvFMG/K
 GarGFJBCY5qfYktGzhbgYXAObPLSxfJS7jyCKbH+jQGSAtjJB8e1tnHmFflSkyUilea6ARpKixv
 c3WME73gLrQ==
X-Gm-Gg: ASbGncu+8Yz3hz84LZzYVCp7lzT558K8rSnktMccYpb20Zo3fjj3us06tAhqDWr/I9+
 ilcCxjypMl+QYOfmfNIaCkMPwx/Av5/hTe1xtJBiqiVJXTgK1wOpYhrxQ78IfAI0DOyRT0+PS0U
 pBwc+CxfDIfbMRY1G4Qa/J3PnxMmh9g9BYn0YQZAOy9yr77K8FtZnQi2edChxbGZPy/DTL5pebz
 v/hRSCu8PbzgIOkDkojzUyYDzG3uIawYOLvvhPIJnop4HQNYN+zal4+96D2WiY9LZazsExusnI9
 jEuYAQDOLmnIJisT8piXBnHXt9uTI0y8oTsMbMLUO5PcW4eQVMe6CAVdRxyXuZS69nit3ak8Uvn
 j
X-Google-Smtp-Source: AGHT+IFZMgb3kMp09b6Z/BcApL1c3ExMWWTRuJVPLQZpGAWC6ink/VJhb6bJOleH5Y2LJobNWTnJYw==
X-Received: by 2002:a05:6000:2505:b0:3a3:7675:90c with SMTP id
 ffacd0b85a97d-3a4cb47b029mr8360406f8f.26.1748280409177; 
 Mon, 26 May 2025 10:26:49 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62b5dsm36302152f8f.55.2025.05.26.10.26.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 10:26:48 -0700 (PDT)
Message-ID: <314e21d9-042d-4a24-99f7-0269bf62c882@linaro.org>
Date: Mon, 26 May 2025 18:26:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] semihosting/uaccess: Compile once
To: qemu-devel@nongnu.org
References: <20250526095213.14113-1-philmd@linaro.org>
 <20250526095213.14113-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250526095213.14113-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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

On 5/26/25 10:52, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   semihosting/meson.build | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/semihosting/meson.build b/semihosting/meson.build
> index f3d38dda91d..b1ab2506c6e 100644
> --- a/semihosting/meson.build
> +++ b/semihosting/meson.build
> @@ -3,15 +3,12 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>     'syscalls.c',
>   ))
>   
> -specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
> -  'uaccess.c',
> -))
> -
>   common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
>   user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
>   system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>     'config.c',
>     'console.c',
> +  'uaccess.c',
>   ), if_false: files(
>     'stubs-system.c',
>   ))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

