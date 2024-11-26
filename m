Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE75FD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvj7-00039k-7v; Tue, 26 Nov 2024 08:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFvj4-00039A-Ff
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:35:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tFvj0-0008RK-Cw
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732628127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J/WMazwLDcVs71OKEl1CHvYjffjtAQIjP5TA8DAH+sw=;
 b=C/8ud2vdlTmG3okTap8aeTmenLbEp6DwOK8CIlG7maallG/Ier5vtaDzgJdtXoMBHJMjr0
 oXEIgOR6U7CToRk7nrG6i35ZczLA4RZxnzNo1YVLLB76Y8L6Z0RcZCyzjYuGSwuqdFyy/y
 Dj8hLrbsoSC7tTpNzO86uAEH9ujNIoI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-fkO1BcsxNu2UrXVCTWRnig-1; Tue, 26 Nov 2024 08:35:26 -0500
X-MC-Unique: fkO1BcsxNu2UrXVCTWRnig-1
X-Mimecast-MFC-AGG-ID: fkO1BcsxNu2UrXVCTWRnig
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3822ec50b60so3175431f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732628125; x=1733232925;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J/WMazwLDcVs71OKEl1CHvYjffjtAQIjP5TA8DAH+sw=;
 b=att1TckjNeX1mesaw8RCb5/oP2UNTvyBPkUwef8cO6QgeJSL/RK9aTMmCYm6+FY2M+
 swWtYKPSoZOLpb0xHRdijcZDlwa8oTqcX6p0PWNdNEtbR204yrG2dB3HWZVOZApInWpG
 6Nveo46ARp3rCp9cZFYkDGljpzOZnYzRZUIPXRx0UtJYStocQd1RC7x7qeg+J4HdYu8S
 xQ0zIAoFxl/xqCM14DRTedtJ52vuYgjt7xyLjMvwCLiXV0EHVT3iH7tAtly2adDD7E51
 RRC77h4cdr8DASqDqJsGpi8FZwtiiFxxr+8cE+GtgNPFW4hYzxzQANtljGGNz8Ufe7dr
 BvCQ==
X-Gm-Message-State: AOJu0YwTJ+zOHpoWv6JctKxYfxnvEheEwquhOa54x49Oe7sobg4f8oVJ
 bqP3NLVFCUzrTptcDZOZCT8h8K8kfTcIGKaZb/wHlIi4Fw4HMCI0Tzgc0XAGW71xG10CVAhrSWy
 bWut6AuxwGp4l24DicphaK+0yJZlPrVlWY/ZLC83RQWxmlW8F8RdW
X-Gm-Gg: ASbGncvI9JCqQAPZ+pqctsv2twe7lA8YZn5TNoxjA+9+AamZk+/r78EpDP8AKfBVzUy
 8Ol0qv7J5kKM0O4m5r9D4jkRnW91JaL3VEmrRfx1HbQIoK+TrKypVys58YfEJRB3hX8/pRMDcR8
 +eRjmkdGkwWKdM9XTFUMFU/aigKUv6DlzQzEvV/l75d4//GDnL3CaZIbSW5/LRrH/2N8O9bJxoh
 ClS2i9OUxRR4rrcGGXJaIrZdrZL7AZL7Kjr3g+o0ul4974jLGWaQFQ=
X-Received: by 2002:a05:6000:42c6:b0:382:4460:49ad with SMTP id
 ffacd0b85a97d-38260b986a4mr8376127f8f.32.1732628124825; 
 Tue, 26 Nov 2024 05:35:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAD9YksD4WOc8rI3h5sHOhd5QwF4bbCecVK9Y8sRkXSaHZ03mCoQOYKT8BqJubenH7hXkAbA==
X-Received: by 2002:a05:6000:42c6:b0:382:4460:49ad with SMTP id
 ffacd0b85a97d-38260b986a4mr8376117f8f.32.1732628124515; 
 Tue, 26 Nov 2024 05:35:24 -0800 (PST)
Received: from [192.168.10.28] ([151.49.236.146])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-434921ceea7sm114503795e9.25.2024.11.26.05.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:35:24 -0800 (PST)
Message-ID: <7a59cb8a-3da2-45d8-9c8a-92132374cecb@redhat.com>
Date: Tue, 26 Nov 2024 14:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, qemu-rust@nongnu.org
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com> <Z0XQ79uYWNUrbmR2@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z0XQ79uYWNUrbmR2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/26/24 14:45, Zhao Liu wrote:
> On Fri, Nov 22, 2024 at 08:47:56AM +0100, Paolo Bonzini wrote:
>> Date: Fri, 22 Nov 2024 08:47:56 +0100
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH 2/2] rust: add bindings for interrupt sources
>> X-Mailer: git-send-email 2.47.0
>>
>> The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
>> as safe code.
>>
>> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
>> They are QOM link properties and can be written to outside the control
>> of the device (i.e. from a shared reference); therefore they must be
>> interior-mutable in Rust.
> 
> Out of curiosity, are there any examples of this situation?

Yes, qdev_connect_gpio_out_named() changes the pointer that is stored 
into the InterruptSource.

>> +    /// Send `level` to the interrupt sink.
>> +    pub fn set(&self, level: bool) {
>> +        unsafe {
>> +            qemu_set_irq(self.0.get(), level.into());
>> +        }
>> +    }
> 
> Regarding the boolean discussion, the c_int/i32->boolean conversion
> seems unavoidable if it is changed to a boolean, for example, the
> level parameter in qemu_irq_handler is declared to be c_int, and
> there is a pattern of setting the level in qemu_irq_handler with the
> level irq:
> * hpet_handle_legacy_irq
> * split_irq_handler
> * a9mp_priv_set_irq
> ...
> 
> So it feels like a more direct way to follow the use of c_int or i32?
> Inconsistent types for level are always confusing. Maybe we can change
> the type of rust after the C version can be standardized to boolean?

The problem is that auditing the C version would be quite some work, 
which is why I proposed adding the generic argument to Rust.

On the other hand, it's relatively common in C to write int when you 
mean bool, because bool is a relatively recent ("only" 25 years :)) 
addition to C.

>> +    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
>> +        self.0.as_ptr()
>> +    }
>> +}
>> +
>> +impl Default for InterruptSource {
>> +    fn default() -> Self {
>> +        InterruptSource(BqlCell::new(ptr::null_mut()))
>> +    }
>> +}
>> +
> 
> I like this idea and this binding is very useful!
> 
> HPET also needs qdev_init_gpio_in() and qdev_init_gpio_out().
> Should these two safe binding wrappers be implemented as methods of
> DeviceState, or just the public functions?

qdev_init_gpio_out() is basically the same as sysbus_init_irq() and it 
can be added to DeviceState.

qdev_init_gpio_in() is more complicated because it includes a function 
pointer.  For now please keep it as a direct call to 
bindings::qdev_init_gpio_in(), but we'll have to tackle callbacks soon 
because they appear in all of chardev, GPIO inputs and timers.

Paolo


