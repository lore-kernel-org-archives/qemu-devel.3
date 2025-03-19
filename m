Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DD0C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 23:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tv2Ud-0002V8-B1; Wed, 19 Mar 2025 19:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2US-0002UU-L7
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:06:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tv2UQ-0003Gv-RY
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 19:06:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-225477548e1so1571705ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742425581; x=1743030381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0B7qZzLI8brQRidgeDupLP9VVQOT4B9SqSdemiBIJrM=;
 b=DeX7jxQlYyca652ETPX7xj9VdVxatrwcueo8oSDCyi70b3hxsScoTn8eZozDULQsth
 ZECrCZ7WJ4i8Do/wvwwJpgs2CXbQ7zsu1G91z2nFXDquhXNzpNCuSA0SKVifKDGq/qF5
 5tWxAU6QQFGXzTwTpTedQFk8xnsiTvgaeFQE8QP4tw3q+MgjEhn75w2kmb2qsNzSiBWF
 pUDZviaInl6vgdgCfDt9E1wlBa5Ib6ZeRJam05wxX/+Lpvv49OHWOg7wAqI2qmYbTZlr
 /WXjH6UFyItDLjfPwII8ioqXaovMi1MhKkFi+FznkkT6dDni7tgiU3ZDePkxuDucJclU
 pQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742425581; x=1743030381;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0B7qZzLI8brQRidgeDupLP9VVQOT4B9SqSdemiBIJrM=;
 b=YAdsBtWiQgO5+BzV//tpiTPIyLqqyuApF6ZqljgqQzBUIhk4fMy16g0/HKjAMrKRzx
 yktl+DtuSCfB68E1GLrMut/7EPXuWsY+TdiDZin2VJ+h0mZxWzwVLYzLBTL5/wMMs4bp
 FAnHtFA2M7xsjLV2+27B9kRUxG1LxEazrKqs82qzXZ23v/m54eO9FE09aF4RsO658miZ
 xH7BOiceGA7ig6NiTbSoCmG3Ngxpkf94GKj2BXKx0px/LPkHqM50lBpSH+rnX+E9SuBb
 rgSZJSGD2RIULedpPbkJ0bC/1CLUyXqFNL0ci49p0HMjCW8w3is4O9uim7lINnsYLL5U
 nAHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqdcb13YLnn+sx7QvsJNoiaybxGYwJXQthIW+RnBiDo0r3VHRyv9sWfLHOoHzTwZJtbFcbFENRRatt@nongnu.org
X-Gm-Message-State: AOJu0YyZC3zj1VZGUJ4kfaE0tkeTeJeeeU0fqW4OD3XE72ibgYdx44ZA
 Tv1+hZyXuBJl51nRzQjT26yPkCbrwcgVHpB408ZNI4sD2SltZ6VS/30a5BT8Ofk=
X-Gm-Gg: ASbGncs8BDYgHRNj1wbuBUun9m/k7RVHShL8VR6iYiJ5BueAKQmPR6zczTqmXXico5X
 qYl6/yq8zFwDk3OZXJtWLh3OSXmPcGz8zZ5cVOYazJzyzwnLe67RbcBNgedVugk86tUnXHVCqS9
 I4GEwrBH/ol/vFdLc294CYFG67v4eqW3frB6Ka4yAxTW5Z31G1I1TbAnm3+9UhgSkBlh2LgNhAJ
 zacfmFg5KhG7X5FCiM/BfkR7keS8ToNK80FI7q58J8FpJTL2Go7TE6xokShay0B67soDhCtHFT0
 3UJAVQn/pnjepF4tqIC0hjlcez8nk93YZ7o/LiHPsJZi8aiF7/gVDVxtwgoKCVoTWiLq
X-Google-Smtp-Source: AGHT+IHtNH2/b50JPe298GmK9alO0tYGjRJ7dXzrqpDLLmEgohh2rXtZhg+BmTK0bW8zlb9NoYW0nw==
X-Received: by 2002:a05:6a21:168b:b0:1f5:5b77:3811 with SMTP id
 adf61e73a8af0-1fd10391437mr2016652637.22.1742425581014; 
 Wed, 19 Mar 2025 16:06:21 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ca18esm9770445a12.16.2025.03.19.16.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 16:06:20 -0700 (PDT)
Message-ID: <0845395e-f306-4fb3-bf4c-9723be4c969d@linaro.org>
Date: Wed, 19 Mar 2025 16:06:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/arm/cpu: move KVM_HAVE_MCE_INJECTION to
 kvm-all.c file directly
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-6-pierrick.bouvier@linaro.org>
 <f1ce73a6-717b-4230-95cd-45505fecf039@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <f1ce73a6-717b-4230-95cd-45505fecf039@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/18/25 15:19, Richard Henderson wrote:
> On 3/17/25 21:51, Pierrick Bouvier wrote:
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index f89568bfa39..28de3990699 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -13,6 +13,10 @@
>>     *
>>     */
>>    
>> +#ifdef TARGET_AARCH64
>> +#define KVM_HAVE_MCE_INJECTION 1
>> +#endif
>> +
>>    #include "qemu/osdep.h"
>>    #include <sys/ioctl.h>
>>    #include <poll.h>
> 
> I think this define should go after all #includes, emphasizing that it only affects this file.
> 
> I think the #ifdef should use __aarch64__.  KVM is explicitly only for the host, so
> TARGET_AARCH64 really means the host is also AArch64.
> 
> I think you should go ahead and adjust x86_64 either with the same patch or immediately
> afterward.  There are only two users after all.
> 

I'll adjust this for x86_64 in the same patch.

> 
> r~


