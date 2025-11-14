Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD9CE7AED
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 11:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJrvg-0005P0-PM; Fri, 14 Nov 2025 06:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJrv0-0004zW-3F
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 06:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vJruy-0006CK-2A
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 06:24:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763119477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hQiQlwRepElU+s6LRQFm2xPGottitdxFRvL/NL26Oss=;
 b=XkATVfD2XD/z9IJrGgleu39dhhctowzhYqaKdos4cRp1dZChjNr+RUKzmmuATk5WkZfu5W
 nw+3lsz3YTLvZnSsrF/whaHYM9QJqUQ7vz80QCBrq1t6C1HcMefAJTYMu5BPaFAf4A0qxr
 MIucJKcE2OL4qh3TSxJWl3yHFk5l/Zk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-ateQcgSNNa-dnIx7d6uyAA-1; Fri, 14 Nov 2025 06:24:36 -0500
X-MC-Unique: ateQcgSNNa-dnIx7d6uyAA-1
X-Mimecast-MFC-AGG-ID: ateQcgSNNa-dnIx7d6uyAA_1763119475
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b30184be7so844964f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 03:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763119475; x=1763724275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=hQiQlwRepElU+s6LRQFm2xPGottitdxFRvL/NL26Oss=;
 b=LyzbJQiSLIbVjnxq28HO8+RIKFb4m/kltc92+pZGX8+gBY68IrRMh2+OE/RHE2ceH3
 7IFmLE43n5K2XtaVSrcYJ40ySMfmN0vg1u5j1x15p+jaHhvpCuVX6q2pcuDIMCbvuqfr
 /7lbWVkHLBwJwRVK91asK3orvU58prkWMtgB5J16g3h4pgh0Mj1AFdGgSnYKNmMraIGZ
 j2rr0AYE1hiAPRgQPx8kHy3criTtYafT/w0gnMVwChiW7lQ8f4NOkDP4JnadGKwKxqvo
 Xj4FhDTFdGat9hS6KjZamWmCa3tPH5NIzuwfq3i2pPXGH4q/Ee+3XHf6l8DF/EJNycDX
 rqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763119475; x=1763724275;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hQiQlwRepElU+s6LRQFm2xPGottitdxFRvL/NL26Oss=;
 b=OX+FLJhE9rGSDsWRv6Gmjy2gHolsthxkmResjuxHwgvrlyb0pFjPUwXsCewYV18kPT
 CGVxaojIQpz1328y0qWZRqe5uIHKFrhQucCms+UQFJO3AEYt4WXdtk7guD8M5eWJz5/v
 f98Mlf7imAeIEoPpbJZeqnSyY1e9BpuN3162xaS+lP8QBX05wsbcGQNKZGWdj9Mv1997
 S0Rj20sz1vuDVfhVQJcKyXNNGY9AbeAI85/Pnwh34vfrs3Evkl+Wj7kGWTjQE2DzEx7k
 gnofItzL5hXHjDo4/k6p+SbVxHnDBp9zCJLLQv41ttdW0ZiYhBrpYm6Owsc0xc7UgZVT
 3RnA==
X-Gm-Message-State: AOJu0YyzJRWBIl6GMLSZqbodzg9HV2ubK5yDnzGjKWME423jVXIrF1gN
 aH3b8IqRxjm+ENI2D6fxlUdB4SKJqzk+qi96Xjm0HiC2KowavD4OIrf+TLGE2aS8F+PhPtT2OxK
 QxA7jnThm4k6gTWML2Ur/FFx31JhIViiiqrUWn4aBeJMB99zHsjVHAso5
X-Gm-Gg: ASbGncsteAmEsFd2nd8MgH6/FtTgbCTkicUaZdOln+VjddUuY8ycHXvORmJd1iCTsxk
 /5FY/khlahH/mCIMAnH2+u55a1KcXZ3M/5x0G4MBp5KmNbTJ5sp9ubbpPqWlbbD3tGj4PBQcJ2p
 pIFvfhCC1ssO1b4DXEcWQJKZeNg4wCrwFXpzmsXiEZszzkIqq4ytEic2EfrJvXeD6a5IyzP1U0j
 yCXRD8sNsHjKBPyS/ubMhQHy8sW72Mp8EW5sP42QRrG2WJKJD2+zBNoO1yjZZhJ1y2UJZejGa0U
 pmtW8HNMSGQvftXEs8StoOPxuz4jGgtlSRyvnfL9Nl96G/Yov/wwi1VWQayBHsBq6Ea/RG7w3ga
 oMbSnVmnJs1KgX5jhufgqamHO/o5oV8jRKN7CdXTdG2HRekvs2t17kfkTUTyrMC8Pn7wFqlmRZ8
 Xh2EZk
X-Received: by 2002:a05:6000:1867:b0:427:854:770 with SMTP id
 ffacd0b85a97d-42b59374ac9mr2376367f8f.43.1763119475070; 
 Fri, 14 Nov 2025 03:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJLUT9ypGvmIgNt4NGeZ8y6UBs2Xv5Q/Ky9mnidmqzqmEquYjRQEyMP33xOHKe4cszlI9sqw==
X-Received: by 2002:a05:6000:1867:b0:427:854:770 with SMTP id
 ffacd0b85a97d-42b59374ac9mr2376341f8f.43.1763119474647; 
 Fri, 14 Nov 2025 03:24:34 -0800 (PST)
Received: from [192.168.10.81] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42b5ce849ddsm2902489f8f.14.2025.11.14.03.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 03:24:33 -0800 (PST)
Message-ID: <b73bf674-abb2-4395-a840-ab07f210dc24@redhat.com>
Date: Fri, 14 Nov 2025 12:24:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Make sure fetch_instruction exist before calling it
To: phind.uet@gmail.com, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>
Cc: qemu-devel@nongnu.org
References: <20251114082915.71884-2-phind.uet@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251114082915.71884-2-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 11/14/25 09:29, phind.uet@gmail.com wrote:
> From: Nguyen Dinh Phi <phind.uet@gmail.com>
> 
> Currently, this function is only available in MSHV. If a different accelerator
> is used, and the code jumps to this section, a segfault will occur.
> (I ran into this with HVF)
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>

Applied, thanks.

Paolo

> ---
>   target/i386/emulate/x86_decode.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
> index 97bd6f1a3b..d037ed1142 100644
> --- a/target/i386/emulate/x86_decode.c
> +++ b/target/i386/emulate/x86_decode.c
> @@ -77,7 +77,11 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
>           memcpy(&val, decode->stream->bytes + decode->len, size);
>       } else {
>           target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
> -        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        if (emul_ops->fetch_instruction) {
> +            emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
> +        } else {
> +            emul_ops->read_mem(env_cpu(env), &val, va, size);
> +        }
>       }
>       decode->len += size;
>   


