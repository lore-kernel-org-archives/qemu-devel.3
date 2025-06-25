Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEE0C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURWw-0005De-3N; Wed, 25 Jun 2025 10:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWl-00054k-IF
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:55:08 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURWj-0006QO-D2
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:55:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so283b3a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863304; x=1751468104; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=saDhDz9Zn5wEcp6WQAXThL+ZoL2OSHPhwKWmgIFjBqM=;
 b=VFc2w59fcfmQ9yoJXA7QJb4sFN00YEBmCY4U3pC/P9f4uh3uPrt+h9G5Uv0R1vnQ+7
 lVQdBK/aMtEW1ImKvIeqmY7/sSPzqJ6g5FMccMNvWxm7pflIowZVLHR3hykFw3LaTIg+
 EjmKUJzwDaaUedGF/GLjXiT9W9HwFp2JxAgrc1JDKo1HaYMJLycyhe2fLo6p6HnI4Urf
 0zTtEf04eLsN5KvUDSOVzJcZ6Yjgs3H9f+4PuZmRGLV/pTP/1Nn+x7WXi9SL7/phihRO
 E3S3nxn+9QoF8NFbxwt3VsTOYXeRTPIdnwg4MhZbXJqzE5mEA++vSRkA/ovoK0jTftXK
 zL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863304; x=1751468104;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=saDhDz9Zn5wEcp6WQAXThL+ZoL2OSHPhwKWmgIFjBqM=;
 b=vKB/msozTl9ILI32gWwPwHQDOBgtTolxMVGzwyB0ITNoAKdtuA9SnAFRhIFFw0mrR+
 oEOwrMKc/NzPu+ZdhF9nq1tFgcUavf6pxUd2+tLG0mqYUfPsOp8GvzQqKMwC/3Nbv9wN
 UYCeBHwoBmgIG2ph6UL7XD5JY2RYwAFUU6WLAA+n0jhR5QiElQggLTsCYhImja40iXeA
 /BrgjmkD7zC/PkP2GoAIfWxK9WocgycAH09tD7NN8ons8jY5P4lbJ+WqjHrODc9cfEdx
 DzDeMInSVySHfvqW8SNoyf4Hw06CFSl149uNaPW6LVpYPrBoMhlu0gcqxAbjK1duh0/E
 PV1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/IqlVGpVs7wRPjkdJ0nFNgZOTsXJX1fv5LflfcwfDMU4u7pQ6e+NbVdFA4Weg4Lq5gOJKKOnjcY+n@nongnu.org
X-Gm-Message-State: AOJu0YxVz9jwOAzLN9VvFO0Ub2DbUWlBhul808DwLZol5H/rbuPTjcmg
 lPQq0EUI8qHfbThRW1vBD0mrMY+L3Pi9crZLeYwBF8xttj0Xx0i8kyRp7EcrwTkUHWQ=
X-Gm-Gg: ASbGnctFEbupDKGWKRDm1YSMJfcF73TyeAbg5fbdFrWioWep0GUZUlhj1FiS8083DEB
 PDt+DaCmtXo1urF6lDFBLdJIUl5dDcMrjZ8lPpH2n2xs4ifa5J8KmDcnzqalK19puw5SsH0MwGw
 exvmvc+yZh5f5+1o3fAbwRQRioXm5cBFpbWP+ltuyD0ogO5XsUWUHcfBwITC2GqVL0+4L5YCDfI
 Rz/xd/1PQ4krH6HBwsyy+5Zmpj0/t159JuzFmxJYmRfb2/7o/k0ajccO+55eTsCr7etGV0PBqQq
 DhqPXBTaUdCDqyySjn9T+Q1l+O9D0UB4hvw6BMyKHGPCo0zhMpLFlhjAIcuhLoWyqL7Hi6LaXAw
 =
X-Google-Smtp-Source: AGHT+IHdjEnIy4mpa90O31gWx18vV0eBcpeeKeW+fiPGfDYNRI5JuoJXRk7kxMqg2EE/qPD9HOdLow==
X-Received: by 2002:a05:6a00:2e99:b0:740:6f69:dce9 with SMTP id
 d2e1a72fcca58-74ad42bd7efmr4940521b3a.0.1750863303754; 
 Wed, 25 Jun 2025 07:55:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8850bf2sm4668425b3a.110.2025.06.25.07.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:55:03 -0700 (PDT)
Message-ID: <2de4088c-224c-4b0c-bf17-1020289f501b@linaro.org>
Date: Wed, 25 Jun 2025 07:55:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/27] tcg/optimize: Build and use o_bits in fold_extu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


