Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9A5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3z6s-0006Rp-3c; Wed, 01 Oct 2025 11:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z6b-0006Po-QU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:51:02 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3z69-0000rK-Mu
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:50:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso68135b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759333821; x=1759938621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YfyB2A3RB3jVRV3yy3Pk0+tJLe1Mxz+E+eSv5P5PxQs=;
 b=rCgOUK5Z2eWAHnaTd+Ng5mpF+WY7JtsNAw2o6cOW6u/O/QqvQLc3HolZGFADiX5ZJr
 oPm+AvDJC+Iwwwzc00u96jNQCgSvX79DY5qz1NxbV3RjZ/NOUSDeg/US8LcI3fqBaN0m
 owBKqMCZ/s7kbHzcnxmgqVgBbKz/mpv59/Q5iQgQjUTcy3qKuX4tC2hRcCQFd0sZy6tW
 6aTOrrN3lQUTLl6CGAIly59QLqb97JpXIJP5molKGauArOtab0g2hD5iLEt8987SKj1e
 MQyrh9olerq/mLncsf03X8EINo6UXgKDJ12hJbClCtlF6T8y5rC4sh+Pp5u1z0BHYKcg
 jsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759333821; x=1759938621;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YfyB2A3RB3jVRV3yy3Pk0+tJLe1Mxz+E+eSv5P5PxQs=;
 b=vqBWEu/3klDm3d7wf+Wr7Zn2jHSIkXBAh9Wdjn/BTcI+xrqmTST0p7FQ6pgKGLEJL5
 3utJV1e/nOeRZeY4XHPaXc+p8srM2X73T6wWAF0DynBcSJSeixXWFLuyi6VVIjOTLUSd
 inLieUW0/yJBzhGsSB24F64tt4i2irTQDhQO1ZfWbL/yxXFfbG0CLurcGxyr8gvqWZG9
 pTN3lnF8dE5+8RXQ44psJaWX0/oxSBKAo6zTP2hHwMVHdmS7bwxooDe00bO60x8y0hMo
 1fTGVOBo2orjU0vJPkAZ/oRVivgwC8F/02M8ObTAHnDgzFFOrtOdQNqi3mmG7IRWVktF
 h7yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHEkdTsVnVww0e0EoV8l7DvrFKQLOEv++T7c9rDrfErRmoI0Uqv+iH02jyvYheOjM6xaaZaGb1IrYr@nongnu.org
X-Gm-Message-State: AOJu0YxUdNtHf+e+VHq3GSo+6GKfQFS7M2jIcahzZBx8O7pJnJ0eXW1z
 i2seGe+MojwIvHTVvj79GmdfpZTrKqnUreRK0PkNIGcc7y8/wTkpZI50pzeFknq1bRU=
X-Gm-Gg: ASbGncuSuQv+pkGxfV9n10SR34qMsk3X7W23DmZ9ZJzaoxKLENRpFzwL9IMVJhKWS5O
 a3uFZaNnxTfEYXV5SE4A7JY6Ogqz8WuTNbJpak6+2gI6wTXQU3cWcE2ArjOS4YluWO8u/2R+Q0Y
 Y/9KRhbdTNCJk0PPcBHA7pJGCSvzIf1D+FCMcXR6TIlqx4SmUpTKSzFaXjIW8ZqZy9V2NMBq9ae
 QYCr2z8G+x7i0QJyqJwEpjkugnMv8yqtopxM5AP+DZQm52Yzc9AgCjr0S17S/8hbQ25+R/y5jfl
 TnrpKUbRSVU3pyLIdc4R2sTJWqqKyVmh50n3oWwMjwZlmkMxSu9LBTq6S2EuEP+pYlzWasHffdC
 T1tA985aFG9on5OjGz7i1Z4UMB+91o4QnsjJ1XrqfDIGFjoaGRwE8Eif1O1zMPp/pgKEM0hDWJx
 UXH1xzo9l2caRbga/WE9HUHyIqI7V5swM=
X-Google-Smtp-Source: AGHT+IHl0NZFcm8n/l80eKzWzlUhLKTrqrukSb8xjkwRO7CHi5KIxAEZAED8rl4yALtmv1EQCd8yvA==
X-Received: by 2002:a05:6a20:a11e:b0:2e1:5870:ffb4 with SMTP id
 adf61e73a8af0-321d8452cddmr5746364637.5.1759333820878; 
 Wed, 01 Oct 2025 08:50:20 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b01fb280dsm92227b3a.34.2025.10.01.08.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:50:20 -0700 (PDT)
Message-ID: <64d8f612-059c-4171-b721-62f84e88bde9@linaro.org>
Date: Wed, 1 Oct 2025 08:50:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/25] system/physmem: Un-inline
 cpu_physical_memory_dirty_bits_cleared()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-21-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 11 ++---------
>   system/physmem.c          |  7 +++++++
>   2 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

