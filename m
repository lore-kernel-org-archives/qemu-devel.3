Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84892C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 22:38:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIEYC-0005Dq-S0; Thu, 22 May 2025 18:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIEY9-0005DM-30
 for qemu-devel@nongnu.org; Thu, 22 May 2025 18:38:06 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIEY1-0006Ru-U5
 for qemu-devel@nongnu.org; Thu, 22 May 2025 18:38:03 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so6478832b3a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747953473; x=1748558273; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RN4mZHjloUYc5xBEcx0zXmdorZNruJ4VWRnKGIZ7Wbc=;
 b=BE35zbM90I7LK0zqC6Z2ecGuLdfObfhDO1AXJ3YmfvNazXRjyH0kAavb1Qh35ezLfm
 ZNVoFo2pwHITTg1TJfYh/L2NWnJEyPeBgjuM2nu8Q/lriw9YjqadBt9Mr91hnjmCXQPy
 xKM4JYMvqZvZ/EGiTYKe+bcaMihW2wxZMEZlAp5A/ngY2i0xB6mNdZZwAMVuCwQ3KHea
 q50fFk4cIieHbYoP/4BKyRZCG+TxHtQA1APqb6UbjbFWoYtXSHOCk401/m/XBDgcelYf
 LC++UMsERbFbfPubUUJ4s/R02CmdzBeT3MQ1YwEa85rqFMXiV4lgMDKdTExzCV3BcgeS
 Z3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747953473; x=1748558273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RN4mZHjloUYc5xBEcx0zXmdorZNruJ4VWRnKGIZ7Wbc=;
 b=OTVbONMZ3vjQiMB8hjPbkwcVN1Up+LhkZE74UXLsQ99ctXjuug5gCZGWNaW1pNbtQs
 1jM1adiKj2Z9h8eeIgOVfDtvnidoU8Zyg0v4V0Kva5dazH0wc3scEohWFs1DrjsH1B7L
 EHntB1E1E9YOqZasl4yxCIlpZKjsdlyKq52ZV9P+XpW8/pB1utwOhqZVVgRDDydhU7Dy
 v52JQNSCACqPpjJlcgA37ecmOdCOXDuQt6hT0CTBwSSG7wOwq0aleBaU0X+sCOLit4dc
 NxShNiQcYPziiKtDlEb7Cgdx6PGJkUrtlijpuSAgqTyqzBLAQIvK8dJgA6DIJTK9TxjM
 +/Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtuJlze9EJm8taNLdRBvskKDC1XXwu3H4pmqZnWusvsrgTyh2bPXng0SvXEAHmz4Q7M0hknsofwefe@nongnu.org
X-Gm-Message-State: AOJu0YxbusVqO2k7oSU9Q5oCjsQyxeYwxUtLeb2T8ix+2MfYpOXFYxEv
 3hLlIk8Fh6rXiLAGztgtyZMyM/m+pG32lHfBGC80WtnDRZiTCnsZC7YevjIinGnU7pE=
X-Gm-Gg: ASbGncuhaZhDgcwbUpvePLn70GXBLf57H4X1vnv4j8LrbVgg2REdoyisBddUD8s+Bc5
 JaCcubhanGpwP3NoSWnXRCtcFldHMRBaDFwj9h1WJ8TdThuhuWzqKIT4F1+kEmXDh/JYsZvYHeV
 GFOje4/iPYvMGd/lQczN3GV5NlIgCNZxIb00a70mrAXGBjJJukaQfeQ2XWYxeic/ZVCXO8ldXZb
 3cXB8jieM5UpbFrbJWzkre4MHUZnGwcAyBFk+IdRyC4A2rWOJbT7lwbsdgb4YbE6X63E3UGGN20
 ZaQ5oNH10Xq/ec/uJ+AH8WyD4HlP4DltHCDNmuN3LeXUhlByH2TtHnpWv+Jt48sq
X-Google-Smtp-Source: AGHT+IG1Ef+vEla6bYfUvGeaKaGOG2esj1QWgNjZiTA3Ckkd/ybJjDyvbLtkiGVk69RI84RMPbWsXQ==
X-Received: by 2002:a05:6a00:4106:b0:740:9c57:3907 with SMTP id
 d2e1a72fcca58-742acd50f3amr36895617b3a.19.1747953473103; 
 Thu, 22 May 2025 15:37:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96e589esm11695457b3a.9.2025.05.22.15.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 15:37:52 -0700 (PDT)
Message-ID: <25730845-c77c-47b0-8c23-a254dbbb32d6@linaro.org>
Date: Thu, 22 May 2025 15:37:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/8] Add memory hardware address read/write API
To: Rowan Hart <rowanbhart@gmail.com>
Cc: Julian Ganz <neither@nut.email>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-6-rowanbhart@gmail.com>
 <20250522115935.34716-3-neither@nut.email>
 <bbbc7639-9ef0-4510-b481-0c3145b6ff11@linaro.org>
 <CAE5MsNaacPXefwk=tsUmmAoxUZ9UU3uc084rOT7TOarW7Y7FwQ@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAE5MsNaacPXefwk=tsUmmAoxUZ9UU3uc084rOT7TOarW7Y7FwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/22/25 2:01 PM, Rowan Hart wrote:
> 
>      > This definition strikes me as odd. What was your reason to assert
>      > `current_cpu` here, but not in the other two functions? Also a bit
>      > surprising is the declaration of `cpu` if you use it in just one
>     place
>      > (rather than just use `current_cpu` directly as for the assertion).
>      >
>      > And there is no reason in particular why the vCPU could not be a
>      > function parameter of `qemu_plugin_translate_vaddr`, right? You don't
>      > have the same restrictions as in `qemu_plugin_read_memory_hwaddr` or
>      > `qemu_plugin_hwaddr_operation_result` where you actually touch
>     memory?
>      >
> 
>     That's a good point, adding a "unsigned int vcpu_index" to the
>     signature
>     should be enough to query current or any other vcpu easily.
> 
> This is a really nice idea, it might be nice to make a vcpu version of 
> read/write register too. For memory, I'd think going with the current 
> memory is probably fine, I don't see any configs with different memory 
> per vcpu?
> 

Thinking about it twice, and after reading Alex comments for writing 
registers, it's probably not a good idea to allow such side effects on 
other vcpus (on registers and memory).
In case of registers, there is nothing ensuring they will be written 
correctly, so it only makes sense for current_cpu, as we are in a 
callback running on it.
Safer to have the same semantic for memory read/write also, so please 
forget my idea.

