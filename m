Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30706C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1ODc-0005Y3-Ao; Mon, 29 Apr 2024 06:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ODa-0005Sq-Bp
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:26:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1ODX-0000SF-HL
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:26:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41bab13ca80so17708095e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714386397; x=1714991197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znmZeJkGaSCtxVUBkfoWyfWxlq6LW1KJw9yscTqdCls=;
 b=uafpNz7Yh1vUEcU00qiBPfVEYfe4TKkxUY6tslVavBjJ9B35QfJmpb+uxiZzXyZiRO
 yTSnSi569UEeSrk24kqNjZioDpy+S80s2JKSMaWvSB58wK1SE/CkqFiz3BtTGu2kJHIz
 /ESOPofebFup4k9c5Cj+4CYpx5FZQ9xihuO2Gi1w39JQBxT4WaaTq119C7O+o2OEk+0T
 TgHDgD2nh7g/YOj/+ri8L0bAqDQpk9rX4Uhv9M01c58UEkYNOfL3qoSnHVNe4FTTjItf
 GK5nOo7oKqRxyjqtxeyJngEmkCMwgBSprhQ4NfmqwcMEUrZr06cCWFsbGyD74gNFj26a
 4S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714386397; x=1714991197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=znmZeJkGaSCtxVUBkfoWyfWxlq6LW1KJw9yscTqdCls=;
 b=P5YbPY5foMiavpXfkYsOsGSk1LX8jZ0K56xYEOTfK6bPqlbI1m9jgH5GVuTn/Y4fIk
 L6WigLxY1Z3zuKmXs2h4KqoJGiDzt2QskgGrY0Ic0+xL0mo0VYT0/iQ8/wfL9pvQjwL6
 AhGrfdwCqS5IEqjQctkC1t+S+NIdNLkwuoV1UF/mTd0+um9AFFFm7/wQ4yY+s7eykepH
 1aEdM5i67ubOTsa87dg+sRM54Pe3czqUSgH5U6ZHLjjexqmD+6xdKJh1rvz/7e/6EJJw
 H5jNAbApPU9P7nfYMaEwEVSXITd6gs3x4Zafw1kK2b3gfsuqMm6RMb+TdM0CgIgLoRkX
 Qwsg==
X-Gm-Message-State: AOJu0YwhTrnbeRJenpRDuG/tv6lk56plebm1TATe1R2vonbEb9zmzGaM
 27gtRqpVdTJ5TgSLJ0s5rozhe5DPNLHLv+XutTbqWT/wuoizIV5NV82EVYJ39qk=
X-Google-Smtp-Source: AGHT+IHO7DkfsZ+o36ag67jMmIfb9FepsJaq94SOAortLU0+IbQtuqBtQlP6p0pKJToptzjsDzj8xg==
X-Received: by 2002:a05:600c:548a:b0:418:ed13:302d with SMTP id
 iv10-20020a05600c548a00b00418ed13302dmr8086092wmb.26.1714386397205; 
 Mon, 29 Apr 2024 03:26:37 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 fm18-20020a05600c0c1200b0041b5500e438sm15224477wmb.23.2024.04.29.03.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 03:26:36 -0700 (PDT)
Message-ID: <3de69422-38eb-4fa2-972d-16d5c868ae30@linaro.org>
Date: Mon, 29 Apr 2024 12:26:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Remove useless architecture prefix from the CPU list
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-trivial@nongnu.org
References: <20240420054606.13353-1-thuth@redhat.com>
 <ZiYZyOqeM2tYPcCs@redhat.com>
 <d2786e99-ae33-43a0-8040-8a218bb485f1@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d2786e99-ae33-43a0-8040-8a218bb485f1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/4/24 10:22, Thomas Huth wrote:
> On 22/04/2024 10.03, Daniel P. Berrangé wrote:
>> On Sat, Apr 20, 2024 at 07:46:03AM +0200, Thomas Huth wrote:
>>> Printing an architecture prefix in front of each CPU name is not helpful
>>> at all: It is confusing for the users since they don't know whether they
>>> have to specify these letters for the "-cpu" parameter, too, and it also
>>> takes some precious space in the dense output of the CPU entries. Let's
>>> simply remove those now.
>>
>> Could it be said that this arch prefix is about to finally become useful
>> with Philippe's patches to add a 'qemu-system-any' command covering
>> multiple arches ?
> 
> I don't think so: In that case we'd rather print it once at the 
> beginning of a list ("Available x86 CPUs:") instead of printing it in 
> each and every line.

Yes that is correct. Hopefully we won't have the same CPU name used
by different architectures...

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


