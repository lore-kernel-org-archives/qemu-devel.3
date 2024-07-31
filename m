Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 402D0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 12:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ8LB-0004cE-5d; Wed, 31 Jul 2024 08:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8L9-0004bh-CX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:21:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZ8L7-0002IW-VG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 08:21:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso2821558f8f.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 05:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722428515; x=1723033315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=38hVMkSfUgJ3SyzkPTEj+peQ8DkdZV64LMUb5NHiHJQ=;
 b=ysOL/+wGmvW2j/CWx0AX21813vz9YZXeFDolCFQ4DkZQIkpnfw47ImmPUbejmDHLQo
 SVRs33FBjZimgVCz8OkWh5YqvILlrAXta7Nln9RxBpq/ywJCIGBakneA7fhRSXmh1Kl4
 VHLV9LISCPJj6MnXNQooSFG896kpWK9OUdsEamtkr62azIsafdzpTHaPid63ZRu21iDN
 S5JKnDZiEO+wd/u4FtuZGua13/omvE6SSRxJjrOM8tWA/nGYkwdUxqJK3zjuQ8JfjZsm
 Lwx6rUurr32uZrdm4xjvJB7ikIVnFLqwd0GncukSJDwNBvFeIFcihwTYv8Po/RBBir39
 pgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722428515; x=1723033315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38hVMkSfUgJ3SyzkPTEj+peQ8DkdZV64LMUb5NHiHJQ=;
 b=Ci11//PUfy+oYb7uTF6rOmw5SONuy2z6eUiyKTcNUa/ChxHuMJ9ixp0jVUZd+OK0A8
 48AUJb9Q8HM4if4nFU/z+kIRvgX8fcKQR05SB08q3o/M4je43dUoz/kvHWWEagbkOzAl
 j4CQBfgAr2utzPG9eeivN7wlxvT7ENkQ+HgP+rZclm3jTGUMrEkfkwxjS9iEGzbUUx3R
 jPfpmR9Si6q8Hk6KW281Gv3GjH5qQawGvbOCIacIDpsA3SMaQCx0XBKK0F2NSFggDqXw
 gH+q0TEPrHDfzy0nwBM4HBgP5eC8gq6T46uaivY2sdh1NOPAWzRcy+5SjRK7BqoGa0Hf
 uqag==
X-Gm-Message-State: AOJu0YwORyOWXqD2SS82/altOJdeyD6OLx5RTTG/C3hAeWphNe8IWA64
 DkDglO1SqXhb/Z24n+WH0XKEXl8dnbmtrzEe1s2pTd5Qyj8WL/XVF+PCiuws0BM=
X-Google-Smtp-Source: AGHT+IEPqhktt42RUjZR3ED94VSJgJ09SzD292ulK1ussmOpwxoNnsz0z+dfCSTHcjNCRRdmSnRTRA==
X-Received: by 2002:adf:e748:0:b0:368:87ca:3d8e with SMTP id
 ffacd0b85a97d-36b5cee9d3fmr8480207f8f.4.1722428514948; 
 Wed, 31 Jul 2024 05:21:54 -0700 (PDT)
Received: from [192.168.214.175] (29.170.88.92.rev.sfr.net. [92.88.170.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc445sm16860395f8f.48.2024.07.31.05.21.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 05:21:54 -0700 (PDT)
Message-ID: <3b08b95c-e6d5-4c9b-936a-13228961465a@linaro.org>
Date: Wed, 31 Jul 2024 14:21:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/main: Allow setting tb-size
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240730215532.1442-1-iii@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730215532.1442-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 30/7/24 23:54, Ilya Leoshkevich wrote:
> While qemu-system can set tb-size using -accel tcg,tb-size=n, there
> is no similar knob for qemu-user. Add one in a way similar to how
> one-insn-per-tb is already handled.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   linux-user/main.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Missing similar change in bsd-user/main.c, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


