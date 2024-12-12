Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47017E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 20:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLpe5-0002Ta-Fd; Thu, 12 Dec 2024 15:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLpe0-0002Sx-KF
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:18:45 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLpdv-0002gy-Pl
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 15:18:41 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso531899f8f.0
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734034718; x=1734639518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wXx8LehMtPhGQIHS10qgTj1vmwGyf+Bl3o4hJFliSP4=;
 b=dGs+AntrqNMQe2GyL5Ve0CiC3zNIVw/VqBxqrk3psHMjMaV4sIq5yFPhEvjQSZkDn9
 B2dz2gMGl4j5aCR+G/eL/1HnDY4PgbuUK43qzZBVc81JNY9ocuCqDP9Xr+0P23sqMDJ/
 t3mRSGe6hLD0YudLEn5VL2Vf4vLnzwYl9l09gQhl8EvjDqg0MQbUqBDhYfOKszMp+7fE
 NpE+07f9BoqsVt6Ah7CG+Pq1eLDOaMU8SZpc3cvtaCfvDtgEuV8kxY3wlR2g1HcfBhH3
 v5GIIdq656DEV9HXYyZ+/OBnRxPP2t0ZQ8SVGulRJu1sRnnF0K96CN4701zZsNFRj0aY
 Po3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734034718; x=1734639518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wXx8LehMtPhGQIHS10qgTj1vmwGyf+Bl3o4hJFliSP4=;
 b=SCdK4qp/hiB2zQvprXTEtuFV6Q4OOaPzn1kUBKX///l393HiNJoGfm07X1MiomohCb
 +c9wwIuXFw069YhEmm8RalGYSvhL43yVnDQMyfjGzzC89uuwp7YAU2Vd/uKdYqBiGQQ0
 HJhadIC3qscLed4mifTNxBz4A4tQ49ntWAdOpEgFTOPHuKBTEWX2qbWpavZz/qAJBhVt
 KFNtftwS6ik88R5IPhbV4tUm2iNpHBtpojW/xQ2oWfrdIYBQyUZjxiVLGxAn9oQOpMOP
 LlZy1350+DH7MwOWc9ZHkv/EkKuqOaCEfUa5MbgQ3anyizKYB8jPvRIwByzRBEuthc1/
 vlPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhyRkpx+nfWrXcfyWDGgnr3mVPCBkEl9gDIIu+HmGRbSKVrE/s9Oo4377g5TFxs9ijhPNUbRdnguy6@nongnu.org
X-Gm-Message-State: AOJu0Ywmm78mtAi84Ad/u+COGd2ElbKGGizQSuESK3I3GfPuBo3QsDFU
 ahROzjScqW0SGaPHWOBFG13BklI+phV9bGlcwZbaJeWw6AvCd2dhpfzzXor9Vxc5YA56gFktt+M
 k
X-Gm-Gg: ASbGncuI+/a73FCtrIrVaocEiIzECp0x9hOvFca2PCQafkHQUEmAWEmah6SLC56s5df
 7VUrav7O15agSZSXZeUgavTQUxcpkSb4cn9o2+rAlcbWDwHchJDMT32V2qs6pb+sYCFPAku8uOi
 G82//Iu15QzrpnE48CgBtGVQGTFnDLNrYy29s2n79w/LFAP59ftoeKvj2xJm2Ng0L4HeFdOiUp2
 95KsC2/yBPvt/DvLqg5bVn3WstIcqvvMxO1PftgBD5gUoCsgP5wuQ6Q0AlHJizW5v5NjNerNZgw
 alFjJNbizUkVLN2e2YUb05m3
X-Google-Smtp-Source: AGHT+IELOOJASaztCfe6u8QEQUWCprAWxZSDWPvfvsB+4GWVnpG7hK+UNez6rEt+3SJZcHU/etmcHg==
X-Received: by 2002:a05:6000:1868:b0:385:f1df:24ea with SMTP id
 ffacd0b85a97d-3864ce937camr7277161f8f.40.1734034717848; 
 Thu, 12 Dec 2024 12:18:37 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f675sm4878986f8f.20.2024.12.12.12.18.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 12:18:37 -0800 (PST)
