Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BF5C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 20:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9UrE-0003Xk-Ew; Mon, 28 Apr 2025 16:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Ur7-0003VQ-FC
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:13:34 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9Ur5-00017E-MG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 16:13:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227d6b530d8so57123565ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745871210; x=1746476010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6ZorMADMyBRv21znpGy/Jlf4+Ynhn8gEnI7C8weAqU=;
 b=jVxeW8hPeX5wXBV3h8yBfj9Ab+jMnq+S/NY0AP3VHWonqsr2QelnH9hi7pGp4ghkl+
 A2p2caaLTLnjjXm1rlybd2cwddhKw07gYzrxD8dtmffbHcpkYuOAwW8cU2Nn4eQ9NZYz
 4wU0Pu1fkR44VYwmaGDyWF0mJ3mXAfRwIUveD0CVVn5Ael4hOokoPKSvBYeVQjupBCQS
 Wm1AZK42EnPAaJYrykRpMwspR8pzBmVx/WduoM5zTg1LU3AUdvGSOmrgu4xeXHfm+aPi
 MTiAQLW+w2VObPAUTkDg5b7nPSdVBQYTeJymNs6ZALsbSIvDF9+tZ7YoCEiXH8sFPALA
 Mw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745871210; x=1746476010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W6ZorMADMyBRv21znpGy/Jlf4+Ynhn8gEnI7C8weAqU=;
 b=kQaGszPbGMKls6JHk2BYmREz4nJsQm4ZnnMwFKYDYDs6iCO4XlZbkh9m2m/IKLUPaW
 TAdRS8Fq9U7Agx5laUR+48U724PIBG+rVrzhd6lO2SqDuAoV6fDINqKuR+CU6jL7ETSH
 nEMeBToUYiIUR/Q7fI28wlcAabZV5MyEFvzphckyvMBSFH52Xug6q0WhYJWJidVCCDTF
 fq/FyB2470YTNAI8Wf0Eqg7DnGh9sJULza74JbTrPolz1+GD90mGS7XdLQULDGrXLu9B
 OtzCLILWsg7pHjTku9YjTy5U26meHrm7kTgD8jq8sh+VzEQajQYXV4TxpZEfHcr26vBT
 HuCQ==
X-Gm-Message-State: AOJu0Yzht9p+Etck6KxKw/e1lww+CxvlX6C+v+efS21tRmZYXEljNTkp
 0k0cCT2QFSo6dlUCu65FfyCQH7fuXKiVfSHcypk2UFPrsK722D4hokzbqPFIvJ0=
X-Gm-Gg: ASbGncuP1yREIr6p+tZm0rp+VESBBQSBWnv0SsHKgzyAybXMHTvTtjPO9+Lx8Ptz/OD
 JjCv+V34vTDvqT0LLiNInOzrtfEze7nwBdkQhrgvaNy25Iz6f9YKxTWNHx/GT9+qbfzRJylXD8L
 97jEudwW+t13HDbF0S074xo/AVUa7yDlU6aHMDVxLfJewoYx5scINpKC1paahRpoXeJiU3eVCtm
 iAJicyqVbl2C4kcrrRsGnauez8OOa4oqKt58X4yZ7FYWH4iASlAsqMXUJ8oFf2uYhRD0cLc+FRb
 Ynp6UIFTXQURxH2chsIcrFw1n+6LWFLpDHllbH2OnPCL/ep8+0N4BL7sDHbXAfWr3oCMhhKr0r7
 ajroKohg=
X-Google-Smtp-Source: AGHT+IHZ7cF117TSKkCLPfpwqNBAbxpRzJXx2INw9Qpegx1tFnUVybAEHUvXOIuVcER91ocMQE6mYA==
X-Received: by 2002:a17:902:d4cd:b0:221:78a1:27fb with SMTP id
 d9443c01a7336-22de6e932cemr6035735ad.11.1745871210139; 
 Mon, 28 Apr 2025 13:13:30 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db51025aesm87430115ad.188.2025.04.28.13.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 13:13:29 -0700 (PDT)
Message-ID: <75635d14-33b0-4dd9-9a89-2ef06728a0d0@linaro.org>
Date: Mon, 28 Apr 2025 13:13:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] accel/tcg: Include 'accel/tcg/getpc.h' in
 'exec/helper-proto'
To: Anton Johansson <anjo@rev.ng>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
 <20250424202412.91612-10-philmd@linaro.org>
 <ll6avykvfgf7yn27pwe7qvquq7udalqwzfaf6xdxxh7rfmh7q4@kwscgnbg5hb2>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ll6avykvfgf7yn27pwe7qvquq7udalqwzfaf6xdxxh7rfmh7q4@kwscgnbg5hb2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/28/25 11:27, Anton Johansson wrote:
> On 24/04/25, Philippe Mathieu-Daudé wrote:
>> Most files including "exec/helper-proto.h" call GETPC().
>> Include it there (in the common part) instead of the
>> unspecific "exec/exec-all.h" header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/exec-all.h            | 1 -
>>   include/exec/helper-proto-common.h | 2 ++
>>   accel/tcg/translate-all.c          | 1 +
>>   target/avr/helper.c                | 1 -
>>   4 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
>> index 4c5ad98c6a9..816274bf905 100644
>> --- a/include/exec/exec-all.h
>> +++ b/include/exec/exec-all.h
>> @@ -26,7 +26,6 @@
>>   #include "exec/vaddr.h"
>>   
>>   #if defined(CONFIG_TCG)
>> -#include "accel/tcg/getpc.h"
>>   
>>   /**
>>    * probe_access:
>> diff --git a/include/exec/helper-proto-common.h b/include/exec/helper-proto-common.h
>> index 16782ef46c8..76e6c25becb 100644
>> --- a/include/exec/helper-proto-common.h
>> +++ b/include/exec/helper-proto-common.h
>> @@ -13,4 +13,6 @@
>>   #include "exec/helper-proto.h.inc"
>>   #undef  HELPER_H
>>   
>> +#include "accel/tcg/getpc.h"
>> +
> 
> Non-TCG builds will fail since exec/helper-proto.h is sometimes
> included outside CONFIG_TCG (e.g. target/arm/debug_helper.c).

Yes, I've removed that #ifndef in getpc.h on my tcg-next-1 branch.

r~

