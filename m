Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D40E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvO9-0000BS-RJ; Wed, 18 Dec 2024 09:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvNx-0008Ra-U2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:50:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvNv-0002dY-2M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:50:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361d5dcf5bso70898485e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734533443; x=1735138243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6AK1Nr4GAxPNWG0jPbZSxB54s81TDKSUOrtUjE2cjWc=;
 b=bt2uIVfo8kTCmPncwcnk+0KJIrTGH8Q9qDtZ0YAZWQ6UORhrGNQ3InpCkxhWKlMimN
 RWnOGpXR8k2044ZDKhPa/MNw5rdhMIFrCKTydoAXYBuml8z1kpJZTYzs5ndMl0cUBbzv
 SRqj/gSYCriftr70GpfXIxNUAYsoLbQDpzuHOEq9wsjpuAfuthWb0V1xcQM2/unAiJTR
 p2vg3qL+4pRtlykeClpQsBY8u786EBsxGydlB9Z2N3wR1h6ds65LhVbAGbRDnKDRKeHL
 6fkfGDsH77Wy75m7TWjLzFUd9EJRJxWJm0MwuXB2+enSo5YZ6lNuW+3vGoVXr/sxA4XZ
 /VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533443; x=1735138243;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6AK1Nr4GAxPNWG0jPbZSxB54s81TDKSUOrtUjE2cjWc=;
 b=OeZICbAOYZSx1huLPYnmc5y5sXeNQXMrB5bEWWYZTIexQ60XZVf4SxxP4K6FDFzoEz
 L6WAmFOSNiesJQ+cHy/+weGRbKzY5SC80Pgsacvm00PPkaKq+vFdZeJ4fqAvmOjYx5Vo
 aRBEMZgUfoth4g370oMtNG/5rGmcdvvbTNm0TATKI+S1lJQ+jWUGCnJ1mqL2x8pDTaP9
 2lYpJEOUzaQW4QRdHk6LmCl16syb3nPT2XYHUI7jSlmR+qRNzxZaNae6E6vPCApZ2QRh
 ALtDu+o6c+9RICMKQ7dOxpZdqw9UxyVtnsXmqBnlYLTU0B6FGXfgtVRAYRJT84Z40Owv
 UBPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF0Dzu0VUPZ/NR4L06TloDZpVR+9ywUY0L6klhmL1DyfPPtCNpOShqyebbKG3adLuQHfo7u/QGwxvN@nongnu.org
X-Gm-Message-State: AOJu0YyfThjEcLN2ohZnguj8jLxyrhx4T8kKVbchFetC3ZoeLg/LXu3J
 AhVj41JOYN0vit7PhU0thHhx/0Qp4oCHL4INdzfJvxBkyowZavlKDgjcHwn/MZTr8TiXi5ylekF
 r
X-Gm-Gg: ASbGncuQR9fvao33lZWQVuQRjsAEKkNGS3o+e0KflwaYd3ErbwZZSJfVfFrZ8DQYeGW
 94i2t8uLCuW/3QBHYERCfgkMK42ISFyboHr5heNuvTypxWzCjHejiqgwQSOXnlPG+XGcBBSWa4e
 nyUYOyqGOTPFC3dI52YiZR/iGM2GpG8Fw63JOkTO2Qp7XCQfG6st4PsUD8YJA6CXZREZgyGc+vS
 aZFZg00gvqm/gMFYJHE9bmbQDM93Rpf3k8743PtbjLujzWC3SuD43iJ4GLRbfm6kgl2/BUI
X-Google-Smtp-Source: AGHT+IHhj6LUxI15dXVuEDCj1YKs56HG9xZbA4YSQugFxrCQNTYjaX8SUP42Kxgvz9wJjNin83KE3w==
X-Received: by 2002:a05:6000:1f8f:b0:382:4b2a:4683 with SMTP id
 ffacd0b85a97d-388e4d2f6aamr3062189f8f.2.1734533443500; 
 Wed, 18 Dec 2024 06:50:43 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc163sm22497005e9.1.2024.12.18.06.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 06:50:43 -0800 (PST)
Message-ID: <73aace5a-ef71-47e2-9760-2cd690db1cbe@linaro.org>
Date: Wed, 18 Dec 2024 15:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] rust: pl011: fix migration stream
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-rust@nongnu.org, qemu-devel@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-7-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

LGTM, still happily deferring to Alex =)

