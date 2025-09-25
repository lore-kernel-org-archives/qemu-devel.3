Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECB1CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1pHA-0006X8-67; Thu, 25 Sep 2025 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1pH8-0006Wi-NB
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1pGx-0000PE-GE
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758819401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l9xOjTUmjL6f40nOvXHEu6IEzN2COneWIC+IgsaSJvs=;
 b=gaMYM/427OvnipkeVMzWCcIh/2EBC/5i23wbF4BzJHgvXaBgw0F1Y6U+jTYE29/QL45dq5
 O/+QauY2cKrhx1nrk/TGG7xSSZR3vsyswh8tCKmnFC4XkVDN3nWVYj59CEARvdDAejA3Ag
 HJ9xx96zKSXZqIj9ouMYk0CDAZ9cF5U=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-Rb8HM88cMsCPUC2VTDX3ew-1; Thu, 25 Sep 2025 12:56:39 -0400
X-MC-Unique: Rb8HM88cMsCPUC2VTDX3ew-1
X-Mimecast-MFC-AGG-ID: Rb8HM88cMsCPUC2VTDX3ew_1758819398
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-62fce1f3fa8so1020085a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 09:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758819398; x=1759424198;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l9xOjTUmjL6f40nOvXHEu6IEzN2COneWIC+IgsaSJvs=;
 b=H0ADXIZWZ9VBgpHySY9cY4oa3EkH+/ckdEApDdhK+/m8yknDwZ+0ylHNeD7YEdilPL
 xLU3E4MqStBAaJhpVT4k6CJgnuqBewfiFs8o8/6FbtGKP3BRHew0bn6AkBzaVw7jZNiA
 JJmajDF/0P0pGkzAyY3dY1TecNebS4hT1v+UKKZwFwcevO33krqFL3yDmdJ/jmN3DaOF
 D0hoop9utcM42Okf35pL/JjPhrPXH+9kv01qEsZAPWphI6F/4dVpZFChMxBcGx6yT8LS
 SREyYangp61KLowm9jYfoUlGxMaejiJ2dkiQJCI0Y8MBNLTRbvvkEeu4rC/DMkGdsgIU
 a6EQ==
X-Gm-Message-State: AOJu0YyCCbhY7yOih/eCzfAsCn7iwJfIgBXdVTrVfT4H4N+zCNhM5Stc
 nszP32jQAyTPVXKwrXiICS91ULA8WZDLZC3si6zSnTXyzEG07BtcCakjj6/A9Du60icFTWYHula
 qRRc0+HmpCY2nUvb4s7kETFYICJw7r1rKq+korXUpIUOs+UIiWOekL2Ss
X-Gm-Gg: ASbGnct1df9hxonuC42H3YpujrJHJ+jMgABsv1L6ScqPWHZMmJUFy+ib+vnA1p+FIUY
 zLfs5pND5UWSpvtbx1DTGjDqXK2Yvd6TXvDk9BoaIRblv8fTwP9YVxAyiELwCaOrTqqBJKs1Yi+
 3Zkubr+M4dMxhmjZpy1MZW5ckrAkgaOwEkW7emJdNqvPTcV7oo+nz9O223bS9yvBlI1ogDp40qu
 JheIJhrvzgRXBcVwcPJ4nyCiloRUqaohrhLwx7BJiSezCjTxWgB7YQFa6pRDLwJJsiPTvx4axZ0
 gRRI6f5QeTBOITGtWD+sasrS/CzgzG5ikkNyDejnqDxfL2V2MZMurdicAmTCNKloJ/KHxgs+Vvt
 Qy6HdSKXR7ardQ/EPcSjF5cU0WV0/OE+PX2GX5msmIA==
X-Received: by 2002:a05:6402:42ca:b0:634:b3d1:8f92 with SMTP id
 4fb4d7f45d1cf-634b3d19125mr763184a12.0.1758819398060; 
 Thu, 25 Sep 2025 09:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG05CN6qEaAjff9j+oDZxPJVNbtbBsmQrOMPdzbFMLFJBhAal3q4w4i/Vmu9C7HeEPCBeWLQg==
