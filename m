Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12E3D1D46A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrju-0000Dm-7Z; Thu, 08 Jan 2026 10:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdrjp-0000Cb-Ol
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:15:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdrjn-00033x-Iu
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767885345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mTFK/zGjf96JqQXGTDkWieXJ16Vk4rooWLMwnkM5sbo=;
 b=HygbCKaCRcYknwsOmAhOZobfQRs7aJvyRW/PYw1Yd6AEwYJa0v0zyIpHgbSPfpyFTTe4z9
 X29gG1CoaXDpSP2LPw4pRnIGJrhxnjoFBg5JwfNZAaNIgYRSOlT+qgfXvx38Va29k0Teo8
 v7CRKRQBHDPT97t/zj/tBN8rU/R635Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-5KWLAnb7OaCXXEEddwQb_A-1; Thu, 08 Jan 2026 10:15:43 -0500
X-MC-Unique: 5KWLAnb7OaCXXEEddwQb_A-1
X-Mimecast-MFC-AGG-ID: 5KWLAnb7OaCXXEEddwQb_A_1767885342
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-64db7bc9921so6125003a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767885342; x=1768490142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mTFK/zGjf96JqQXGTDkWieXJ16Vk4rooWLMwnkM5sbo=;
 b=KcdVNW1Fo2N0OlWJ7rSE3VFbjSk9KWm8kK+w0A/phrWP/a+ti0gYYWdHM+DB5V4V9b
 I+focvQ1iYIxoifIXxHi1FdN32T6wfbMRpB9EGCqvt3aPbtIOkwq6RqVkiJFzGobV2b4
 lwfvIDJC0XNMwBUEfM30Cvz0jDAvUtzQ2j7yG83FUZy/ZmqYs6xg1Sgc/+b6U2hq7eH0
 apFyG8BukcxEBNGNOMZ3llg/aWJvDuBTBfoW6UjJ9NKdgmVpJC5yN2gZ4basU5KuYYRr
 wLHS8V8V24R9/IDO5vihpnP7Se5Evd6eKkEXcGI/HFkZ1ReBPwLRUxMByV1H3BAMxzdg
 kDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885342; x=1768490142;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mTFK/zGjf96JqQXGTDkWieXJ16Vk4rooWLMwnkM5sbo=;
 b=GrGETcHAf8qZon7tblwjgJlLLytObTZWKukjmFB312ENVJJWk65LA8fRpTuUZoJu1O
 75Exh6gKmuZpEnkWL/N+XMjICCtmw1SHhXMSO0O3/8YrXKDay3+UhoM7KCBXIRoZdwkO
 6IAarsKgDiLyMc2YWU0CSLPnvnumyomZoGLPFsKEX22ovW6OB9SIDtlGVSWRk8OfZblZ
 LDoTtu3Dm7CtMX/1EgEDJD+wVxOEuu2cxa5yHRN6LsanXEDFn84ilPH1OFfI4HnGA34O
 T8eguMRemOn5JsnY0w1xObJFKlcpqBfekIFmC+uFDL9oWmQFYn3OA6WutcApkU+KuSvX
 WVvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlMVOJublGRnmd7qJWvs9dJQcf/yVG3Ccekv/+uVFB8TR+ahfdQLVyYWKyai+WOvi2KoVQgkfusD/Z@nongnu.org
X-Gm-Message-State: AOJu0YzW4aN28K2QoceJJgW8mkyGErzM0BRpYeaoJfzpZV8blF7uJ7Cx
 SDiEp7nJOl4mOdvf6z3kDMasA34SLFaNO9jLUyhazezRBzqaJf84chudKBMZuh+IBYXWR1CfF0Q
 wx7puF+o4J80MMLB53cZum8yNlXlflimqsJxZlE+dS7BfmWakirB2sSIQ
