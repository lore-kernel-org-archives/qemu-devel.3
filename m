Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3260ACD6E71
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYRI-00083n-Gt; Thu, 13 Nov 2025 09:36:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJYKt-0002OA-Ur
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:30:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJYKr-00019m-Rd
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763044203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1qr20ZyZERt2gMXdQ/W6asiXmbcaJ9I0n9I3WfoiU8Q=;
 b=I/g3TbZrV4sfbUUke2m68QtrtpVWACXDV3Zrtb+9aYKlCwSYzY89FC7WldmGzZcM5EXBRP
 VYeY/Kd9lJKjB+RVm45Es7G7k7RgtJ9uWZ7Bz9fc8UmhLQV3gd8dnUNAAcv4xLeFU9ycQ/
 k7w8W2dbnCNQCgk+NPCEooEph5Qc0J0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-HpcxbqMUN06YPVVFU6j7eQ-1; Thu, 13 Nov 2025 09:30:02 -0500
X-MC-Unique: HpcxbqMUN06YPVVFU6j7eQ-1
X-Mimecast-MFC-AGG-ID: HpcxbqMUN06YPVVFU6j7eQ_1763044201
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b6d42c454c2so74842166b.0
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 06:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763044201; x=1763649001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1qr20ZyZERt2gMXdQ/W6asiXmbcaJ9I0n9I3WfoiU8Q=;
 b=ngUnEg0trfBRv3cOquqgFz27msEvt7Pu2TepJ8uSQpH778TfIl3G3z4E6mxzKYsZTn
 krRyiB9Z6bFXuAJlb+GjbhmBi709+QmTykE3BSY9EieQsyzKKwvb396Tk1YIhbv8AmCA
 bwP+Zw2Wz1cT1dHpv193bsPHUkF1Fc4pnznzpiGjT1VsGZwXZa+5m4dyjhpIcBB5Jm4z
 jQD8LADafxXebI/ggE4RwCfpccK//ZYjm27hjpsQXr3nS4g9i9QN4FuKZo1b0HIyn7iF
 RC6oB2VsqhrNAZUlkYimrlBgqYM+rOEzQzEs5NEju4mKdNd9awHuSlqM03eDN+Py75CQ
 MrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763044201; x=1763649001;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qr20ZyZERt2gMXdQ/W6asiXmbcaJ9I0n9I3WfoiU8Q=;
 b=TEdSlerH8Ffc5F236zYE7U8sEypJ0sVF6pm+2zDECdyd2zLGaMxpSO8DHmk9+O/es2
 SXNoM3/n+queNbqNoXViXiuOi9166w/zW7lDTZag5/pfZ5NNuT9WoXaLZ4lxHwa0w0ce
 AsjS7bQpIvUcdxTY9A+eh8gZgWbX4pZ47X8KRiXL3qAjAAZ8u7vGs9jd+AwG+A4q5O0N
 cSrlJoSVULogbcmYLJPVp088nb3nTWHMUB8WC9jTYwnBRjtyDVEwjHCSA+VU5uF04O+P
 TsxwW2w13+UOkjiExgNU+l6k939Qvl9N2efD6eK/NLuEecYSHRgU3EJChJiJS0VazMcI
 Mkkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwvTqxuRrWQTKWp0YZPj0VrDWaWrtJV2XKQRNtORJsV5k+i7Ti6jWASDs7uTpP3Jp77x5H0NTOg49p@nongnu.org
X-Gm-Message-State: AOJu0YylgWwkvL1gDIaE2Be2cYGQjz3Z/Veg7GjRq/5aaZx58Iyrp24l
 1oB+E9gYSblrKyDfLwiwgFDjAOZFHmGK7ADwDfZE9H2rtxzvBN5Aw08PNq39YI8ZWSqcIY9VU8V
 NhAuD0rg2EZxUbUw++SoVgM0L27yltCRBd6zTUHvp334HM00qkzx+SvH6
