Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EEAC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg5dS-0003OD-Ui; Thu, 06 Feb 2025 12:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5dQ-0003No-1J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:25:52 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg5dO-0000I4-Dl
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:25:51 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436341f575fso14143885e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738862749; x=1739467549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFpY6lhLsuESMDGK6xSczhaIErXsE/jTHzElGG+l1VI=;
 b=BvzflDvY3i4HGTDikcKEOf5CF+MDJ5ct4+xMk8t7v5SdkU3GkYatUSzm8QLR4kqmBp
 Bk3eKO9zaIIsSrI/IkwQVadglWeYIe2jWMCoIMasTybtrrwT+eHzCEfvhGH8vVUpJhqq
 PtBgyua+7VL7KttZn5hZCi00eUXHIO4jvnHfIdJkYkqZ8z2bFU7fVNebAbpsgNG6Itgm
 aRVenipq7Caer51+O+xfn4/dwpDQXb/dkA1xRIAnIWCFG31SidKajzhX2t3zng2W3y8m
 RtxgZbWr5L1ZfRJsl9LvRFsrwrLfcOr5y38nS99xet0fNDuTe0+F/+ELumnC2XdS4dZ2
 9SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738862749; x=1739467549;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFpY6lhLsuESMDGK6xSczhaIErXsE/jTHzElGG+l1VI=;
 b=fI1QeilBxCbAOH8QCvz9A6AJ+9AzGIzwMoG3dYm1BAfqkGeUCYUWmsvfGX2agSN+nW
 br5z8rFLGmrL1f4PPeS5JqlCBDlNsn2Yx/8aqij+90eCGl8Un/KjteX2NL3kagflyK3/
 HaBy3HhxtLWS3hM3wmX1zzs/jVoWq0pec+TnUepSztvsUQSdNHMkw8vuYkq+UCle0SpL
 h2e1Pd/RfM/q2adruEX3kaQXd+vhKNCM6TyyaT/EQaNPJd5Mim1zl/p91mNJ4IOtyIvh
 2MwHJzGVSzf4DqaoXmTEW1foPL5cPg0m8ImwtCEFgBJYdgVTOfiEIiD/9k9D8u1pVpOt
 uRyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGmlZjqWiCNriyMvwM7Cc+UL9s6IfmSa2H/0qUVMopXgIzHKtHB3Le2koYI3a3zzdWG8NRcYC2YbMO@nongnu.org
X-Gm-Message-State: AOJu0YyasXUMMqdRXQf3OtlmIgaMOYqvBHhCXOjCZOV5+O/mJOLO8KkK
 MLEb8j3cqWOT/Ol7G+BJ4ckR52Vn8ui9TSeXxe+gB1GJMameAErnOPzMq2imfXrAxYo3bOtxXTp
 P7JA=
X-Gm-Gg: ASbGnctGhf9Wz17VNaOAnDVILCeNnmVzW4XfTNhsfpEW3AhOksyoOeCBeTE/i9W3iHM
 jmSyJt/7ojzSGrKj1F9v1xu2KHk6KQTUYps4Cuw+ydwIN8WY9JfTMrzkLlZZO10jbuaBaoXT4Gv
 sQX0GmXtc0LZLgfD10c7Aeo8Yy1AWUNSgabo8MDGUsxpPWxhg9F9iODkD3YADwB31AkMP7Dt3K6
 QTOTbcdq0b4UASR82qpoMGoGnqsJryXHEm5seMQcUpEXKRlnMvcfv39ZpvfoO3DCwz9Bs8fFFwW
 4yqj4VLmnSQPeS4cBs0K0h1RmgFvKGfMaqjJE0TD6IXLl72BFLVz9fHJ/wk=
X-Google-Smtp-Source: AGHT+IH11EZFL8bQoatL+ho/0lB6Cf1QbjU9Dx7Czit9Zj/scPNOGViFz+c5zb6Xo88V1Mis2hoRPw==
X-Received: by 2002:a05:600c:1547:b0:434:f5c0:329f with SMTP id
 5b1f17b1804b1-439249918aamr3567865e9.14.1738862748688; 
 Thu, 06 Feb 2025 09:25:48 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d94dd1esm62768155e9.16.2025.02.06.09.25.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 09:25:48 -0800 (PST)
Message-ID: <b46b9348-0f28-4714-8b39-13cf2e62a649@linaro.org>
Date: Thu, 6 Feb 2025 18:25:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Remove unused blk_op_is_blocked()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, qemu-devel@nongnu.org
References: <20250206165331.379033-1-kwolf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206165331.379033-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/2/25 17:53, Kevin Wolf wrote:
> Commit fc4e394b28 removed the last caller of blk_op_is_blocked(). Remove
> the now unused function.

fatal: ambiguous argument 'fc4e394b28': unknown revision or path not in 
the working tree.

Is there a patch on the list?

> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   include/system/block-backend-global-state.h |  1 -
>   block/block-backend.c                       | 12 ------------
>   2 files changed, 13 deletions(-)
> 
> diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
> index 9cc9b008ec..35b5e8380b 100644
> --- a/include/system/block-backend-global-state.h
> +++ b/include/system/block-backend-global-state.h
> @@ -86,7 +86,6 @@ bool blk_supports_write_perm(BlockBackend *blk);
>   bool blk_is_sg(BlockBackend *blk);
>   void blk_set_enable_write_cache(BlockBackend *blk, bool wce);
>   int blk_get_flags(BlockBackend *blk);
> -bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp);
>   int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
>                           Error **errp);
>   void blk_add_aio_context_notifier(BlockBackend *blk,
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 9288f7e1c6..a402db13f2 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -2357,18 +2357,6 @@ void *blk_blockalign(BlockBackend *blk, size_t size)
>       return qemu_blockalign(blk ? blk_bs(blk) : NULL, size);
>   }
>   
> -bool blk_op_is_blocked(BlockBackend *blk, BlockOpType op, Error **errp)
> -{
> -    BlockDriverState *bs = blk_bs(blk);
> -    GLOBAL_STATE_CODE();
> -    GRAPH_RDLOCK_GUARD_MAINLOOP();
> -
> -    if (!bs) {
> -        return false;
> -    }
> -
> -    return bdrv_op_is_blocked(bs, op, errp);
> -}
>   
>   /**
>    * Return BB's current AioContext.  Note that this context may change


