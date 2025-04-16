Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502C0C369C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57xQ-0000gB-Ll; Wed, 16 Apr 2025 14:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u57xG-0000Pm-Uj
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u57xD-0003AI-7g
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:57:50 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22435603572so255725ad.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829865; x=1745434665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jPmWnS+SLG5MxFRDT1E+3WHKwDf1QiWrf1dWYMHgwxs=;
 b=gH+ogfAh41ZMs0RAMXiEF+ejU+jTURbRyplxlwcntWC0Qt12Q7qhdpfKJb8Ff1cmL6
 SztXgqtivsisWoaVij8P8SnJ7TwLj6AuCGy6sAT/BQOaW+jmcSuGjQwhuHcLGwNJUIO/
 bo879iqm456d59tdqMEiDblNQPj894pXnwCFsMsn/RQK/wAAWeCrPr8XQ1WsQ8m/V0OK
 INvMzP3kra0KHvgvslfc/Frbt7CreMFkvSMZJYjj9bczzcpKVEr+1Hy+u5rx5KpBF29c
 KS2FzzFMJ6WLKJuv3sM/aaN+UtgeDSF52z9cgqpK4RoBLwBX1WPTUl32lsV+ES+MpdTm
 n8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829865; x=1745434665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jPmWnS+SLG5MxFRDT1E+3WHKwDf1QiWrf1dWYMHgwxs=;
 b=RModw1vbNn6l9x9Am12jlusNLMSIEHyxwMqo6VeXUBgJcCBuI9ovzT+KxSXB3UMI+x
 QAMEtWBxpPUKKXdmTpfKFOV4HdB6haSrckjUKro8Cc0IpKObVuJMhADA/LrVwsyOv5lB
 LA4RNHYDJIVp1MIBIGHZQYb8KLja4iUwXghuhH6/fOoVrfxHwLzY06MFNYDFAdnDhhfI
 RgYxxY0FixvyOjudR7kldHPAXTnEl61ILHd8OsujDN2npZeC7iZGmPfG2Yherxvq4vKD
 c7SVZxq/ZoF/EBIlDFhcpiaFCfh9gUGxleUFFTSjRPvPn0rqgvtGv26da6nJSYXCe3yb
 Vkrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcMsW5VNSxpw6z9KlwtZQVfp+0ro4WujLSPgodBbdw9yR0ZMEbjZIDy0YYOHQdW3EgULDQqq0/S3Gx@nongnu.org
X-Gm-Message-State: AOJu0YxZQPaBhuIupRYi0jLG8fCWvAsJDaS3wMUIOBjCSG8so1rTV12s
 W71z69S+nFNULXYc9X0kU0DodPOm7edxAtcrxnSGTb2zZSkMKbeOU19w2TKDgiFAx/ru8jUWdpv
 q
X-Gm-Gg: ASbGncupkOl+opae46oKxAgsyLU8vqTtUHdFhwpiSIeZs4K0pxj/xGRejO7laPiEUQ+
 eUQhC4VjvQnQlzNdMJt6TTpiOU2bz8RjZ3CH+uNvAOB3fLrohPCPMs9a0hAyfsZxx/1rBK3DBMv
 oLCA4AJnbqYKmuIbgjmcNJS/NYBBnX000aPIqPHbL6719T+dfGVff4WDO6tbhLsnSzsFr2JgDcc
 5GcP2829BHemxY64lJqvnqyeOXigoVaNFYvzZOwQbNCls5/yzKFsjViBEGENIIlwor3rILQQwxY
 9IRNp4rAEpKGlQk6oPhT9RMfm9dFqyyS6V/6Zft2ysG17gOvrkB0+4LxqB9qB1Ri598yGTRKcG2
 Dv2Er8zs=
X-Google-Smtp-Source: AGHT+IFz1PDgnya3u/CY17vFqcl+j/3Kj4wOeFSWnss4cZRmlZCqXbT4A8zOUe0wZcx3sNLlqh9XpA==
X-Received: by 2002:a17:90b:2703:b0:305:5f28:2d5c with SMTP id
 98e67ed59e1d1-30863f2b72cmr4716012a91.15.1744829865004; 
 Wed, 16 Apr 2025 11:57:45 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308613b3849sm1992103a91.38.2025.04.16.11.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 11:57:43 -0700 (PDT)
Message-ID: <283b1e93-f4a2-41c3-8c0c-d0c5787261aa@linaro.org>
Date: Wed, 16 Apr 2025 11:57:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 082/163] tcg/ppc: Drop fallback constant loading in
 tcg_out_cmp
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-83-richard.henderson@linaro.org>
 <D9852XZJ0WXK.1CO4OXV7BVNB3@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <D9852XZJ0WXK.1CO4OXV7BVNB3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/16/25 07:39, Nicholas Piggin wrote:
>> +    op |= RA(arg1);
>> +    op |= const_arg2 ? arg2 & 0xffff : RB(arg2);
> 
> Looks good as far as I can see (I don't know the backend very well).
> 
> arg2 should not ever have upper bits set here (nor in the code you
> replaced), right?

Only in the sense of int16_t sign-extended to TCGArg.
This will have been checked by constraints.


r~

