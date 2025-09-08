Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98075CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYyh-0003YV-9m; Mon, 08 Sep 2025 06:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYya-0003WX-B5
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYyN-0001ga-M3
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=//JF9DWA680VZ6/SuxoQA/o/hdMIuug8NzPVOIP4wds=;
 b=ccA0JFy+2HVZuiD4IYH9ap/zbHFDfylticOKUIVbg3HLHtzt0F3A3ETZe+R7fMxNkNzFQS
 5mp3d0+AWnMShfZQ6+2vKKzeViT6ULBnbHqHvaM9+oX3i8IpkHcMxK3cYY2aibz9AFGDAv
 gSF2bspVDy1FEnBc5AHbk5qa7ClJRvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-eEZo8xxOO4yzHU7HJMYVhg-1; Mon, 08 Sep 2025 06:19:36 -0400
X-MC-Unique: eEZo8xxOO4yzHU7HJMYVhg-1
X-Mimecast-MFC-AGG-ID: eEZo8xxOO4yzHU7HJMYVhg_1757326776
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e38ae5394aso2354008f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326775; x=1757931575;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=//JF9DWA680VZ6/SuxoQA/o/hdMIuug8NzPVOIP4wds=;
 b=mdKSv1MdP11XcdoqqsO44UoTNRuav3w3KS6zrPq3V1Etk2OyazEKGNKBEWgAYpzI1h
 0faJv0rsu9wo9ilccalFPxcknncEv8CW+2huLHwBhbY4Vk1trcm/GCeT8gSqXaLZhBhm
 s+LDje2ndcS7oZvJiAzC17lFcxLO3Ga1iw6C9iGnZ+ASwME9HYjjeY6+WEQRpe7Tk/d4
 hozczhm601umU9EmelLOUjTYvLkfmc4Uid0G7MYRihAzSP2fbhwu5CGrDhJqbbRwfDCQ
 87wPYYmUBekc7Vks5r0bkfHigAOyHcOEheiycyjlpzx4m/04Glr2E78YsiqGvJyK/hYP
 NNMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVw9zrpY/IeXvx0TDsAnG9S95rc+pxBgihkG7NlQJ7Nnfwwx9bkVrli4btODCzN+pAJ6LCxWiJQzsh@nongnu.org
X-Gm-Message-State: AOJu0YyKTkdVyHbwE1QxocjioYtjWcV1C4lapNpsjJ/Ga79F4p+B7/Vx
 +seAY2AJvPGwFdLHgyHc8V3cSyImX70TyqWscybTYjB08C6uG8QYH9ItzQR1BjBVgFBuUl27F0c
 2jysF45LiiZnWRDHgiOmzN/Xab3DFUN3xUH+TlsQ2D3bVBsHvGCPHoqoD
X-Gm-Gg: ASbGnctz2STdO5RSckAwSL4VCkxVVsz5rbY30cmoqVgvLWJ05CP0M4M1TkaxEI3YWK3
 7Ps0WB4OqXWMroyo9FdgkehhHlymKN2ytdyI+3Rtp54E4+4Nl5ictXF7765eCCSBJDQBuQ86DWV
 pbZJCuqmVGOmyHyOyrMfU3ZdAqWG2gnV6gq0C2M2m8fafs/JBAKGYS9FH7smoXXrDSHxYBc/s0R
 vv40hVgfWPWszOT40n+3BLi86uJI2mRTBZgrV5Fg6Z2WDOj33STEwkxiaFefff3VP3y/7t2fusj
 JJ3a3xMVoTZ8BWIoerSpX0r40vsB8S5ZDqLpOXSSj+xDHnkwDfctRaWaf6mZ8pvd4YfhyWaBZMb
 tzHQhGe1XB1hSHx6h1+sTkjK4EQxUjp8IZNVJUxnP4so=
X-Received: by 2002:a05:6000:2889:b0:3df:58c5:ef94 with SMTP id
 ffacd0b85a97d-3e64392d221mr6361410f8f.40.1757326775457; 
 Mon, 08 Sep 2025 03:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGX6akonXYpWiJLftFliD7Guvgs5m84u4dkHbgo5vKGPH6fviTDCc4tmQRFT55LcCyGUCVLA==
X-Received: by 2002:a05:6000:2889:b0:3df:58c5:ef94 with SMTP id
 ffacd0b85a97d-3e64392d221mr6361384f8f.40.1757326775060; 
 Mon, 08 Sep 2025 03:19:35 -0700 (PDT)
Received: from [192.168.10.27] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3e74ee8cf4asm413531f8f.29.2025.09.08.03.19.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 03:19:34 -0700 (PDT)
Message-ID: <ee80babd-6e48-483b-93d8-849539c0f378@redhat.com>
Date: Mon, 8 Sep 2025 12:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rust high-level pre/post migration callbacks
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-rust@nondevel.org, qemu-devel <qemu-devel@nongnu.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <8076a298-1cd9-4c90-a64c-f65004753975@redhat.com>
 <CAAjaMXaPM0qrCwrMY_n531R4d5X3h+GjRHKzjHLeY3FprT5_TA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXaPM0qrCwrMY_n531R4d5X3h+GjRHKzjHLeY3FprT5_TA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/25 12:02, Manos Pitsidianakis wrote:
> Hi Paolo,
> 
> I'm not familiar with how migration works under the hood, but this
> data transformation design looks very clean and neat to me.

Thanks!

>> Using it is very easy, you can just declare your state like:
>>
>>       regs: Migratable<Mutex<MyDeviceRegisters>>
> 
> Hm it's a shame we cannot do this with a trait since it requires state
> storage for migration_state.

Yeah, but a Box is just a single pointer.  We need to have an actual 
location in memory for the C code to retrieve the pointer.

> A suggestion: we could declare a "mirror" struct to hold
> `migration_state` with a Derive macro. This is what the `rkyv` crate
> does with its `Archive` derive macro and trait
> <https://docs.rs/rkyv/latest/rkyv/trait.Archive.html>

Nice!  I'm not familiar with rkyv but it does look very similar.

When I tried to clean up the HPET (create HPETRegisters, and replace use 
of raw pointers with self_cell to implement self-referential structs), 
migration was the big mess, so I hope that this design will fix both 
that and Mutex<>.  And indeed having a derive macro is very similar to 
what I came up with one day later :) while thinking about how HPET could 
use it in practice.

Probably the derive macro would require some changes to the trait, but 
the basic idea remains the same.

Paolo


