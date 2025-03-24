Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC8FC36008
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 17:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twlHu-0007Ru-9B; Mon, 24 Mar 2025 13:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlHq-0007R6-LL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:08:30 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twlHo-0004xg-N9
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 13:08:30 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22401f4d35aso97159625ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742836104; x=1743440904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tICv1eYr98BUyiF7XS7X+sxYHrGPdKMJqNUR0pOnoEY=;
 b=LNm1pmFWs03XzDiArjWsMFLBK/coG+xqBdxV53LC70C+DGJmWerWhUc3bJkxGDJMkh
 tplZ+OBvfStgVHyDEot1yvofsN/VZsaYY3sp2VC1Bj2d92EEgWJxxV3BlsoelQHI/H02
 1jyCLwhUEXl2E0ENTqYCPWYYxHPFF98jtD98GHBAyN0vBWPvH4Jz0HsEmrayuIh4wFmW
 uC/2gqiZ4AQA6v6LcaLBrVn83kb1geOY9Oz0KGK2lUJdV+JZ4ItPbugme+Ts1FOabPDZ
 J4KEyJKyGR4+jGs3s7wiTYQyYnnjoGhaQ7kcMYkzQ/7mTsOtuNYI78XU1gTMQy8vEUXL
 At2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742836104; x=1743440904;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tICv1eYr98BUyiF7XS7X+sxYHrGPdKMJqNUR0pOnoEY=;
 b=rKrazs/jVTfupuu8ePNtR8prVE7aT9heddlcy9XxIgt/tBLxyisnIXZj7Tp/0yksgh
 KioJJPYLD2SN69JBB/T/ItmlTtx0aGjky/77TxodI/rzq4u/aGpJcYnR++Qz3SOtpMO5
 fGtwubAF2AqYVETx7U8ZZb7d8NREDJLFMIjboxo9Ec3aS9NvbC6P+YveZ1tYOV9OG4HX
 9Bu+QNTA7/eL4o/vdaxzGgZAqow5xIv82TbadidTUYW2p8re13k7ZtiqzqFBbCsJcG15
 VrdldqpO9Q1V1dYQKrCy3rgTan1ik6Ph7U9N4faWzEq9Y/Yz/59+W9HSr6lPSnporaQO
 mA8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1k+uT5GX1mWQ2C+t9xOm9tUmW4hM1hgM8DnQ7/dkBpPTJvkWci4JZzFA0pHIJSYofWPBF68lY9gvO@nongnu.org
X-Gm-Message-State: AOJu0YxvlFLk0IKn7mGAIgGXQQG4+bCRLrdhCfKdMG+cu952b4wlWgdC
 JjdxsgyPkyYiU1HXjpvDEt5w6EzncveWHT7pcBqJTVsNouHHJ58HJRPKFUGGiHkQOEOIZYVD5Em
 p
X-Gm-Gg: ASbGncuFfzxVgUSQOfi1LIEadUUrh5DIlaGwMDdeg6WZ6xBMtVItTyjG2sSrO/ON+vT
 ukAOxWtWdHBzdf/DH3yZCwLylTgrMAGrvmoQbT5BmJvnc4PkmXVeVGSLVJwt3IxMJxW8XMnIbmJ
 /mT+Ye2p2wAs569pWy9GeKDkK+Dw9TJDgO9ODvuMXEYyZc/CFLqZIF1MiOZOJIL01NdW87wa/pu
 Sp9wOWRGm6GOrNvyhbdgFsAvKuVx4zTpoRBB1DZYouf+l2iQmafvI19ePd/RhknbNF9kTGQNKvK
 j23GxHL+G96aExUc4VFMkIEfUM2IQCDgXmKkoxdO3eJo4vkJ3+9xnZf6vHC03X1kcckRS9xcEqn
 0vyvBhAhsee7wj2HbymA=
X-Google-Smtp-Source: AGHT+IHATHAFxLLuDAN4Jycf4agXPZVMUJLsJM+tyH8xJY8mveUUrmcqXNr5h1hRhmjKzXC0GehOPw==
X-Received: by 2002:a05:6a00:99e:b0:736:47a5:e268 with SMTP id
 d2e1a72fcca58-7390596677emr19199114b3a.1.1742836104250; 
 Mon, 24 Mar 2025 10:08:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73906156559sm8550710b3a.137.2025.03.24.10.08.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 10:08:23 -0700 (PDT)
Message-ID: <5943b81a-acb9-406d-ad0f-7bd3d4716779@linaro.org>
Date: Mon, 24 Mar 2025 10:08:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/24/25 03:21, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - instead of 128 use 1 << MO_SIZE for future proofing
> ---
>   include/exec/memop.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 407a47d82c..6afe50a7d0 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>   static inline MemOp size_memop(unsigned size)
>   {
>   #ifdef CONFIG_DEBUG_TCG
> -    /* Power of 2 up to 8.  */
> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
> +    /* Power of 2 up to 128.  */
> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << MO_SIZE));

1 << MO_SIZE is 1024, not 128.

So the patch is correct, but the comment above is not.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

