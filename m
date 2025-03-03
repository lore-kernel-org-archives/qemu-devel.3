Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADB3C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp78w-0002LB-2N; Mon, 03 Mar 2025 09:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp78r-0002BY-Bb
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:51:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp78n-0006WX-Gs
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 09:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741013492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r6kKs2VKcDYFe9P1iLTQMG3USZ1cNcl9KptsP8PUt2M=;
 b=eVAdPDhOdeqMfn+ZfGwFvRPwZjsktXaRYcM90r3rA+OpBXwR0MwCNLfbcZmmRTZlpR2Pi+
 wDW8yUhqjAV9KtEtlCZNR4pqu9TTRBsnKwMqFMtFReOSDeNrKAVbRmcJ8254bB7NccFpin
 KDBtchy9BqghZym7up97lySfFNEW4S0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-J9llKStCNVSBvIVP7NKW2Q-1; Mon, 03 Mar 2025 09:51:29 -0500
X-MC-Unique: J9llKStCNVSBvIVP7NKW2Q-1
X-Mimecast-MFC-AGG-ID: J9llKStCNVSBvIVP7NKW2Q_1741013488
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4399a5afc72so20150305e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 06:51:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741013487; x=1741618287;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r6kKs2VKcDYFe9P1iLTQMG3USZ1cNcl9KptsP8PUt2M=;
 b=d0rs4hTAzW5NtJx46m9lljfeYmF+W0FvpR4VUhHidAO6Ewz8NUdsxIp4HFRb5o1ikB
 b0LbWNIc1vS3GtlXDptFA4q/jywPBZ7Trr1Fdec7OyklXjMwhOgtGqVLCxk6iZn9N8Rj
 KGtpWGG7dzU3wr6jIAy8WWMJFKV/OYsQ9WkWnOzz0QhYrmJCuBKttlli3/2qf+m/Ka92
 QHqzXlF0FC8kRF9TsSfc+acNlly0deZYW5AtWr+U2gjXELkrhARZT88Wa3B4KfN0ox2a
 Rin/axNMi2nBJeLn8ovBxgvCtbq2T/hDqN6PLd/G7NpotBFTfe2xEkE/3L29UtXxHnoj
 o1ug==
X-Gm-Message-State: AOJu0YyfC2MufkaWN0nS0lvdBivYlY7OjhWPQORXcVOQDHPo0HWh15Wi
 C/0aqhyyEPT+ylxb3oR1EvvMMyYeeIDe5wI5YxW7J27EGMdt4a5c6aCEeAv/kBpBWGm8v70C2fB
 KmSR3pK+eyPLIR2g3ozPTXt8NC/FpX17VJE6W7j8501rqqF8v6IlAcmZQW/lU6vA=
X-Gm-Gg: ASbGncvS6y0CBOmBZFyw/6JcniW/wRQrBw7AA1ryqxiEautC+Ofm7B66ahhvKu/2oiG
 g0C861RGYZDQeuI60NJSQhvjfJNoDDhKvryzg1mXGhbfO1AZyt3rQl4NQazv+gtmmdTqur/4JOM
 zDNit5CcAmodKOEsoUsztqfW/rqKv9NZKjfuPaz0fzVdN9gJuMumEq0P3aepNzaerzOPj3A6+89
 a5VET0ksAC6W44Lqnh5BKKwwLeQCwUpY4Ql/mX+SCtb/kbpmsPhfR+UaKdbtW6v1Dhee5DXLWvk
 15ODvYBSE0AvY1NC/e8=
X-Received: by 2002:a05:600c:5106:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43ba67745d4mr119272335e9.29.1741013487354; 
 Mon, 03 Mar 2025 06:51:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxdtsjk6QfcKCQkHQfYfAEU0CNTLvHVwGilXAEvzW3gI6oKxES549fTdESaN7XHRnU8cRGvA==
X-Received: by 2002:a05:600c:5106:b0:439:9496:181c with SMTP id
 5b1f17b1804b1-43ba67745d4mr119272165e9.29.1741013487072; 
 Mon, 03 Mar 2025 06:51:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.119.44])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43bbed8b26asm52305425e9.22.2025.03.03.06.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 06:51:25 -0800 (PST)
Message-ID: <4b4ca8d8-662f-409c-96dd-11c5075252e2@redhat.com>
Date: Mon, 3 Mar 2025 15:51:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] rust: timer: wrap QEMUTimer with Opaque<> and
 express pinning requirements
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-5-pbonzini@redhat.com> <Z8W8hzFO9HU3IujQ@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z8W8hzFO9HU3IujQ@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 3/3/25 15:28, Zhao Liu wrote:
>> -    pub fn init_full<'timer, 'opaque: 'timer, T, F>(
>> -        &'timer mut self,
>> +    pub fn new_full<'opaque, T, F>(
>>           timer_list_group: Option<&TimerListGroup>,
>>           clk_type: ClockType,
>>           scale: u32,
>>           attributes: u32,
>>           _cb: F,
>>           opaque: &'opaque T,
>> -    ) where
>> +    ) -> Pin<Box<Self>>
>>           F: for<'a> FnCall<(&'a T,)>,
>>       {
> 
> Ah, the lifetime here isn't effectively bound... However, I also
> referred to your latest code [1] :), and it seems that this issue
> has already been fixed. (Nit: The code still has a complaint from
> `cargo fmt`)

I am not sure if the change I have in that commit actually does 
anything, unfortunately... :( which is why I wanted to use init_full 
instead of new_full.

It's easiest to marked new_full() unsafe for now.

Paolo

> [1]: https://gitlab.com/bonzini/qemu/-/commit/ccb9f6dc738f503a696d8d50f1b5e4576ee80bc6


