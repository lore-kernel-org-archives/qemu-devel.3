Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46D2C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 18:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TXD-0008LT-Me; Thu, 17 Apr 2025 14:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5TX2-0008GA-KD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u5TX0-0000HI-4L
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744912806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Ka7wN4rp2r8Gx3z4HaHZcnc7BzqNjGElmV0E88hsTM=;
 b=HMqtH6QA3RfNlV/CkmuNr4j5jIYxWFf1tcH6G5C5LgrY/6lFrQ9qtqFbfFj0Yxa6/RoUiU
 tvDOJfMWtVxefodjejfArd9tJhPQbr0Td88c4uYyOXYbFsnvLENb6x2at7XX/UTYWwPJXJ
 0ZHiz7yeeCDo9NfvufQSLBeKEnfvMjE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-EsQkBoHTNTaUmfmRMvgxCA-1; Thu, 17 Apr 2025 14:00:05 -0400
X-MC-Unique: EsQkBoHTNTaUmfmRMvgxCA-1
X-Mimecast-MFC-AGG-ID: EsQkBoHTNTaUmfmRMvgxCA_1744912804
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39126c3469fso439910f8f.3
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 11:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744912804; x=1745517604;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Ka7wN4rp2r8Gx3z4HaHZcnc7BzqNjGElmV0E88hsTM=;
 b=B1sX0CalG0tF3cndGVLvJEHS7ITx+hxC32ETNYEwOy5UlBBStTvsswoMZvjcx01DbS
 UmaY1vQB082qnPXQL3p2Qno+Yhbtl8CewUQWfUde/jaE48nnxBHDRfpmB5LMyZvay1ct
 qXfdRhJBM2hDqtu7FDpbZQoM/pMIcV/wuWihzZSgYf79squKuVKW41LAGvp3y4VoN/GN
 xEEUs+9mjJYYflM9eJzji5w4n/hcbUamiU1Uxw8u89dPv/ydRWOmypu37nCA6ilzfLaz
 UcfYH5dAQ2CsnSoXX3gE9/aOX0ZFiCnrSEUD74fBEWsBNqpihQJqlmeqyP9RenpkrqgV
 QPww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnhg25ucxGL8H5S+o+dUBVC0oyNF/HRgsgx5f6OJr7qNqvxps/MKkbkVH2wvypTQ9my8SFVLqnEKv1@nongnu.org
X-Gm-Message-State: AOJu0YxYNpQPaGwcwYIedIwOTvGc55gW9TbY4wYHBVG8HxF02ryIFGCn
 +/Y2bB14vSayWsYCnW5KEJrTL4B1G0U0/2H11KGuPhoUwUPMQKIjm8xgQcxidyeDaxRk4/D/fdc
 sUk2/jskj5APdJrDKXu4jACsQ0eZcgfkmJ8buwUa7yEP/PZmbKXQy
X-Gm-Gg: ASbGncvei0stMWkU1So1SJlKgjAFwVs6Sf2pMhvKqVelspJsE1MHIQ4KiDDDnDzgAQf
 gQXxaAPGr54f6aZWOhYa2302HLnizPjwZLO9OD3qirubK5Nfb6+BNQKkiqpseyjU3Iv55480+bw
 Icj2nYX92ZO5qvJsn9phBdMAM46RkIOdV1lp1Hi6t9+tn/fWOABFMnN7VI16zIpgPlc+OEn4Yij
 aPChu5PNeX7+f9dGalicusHpedP+BpbbfeeAN5iWAcT5hA+TluQT4FMAGGXckWwOMRjHvLel5vp
 I/OKkjmaDFtQP2kC
X-Received: by 2002:a05:6000:2283:b0:39d:724f:a8bf with SMTP id
 ffacd0b85a97d-39ef9e84607mr499845f8f.4.1744912804133; 
 Thu, 17 Apr 2025 11:00:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn52cDSTe7erLt96yv3SpJmP2vrfSgloJu/BBbt00d7Nk2W4kXY8cynykClrNFH3IxPWPTaQ==
X-Received: by 2002:a05:6000:2283:b0:39d:724f:a8bf with SMTP id
 ffacd0b85a97d-39ef9e84607mr499827f8f.4.1744912803758; 
 Thu, 17 Apr 2025 11:00:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207afsm340717f8f.12.2025.04.17.11.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 11:00:03 -0700 (PDT)
Message-ID: <00989085-0f7a-4fc3-af66-b254b94a9701@redhat.com>
Date: Thu, 17 Apr 2025 20:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 06/19] target/tricore: Replace
 TARGET_LONG_BITS -> target_long_bits()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-7-philmd@linaro.org>
 <58473afb-337d-40d5-933d-447531c2d52f@linaro.org>
 <e1e04023-baa8-4a1f-b8b5-64e6f5830f7d@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <e1e04023-baa8-4a1f-b8b5-64e6f5830f7d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/4/25 19:53, Philippe Mathieu-Daudé wrote:
> On 4/4/25 18:48, Pierrick Bouvier wrote:
>> On 4/3/25 16:49, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/tricore/translate.c | 6 ++++--
>>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>
>> The temptation is good, but please do not touch any target code at 
>> this point. We want to focus on defining the API first, and we can 
>> perform codebase changes as a second step, without letting any 
>> occurrences of the old macros/functions, instead of just adding 
>> "another way to do it".
> 
> I meant to remove these patch before posting, to focus on ARM, but
> apparently forgot to do so...

In this particular case TARGET_LONG_BITS is a constant 32 (and 32 is 
present many times in the code), so it can be replaced as a cleanup.

Paolo


