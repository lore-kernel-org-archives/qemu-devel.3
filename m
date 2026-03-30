Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CE5FF4934
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 03:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w73ae-0004wI-0P; Sun, 29 Mar 2026 23:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w73ab-0004vl-Dz
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 23:46:57 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w73aZ-0005at-S1
 for qemu-devel@nongnu.org; Sun, 29 Mar 2026 23:46:57 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82a62714fe6so1566739b3a.0
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 20:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774842414; x=1775447214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YiQamVYxlcFGZQfv9meeF2jjjsQSs82NLF9lQ4MzMpk=;
 b=yzkQ2T0Qfoonb3inZRCLilmo4dLlMGvu29BcwmpemIRNQvkTu+3iC7jqCZwLjOACgH
 7lwT/GeeKppLdTYXpN2gdNMFcsA9njJFukw0yBW45x8fzJRTAVhA3jdCbI+rRljnEUv9
 zzrFUId1sKmctgmqUrQq81aporbvPY0liO0/txvL+fao0rbeN0ZXHG9UH9twHHOc3WMb
 GCGssR6fAgClY1KgBTslxizt4z4Y2G5KnMTXbifd3lPru0nBsBvT/GHP6/uoIiD2Sjgh
 3cF2hl27en8X/zeDNKAkFFVdr6pWKI4at0dKon2NlDR3nUWE7p6nldmx8sxdSBaQkTwc
 L3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774842414; x=1775447214;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YiQamVYxlcFGZQfv9meeF2jjjsQSs82NLF9lQ4MzMpk=;
 b=EziY5Y0D22Tox0MkJn28i3L958Bv1DrTxYm3gRkcZCtC9eVVUaSw/6f7s2omw1/cGw
 qmPG1V0P8E/gnsoQwYcUlMQTdgYGIhA4oxhAdIucHT4z/JMrWXalOYPYKnZzeOfBdh+5
 c+I3kkMcOaaDVHZQ9FDO04KJNtIm+ckLIex9IX3OuaFKEUgtd0smGd4G86ELQ1g9JE+S
 CcknDuAvVJ7ewQHepkSLVQH7AzbxrLpHKTTy9t1QBWbnJhYI8VVg6Cqa9Ma3367DLbpj
 rnaJNifAl2itVvlfYX7M74z56e6re9snV+vLKc9Coa83m3sTkaVsiEFlSaZEHIwrdaHk
 vicg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVduFxHC7YuCPkkfuFD3N88ZJgFhrQF2FLZApwXdZl3kndnm29C46sfs4NBxI3j4Jcr9DzPZMqK4GxB@nongnu.org
X-Gm-Message-State: AOJu0Yw/VMC0MWxnn9vP1G3qLDZ0Zk4gWqOLNIUgEa91PxnMsfSdQlp4
 7B6kKKltT6xJgabb8OeGARXVaQoANlfD5482h3nv1CRoVtov0+OhGBFKbAHX/fsEo+s=
X-Gm-Gg: ATEYQzxpPBjoXOFRCiF5Trwl89WrjvTWN0N5gsbwPiOGe9LYxHnrtE8jpWGba31pQYG
 5i/e9Ve/v+SEjPLYuT+qMtamKJIGb25kyPNhXVgnV/TP6kO+tZWm/6HJh5fRWcj9djt9cjNkw0i
 psP5N0szDSX/vbmgPopjrBEO5MlcWmKD5XCcyXCi5Os9DoXqs7CeItRJFKVOv4ZZ8pq6EbBziR7
 5oEAnlEItHf8ZZWD3sYxObwuSylfmSwbIiA8Ik87D8aOLbC9VFmmqNDM2qMIJTDRGGXcz5alZPy
 FEBTbC8lXC5JXtGneZz/PXFwwefV+j0BODZAlnRg2djHpLktpxqkQooNjPpk0nCSUG8t1f7KbdA
 730LaRf+McJgFxpvHu6JSEsSu1xLGIA7wRyywU4GW96Zu83fvP2U7DUut6glcgh8mRf7Qpmxznr
 jwA4Z6QwlCB7oSxqzK3Q1JXfx+hiKJSFRFJ4qhE1s=
X-Received: by 2002:a05:6a00:3c93:b0:82a:14db:68d1 with SMTP id
 d2e1a72fcca58-82c86a54bdamr12103630b3a.33.1774842413933; 
 Sun, 29 Mar 2026 20:46:53 -0700 (PDT)
Received: from [192.168.4.112] ([103.73.85.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82ca85fc6e9sm6424691b3a.46.2026.03.29.20.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2026 20:46:53 -0700 (PDT)
Message-ID: <8e71cd16-7938-487e-91b9-2863f1eef15f@linaro.org>
Date: Mon, 30 Mar 2026 13:46:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/12] target/arm/tcg/translate-vfp.c: make compilation
 unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, jim.macarthur@linaro.org
References: <20260327165042.604105-1-pierrick.bouvier@linaro.org>
 <20260327165042.604105-6-pierrick.bouvier@linaro.org>
 <b6895297-c24b-4605-8d2a-a8566dfd3604@linaro.org>
 <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <1c34141c-7b26-4e15-885e-27c15382ac07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/30/26 12:34, Pierrick Bouvier wrote:
>>> -arm_common_system_ss.add(files(
>>> +arm_common_system_ss.add(
>>> +  decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp'),
>>> +  decodetree.process('vfp-uncond.decode', extra_args: '--decode=disas_vfp_uncond'),
>>
>> How are you not removing the other decodetree invocations at the top of the file?
>>
> 
> They are still needed for user binaries.
> As explained in commit message, we don't have control in which folder those .c.inc are 
> produced, so we have to duplicate them to make them visible for system_common code. Since 
> they are not proper compilation units but templated C, we don't really have a choice here.
> 
> The only alternative, if you prefer it, is to remove them from gen_a32 array, and add them 
> to arm_user_ss. In all cases, duplication is still needed.

Maybe I'm wrong about how meson works, but does invoking .process() twice result in two 
executions of decodetree, two different file objects, possibly with identical names?

If you want to share these, do we need one invocation, storing the file object in a local 
variable?  Akin to

vfp_d = decodetree.process('vfp.decode', extra_args: '--decode=disas_vfp')

gen_a32 = [
   ...
   vfp_d,
   ...
]

arm_common_system_ss.add(
   vfp_d,
   ...
)


r~

