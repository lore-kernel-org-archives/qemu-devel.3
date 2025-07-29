Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33874C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 14:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uglBL-00044L-D3; Tue, 29 Jul 2025 10:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uglBF-00042P-5i
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 10:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uglBA-0002tF-Kl
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 10:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753798781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=f0M5pMeShAvl7P14FsQvrzgLM6UN5hkzxIUt6Am8+ck=;
 b=NIKzHqab+Asl/WK0Re3v0Rq9Tzew0XCjrUJuUso86yfS3ls7u5vtwOU+4JfUUmz5q5YygB
 N2EaBxcIPXY8dY9mmBg/Mf7sM6FTgGByICWD9m4afK6lmu5C/TRGgFJAjgwkt+skoLOnVi
 lCzn7iLFustMa6Wq8OD+gshWR5Baeag=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-EE7y9njgMMSN_-3jG8iUug-1; Tue, 29 Jul 2025 10:19:38 -0400
X-MC-Unique: EE7y9njgMMSN_-3jG8iUug-1
X-Mimecast-MFC-AGG-ID: EE7y9njgMMSN_-3jG8iUug_1753798777
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso2005206f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 07:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753798777; x=1754403577;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0M5pMeShAvl7P14FsQvrzgLM6UN5hkzxIUt6Am8+ck=;
 b=pciaHVP/bkfv5sO0B2KpSlvBRhNmRCovQeqzAk455iJQEBSC+vJgmQHx+rXhFRpHI3
 kp3QUwu+d2KUSPJFow5LTa7LYGfL4Btk0+lHPAfPwghNZcYm7z7+y/UT0X412HJFBeVO
 IRGDBeQW8Sgk+VoAuRTZNCY0aSFe/3a00FpJFGkxwuiqT4K9eghhlP6KrHattISPU4JJ
 1Si9uHe4HNII40HMJf9THUR1jBnBuNNBoSAeV2NPqqVjma9pJWH8zS2rVzahN9+/ktnU
 9iNAVMVtSmHJ3xO5fIDgTTaduY81ku9k8RxmG1sleeyFj97RuRmJN4kRiBoNOTM7biPn
 h9sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD/Xoq04S7pq1VZ8bDbuAuDcAng78fLoz79yvC2EqACnQCXqtA12af5NH3+nPA+iVfAcCGmNLmgReu@nongnu.org
X-Gm-Message-State: AOJu0YwatIh+haN7pXKmdbVubcVJHnVt3i3FcEKCYtpfXikVsSFjfPP4
 CaDY6CrHtp7hydz0ScvUppk8vdAnyUSyviQW/TL7qsQbK3GrAEwLHJ0vg3GNzardm2ajeIUNDgn
 5ne/qhsxI2liE5wT35z+pnLOTHJmK54XttvWL2mjWgygGc0fdadlNlqLG
X-Gm-Gg: ASbGncvm/TTQp7Ds2eFMD8PGRqh5XymjqhxcsmtEQkuuOGnJKOsRJs4Wk/QkVbpvuJX
 WnxK4w/v6K8koV/SqquUXffnn+9HNJQGNziz6c1TpsS4EtbLToKfZ7NEPVaZz5V52vAyPVp1lZf
 klrRY545xsePjkZj9To4eQH6xIaFtstpn+jPSCl9nA4w7sJSAXMX5RfvLl4dxz4TptDkYPu0l+A
 szxghs69vn4MmomKQ71WFszcafJnGELsxDah/YmuHyPpd8579kU/b1umW6MwQXiTQ/nsZswKOo4
 sYwtyAq1+SNmIdDm2SWT3saSqIfAjCvNTkorj4llba8C
X-Received: by 2002:a05:6000:25c8:b0:3b7:75d9:5ee5 with SMTP id
 ffacd0b85a97d-3b776645f69mr10213757f8f.29.1753798776861; 
 Tue, 29 Jul 2025 07:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB9kWsV5hSeg8ZHoKaItiO91vXjFS1ORpLj2JA0USYGK45MG6Q6sSS6ymJxDQoOgOgtL+Dkg==
