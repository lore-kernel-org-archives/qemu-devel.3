Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E0BFF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC8A-0003fe-1n; Wed, 29 Apr 2026 17:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC84-0003HY-0D
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:07:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIC81-000427-SP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:07:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b2589c26e3so1620305ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777496848; x=1778101648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LjS1vnZQm0ZoOJPdJwKVJRdnYKrGCiXMt+6uMj5ykEc=;
 b=mgjf4k3hWPxyr3QOVs+2LmihDpcMy7oWS7GKS3UH7amrMXPgUdPC+idVxR1bVbv+RT
 Q7ameLbYOuXPpjTnUx7QLHDvfUNNHskjs9xXv0GZGegJ8snjhIVikgiX9/6wkQki3xQm
 Oeo7MAwfYPQofI7PizWs2Q663awp+Z2CNXpF77PgI2eJ3RMuRX2ttTI15ubYhaROi6u5
 4BkkKEOSXuDBME6jTdAJO+bHcH+eosfVdjB9lWYmNaJj288ak2NDz3V0bwq+uCcfD3oE
 A1p6Hx4ACdjEbJ6V8ALScSLx1NynaBZIXdW6RnpVIOM4RLKtU9esLlr1IuKmq4t2BifL
 uYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777496848; x=1778101648;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LjS1vnZQm0ZoOJPdJwKVJRdnYKrGCiXMt+6uMj5ykEc=;
 b=pqP4f6PyPMBlqaAYZA9BGwLC4OnIlCJKHYMAW+h7jN1MilzMllLMg1bvuiKhr932Hf
 a6dB7wi01DydIdR0K/9lkwEFX30KFuljVNgz8r7xt4E6RKlhlymQnU5GDvWA3uchgR7C
 ZDS7pG3m3M76EV7yEO6/+amVmX5VIx/zcH6YVHMH5XcaqQLFFKZ4155vHu7/po9IRwvw
 ZGtH+8oOWz5fQetjNW8X0wjkIYuok66erSW707PFNFxnqKjSJFN46HvrnEDQn7Dvgc18
 ouSii6DNxfwxsg/HqJtWGorlVcSXwigLN28OdcRC2myycNmfmFt75dNzpTp9MnalZnBJ
 KC3A==
X-Gm-Message-State: AOJu0YxJCzArefEMcwUvjaNohik84V+CPWrYy+oV7/+vxdc/rAryKJZJ
 jMl/w0jD8vsvVTqnhSGGHIqm0hEXlhIDcuh4SCk7N1prkW3tkhjSZCNhO9oCj2Mi4EXz2JhBzlE
 MO2DasDE=
X-Gm-Gg: AeBDietZ4BaRiVb6MJbfqS1BdACBxR0zC4T2RKbjRVt819uevnbTzSlQPz74RiP87Y+
 6vAcdy3/NoYV1euNK0xpXxB3/PQyFdJYTldirr4sWbxRrriBi/bcc/Dt3dIxfOo/WZf4M0gy8KT
 moCcO7vVKw5Q8ahpwTF8RhmdnomxFiJgWrsWXRifWnstHkLFKgIRT+cBOPjan4WxB24eywnoa/v
 4GoH5j5Yw3RJ+LebivdwPy9rSz8iTH4r6uizkqjYiViekG6MyioKQY0aLN/MHFVZgPLDWMffJ+P
 7uRJLRjePxzOFXEK7VGrUHCHqN6mzmtwZ84tHvr84YSexkLr8eGqgzcv0KMj00SCdRu1TN1GKax
 Yj28P3FuFA+qCUHIrNa2/69KbS3cmHl+IJv6GhGxOfcTfiT7na5/s4Mq8a0JYNp0gDHKjRKdwAk
 2teEx5ZI2e+aqwfj1mVkgIMlY6g6KQ9XsYbR4xHpv+q5SeruyAzYrb
X-Received: by 2002:a17:903:1447:b0:2b0:51f6:d46e with SMTP id
 d9443c01a7336-2b9a23494d8mr754815ad.15.1777496847589; 
 Wed, 29 Apr 2026 14:07:27 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98893f4f7sm29059105ad.50.2026.04.29.14.07.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 14:07:27 -0700 (PDT)
Message-ID: <df5fa8f6-1e6b-4327-9ac2-6944288f9d53@linaro.org>
Date: Thu, 30 Apr 2026 07:07:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block/block-backend: delegate blk_co_preadv to
 blk_co_preadv_part
To: qemu-devel@nongnu.org
References: <20260429062004.36582-1-guobin@linux.alibaba.com>
 <20260429062004.36582-3-guobin@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260429062004.36582-3-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/29/26 16:20, Bin Guo wrote:
> blk_co_preadv() and blk_co_preadv_part() share identical bodies except
> that blk_co_preadv() always passes qiov_offset=0.  blk_co_pwritev()
> already uses this pattern and simply calls blk_co_pwritev_part() with
> qiov_offset=0.  Apply the same simplification to the read side so that
> both pairs are consistent and the shared logic lives in a single place.
> 
> Before this change blk_co_preadv() duplicated the
> blk_inc_in_flight / blk_co_do_preadv_part / blk_dec_in_flight
> sequence.  After this change it is a one-liner wrapper, matching the
> write side.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   block/block-backend.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 9944657120..490b149bf8 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -1376,14 +1376,8 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
>                                  int64_t bytes, QEMUIOVector *qiov,
>                                  BdrvRequestFlags flags)
>   {
> -    int ret;
>       IO_OR_GS_CODE();
> -
> -    blk_inc_in_flight(blk);
> -    ret = blk_co_do_preadv_part(blk, offset, bytes, qiov, 0, flags);
> -    blk_dec_in_flight(blk);
> -
> -    return ret;
> +    return blk_co_preadv_part(blk, offset, bytes, qiov, 0, flags);
>   }
>   
>   int coroutine_fn blk_co_preadv_part(BlockBackend *blk, int64_t offset,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

