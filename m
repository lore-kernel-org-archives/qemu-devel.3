Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5E3C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 21:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMCxH-0006Ej-5f; Mon, 02 Jun 2025 17:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMCxE-0006EV-PC
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:44:24 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uMCxD-00083Y-5h
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 17:44:24 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b2c49373c15so3041921a12.3
 for <qemu-devel@nongnu.org>; Mon, 02 Jun 2025 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748900661; x=1749505461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjBFZha3T6dxwS2Ai2OI10yYHkYGii8nPvaO9dfSaO4=;
 b=Rojmo5aOFyycQ1VeGL3BObQe5BkLl+fH8FiU9EHzEXsFZtjQsue8jvpQOAPSBERO9L
 za/URROkrO8sML6d7PVrZ3jZQ6tqnlP+GvpZWKwB+YftLEvb6pKuKw7jkfHjP8tQnthC
 qMIIh8L/yYfdFvrvFYCxm2esfy+6D10vmsL69hvVmPWhP0aD4j39SrmeqFn9GXRPcvmO
 RO//pFpM1whM7zoeAjJ5qkQ3iZJkrzWH/AvcjpVWnUkWoi29/ChWlLv01Vs01ItLxUn2
 Sf5AoElK/jAVliTCqJYmSc00v6g+UkV4909IyL1y27Bl1q0JPm8Kx0HIDxQ+rYnVnKuz
 Qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748900661; x=1749505461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjBFZha3T6dxwS2Ai2OI10yYHkYGii8nPvaO9dfSaO4=;
 b=tIRCYRV0uqgVy1UfxtY6ufcC+HKuYi/IBDerMbgkG2GMuHfVyrxgF2rnd2EEgRmRoq
 YYUdl7TMnJY9I7Zq6+Xfj+jaxJmf1D05jm5uSz3kHYBcxrddNLQkmD+mRRI3K5Nrz2QN
 7FMhK2FTQ+K1jJgO0bMtgezR7i/lSGoIXjnsvE+0lXVNMqvEqT2lgW52/jG14ZJx9wly
 4zwpjZddOtZqWtTXO8qPnBZ8fHEXfRym+eMPm9dNIeGod1XjkTyGTGuLjoi9N27R78cQ
 LJrO3JZUAH7eBtgduU5iNFtevG0lEHxv8+Vsrt/p8UCvvCaxO1ppas9Cj0huJvnCcEoM
 QoMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWvAFXct7Ekj8krN+Fyuh6yGJpDDBTeTZ6lGGVjDWKqyhokJ9mtL1HYP6zwGUIsnhEshg8SUY1MW/h@nongnu.org
X-Gm-Message-State: AOJu0Yz32hbsJB1UCuKPuZIe1kVoIFRJ/eraqC/irMM2HqrxaqA/6ZuB
 EAw5Dt24VOWQf4ZxwwTlQPqthTZcAAbmK9wT8YmQtqf5PVGs5rKBlay8
X-Gm-Gg: ASbGnctFOUWrlc0SohVOx/zyDrqwgslyG0+y4SmKtI6Af+Lodoa79YDtSZNJhzWaldb
 LDuAl+fg5LP4V0PrNsT/MyYwVWbPSXaqkIMI7gz88yTvEB3Wt7vp9V6zDNTxFciyLpLebzljdmN
 c9aPHuqQVkFIsL5AgZTis89u/IIO6iDy/odDD85UU6OOFBQbdEGk0TVwN15Ftxnww6eN8+oTc6V
 otewAx/8dMrvte0LIzn2cCw5XL+f0rAW+ybJ1ALtAO8kf0Yqpjv4L3x83QFi9k19Ihv42TxeeUb
 I6lzVUhFoT8xdlD21IMVxCMSVPkilqDiidfoIBGQyuncVuC47/eQsaM=
X-Google-Smtp-Source: AGHT+IFdTCNmXpNzFrfF8S335uiBBbtgUoO3DXJ4mkfBTsg6pYWFrv29GTOtlSrkONnDA9TVyVvhmw==
X-Received: by 2002:a05:6a20:7286:b0:1f3:2e85:c052 with SMTP id
 adf61e73a8af0-21ae00c987cmr23110965637.35.1748900661478; 
 Mon, 02 Jun 2025 14:44:21 -0700 (PDT)
