Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C5AF9D0C9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 12:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCcW0-0000X3-A1; Tue, 14 Apr 2026 08:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcVw-0000Va-TK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:05:08 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCcVt-00043P-Lw
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 08:05:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488c21c636dso33082145e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 05:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776168299; x=1776773099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uw1fSUlyZLJQXq4DfFQbBLS5c3ny+bylAif3wFUdwy0=;
 b=diwlJfcUEWshGyYRSeMmutmlBZl2BUxls5SPr21ya50TsSppND1i9WBz/mZNFXZriK
 iDHq8lhwEit53bdf/BC03G0+1U5IMQWUBKZmSCtTbg2BzxBpXPf16Fk9apfxX8D11hHu
 c9KPNt05DWGcHjqf392r37BVUvejsbUMLaE1TSv67eMWMBvXXqNxKDddbJRyinZaF2LX
 vMM32NABH0VppxfgIYX424AScKXZD/gjUpN9XHbwafnPQNG/QAcXTaVUP+sz4MA1dQwu
 /gvOiCksBITPaUual4zb+LBcRXKSteDzidsNX7Cgww10A8DaYXaF8GUfxz7IRF+INNFp
 T7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776168299; x=1776773099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uw1fSUlyZLJQXq4DfFQbBLS5c3ny+bylAif3wFUdwy0=;
 b=H+DrvQ39nETQMVcJZdHceNpKYn6tuFeXVrGEO786VyzN/yrvpagepaFqVz9cr8HVwD
 aPLcoKTQQQFmZU18/EU7+misc26j7kht+7W2/jkIt0WMwEMnS6xE0L7q3cP3/zKk/H2A
 NG/1IfgUo8reH9bqPB32ypCzMMwCUFMOKfuW+F0nVHnGxYfAr1neJlkL8Qr963vq1p4D
 YPhrVszBijj0hWBQR669/YacwaPXn72D+UB/KimsbgjioInMKCFlXvQk4MWrJMVi0rgg
 qzJmyZWcAEpE+7oeMGMXeYGTFQgIHolILq8LgP6kSclTaVrss8Zm2l8oVz4MCyIn/yon
 V3dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ACHfoJeigg8YtvtI8WX62smVBcmUio4sLEVEzrywZnOKwLRrclUM9qRzN/zblFTYrBCSKOPCY2lUZ@nongnu.org
X-Gm-Message-State: AOJu0YzZ7LBsSdEJ2DykLwhe+bv83U37/XqU4CkT9EpN8W/Wv1/aEkcV
 LjMjz+XvTj+r/JS3yNJoU3ABeYS+ACgiLk8iCNMEuIOZwHq6ZXPfnFL+xsK9Xl5p2sI=
X-Gm-Gg: AeBDietK3PliS1n1OFYuS1c34g+lenDy9HyS4msn5aR1jJG0rGf/kq66H62JMCaHAT6
 ziiQk785wNuNJmdvP2xGpTxktr14gorn4doGcw905W7qCHGPaDFPNEH8yMAxekW6JNkHFxdJuz0
 nTdYXHsM5YPkCpFIutQuKnhCTcPTwQHxocNwgf2YmQbS7wucV/eeEKg/CCTFxVOxEDj/wLrsvTC
 V/jv4D/GLvrzcCH7e7jsmNDumPAryWS4/1WGdrVofGKm8Df91WFPrvg3pZxpALFXFnVhjBoKHCo
 PqKVg8uI8B4NgVv9glM21lJZyvElk4S1Ko1WFAX+jkVgVv/kjJKqpoQ696X3XdZIpXp+A7GcZ8N
 PP+avJFBnfS8QAM85XKepyVEs0T8pLeUkgci/UiJW3AaD6AqpduhipLHwuKfzc6rdz9myJ71VfK
 F4FPTn90Qr8Vwzl+X2C4CODqUyHGrKKNtzBvkpXEKus69AqvehjAAj1E8UMFOo+g9+TQ==
X-Received: by 2002:a05:600c:5306:b0:487:59c:2bb8 with SMTP id
 5b1f17b1804b1-488d68c3385mr234895335e9.27.1776168299337; 
 Tue, 14 Apr 2026 05:04:59 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede2ba5asm42744725e9.12.2026.04.14.05.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 05:04:58 -0700 (PDT)
Message-ID: <ee9eedaa-adff-45f7-8978-027c1bbc3616@linaro.org>
Date: Tue, 14 Apr 2026 14:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0?] util/cutils: Fix heap corruption under Windows
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-stable@nongnu.org
References: <20260414114033.2360-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260414114033.2360-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/4/26 13:40, Bernhard Beschow wrote:
> Under Windows, QEMU would only sporadically start successfully. In the
> G_OS_WIN32 case, get_relocated_path() first determines a cursor
> to the end of the "result" string and then increases its size with
> g_string_set_size(). Since g_string_set_size() may reallocate, the
> cursor may become dangling. Windows may detect this and crash the QEMU
> process with the following message:
> 
>    HEAP: Free Heap block 000000000499B640 modified at 000000000499B684 after it was freed
> 
> Furthermore, QEMU crashes spontaneously, even long after the guest has
> booted. For example, it presumably chrashes due to the guest setting a

(Typo "crashes")

> new cursor icon which may be a result of the heap corruption.
> 
> Fix this by determining the cursor on the resized string.
> 
> Fixes: cf60ccc3306c ("cutils: Introduce bundle mechanism")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   util/cutils.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index 9803f11a59..76a9442085 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -1165,9 +1165,10 @@ char *get_relocated_path(const char *dir)
>   
>           PCWSTR wdir_skipped_root;
>           if (PathCchSkipRoot(wdir, &wdir_skipped_root) == S_OK) {
> +            char *cursor;
>               size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
> -            char *cursor = result->str + result->len;
>               g_string_set_size(result, result->len + size);
> +            cursor = result->str + result->len - size;
>               wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
>           } else {
>               g_string_append(result, dir);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


