Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E74DC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 17:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnLBi-0005Eb-7x; Wed, 26 Feb 2025 12:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLB7-00057R-7n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:26:40 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tnLAy-0000ek-OO
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 12:26:30 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220f4dd756eso153178575ad.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740590787; x=1741195587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=anMipOCPqIO21WAlb26r1DqJzqrKk6n15v9mlFRl51A=;
 b=QgpBtdY2wz1Oe3+c9TIFkj2UIF8JkwckScOpA2EXsmv5BZX4JMMrRujwxTJyzgmKBI
 BDwpG+4G0XnkocVErpwr04fiB44gg+TmyJvApcSdPUbYzmI4/Gqh7Ynu7+wNjI3uRopN
 40uwFeRGVkPbxdDHWcnuwVisvEqTZMPLrbGVKWLvK5UzRH8gZFsJaS/2YSCKGOFWfWrG
 /Xt0axzhaawDrk6JjTEO5cEMTh9JF7ZMr6dat1q+pLqhUXdCx7t3SeuqYWHbl5nChFXs
 YXQSMxHHzuNhAb1C/HmTLR5mC170nprXD0DZ0URQLQVwMYEO16udAnZe4+h6mo2+dMYP
 Yvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740590787; x=1741195587;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anMipOCPqIO21WAlb26r1DqJzqrKk6n15v9mlFRl51A=;
 b=aMJNDPdbyMyqsC0UG3erbTgr6aUV31OYLtX8poXsz5JdSohChFNpZ5GFDYga9YYkIU
 9g/wPYSCPoUXWUS3Qbzex9JbHW+pCrKJgISbdLV1kbZJxHCKEUKGU1t/Nw/QIMuz4NeP
 c7Ota+WeGyreLewUOWYc74vCx1dxTyJ1E9Lu1todKpgL97UKVIAKwges3ng70F3Z5A6w
 trkhT3mUCDBNXjGXtd3chLy6Ej6RI4GfO/33iP0ZFzn5CxfAw0oWNpYzOgAqhXfqEYWx
 /Mwtm4gI8qWu1kO+gLBTVIgAFoelEWdL3pOUQv4I3mhdPcScGyc0o9O1SJxWXU2wiyaZ
 dhvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcVfYrPJlkFMME2RRovh1hIXE5kMgJY17+UcSifSc05VMcG2PHGk+txLCZhyIfU+j9cbp4sMPAm/QX@nongnu.org
X-Gm-Message-State: AOJu0YziZp8m3aeklmQ9DJdbTMzrj7GRoumd5kSW3IzZdWT0wWfiHwsV
 F478zbevIrVwY3EAY1mJ9NST65nKyZRK4MSXhRLTf8QsMcCTTPE8+jh/yK7MZds0O6VFS+AkdM+
 D
X-Gm-Gg: ASbGncsDPrDYdIGEH3aBudTPx7sp+nNN14ArLji7cGwCXqmRHmMlsSxkazmKoiURwYO
 aAQ7DXE2zOYUO/FtYH3zTh2p/ZfEO0u/F+UmGX5si+MPMZSuEksMnvSphSrzn6wPFCQTxiQiaJ3
 n3Mt+4rRLvpvB3iB9lUPplqpbZVxAK1CUoRrY381COd+LOe7PEQjEvcuGDiS7h88dKksLvfcp0r
 P7LzYph4CwHzD1ZH0dS7xWsl/Omw6cL/SjbaMzYWPnQhsoOzEZYe68dzzctXaA5jCAaISqf8qj2
 wSKtYkeJQkz6D5tAc2TflIHliBiXLyaA+39ZfacDe2vo82uh
X-Google-Smtp-Source: AGHT+IEtavsJNs7PK3A+8M6yYyZg9+oqomD1sY/6Ztjk9zwKCqizG1ha5sChxxXNjol/4K+m0FAC0g==
X-Received: by 2002:a05:6a20:9e4d:b0:1ee:d3aa:abea with SMTP id
 adf61e73a8af0-1f0fc12b64dmr12803513637.10.1740590786848; 
 Wed, 26 Feb 2025 09:26:26 -0800 (PST)
Received: from [10.254.143.227] ([172.56.201.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aedaa6486d7sm2987966a12.60.2025.02.26.09.26.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 09:26:26 -0800 (PST)
Message-ID: <5facb17d-c559-46df-be17-b37d22a212bc@linaro.org>
Date: Wed, 26 Feb 2025 09:26:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/25] tests/tcg: fix constraints in test-i386-adcox
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
 <20250226140343.3907080-14-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250226140343.3907080-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/26/25 06:03, Alex Bennée wrote:
> Clang complains:
> 
>    clang -O2 -m64 -mcx16 /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c -o test-i386-adcox -static
>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:32:26: error: invalid input constraint '0' in asm
>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>                             ^
>    /home/alex/lsrc/qemu.git/tests/tcg/i386/test-i386-adcox.c:57:26: error: invalid input constraint '0' in asm
>            : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));
>                             ^
>    2 errors generated.
> 
> Pointing out a numbered input constraint can't point to a read/write
> output [1]. Convert to a read-only input constraint to allow this.
> 
> [1] https://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20101101/036036.html
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/tcg/i386/test-i386-adcox.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/tcg/i386/test-i386-adcox.c b/tests/tcg/i386/test-i386-adcox.c
> index 16169efff8..b56dbc00f2 100644
> --- a/tests/tcg/i386/test-i386-adcox.c
> +++ b/tests/tcg/i386/test-i386-adcox.c
> @@ -28,7 +28,7 @@ void test_adox_adcx(uint32_t in_c, uint32_t in_o, REG adcx_operand, REG adox_ope
>           "adox %3, %2;"
>           "adcx %3, %1;"
>           "pushf; pop %0"
> -        : "+r" (flags), "+r" (out_adcx), "+r" (out_adox)
> +        : "=r"(flags), "=r"(out_adcx), "=r"(out_adox)
>           : "r" ((REG)-1), "0" (flags), "1" (out_adcx), "2" (out_adox));

Alternately, drop all of the matching constraints as redundant.
That's what "+r" does, anyway.


r~

