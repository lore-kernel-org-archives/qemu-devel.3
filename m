Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3235BD11707
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2024 13:16:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t537o-0005gB-9q; Sun, 27 Oct 2024 09:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t537Q-0005f5-7d
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t537N-0006Md-Hw
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 09:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730034940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4/4ftOcprPqEHBiSAwm4ukwk3Q5RFUYPRTPJrPQRTDc=;
 b=bdpGywLji1e1haHY+sbLDd25c3h+apJZBX+arifcVV/B6a068lxIHMXz9S407iNtSWJJ9V
 KNQ0pyszbY2YFTLxQ3WnMIaRLNZ7GzeWX50/FGrqk8TioVYipnICHK2jlz7z7XCPBsrIGX
 yyCMgdWVO9LOo9LPbkVaKEJXoQ70cXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-4rXhYA_vPpqzx83GGRv-yQ-1; Sun, 27 Oct 2024 09:15:38 -0400
X-MC-Unique: 4rXhYA_vPpqzx83GGRv-yQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43159603c92so23584955e9.2
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 06:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730034937; x=1730639737;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4/4ftOcprPqEHBiSAwm4ukwk3Q5RFUYPRTPJrPQRTDc=;
 b=rVh6O2/qrC66dRcbsde7dE0l4mimYFcnz5P5dkgJ9JGjB4uQdIPnAZqq+WygY/u2GE
 4VJdPQPJwmgkROsUN9kzHSTgA4HixC81necvDvyi0rqaiRhVO2jbbLj7LN1Dy400OVaH
 Wt/RBURbVAZ+ej9h43UOaBJrT4/3jBSexoN2hHEfwmqXPzUJoqDNvA14aZQKOgdvj8Bi
 TSlJGZkUWZ6EFZS5UaYBum5OSkJEjqVfPPrZrIafmwretd6rTZw0b5VsfF+lSBMFAzVc
 6OMTYJoPyGm/2WpAfU9gJ8unYfPaQX7ZEjKNiqXzUZmTVqrSg81O5bFbvAT6wpLAilXo
 cdrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF03D0MNGVMcQ+PGr8DSQpvpxVJHS06c7dJ6DJ/yeidihKwGl5HO2iQfE00D6f3O4GUOdVsmabuqiA@nongnu.org
X-Gm-Message-State: AOJu0YyvOwVCEN15qp4yHlxjINoo6Xwsnp1tc5bAN6ZtkEKtP5E6CiNt
 Rv2nC4bpNlQ0/iU5rIeUHgBdhnp8tlT/UVOAvaIjwW9tHO3X3rp9D9efzcrIV/AarVFxLmvs2o4
 dbtH8Q1V44bpQQhd82kFxaoCZz6woWAE6018gyaSlMJK4CvO4GYBr
X-Received: by 2002:a5d:4f92:0:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-380611dbea7mr3684024f8f.39.1730034937293; 
 Sun, 27 Oct 2024 06:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRcsv/Jxm1URUPigrQiRWmXEKTQ0Q5Sbvk3x2soG3OVDZBs0yuK9PMuUQ1ItSSEsz+dh6Xfg==
X-Received: by 2002:a5d:4f92:0:b0:37d:3985:8871 with SMTP id
 ffacd0b85a97d-380611dbea7mr3684013f8f.39.1730034936922; 
 Sun, 27 Oct 2024 06:15:36 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4319360c10asm75116075e9.43.2024.10.27.06.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 06:15:36 -0700 (PDT)
Message-ID: <e9094b82-8a23-45dc-b172-53d31abd9b32@redhat.com>
Date: Sun, 27 Oct 2024 14:15:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: do not always select X_PL011_RUST
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241025094248.152556-1-pbonzini@redhat.com>
 <m0e19.8g754qmy2u4@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <m0e19.8g754qmy2u4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/27/24 10:49, Manos Pitsidianakis wrote:
> On Fri, 25 Oct 2024 12:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Right now the Rust pl011 device is included in all QEMU system
>> emulator binaries if --enable-rust is passed.  This is not needed
>> since the board logic in hw/arm/Kconfig will pick it.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> rust/hw/char/Kconfig | 1 -
>> 1 file changed, 1 deletion(-)
>>
>> diff --git a/rust/hw/char/Kconfig b/rust/hw/char/Kconfig
>> index a1732a9e97f..5fe800c4806 100644
>> --- a/rust/hw/char/Kconfig
>> +++ b/rust/hw/char/Kconfig
>> @@ -1,3 +1,2 @@
>> config X_PL011_RUST
>>      bool
>> -    default y if HAVE_RUST
>> -- 
>> 2.47.0
> 
> (Do I need someone else reviewing this before picking this up in my
> tree?)
> 
> Acked-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Oh, I wasn't aware that you were setting up a Rust tree, since you had 
asked me to include the first round of patches.  Generally "acked-by" 
means that you are *not* going to include it in your pull requests but 
are delegating this to someone else; which would work for me because I 
have this patch included in my next pull request, which I plan on 
sending out tomorrow.

Paolo


