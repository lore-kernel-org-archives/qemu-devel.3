Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9F5CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Drn-0006lk-Jt; Fri, 10 Oct 2025 10:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Drm-0006lX-9F
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7DrY-0001wp-CB
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760105566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jmobBCoe5DPv0d1P0VrA8G7aTAUv3t7ChEuVERh6C/M=;
 b=GZsJouNO+7UFW/u/yrmoeLRcq8Kt9aJHrLjfbQOXqNYWIRTJLmDo7VL8U0igmRpfVVsEqD
 v8XYieIikzAYVMqixuBX3mv0nYZZVGF+IDQdybSE6dxxdrY5w1D2s6IVAiH0ABs0OP5qeU
 f34ECsQrdqoeqa+6D2gTj+tEKij9y5g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-sJcMaGx8NwGeMfkFuTo83g-1; Fri, 10 Oct 2025 10:12:45 -0400
X-MC-Unique: sJcMaGx8NwGeMfkFuTo83g-1
X-Mimecast-MFC-AGG-ID: sJcMaGx8NwGeMfkFuTo83g_1760105564
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-62fcb646334so3700681a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760105564; x=1760710364;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jmobBCoe5DPv0d1P0VrA8G7aTAUv3t7ChEuVERh6C/M=;
 b=bDbZdp+bgRD/267/jsk5F4psnYAAAYNnns5q2jt9r2/t11p0ZWq9TxKiTissRnpzba
 DZChJ17jMqfo1XYau1SBDLkCr7RWpv0Thb7lwTXfyIUTxFksC1XkDO1gmKf1KHPSHlnw
 Fv1UTLQDxnOcBax8aCgUrBFsokLAoabQcFUxjHCHr1fatTubXhBHKxtwa1WqR/ljdVJG
 5CM3lMPic1xNMBwhoVMhdnMTStbmwv+kaJyBCR5W2HgfoxqCKYJ2BBVW3k9duyzTo0zy
 DEi1YDdZPU5pcrJVmHBvC8Umo41SJZbR2ZXSxBXzayZRb4loPzO5Hbu7OS6UiijrCQ1S
 ldVQ==
X-Gm-Message-State: AOJu0Yx1UDka127ZmnH1wi60jMGrTYDLqlU/hyrM6zoKypkqKrHpZdsS
 eAGyvq96v8z7bOJSe4w/37O4VNtRFo1YkABng0YGq0fQv6uGPToQSQb0TJEvHoWaiVf5vQhP8ha
 kvYGNq0fIdQxzNVPEn+KOcmZ11HB3Z5GdXhT/PDCwdDiS/FM5pipIl420
X-Gm-Gg: ASbGnctzUp/ynCDzW/uK7Gl8vZKqEx+2Gc/oocWcycdpnUcB3lqhB1cBw+io7I8UMr4
 QXhRIrzmfHWP/ts0y3OMohRHK8/tZR4DX4Erq27T13ewVGAvq73aGBaTRl3DMGNSQStIexmtyq2
 eJkrCpLPLoS5K8ufbrayL3Wd9VyaOalEX2shj7YR6irC3LU96N5w6HEVEx0h7i/O/MRUsGwN/7N
 oO8fMsd1FhQTzA/9ErzsfSgbUDrgBlUyAleHUIzBdscxFoWNbmk2dN7WN0oPzTj05yEhTHVEUyh
 +lfiIehBiDWt6yrcYtl7BNXdI6wmzVGjov4hjdlvM8DNR18z38+z6TiOTn3aOgNuLA/MFyrCDST
 4pH7B3Y4ZR2ByDuSDj5uj4iu97UKJdG8IUL1CJEYCAx3o
X-Received: by 2002:a05:6402:1444:b0:63a:35c:6ebc with SMTP id
 4fb4d7f45d1cf-63a035c72c9mr5132037a12.23.1760105564148; 
 Fri, 10 Oct 2025 07:12:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjZmfNg5zqeX1Jsk5m2nObI4blvkeLDQ741khgs10wjUtM5J8kO+MSj6SZzFFHwyHJFxz0TQ==
X-Received: by 2002:a05:6402:1444:b0:63a:35c:6ebc with SMTP id
 4fb4d7f45d1cf-63a035c72c9mr5132006a12.23.1760105563661; 
 Fri, 10 Oct 2025 07:12:43 -0700 (PDT)
Received: from [192.168.10.81] ([151.49.231.162])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b1e89csm2437553a12.19.2025.10.10.07.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 07:12:43 -0700 (PDT)
Message-ID: <0766dc6c-6cab-4f56-a8ab-c573aff15421@redhat.com>
Date: Fri, 10 Oct 2025 16:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: temporarily disable double_parens check
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251009211208.643222-1-pbonzini@redhat.com>
 <CAAjaMXaPv+hENfLuZUeLEOjakuw7dOTLQCeaUbuveZW4Y_2PBQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXaPv+hENfLuZUeLEOjakuw7dOTLQCeaUbuveZW4Y_2PBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/25 14:23, Manos Pitsidianakis wrote:
> On Fri, Oct 10, 2025 at 12:12 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> It is showing in the output of the bits! macro and not easy to fix there
>> (at least not without making the macro more complex).  Disable it for
>> now.
>>
>> Link: https://github.com/rust-lang/rust-clippy/issues/15852
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
> 
> How about putting it in the macro expansion instead of globally allowing it?
> 
> macro_rules! foo {
>      ($a:expr, $b:expr, $c:expr, $d:expr) => {
>          #[allow(clippy::double_parens)]
>          InterruptMask(((($a.union($b).union($c).union($d))).into_bits()) as u32)
>      }
> }

Can you do it for procedural macros as well?

> Why is the double parenthesis needed here by the way? It's a method chain
It's just how the macro works, occasionally generating double 
parentheses keeps the parser simple.

Paolo


