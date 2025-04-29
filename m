Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B34C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 21:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9sCm-00023h-4i; Tue, 29 Apr 2025 17:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sCW-00021r-Hn
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:09:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9sCU-0004H5-GR
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 17:09:12 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22c336fcdaaso79197795ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 14:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745960949; x=1746565749; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLeuxHcfNivb7tyBBoY+e0IZqSm/iDGYB29+J+i/d7Q=;
 b=Ld3v+HGKKcO9hcUNRRC+SVOd4ArC6E+KpsPjDcHW7DWCSIHt8u7sZiYHa2deyFFSBd
 chY+KHBVuXiaAgqajy18wsrLDdDmv/QLxD18HywI32I5RSIKiajJu2kaNSo4Lqq/mlQY
 z8L5+17bTDQqu/hW84+Y5XvTQfbIrQZQEF7ypfv++sO8J58/O2xmWscYjCb6PisUvtQm
 pYh5KPlkwOzpAGSCmur4tWdSmdD293A0eT2v1/KcbwFqvph6wAEW1ofHUCAUNV0ut/Sh
 +pMypV+QaQGGxM9w/NGoH2zuN4tVZLojpm/uFkHxEcmGsInRJ3uA6TNNsn6kq8YeTdCX
 zFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745960949; x=1746565749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MLeuxHcfNivb7tyBBoY+e0IZqSm/iDGYB29+J+i/d7Q=;
 b=Cw4as8u87PiSEVZRHyWex4/WbGBh7ocjPO3OQqPgrVGvDVqtc33bDmH0x3OhglUFG6
 bBjUwFnESRJJ1kT6Z8zUKEkFUiVPFfa75O8YfLq9GiItZsoBVnl6EyyGHtjwP14Da+AW
 NM/GOjzwx0QgZaZxHdSTnPi6KralYLiUWVYue0jWtQkkJ6tvhXfbPQOKhp36Bslnsear
 gfFlv1GxKawwFnnT9W8S2IEbWvhpey0vb+xo/jeixtRnps+bYRYyqxptWbcrzADQzweZ
 a7wH3N9MHPFxuoHfRAk/lQVvs0h84+HhsstqTMoue+dxaV+8tqptdZvEzePREHeIRqDa
 wNMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5P886dfqznuxdXhq2mRVXCbziXoOdgajJOyXgOUmXMZcPFOL1cqYN4g25tF1jZNvjO78oKLGHU1Ti@nongnu.org
X-Gm-Message-State: AOJu0YyD01cRMDo4YHkG5fY+kRH1yu2+rGmm7RIkqv+SNh4/PfMe5aL9
 A3KqN9r+LRMJAskrEFXyISpVfzbvI4ZgVQ9E5DFxkncdGlH8jDcyT2PmGf9p8kw=
X-Gm-Gg: ASbGnctzr8ydwrALrp1e3N634nV3myH+qcys5GePppCwo6hZ839QbSkq4w50Qp9dEOR
 D8EkH5kd6UlX1BViC9dx4VS9VpYxN/l3bOvKg8IZNv3fc/sU+ivDqh8wKD2hSSUFgGQO6lL+DIo
 EH9rTSH3mnP+b33aVaqSS+lR7eVCdT/wojq0ZFF2hQDwuStdFl79FiI6wWO+q33DXNReb5wm6qu
 SvGiObAChy8bP7AMMlKl0IxUUzv6tTqLxhrnkSrso1kP8s7dKYmRrH7xyc8DUCsh69c65Oezrvc
 K2PaZPJ4EHcceCfh44eXi4cDIn2HzSs4syMIQVQf/Q/bRryki3xTlPRwAaLKMRmp
X-Google-Smtp-Source: AGHT+IFRj+IPjAu+ZLe7pYPx3EsLGYybdG1EozzrwQ8TYu9qesZOiZaauU4yxthkSrf6JESEIKXUQw==
X-Received: by 2002:a17:903:3c48:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-22df358762bmr13027345ad.48.1745960948821; 
 Tue, 29 Apr 2025 14:09:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm107801645ad.17.2025.04.29.14.09.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 14:09:08 -0700 (PDT)
Message-ID: <75cc3e9c-05bc-46e0-9bd0-d0c889133434@linaro.org>
Date: Tue, 29 Apr 2025 14:09:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] include/system/hvf: missing vaddr include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, anjo@rev.ng, richard.henderson@linaro.org
References: <20250429050010.971128-1-pierrick.bouvier@linaro.org>
 <20250429050010.971128-3-pierrick.bouvier@linaro.org>
 <e178a430-7916-4294-b0c3-60343ce6f023@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e178a430-7916-4294-b0c3-60343ce6f023@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/29/25 12:13 AM, Philippe Mathieu-Daudé wrote:
> Hi Pierrick,
> 
> On 29/4/25 06:59, Pierrick Bouvier wrote:
>> On MacOS x86_64:
>> In file included from ../target/i386/hvf/x86_task.c:13:
>> /Users/runner/work/qemu/qemu/include/system/hvf.h:42:5: error: unknown type name 'vaddr'
>>       vaddr pc;
>>       ^
>> /Users/runner/work/qemu/qemu/include/system/hvf.h:43:5: error: unknown type name 'vaddr'
>>       vaddr saved_insn;
>>       ^
>> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:5: error: type name requires a specifier or qualifier
>>       QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>>       ^
>> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:18: error: a parameter list without types is only allowed in a function definition
>>       QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>>                    ^
>> /Users/runner/work/qemu/qemu/include/system/hvf.h:45:36: error: expected ';' at end of declaration list
>>       QTAILQ_ENTRY(hvf_sw_breakpoint) entry;
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    include/system/hvf.h | 1 +
>>    1 file changed, 1 insertion(+)
>>
>> diff --git a/include/system/hvf.h b/include/system/hvf.h
>> index 730f927f034..356fced63e3 100644
>> --- a/include/system/hvf.h
>> +++ b/include/system/hvf.h
>> @@ -15,6 +15,7 @@
>>    
>>    #include "qemu/accel.h"
>>    #include "qom/object.h"
>> +#include "exec/vaddr.h"
>>    
>>    #ifdef COMPILING_PER_TARGET
>>    #include "cpu.h"
> 
> What do you think of these changes instead?
> 
> https://lore.kernel.org/qemu-devel/20250403235821.9909-27-philmd@linaro.org/

Sounds good to me, it's the right include set.
I tried to remove cpu.h, and noticed the error, so readded it, without 
investigating too much.

Feel free to merge the current patch on your side (or the version you 
wrote, it's ok for me).

