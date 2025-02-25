Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4C1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 09:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmrXr-0007VA-Ag; Tue, 25 Feb 2025 04:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmrXn-0007Un-QN
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:48:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tmrXl-0006Es-Sc
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 04:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740476880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FuEsIP2O2tHJNVHhmve8zpwX/Sq5q/QV/BFBiFtj7iM=;
 b=MSmxZIYbbNxOfFkeS0DUyVHH5kr7x8Zpeegy28hem/yruWAoU4i5RhFCZ9PGtlu5syVNva
 hORK6a1SPtTWwZRtMV8tSP3UPLlHBmquQg/jjhRnUnFtPftjlBs67s1E8GZXZSxsnfgYs9
 ceU32NqmeKCuo7QzR5yJUzm2pQgJmlQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-U2qQBNmiM4CFjy197seROg-1; Tue, 25 Feb 2025 04:47:59 -0500
X-MC-Unique: U2qQBNmiM4CFjy197seROg-1
X-Mimecast-MFC-AGG-ID: U2qQBNmiM4CFjy197seROg_1740476878
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5e041305a29so5379555a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 01:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740476878; x=1741081678;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FuEsIP2O2tHJNVHhmve8zpwX/Sq5q/QV/BFBiFtj7iM=;
 b=HAfYwcSo9aYwUd7ZqErbRaV+UsSTFpTvB0lk6gEI2eBGMdpiB7+kb1J/TK0eVwi7KI
 KrkC/kAwIGenq7+Et1MwF+5ODqNfjyLDa6iObZ9mQAke+jOXNnM0o3tM8RAWiABGIp61
 elqCjid6rYgoiI7w/IhjJkOejLSBcE+6gAkAeBsKSmkF6YRd+VbhUGLMF9FPd37dd1Yj
 9hVMh66ADLG9ktnPO9oqH3rFvi+oGTDMGLdbrj3gstvfw7o1+DQUqRIzRyI3BvwYlY7C
 Wwe9ADp9IePXfxTN0vXVWCQSakHT8ihP6LVjY6PMUwp5ITFWNduWbDPv2kGEvhD1eInd
 lKoQ==
X-Gm-Message-State: AOJu0YysJx0SNXXA08FpnoyJqVse/1ihwsFkPVamC7TxMHRBZUJCDeAL
 9SMLheUn91Cn0+AQNKzZ+Zq2R4Ia6HY0olSaCMvZnalAa7A8/IcvwqTYPeBJ1HqdEPPnMcX6dEM
 ZP/fGtNs42Cu7BBYJ5DtFmTTFV72W8rr0jVcIuFMEXeLE4ay5+5y5
X-Gm-Gg: ASbGncudUs+VSoH9AjdOWHhojOakpU/s4VVERxaiSzuRF0pj8ieVrBWhbcR7sVaphOR
 sb83AjGOJL16dejTccJXUmPWI16FdtX8HARGP6wRbauG0391VM506ebfVJWmllWRXKbYceRE5x5
 FAS8mse+prhjepjmZIGrAfQxjs74e/5WZeZ31WkjzGI598vsj7QV79iChykrMGpIdJwjgSiGxg8
 qc+udCCuAazXR+XUvE+vlxtRAYXCzaz60JiWPO2Y5eei4flB3FUY0pO48R7h1Shu8EBKCPbr2AC
 mF2uq3vFhYZD1duka+PV
X-Received: by 2002:a17:907:970c:b0:abb:d047:960b with SMTP id
 a640c23a62f3a-abc0d9885e7mr1604099266b.4.1740476876595; 
 Tue, 25 Feb 2025 01:47:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWdwPduhCddhpakC5v8+D3m0cQ7xXzdB61AhMDe7Z3CI9hZ/EDBsukneiOUMGg2Yk1X8wtgA==
X-Received: by 2002:a17:907:970c:b0:abb:d047:960b with SMTP id
 a640c23a62f3a-abc0d9885e7mr1604097066b.4.1740476876197; 
 Tue, 25 Feb 2025 01:47:56 -0800 (PST)
Received: from [192.168.10.81] ([176.206.102.52])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-abed1cdb131sm111407066b.7.2025.02.25.01.47.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 01:47:55 -0800 (PST)
Message-ID: <3ef9ff7a-570d-4cde-a555-8415a07ccdd5@redhat.com>
Date: Tue, 25 Feb 2025 10:47:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] rust: memory: wrap MemoryRegion with Opaque<>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-14-pbonzini@redhat.com> <Z72J4uLSPvFBbpyz@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z72J4uLSPvFBbpyz@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On 2/25/25 10:14, Zhao Liu wrote:
>>   impl MemoryRegion {
>>       // inline to ensure that it is not included in tests, which only
>> @@ -174,13 +174,15 @@ pub fn init_io<T: IsA<Object>>(
>>           size: u64,
>>       ) {
>>           unsafe {
>> -            Self::do_init_io(&mut self.inner, owner.cast::<Object>(), &ops.0, name, size);
>> +            Self::do_init_io(
>> +                self.0.as_mut_ptr(),
> 
> I'm not sure why the wrapper doesn't work here.
> 
> If I change this to `self.as_mut_ptr()`, then compiler tries to apply
> `ObjectDeref::as_mut_ptr` and complains:
> 
> the trait `qom::ObjectType` is not implemented for `bindings::MemoryRegion`

It's because the implementation of ObjectDeref for "&mut MemoryRegion" 
wins over coercing "&mut MemoryRegion" to "&MemoryRegion" and then 
calling MemoryRegion::as_mut_ptr().

I added a comment

         // self.0.as_mut_ptr() needed because Rust tries to call
         // ObjectDeref::as_mut_ptr() on "&mut Self", instead of coercing
         // to "&Self" and then calling MemoryRegion::as_mut_ptr().
         // Revisit if/when ObjectCastMut is not needed anymore; it is
         // only used in a couple places for initialization.

Paolo

> 
> But when I modify the function signature to &self like:
> 
> diff --git a/rust/qemu-api/src/memory.rs b/rust/qemu-api/src/memory.rs
> index fdb1ea11fcf9..a82348c4a564 100644
> --- a/rust/qemu-api/src/memory.rs
> +++ b/rust/qemu-api/src/memory.rs
> @@ -167,7 +167,7 @@ unsafe fn do_init_io(
>       }
> 
>       pub fn init_io<T: IsA<Object>>(
> -        &mut self,
> +        &self,
>           owner: *mut T,
>           ops: &'static MemoryRegionOps<T>,
>           name: &'static str,
> 
> Then the Wrapper's as_mut_ptr() can work.
> 
>> +                owner.cast::<Object>(),
>> +                &ops.0,
>> +                name,
>> +                size,
>> +            );
>>           }
>>       }
>> -
>> -    pub(crate) const fn as_mut_ptr(&self) -> *mut bindings::MemoryRegion {
>> -        addr_of!(self.inner) as *mut _
>> -    }
>>   }
>>   
>>   unsafe impl ObjectType for MemoryRegion {
>> -- 
>> 2.48.1
>>
>>
> 
> 


