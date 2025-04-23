Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05461C369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 20:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7h3H-0003bq-Kr; Wed, 23 Apr 2025 16:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7h3F-0003bb-CV
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:50:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7h3D-0004bg-PP
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 16:50:37 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22c33e5013aso3718795ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 13:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745441434; x=1746046234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wIy15xrOE+YZn7Txu/ZnurLRmzccmN9v2f0qlSRFlBc=;
 b=qrtbkBCeGvX2+2CTAcctCDOG1pReNxHxNS+VLDYRq4QGkHzdctz0yt05rTr2VNf7hd
 EK23fYzmRRrTQ4vpJtBkdgYkH2VCOUCEjud02gF9XMQu6PHR93Jb66f20IVhHQmf+G8H
 +Mw2lio/AUWlnp/Z+4INrwWpiJIJiI/gfBGKEluIzSp21xStjU8ZfLMycpnKd/mcfbQR
 6aKdQ7kBrqIlDYaFBDOX80PaFi7vcrHTrv+g7VVrYOCBvjYhdcU0ItVJFg4MHkW8fBwT
 WdV7bH2j99KWqBpprHFGcedUQM2Z8AEHMihpZkxT/avGUGf2UjJyXJ3b9J8RZhpNwcdv
 7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745441434; x=1746046234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wIy15xrOE+YZn7Txu/ZnurLRmzccmN9v2f0qlSRFlBc=;
 b=LiaquCHYuvxT6gFwzy8xte+wTRDSViTFsoSTWXPT8PqTuu0vX6mS3Q1og0c2wowlzF
 QcLTPjg3L+A+9+ABIdJBZHXfy/39ryqoBSXPcC9UF8OEIlW2N0SCDC3LE2udyd94vBH7
 HIqgQiLl6KUNoNaMAWS1N8D1vPo6sGCFhwoMa5ZwGDUjLVZyRagw7Vgqc5TzFNNngdLs
 G29R7yA/zMwe1u/glnt2OjJTeDUKrTdPQGquGotrMPCYPU2GbNYH/Pq08+A01ly1tnfB
 52dUANHMmODUbb6Fb10skuS6tafVi3bE2AN+gVBIm4RUDD5DIgT/ipWZocFcfS9JBvEj
 gu5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8jA9Ak0vg4YERrz8an0l2PtL+n4RbK2XX13MpUKRQTGMGW9BsPeR0sYejR4pQkz9D8e7hJ/6X3AhV@nongnu.org
X-Gm-Message-State: AOJu0YxaGZXD7ZXj1b/gTKxQMQ7Yo9E79TNi9LI1oLuCQKk2kT8Gae+Q
 hpSKqJbhfqn4oC/Yl+VKw3yr8mjABDfyAMwcONvvaES0bRkUQIlEpqVJi7wysLs=
X-Gm-Gg: ASbGncsJ5onyfh2zvgh0FlQIQaA4uKXwvmhpYHzwD063AEcPeJhCXRcMsQSAJpobgzh
 Mwl/bRbYCNcoxoI04UeM4iWkBLyC+vx04cEfkMqja3w1dye7QtNQEU5N7heKvkv/T1K5vGjPpRe
 fj6rFt5DDPVZ65qTu2wfVmYGnUZaA0RXcrz1DlJHOk6EDKkOEk0v3G20NXJ2Ex8voarJ7qovzy4
 frsFbQ2Q56qMifuJvdwKiDT87JsqSMQv28uBo3AfAWlWWH6y5T3Ek1Ss+HR4OS5xXUD2ouAQSLw
 tvAOY9Ny9PHyBJ/1lzWC0wPI4sJmawdDcjJcUnegF5TPcjcW1Y0UvTwhUIVFFVE49cqUkH4zQIE
 ICrRck4Q=
X-Google-Smtp-Source: AGHT+IG81tVoRqHefnfqtgLP2CQQBXr+QUXWs0001ik7yY2MHhxTL8O+bl1rctL18dfB3760lF2LiA==
X-Received: by 2002:a17:902:e80d:b0:223:53fb:e1dd with SMTP id
 d9443c01a7336-22c535747d6mr255096055ad.9.1745441433925; 
 Wed, 23 Apr 2025 13:50:33 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf5398sm109635205ad.90.2025.04.23.13.50.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 13:50:33 -0700 (PDT)
Message-ID: <823947da-cc09-45cc-993a-7dc728e7e88a@linaro.org>
Date: Wed, 23 Apr 2025 13:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 013/147] system/xen: remove inline stubs
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-14-richard.henderson@linaro.org>
 <dfcf9c43-4585-46e0-8d7c-0855d348c38a@linaro.org>
 <f54bd881-f75f-4a89-a293-7d49f82748bb@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f54bd881-f75f-4a89-a293-7d49f82748bb@linaro.org>
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

On 4/23/25 08:58, Pierrick Bouvier wrote:
> On 4/23/25 02:22, Philippe Mathieu-Daudé wrote:
>> Hi Pierrick,
>>
>> On 22/4/25 21:26, Richard Henderson wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-ID: <20250317183417.285700-14-pierrick.bouvier@linaro.org>
>>> ---
>>>    include/system/xen-mapcache.h | 41 -----------------------------------
>>>    include/system/xen.h          | 21 +++---------------
>>>    2 files changed, 3 insertions(+), 59 deletions(-)
>>
>>
>>> diff --git a/include/system/xen.h b/include/system/xen.h
>>> index 990c19a8ef..5f41915732 100644
>>> --- a/include/system/xen.h
>>> +++ b/include/system/xen.h
>>> @@ -25,30 +25,15 @@
>>>    #endif /* COMPILING_PER_TARGET */
>>>    #ifdef CONFIG_XEN_IS_POSSIBLE
>>> -
>>>    extern bool xen_allowed;
>>> -
>>>    #define xen_enabled()           (xen_allowed)
>>> +#else /* !CONFIG_XEN_IS_POSSIBLE */
>>> +#define xen_enabled() 0
>>> +#endif /* CONFIG_XEN_IS_POSSIBLE */
>>
>> Just to be sure, you said we should remove CONFIG_XEN_IS_POSSIBLE?
> 
> More "Ideally, it should not have been introduced", and {accel}_enabled should be a proper 
> function, and needed stubs should be added for other functions.
> CONFIG_{ACCEL}_IS_POSSIBLE is just "yet another way" to stub some accelerator functions, 
> while we could have proper stubs instead.
> As long as it's not blocking our work, I don't think we should do this cleanup.
> 
> For your case, concerning hvf, I said it would be preferable to simply implement 
> hvf_enabled() as normal function, instead of mimicking the CONFIG_{ACCEL}_IS_POSSIBLE 
> pattern, since it has not yet been introduced for this accelerator.
> It it's more simple to simply replicate this, no worries, go ahead, it just concerns one 
> header.

It's obvious why it's done though -- expanding accel_enabled() to 0 lets the compiler do 
more dead code elimination at compile-time.


r~

