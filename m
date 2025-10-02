Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BDBCAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PWT-0002D5-Gx; Thu, 02 Oct 2025 16:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PWP-0002C6-Sm
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:03:26 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PWF-0000o2-Q6
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:03:22 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-27eed7bdfeeso18795105ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435388; x=1760040188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hfdq8SId+em80pbdJEgSqHqD9rZlxwH39jv9kpinLs=;
 b=mC3ZTvKa+4Zb4WhyRGJ3Du1mLrcq0p78DelgH1RkIs6TpF+KsnBD+QZGUUxG8mlfjv
 Tb92nmPqg7VH591yTS77qGEzUJjJPfiwiqCo5iap0APcYtZmYBarIEjZ9bo/0k4T6fex
 AQs+//F0zL5XtCY9RjHQ3hmWw6yO1ftGQ0r4sZm4VIDAKiFptiD7XsFkMS9n+LUTEHaR
 FZc0I5MoyPr4DmF96Uh91N7pI1AVlAbXhhAa8RSfi3U6opcjebm4KEgCifgK5e+eAceu
 qMqZfN6sUWGtIXVfdTzwqsnd821DjassmQRV2KsJ4rxgWZE68L//exfUGPCck30degG3
 SqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435388; x=1760040188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hfdq8SId+em80pbdJEgSqHqD9rZlxwH39jv9kpinLs=;
 b=XZIZtCzEWZHdvB32eb3J35Fgi8xbwui3ul8zsQi6Yy/tdIu9zAW0UoroQgpdLD1ThM
 Xf/O80p2QLTeEETphP/bJ6ICVhJfpkmcpeWw57HhsQqQqxm0+5RNPAQIT1BuwQfxl3Ti
 J2FlkYXFnr0ebCYaaMhg9m6VDcMlM4vY+TyaEFXOeaduYbfqtTaYBvReSBNaXOtSpwNQ
 KvN2fvOoGBw0M9o0BxTmTUPclEpx7pgY+lyNhvLq8ledyNs0AynnOIxcgJjK8c7glxwI
 UJvwStUSBB5VbPQHQiUAt7AwFGwmKTkJgTV5WhBrN3ByVGpT87WGyAzDkC8nQUI+Xomm
 F5cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJehExy0Djv6v7GdogrRe9HyqoeshWwduq6/I7zz/c34V9nqjawziINSCOgpnA3Aw8K1BGPbaRHM4b@nongnu.org
X-Gm-Message-State: AOJu0YwRJk8YxjcIWq3DEpP+EHeSMk+iYVtwXJd5KrEc5Ve4WDuJiymR
 PMG/1b1YBH3E3eZfxNpzo9xEs7LWrFCHTOAKmwGl06Ls86VgESJy6zE5Y25E7D55oC4=
X-Gm-Gg: ASbGnctd3ee0RAaM3Q3UbzLOWJJy5Sf3JEdwYIB6VWOwqO7AoRWNgFVTel8E1M8G8rQ
 pLLf8N00dJjd3TaA9im5/IYxvKKlGF45HydSmYzYj5fWx5ppyS/aJGtn23HcspTJLiciojznLfw
 UVpkH7bffgDU2sF1i9dvrPgVRpMVyfDn19rBOJxI/9nDn+Jc45DOaOCTDMPKm0kEzx4LVIjnvnW
 xWD+MgfRD1eTQDF58Pg9nYPAGS1FRDmCRpwbaJviTq75z+uT/jofyetzBEf7Z8+ekfZ9EDII0z0
 dro5U2U/pSBs3ioQuQjxaK9IBBIXwrEL9mOR+wv2ccsXRrUV/BS7R+jO5VlEjDHdJy50aRFHLeB
 VEwXEr920df2P3SlOM5AG7P2nTJ1FSFlpUbFtzzN/C3uZc/gln855O0e6JKfE8v0=
X-Google-Smtp-Source: AGHT+IFn4lpJ9Vt4xdt4/4/nkpUTLGzawheOLn7rZAKJWdSSMDlJIhYyjhCIbX4GsOcg8oieXUErbg==
X-Received: by 2002:a17:902:dccb:b0:279:373b:407f with SMTP id
 d9443c01a7336-28e8d00a47fmr42422255ad.5.1759435387849; 
 Thu, 02 Oct 2025 13:03:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1108b8sm28812705ad.26.2025.10.02.13.03.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:03:07 -0700 (PDT)
Message-ID: <8c267bff-3e6b-40a4-98ca-da8567798e62@linaro.org>
Date: Thu, 2 Oct 2025 13:03:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/33] target/riscv: Fix size of guest_phys_fault_addr
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-15-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-15-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> Widen to 64 bits, and use hwaddr as argument to get_physical_address().
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 2 +-
>   target/riscv/cpu_helper.c | 3 +--
>   target/riscv/machine.c    | 2 +-
>   3 files changed, 3 insertions(+), 4 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


