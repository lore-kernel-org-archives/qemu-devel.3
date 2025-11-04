Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A6FCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 14:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIDU-0001W5-2L; Tue, 04 Nov 2025 09:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGIDS-0001Vt-HE
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:40:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGIDP-0000Ir-RJ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 09:40:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762267253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TLuEQK6nczcQpH6Y03wNMm12WVfEPzppTG57S8h6lTk=;
 b=GPPAhKLAftzkDBdUdOSIOdEaSMQva0F2/wmkT1+EHokfiWxgnxWIeoAjskJ4Buu0jZGPLF
 liWKvEs5bGct/8iJ9NsM9G80JHtbGDhKJzDxgurTjR2rCd7f5TgHlVKosybUCOEmTpo+6u
 ZbBo5reZnsE6g57hLezctzc6J6qOGF8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-hG7KdE0CONunHP3vSM7wXQ-1; Tue, 04 Nov 2025 09:40:51 -0500
X-MC-Unique: hG7KdE0CONunHP3vSM7wXQ-1
X-Mimecast-MFC-AGG-ID: hG7KdE0CONunHP3vSM7wXQ_1762267250
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-640cdaf43aeso2845046a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762267250; x=1762872050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TLuEQK6nczcQpH6Y03wNMm12WVfEPzppTG57S8h6lTk=;
 b=U96CZwfKBHW9uPuuUk4gN9gz9nvle26MHmF9o97zqBj8mUQMSoacSANGY9kJkogg3h
 7rkG01StZwESlJrwmd7f/1EVpn+v+9fbKLZlUXpxFG7UG+5EB1xtV5hkaD+mwzRl5nUT
 JvA+mVDwsDcSEIalB0oz5p/lThsN2nSH6T9brP8gGsX/gcirHDHtTFNAmCaYeUXZWhfH
 9Q7wfKGHeSudFSjNdKvElt2OcBrADxXGuGceNHPwLK60tpOCrTIvWMYVlNdN2BsG2NJ6
 22K6f2lfbJYVgeLes+2vYqsHQc3Md59z2hRBBN3FTL1OYikufwuzZR8+wIlbWDosdiQn
 WZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762267250; x=1762872050;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLuEQK6nczcQpH6Y03wNMm12WVfEPzppTG57S8h6lTk=;
 b=cjbDEt+slWqfxNcyRRhV2Lm93NokUfiVNYq+DQNItfWE2v4RFt8sfXOLr9ZeB/nAco
 d5EZ6jWY80zhIC+PY6vvdzQmc9QPoURbSV8MnzPSAEeOa8ybVOS0WTQdK1glweLj57l1
 /b/w5h0S4M63fmFVxFpqFe4J/udrRVbyzk1pOPP2m/sXtX/EjzInMeMjH9UsCYHPoLvR
 ImHzxcjKIthZqiMyYJIbQiDYQgeqvMMFIwRqD+OoPAcZzVMVokCV9DpIn8y/YTwcBfu5
 0KiMVaYm4K1/sja+zJHlAYJy6IDZtzO4zx+Rxo9fnK7nhw5pJsbirQz/+deJpx25kl+Q
 i6qQ==
X-Gm-Message-State: AOJu0YzqfM7V6q+UUtNuUbck60qxdfv94iyYHVRMoNnQqf1QG/1sX9+c
 s0LjEoEgdK5oDGPnwzIc+mTpWZ3XZ/r69y8HXsRFgBQTZoRKQLbVoS2V4NnGJ2f7BjGe+sR4OFN
 Io++j5jFo3ln5EyLQEYdCJjmRt6hxQPzQm+nJo/74A2Y5kZOiPrqzYFEGkvrcAfTi
X-Gm-Gg: ASbGnctkYyVG4tISn6K3+bIVv8BxmdV2qpwHFxN/sIjiDLcgYzlFyGV2LGZ2YXBpu2l
 +LfO281aOQ/c4gPiBfGVsZv029wTbid8DRE7Dvvw/KG6XnAcn5ajbcsWUwEk8WqSNr1asKHEq4Z
 sI0IMRiRV4qvuw4pUGLSvqDsi2puVi2XDk7ETDre8IDJXmzOfNxuazaDxas5pPkbXwClhOQ0njt
 8sG3HHzhV3KcZhA8dfGe/qxY3BmUqAUz/fKVRVuwuXmR2+48XqHMogJvYYz12vu5EUNGsiUX9jl
 OVo6apSVbeMCI1JXpXOn1yJynIewJzDHCPki90IIwWIdMWNyUAxp376PaxjTjS53oqqV04SyFL7
 9/Uwk2+cGI6WtPqHVtlxSkPjpWs8sSKX091OXQzYiZEezTfKShTvSV/tdbTqq988/Rq96AoLk4M
 kC0zwD
X-Received: by 2002:a05:6402:848:b0:640:bd21:242f with SMTP id
 4fb4d7f45d1cf-640bd212911mr6485533a12.1.1762267250097; 
 Tue, 04 Nov 2025 06:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJoSPyhx67aMbFoJ2TALMmS9Ik8uCsIODQAS38Wv3S7fVmS5hcHJCMtQ3nZpF8fto3ntgctQ==
X-Received: by 2002:a05:6402:848:b0:640:bd21:242f with SMTP id
 4fb4d7f45d1cf-640bd212911mr6485497a12.1.1762267249622; 
 Tue, 04 Nov 2025 06:40:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-640e67eb65bsm2214281a12.4.2025.11.04.06.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 06:40:48 -0800 (PST)
Message-ID: <21c1ea17-6555-4dbf-b10d-e62eca302acf@redhat.com>
Date: Tue, 4 Nov 2025 15:40:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] rust: qemu-macros: add ToMigrationState derive macro
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-8-pbonzini@redhat.com> <aQiDFo0Yv6sIZsH5@intel.com>
 <aQjPApAmM2Hma3Rm@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aQjPApAmM2Hma3Rm@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On 11/3/25 16:49, Zhao Liu wrote:
>> did you miss something like the following?
>>
>>
>> diff --git a/rust/qemu-macros/src/migration_state.rs b/rust/qemu-macros/src/migration_state.rs
>> index 5edf0efe687f..2064bb73a6f0 100644
>> --- a/rust/qemu-macros/src/migration_state.rs
>> +++ b/rust/qemu-macros/src/migration_state.rs
>> @@ -236,6 +236,16 @@ pub struct #name {
>>           }
>>       }
>>
>> +    fn generate_vmstate_impl(&self) -> TokenStream {
>> +        let name = self.migration_state_name();
>> +
>> +        quote! {
>> +            unsafe impl ::migration::VMState for #name {
>> +                const BASE: ::migration::VMStateField = ::common::Zeroable::ZERO;
> 
> It seems the generated migration_state_struct needs a complete VMSD:
> collect all its fields and build a VMSD.
> 
> And then apply impl_vmstate_struct! to this  migration_state_struct.
> 
> If we zero the BASE, then `vmstate_of!(Self, migration_state)` seems
> can't migrate its fields.

The VMStateDescription for the inner struct is indeed missing, but you 
need to write it yourself and apply impl_vmstate_struct, because the 
derive macro cannot know the checks or version_ids for each field, or 
the subsections.

The VMStateDescription for Migratable<> however is automatic (of 
course), and the outer VMStateDescription for the device is simple---it 
consists only of the parent class if applicable, and the Migratable<>, 
similar to VMSTATE_PL011.

For HPET, you'll have to move the subsections from VMSTATE_HPET to the 
inner VMState.

Paolo


