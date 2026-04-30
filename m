Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44494FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIK8e-0005GV-Np; Thu, 30 Apr 2026 01:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK8b-0005Ey-Hz
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:40:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIK8X-00017k-EQ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:40:36 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ad135063so3756475e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777527630; x=1778132430; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxM3rhlMKrQzyni1Gr5kbEORVUSd1elj9gM7QpjMJ7A=;
 b=C1NrKfnmFWy0jEUyQNvHyNYEzFDqUn3g0MAhADLuVl6fKz6mB2Yp2ms4m2MAs66SrZ
 PjPrX+4k/OXvHjgJtA8Tj9kHZfHQYYchXUhAdW27QYSzW+nveIEXPdRAXZcmUK7BbS3C
 3qBqNNtTcZ2oebPGLSfp+v8RCDFX/n19ovMkTopr1UF09o2Y6hs7Dv3Cm9USUT1hrLrC
 JmBuNpoCT3YG04QfgZa9voKT1TE5xcQ1gmLLe5bkLqiyZAKHvsP0rJ3cZcnSnn/M21fr
 MojNPhQ8MHTMxifKcxp7Y/08JXasXT5ilbXCmaTkQVqc533q76KcKr8WFST3nq/baRoJ
 iJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777527630; x=1778132430;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxM3rhlMKrQzyni1Gr5kbEORVUSd1elj9gM7QpjMJ7A=;
 b=F/HQxux5X1sZ5juJdi26uGJhstdERrqtH+BGCa1LA0iXzfPZCmUqXMfTH7JYoL4J6z
 KWGmhqG24FgUd3sWZm8WA81bB5f/y8R5uodrm6Gqw2xWf19r4a6Fl43DruqB1+ogrFhH
 jzBiRJfcGhmjn8qYY1beuvP5cemYKoo+wlJNLgXRcXZQimUSYpf8BKYEjmON0NmVMWMN
 4H0RV4YjGydUb5DNfLyZJpKatQsiUAau2UyhJI0k1ERtPdglj9mZDWAu60TyItuukb5f
 OC90hwwimfqDB7e0WsXZ2Yffl186boXR2OpfvC7/aZ1zzZr4UuW8ZSq81hX3Y4akRu6j
 r5qQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+uBdQ3c/+ZDQIg6eXVMdXMDI350JZbPwFCj1QYRO07e9IKqjKh95zRg9vYoxEGKzmIGjMneBWwltv@nongnu.org
X-Gm-Message-State: AOJu0YyWj4wyLrWwl+4lmIIK5l6GgvEHA3Ls6M7JkNyqgkDfgb84ucPE
 GLbWMj7KfVJa0nlI0RIy9QyI6XZRfLeZ71qJ0430WmTA3xM2rIK9eBzYafmOIuy6q04=
X-Gm-Gg: AeBDiesrexU7lKmTGOxl2ohOkkzibQ0s4AoAJA5w9H1nCx5gOSRGkOkfy5Ka5oAr5uT
 PnZbybf1j+voM6PwErDh2ZeJCf3aHu2QKMv6D6/CWBRfqpUkT2FyKlH9pjz9+vD8tab6FzHCbO8
 iezg4Yj0O2DVA5r1/ofkyxQ+CuVAZK1MTO3Bt0UVHxhxR5U3PY+eEQCmUwHhuscudfe1PzLNhVj
 a0D18WuRKv65QTxs5d3pRPwMtCgqh1X/n4Zd6xwOXbARjcWKv3zq+JgNqUn0jIqrWXhCDIo6W1U
 fkcbR7GH78pY+5iJPW8CPtpUQONwpDmRR/nlwiLuocfiUBrIl84ZMpoK5a9ycHz82rHuJTSRWcx
 z571nUkouyIDXR4Z82SYIQrXvkWrr1XyOQRQCNIGZSQQDpZbUlP3NlnbiDe6B6akafBaljp3EsO
 O6aqji0Bu1pPCp2d3IIBN/Mk3gEUGz5m7f6K512bh954PmT3Aj6vQUAKsCPfkOJ2MFMTx8zlUTv
 LPq
X-Received: by 2002:a05:600c:8b04:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48a83d6a89bmr22435695e9.2.1777527630511; 
 Wed, 29 Apr 2026 22:40:30 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b9219f3sm40492965e9.9.2026.04.29.22.40.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:40:29 -0700 (PDT)
Message-ID: <2ad2c12a-b850-4d92-b20b-d259dc67511d@linaro.org>
Date: Thu, 30 Apr 2026 07:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/40] fpu: Mark pack_raw64 QEMU_ALWAYS_INLINE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 30/4/26 02:04, Richard Henderson wrote:
> This is almost always used with a constant FloatFmt,
> so inlining pulls the constants into the shifts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

