Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C010CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yZm-00042B-Ql; Wed, 01 Oct 2025 11:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yZj-0003tF-Ic
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:17:03 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yZW-0002Tt-Nt
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:17:00 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-5a218470faaso5539773137.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331804; x=1759936604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=njYBIx6z+d4JrX50Hvhl+QT9I1OTzkW9LgIGvKyp7Sk=;
 b=xzRmIZTBN8kuIh44XQgawn6Sn0tDMUlg7lBYddqVALZFxNZzxp4CyR3jTABkRUgu1D
 chLieSbxmKqgo4e15pnUlFioLQObWKnBUBaW2YS2VeuFj/fOm0ki5PWFiP9eVLlWJ9Wm
 OQAlnPyu2G9BrUqWnXIExUMGjzGeVK7PxsOY4vfIV9X+Pgp+xyE5UKmPl6bGS406z+Et
 F4NLNGU37CcqfTn0EFr0+S8byrDsOqGDy7J/8wmWpExSnexUTRGFaN6x8dJPd5hlUrUo
 TmFMa8HCbVaRFa/NU5T9m7uGT8qnrf2F8PDF7miBQQiLlvT+wNDRNGMmsFQwWL2WAdhz
 O59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331804; x=1759936604;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=njYBIx6z+d4JrX50Hvhl+QT9I1OTzkW9LgIGvKyp7Sk=;
 b=FsvIDNV/BXYkYfvXT6CKtwZSyMTvdd8x33eH17n/16F1t8bEqG/M2+aRk2ARkp/JpK
 D13MN5X8etk+jt2plNZSJ8JU+zLnOPpSr37x1gSBaTSdrDAFKgxnyI9khZGkR5IHenW7
 C9gwitibXK90Kx/vpUXlA9VODdMYuwLhARjnb+F0vISHwRWj85uLxDikWOI7h2NflQrE
 1ongAe/0w+10f5UEhGTYYSzduUX07g5xtUoyXQjJ2klziUW2hWAlkQsA1EboIqkpfkLz
 Ngx5u9YjMSVGdwrUNCBYsVJLF5vK6T4rJQhhImVE+8B/qocJGDjgWEj7y55Zw92JwcA0
 sUUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo2H7YI05GQIDytxXlj8xhFJ8C7JWRkW0GRhwLEaAFVElA/2s3X6xseYHr8a9Iny3px81UdFXeG/4d@nongnu.org
X-Gm-Message-State: AOJu0YzFax/XwyMUctIZZjGfRqAkfkjrI9nP/vJT9w13b9qkh+2V9Zth
 99TTh0jnXcP6TB4/vOg+o+WmREdOjqB9u7PXnq/6EU2XiEXE7cRU5L2GwRvWvex21wE=
X-Gm-Gg: ASbGncvHqQURxnLVJWjfYfzzI33iyC8dvTio06vo5a/JejTxeaJShhzw7zhiJAtn1wx
 sEll8ah71/leYk8Be52YZbUjcn2bATovLqWOsD641z19Ub3WU6G5TKLkZpYsXxj6WSUh9GLetF/
 aSwFe9LwEXtSLpgM6oOKdU/AWExvPIeWPy+7TPlNZ/Wm/JV0on/jpfdDD1AMh8/VdrrzYnZz4dR
 fmPlnrCdAdfMfQOnJxsF23+L6zAGv90qnJdSgYopd9wQ21PARxFZXijmMfb8dOdjsWv4nE19HX5
 C6OG6Ky34I0rqeZk/03apUeyZQlrK9wPPpT9HzKNrUwJeFNqnXS/xqOsgS8Y9GnWCyXrS4uK/LC
 ECLBtMBM0E3Z1M2zuvMLBz4uFc8jjImjJivWszTf2+McKsQqjRCtfwCqhacdxBdGvWkvP3z6bcy
 cWxNg/0ceNmlsRc9CVvJLEYAKwmZTYcDw=
X-Google-Smtp-Source: AGHT+IGILxOZtEq2IZZprQqvvDyntj+tu77BJa9D3TVTmsCLe1t4BGuIIMkHqDMi2NhtmlQIK16Oew==
X-Received: by 2002:a05:6102:44d7:20b0:5d3:fef0:9e77 with SMTP id
 ada2fe7eead31-5d3fef09f1amr1370254137.17.1759331803824; 
 Wed, 01 Oct 2025 08:16:43 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55cfd377asm173161cf.34.2025.10.01.08.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:16:43 -0700 (PDT)
Message-ID: <36a58de7-de32-4401-bc9b-347967914259@linaro.org>
Date: Wed, 1 Oct 2025 08:16:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/25] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_flag()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-vs1-xe2e.google.com
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 19 +------------------
>   system/physmem.c          | 18 ++++++++++++++++++
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

