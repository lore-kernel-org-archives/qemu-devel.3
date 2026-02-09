Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E0BEF06ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpHCc-0008P5-5b; Sun, 08 Feb 2026 21:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpHCY-0008NW-9c
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:40:38 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpHCW-0002nF-NG
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 21:40:38 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso2488776b3a.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770604834; x=1771209634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LzBf6CeZnu2D6SYZnIQnuWZPT7rD/4F4hsIzRxwlMzc=;
 b=XdJoUkNsjieGfq/QnLFVR6mxZPZFj1bMNedK5DvhFWkF0f8qr0VIBJKA429Dn/S+ik
 sVJEwsRxfe7NsmYssGvAeJvSYTe3bsHt9XDpMKr2wByTk03orLaZZ51g4ZsihICYFRGa
 3ZZ8OdzvkHYARq1LkL5JSmqRcMkhs0mhnB+DRz52jBUFGPZYU4zfGerE4KN7uYyUmbwS
 kAt3dCGGGDyoxj6sCDja9BFxJC05ft8RU4aiYbFPYDg1DaEMRVLkb7K7+vpc2GUfMFtI
 rciYml5Qufq9KUvshWcern0pjlCG53n6XaZ4oSIktZUKmQ+RCbQB88c3oC+xOowUP/R3
 omJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770604834; x=1771209634;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LzBf6CeZnu2D6SYZnIQnuWZPT7rD/4F4hsIzRxwlMzc=;
 b=GpZC+Yz1j7Zj62SM7zOKqj4TdzkeKaZxG9icT0qi3rYTlo3bKlC0R7bgpSaFoS357G
 nQUWpyrROankyEHFksedJ30nSZ9365v88FV0jgFQrqh8QYwno2xw2GI8a6ve1i5xeg4a
 aqGw1qT3T63inAO1PKPVbZ9AWJMEixnP315pgoMngyH7FWgfbL6bd3SpmDwyZ2fv3fv0
 +pCIyeADcv7388u1ZELAthrDbV0+c7Lif+94RhlUVKRHmcjSHGO+PjbRJK5hFFiA+Dms
 pEMclckblqHT78ZVuuuYOytI0Jw/gNi0zoZVCzGZ3/j3GWWKhmh7wK14d+yAStASlDdO
 uB9A==
X-Gm-Message-State: AOJu0YzCoqfZMQsmNrNJJ+HCHeogQSBC7lg/qxywA+/Kplga6Ua5DYOA
 LkNRYDr/OZbf3xpKd1mtvNbT8W8WKeO0+B97339p8Q4ci6vPJdvVxzxNjETAZdGyl0ViF8GMNAZ
 LRNa68dg=
X-Gm-Gg: AZuq6aKEPcm7u4Hgd4koFT6OVaaLckqJJM4QvpmzjMKJsPPvqVVOzc0lzH0R8tDtOaZ
 VlkoQysOWSdXMY1P9SJl5C2ogZmpijaixZpGVqiOHX+soTU347jIuHRuWieoC2OfCK2O99VYFuZ
 7wy8rfy1TIiV5/UhRfS8X1JBii+DdSxgNmK3g5GYVOFa/OFKTs5P8jKzmdUu5FLzR1876FOh+nr
 nQjgHiCrX6GXoM+AWSZdIuSmndmgkuo1NukOfBIXyaNur5LadqEJ4sckBESrCtvt+aMGbgOzaxp
 pA7jAUEw6aKeKqRV5eTjXn/eG+8jCBiVflTU2uIPZ0OWtCfKTKD2QXYfWub3tzjEfuS8w1rfG34
 jlZQd7nNIYgV9rS9eRuPOQ5drQPXZZyf9qUim+T4Tn7+OPWsR8bElvgo41Fi1EOmZaWbUW45mLD
 k/onhjq6eCSc01Gs99jlRY2kMSBRGx4lX62ty++H3xE0Q4M+ipqmwkjJVsOnsSUhU=
X-Received: by 2002:a05:6a00:810:b0:80f:4667:a94a with SMTP id
 d2e1a72fcca58-8242d411a6dmr11515956b3a.10.1770604833645; 
 Sun, 08 Feb 2026 18:40:33 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824418b73d1sm7925036b3a.47.2026.02.08.18.40.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 18:40:33 -0800 (PST)
Message-ID: <0c061c9c-2ff5-4e78-82d6-7c0044a78ee9@linaro.org>
Date: Mon, 9 Feb 2026 12:40:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] bsd-user: Add miscellaneous BSD syscall
 implementations
To: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-24-58e5fcfdb84f@bsdimp.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260208-bsd-user-claude-v2-24-58e5fcfdb84f@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 2/9/26 05:26, Warner Losh wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Wire up the remaining miscellaneous BSD syscalls:
> - quotactl(2): Quota control (stub returning ENOSYS)
> - reboot(2): Reboot system (stub returning ENOSYS)
> - uuidgen(2): Generate UUIDs
> - getdtablesize(2): Get descriptor table size
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/freebsd/os-syscall.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

