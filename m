Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B38C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 14:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx53y-000148-RV; Tue, 25 Mar 2025 10:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx53w-00013Z-0g
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:15:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tx53s-0000OF-PE
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 10:15:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22435603572so103573105ad.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742912120; x=1743516920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tzuXAwtMn/t76BOmKSNi/yBEvN7eFuMnVUBtlaqTRHA=;
 b=ckD65es/ZycFPXdSTF98NAPGhvoaoEdeLBYwgTvC6mrnuVGtzJ8S6YQwBg1aB97X+T
 q5N7yNqMNq9lfu/7NXniG4ZDSSAW9ZP2Y4n5pDMg88ds7FJPaT1G7Kgh6rbu3QtAhVqD
 RsTROowwmzC/e4nMMaELIFkKkXePxN4RqixA03tRL/+8TAFhX7fX67Nj2GAOQJAZabaV
 0pW47xQJc4YXXOETFLUGTc3Ng20XV5K5w5ygyLgZPCGJBXpFATWHOkMwG8vgLW9rN1eO
 uSBzvu8WB31PpIk8t2grNPiyQKGJsQfK9xckf3nE4wMciUx02bKKBb8NhsnEPJpirR5V
 hMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742912120; x=1743516920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tzuXAwtMn/t76BOmKSNi/yBEvN7eFuMnVUBtlaqTRHA=;
 b=cHZB3m2Yww+p1Pw9UcpHaUrnQv3AQ3IjZ2W1j2V+0/xCZKYCyClAEVGbC57leWnwp/
 mGtEKrO/t4jP1Ywup0FPJ/wdZ2hDKaZ0iWxZMYW0OB2U9t8qvGzYrJjp5VWOIb3mff07
 zxOf7sQ7NaksDZv5FKSAfd60WRwAgMy1OKZugKz5/a2wIVSrmfgXjycFtAXIQednsoJO
 dX3u6LY6NPVOQjYTnhonIDJ+ay4I1sJ6sEkn/Xx5n/Rib1ssZcdjyw7UhNqRlRkSZ/lG
 rb/62vRCs/8u3kg3Vto+gsUOi8qYFJmoISF1ih3u0W9Td8BWiW32+SjV1KDdxtOF6jFI
 5/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXETjlDBGC6iDCdV6GvIFDmAEIzxnYWUqbzbdvhXCHthbQEtcgyR28OiBkO1ngkSPvH5RKxrP90+tfy@nongnu.org
X-Gm-Message-State: AOJu0YwZ/jQsYPqB6XRyRxOQCvn9sE1X7/U1Upx/BDhauzXnB52QGeYA
 MYR6m7KTqufxxYSjFQbK9vpWv+6bpVDGEpYjTfhoJRfxItA9jnqfjTkgqYtfy4g=
X-Gm-Gg: ASbGnctUoM8l1qlbJJGEmlA0gsHdOSPjPdyhaA2VmCzYv2HmGjKi643+Ogk4n359Q2R
 1EPDK4RpcBmpFG9s1a4h3/ZAnEYoLCJC8YK1h3oPTDhM7H784uBKIqn3aIte/BAMZscyBsN2JZL
 vg0+QEAW8pP5svHZjSvGJz4vMxzwwzgepc6t6EY5bMUZ3vU/5dYXBs8GQX00czmQSJEArYLtej0
 1sWTfn6F3Ke0jLg3piJAgcwOR0Lu7hO4ZEvYdefn7AjWTEKT9ehGPhU7gKCFXyBg4nz8KrsXaqt
 dnsJxrzVk0taGpL7Tv87sxoyJDMrLbsgCeen7YBp10lMIH90WUJX3+JfXJa51EmYRbVR59aKlM+
 f99faquQM
X-Google-Smtp-Source: AGHT+IG7Zg5SL7AdUiNEjn+5RT6svJ+SNwtQmmCXH4fHKNc7FHAidPyy82jJnr6xcyiwhjVeSUIxZA==
X-Received: by 2002:a17:903:40cb:b0:224:e33:8896 with SMTP id
 d9443c01a7336-22780c536c7mr260984905ad.11.1742912119458; 
 Tue, 25 Mar 2025 07:15:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da2e3sm89843085ad.174.2025.03.25.07.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:15:19 -0700 (PDT)
Message-ID: <d9a81b84-fd34-4a4c-bb6e-fc5f0e5ce18b@linaro.org>
Date: Tue, 25 Mar 2025 07:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 0/5] exec: Remove TARGET_LONG_SIZE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
References: <20250325130221.76116-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250325130221.76116-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/25/25 06:02, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>    target/i386: Use explicit little-endian LD/ST API
>    gdbstub: Remove ldtul_be_p() and ldtul_le_p() macros
>    target/ppc/gdbstub: Replace TARGET_LONG_SIZE -> sizeof(target_ulong)
>    user/tswap: Replace TARGET_LONG_SIZE -> TARGET_LONG_BITS
>    exec/target_long: Remove TARGET_LONG_SIZE definition

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