Message-ID: <cffc3e39-bbd6-4acb-9033-7740ed479533@linaro.org>
Date: Thu, 12 Dec 2024 21:18:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] include: Include missing 'qemu/clang-tsa.h' header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241212185341.2857-1-philmd@linaro.org>
 <20241212185341.2857-4-philmd@linaro.org>
 <f2e5348e-8773-460a-a586-8e5be7a87f3b@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f2e5348e-8773-460a-a586-8e5be7a87f3b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 12/12/24 20:22, Pierrick Bouvier wrote:
> On 12/12/24 10:53, Philippe Mathieu-Daudé wrote:
>> The next commit will remove "qemu/clang-tsa.h" of "exec/exec-all.h",
>> however the following files indirectly include it:
>>
>>    $ git grep -L qemu/clang-tsa.h $(git grep -wl TSA_NO_TSA)
>>    block/create.c
>>    include/block/block_int-common.h
>>    tests/unit/test-bdrv-drain.c
>>    tests/unit/test-block-iothread.c
>>    util/qemu-thread-posix.c
>>
>> Explicitly include it so we can process with the removal in the
>> next commit.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/block/block_int-common.h | 1 +
>>   block/create.c                   | 1 +
>>   tests/unit/test-bdrv-drain.c     | 1 +
>>   tests/unit/test-block-iothread.c | 1 +
>>   util/qemu-thread-posix.c         | 1 +
>>   5 files changed, 5 insertions(+)
>>
>> diff --git a/include/block/block_int-common.h b/include/block/ 
>> block_int-common.h
>> index ebb4e56a503..bb91a0f62fa 100644
>> --- a/include/block/block_int-common.h
>> +++ b/include/block/block_int-common.h
>> @@ -28,6 +28,7 @@
>>   #include "block/block-common.h"
>>   #include "block/block-global-state.h"
>>   #include "block/snapshot.h"
>> +#include "qemu/clang-tsa.h"
>>   #include "qemu/iov.h"
>>   #include "qemu/rcu.h"
>>   #include "qemu/stats64.h"
>> diff --git a/block/create.c b/block/create.c
>> index 6b23a216753..72abafb4c12 100644
>> --- a/block/create.c
>> +++ b/block/create.c
>> @@ -24,6 +24,7 @@
>>   #include "qemu/osdep.h"
>>   #include "block/block_int.h"
>> +#include "qemu/clang-tsa.h"
>>   #include "qemu/job.h"
>>   #include "qemu/main-loop.h"
>>   #include "qapi/qapi-commands-block-core.h"
>> diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
>> index 7410e6f3528..98ad89b390c 100644
>> --- a/tests/unit/test-bdrv-drain.c
>> +++ b/tests/unit/test-bdrv-drain.c
>> @@ -28,6 +28,7 @@
>>   #include "system/block-backend.h"
>>   #include "qapi/error.h"
>>   #include "qemu/main-loop.h"
>> +#include "qemu/clang-tsa.h"
>>   #include "iothread.h"
>>   static QemuEvent done_event;
>> diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block- 
>> iothread.c
>> index 26a6c051758..1de04a8a13d 100644
>> --- a/tests/unit/test-block-iothread.c
>> +++ b/tests/unit/test-block-iothread.c
>> @@ -29,6 +29,7 @@
>>   #include "system/block-backend.h"
>>   #include "qapi/error.h"
>>   #include "qapi/qmp/qdict.h"
>> +#include "qemu/clang-tsa.h"
>>   #include "qemu/main-loop.h"
>>   #include "iothread.h"
>> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
>> index b2e26e21205..6fff4162ac6 100644
>> --- a/util/qemu-thread-posix.c
>> +++ b/util/qemu-thread-posix.c
>> @@ -17,6 +17,7 @@
>>   #include "qemu-thread-common.h"
>>   #include "qemu/tsan.h"
>>   #include "qemu/bitmap.h"
>> +#include "qemu/clang-tsa.h"
>>   #ifdef CONFIG_PTHREAD_SET_NAME_NP
>>   #include <pthread_np.h>
> 
> Seems like a better place for all this would be in:
> include/qemu/compiler.h, instead of a separate clang-tsa header.

Yeah I was thinking the same, but since there is already another
header, I didn't want to delay this cleanup further by modifying
unrelated files.

> But for the current version,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

