Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E79EC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 15:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0Mcm-00041f-3P; Thu, 03 Apr 2025 11:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Mck-00041C-J5
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Mci-0004zg-Uk
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 11:36:58 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-224100e9a5cso11976835ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743694611; x=1744299411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=59HoxlHm3ErX1wJtvCRi+ZTkNbtUVGkCkvuK5TvVPqI=;
 b=noWFRxxMH4/zpvSOkX9RaAhXE2vQ8kgOGI75ObZke4U70IrqkEy6ByVkx+FPn4tsni
 7cbxHW29Co4AJ5HJ/hX8Wgek3kJ3WXzqH7q3rPqOpO3htcewN7diTnFlMxR1h/SqYPzs
 BAylAz/d6rTjwXLvFjLlZNV5XcEj57le+YRzFCv69jixoPZCFaqPlhuNJJaysbibKH0U
 iHXdLoena+DPqeiacsAY0nMQs1HlubLVNWcmmf+MHVo+2KcqRmoOwCyEuNqS50sjHKDA
 U4td/UXytuRY/G/ewOejEUP7c1bwA5SWIjUiG7bZbOveLhppPvoatBDX1RONYzM0FST1
 4+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743694611; x=1744299411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=59HoxlHm3ErX1wJtvCRi+ZTkNbtUVGkCkvuK5TvVPqI=;
 b=PAsvN/To1UakGmhG8Z7tQ517xwmYTvcWUb8slRD8zR4m4MLBLUDhjcD7oBFELBnd+p
 5QzYlHV/W3VjAOvdgE+dIIa3EHe+TnT7cKomG1JeWjLVsTgODLrXef1wBLQAHvBcBKOO
 RfirHVAJSCokVPIaip0wEKK3ZxH9+TBFFLZE31M2G8YH/sHGHz3hP11ivpgrxhmRRftX
 PxtpRKg7khyb7mN9O9+XVlSCa7gv1WtWhAycDndoEcZcziZDQliPmOWTTwXU0z3Ml/Y4
 s27O/s+ENJdkFFj5JKKKhpyw1YHpAEpQr+8pKj2ItCi1/UZxLkADcg++d/bljux79JgD
 yzTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUHz4YT8dWwmxj0/XpI/F7Soz4JK0hALUSAAZbuGmAhXztz4uyPhSeMhA5NGYYSiNgVv3GDvZcKA7C@nongnu.org
X-Gm-Message-State: AOJu0YzQ1/BZRV8tIYwGOtX49Ms24WImM+53Ja8SPEKO8VdzM3i01uEv
 O5fDr9niq3Ak0FooAYxPEZXPx9+0PEtvF9b0S1pxcmYeXxSBKdbtBDodHTHzEGI=
X-Gm-Gg: ASbGncvGc9YnzhUzyNt5lqK4RpGChAYXtat2z6IRuEaoEkE+hAW3LJ3RZCg2ff973D7
 F4tFcmF766Tsi3aFkMa9t0BCq/pVl7UlJaG5w4tWd5cYAn/93hBLIIEb7ncRDnzuuz9b8kjCTox
 GLUif+RLfeNRLCPfmZ5Rnp2IeU+OzONPq+dZDQewB8s9Ps59+YBBwouI12CbH09qvdNxhLrhsfH
 SM78zKixgQ6vuXE1sXbzwHbDy/mxPZ8Rx405adavG7OB9d+h40uWAUXXvGejIGd2Gg0UmdBZH1o
 7I5HssjDXL6GxLXXMNIxeuDnHPtcepo0h4oUqGB1C15xR2a5B8N3K/XEPjBqYg3PGfaGy4mLZEi
 WpliTr2ZX
X-Google-Smtp-Source: AGHT+IGDMRY8mkOdPeAnSE7WPggM6EuKkzr8eF/URXZeVFjIFHxvi+1Dezy171TQ19IH6IaqmI5GeA==
X-Received: by 2002:a17:902:ef07:b0:211:e812:3948 with SMTP id
 d9443c01a7336-2292f8a0002mr317869525ad.0.1743694611315; 
 Thu, 03 Apr 2025 08:36:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2297865dfefsm16022605ad.151.2025.04.03.08.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 08:36:50 -0700 (PDT)
Message-ID: <0418b2d2-404f-445e-8441-588f7f47e134@linaro.org>
Date: Thu, 3 Apr 2025 08:36:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 43/43] target/arm: Update comment around
 cpu_untagged_addr()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250402212319.58349-1-philmd@linaro.org>
 <20250402212319.58349-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250402212319.58349-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/2/25 14:23, Philippe Mathieu-Daudé wrote:
> Since commit f9ba56a03c2 ("user: Introduce 'user/guest-host.h' header")
> cpu_untagged_addr() is only needed in "user/guest-host.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

