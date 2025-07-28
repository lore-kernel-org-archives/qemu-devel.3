Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22CEC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 18:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugSpp-0002gu-6P; Mon, 28 Jul 2025 14:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugSpG-0000xb-VW
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:44:01 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugSpD-0005h0-D8
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 14:43:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455b00283a5so28641045e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753728229; x=1754333029; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v30YyiAnK5f/H6E1hsH1UQDvvYzD4MmD9yMtY1RlojI=;
 b=ceD1GoV7UZ+IUEMQnyHN6vRti9alQjL6jlydHWU4/2GLifGo+wjSdzTLz3G8JbfNGd
 s0co9En0/LJ9gObGQFy3Lt//kXCeggw+DPW1neMUXGeAZpGSOpNPm3iJ4ZjeOSeERyHV
 2iAtlWK0S42PvQZ92LqVhwkDu528URNTdF/QDYPw+PzM47NKTkjT7+yABUt8/AAgof4g
 0/P/EhxW0d8u3kFPdn8oL/ESSU8PwAqdV7Z46jL18P21zuuHgtPHd5EBcqS39s7kzw9B
 XlvB3vqeeKF1hJaQ8ykU6pUjdgRzDiEbYS3M8IzrbST3/jIAOPkRpk8/hiYUP8C044Fa
 qPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753728229; x=1754333029;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v30YyiAnK5f/H6E1hsH1UQDvvYzD4MmD9yMtY1RlojI=;
 b=a2B1Hc6lWloMJLuKM/TfynNLpDvVsaRZs8vQfbDgJVS9A27HrvOB/YYBt+jDrTMB8T
 u/0rrfgDseFFCdUP4zIPp9ZePVTH0lKhopiVAPYLGlfgELfRFLUCIGpc5f7pQzONYmVa
 8ngvx1sgIwgpuNWAB0vQXBsDFUHZTaHQKTteIlTKdY2iLhPVFNLneTPtfvDpGecdZ8/8
 aRRq8rjHofJ8BICVG46Lt5QwunryQyYhpWMMTg6Y+DgtHYpAJT1iREImgdrUiwctWxEQ
 6CDNy+JN0z3Gi6zzvUecWZbE4gXb2+uPkRi8K4SxwGlE1iJ3gFKFv7G5B45OQ/fbkkHz
 ow+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtm3qQFHM9rg66I7ayepdTGGIuIBRyRdyx50VdfvAilTewftiHZdnaOPwL3muXwGGymC8ZAcvWNQPs@nongnu.org
X-Gm-Message-State: AOJu0YzgCXeuE5sshUjwBSRIy2g+RPyHd3A9dz2vp2SGZmZCFmnJqGPr
 Ak7aPOifbqKwfGI+5EfywoF5RtsvPRuh/S+iZs63p89RsEglyiu9jKbh62aFZ/9zcY8=
X-Gm-Gg: ASbGnctKZEyXnj2ZH4BHulYz7GIpHooqDpIocCeu+fxbj6LbsY4MPBc/e2bXY/bJDJQ
 8S5mo1y/aWnJAIw+FO1lGxRwfyhL8xfk6qu0Y1dhV1vgUUlLtyhqsjhVVj85DvNPIGz3ml+mGbw
 iYvo1Z3QkanABwjIhDBa/fQPEJSIXk665yDTa/h8d1y6+i2gZyuda6NTUrU6qIgBnu2OX0pQMg8
 D4vNtFdlsoB7jcWXCRoq03BSmwoO2TJbMX63yVWpPJvksf5/a1Er/gupk+wC0PVfMNYROAwPzJ+
 1ml1l3ClzwvW1SC93T7BF8uFFIElLXeLiwtEUY7HgYifTXNnCGFHaGpcIcKFvYr09cpf6oNRH+x
 AdTV5KnKG4ysOJtWSDytYQc0Mc+y6nptMCEDTNQgFaTRTVFBsA2vxcwM2dXcigHWVwA==
X-Google-Smtp-Source: AGHT+IG69dltNtZbswIHkg0T6vdDwHMecxtunAaB97jg9t/AJjui0Tx6gPBwQR94kbjdlGgOLEWv+g==
X-Received: by 2002:a05:600c:1da8:b0:456:1006:5415 with SMTP id
 5b1f17b1804b1-4587d83d695mr68761745e9.6.1753728229050; 
 Mon, 28 Jul 2025 11:43:49 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705377e5sm165292025e9.7.2025.07.28.11.43.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 11:43:48 -0700 (PDT)
Message-ID: <e19e5442-1479-43b3-a232-b8587c79caed@linaro.org>
Date: Mon, 28 Jul 2025 20:43:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Silence warning from ubsan
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250728172545.314178-1-thuth@redhat.com>
Content-Language: en-US
Cc: Patrick Venture <venture@google.com>, Peter Foley <pefoley@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250728172545.314178-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Cc'ing Patrick & Peter for similar patch:
https://lore.kernel.org/qemu-devel/aCUDxEQVACn5CY8f@x1.local/

On 28/7/25 19:25, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When compiling QEMU with --enable-ubsan there is a undefined behavior
> warning when running the bios-tables-test for example:
> 
>   .../system/physmem.c:3243:13: runtime error: applying non-zero offset 262144 to null pointer
>      #0 0x55ac1df5fbc4 in address_space_write_rom_internal .../system/physmem.c:3243:13
> 
> The problem is that buf is indeed NULL if the function is e.g. called
> with type == FLUSH_CACHE. Add a check to fix the issue.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/physmem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 130c148ffb5..00333ffa7f7 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3240,8 +3240,10 @@ static inline MemTxResult address_space_write_rom_internal(AddressSpace *as,
>               }
>           }
>           len -= l;
> -        buf += l;
>           addr += l;
> +        if (buf) {
> +            buf += l;
> +        }
>       }
>       return MEMTX_OK;
>   }


