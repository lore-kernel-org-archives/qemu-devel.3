Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2880CCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzm1-0007s2-Ov; Wed, 29 Oct 2025 02:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDzm0-0007rO-KV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:35:08 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDzln-0000ql-IK
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:35:08 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63d6ee383bdso14670203a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 23:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761719690; x=1762324490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ry0M+9kopk7MNnN3poBXxumoJIxvGoLsSMglqpbFUSM=;
 b=r1lWN96qbPk3q8kgpVQJNdap6giV2zTHxqjiWbN2UT3G/02aGMumqpjsbwzU62IkVB
 D2BszXyRISU3cxwb0BctoDKW+SAYe4Whh8Rs2UtGg0uRyLWZTGcC7o/SIN27kjav60u1
 uWJKpkD4J26MjZUDE8h7CaZUDO4NFOj8VG6lhAOSZNU1ZqOxK2ygyNzn9vmww9YL9nNy
 C2VIUD8aVstV4Uc/lysXp1E8JDd4kRlAP1UQhM7MSCKIugbTEzpvb79QnEZQu6Oros1V
 gnVV6cp8iQ/kjb9hLMZ7KyIf3uMn5A7GvcU6BEmDIrsjbHDvuM1Ct6AYD1jNGTkoBcaG
 nPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761719690; x=1762324490;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ry0M+9kopk7MNnN3poBXxumoJIxvGoLsSMglqpbFUSM=;
 b=lNriwse0po5Xl9JzLWg1eliKKOKN1GNDGw4ZucFGYBtuhYb9reBnPos/BE+fOMZh29
 Ylj9h7xsVIKofoo/En87XLC6y6+FeSqK7DVO7OXOD3JDrPLXeL/S4gVjxBg/ptac9uN8
 2RC2Gg4c70FcYi9p1TCATjplBG/5rbKi1wWV2sNiRj24uPGil0XBfoiPhi+tR/u86fRT
 VG9A0oKmiUKoigRRrNwQCX7Qyv1lgxzuBU1r66+rh1g4c0XsYVIaol6+kUoU3V6wkPUJ
 hNouzeJYRtFIT5RqAm5dvu2UZMaWXIY9jFckaIiGTXOtpLLzqx04D9DnyJY3jhjUcE9s
 eiWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSlxKwc+jlYQMbKDT2YRxeMbZx5Vg+CD2a3GufWPoYKaEYoS7v5wGi7ifAU4R0ySrt8b7iXrPZa2+D@nongnu.org
X-Gm-Message-State: AOJu0Yw92ZmGNU3koWbNNUW98/LH+lqNC8v3wwl0Wz5LLgF02sJElFUB
 kQfDkOlkNy14p09xy+XKNr0FpmLbewqmgRVVhsBY2GhkvMB4v9w4OAT5Zu9ZWvlXMQY=
X-Gm-Gg: ASbGnculermlPWSqrZTuH5/f2O2rBAoNs/KS7pcf3jzr+APzcbLVevPpnXk1f3l7TEm
 sMoBucKTmmwFPjD/HVfqGM+KtK2vw4FBvMriQ6kqkRv9Y9BtlwEtTMEttDT+zrzEjBlNLfV/ZRD
 oYOnN2xpjCj5M55qpW8d9DIkozsiHrT+Dd6l0Hx4uEBlPpKGdZEbSJZFIF0oFv15tc7t/vg/BkR
 1jRRy6YHof8WuynimuZuq6vFugE1ZdaTL722RMS4qjEEcMplT28kUOUFNOGX+PQXySlgro878Xx
 7z72e29sr/Y7lgBsol/sk4+JHR621dmp/NmUlMS4OXpNW3WCNuvu/j/zUHjLfcFoSRgC7b875x+
 8d4pzUNcWGguKQXSFjRHYdSKQAYSK2bwJxXDYGM5eDI4UfVQyiIAine1j8ghrJyXTeTtdxnUH4C
 v2aKqfcjXRcV/F42Na
