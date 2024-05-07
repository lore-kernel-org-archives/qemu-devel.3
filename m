Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB45C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LOl-0001OS-P0; Tue, 07 May 2024 10:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4LOf-0001Mv-ME
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:02:21 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4LOc-0005Be-0W
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:02:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5591so23944315e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715090533; x=1715695333; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cRrhTT4on/Pz3+KiB/1RGVfKMqeTadB9NOvAWxCotg0=;
 b=POOQQIyXB7Pq60tudypsDHPw9hwZVV32mI0WjjiIA0zIccxbQtc+rEWrGPC8tgvrdK
 SAyj2iO+un5/lZWtoP1OR2bjB0VXpdIBInvRoXiQ0V6cjCVQVqE8hHPodNlkykRYCddi
 BLRctA60mBcRFs4/QuJlN3DOCxH+CVjQ70aJVOCXHSg2htdFCCOObBo9wi3mrLSUeMBC
 r4urmqE66y+eh2AWoizu5Xt7hKnmTDSnTI5d5jY8wW7iei+D5zsknpfo+Cvuu9rYXspA
 OZWQJGpnLfQojrkug4c5foDLPH3W36+A1TdWIO7iO7mpgW/P8KSQ9nJYYkfW6b/ELwBN
 x5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715090533; x=1715695333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cRrhTT4on/Pz3+KiB/1RGVfKMqeTadB9NOvAWxCotg0=;
 b=IS0vzAkvDDx1NUL2pa2o6yn7eD6+A7HDuR8EA1PJlEfcEe7PY77HHP/47YoDfMzjVI
 LqZZec9ycamw1lSUKCdr/K6EDWbjzEVbjLU62EouOqvVEbhaWEQSj7mQ6oT5AgFiwwEk
 XAnVUp2Em0rLvUsrlKQWyABvbEKypA7gzznoWcfJfPhFZsJEMJXqJ58i/JuovwmM1yo0
 NCBMDhY/7cdPYoMupS50DyTW1HJpvEBhfYEAHPkp2JstCQvOGGVc6j7zehRk3VX+8JR/
 w3pvP4m8yXPPL9dHni7tSvrfx3KM0FHWrmfqlRT5oZvNHzVeQtBUkS5hzrjsXYMYzgdS
 MTGg==
X-Gm-Message-State: AOJu0YxqDEbzSVm6X5KQ5lub5hqUzLW7J94Z5rdZ6nKEKIn4CUV5fl/M
 f5vSAFMeEFtk44zg13FVfLmbqUqpCaR+TuR/fwh0nFIdOsYr0LY/5+wJcf+2pBw=
X-Google-Smtp-Source: AGHT+IE5nvRl4AJfa8L+Nl5fUSiORws88wlVGm1iDIXsOO2BF5Wr+B+/JD1888Tt3Bgm68tMM6Z1jg==
X-Received: by 2002:a05:600c:1f91:b0:418:be2e:df9e with SMTP id
 je17-20020a05600c1f9100b00418be2edf9emr8188410wmb.41.1715090533303; 
 Tue, 07 May 2024 07:02:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.243])
 by smtp.gmail.com with ESMTPSA id
 j8-20020adfea48000000b0034dcde55043sm13025943wrn.101.2024.05.07.07.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 07:02:12 -0700 (PDT)
Message-ID: <2280ede5-0455-4086-9925-bd9d473d190a@linaro.org>
Date: Tue, 7 May 2024 16:02:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] system/physmem: Propagate AddressSpace to MapClient
 helpers
To: Mattias Nissler <mnissler@rivosinc.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, john.levon@nutanix.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20240507123025.93391-1-philmd@linaro.org>
 <CAGNS4Ta9aV7ch5DCdMe=Pk3eB_3+0xx8fCekvuiAPb6hz=Yx_g@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGNS4Ta9aV7ch5DCdMe=Pk3eB_3+0xx8fCekvuiAPb6hz=Yx_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/5/24 14:47, Mattias Nissler wrote:
> On Tue, May 7, 2024 at 2:30 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Respin of Mattias patch [1 split to ease review.
>> Preliminary use QEMU_LOCK_GUARD to simplify.
>>
>> I'm OK to include this and the endianness fix [2]
>> if Mattias agrees, once first patch is reviewed.
> 
> To be honest, given that this patch series has been lingering for
> almost a year now, I'm fine with whatever gets us closer to getting
> this landed. I believe Peter was also considering doing a pull request
> for the series, so you may want to coordinate with him if you haven't
> already.

Well I'm sorry, today is the first time I've been looking at it,
and was trying to help reviewing. I see I was Cc'ed on earlier
versions but missed them. OK, I'll see with Peter.

Phil.



