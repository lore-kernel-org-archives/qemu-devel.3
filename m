Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AB4C021A1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 13:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thTqk-0005vc-8N; Mon, 10 Feb 2025 08:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTqd-0005ml-OB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:29:16 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thTqZ-0005O2-2F
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 08:29:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43944181e68so9892285e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 05:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739194149; x=1739798949; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pnKit6bvlceVtaPue+HnO2chHJDyacT6hBPxAwvfjDo=;
 b=QX6DPYFprh40u3VC23+9Ec0FfxRor3BOsn8uJTMUMNs4Uhn86681Qku3KoR2mo6erO
 dniIBBKPuoz0czbOW/Rs60xeNwp9jGeGURA8iq209QqerJ8HJZeh2UmA2YvXl3CWPLWH
 Oq0jCGc4NwSev3KiQ3OO2yN1ZZY9c8YIfT2Uy7PPpSytNuBo3zHlD2XzU7+Jn4+4XpBf
 quc5X4t8kUVu7IhhCPisbHJoqMZ1quzT3ldHPwT6hJJJHvMXC6Trnw79wJAbvEWD/B//
 hLuYNXCaBL8YmCI2MCV8lSQ6RQrTFlJHV7SnyPMX+l7yun/5Xp+xV489PH/niNxrTJ7X
 LynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739194149; x=1739798949;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pnKit6bvlceVtaPue+HnO2chHJDyacT6hBPxAwvfjDo=;
 b=uxbv1YZ0rec6xMyq2Bt/c+0DT5umveopOcIu1ESHGZNI7v2RsEdkuv9u74mDCYwmUO
 ZSNSPC/ToISsn8D9LrY2p3wTP19p4Vj0pwNP2vlZW8uDbHKk91vcaqzF1GtHqnhO8GCc
 88hurnHVr6Efs98G9NJRsC5Lz1Eo72b5BOjDHK9bqJJpzjlPQI/GA3aNjm/gsvdvWFV7
 WI8B9bXWMLciW98qalAEke8SfYu1RW5nOLVNSySCMi3ceZ1mmgaeYZx9wOKr7XbWzQKD
 Hnili+BTMft8mvxLKPk/yo/Wbb/bxu0tO0kP5M5bPzKSRdx3G4F3nYPBKVNEPx1mipIV
 +W0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4QI5zwlPFqw6WlICMC4RGRiGNBtklb8wgAv32mESmNePP8/i433rvVR47cs0cxiU1cBzhQhuBlPBk@nongnu.org
X-Gm-Message-State: AOJu0Yyxgt28Q6hvUvWPcf8IZH18S2/34anQr0F5FmmxjgkQtddXjyVX
 Ou5vsRmAGaaMhAFSmOlas+vD6IKPzKq4GclDtF1SSILdnxfXiEqxXVYd/tv+qTM=
X-Gm-Gg: ASbGnctjdeNSteTfYnD5N107J9ln+BzMczRdB0OF80P7oIw92L79tRG7vgHJiJIUTwi
 NlHO4kWFlgFo3+3XxrRa3i4Pip5Ox2z1CsySOpEsgSHCMejOcUaIiTLephH7vs65GlpSbXXLe1M
 j603DFu6DWL7B3IDWH/sRCipG9QeDCyJAMZ8fD7MzUZcEhz/r3xB2gom+ppijsIhDgHYF9Wo7/R
 2CNIOsEnCc8ogsIPkk1BXtm0sVS2+mSQuWbfW3Yz8Mflu5n/vuq51BpbHVtytn3+OoR1X0ITn8i
 14iNJsX8ktfPZp/aeAi22PHvigYuN6Zxv6U0tBhOyKUkWM0Ciz13tBvhNvfjOzSF
X-Google-Smtp-Source: AGHT+IHpoqhPyUk+chR3FjAOEvIAfgqKQU+q3d3eoYGuwQjLU6SSfXl35gbgql2gPBnsu5nTq53MuQ==
X-Received: by 2002:a05:600c:3ac7:b0:439:40c1:1343 with SMTP id
 5b1f17b1804b1-43940c1141bmr46344715e9.15.1739194149008; 
 Mon, 10 Feb 2025 05:29:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm151451435e9.0.2025.02.10.05.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 05:29:08 -0800 (PST)
Message-ID: <f82d5a10-6cf3-4d46-8699-e3bb8f552e6e@linaro.org>
Date: Mon, 10 Feb 2025 14:29:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] qom: Constify class_data
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
 <ef7d98d4-c0e7-4bb3-bf8c-e36c5cfe2e05@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ef7d98d4-c0e7-4bb3-bf8c-e36c5cfe2e05@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 10/2/25 13:30, Paolo Bonzini wrote:
> On 2/10/25 11:25, Philippe Mathieu-Daudé wrote:
>> Following Richard's suggestion [*], make QOM class data *const*.
>>
>> Note, rust code not modified...
> 
> Untested but it should be something like
> 
> diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
> index f36be2831eb..8603f7cc657 100644
> --- a/rust/qemu-api/src/qom.rs
> +++ b/rust/qemu-api/src/qom.rs
> @@ -180,7 +180,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> 
> Result<(), fmt::Error> {
> 
>   unsafe extern "C" fn rust_class_init<T: ObjectType + 
> ClassInitImpl<T::Class>>(
>       klass: *mut ObjectClass,
> -    _data: *mut c_void,
> +    _data: *const c_void,
>   ) {
>       let mut klass = NonNull::new(klass)
>           .unwrap()
> @@ -523,7 +523,7 @@ pub trait ObjectImpl: ObjectType + 
> ClassInitImpl<Self::Class> {
>       /// the effects of copying the contents of the parent's class struct
>       /// to the descendants.
>       const CLASS_BASE_INIT: Option<
> -        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
> +        unsafe extern "C" fn(klass: *mut ObjectClass, data: *const 
> c_void),
>       > = None;
> 
>       const TYPE_INFO: TypeInfo = TypeInfo {
> @@ -544,7 +544,7 @@ pub trait ObjectImpl: ObjectType + 
> ClassInitImpl<Self::Class> {
>           class_size: core::mem::size_of::<Self::Class>(),
>           class_init: Some(rust_class_init::<Self>),
>           class_base_init: Self::CLASS_BASE_INIT,
> -        class_data: core::ptr::null_mut(),
> +        class_data: core::ptr::null(),
>           interfaces: core::ptr::null_mut(),
>       };
> 
> 
> to be split across patches 8-10.

Thanks!


