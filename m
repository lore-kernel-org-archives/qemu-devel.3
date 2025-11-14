Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1129CEACFB
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 23:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vK3R8-0002UD-Kf; Fri, 14 Nov 2025 18:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK3Ol-0001KO-NQ
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vK3Og-0006XN-7r
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 18:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763163603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l8whlAAKKkdIgjd7yfVV3zI1oFn1D/BV88eScV4sya0=;
 b=i8l9/54UzcWMXNZlewtrDa/TOjaP8CTHcjE5L373VtRM/l5W5Sfs1xNEhnE5n4C1JNtzXB
 J54V/S98mFlDTJ+I6a55Vrkg6PCdpQTF5i99XjV0hMu+k39CNNcqL4s2aFc6vvcOKgrip+
 IaBIM3xBEYfYQFkox4zURiXuOuu6I/Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-NsRVrLJoNk6e7h8WHZVu_g-1; Fri, 14 Nov 2025 18:40:02 -0500
X-MC-Unique: NsRVrLJoNk6e7h8WHZVu_g-1
X-Mimecast-MFC-AGG-ID: NsRVrLJoNk6e7h8WHZVu_g_1763163601
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477771366cbso16397535e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 15:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763163601; x=1763768401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=l8whlAAKKkdIgjd7yfVV3zI1oFn1D/BV88eScV4sya0=;
 b=LaZXJ1PlzDDorSgVOmYvDJftAOak+YvhZXjWDXPfJlJxsQzjToIl4oVQEvxQPRgbgc
 rdA/m3QuQ8Ax3P7uuKD/LTafJJtLjCYciNeNENgFjuI3ugOKlgg84OSnd1p4xHvvGUHE
 pSAVqVCr4NwIcrhhoRBhEUW2vXzM23eYpqieXgur5+/wXfIzl7LVYQUb0QiCtcwV111r
 Pn76ay9wPDqfG1lVkRn9WK9TXxz/ru5ZUPpqvUb6eFhwN9BfjmJT2K+OrRsEoDAyhp9Y
 6kKnR3uIBkt8Gx9QciRipi0zpTGW6tjqoD/QUQLaHPBNKBI52mJJ3n+tNdwQNULRAfmG
 Fd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763163601; x=1763768401;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8whlAAKKkdIgjd7yfVV3zI1oFn1D/BV88eScV4sya0=;
 b=lfR5Gx6xIxJFyckd53/lPCfdGrjmck+mBH9i8rHs8tzQ5OAJ6iWBXurIfQK2f9MM5P
 KSmcijdVPVwtdGaSUKQ+3EoLjn2Y4Xhz8K5KT5sKjqNbV7wPPDt2jF9LnbQ6Kkbus1P5
 EH+fZ3w7w+x+hqTBdxJNufIScQq3zaAtLZKjf6ds7Rqk67wr0xB5I+gzCVyvclyZV7Ec
 TjDKT5aN8TyvvatikDlxIwJZpIhjFG6a49Hx7vkJJGB8bADFldGExCJl8kBSXOYMuVNg
 hAolmpk15zVAWQkVbjZwd4NN0u8OqhwPRI8MM26VzHg4jE0DbRpje0Xv43JrFMKBbeFi
 +9yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW343vM8vV1zbcNmdRPNaug2iBcOwSzAtDY8N5xAFFpzIO4alFEvB2+W79pP9nrbYn9om8tEovUGiA3@nongnu.org
X-Gm-Message-State: AOJu0YzDKDbWxpZOMThxFetUFixRwmH2PgKopF0kgkEzjjwaTbhgnwcq
 uWhwNmHxxrdLPr3xMI2H/UZTSVL3WInEKzi8WNMF2OjnVrLpn4JJTYQh91qHQw47WZCAPQbElQy
 IXbw4zuNDvHgyPpTU2AnM4GpGcMa61adcKZpd2CacpVfhYjmzmkpE1kaX
