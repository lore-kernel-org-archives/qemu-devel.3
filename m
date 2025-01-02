Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35478E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 09:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTHyl-0000bx-Ag; Thu, 02 Jan 2025 04:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTHyj-0000bl-J8
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:58:57 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTHyh-0005qc-TZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:58:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385df53e559so8784557f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735811934; x=1736416734; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VHrfBH43E1WAA0UOyqnVwGTMiZL45kAH74MnXrB7Fpg=;
 b=AOnWWYdnyCcwFqwHmbHJ44G4w7Ya8WklwAPe8b85WmT7a4J8HrT80CUbjWRaCzVh96
 CYdJ72yduly0/Id6gRwhdko/xaXAxNi4DuM85QFPMWwWcLxlU3syq5S/hJafAtT8K8Nz
 8mD354Yg/RcE6wcSXlBe3dcRRD+iRBI9Ahf1Nw30MOkQdz/0Ets4uVRCqHqK/D/Md9nl
 TS11EbeznAzLsDbI7n2kQojZ2elO2s/egnI84rNUSoa8LS4xTfdkd4/9qhqy/1NofPwu
 sTQeOP0nxRnoFlWfkI3moujJhsdFm2b6Ipefia4lXK0Dd2nxodgPjq4cmOq7EipbVLi/
 O/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735811934; x=1736416734;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VHrfBH43E1WAA0UOyqnVwGTMiZL45kAH74MnXrB7Fpg=;
 b=l8InWx/t7fSQOgfRCgFHqsQKj2U+OIqHXfaynLd7rVqYbL/zuEd+swUqzfZFAGrnlM
 rHW8z9z2DzOrLYvE2eztNy+1Lxr1QTamKPrECnNxnpvanLMl18U3V7vx+mzn3RfP/m5/
 KxVXcRTDQRXwx98QPwwDjJLs0KtTgjqsbzac2BGIFTMD0M7nC8pWC5zvR6v6KN5AGHy7
 eAtHxR/RCPZH294lNnmQoMYJAUeslBnZpSyr1wwOLajj6SgjUNtlbB3VQ8sVPiLJD2Bt
 ZiQ9eRYRodaueOSaXjaypESYXCj1SshRor3iCBOKXKt8Zejqcj8/Jkwaiv3bekse0/Hh
 kapQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQjxg2VJPvambHqpD9NWjSx8wQRw3cHzf8tIBu2mQEwPNYsTIJDSPUooG604R44mjjDqWb4t5sPxqi@nongnu.org
X-Gm-Message-State: AOJu0Yw7Ci2Hq08KrbJL7Ei9hT3Q2TrAyGNUrSaTYAIlqgMr8cBgYxUP
 MOYVZjZ0BZnRPV4BtnlF3BYxd69FB4FZPdn/RKHLc2ecA0AFB4nPxtfQmyOCCls=
X-Gm-Gg: ASbGncu1VuVCb7IwoLIX4xrei62mDDGKwLo+By1CjClnuOYrjt+FKkWccy2nR7UzNHM
 1yoDNa3J2u7+SICYqbPtKqr75T2vUzCQaZ2MwvAXUqL1JQhttGuftB4NEOkwMwVhwClE/lq53cO
 zx2tMfp0CSOLP+Rnwq9eNin5jct9dGr85DfHoYWc+7b/55jMHfQrzrtPESo5ADzyQOvhgfNMbIa
 tNqwfvG19Jh9Tq/fE4cQlKgfXnp5ecpKCBXrl9aUZDpKGDs7Pghx56knrIYuj/eREwf6IimAcUk
 8h7fT125wYIBGI+nYW8LLFih
X-Google-Smtp-Source: AGHT+IHtF8lrbExV85Gs0jH+JU/fMga1lL6WFfbtaDh7JEWktdUHZ8JHbv/9gwxpkNJFza7Ws2IANw==
X-Received: by 2002:a05:6000:70a:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-38a221eca99mr38440814f8f.9.1735811933578; 
 Thu, 02 Jan 2025 01:58:53 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e2d2sm38306814f8f.71.2025.01.02.01.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 01:58:53 -0800 (PST)
Message-ID: <bcf71e10-1fa2-4926-9f02-fb1387d5a619@linaro.org>
Date: Thu, 2 Jan 2025 10:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tests: Add functional tests for HPPA machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250102092301.42122-1-philmd@linaro.org>
 <00ad22b7-4885-4142-b675-4f4143fc668d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <00ad22b7-4885-4142-b675-4f4143fc668d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 2/1/25 10:45, Thomas Huth wrote:
> On 02/01/2025 10.23, Philippe Mathieu-Daudé wrote:
>> Add quick firmware boot tests (less than 1sec) for the
>> B160L (32-bit) and C3700 (64-bit) HPPA machines:
>>
>>    $ make check-functional-hppa
>>    ...
>>    4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 
>> 2 subtests passed
>>
>> Remove the duplicated B160L test in qtest/boot-serial-test.c.
> 
> Thanks, this only tried to test the "hppa" machine which got renamed, so 
> the qtest was only skipping for the hppa target.

Ah, that is reassuring, that explains why qtests were still passing
on my broken hppa series.

> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