X-Google-Smtp-Source: AGHT+IHMTas65ns31ln779kL9I3LLiFDDwTTOM76b5e2WynOHBnGiMk8/dup1SKnnax8AeJrLyEyQQ==
X-Received: by 2002:a05:6402:518c:b0:63e:1643:de4c with SMTP id
 4fb4d7f45d1cf-640441a8165mr1192626a12.7.1761719690091; 
 Tue, 28 Oct 2025 23:34:50 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64043e05a5esm1286303a12.4.2025.10.28.23.34.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 23:34:49 -0700 (PDT)
Message-ID: <05b5eff7-ad25-428e-8468-8b71878aad2c@linaro.org>
Date: Wed, 29 Oct 2025 07:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 18/18] rust: migration: allow passing ParentField<> to
 vmstate_of!
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Chen Miao <chenmiao@openatom.club>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-19-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028173430.2180057-19-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/25 18:34, Paolo Bonzini wrote:
> The common superclass for devices could have its own migration state;
> for it to be included in the subclass's VMState, ParentField<> must
> implement the VMState trait.
> 
> Reported-by: Chen Miao <chenmiao@openatom.club>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   roms/opensbi                  | 2 +-
>   rust/migration/src/vmstate.rs | 3 ++-
>   rust/qom/src/qom.rs           | 3 ++-
>   3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/roms/opensbi b/roms/opensbi
> index a32a9106911..43cace6c367 160000
> --- a/roms/opensbi
> +++ b/roms/opensbi
> @@ -1 +1 @@
> -Subproject commit a32a91069119e7a5aa31e6bc51d5e00860be3d80
> +Subproject commit 43cace6c3671e5172d0df0a8963e552bb04b7b20

Spurious subproject change.


r~

> diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
> index 42e5df8d818..5a237c409ac 100644
> --- a/rust/migration/src/vmstate.rs
> +++ b/rust/migration/src/vmstate.rs
> @@ -268,7 +268,7 @@ macro_rules! impl_vmstate_transparent {
>       ($type:ty where $base:tt: VMState $($where:tt)*) => {
>           unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmstate::VMState $($where)* {
>               const BASE: $crate::vmstate::VMStateField = $crate::vmstate::VMStateField {
> -                size: mem::size_of::<$type>(),
> +                size: ::core::mem::size_of::<$type>(),
>                   ..<$base as $crate::vmstate::VMState>::BASE
>               };
>               const VARRAY_FLAG: $crate::bindings::VMStateFlags = <$base as $crate::vmstate::VMState>::VARRAY_FLAG;
> @@ -282,6 +282,7 @@ unsafe impl<$base> $crate::vmstate::VMState for $type where $base: $crate::vmsta
>   impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
>   impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
>   impl_vmstate_transparent!(common::Opaque<T> where T: VMState);
> +impl_vmstate_transparent!(std::mem::ManuallyDrop<T> where T: VMState);
>   
>   #[macro_export]
>   macro_rules! impl_vmstate_bitsized {
> diff --git a/rust/qom/src/qom.rs b/rust/qom/src/qom.rs
> index 5808051cd77..84455cea79b 100644
> --- a/rust/qom/src/qom.rs
> +++ b/rust/qom/src/qom.rs
> @@ -102,7 +102,7 @@
>   };
>   
>   use common::Opaque;
> -use migration::impl_vmstate_pointer;
> +use migration::{impl_vmstate_pointer, impl_vmstate_transparent};
>   
>   use crate::bindings::{
>       self, object_class_dynamic_cast, object_dynamic_cast, object_get_class, object_get_typename,
> @@ -182,6 +182,7 @@ fn as_ref(&self) -> &$parent {
>   #[derive(Debug)]
>   #[repr(transparent)]
>   pub struct ParentField<T: ObjectType>(std::mem::ManuallyDrop<T>);
> +impl_vmstate_transparent!(ParentField<T> where T: VMState + ObjectType);
>   
>   impl<T: ObjectType> Deref for ParentField<T> {
>       type Target = T;


