Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3917C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 09:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfbQ8-0000mw-U5; Wed, 05 Feb 2025 04:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfbQ7-0000mZ-Vn
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:10:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tfbQ6-0004rD-Cm
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 04:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738746605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WKrlfm/+d/CdMVNMzj8FaOxnUO20Zo764K/5ifjn7Z4=;
 b=cgPZk9RRBzNVZcgrZyizSOloWnx+2WXHP9Nnluhehtc9BJBNio+ZFDeMerqXWFy8WWpCaD
 kotgWWP0TFGt8dUQVLbG1kTABmSY/3FjXXZdff99jrqFYLF8ZifNJ8zEfRbWMXV7KwM4Zt
 qEw3uRc5etLCI7JBZ4JtHMQ5Ydijbyw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-opcg-Qy5NMihySfECdjW7w-1; Wed, 05 Feb 2025 04:10:04 -0500
X-MC-Unique: opcg-Qy5NMihySfECdjW7w-1
X-Mimecast-MFC-AGG-ID: opcg-Qy5NMihySfECdjW7w
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa67f18cb95so265312166b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 01:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738746603; x=1739351403;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKrlfm/+d/CdMVNMzj8FaOxnUO20Zo764K/5ifjn7Z4=;
 b=Q6W742frT/M2UC2yer97tAlzd5qPbu8fmLfvIY9tYxsnK3GQ2+V4AJemnNbGolCCmM
 OEWs8Z9PP/xqBUWNa/x5dyZChwbOnRLFzwjzMDH1nvCvpAifv8K0gWdQpFCYBOr0cktc
 XB6iEOPIJlom6V4gl3i39nDTygibN9yDb+GeKrQyAeH9ffApDCKSKRv/sczFBXztw23i
 2laEAMO0heJtbgxR7FKHnBASZkdyq3PIFuBHughPSSI85xXwq74jel6DXv5ShKGv7Yv7
 mKg6j7LSJYE7V1KazC4bGtXKpcv3NiHlbs+8qYz5oxiJr3tNLFPuJjdD4tN1+lPB8otZ
 4ytA==
X-Gm-Message-State: AOJu0Ywysbl2XhFBUgqW3HxCSAM62DdgkxGG44fIx8+ZAzenQ2ufBALJ
 B5zjp5awMHYDie+QQ9a7H36bv7Nw4wnYliGf1rjGY+9TSnCPLvfvPCaOrY9EjIo7s//XxMmJvNh
 ra9LVl/39VQ9MOsLOtMAuKmjRhTbq48wuznG8wmJen71Y2cU/YWJU
X-Gm-Gg: ASbGncvCBu09RPDZUkI5vxt36sFol0IjZSZMSDj1qIhPFpWEoJmvveGWCyVR8O/R6xT
 WajR/+0zriMtPtUU2bUkpNXFC/W5wTIHk8kTQwMa1ORsSIVa6IVCnmgiViaQh5dmOgqTWfhZDUy
 t5MeO4V/bspjWpOeC1ragJ3Pfyqsk50A9Xf2LXPcj99ytLgl9AIZ07ow8I2pmGiT47XgDkh/LYa
 g/H+yQzDG0R+67q3peioywx1fdmW+207Kln//XjQPY47GWJNj1bT2YeJNVtM7GyjMiMaslwwSLG
 bz9EDxI=
X-Received: by 2002:a17:906:856:b0:ab7:6606:a8d5 with SMTP id
 a640c23a62f3a-ab76606b5camr61081266b.48.1738746602704; 
 Wed, 05 Feb 2025 01:10:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhxUarvvq/pT+83r1XhU4K7PYi9op6FrjEuegFqwI14CILdjg9pXr21lcnI9aggfILvxFPNA==
X-Received: by 2002:a17:906:856:b0:ab7:6606:a8d5 with SMTP id
 a640c23a62f3a-ab76606b5camr61078566b.48.1738746602341; 
 Wed, 05 Feb 2025 01:10:02 -0800 (PST)
Received: from [192.168.10.81] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a7be3sm1057297266b.20.2025.02.05.01.10.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 01:10:01 -0800 (PST)
Message-ID: <8e5cbee9-4a37-4a7f-948d-52dccb27ddd6@redhat.com>
Date: Wed, 5 Feb 2025 10:10:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com> <Z5c8gVcUn4rzVpID@intel.com>
 <CABgObfbLaHXtoGAkUVW9CUXio-N_1A=Awq0=ZCY3G8sAO+9NXQ@mail.gmail.com>
 <Z6Mrs4l+fRF7jcay@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z6Mrs4l+fRF7jcay@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/5/25 10:13, Zhao Liu wrote:
>>> * The use of from():
>>>
>>>                  let clk = bindings::qdev_init_clock_in(...)
>>>                  Owned::from(&*clk)
>>
>> In this case the C side wants to manage the reference that
>> qdev_init_clock_in() returns; it is dropped in
>> qdev_finalize_clocklist(). So Rust code needs to increase the
>> refcount.
> 
> Pls forgive me for one more question about qdev_init_clock_in() on the C
> side. :-)
> 
> qdev_init_clock_in() didn't unref `clk` after object_property_add_child(),
> so it is intentional, to make the ref count of `clk` be 2:
>   * 1 count is held by clocklist until qdev_finalize_clocklist().
>   * another 1 is held by its parent via QOM Child<>.
> 
> Am I understanding it correctly?

Yes, that's more precise.  In Rust it will be 3, the two above plus the 
Owned<Clock>.

Ah wait... qdev_finalize_clocklist() is only called _after_ the Rust 
struct is Drop::drop-ped, because device_finalize() is called after the 
subclass's instance_finalize.

So the result of qdev_init_clock_in(), strictly speaking, does not have 
to be an Owned<Clock>.  It can also be a &'device Clock; either is 
possible.  Would you prefer that, or do you think it's enough to add a 
comment?

Paolo

>>> Then the comment "the clock is heap allocated and does not have
>>> a reference" sounds like a conflict. I'm sure I'm missing something. :-(
>>
>> Changed:
>>
>>        // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
>>        // does not gift the reference to its caller; so use Owned::from to
>>        // add one.  the callback is disabled automatically when the clock
>>        // is unparented, which happens before the device is finalized.
> 
> LGTM.
> 
> Thank you very much for your patience. I think I understand ref count
> now.
> 
> Regards,
> Zhao
> 
> 
> 
> 


