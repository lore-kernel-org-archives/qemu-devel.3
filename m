Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425A5C02181
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 17:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZvR1-00065J-KZ; Mon, 20 Jan 2025 12:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tZvR0-00064q-VC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:19:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tZvQy-0005FE-Sh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 12:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737393571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ktd98cBCw8JVjyAiUFx6Au5Zurp/46O2DsACOHf9WT4=;
 b=cIQzTUveNe76pkgby/tcLyp1ESKUxgcMuhMabQhG1Ntio3u6mt30Lpgr12WTpFiRmJh1Db
 HO9xBSDsA0ihZN2Wcup88gR2SaF9HWEtWxAdtTqTbpQ1mfhmSgYr/uIvPy2hNTdd4m2dCk
 mgxc9h13V2LcKL+gxzaKj4T0mQnU4dE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-1vcHi7LOMtOTb1aYB8qM-g-1; Mon, 20 Jan 2025 12:19:29 -0500
X-MC-Unique: 1vcHi7LOMtOTb1aYB8qM-g-1
X-Mimecast-MFC-AGG-ID: 1vcHi7LOMtOTb1aYB8qM-g
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d9f21e17cfso4713829a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 09:19:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737393568; x=1737998368;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktd98cBCw8JVjyAiUFx6Au5Zurp/46O2DsACOHf9WT4=;
 b=Qe+L53tlbh8/H3xeEho7ulaPxMl0Yc7UiMRStVvf5nPEn4VVqf7o8STWb+oVlhhEOZ
 ZWBtWC4yzFXxwaGBu8mkv88IB08Qi1guR/t4bFavoOE9kfMHf2ewlhrU9ySPlqbPTdCy
 QyWFhRfsFiS21+FP/aWGIrBC2HfUAfDVH8PwXUOsDgOVk8gans/zaPDDKjsQM/OxMAX5
 LDdK1uLlZb5kUPWZL/RV0vG+pTlr/Z/a2uB0TXgY7r+YLKzoMZZm8ZaPBCqgj5igCwR7
 lK1seAZcRTv0EHf0JCPIlqSye1wzfZIywerFqx/88JPIEzIguaFDv0BhyHCYIofRe/+Y
 iPIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUblgoX6sKHDFmXdBqsiffKalvV4UiUMRC13rxSeuvy7BlCnmhE3OQHK7JrULb2VN662+OVeqK9tK4@nongnu.org
X-Gm-Message-State: AOJu0Yyb5q/MFx/ZZsZIQHyTRMRymouC7HJBYT0D/PrY2mjzZywITywl
 f6IKXt+zKOyU/W0wKEuDLR6chI0+mNYph1N575A5dbHT03MhVIvcmgdA7S6Hk0tEJnA2hZlAARw
 3OWCvos2aBkRXJAS4DniX4xMmx8vOy74Uh57lMh9Idv7W9zIRVB+t
X-Gm-Gg: ASbGncsL6lwwar3+BfFZmJqnhYLlUKQXf1j+3Y47lZVqFWyV7QrK4h+pcGDTFwOyhYq
 IsngXvPYqzOoDeGzGVXkAm6PwzZmAzG/P3DstR/WJFltWDk5j5KUUj/eq75wAW5+OIhdcgZFjDB
 PZ8LQTecwgFvJUMyuf34v2MdU3ljQ/44QVuiSBfrAiKE65XLlBIpGExXUuU+7F6a2z3R/C2yjv1
 GEfrVJ/mlIxTPM/jP8Jt3VMhOH6J4Jn0jIv92auSyfo/A0vGeECAN1WT5uTCJa7DeKeYGfc2WM=
X-Received: by 2002:a05:6402:2686:b0:5db:67a7:e741 with SMTP id
 4fb4d7f45d1cf-5db7d2f5e87mr10353590a12.8.1737393568025; 
 Mon, 20 Jan 2025 09:19:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOAn6+Lome66MHjSFxjSSUcMMYuNlbvnnU7/+lp2sFJLkjqteW8r3ik/M5Kgkjx/pP9ABotg==
X-Received: by 2002:a05:6402:2686:b0:5db:67a7:e741 with SMTP id
 4fb4d7f45d1cf-5db7d2f5e87mr10353572a12.8.1737393567599; 
 Mon, 20 Jan 2025 09:19:27 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5db736716d6sm5917528a12.31.2025.01.20.09.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2025 09:19:26 -0800 (PST)
Message-ID: <e2920049-01c8-4ea2-8f52-b99ed0a559af@redhat.com>
Date: Mon, 20 Jan 2025 18:19:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
 <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
 <CAFEAcA9SCfMcrhpd_x0LmgwtD-5XwT4TY+QXBJMOjWbdtBPCUg@mail.gmail.com>
 <CABgObfZSR2s5AYEAcJfsdF0jKQGf_AVcDafKQq47qzLmBuX0RQ@mail.gmail.com>
 <CAFEAcA_dVnpN2Vn+VAf1XZSAdj183wJhQZ3pVNtb=NHeMOF2Jg@mail.gmail.com>
 <CABgObfaAdDtrLF4tWL17Lmw9UKiLRNVvuiDZsQxc-9Wd8W61Dw@mail.gmail.com>
 <Z45/MNYY5jD5fNET@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z45/MNYY5jD5fNET@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
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

On 1/20/25 17:52, Zhao Liu wrote:
> Sorry I missed this comment before...
> 
> Now I have a MemTxAttrs like,
> 
> typedef struct MemTxAttrs {
>      unsigned int secure:1;
>      unsigned int space:2;
>      unsigned int user:1;
>      unsigned int memory:1;
>      unsigned int requester_id:16;
>      unsigned int pid:8;
>      bool unspecified;
>      uint8_t _reserved1;
>      uint16_t _reserved2;
> } MemTxAttrs;
> 
> and its binding is,
> 
> #[repr(C)]
> #[repr(align(4))]
> #[derive(Debug, Default, Copy, Clone)]
> pub struct MemTxAttrs {
>      pub _bitfield_align_1: [u16; 0],
>      pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize]>,
>      pub unspecified: bool,
>      pub _reserved1: u8,
>      pub _reserved2: u16,
> }
> 
> unfortunately, Zeroable can't be applied to __BindgenBitfieldUnit since
> event its member (`storage`) is private :-(.
> 
> But there's a solution to force (and at the same time unsafely) ZERO the
> entire structure in const:
> 
>   * const_zero macro: https://docs.rs/const-zero/latest/const_zero/
> 
> With const_zero, we can implement Zeroable for MemTxAttrs:
> 
> unsafe impl Zeroable for MemTxAttrs {
>      const ZERO: Self = unsafe {const_zero!(MemTxAttrs)};
> }

Another solution would be to implement Zeroable for 
__BindgenBitfieldUnit in bindings.rs, but this is much nicer!  It works 
even with old Rust versions and, even though it needs manual 
implementation of the trait each type, it doesn't require enumerating 
the fields one by one.  So it's better than the current version of 
Zeroable and, if you wish, you can also replace existing implementations 
of Zeroable with const_zero.

I wouldn't bother adding a subproject; just include the macro in 
zeroable.rs, with attribution and MIT license, and document that it 
might go away once we require a newer rustc.

Thanks very much!

Paolo


