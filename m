Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A10C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuClS-0000xI-WD; Mon, 17 Mar 2025 11:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuClI-0000vH-Hg
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:52:22 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuClF-0008Pr-Uq
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:52:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso15263315e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742226736; x=1742831536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7xiXPoAKkwFpGzY8cUM/UBfoM1Sb/wB5ZKQOj7uhRCw=;
 b=HK4hFd2XnlL3yb/CBilcLW2SJPe2r3MfO+VF+kXzLp2Y/erPMqZxpMegO4cEZjXZhb
 KmjE3TgdasaJwKpNQOIkkOyHMHAJPaulqhGfJYZqidQhJnsJJD1GLEo8LVuaJda5aHew
 PFBERh1HY3stm/Bi2iT0cMhXk2frX5Yz3eSvkx3LWy4DwqARd99PhdG1nMB0Wu7N0n1T
 PswzR/vapp0S+bgFnXxLCk18fUhFdoZLN+m5T38c4eCuZPf6wjXpbvdisbn9J1l33KGR
 q0OtJfq+Au5x9HH1bvJ58CG/wYK+4RvD/utXizcKF5hy5zxMuC09Gcks65Op9t9OE8m8
 n/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742226736; x=1742831536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7xiXPoAKkwFpGzY8cUM/UBfoM1Sb/wB5ZKQOj7uhRCw=;
 b=rUx7D2TUjuVpvcNpp701gSr6RPmB/SKFcaCArkkYm4VQkIKrGinfnfPw/YJxrZU0V6
 NMFeef+4+Jobrrel2c4luisFVGp8ap132JuTD+qGSy2heHVCzteoHtB9K6oAi/DgAwrt
 Pstu/a2MVDITSxm0CBzTBJ5FnFzOKzPnCtanKY/E3ZLcOwKwA9xLeVabH4YR2ktcF/xT
 bM3uDLrfVV5oTgVjZJtW2ng6vXJpj4zgucoBUJzAIRO3OdFpjUTNSYlvb0wTS4hYODWJ
 PI58mLlhavrfW9npbKLHaohQssIJ47wU8k3/QZi+ZBmUj5WzZQzFbCyozZfp4TdFRz6R
 Y56Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmrOSdbiLAeX/L/HDjI6cvf4t+9hzmUorWPOQjFOjfnUF2cRvbXwZNrTGTmoPrfSr+hww3mpqgLCKk@nongnu.org
X-Gm-Message-State: AOJu0YzhIxVIbrmhqLwBmbaoxiDL6uV2KtZpV21oAkHbwRX4YuUlQPse
 aMj80IBp0UQ9dsFGHLv7OeBjnltRGb7FDIsgk6cGioCbOhRNzOwxWhxrWPznUA4+uxrUetSL3wr
 1
X-Gm-Gg: ASbGnct7TVrqdBBWXbS2frTqNScpY8x+/ra0ek5TJ0AN3LVwu74FZAKSNMg35MisWjQ
 cXH5c4kpTkiwuHJwzS81BlLNXraq21G8YW8Mw3efgKTbhNvzRp1TYusEdUFbXz76Oig4NBBICz/
 DBw0ox7uokI6E1fBY7TASpb1rBtPFWzsqh2qVVjiNUOWEyPk0mkcmaAysMgaXEdeNpQVNLuwhA8
 XAQFMkpguVP/96Nf2Eq9GZrz9pIsE/JEUAeb7tYFApRxb5jBizFIxci6VRHDxwJZNzN7f4Mm6ga
 HYX/mP5PGAbz/paM0C1G90gP4oPZ6yGeS+QYKcqqchZVNP5La/QGPJoSjXYcFNejq1uutN2kDij
 WckwXE20Wy0SGz57/265+
X-Google-Smtp-Source: AGHT+IFpt8KideQTGA4uKhjvZxuTIzGsP3DM5t9jXqk82vnIbb3xkl9IyoVgYgeOQux+EakZvkLZoQ==
X-Received: by 2002:a05:600c:4ed2:b0:43d:cc9:b0a3 with SMTP id
 5b1f17b1804b1-43d1ed000fdmr111360435e9.22.1742226736253; 
 Mon, 17 Mar 2025 08:52:16 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdbc4cesm81462315e9.0.2025.03.17.08.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:52:15 -0700 (PDT)
Message-ID: <0f6a945b-b3f7-4602-8c17-db07123026a9@linaro.org>
Date: Mon, 17 Mar 2025 16:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/17] include/exec/memory: move devend functions to
 memory-internal.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Peter Xu <peterx@redhat.com>,
 alex.bennee@linaro.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Anthony PERARD <anthony@xenproject.org>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Weiwei Li <liwei1518@gmail.com>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <20250314173139.2122904-16-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250314173139.2122904-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/3/25 18:31, Pierrick Bouvier wrote:
> Only system/physmem.c and system/memory.c use those functions, so we can
> move then to internal header.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory-internal.h | 19 +++++++++++++++++++
>   include/exec/memory.h          | 18 ------------------
>   2 files changed, 19 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


