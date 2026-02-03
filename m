Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27793E83041
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn6FF-00015r-CO; Mon, 02 Feb 2026 21:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6FD-00015g-Tg
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:34:23 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn6FC-0004Qz-Ah
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 21:34:23 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a7bced39cfso53921655ad.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 18:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770086060; x=1770690860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ByiZxjxpmM+8p/5SDU+uhZ74sfObowyYTpL4OkvIdQ0=;
 b=Z8Yrgrpstel2LXv31ZWqyCQ4TncfnoLYo0hM9rrUJsqEUSiqzo8AI7kFBtyK9WenrH
 JwzmqcOu+Sx80q9TwbB+Hynvl47JprDr3gLR396QVAZStujs+WC21QuL1xtdJl6rel5N
 5Vphqt9ZWQowFD2HaMkDQb91eg38/xTFB/1FsAcYgpL4Z5XSOE2UN7T9T2xmUsE0jN8B
 pFBHljp6sRGxRkpdJupDlrmDdyRnMrAEdUOxmTNtl0r3Igvx6VwP22uG+j/GTgaYnGjB
 cNqkjXAFlPnE5T0mggbfs3MGS4wDIhhHEymtcKfMG/hiu3+Sss7Yrp20Co5M6EX21vmC
 Z6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770086060; x=1770690860;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ByiZxjxpmM+8p/5SDU+uhZ74sfObowyYTpL4OkvIdQ0=;
 b=B9u2wVxt3PXSFUVPw0pEYCh/YvcaVYQX6Yxevu3uT4HO7chO1RPut+NFVq2rNMVADK
 Azb4lcn7oKlICIOoDuWfo9pIFEWFrV6TyDg4g9xtZoMzwUcVDhuLD3LtaJ0SR1R04iDl
 qppY6fnN6QwCVKspC81iDoHXvcMcjlVDpmOSAWRTJmFXDkpUKdG1xz7/KhE3+m04R3lq
 VuuF7JvH1/2mMXxupvFpKBfuukMTNOtwGbCIpINeoDvHoi9bczWBbLLzD2hfgAdhFGDm
 L47OUXkhlR7dEDwNO3t7j5LhmIHZCtqeh+6c3X0n9eJ69Vyg3QdkdNrVCCvzaVi9q7O/
 Qjlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/IjcnAtL4O1jj76i8N+IxckKoqxxUqE0jLJOJmS1umLN9dH80TmyfChZYMlGVQX6Yy6KbPUdBhXqX@nongnu.org
X-Gm-Message-State: AOJu0YykKVuBYvt6K5oLzXWrMtoh3W1JV1SWD/Oa26F3YuQ8lViSl5t5
 8lAKyo9zSKK8rsbhxHd2rf2MzklkmvfTS+gHSbyCoFv3KnQzfGdT7EAbmZM/xx0YTWq8PUkipjZ
 kaflUUMFYXQ==
X-Gm-Gg: AZuq6aIo0ayCM9LVeSyXxyaJ5tvkIqusOVi+05wSPcOqbcegeJaY73pu4FoBeGmZFAu
 Y0lTZGPWBxxXRCa0ZIkHBhbqCbg7KKaQMEowg5Sh/TsfpaxgfLZNSdJmGl5zk/v32uDTBxWeW9I
 phjVYE+M7C9e7UubSzR0LsYKnzWg/zzmAhjyXU1qJPaiHdAsLlNuVZ9VxlgN1mQrcRXe39bYHwp
 fdwop0q8neJY2PqkG+IGtT6BtIW0cVwrXXbp3wIw1c6GIsAjU8K1oxgju86x3T8lN7H11aP2Nvv
 QvIK4JxqgK5AOc8wC0/mzC8cT6fncmGJISuxcPeJOSb9aIYhXSnxE1GoYJwIiFLvUHB7R2yHR+d
 GH6KOs67JYARPO+jGpWljKHL2D8rOT3RRHCIy4du37ZituISkuiUcvYxuh/Nz7dq2gmzbooPn+W
 /vj0RKcS9x9icUZD3Uu+K5Sqlgq3FHFgwsJ/DUhcITm1enRMOMGyu4LhwS0KD6++vamvpMtS/vl
 mFGXCGbE+BintV37/zFf5BWPoYP+HoV6pI0njhAAw==
X-Received: by 2002:a17:902:c94d:b0:2a2:b293:27d2 with SMTP id
 d9443c01a7336-2a8d9a81be2mr140194785ad.53.1770086058252; 
 Mon, 02 Feb 2026 18:34:18 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b4173a2sm162956015ad.30.2026.02.02.18.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 18:34:17 -0800 (PST)
Message-ID: <dd227adf-2227-42cf-a433-eb42b68b3ff2@linaro.org>
Date: Tue, 3 Feb 2026 12:34:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
To: Panda Jiang <3160104094@zju.edu.cn>, qemu-devel@nongnu.org
References: <20260128010715.347776-1-richard.henderson@linaro.org>
 <20260128010715.347776-3-richard.henderson@linaro.org>
 <396462f8-b3f5-4451-9d5e-1ddcad195e43@zju.edu.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <396462f8-b3f5-4451-9d5e-1ddcad195e43@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/29/26 17:13, Panda Jiang wrote:
> On 1/28/26 9:07 AM, Richard Henderson wrote:
>> This uninitialized value violates the contract in the
>> documentation comment, and may lead to a SEGV during
>> translaton with -d in_asm.
>>
>> Change the documentation to disallow hostp NULL.
>> Pass hostp to probe_access_internal directly.
>>
>> Reported-by: Panda Jiang <3160104094@zju.edu.cn>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Hi Richard,
> 
> Thanks a lot for the patch!
> 
>> ---
>>   accel/tcg/internal-common.h | 2 +-
>>   accel/tcg/cputlb.c          | 7 +++----
>>   accel/tcg/user-exec.c       | 4 +---
>>   3 files changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
>> ...
>> @@ -1545,7 +1545,9 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr 
>> addr,
>>       (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
>>                                   cpu_mmu_index(env_cpu(env), true), false,
>> -                                &p, &full, 0, false);
>> +                                hostp, &full, 0, false);
>> +
>> +    p = *hostp;
>>       if (p == NULL) {
>>           return -1;
>>       }
>> ...
> 
> I have a small question regarding the implementation choice. My initial
> thought was to simply initialize *hostp to NULL at the beginning of
> get_page_addr_code_hostp to solve the uninitialized variable issue.
> 
> I've been comparing that with your approach of passing 'hostp' directly
> into probe_access_internal(). As I see it, the main functional
> difference is that in your implementation, if probe_access_internal()
> succeeds but the subsequent check
> 'if (full->lg_page_size < TARGET_PAGE_BITS)' fails, the function
> returns -1, but *hostp will hold a valid pointer set by
> probe_access_internal(). With the simple initialization approach, *hostp
> would always be NULL in any failure case.

Good catch.  I will assign *hostp = NULL along that one path.


r~

