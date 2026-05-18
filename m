Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68FFCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOznQ-0003EO-C2; Mon, 18 May 2026 11:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOznK-00037k-UT
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:22:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOznJ-0007Hb-9c
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:22:14 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ba6485d219so16824135ad.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779117728; x=1779722528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MDyk8TJj43mhdJJd4UgNSqPn2FIzSDXqbgY+ezz1jvQ=;
 b=d7dCLlqRVnp9A+s7cLowsu7+2tMhpJi1i1gNlLjKviLQpDJGksEbhAx+i/Y3NnceYk
 tzH5ONrAraVyXZOECkSFwrJhhj+ZUavinny2sCrsGHrh4hWuY00k/c/VnDjnYsdDM7zm
 X0e5bNKFSPxvXW9JWxLY5gLHlnqCWhttkP7MR1l6bytLitvtD4DZr4f0r3dVS5MJJTQm
 5Z3e1evnrUSH/fOfTky2ETVnaGV+BRPkRgcAf7R61iel9kjDRPwFAa9mRRSt9u0UPPJu
 8CH3o+0MoHibs1I4v9CT579zkHho4Wk7PKwjEnww02hcr9/0NvtqhfHIyeuP4ipySDLT
 4sOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117728; x=1779722528;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MDyk8TJj43mhdJJd4UgNSqPn2FIzSDXqbgY+ezz1jvQ=;
 b=bGPRzsF9T8uvKbABGacIlOUzfWp0jMQNNyH54XoDBlA3o09dcFHR2L39oQ6Mzskw/Y
 isJvubL6S4EkT8YybcQ7RrD3hxqtBQ+WrpUhAGUa4xQqBpe1gVl1P93ae660aSRJVx9Y
 P58QHjaF++O0JjLbH+pt+msCDj0jNz6TRLOiUGurV8kDO2A8g8nt8cfLZHrbBRy6IRfF
 FlfHVQKeS3TNckqXsm63zm0MK0d/xThkVOYkSs1Cjk0QRamgF65LOiilLlVnGBW7vVx+
 DSWgLw8uJua0AdZH6gFMcAqLyqMwVI8N9lthSGmUTmNEOJ4Lqqwid37kovybPn62L0dB
 kuPw==
X-Gm-Message-State: AOJu0YxWUSf3O2ip7keeiDA2lgs/eNFtktoOHgQZkDZrwHk3vz/VkN8m
 LYkNj2/3mvesBQtQ3qyzxrsO4dX42CYQUHgx2u+iV36f48xYI/Uk3FJ4NnbIxFfoqtR1Js6SKUJ
 lrqTHAKA=
X-Gm-Gg: Acq92OEc6PXD6WKZj+dHeR7ESjWRZLdRoz6g1KUnj/9cT2zf9X7FzxAN7HynkJVvG12
 1qfSqoXcg/KMKhJJ4P/PkqLUP7nHOfn/v2Bu+yd1wjrXroeRwiUqdtBw1oi+aTE+LyFOVensn+9
 uxJFWQsMWz+mNHD7iBUbGSoK2PBnXThZ9W267fdPDk6MJnC1PI36vRXfxeXdeMlN6Osa9mEVsKs
 Z/DSTLYOD66f/sYpqVOJ7ugTAFwPlcMDxZG3dsbkoaWR0/jzUFj2d2f8tjlrflDL+3dDkkYWR5k
 q/z55xQquKTHzMDngXzdvz8+P4Hhsu/9K+DcaY29/FzEF2ul73RAMQDy7silwe5TuUBLjB8a0NZ
 s89hV1n8rnxFgakW/YycKF9UBL8swx1s5FWSfhqzzKDZMz9A2Ulp5PafrSzU6xD0z14vRSz0lzl
 Yg0SMNgRQrhqS6b2Xo+/ziZ+wIXoKBs6TBJfS3
X-Received: by 2002:a17:903:13c6:b0:2bc:7d5d:e2b7 with SMTP id
 d9443c01a7336-2bd7e9a7de2mr176101635ad.36.1779117727730; 
 Mon, 18 May 2026 08:22:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe6512sm156592785ad.52.2026.05.18.08.22.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:22:05 -0700 (PDT)
Message-ID: <b1d55330-30de-484d-a4ee-8cfb7b267006@linaro.org>
Date: Mon, 18 May 2026 08:22:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/14] target/arm/ptw: Flip sense of
 get_phys_addr_disabled return value
To: qemu-devel@nongnu.org
References: <20260515142541.571911-1-peter.maydell@linaro.org>
 <20260515142541.571911-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515142541.571911-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/15/26 07:25, Peter Maydell wrote:
> We want to bring all the get_phys_addr* functions in ptw.c into line
> with the sense that translate_for_debug() has and which seems more
> logical: true on success, and false on failure.
> 
> Start with get_phys_addr_disabled().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

