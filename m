Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BBCFF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 21:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wH7Si-00013W-F4; Sun, 26 Apr 2026 17:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wH7Sf-00013N-Fa
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 17:56:22 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wH7Sd-0004sx-C8
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 17:56:20 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c7b9f54d3deso2822383a12.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777240577; x=1777845377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLhzA51cAV76CIczZOdeT8EWx57iVov6iuRl7cypXdg=;
 b=WEnRwSYtwF6v8y9u70Bffv8+QwjIWfGZd74wtPoT3uAbv6w4uASQ00dg7Sc+vR1G/v
 5440Gmw9rMNBdHpLUJwvnKDpX+tCUVnKRAtrIaREDwcupAMi2XL+ix4KHoNbIKiKEZ81
 T/Pa9E0ExGzavI2xHzoIY+ZtrlysAUjpQaFNgocnLiLTED0HZvnRihpNkh/LCgk1Hdkd
 TqeljkubUyIv3cI7lyI5TFw0Gtd9DvIiiK3AC79h9LJlsmyQftwnDDyxFvGOPwYhcfQM
 JROOaECO64lxNV9W7wIQGY2U1WOC3NHR5/uPuLQIkINWcxEftciezih0Nm95vJKxu0hK
 U9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777240577; x=1777845377;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VLhzA51cAV76CIczZOdeT8EWx57iVov6iuRl7cypXdg=;
 b=mrLwnsiPD1lYN/2qoiuKDub5m2GdFRYnwU5Hsg5I9vd7j4C9QKbQIgz71dlC7OYEby
 R4YqdMag9ncmrr9M7DUu7QDaKzrczV9uHGXx3+a697KNvDp/8Apz3xzUiAO3ing9qBUw
 vRs04Mr/K5DngIsmv/ey2x4ZUsKC4V0GUy1NFU5a7pssE2xjh8EyPJ/v0RA6QJhZxWSh
 SUoJo5Ye9OqFl62/ZVIeM9msCJkQ8qcBlhe8CpL9oEgcujAV+KnFuao9XRN3N9v//Ewz
 J99cJRt6Q9rsz5cvSUq4eneW4DQz4ELNhI8ntnklj8Qnael1T+XYcPPJTZyvqbo24LKn
 cnRg==
X-Gm-Message-State: AOJu0YxqzqQRdmxwPV2pUa/BQNqnmf2FS7DzBIk4SQ8hNtSEkzqq9qGF
 FFiVIn/fBcdD4OUE7FkhXke//Un9smEL9KSSN4jewR/9+c/+zdNMPQ7upOQPnnkMj4hH8TbxW04
 KFHj7vew=
X-Gm-Gg: AeBDiesWzIofsHSZ/exByZb3kY1P+wpmm5LImSLG6zceqoi2HB5DE9d65P1etlSLyBl
 zjM1eEkI9ybH54lmdNwDWVEYndqbccldgy32e+kVNPKy6LbaB6rp5X3+FGwiit5mUnj4BR1ZMwA
 zU/pzIanbJAGc2uq7tZa4zQlRNCX2wS8Uvd5UuZW0GM+eIImbJ0KJkRENhnntJYTi4R/HDQegoy
 8pZjc/uiJ1ogXUAts/jV9Ldt78MIAde8jy6zTum+kx614jn8xSFhZVntP9b0vKFzYL0JTKkQ2qU
 eHyF1lHzrhzLGHiPpkKakb71+mvalOQWku9niFCQL6dDoN657zVBJtEhc6jsHkWlrWMR0WDr12J
 a9hJRRAZG34tG+eyVwNTYeKh7hT46gsnaCOEqpzDIE+hLwGFfxBswny5V80jzOt5r0XBL+yvNop
 bwQRzghXozcL/2rQeBPYWbi/GtjEnCzP/jhpGBfb3UEHfQIP0WqUVT
X-Received: by 2002:a05:6300:210d:b0:39b:a48e:6a77 with SMTP id
 adf61e73a8af0-3a08d8e9ce8mr45554290637.37.1777240576755; 
 Sun, 26 Apr 2026 14:56:16 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f8f3e5sm23675777a12.5.2026.04.26.14.56.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Apr 2026 14:56:16 -0700 (PDT)
Message-ID: <230b03c5-fe38-4223-9216-c22886e48218@linaro.org>
Date: Mon, 27 Apr 2026 07:56:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Flush errors by using exit() instead of
 _exit() in error path
To: qemu-devel@nongnu.org
References: <20260426144100.4037-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260426144100.4037-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 4/27/26 00:41, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Similiar to previous patch - ensure that we always flush I/O by using
> exit() instead of _exit().
> 
> Reported by: Tobias Bergkvist
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2544
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 84e110dfe9..86d04cca3c 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -975,7 +975,7 @@ int main(int argc, char **argv, char **envp)
>                         info, &bprm);
>       if (ret != 0) {
>           printf("Error while loading %s: %s\n", exec_path, strerror(-ret));
> -        _exit(EXIT_FAILURE);
> +        exit(EXIT_FAILURE);
>       }
>   
>       for (wrk = target_environ; *wrk; wrk++) {

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

