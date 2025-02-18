Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75E2C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQoT-000333-P2; Tue, 18 Feb 2025 11:51:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQoQ-00032Z-Ce
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:51:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQoO-0003iw-FX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:51:09 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso3724907f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739897466; x=1740502266; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7CWeBBFbyvgm068mE6Y6Rbh2Sn6NIPxzakzmct2FlY0=;
 b=rkSe/InSuURNpmrxkHftLNfTldVzq3C3pPt31uVBr/16Tb0n7YrzGzxx3wNPdO7Mqi
 7HPzd2L/AdUXzmrVYV5+O9u36q7YOU68itJ0FcI74/IbxEPT1QzypbQlESR8GAS3GcUX
 d/hPFoGzj4oKAl08xPHqlMtKmzeP6vnLJRu5XEfTZF2KodxsLviMfXvb2Wx2AGls+Uqx
 wCCD1Usvnq2qdGqB8gS3eiJKReowhvlFz41HJ8F1EyjGDtcDXFKVp7pY4Qsz0uJ6XICl
 iI9nQlVhzR6grN33SRGJhoqjZGP+frTjDuEhihgVaAIxe+NF1JsUZQLrmfxr6c6FCQ7G
 MEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897466; x=1740502266;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7CWeBBFbyvgm068mE6Y6Rbh2Sn6NIPxzakzmct2FlY0=;
 b=RbS/B1tZhleJVvDlX9mSt0+/H3oOqJD3m+ptcwP2bDjbtYHfXkNeyusADigvuDbXee
 GeMVZZKYP9CVA6Ufaj9rmmhMShm0s27HmY749NnEkIKiSKSQ8b+DTr1MMNcvC3hEmR+w
 vc4L7cswzrCt5CGgqyreT5M+cLuMlBMPNwhb7gHXAAz0Y5euyEaCpeRh9Uz8glEYwUav
 w8RkPWN1de+To85xvxSHXNSASMMDwwU7sZuoF35s+V1OP3pNpAUg2eiSct6w/fiwZ8SK
 +LmBYk5ZmZAj1re/2Pjcb0hfgGhpqGMclweN6bLBs3csqh93TldNtn/ekzVwn7nFCw7y
 x3uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYvSiFMbwsPPzu0oFEET09G9aq33YjM1XeBAIEAoDfu/AQqpc5/BQ/553CcvAsGbbKfsV8ig3P1JOi@nongnu.org
X-Gm-Message-State: AOJu0Ywvnx/kZ/0AWr+2iNYte0MBtR5fQvHpaXsmgo7Lo8E/Xw3FRPbv
 csZEwGUKu1nk83kBErjeh/UnDUeJt8i0Y3O+FgPnUtmEfUEkEeLUw0NPoDB5qcw=
X-Gm-Gg: ASbGncu1WRu/yNewysHyF086CS4J/AMwf7EMI7q9oKL0UnQIwFzE7KAAoenSvMvdWFd
 dKu+SRw6VFsCgcr3xjgwHzCFN39qJJBWAFuIsWvIUhaAJ4XP37BiYEnHEo1pEAltTJ+iTP6b/TM
 1C1Xj4SHkq7ujzI0LuTJ6F0vTqmfoZThdJ3IMq8pN3Ij8IpqIPYRfCwEwgEVQJTVPhmWHBWMwIC
 XDLQsOruSQXtlhTlUzcDssP7WTfWJIxuTO4/vUMEsFv7svXrMwQN56aniJTEpoBRyGQAhih1Cl5
 F792sXPQMrRDSKVhyy8KMsxn+UJCayqe1CFiC0dj8X2btWUGP1K2YvB+20s=
X-Google-Smtp-Source: AGHT+IHJtHP6+twHGnGF3l/G5UYk/1yKE+7dOqg08qW+cEBXFmew6lWgeyrmRGlIAuLZKqLdZulLfA==
X-Received: by 2002:a05:6000:1866:b0:38d:d223:f8e6 with SMTP id
 ffacd0b85a97d-38f585ea6cfmr199818f8f.0.1739897465327; 
 Tue, 18 Feb 2025 08:51:05 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b431fsm15313687f8f.2.2025.02.18.08.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 08:51:04 -0800 (PST)
Message-ID: <aa821006-9cef-489c-8414-288985666989@linaro.org>
Date: Tue, 18 Feb 2025 17:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/19] qom: Require TypeInfo::class_data points to
 const data
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20250212213249.45574-1-philmd@linaro.org>
 <20250212213249.45574-20-philmd@linaro.org>
 <40b1b0b1-e019-400b-9d06-079ca472b7e1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <40b1b0b1-e019-400b-9d06-079ca472b7e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 12/2/25 23:11, Richard Henderson wrote:
> On 2/12/25 13:32, Philippe Mathieu-Daudé wrote:
>> All TypeInfo::class_data point to const data.
>> Enforce that in the structure, so future class_data
>> stays in .rodata.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/qom/object.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/qom/object.h b/include/qom/object.h
>> index 1d5b0337242..31adc2ef174 100644
>> --- a/include/qom/object.h
>> +++ b/include/qom/object.h
>> @@ -488,7 +488,7 @@ struct TypeInfo
>>       void (*class_init)(ObjectClass *klass, const void *data);
>>       void (*class_base_init)(ObjectClass *klass, const void *data);
>> -    const void *class_data;
>> +    const void *const class_data;
>>       const InterfaceInfo *interfaces;
>>   };
> 
> 
> This doesn't do what you think it does.

Per cdecl(1):

const void *class_data;
// declare class_data as pointer to const void

const void *const class_data;
// declare class_data as const pointer to const void

> I'm surprised it compiles.

I had to add the previous and virtio-pci patches to make it compile.

How should be what I'm looking for, or how should I describe it?

Thanks,

Phil.

