Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798FBC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 06:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWrOE-0006Td-LI; Wed, 02 Jul 2025 02:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrO8-0006SE-Je
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:56:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrO0-0007wa-Ke
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 02:56:12 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso63574085e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751439359; x=1752044159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgu7VqDBRCkgwsJtMNJzkITzgF5YINgQ+CFLRGvMbOM=;
 b=lAIT/6bN2wtnSA2UDB4X6hicosC6DfkgJS3zEJUe1AH4V2hTPHAUFuwlZcPmM8vVMb
 n802jXaNpgS7ZvPZTk/dvFbwJgsu5/0PgpD5tu4AaRswWD3ArTlW6EZzXv3YVeKGXGat
 ojlInl+mhZ3kFTxF1V/uX5hYvAvsf+MtZ/BYtoIVf1rddSbNnwCJoqaQjrZRvfluPzSE
 PQyufAeGHA1c9KRsAADj/i4V/znoTXbQyxMEy/8N8xd7T4gOS3kx6k4Z7mFA3111P1f6
 4R3NUGOqPWFr9Hg8DY+pW5M0Q2brR6+9RzUgs65Ioc+YOe6n/VHjaamzSrzOAReWcP3B
 K+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751439359; x=1752044159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgu7VqDBRCkgwsJtMNJzkITzgF5YINgQ+CFLRGvMbOM=;
 b=jawqkZg9EsNFnX8U1ujzldhhBlMNDeujIHySD60/2rolRy9PCG97+zkXGcx5/AZAi9
 rYNvVrv8KPgqdKau9IyS0RartCiiBk8572PNN0siBaiX77xn9Bj8c+2L+NQ9GE+yMrDI
 NIqVWAAwMOq3JnI8pSTI0L9u8sYxa1kdrPaAGj3wfXRJmVd1FJGergJO/R/buxXsaM1R
 fnWhgG5mZqAJslgeJ0JCy7owViU7ITfceZaNxHy6uUlxI+cPkoi22gkByosVSKsbZVzQ
 Awlae/i+h6YnMmZAoxwGNeQawkjm0tQcjjS8bK0YY+wI1ajRWv65cdxpsM8+n12ymLfH
 kvjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU/7eSGYnm88etdMe2/xt75BsXalWzdj2K2JwEm6G/J6IuiGJ8U4q38yFgdjuk0qGvB8qBrmFoaJkG@nongnu.org
X-Gm-Message-State: AOJu0Yw1yOIrQU0Tl7AFmqSDxW3UqQO0WJFJO1NjbZPs4wRg2T7ICAn1
 L9fcCCBUxAS3eiq2xc+MP7n6VO5CCVLzCKkojWZzmLnCcJmYXNedErgCOhV6LN6D5CM=
X-Gm-Gg: ASbGncuKkLWlZXM49abjBvmp/3qwWGlHTsSSdSTm8EJFAi2BV5a11UITK6xmOI4TQJs
 WwRR+cLThfdbDN2jG4pK81B8v2I/lU41sNY/TcowW0Pkj7GwMrbdDsDcmDYww8qVDElwVL2jtNb
 wI4YYh7kvDmEu2kH4q06ryf04Vr/F5S+fwv4BNifPzHPsVLqRdUVpFG9yi1b21z2kZoOZ8vh+n9
 7iipqHhTZrWhdG42DZ9YZjcKfyow6yquLuxBxvCBLztxqo8bSTAOJXa88qEsrmkLivCsgbv5x0d
 eu8ETPdkEhYgcGTtB4xHYeTA6iaArmAKqy1YcuRLtYklXMsYdRTSAeVHX7T9ycqUox2oRkJYgWe
 5X9LLMUWagjj5zipjdbDG1sXAqlDsAQ==
X-Google-Smtp-Source: AGHT+IGtneCTq5/X1I2atVKDD+cfUWATiSPDzKx6KyMF+bybGxmJ4h86Dg7ULvaeEPLiJq6dMXcJIA==
X-Received: by 2002:a05:600c:8b22:b0:453:8bc7:5cbb with SMTP id
 5b1f17b1804b1-454a3726347mr14856515e9.25.1751439359173; 
 Tue, 01 Jul 2025 23:55:59 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7814sm14978548f8f.8.2025.07.01.23.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 23:55:58 -0700 (PDT)
Message-ID: <83d7c55b-fa17-413d-8896-171d9538693d@linaro.org>
Date: Wed, 2 Jul 2025 08:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/kvm: Adjust the note about the minimum required
 kernel version
To: Zhao Liu <zhao1.liu@intel.com>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-stable@nongnu.org, qemu-trivial@nongnu.org
References: <20250702060319.13091-1-thuth@redhat.com>
 <aGTU2enBBQj7lu3E@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aGTU2enBBQj7lu3E@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2/7/25 08:42, Zhao Liu wrote:
> On Wed, Jul 02, 2025 at 08:03:19AM +0200, Thomas Huth wrote:
>> Date: Wed,  2 Jul 2025 08:03:19 +0200
>> From: Thomas Huth <thuth@redhat.com>
>> Subject: [PATCH] accel/kvm: Adjust the note about the minimum required
>>   kernel version
>>
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
>> KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel 4.4 to
>> be able to use KVM. Adjust the upgrade_note accordingly.
>> While we're at it, remove the text about kvm-kmod and the
>> SourceForge URL since this is not actively maintained anymore.
>>
>> Fixes: 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH")
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   accel/kvm/kvm-all.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> I just mentioned the kernel version in another patch thread. I found
> x86 doc said it requires v4.5 or newer ("OS requirements" section in
> docs/system/target-i386.rst).
> 
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index d095d1b98f8..e3302b087f4 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2571,8 +2571,7 @@ static int kvm_init(MachineState *ms)
>>   {
>>       MachineClass *mc = MACHINE_GET_CLASS(ms);
>>       static const char upgrade_note[] =
>> -        "Please upgrade to at least kernel 2.6.29 or recent kvm-kmod\n"
>> -        "(see http://sourceforge.net/projects/kvm).\n";
>> +        "Please upgrade to at least kernel 4.4.\n";

Using 4.4 or 4.5:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>       const struct {
>>           const char *name;
>>           int num;
>> -- 
>> 2.50.0
>>
>>
> 