Received: from [192.168.1.119] ([50.46.174.34])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afda8b71sm8081237b3a.0.2025.06.02.14.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 14:44:21 -0700 (PDT)
Message-ID: <fc8702c6-568a-4d71-af9c-19afd037b688@gmail.com>
Date: Mon, 2 Jun 2025 14:44:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250602195706.1043662-1-rowanbhart@gmail.com>
 <20250602195706.1043662-4-rowanbhart@gmail.com>
 <7f925a2a-20d7-40e6-bf2c-ac3823912a04@linaro.org>
Content-Language: en-US
From: Rowan Hart <rowanbhart@gmail.com>
In-Reply-To: <7f925a2a-20d7-40e6-bf2c-ac3823912a04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=rowanbhart@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

>>
>> @@ -437,6 +437,10 @@ int qemu_plugin_read_register(struct 
>> qemu_plugin_register *reg, GByteArray *buf)
>>   {
>>       g_assert(current_cpu);
>>   +    if (qemu_plugin_get_cb_flags() == QEMU_PLUGIN_CB_NO_REGS) {
>> +        return -1;
>> +    }
>> +
>>       return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) 
>> - 1);
>>   }
>>   @@ -445,6 +449,10 @@ int qemu_plugin_write_register(struct 
>> qemu_plugin_register *reg,
>>   {
>>       g_assert(current_cpu);
>>   +    if (buf->len == 0 || qemu_plugin_get_cb_flags() != 
>> QEMU_PLUGIN_CB_RW_REGS) {
>> +        return 0;
>> +    }
>> +
>
> Would it be better to return -1 for "qemu_plugin_get_cb_flags() != 
> QEMU_PLUGIN_CB_RW_REGS", so user can notice there is something wrong 
> with flags?

Sure would, typo on my part here.


>>       return gdb_write_register(current_cpu, buf->data, 
>> GPOINTER_TO_INT(reg) - 1);
>>   }
>>   diff --git a/plugins/core.c b/plugins/core.c
>> index eb9281fe54..34bddb6c1c 100644
>> --- a/plugins/core.c
>> +++ b/plugins/core.c
>> @@ -364,14 +364,15 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>>                                      enum qemu_plugin_cb_flags flags,
>>                                      void *udata)
>>   {
>> -    static TCGHelperInfo info[3] = {
>> +    static TCGHelperInfo info[4] = {
>>           [QEMU_PLUGIN_CB_NO_REGS].flags = TCG_CALL_NO_RWG,
>>           [QEMU_PLUGIN_CB_R_REGS].flags = TCG_CALL_NO_WG,
>> +        [QEMU_PLUGIN_CB_RW_REGS].flags = 0,
>>           /*
>>            * Match qemu_plugin_vcpu_udata_cb_t:
>>            *   void (*)(uint32_t, void *)
>>            */
>> -        [0 ... 2].typemask = (dh_typemask(void, 0) |
>> +        [0 ... 3].typemask = (dh_typemask(void, 0) |
>>                                 dh_typemask(i32, 1) |
>>                                 dh_typemask(ptr, 2))
>>       };
>
> [QEMU_PLUGIN_CB_RW_REGS].flags = 0 was already set implicitly, as all 
> elements not explicit set are initialized to 0.
> As you can see, [0 ... 2].typemask was set, which shows we initialized 
> the third element.
> Adding [QEMU_PLUGIN_CB_RW_REGS].flags = 0 does not hurt, and is more 
> explicit, but you don't need to increase array size.
>
> This static array is used to set info field in callback struct, as
> .info = &info[flags]. Flags being an enum qemu_plugin_cb_flags, its 
> value is 0,1 or 2, so adding one entry is useless.

Got it, for some reason I assumed this array needed a sentinel value and 
simultaneously didn't recognize the [0 ... n] sytnax was inclusive. 
Thanks for pointing that out!


I'll make these two changes.


