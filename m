Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73785C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 22:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAxT1-0000Vf-14; Sun, 27 Sep 2026 18:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAxSx-0000VT-Vu
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 18:35:28 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAxSw-0006n2-EH
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 18:35:27 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so1206237a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790548524; x=1791153324; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jHVOgrfi07N/06CkPD3Q2QaI64QqPzLuQ6max01W4Zo=;
 b=C9uI/TSaqeYE91EKyIRJPr7T8LhImx4rktJoxPxkzRFrHw+FvnV26OQeHO08E5mbaj
 3+dRfOCArAQyP+51U1+MQaCHTqcIailif/2wWXwrcqwcHLa/6us7uEkPGBSfOTMOpG2u
 qrMnfV/+x1xsB/RhjkFKsZgLNSIkbgOZUw6MwRP55sawB3rHqyvrwOQGPdIbatUTb21r
 dgl2IhzaVHlxPDDKUUjQfiPtzcp+nWU4XilJNmlVpuK4oVnKfr3a2k/LU7Czluju8dVi
 IrHQWiDFhig+9CENMExCjVquBwQ/ZQqiGZ8bJnJidvOPMkehI/xx8XWYwKZSwR4AViQO
 uBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790548524; x=1791153324;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jHVOgrfi07N/06CkPD3Q2QaI64QqPzLuQ6max01W4Zo=;
 b=EXcVt7sTrgylXDQ1VEJm1rExcKahn9WQNDI6ylSFv1h6dnvtEUM5E1Ln57kFhgbMbb
 cpFEyrebpnZ/J1H2OGgcgFRUr+c+yDUN2yIACcuO8ctjT8Iun1kI7pM7pyZw5sooh9qa
 EzyYYGdyZz6XDCICeBd7gJDGvtuTBMHcKmVHMOAbWVx+dkzAEjJS6ixEhT4O9rUbPdZ0
 FwqRB4CNpgyYWAJsFYFmx25BJYL8CkLzWVd1W0yUA6iI3FtXP3f+9eakDO3px/8ZWPD3
 upOd27zPpckcSNQKpodwkyCJ/IEmqMN7995+XXGTqu+yUjkyyaN2yHHT3fHFnxe9Rh9e
 IzHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByozn4p6Nkf7C+7QXODtMz+Sy8RkYTNpdLjVS2CdUXn+UQB3ZzBCxIrV+4CUWLYGjdejB6ecNjqKYWu@nongnu.org
X-Gm-Message-State: AFq9FYJWXlJAFf/TfE8dpYK5qFxSSRg+eWgZR4ZHYQ7V0o0/L8tSdwTW
 y4pKVf3TE/GPk92Y3HuQTD8n9OftyHC7XGJAU9L/tV+2K+gzEAJJvrV6SadqfMjD/Ww=
X-Gm-Gg: AYBFou1sr3o3c9xivkL8GdHcsLiib5Qo2/VS5Z6ANPHZutQtfM3v/BtPoOKrfVsPz2w
 re2sREq4S77II9GTTPQLLi6+1Pi9O2kdgo7rSq8LN1TagEBpavZYzZv+ZvRTopDTGxre40Rj3zQ
 VwX1Nh6Zk/UwjuBI+Ou1CdrvCQi2Op7gjk2zTxO7rZCt0zdfohwa+G3DSi4c5IHNt0phSvOJeev
 jTI6STtVOsrPZx4kQ1yHItq+NVaqx+AI5B6WlWKl7UBqPb7s8ElHEz8FDr0loS6rx76gWQOXjfB
 z4vsjbnYAOIToUP36GAG5KqWrsOYWWG8TqbIuXeypBhWYGl1oTlaBn0/xoA95PX2JUdhLT0pQUd
 YqnaMlLIzaadGv37OZ1ZA/8QFdnPsGzYUp/4tmEqjCh300u9LT/mcb1J0tjEsfdTVy/mq4PfDvI
 nWSXq/d+Q/8Zu0hqYArjQ7ll9kmS53tLdmfBZiTxd7V+kN3qqN3IjqguCGLJoOgCkc9xRzRuYGF
 +pphY0N19V37ale/fJIdq2DBTRKiuOA/9KGZXxy
X-Received: by 2002:a17:90b:390b:b0:3a0:e786:84cc with SMTP id
 98e67ed59e1d1-3a0e786876fmr3929669a91.51.1790548524165; 
 Sun, 27 Sep 2026 15:35:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc78796cf39sm3678773a12.32.2026.09.27.15.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 15:35:22 -0700 (PDT)
Message-ID: <c8448194-1576-4b5d-8d85-5d594ff26c09@linaro.org>
Date: Sun, 27 Sep 2026 15:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 002/101] include/qemu/compiler: Define QEMU_ALIAS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: mattst88@gmail.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-3-richard.henderson@linaro.org>
 <9e71b3a6-4afb-4208-a6a8-9c100775b061@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9e71b3a6-4afb-4208-a6a8-9c100775b061@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/27/26 08:51, Philippe Mathieu-Daudé wrote:
> On 27/9/26 10:58, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/qemu/compiler.h | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>> index 3661dc5fbaa..8fa4552ef8f 100644
>> --- a/include/qemu/compiler.h
>> +++ b/include/qemu/compiler.h
>> @@ -230,6 +230,13 @@
>>   # define QEMU_UNINITIALIZED
>>   #endif
>> +/*
>> + * Alias the current function definition to another.
>> + */
>> +
>> +#define QEMU_ALIAS(N) \
>> +    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
>> +
>>   /*
>>    * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
>>    *
> 
> On macOS:
> 
> ../../tcg/tcg-op.c:1820:38: error: aliases are not supported on darwin
>   1820 | void tcg_gen_discard_ptr(TCGv_ptr a) 
> QEMU_ALIAS(tcg_gen_discard_i64);
>        |                                      ^
> include/qemu/compiler.h:238:20: note: expanded from macro 'QEMU_ALIAS'
>    238 |     __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, 
> N)))))
>        |                    ^
> 

Bah.  Ok.


r~