X-Received: by 2002:a05:6000:25c8:b0:3b7:75d9:5ee5 with SMTP id
 ffacd0b85a97d-3b776645f69mr10213735f8f.29.1753798776265; 
 Tue, 29 Jul 2025 07:19:36 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.154.122])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b793519f3asm1495981f8f.36.2025.07.29.07.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 07:19:35 -0700 (PDT)
Message-ID: <2fbf7b01-981a-4c12-a972-3c008056a3ad@redhat.com>
Date: Tue, 29 Jul 2025 16:19:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: declare self as qemu_api for proc-macros
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250728-self-as-qemu_api-v1-1-001c339cccc8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/28/25 13:48, Manos Pitsidianakis wrote:
> Fix an outstanding TODO.
> 
> Declaring `extern crate self as qemu_api` allows use of `qemu_api`
> within the qemu_api crate; this allows the Wrapper derive macro and
> future proc macros to be used interchangeably in the qemu_api crate and
> other crates. This is not required currently and is only for
> future-proofing.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

I had no idea 'extern crate self' existed!  Nice, I queued it because 
it's useful for the purpose of splitting the qemu_api crate.

Paolo

> ---
>   rust/qemu-api-macros/src/lib.rs | 14 ++++++--------
>   rust/qemu-api/src/lib.rs        |  3 +++
>   2 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
> index b525d89c09e496a1f7f5582dc6d994e318f62bca..e01ac26cf3dd5a1b06ce095ef32b27a67e0def19 100644
> --- a/rust/qemu-api-macros/src/lib.rs
> +++ b/rust/qemu-api-macros/src/lib.rs
> @@ -115,23 +115,21 @@ fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
>       let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
>       let typ = &field.ty;
>   
> -    // TODO: how to add "::qemu_api"?  For now, this is only used in the
> -    // qemu_api crate so it's not a problem.
>       Ok(quote! {
> -        unsafe impl crate::cell::Wrapper for #name {
> -            type Wrapped = <#typ as crate::cell::Wrapper>::Wrapped;
> +        unsafe impl ::qemu_api::cell::Wrapper for #name {
> +            type Wrapped = <#typ as ::qemu_api::cell::Wrapper>::Wrapped;
>           }
>           impl #name {
> -            pub unsafe fn from_raw<'a>(ptr: *mut <Self as crate::cell::Wrapper>::Wrapped) -> &'a Self {
> +            pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped) -> &'a Self {
>                   let ptr = ::std::ptr::NonNull::new(ptr).unwrap().cast::<Self>();
>                   unsafe { ptr.as_ref() }
>               }
>   
> -            pub const fn as_mut_ptr(&self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
> +            pub const fn as_mut_ptr(&self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
>                   self.0.as_mut_ptr()
>               }
>   
> -            pub const fn as_ptr(&self) -> *const <Self as crate::cell::Wrapper>::Wrapped {
> +            pub const fn as_ptr(&self) -> *const <Self as ::qemu_api::cell::Wrapper>::Wrapped {
>                   self.0.as_ptr()
>               }
>   
> @@ -139,7 +137,7 @@ pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
>                   self.0.as_void_ptr()
>               }
>   
> -            pub const fn raw_get(slot: *mut Self) -> *mut <Self as crate::cell::Wrapper>::Wrapped {
> +            pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::qemu_api::cell::Wrapper>::Wrapped {
>                   slot.cast()
>               }
>           }
> diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
> index 86dcd8ef17a9ecd040742a99e4b0421e19ec88f6..44d995cfdb990e0d17e7216cf4d1f04a5a980a1f 100644
> --- a/rust/qemu-api/src/lib.rs
> +++ b/rust/qemu-api/src/lib.rs
> @@ -32,6 +32,9 @@
>   pub mod vmstate;
>   pub mod zeroable;
>   
> +// Allow proc-macros to refer to `::qemu_api` inside the `qemu_api` crate (this crate).
> +extern crate self as qemu_api;
> +
>   use std::{
>       alloc::{GlobalAlloc, Layout},
>       ffi::c_void,
> 
> ---
> base-commit: c017386f28c03a03b8f14444f8671d3d8f7180fe
> change-id: 20250728-self-as-qemu_api-de5ad829a034
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 
> 