X-Received: by 2002:a05:6402:42ca:b0:634:b3d1:8f92 with SMTP id
 4fb4d7f45d1cf-634b3d19125mr763146a12.0.1758819397504; 
 Thu, 25 Sep 2025 09:56:37 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.206])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-634a364fd05sm1469811a12.13.2025.09.25.09.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 09:56:36 -0700 (PDT)
Message-ID: <272e5d71-0671-4ebb-9ce0-7abde2720a44@redhat.com>
Date: Thu, 25 Sep 2025 18:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] rust: qemu-macros: add ToMigrationState derive macro
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-6-pbonzini@redhat.com> <aNU3Cgll0vETC2Az@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <aNU3Cgll0vETC2Az@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 9/25/25 14:35, Zhao Liu wrote:
>> +/// #[derive(ToMigrationState)]
>>   /// pub struct DeviceRegs {
>>   ///     status: u32,
>>   /// }
>> +/// # unsafe impl VMState for DeviceRegsMigration {
>> +/// #     const BASE: VMStateField = ::common::Zeroable::ZERO;
>> +/// # }
> 
> Outdated comment? Looks like the DeviceRegsMigration definition is
> missing.

It's defined by the #[derive(ToMigrationState)].

> the below conversion is ugly:>
> #[property(rename = "msi", bit = HPET_FLAG_MSI_SUPPORT_SHIFT as u8, default = false)]
> 
> conversion should happen within the macro parsing process. But unfortunately,
> try_into() is not const, maybe I could do this for bit property:
> 
> diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
> index c459f9bcb42f..e67df57c3712 100644
> --- a/rust/qemu-macros/src/lib.rs
> +++ b/rust/qemu-macros/src/lib.rs
> @@ -275,7 +275,10 @@ macro_rules! str_to_c_str {
>                   name: ::std::ffi::CStr::as_ptr(#prop_name),
>                   info: #qdev_prop,
>                   offset: ::core::mem::offset_of!(#name, #field_name) as isize,
> -                bitnr: #bitnr,
> +                bitnr: {
> +                    const _: () = assert!(#bitnr <= u8::MAX as _, "bit exceeds u8 range");
> +                    #bitnr as u8
> +                },
>                   set_default: #set_default,
>                   defval: ::hwcore::bindings::Property__bindgen_ty_1 { u: #defval as u64 },
>                   ..::common::Zeroable::ZERO

Good idea (also testing >= 0 is needed).  "const { assert!(...); }" is 
even simpler.

>> +/// - `#[migration_state(clone)]` - Clones the field value.
> 
> How about emphasizing the use case?
> 
> "Clones the field value, especially for the types don't implement `Copy`."

I don't have a use case yet to be honest, but at the same time I want to 
help potential device authors and remove the need to muck with the macro.

>> +/// Fields without any attributes use `ToMigrationState` recursively; note that
>> +/// this is a simple copy for types that implement `Copy`.
>> +///
>> +/// # Attribute compatibility
>> +///
>> +/// - `omit` cannot be used with any other attributes
>> +/// - only one of `into(Type)`, `try_into(Type)` can be used, but they can be
>> +///   coupled with `clone`.
>> +///
> 
> ...
> 
> The implementation of the entire macro is great.

Thanks. :)  It's indeed pretty easy to follow, and I like procedural 
macro code that is simple but powerful.

The attrs crate also helps a lot!

>> +#[test]
>> +fn test_derive_to_migration_state() {
> 
> ...
> 
>> +        quote! {
>> +            #[derive(Default)]
>> +            pub struct CustomMigration {
>> +                pub shared_data: String,
>> +                pub converted_field: Cow<'static, str>,
>> +                pub fallible_field: i8,
>> +                pub nested_field: <NestedStruct as ToMigrationState>::Migrated,
>> +                pub simple_field: <u32 as ToMigrationState>::Migrated,
>> +            }
> 
> In the production code, CustomMigration still needs to implement VMState
> trait, so that String & Cow<'static, str> also need to implement VMState
> trait. This seems like the thing that we are currently missing.

Or more simply they're not chosen well. :)  For the documentation I will 
think of better types.

> For test, it's enough to show how the macro works.

Yes, for testing it's a lesser deal.

Paolo


