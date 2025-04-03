Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D246C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0TkB-0001M6-Lk; Thu, 03 Apr 2025 19:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Tk9-0001Lq-Tg
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:13:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Tk7-0003wj-SV
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:13:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso1740350b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743721982; x=1744326782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vSRh9ciLiZERRTYJ6zqimg5jbJldjzZEngTZ7OexjA8=;
 b=lXOzkokURLpDfAGfeIXO8fAWjcRSUsUyxXSWElx/wB7M8ZN4/FFNkIYgAWiBHao5Yg
 7dKd+Yxj8alOA2F1czNMpM59OZYEjWzqcCMhGkEoOBMmEGk0lFw6jaPvjCsZH1xwk+Y3
 67r/sXxRUzmGTFAHjqy/5jb6Y3qPfGthIns5LZnC7p6Ev9hbY+yv10XiH/h1f74NHdFv
 TUbZBqz4rKn39IDbcxvpBitQWkhlXziNaAEbnhuW701UqvgU1u/y/Mf4o3fy3fuLVLW6
 bqwusmCljlWZSxfbC4mwotKLH/mwFcaAypxRrthNaQOz9P+peaYoxDfBDbso3QeEdPu4
 +G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743721982; x=1744326782;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vSRh9ciLiZERRTYJ6zqimg5jbJldjzZEngTZ7OexjA8=;
 b=UltIEk3UyC72R6xO9jgpuOv+9H4DoagE/uqfL+AHZC4iH2+VfNuf3Y4iGu+TyXKTSU
 OQQUPwMHe4MrgabFL/CdeJRuaRW6qgFBcgNuXgsC6CX1PP2isE2VzmYrc8zLvFURhFvP
 ObGv+kUHI9I0BZRnku8zdPScNipxM4Ya9/6Sg5e8bggEAgXJFu5nMX5k2X4CK2z2XKAr
 CPZXLLms/uVlarhEuahXf46QnZMkBrv6hge00cWRPoPqbUFnDN5ktCWclyPtyHkTyWOi
 MdyAxIX4AWO68/eMZKp76Db46u/cIfg/joJj4VgFH96/U8z73eUsECsMMgH3CrvgY99l
 lCeQ==
X-Gm-Message-State: AOJu0Yzg+SVswcvGfChqUrdX5bqd3hn9GTAejEqCYBVhTdSjJD53nuxT
 narVABfghSu4bmEHbIZ/yvTKw3r4QW6Mf/CqBf+4CmMw4RF9PVOHJlBln093VhRq8hbA3KeQ/aw
 b
X-Gm-Gg: ASbGncvvtEgwonxvrcK8qDS0Qj9t3eaGJHV98uSySDFmsiPORafR0qn17QHtx8ys0Nw
 GIdxjuDD7oBLXRkYXxcEagUNx3HigDbHxTTYzVsQLFVKo+uUSW5sshcwj80deqMW3HJaAn92Ddy
 VxeZ2QIDGVRstTcFWANuky1Jm59J2NzfzkyNr90CtEipZgT0Z8iS21XBWs1pmYIk0Dn7OkMOrNx
 SafxMVszlAsR+8PqnxoHxtK2rB8ewdl6nMhfV1vVWS0uyEMnvuFR1MCLniWeUN5OrB2hINjy7cm
 MRx1X6q+hJZAjPJ7JtX5O8+OGIRC82JDeXzAhHcUnQAWTrPoXsFie4/MszrLHHVp
X-Google-Smtp-Source: AGHT+IEnlOzYlpKKkofQeVPc5S2tS52aD9kZJHUm/d9njoKdGoQxHtJBvX42MDs61ohLhaSGjOaWqg==
X-Received: by 2002:a05:6a00:181e:b0:736:4e02:c543 with SMTP id
 d2e1a72fcca58-739e4b49bbcmr1682310b3a.9.1743721981756; 
 Thu, 03 Apr 2025 16:13:01 -0700 (PDT)
Received: from [192.168.101.134] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739da0e7013sm2134234b3a.171.2025.04.03.16.13.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 16:13:01 -0700 (PDT)
Message-ID: <78000846-b224-4b7f-b95b-bcfcfd700dd2@linaro.org>
Date: Thu, 3 Apr 2025 16:12:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/emulate: remove flags_mask
To: qemu-devel@nongnu.org
References: <20250403194838.103531-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250403194838.103531-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/3/25 12:48, Paolo Bonzini wrote:
> The field is written but never read.
> 
> Cc: Wei Liu<liuwe@linux.microsoft.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/emulate/x86_decode.h |   2 -
>   target/i386/emulate/x86_decode.c | 864 +++++++++++++++----------------
>   2 files changed, 424 insertions(+), 442 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

