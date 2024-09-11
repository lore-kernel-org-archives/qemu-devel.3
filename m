Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CF3EDE997
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE0t-0004Mb-8m; Tue, 10 Sep 2024 23:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE0r-0004CZ-0N
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:27:25 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE0p-000129-FC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:27:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-718e6299191so2151914b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025242; x=1726630042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7eODV1uHjgn2SlGVWkI/yPrh4k94iEPleJQ6XdqYt58=;
 b=Qr9m3ZJ99QhP92H5cZDBKXTiBHfT4te0CfAAL/x1fFsYGnt9l8mJLYs2j8qUQq7OMq
 LfvOWuNPyNccBO1ioPOZg7eKsCFu1ytfY1TIL4aDl3ZCa7BlD49gCIXFZILDxtS8mU53
 NmINzVNJvl6x8GjGEGvH5XiXH+wF+GCLy6oqom+Dm+BreEAasSTnb0O3WTOWr2ixaXIZ
 dR1YIqdCg7TzlnxkxLwhVFN6MT3CBF72lCohRNPwfT51YY1Wyb/N2STwZ9YkJ2PtLyxP
 ifyUIkJIS7hWZvsUMEIezipPZ8B7vYdfSPX+Nqrc9sZ2vM5oS5PYhEj7/zNt0gtij7Kh
 i97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025242; x=1726630042;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7eODV1uHjgn2SlGVWkI/yPrh4k94iEPleJQ6XdqYt58=;
 b=cH9WC8N9GqnqrZ14F4k7zCpDyasMMVF+ealZ3lSGCTEBIAK+Qd2lnlSJgMl2NSRqFM
 pNGYRvgSafuiXm1Swza/4KkdSZUlq1x5GuoDfLe/0SsDEyYF/1DgR9YnrWXo47yRC67h
 32JpkHhj3q8i/xUoKwcRe+g7bJKBNq8WN1lC3N0Yc8MJSwSk6f65gyIVfOhDYgLdk2QB
 CG9/GpUlPpZUqXFxtPyQUOyfY0cUwmyyrQOQaNUPQyjurzN2SA0+B8FDnE9EzBpLG/IC
 0r5KQFGMrZ4TLL0WtaoVxMMSnn/dJyiKkJZB4gqCBSASOhIFynsWGzMDHzuvIWOIIPeN
 gFpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI/kzVFoOP94XEipWkIXJU9lEaHjWqfie1bfsqoJjH92vVEq4RwlGdCcir4iJCSSGa+TRHx2ejYQkp@nongnu.org
X-Gm-Message-State: AOJu0YwyqEq6C3S48ROB37aFWbTNGRmJq8kcBL7vSpScBGAzLf+AORL/
 djbgNi6+4WAhAVAVA+yaXDx5dQsJpZUj96rdrz/s0L7fAbzezp6fnb6Omr/xj4F8YwXu/eAzJjt
 l
X-Google-Smtp-Source: AGHT+IG1toJLkqT+BsX+ht3WtbDQhWDabqJXRt/NFbeu6XLT4RaZzf3EhdHxE2Te9+Rd+XkRtSc1Uw==
X-Received: by 2002:a05:6300:668c:b0:1cf:38b0:57ff with SMTP id
 adf61e73a8af0-1cf5e198435mr3695833637.48.1726025241726; 
 Tue, 10 Sep 2024 20:27:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe29f6sm2054908b3a.67.2024.09.10.20.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:27:21 -0700 (PDT)
Message-ID: <73ac0f2d-49c0-45fe-90d2-729982a0f90e@linaro.org>
Date: Tue, 10 Sep 2024 20:27:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/39] migration: replace assert(false) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-22-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 9/10/24 15:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   migration/dirtyrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 1d9db812990..a28c07327e8 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -228,7 +228,7 @@ static int time_unit_to_power(TimeUnit time_unit)
>       case TIME_UNIT_MILLISECOND:
>           return -3;
>       default:
> -        assert(false); /* unreachable */
> +        g_assert_not_reached(); /* unreachable */
>           return 0;
>       }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

