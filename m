Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E6C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiG5w-0006SN-Hu; Wed, 12 Feb 2025 12:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiG5j-0006Ri-5d
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiG5g-00064U-Pn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739379599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=P3rdE6bMKhtKvKG+ss3N+3Q/1bwSp5hZDjlL7n3rqC0=;
 b=MSt2Wg1A8RVqs20VGqXnD4kqQ9W1QFIFf8L9SEa4rPIbdqrXPmPcCuI67eyIfsQyq4YJpl
 AUPod9CqGTD8Hs8qxvRPv+dFylG36HcouJlPSxPxV3lUm/uhT05SDmMW6TSR7ldCQE3Frl
 CmOn8svPEW+vXIcXHJHXK6bYXdn7aSI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-2Y40UoVrNQqKZ9T-7vC9_w-1; Wed, 12 Feb 2025 11:59:58 -0500
X-MC-Unique: 2Y40UoVrNQqKZ9T-7vC9_w-1
X-Mimecast-MFC-AGG-ID: 2Y40UoVrNQqKZ9T-7vC9_w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38ddcb63ed1so2270764f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 08:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739379596; x=1739984396;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3rdE6bMKhtKvKG+ss3N+3Q/1bwSp5hZDjlL7n3rqC0=;
 b=X+AjJysQS2TRCVLRHVBZCcbEOHD0YkwiqkIPHD+HHl5wshY/8CUQSspoJ4g0TTF45a
 MUUSsJG99UCwRAo2tCiTt842+pLoLZf2Czfb06oqP7WNsGsJdGotv+DJmfh5P8WTPYY2
 O+i3oueCjKcSMnhyI5G6qoBufB+xAe5I3IBa2FTAx5Ggr3wPlVpx8Bpr2bRe+d4RGJWi
 aJcy5aL/3CWwBz3pq2Fj7gxbZKg7I7lKcEtVgixqeCl0qYK+H0waCAdOSKTEagqoo0RA
 lYuvGjEXvaWUEy3LPpo5s2BZUe80drt7Qu9pS1KuHG2wF1Bb4769vElgtM5vNTn5Lskb
 UpWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuT1lbdLRG3NwA6G00W9M8exLZDH5G5icwHKHu97591+tFHnNiadS7xZNxWY1wW8XN4pQvUUOmdtQu@nongnu.org
X-Gm-Message-State: AOJu0Yyu/INaxshjxkM2uQVM4m611/bs/oEg7EUVE4xsTCWbiSZRKZCL
 NlvVcuoJK1oPvpZNtwyaorGfDYEcr9lLeKDvJSYLf1y0GaLIt0+U3my4qNITIIoXe44ANAkbO75
 wid7xUcquaElikvtDYWER4mmB4YR6VhWwUDlPMTHIl/rR+TYc+FpZT8s3jL2FCgE=
X-Gm-Gg: ASbGnctiZM3WwGVl4TPFcyaCFVK/rlzkuR8uOXvlmoKBZT+/zhU3bxXffyNQhNm/UXz
 hbu341n8zH6Cv2q7dhzASIhjiBldUFlutwiOPVHYutZOCIo2GhkZzq596vZ83bi1wNcuxj/HQSu
 veyTVsQagNYXUoaNq2HYZgd3rI5XukrgWOwUQ4b1ENTLij7YGUs5VTrfypZKgKPf5oSmaY/iA7A
 meHaJiYUDTxyEEe+Cf+oXH8JwTMslsdB978ISwVVOcDPFTvTHJaVpip2KwHA+dqQl8mxFUb0DPc
 GVDg6ok=
X-Received: by 2002:a05:6000:1f88:b0:38d:dd8c:51db with SMTP id
 ffacd0b85a97d-38dea2f982dmr3623034f8f.53.1739379596556; 
 Wed, 12 Feb 2025 08:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq5UDzW2TszXvG5sll6tR4UsA9tcrIPCwq+Xq0nckj3iDb5reCujSVTG56Z34M1q2IS79aXQ==
X-Received: by 2002:a05:6000:1f88:b0:38d:dd8c:51db with SMTP id
 ffacd0b85a97d-38dea2f982dmr3623015f8f.53.1739379596199; 
 Wed, 12 Feb 2025 08:59:56 -0800 (PST)
Received: from [192.168.10.81] ([151.95.148.6])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f1f27e612sm1616072f8f.93.2025.02.12.08.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 08:59:55 -0800 (PST)
Message-ID: <99cf772e-984f-4b39-841a-522d9191d5e6@redhat.com>
Date: Wed, 12 Feb 2025 17:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] rust: Build separate qemu_api_tools and
 qemu_api_system
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, manos.pitsidianakis@linaro.org, 
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-2-kwolf@redhat.com>
 <1bcb9de2-5932-4c24-958d-7a86cfcea70e@redhat.com>
 <Z6y-bBK4ZAAcPhFm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z6y-bBK4ZAAcPhFm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/12/25 16:29, Kevin Wolf wrote:
> Am 12.02.2025 um 11:01 hat Paolo Bonzini geschrieben:
>> On 2/11/25 22:43, Kevin Wolf wrote:
>>> The existing qemu_api library can't be linked into tools because it
>>> contains a few bindings for things that only exist in the system
>>> emulator.
>>>
>>> This adds a new "system" feature to the qemu_api crate that enables the
>>> system emulator parts in it, and build the crate twice: qemu_api_tools
>>> is the core library that can be linked into tools, and qemu_api_system
>>> is the full one for the system emulator.
>>
>> As discussed on IRC, the issue here is ClassInitImpl<>, which has to be
>> defined in the same crate for qemu_api::qom and qemu_api::qdev.
>>
>> Right now, the block layer has no use for QOM, but later it will (for secret
>> management, for example), so splitting QOM into a separate crate does not
>> work long term.
>>
>> I'll try to figure out an alternative way to do the class_init bindings.
> 
> There were more problems with splitting the qemu_api crate related to
> bindgen. Basically, you would want the system emulator bindings to
> contain only those things that aren't already part of the common
> bindings. But the system emulator headers will obviously include common
> headers, too, so this becomes tricky.
> 
> If you don't do this, you get two bindings for the same type, but the
> binding types won't be compatible with each other etc.

That might be a good reason to move the bindings to their own crate. 
Then you don't really care if the bindings crate has declarations for 
things that are only for system emulation, because they're just externs.

qemu_api is currently doing "impl Foo" directly on structs defined by 
bindgen, but that can/should be changed.  This way a PhantomPinned field 
can be added, they can be wrapped with UnsafeCell<>, etc. I need to 
understand better what Linux does[1] and document it.

Anyhow this is not a blocker, this patch is easily reverted.

> This approach of just building two separate libraries was a lot easier.
> Apart from the obvious inefficiency, I just hate the need for
> rust_dependency_map everywhere to make the library show up with the
> neutral 'qemu_api' name in both cases. Maybe there is a better approach
> where this could be defined for the library itself rather than for each
> user, but I couldn't find one. meson is still black magic to me.

Yeah that's ugly.  There's no way to define it for the library indeed.

I'd like to have split crates because for example we're now building the 
QOM and block layer code twice as well.  Ideally, I'd like to have 
crates roughly matching the C static_libraries, so for example utils, 
bindings, block, chardev, hw, etc.

Paolo

[1] https://rust-for-linux.github.io/docs/kernel/struct.Opaque.html