X-Gm-Gg: ASbGncviu9OWqviV38oD7qz9o0ZBmrLfBZq4AvlAlvkoMmUzb2VuxVLkkuJwZ5JBycg
 nGTfwJyzSUnicgUeI6moGOKp93UYjJRON32DmFhu1lNLQjg4KVt47H1PjKQQqWC3SrZXYDAJpM0
 aZarOUMd828W9GgpBXxW+UQ5N9VadJJ5RuZ2kLQaVnvTZFZ1YoD64laJyPC47yO7nchNDjHxwPb
 UDEnu1CzMV0wH4x3ommbWF9nFUEEpckUZtJu+wEJ+QljLKDABOSqsQael1ixgHbwfTjYUnJVd/K
 u0oxkCis65PjUsT3O3mCmK3mmsH41GD885sDMYbYKlWMSJmnZZ+GXPUqyIiOjHCPztxAHBVXF8x
 eJdJUfJR/8yGsSVCZKgM7EnsTklTJ7A5BN22H/XX3y4LTi8iXNXH6eyifPZleLWKqTB5vRho4EF
 xufHje
X-Received: by 2002:a05:600c:3587:b0:477:75eb:a643 with SMTP id
 5b1f17b1804b1-4778fe4f3demr40557125e9.4.1763163600892; 
 Fri, 14 Nov 2025 15:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN0WG1iS/sPiYKy9fqc7gwNxvUFvm/CsRF1EOI5/6pB07Y/PgDbTA10OfQsQdez4A2r7xLSQ==
X-Received: by 2002:a05:600c:3587:b0:477:75eb:a643 with SMTP id
 5b1f17b1804b1-4778fe4f3demr40557075e9.4.1763163600476; 
 Fri, 14 Nov 2025 15:40:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47787e2ad4csm176369815e9.1.2025.11.14.15.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Nov 2025 15:39:59 -0800 (PST)
Message-ID: <6e695458-13bf-4d64-89ee-f39818ed2e52@redhat.com>
Date: Sat, 15 Nov 2025 00:39:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Mark VPERMILPS as not valid with prefix 0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20251114175417.2794804-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251114175417.2794804-1-peter.maydell@linaro.org>
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

On 11/14/25 18:54, Peter Maydell wrote:
> There are a small set of binary SSE insns which have no MMX
> equivalent, which we create the gen functions for with the
> BINARY_INT_SSE() macro.  This forwards to gen_binary_int_sse() with a
> NULL pointer for 'mmx'.
> 
> For almost all of these insns we correctly mark them in the decode
> table as not permitting a zero prefix byte; however we got this wrong
> for VPERMILPS, with the result that a bogus instruction would get
> through the decode checks and end up in gen_binary_int_sse() trying
> to call a NULL pointer.
> 
> Correct the decode table entry for VPERMILPD so that we get the
> expected #UD exception.

Fixed to VPERMILPS, and applied, thanks!

Paolo>
> In the x86 SDM, table A-4 "Three-byte Opcode Map: 08H-FFH
> (First Two Bytes are 0F 38H)" confirms that there is no pfx 0
> version of VPERMILPS.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3199
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index f4192f10068..805cfd08e83 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -643,7 +643,7 @@ static const X86OpEntry opcodes_0F38_00toEF[240] = {
>       [0x0a] = X86_OP_ENTRY3(PSIGND,    V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
>       [0x0b] = X86_OP_ENTRY3(PMULHRSW,  V,x,        H,x,  W,x,  vex4 cpuid(SSSE3) mmx avx2_256 p_00_66),
>       /* Listed incorrectly as type 4 */
> -    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_00_66),
> +    [0x0c] = X86_OP_ENTRY3(VPERMILPS, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>       [0x0d] = X86_OP_ENTRY3(VPERMILPD, V,x,        H,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>       [0x0e] = X86_OP_ENTRY3(VTESTPS,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),
>       [0x0f] = X86_OP_ENTRY3(VTESTPD,   None,None,  V,x,  W,x,  vex6 chk(W0) cpuid(AVX) p_66),