X-Gm-Gg: ASbGnctBF33fNbor0L07+y3scs+W72hetm566jFhMNhR9lD028fjEiaYrSr2sGswFrJ
 eR4euxPChOFT7a32jTDSazmiSMo+A4bBWAlf6QwBPimc3sG4Rd46dhS1uY/4VOpJnUChiTwQlit
 ERGCjnZfIZ47OuBYeTFJ5CPoN63oSxGArMsGktflinc1SPuJ8V/Djx5BcnRha3YGlPG4EIuWQv6
 cIlOmxmqC7JQEiil83OJHJuETNd+2oOVZUbZ3wHsZ8INFfR5HqnNIGqOTW1BbrCYmcxm2V2RnLI
 c2O2AdSM2e95H1yl1IpePTP0mJmAGkqVtIys6j6tILEMJ8dePL8SKSVgXvL0vdZGTnELUXqdy9Y
 +fe5gdSacNeF10C14tk460ncM4RfAWo2EPs0lqwJldwt7RPk0RT4fxAGTpLXPEXzVBrkkAunUVG
 aLtrDG
X-Received: by 2002:a17:907:9493:b0:b73:1b11:2ac2 with SMTP id
 a640c23a62f3a-b7331b3bd59mr789859166b.63.1763044200794; 
 Thu, 13 Nov 2025 06:30:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPtf/Dl9N11d3a4qffn/l4s3DdirNqKWzR/S+5rVaL2MZ/+PDbFQAXehJbnDBmu7OcsacRXQ==
X-Received: by 2002:a17:907:9493:b0:b73:1b11:2ac2 with SMTP id
 a640c23a62f3a-b7331b3bd59mr789856966b.63.1763044200389; 
 Thu, 13 Nov 2025 06:30:00 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b734fd809fasm175926166b.45.2025.11.13.06.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Nov 2025 06:29:59 -0800 (PST)
Message-ID: <6ed6a959-fe49-4635-9051-b9bbc91dd2e4@redhat.com>
Date: Thu, 13 Nov 2025 15:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] rust/hpet: Enable lockless IO
To: Zhao Liu <zhao1.liu@intel.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
References: <20251113051937.4017675-1-zhao1.liu@intel.com>
 <20251113051937.4017675-23-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251113051937.4017675-23-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 11/13/25 06:19, Zhao Liu wrote:
> Enable lockless IO for HPET to allow BQL free MMIO access.
> 
> But BQL context is still needed for some cases during MMIO:
>   * IRQ handling:
> 
>     Like C version of HPET did (commit d99041a20328 ("hpet: guard IRQ
>     handling with BQL"), BQL context is needed during IRQ handling.
> 
>     But Rust HPET has an extra reason that InterruptSource is placed in
>     BqlCell, which requires BQL context explicitly. (This also shows
>     that the BQL limitation in the design of the InterruptSource binding
>     is reasonable.)

Thanks, this is helpful.  It shows some complications that I honestly 
hadn't thought about.  So many more things to be precise about, compared 
to C...  but I have an idea which I'll mention below. :)

>   * BqlCell/BqlRefCell access.
> 
>     Except InterruptSource, HPETState has other BqlCell and BqlRefCell:
>     hpet_offset (BqlCell<u64>), rtc_irq_level (BqlCell<u32>) and timers
>     ([BqlRefCell<HPETTimer>; HPET_MAX_TIMERS]).
> 
>     Their data may change during runtime, so the atomic context is
>     required.

I have already mentioned HPETTimer in the other email, but I would also 
move hpet_offset to HPETRegisters if possible.  It doesn't seem hard.

And as an aside, I wonder if you really need to pass MutexGuard and not 
&mut HPETRegisters.  Once you don't have BQL dependencies, you can just 
remove the assert!(bql::is_locked()) without switching to MutexGuard<>.

In the meanwhile, even if they are not perfect (especially due to 
migration), I think touching patches 1-19 further is too messy, so I'll 
rebase on top of Stefan's tracing patches and push them to rust-next. 
Let's start from there and I'll take a look tomorrow maybe on how to fix 
migration.  Migratable<HPETTimer> looks like a powerful tool for that.

Then the new problem is that we have to figure out a way to handle IRQs. 
They are also messy for PL011 compared to the C version, and that will 
make it possible to enable lockless IO.

The crazy idea that just came to mind, is a Latched<u32> that is 
something like an (AtomicU32, BqlCell<u32>) tuple.  Then we set the 
individual bits outside the BQL and update IRQs at the end of the MMIO 
in a bql::with_guard() block.  Maybe if you have some time you can 
prototype that for PL011 (even without generics, you could just do 
LatchedU32 for a start)?

Paolo


