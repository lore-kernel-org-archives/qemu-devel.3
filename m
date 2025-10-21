Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA64CCD1AB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 19:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBIHv-0008Vl-Kw; Tue, 21 Oct 2025 15:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBIHt-0008VJ-TT
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:44:53 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vBIHs-0006Cj-45
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 15:44:53 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c27e5ca2beso1617669a34.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761075890; x=1761680690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jaRudyjBUXlwGlNpgWwa4/6HkWfm7wxdXyApdf6ZJ+A=;
 b=a6IlFzp9kTHbslA1lxb1WhBJqC61RAD6gRVGvfIvK0Z9QgcwI9er+8pulY7qcQJPNH
 c5JyXtKZ4qIdOgshCsARpmxJOUqcVpkFJc0Xm6irHyF1ECxdPZ092TfF5VrbbrBpgAJy
 kzO4O6gxwYXBqNX1hlVE48Ja3ati0hxkE9xJjip/zesFBv/1jJ3D021pczeJIKhNl0ql
 bj06YUcfMS+rKMRKgp0HNI8g8Af35nPWUUOOfXEHWSTvRuIO5BcjiwGU8+CGipgzQpK2
 IL028anKLB8MomxkEiDFq027NbVVD6TfpzBZP7Rm0Z/7Y0A8fIMBEsT9mxTiI34lS9Ia
 1w6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761075890; x=1761680690;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jaRudyjBUXlwGlNpgWwa4/6HkWfm7wxdXyApdf6ZJ+A=;
 b=e7/OCcS1f0a7MFghMZMvChuUNqQqq5xcXBLFFbopUjzVkOKyJx3E9hyoI5eFJdJHVP
 A/qrYWjtd090Bi1WFICWs+zZQeo/UF2UQ7cFCbLeDgme2oAgkwJ7ZiB8YG+jVEUbRdye
 sL1voziuqEtTFVV1WJ5yRg4KF2EBdTzKIN6knU9mqY/L/umEg+AKrtz9ASqJ6MUfDO2D
 9dY7krYZ6arl93unGtYz01sSl7oCAdXPzJDJShl/tcLlN8HIEM3f8y1tr/Tpygu4laJU
 G9oB+lwlY5vYgJDtsfDmzu44Q+UcHACLBUHcGVrYLh3b2H1RJ+LOSHhtm3Kq+b0VMnKm
 /Omg==
X-Gm-Message-State: AOJu0Yyyfx4zv9hrEU41nqIyj1j0V7WkyvSoV0CDZe39l9uSHHwfbpIt
 sUFnJLbOA1LyHCkdWpzDnNknUwNaVv9ua7AdjBStTcd3saFOzrQ288l/+kCO4i8J8idYgE5Fqhg
 LYxzy
X-Gm-Gg: ASbGnctxXKhGio+B21/0PAhOvySEznuRtmd+ABvQFM5GgsNK8J+iJQ4wcaJniPxWdYG
 /fTS3DZ0LkJ1rt6zNBsW7Cz6ATfyTVdKgT5A+gNyivfX90ChsCk8Q7l2SLueBhJdqJapVc1I3Yl
 hJEEh+dalvMjaawpbDdiwdEuiKLJJjHTtpoUnZ/MtYgEq8ciqLiIPV0LkX0o9h0TZzyv7Islk01
 htXij8fg2gellq2KJiPhyvBMdYueepH1/lKKNdof/YKWDcvclGSo8hyN+ieL1oeVbI5vzGPKK3n
 1dmrBOFhZzqBJevQTFLfSmlwQi4eAbi2GuFEpv6qUHMiK8641bIElnPUqOoDd4NrfJRoFBykXFe
 aT+B3DpcWYjzqnyXFM2Bh/PNIEBkDDZCTt3ToC5ykDMdFBm6rdtZBZWTjjTPv9G0uZBrJABIJpl
 1fUVa17ifvn8OED3heXGKNpt2ZlhPDQ7VphrqS9tIQqf8j59aDtl95aW1k4fQ=
X-Google-Smtp-Source: AGHT+IHkeAunGQ5R5s+e0aa+n50w98lXa9N7XlZmbZ6meLu0nKtYz1dzGiH0ufqoG8U3jAoiu/fnVw==
X-Received: by 2002:a05:6830:719e:b0:7b7:6e45:7f2c with SMTP id
 46e09a7af769-7c27cc84ebcmr8631422a34.30.1761075889938; 
 Tue, 21 Oct 2025 12:44:49 -0700 (PDT)
Received: from [10.128.41.227] (c-174-170-192-123.hsd1.tx.comcast.net.
 [174.170.192.123]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2887b8588sm3907182a34.11.2025.10.21.12.44.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 12:44:49 -0700 (PDT)
Message-ID: <68c8d609-37a4-4369-ac5e-1542612371c6@linaro.org>
Date: Tue, 21 Oct 2025 14:44:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] linux-user: fix mremap unmapping adjacent region
To: qemu-devel@nongnu.org
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
 <20251011200337.30258-2-mlugg@mlugg.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251011200337.30258-2-mlugg@mlugg.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x336.google.com
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

On 10/11/25 15:03, Matthew Lugg wrote:
> This typo meant that calls to `mremap` which shrink a mapping by some N
> bytes would, when the virtual address space was pre-reserved (e.g.
> 32-bit guest on 64-bit host), unmap the N bytes following the *original*
> mapping.
> 
> Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
> ---
>   linux-user/mmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 847092a28a..ec8392b35b 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1164,7 +1164,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
>                       errno = ENOMEM;
>                       host_addr = MAP_FAILED;
>                   } else if (reserved_va && old_size > new_size) {
> -                    mmap_reserve_or_unmap(old_addr + old_size,
> +                    /* Re-reserve pages we just shrunk out of the mapping */
> +                    mmap_reserve_or_unmap(old_addr + new_size,
>                                             old_size - new_size);
>                   }
>               }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