On 12/12/24 18:22, Paolo Bonzini wrote:
> The Rust vmstate macros lack the type-safety of their C equivalents (so
> safe, much abstraction), and therefore they were predictably wrong.
> 
> The registers have already been changed to 32-bits in the previous patch,
> but read_pos/read_count/read_trigger also have to be u32 instead of usize.
> The easiest way to do so is to let the FIFO use u32 indices instead
> of usize.
> 
> My plan for making VMStateField typesafe is to have a trait to retrieve
> a basic VMStateField; for example something like vmstate_uint32 would
> become an implementation of the VMState trait on u32.  Then you'd write
> something like "vmstate_of!(Type, field).with_version_id(2)".  That is,
> vmstate_of retrieves the basic VMStateField and fills in the offset,
> and then more changes can be applied on top.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs       | 38 ++++++++++++++++++++++----
>   rust/hw/char/pl011/src/device_class.rs |  8 +++---
>   rust/qemu-api/src/vmstate.rs           | 22 ---------------
>   3 files changed, 36 insertions(+), 32 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 332e0a31a82..cfe2734703e 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -31,7 +31,7 @@
>   const FBRD_MASK: u32 = 0x3f;
>   
>   /// QEMU sourced constant.
> -pub const PL011_FIFO_DEPTH: usize = 16_usize;
> +pub const PL011_FIFO_DEPTH: u32 = 16;
>   
>   #[derive(Clone, Copy)]
>   struct DeviceId(&'static [u8; 8]);
> @@ -49,6 +49,32 @@ impl DeviceId {
>       const LUMINARY: Self = Self(&[0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1]);
>   }
>   
> +// FIFOs use 32-bit indices instead of usize, for compatibility with
> +// the migration stream produced by the C version of this device.
> +#[repr(transparent)]
> +#[derive(Debug, Default)]
> +pub struct Fifo([registers::Data; PL011_FIFO_DEPTH as usize]);
> +
> +impl Fifo {
> +    const fn len(&self) -> u32 {
> +        self.0.len() as u32
> +    }
> +}
> +
> +impl std::ops::IndexMut<u32> for Fifo {
> +    fn index_mut(&mut self, idx: u32) -> &mut Self::Output {
> +        &mut self.0[idx as usize]
> +    }
> +}
> +
> +impl std::ops::Index<u32> for Fifo {
> +    type Output = registers::Data;
> +
> +    fn index(&self, idx: u32) -> &Self::Output {
> +        &self.0[idx as usize]
> +    }
> +}
> +
>   #[repr(C)]
>   #[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]
>   /// PL011 Device Model in QEMU
> @@ -66,14 +92,14 @@ pub struct PL011State {
>       pub dmacr: u32,
>       pub int_enabled: u32,
>       pub int_level: u32,
> -    pub read_fifo: [registers::Data; PL011_FIFO_DEPTH],
> +    pub read_fifo: Fifo,
>       pub ilpr: u32,
>       pub ibrd: u32,
>       pub fbrd: u32,
>       pub ifl: u32,
> -    pub read_pos: usize,
> -    pub read_count: usize,
> -    pub read_trigger: usize,
> +    pub read_pos: u32,
> +    pub read_count: u32,
> +    pub read_trigger: u32,
>       #[doc(alias = "chr")]
>       pub char_backend: CharBackend,
>       /// QEMU interrupts
> @@ -485,7 +511,7 @@ pub fn loopback_enabled(&self) -> bool {
>       }
>   
>       #[inline]
> -    pub fn fifo_depth(&self) -> usize {
> +    pub fn fifo_depth(&self) -> u32 {
>           // Note: FIFO depth is expected to be power-of-2
>           if self.fifo_enabled() {
>               return PL011_FIFO_DEPTH;
> diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
> index 975c3d42be7..759c521a99e 100644
> --- a/rust/hw/char/pl011/src/device_class.rs
> +++ b/rust/hw/char/pl011/src/device_class.rs
> @@ -6,7 +6,7 @@
>   use std::os::raw::{c_int, c_void};
>   
>   use qemu_api::{
> -    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_int32, vmstate_subsections,
> +    bindings::*, c_str, vmstate_clock, vmstate_fields, vmstate_subsections,
>       vmstate_uint32, vmstate_uint32_array, vmstate_unused, zeroable::Zeroable,
>   };
>   
> @@ -64,9 +64,9 @@ extern "C" fn pl011_post_load(opaque: *mut c_void, version_id: c_int) -> c_int {
>           vmstate_uint32!(ibrd, PL011State),
>           vmstate_uint32!(fbrd, PL011State),
>           vmstate_uint32!(ifl, PL011State),
> -        vmstate_int32!(read_pos, PL011State),
> -        vmstate_int32!(read_count, PL011State),
> -        vmstate_int32!(read_trigger, PL011State),
> +        vmstate_uint32!(read_pos, PL011State),
> +        vmstate_uint32!(read_count, PL011State),
> +        vmstate_uint32!(read_trigger, PL011State),
>       },
>       subsections: vmstate_subsections! {
>           VMSTATE_PL011_CLOCK
> diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
> index 25c68b703ea..63c897abcdf 100644
> --- a/rust/qemu-api/src/vmstate.rs
> +++ b/rust/qemu-api/src/vmstate.rs
> @@ -106,28 +106,6 @@ macro_rules! vmstate_uint32 {
>       }};
>   }
>   
> -#[doc(alias = "VMSTATE_INT32_V")]
> -#[macro_export]
> -macro_rules! vmstate_int32_v {
> -    ($field_name:ident, $struct_name:ty, $version_id:expr) => {{
> -        $crate::vmstate_single!(
> -            $field_name,
> -            $struct_name,
> -            $version_id,
> -            ::core::ptr::addr_of!($crate::bindings::vmstate_info_int32),
> -            ::core::mem::size_of::<i32>()
> -        )
> -    }};
> -}
> -
> -#[doc(alias = "VMSTATE_INT32")]
> -#[macro_export]
> -macro_rules! vmstate_int32 {
> -    ($field_name:ident, $struct_name:ty) => {{
> -        $crate::vmstate_int32_v!($field_name, $struct_name, 0)
> -    }};
> -}
> -
>   #[doc(alias = "VMSTATE_ARRAY")]
>   #[macro_export]
>   macro_rules! vmstate_array {


