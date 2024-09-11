Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAB8EE57DD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 23:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soWQs-0003kQ-61; Wed, 11 Sep 2024 19:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soWQp-0003j2-8w
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 19:07:27 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soWQn-0001Vt-PY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 19:07:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7179069d029so212259b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726096044; x=1726700844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NWkFRwzMtnjnS6hDMOQcA6JEZDkh8xVFkbeR+AlO03Y=;
 b=vbRS293lUdW+NlGgCcw7qbxTdH6gwUGSpr1ewO3swWgOQB8NDQlaVjHIaRJj3MSlw8
 ZRL3MqXXqdYTlLS6SNgyjYmhF9xb704kzn22pQ0G/wBwCGDtnX0bPWraWXpPPqcyz62N
 /SGVua2E45Gmz6fOdRTugKPnATq0miNmpdLuCDnrkrWyRgNjyOb7QvKnZ87WMfVkIIvy
 FeJxtt5uokvio8yWf/ofE7Nmj3wxEHB19XR5/Q5l9NlQjGK/uAwZrlNaSvlM0ZnEK2iX
 o8rn8DMuvM/YjV8wQQwKsSpIN964zt28ngF/QpuuRNlJ5IGSWdhrqrbFNbn5B43NMIjr
 ac5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726096044; x=1726700844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NWkFRwzMtnjnS6hDMOQcA6JEZDkh8xVFkbeR+AlO03Y=;
 b=fn2ly6N0SV92L4/ITz116+BW9NzOvYoyGqJ+Lzzt/TyC4uouE8ozZ1AbPnAJZwdL/9
 pzW067MsCslHoBVjYrY0NRS/EZLbp6bmQfWxixqAPqqt7NyqA4oXrM3wMG6wNXlLXSLW
 j2aTdsQkqEwgWHBVg2H/PA3PHOjC7gEWUSilmpWbSMwYzCW6gu1ZGp7iQwFLFUVWs1Qf
 c96OfsuqWkRXqblbSFUPNr6z0qQ8gq4/ALULMVyDCVCMQcnXXCdAsS8hj4Juc3oodvA0
 Ur/a2jfafqkkFosKpP1LGMuY5qmwmgpark1NOq6wKZwGQaXhUG64ilQuuSu5RlKH33hC
 7vaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRJJFHIAjd5M9t+m+Bom7DpzoVrbcyx1LT/NRxEp5GqCzdkkPfb9jyvSIYAqYUZqT8PO6XBgBCPJpF@nongnu.org
X-Gm-Message-State: AOJu0YzcnBbdK803yw6UNZmVFtZGxhIwRKcskONGmKUFRt4RLZzPuO7L
 jb7BwXxQ6WhnJwJVecz7eP2G7S6TwK7FFjRpDKeJswwTKHHnrJtL2M0/mtiANDA=
X-Google-Smtp-Source: AGHT+IECL0SCaKviybaGjoYpaCkfHbFysQgUBjMSPc/iO93ZIabeEyBAtkoJvGCPoMYvNfwv0O/Cbw==
X-Received: by 2002:a05:6a20:2d28:b0:1cf:253e:5cc5 with SMTP id
 adf61e73a8af0-1cf75e7b611mr979837637.10.1726096043698; 
 Wed, 11 Sep 2024 16:07:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8205sm3495676b3a.21.2024.09.11.16.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 16:07:23 -0700 (PDT)
Message-ID: <e0683f81-61f0-4c8b-8f91-fd93dd29e0be@linaro.org>
Date: Wed, 11 Sep 2024 16:07:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/12] tcg/riscv: Implement vector mov/dup{m/i}
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
 <20240911132630.461-5-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240911132630.461-5-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/11/24 06:26, LIU Zhiwei wrote:
> From: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> 
> Signed-off-by: TANG Tiancheng<tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   tcg/riscv/tcg-target.c.inc | 73 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 71 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

