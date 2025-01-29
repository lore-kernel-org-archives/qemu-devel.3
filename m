Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1EFC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:58:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5lA-0001oe-4T; Wed, 29 Jan 2025 05:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5l8-0001oQ-R4
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:57:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5l7-0001L9-DZ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738148243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FJIAHeFPrSS3he2lHjKhC1c74Vu4MGHhJ5b3IFo6Efo=;
 b=VAV9OHUtN1rifQ/Ql35fVXNfeF4M2+AUC6TnO28JPJ3iU9Z7/tuaKjff3qlvbuvwb2euCw
 8Mfa8cfJEECGBf4aqp0+tFFdlx2mA9Uqqpij93IlSOYZZbDPFTxK9tQPFCtRM2i4j8a4cp
 qVcApMYEb7gjv3wY79oR0z0Vgs41Cps=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-gKmPENxbPFaoAiSMcOD75w-1; Wed, 29 Jan 2025 05:57:22 -0500
X-MC-Unique: gKmPENxbPFaoAiSMcOD75w-1
X-Mimecast-MFC-AGG-ID: gKmPENxbPFaoAiSMcOD75w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e1fd40acso3719581f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:57:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738148241; x=1738753041;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FJIAHeFPrSS3he2lHjKhC1c74Vu4MGHhJ5b3IFo6Efo=;
 b=pw2TRi9sDDOpq4tJeYWwpYFxKpnrTKdYnzeThQGeu1fQGNsRh9WA7LysMOdt1Kw/d8
 XR9zlYlWTbITls732/ROcM6FyqYF+ferG3rwG+XSQXTrmFYdnF7L6KESiYZJZ1rAV3jv
 qiczWRiGSMuYt0RgX8sddvdNZ6rSKWCE9fDJ2Q/kvGaUfvR41eVv/S+ddkQTiH1gfBpK
 h/6U/QN2Pd5TJBrh4vSPZjvzon4ttjKaDpZiwKOccU4l4/aA0y1gRHfbkLuWAKfO3MxM
 lM61WiLz7I/hDy7LkcHymtXD51joTOHl5TOJV+xVAaB84b/DNu3ZMKiCSiNsi/dY8vOB
 dMCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdIxJyi0pcc/7R0BoGJgG/DrEY6hbGU0dFyhcvCSX3Grj14KmRfzWv2wcogqQHaG5B+Xoj58KFeYgO@nongnu.org
X-Gm-Message-State: AOJu0YzUdlGmxSxkuZDEK+AKKFVC4d1ycu7h2fVslJOYRpAs5buD7Dsj
 Yw/uJNLp8vLBRHMDCI/QIAKq9y4RNwghUlABLbEB7fIDH4F5ox9NjCy4l7s4U2ejlpQ/JUuf8bm
 72yrHwKuHSMJj4fQp+T81sw4FTtbNqmYaHTZgy3L8lXxp1+wqMDp9H8zUezNHCHw=
X-Gm-Gg: ASbGncvuoSBp+8yXTqMpR1s8s3VCiTXDVW4KKdYAgTabVTvTrzEMXldQkf0k5sKWUqa
 ClIboeQEfW6h/d3YiWLGhfpchP29cZ6XI+E2EcasW4mgX8A/486Uqtc1YVlo2sQCqUYNM5bg8h4
 PMUIn6OsAkYN+LG1KE5de+m1VN/0IXHpAhBEEENXaNMPwanXAHSMNpPZTUpaW6BmfPPCT1r+eNf
 /gx8XFWKbmfe8+447dXWBlll6PZDWK/CocUy4GWfCVjjPJ6DOLuWbO2GpRFpWwSQWX8A2rFMg3w
 UeIvyw==
X-Received: by 2002:a5d:5f8f:0:b0:386:399a:7f17 with SMTP id
 ffacd0b85a97d-38c51b5eaebmr2353510f8f.24.1738148240721; 
 Wed, 29 Jan 2025 02:57:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEp5FiiZ8a+dHKTM3BQ4/p/zOJtTgDCUzpwch3ki2O7uTjkTtV3tufblElO+p2YpbriQ4v3cg==
X-Received: by 2002:a5d:5f8f:0:b0:386:399a:7f17 with SMTP id
 ffacd0b85a97d-38c51b5eaebmr2353486f8f.24.1738148240397; 
 Wed, 29 Jan 2025 02:57:20 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bbc8dsm16819300f8f.72.2025.01.29.02.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:57:19 -0800 (PST)
Message-ID: <b9ce64fa-b2b8-4f61-8380-9ec582936b26@redhat.com>
Date: Wed, 29 Jan 2025 11:57:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/10] rust/timer/hpet: add basic HPET timer and HPETState
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-9-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250125125137.1223277-9-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> +// Register space for each timer block. (HPET_BASE isn't defined here.)
> +const HPET_REG_SPACE_LEN: u64 = 0x400; // 1024 bytes

Use doc comments "///"...

> +// Timer N FSB Interrupt Route Register (masked by 0x18)
> +const HPET_TN_FSB_ROUTE_REG: u64 = 0x010;

... all the way to here.

> +/// HPET Timer Abstraction
> +#[repr(C)]
> +#[derive(Debug, Default, qemu_api_macros::offsets)]
> +pub struct HPETTimer {
> +    /// timer N index within the timer block (HPETState)
> +    #[doc(alias = "tn")]
> +    index: usize,
> +    qemu_timer: Option<Box<QEMUTimer>>,
> +    /// timer block abstraction containing this timer
> +    state: Option<NonNull<HPETState>>,
> +
> +    /// Memory-mapped, software visible timer registers

These "headings" cannot be doc comments, because they would be attached
to the field after.  Same below:

-    /// Hidden register state
+    // Hidden register state

-    /// HPET block Registers: Memory-mapped, software visible registers
+    // HPET block Registers: Memory-mapped, software visible registers

-    /// Internal state
+    // Internal state

> +    fn get_state(&self) -> &HPETState {
> +        // SAFETY:
> +        // the pointer is convertible to a reference
> +        unsafe { self.state.unwrap().as_ref() }
> +    }

Note for the future: I looked briefly into why a NonNull<> is needed
and the reasons are two.  First, the offset_of! replacement does not
support lifetime parameters.  Second, it's messy to pass a &HPETState
to the &HPETTimer, because the HPETTimer still has to be written into
the HPETState.  This may be worth revisiting when QEMU starts using
pinned-init is added, but for now is self-contained.

> +        if let Some(timer) = self.qemu_timer.as_mut() {
> +            timer.timer_mod(self.last);
> +        }

I think this can be just "timer.unwrap().timer_mod(self.last)" (not
sure if it needs an as_ref() too).

Paolo