X-Gm-Gg: AY/fxX5C5CH5exYKT51pMuPnBgpnQfim18drIfSBAcYHmVxy+uAD1RzRAr8zatoqoLB
 HQRz09nFxBeVPNE2KHz9RCy9QCTeXCEeKylNNEI1+UamG0VO5ZUOwGX7p8WHXJJ1pxxjZeYtUZw
 kZ2sbmogR97sTf7mfjvNpi0wAQNnYFt7StAibp/vxhJ2K0R8n7fnv6l97pqgAwEYp7xZVQUc/jK
 n4OwZQqCVinS3glLK4CnBDnftpu1FdKy4pI4BEUAfMz+kI5NxwC9rzmySv1i+ZR+92uEqyXKUla
 aa2iyPyTFTI7ZDa0kc77QxPU68naiqFhkolIG2IbfRoX8xGIvWHfKX5n/17qmjAk8Gu2825rxeG
 flrYpTzyEjBlE6ghKYqupDa3WAZcYDa7DKCrAPJ/Wx6cCMXns/lZxr6OzYqvGiQbln4e68mhQ39
 RhpekFgKYwuX0=
X-Received: by 2002:a17:906:4fc9:b0:b79:ecb0:db74 with SMTP id
 a640c23a62f3a-b844540607dmr667842166b.59.1767885341948; 
 Thu, 08 Jan 2026 07:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4C5pLM/KeLxHB/T9VSPlHVnCV16pCrOHeogApUnGMq6/YaQLCsGOT+55qE+xtsdH1DzSPYQ==
X-Received: by 2002:a17:906:4fc9:b0:b79:ecb0:db74 with SMTP id
 a640c23a62f3a-b844540607dmr667839966b.59.1767885341523; 
 Thu, 08 Jan 2026 07:15:41 -0800 (PST)
Received: from [192.168.1.84] ([93.56.161.93])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b842a2ab77bsm869146366b.25.2026.01.08.07.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 07:15:40 -0800 (PST)
Message-ID: <56548949-8afd-4bcc-b539-bfb1a28c3987@redhat.com>
Date: Thu, 8 Jan 2026 16:15:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: disable libatomic with GCC >= 16
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260108141407.2151817-1-berrange@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260108141407.2151817-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 1/8/26 15:14, Daniel P. Berrangé wrote:
> Historically it was required to ask for libatomic explicitly with
> -latomic, but with GCC >= 16 apps will get linked to libatomic
> whether they ask for it or not.
> 
> This invalidates QEMU's check for atomic op support for int128
> which explicitly does NOT want to use the libatomic impl. As a
> result with GCC >= 16, QEMU is now getting linked to libatomic
> and is activating CONFIG_ATOMIC128. This in turn exposes a bug
> in GCC's libatomic.a static buld which is incompatible with the
> use of -static-pie leading to build failures like:
> 
>      /usr/bin/ld: /usr/lib/gcc/x86_64-redhat-linux/16/libatomic.a(cas_16_.o): relocation R_X86_64_32 against hidden symbol `libat_compare_exchange_16_i1' can not be used when making a PIE object
>      /usr/bin/ld: failed to set dynamic section sizes: bad value
> collect2: error: ld returned 1 exit status
> 
> The newly introduced -fno-link-libatomic flag can be used to
> disable the new automatic linking of libatomic. Setting this in
> qemu_isa_flags early on ensures that the check for CONFIG_ATOMIC128
> still works correctly.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/meson.build b/meson.build
> index db87358d62..56df08c10e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -445,6 +445,15 @@ if host_arch in ['i386', 'x86_64']
>     endif
>   endif
>   
> +# GCC >= 16 automatically tries to link libatomic for all programs.
> +#
> +# QEMU explicitly does NOT want to use libatomic for int128 types.
> +#
> +# Later checks assume we won't get atomic ops for int128 without
> +# explicitly asking for -latomic, so we must disable GCC's new
> +# automatic linking with the new -fno-link-libatomic flag
> +qemu_isa_flags += cc.get_supported_arguments('-fno-link-libatomic')
> +
>   qemu_common_flags = qemu_isa_flags + qemu_common_flags
>   
>   if get_option('prefer_static')

Great. :/  Is there a bug reported for the -static-pie issue?

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo


