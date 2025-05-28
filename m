Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F56C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 11:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKF83-0005dc-6R; Wed, 28 May 2025 07:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKF7i-0005aV-Ji
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKF7f-000659-Hf
 for qemu-devel@nongnu.org; Wed, 28 May 2025 07:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748432340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5UlRWtxLGJx/TX+OrJuXUEzFWoVMQDNFtOeubM3y86c=;
 b=PvG/mnePVD7/oB+I3UIiwLe6WjLQMkPv5RWg0qLBIfH/2+BdGJUMi3lHpf0ivYcN+lm0rZ
 pzpEa4IXb956R+mzyqdgwUzgn12YGU8f2Rs0vdH+z+7aLfZOQFEJoDtO8u6cqxxKaAXVmY
 zFqABNEYU5igR4BColoj0Js8uUu9J1w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-j5YCJDpmOx6UtVRXBZecPw-1; Wed, 28 May 2025 07:38:59 -0400
X-MC-Unique: j5YCJDpmOx6UtVRXBZecPw-1
X-Mimecast-MFC-AGG-ID: j5YCJDpmOx6UtVRXBZecPw_1748432338
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-604e82a5d37so2091337a12.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 04:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748432338; x=1749037138;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5UlRWtxLGJx/TX+OrJuXUEzFWoVMQDNFtOeubM3y86c=;
 b=VmYFnzKmUk+jiPWkH06z34vqRfANDbnmcefcoLV7xFb+HSc6aqkqN7EDGxesuWw18P
 coQdzYdziq8fsPolcMj4htf9Nh5bVQa/SIpEFtNIbZoAecyrNsvOwNYUrf91RZmiNWuU
 DpRWUmMY+ZsQgCpsSeR2W+Yyyhq6L3vq98OZLcerkGwBWKEZtF5LkK8JHlTdd6q0QmAi
 0YjCoxJ6h4oUb7V2Gmph2bghw77pX7dw8M+0+LDyWdiLtc1fw6CCgpAErbHizATQFdBS
 yYblKsEfgdsZ9Jrpe110WUYIHV34883BiAywyTZ/DMqhwZADblbrqlZvx4czq+RY1N2O
 xOew==
X-Gm-Message-State: AOJu0Yy16Af1PqC5oTUKvE6jqIKVyptIXVFyV46jEO0+w1ffKcHEM+44
 O2hAPmE/kpHdD7Se6aCoS6gdW1sM0CM/KVEdFEu54kKXHgJ1yb/WbRwqgVn6hNObNjKAGg+Wq/X
 rcFZ7nI0Z47Yyq+APkN0j6GFgMDpxpqT257jyQxqZHNhGT9Ir87caHLDU
X-Gm-Gg: ASbGncvkFpWIA7jM6wFYshqO2kNwKMaiCMWrfVncDUFX9O+tJmv1uFkzPAadV2Fs+cS
 kYjoid97do4kiPQuOTsJWEtTaRa8pptM42go7FhwQ5zW/G8Al58Ts7Ofz1t4qB3Fs487CrKKLag
 rmHMsKom8o3gVbj5Px/gweIcCao/aFonp1KCK2BvtrnA/OzNAnZ+uLvZ7D57ovqkqAkwRDJA50n
 1nf6zsJp/ijQ9m26uepghmr1uj4Q/LambsEFlGhGOch8AOXNbLsEUd1tbwlcsKRvCIOXZBwWzil
 fYyN8zLm+E/dyA==
X-Received: by 2002:a05:6402:26c4:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-6051c4ef709mr1483212a12.24.1748432337726; 
 Wed, 28 May 2025 04:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESJvlpBRArNWYINsAp1wlOil5rxUtaO4UWcnPmvgfi0cr6ppM8gUtHlEo/di4OT/4clqnXOg==
X-Received: by 2002:a05:6402:26c4:b0:5f3:f04b:5663 with SMTP id
 4fb4d7f45d1cf-6051c4ef709mr1483188a12.24.1748432337317; 
 Wed, 28 May 2025 04:38:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6051d7a0013sm659319a12.80.2025.05.28.04.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:38:56 -0700 (PDT)
Message-ID: <0c5f3e95-3aab-448d-9713-97413cb5c2df@redhat.com>
Date: Wed, 28 May 2025 13:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH WIP RFC] rust: add qdev DeviceProperties derive macro
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20250522-rust-qdev-properties-v1-1-5b18b218bad1@linaro.org>
 <CABgObfbVSZ9MNzjXBu1mr8bzX9F-AoKVRQzCJj6c+SUpsoUQNw@mail.gmail.com>
 <CAAjaMXbEB_c7NpBVen29Tgtmki4+nADnXysawK+oSbWDBWPR2w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXbEB_c7NpBVen29Tgtmki4+nADnXysawK+oSbWDBWPR2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/28/25 12:49, Manos Pitsidianakis wrote:
>> It's not too large, overall.
>>
>>>  #[repr(C)]
>>> -#[derive(qemu_api_macros::Object)]
>>> +#[derive(qemu_api_macros::Object, qemu_api_macros::DeviceProperties)]
>>
>>
>> Is there more to be derived that is useful for Devices? Maybe the
>> macro can be DeviceState or Device.
> 
> VMStateDescription and the realize callback, I think.

Ok, pick the name that you prefer.

>> Can you change the name to be a "normal" string and change it to a C literal in the macro?
> 
> That'd be neat, it should be possible to create a cstr literal token
> and error out if the input str literal cannot be represented as a
> cstr.

Yes, shouldn't be hard.  If it is hard, you could resurrect the c_str module
and use ::qemu_api::c_str!(#string).

>> I would also merge the files at this point, but no hurry.
>>
>>> +#[derive(Debug)]
>>> +struct DeviceProperty {
>>> +    name: Option<syn::LitCStr>,
>>> +    qdev_prop: Option<syn::Path>,
>>> +    assert_type: Option<proc_macro2::TokenStream>,
>>> +    bitnr: Option<syn::Expr>,
>>> +    defval: Option<syn::Expr>,
>>> +}
>>> +
>>> +impl Parse for DeviceProperty {
>>
>> Can you look into using https://docs.rs/crate/attrs/latest for parsing?
>>
>> (attrs doesn't support LitCStr btw)
> 
> I think we can do without it for now, even if this patch is not
> cleaned up (for example it has unwraps instead of proper panic
> messages or error handling) it does not end up very complex as far as
> attribute parsing is concerned.
> 
> I'm fine with either approach though.

Ok, I'm fine with the manual parsing as well; just use Result<>
instead of panicking.

>>> +#[proc_macro_derive(DeviceProperties, attributes(property, bool_property))]
>>> +pub fn derive_device_properties(input: TokenStream) -> TokenStream {
>>
>>
>> Do you need to handle errors in the parsing of attributes?...
>>
>>> +        _other => unreachable!(),
> 
> This should be literally unreachable IIUC, because only property names
> declared in the attributes part of `#[proc_macro_derive(...
> attributes(__))]` would get accepted by the compiler and passed to the
> derive macro.

You're referring to

+            other => unreachable!("Got unexpected DeviceProperty attribute `{}`", other),

and indeed this one is good as is.  The "_other => unreachable!()"
line above, instead, comes from matching on input.data and it can
be replaced with the existing function get_fields().

Paolo


