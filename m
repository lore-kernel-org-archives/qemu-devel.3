Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE62E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGz0-0003vB-IY; Thu, 05 Dec 2024 13:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJGyy-0003k2-F5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJGyw-0001DW-Mz
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733424826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MJHLBtqQ7saBLHJKPz5jOE+/qfjkFJwcL7PVz8ahCCk=;
 b=MC3fGchyX5CzrgwrwS9vtbRnipyNlFDsjrYNqoZ4FQfDj+5mm0doUZt5wlwMXybXSTQ0Rn
 TKaxIw2R49+A/4vkrbqdoosDTrqBP1X0k3WaSwD0GClyc5tM16fu8DaBXmfgFUisBML9SV
 5W5EEwQhphuN1vK+246OfbhpUGz4WO8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-sIvlLTeqPcSGwKCeDPZzOg-1; Thu, 05 Dec 2024 13:53:44 -0500
X-MC-Unique: sIvlLTeqPcSGwKCeDPZzOg-1
X-Mimecast-MFC-AGG-ID: sIvlLTeqPcSGwKCeDPZzOg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b66ec70846so255792385a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733424824; x=1734029624;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJHLBtqQ7saBLHJKPz5jOE+/qfjkFJwcL7PVz8ahCCk=;
 b=Va1XvZCNMoY6LkjDI6+IkQiAJnztt8npizrTpt4W7YI7cy5DfaddB4hPpgGm2iF8E4
 +zsAQFOi3SfrI5psGCIy9SdM4jyX8bOMwWRn3yanEFfX/5lcsgxEpDmDWI7kRH6XRnuK
 eicKVj/tfKu+/hKx/zkCCSXtJpIcnCaciV45WyWBbC2QjThaZulP6Uu/K4oN97DfFkCV
 kxDVY9ho43XsEyNC0NiiX667Q+yxicL46PbW3QEgAjay5D1N0DOVymHb3YqFwbeQglzO
 OVVcTExoN3TnCFR4MLtCP9husqsu2/AwDKPwQBIY39EgZu5qz1dkfrw/5FlJig7j/vrn
 M2pg==
X-Gm-Message-State: AOJu0YxbY6pIAiJ3CwnZbwOhB/GLjFaWH2z+JiRtULaKIH4vv4Gev2yL
 jWekD8Y4YV9qlSVa8KWh1uolCHlxT4pKMNPO//Zno2LM+qXT3Al4vtLTFfEOA3//Xs8lThR0UHJ
 IHPPPilB1d8/dDkNQq0k+ED/fiyeSuLYfeVQtd+hwz9zEGOFwI3IC
X-Gm-Gg: ASbGnctDAwp7++aKGY26x5oNJIAU2nl/k4In0ceWmOyriSzuRw7TlaMtBxJ+NhxlgLw
 6sPTpCJDm+uEfrPD+gcZzFQzWiD12e8zKkVLiXs2C8zAIPT8ffSznQTVpSVyCbGIsheFNBghlXH
 RoYA2d+z7a5Dz8ygMQCsargEcOe3KqI1ULjSbc/ucRqrTK5cirL+dNaTIzCXJ00XG+aKlN2fkhz
 +q60F113Z2hVaOso3mD7mwqKapXgGfDJNrt+wTUZ1i01brtwP1aPeDp
X-Received: by 2002:a05:620a:2415:b0:7b6:67df:51ce with SMTP id
 af79cd13be357-7b6bcad4d3amr55822385a.18.1733424824389; 
 Thu, 05 Dec 2024 10:53:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVp1yOFWLsBqd+DCbc7ErdZEzikmrkD8nsgmirLJ8xTTagT2nTNXwWDerGPqrZm79x4nh27w==
X-Received: by 2002:a05:620a:2415:b0:7b6:67df:51ce with SMTP id
 af79cd13be357-7b6bcad4d3amr55818785a.18.1733424824114; 
 Thu, 05 Dec 2024 10:53:44 -0800 (PST)
Received: from [10.195.154.128] ([144.121.20.163])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-7b6b5a83c37sm86377185a.95.2024.12.05.10.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 10:53:43 -0800 (PST)
Message-ID: <6108dfe6-f629-431c-be91-51abff338e85@redhat.com>
Date: Thu, 5 Dec 2024 19:53:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/13] rust: add bindings for gpio_{in|out} initialization
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-5-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/5/24 07:07, Zhao Liu wrote:
> The qdev_init_gpio_{in|out} are qdev interfaces, so that it's natural to
> wrap them as DeviceState's methods in Rust API, which could eliminate
> unsafe cases in the device lib.
> 
> Wrap qdev_init_gpio_{in|out} as methods in a new trait DeviceGPIOImpl.
>
> In addition, for qdev_init_gpio_in(), to convert the idiomatic Rust
> callback into a C-style callback qemu_irq_handler, add a handler pointer
> member in DeviceGPIOImpl. For any device needs to initialize GPIO in, it
> needs to define a handler. And for device which just wants to initialize
> GPIO out, it can leave the GPIO_IRQ_HANDLER as None.

This has the same issue as timers, in that you could have (especially 
once someone adds named GPIOs) multiple handlers.  So we need the same 
kind of Fn-based thing here too.

> +/// Trait that defines the irq handler for GPIO in.
> +pub trait DeviceGPIOImpl {
> +    const GPIO_IRQ_HANDLER: Option<fn(&mut Self, lines_num: u32, level: u32)> = None;

Ah, I see that you're placing the qdev_init_gpio_in here so that you
only make that accessible for devices that did implement DeviceGPIOImpl.
However you are not guaranteeing that this _is_ a DeviceState.

If the handler can be passed as a function, the problem of getting the 
GPIO_INT_HANDLER does not exist anymore.  So with the code in rust-next 
you can add these to a trait like

/// Trait for methods of [`DeviceState`] and its subclasses.
pub trait DeviceMethods: ObjectDeref
where
     Self::Target: IsA<DeviceState>,
{
     fn init_gpio_in<F: ...)(&self, lines_num: u32, f: &F) {
     }
}

impl<R: ObjectDeref> DeviceMethods for R where R::Target: 
IsA<DeviceState> {}


> +    fn init_gpio_out(&self, pins: &InterruptSource, lines_num: u32) {
> +        unsafe {
> +            qdev_init_gpio_out(addr_of!(*self) as *mut _, pins.as_ptr(), lines_num as c_int);
> +        }
> +    }
> +}

Pass a slice &[InterruptSource], and get the "len" from the length of 
the slice.

Paolo


