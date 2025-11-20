Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC6CF857F
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM2LG-0006ln-VI; Thu, 20 Nov 2025 05:56:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2LF-0006le-EW
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:56:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM2LD-0005i6-Vs
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:56:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso3257365e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 02:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763636202; x=1764241002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nKjuggSFAUg6KqDfjRcvr47A8qsmzKEn6yQfgdxStxc=;
 b=FBb9/h5IYAWnSY14r4ilmdvFqgLiXnjeBvrIhOGWg/WAc87xnnuFwEGr3VUXMVlgY2
 l+z5Xy5oDWQtdIn9sJbZDB+QZWOqB2zdPqe/rGZTknQrMKmaeZIR3fESHrELyqJkZJ/z
 oQV/TEUjoi892x8M+rRHT/k1rhjg8tKXYr/XwDrm/dhvS8q4w/uM0pfNdl2gEiPGW92f
 lJm8QtMASV4IiM/B8BkbAtAT9qJh45hU/AD0iIDeDItru3bso+21LlSDrTUkmOYWKZrK
 iWB/NpdSX6ArK+YtF8YS09otrffTCk6xHhh2gGUJaxgGpN24Oe6/Lb39Ja5IxnbwX15U
 NzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763636202; x=1764241002;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nKjuggSFAUg6KqDfjRcvr47A8qsmzKEn6yQfgdxStxc=;
 b=ZNoSjCecWmiXfLqRqs2YtsTv/VlD0Qn24LCLatJ0k3HAEEECbiVqK/imvj5K1qbweu
 1dNbhXKqNjnDsOEG+llhFylRPhM4yiNXHepHWYTPi1+kM4Oa5A7wkJpf9PCcBlnAsb4N
 J3ZVwmAuC+feCiW7qHv4If5nKyyNz0Q/VzYzhSzLvPwPvqH8RFGP5wncSCk1JNHkTEOX
 tmBvFCrKxQO89aQQy9KyY1sOL83n2BCqL0sziQB9d2y9dgFLMl20AhjwHNmTmIs4iY52
 tJmqWe7V5UAAEZdZgOioCLn+TB64h1z7CSFydBzEnNB6H/4Q7ASxJm1W1se9LmfzZNEC
 pCNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWln/Waj0ES12h7AZpL4cxbJP9hV9fWk2noAm9r1H+IIOzvF46ZCte6BAEdvNmDOuZ5/W8UY+csze/k@nongnu.org
X-Gm-Message-State: AOJu0YyORlmvf+tGkcc1PtxsZoBtbmx0LBg1gExOKuRZG0A0mYAq3YzK
 /PcaIWgSsdf2C6aByngk+5+O1jc6KNqELxqyVBWTy+StvDc4fiLpE/Rk9+ItHunZ6/Q=
X-Gm-Gg: ASbGncvCJ6GwPTpBw8X6EMv9bhykAnAuHRfQrHQzWNUoF7ldFr+xqF2N6IGmhsr1O4a
 XXywrmxNdUARwX5fhS91/bcmSkCXVqRt2G290putbUkSFzjkTXTjj2WkC/aOWjgJZo5LNTqfbVa
 SYBlF8v5LrYlqmVOQE4cOo6ZM9qrdjvMGi9PurK987hztckiznB+zEahwhvCgEzMupyM1w+Hmlr
 Q6Dj7iqkLnlGZC7UDJPXd4kFNc6kEfPcrJdP7aNxXKf/DC1wvkIIX12Zw//pCDjWjmRIKHC5tyE
 C6vP4ZDDlAmKoluw0K5TE2fjBUHDLqwe0+6QcWXip3x2xW8pFjogpooHb07fRAoSazHaYESyu/L
 6UyQAiQhhr/rN2/NeX/JcZc10iQvoYOfD3pyKw83bCp3defU4XfkdXKr1cEZ3sKM+d4U5jaZo96
 S7yZYdKEpLtbJnOOyMTIQvfC/pVzSJerXQ9fA3uGnzm+EkZBSZ5ItiKw==
X-Google-Smtp-Source: AGHT+IE/ltMdyQhuFdkJQZQd27KpfXiQhiOuRxXI4NBm/O6YIw4K7RnUiYATdYui2T0yVJuWQ7ApAg==
X-Received: by 2002:a05:600c:6c88:b0:477:acb7:7141 with SMTP id
 5b1f17b1804b1-477b94027f2mr15577635e9.3.1763636202095; 
 Thu, 20 Nov 2025 02:56:42 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b106b10asm100648985e9.10.2025.11.20.02.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 02:56:41 -0800 (PST)
Message-ID: <8112f7f0-0800-4b04-99d0-5fcabe5c0f27@linaro.org>
Date: Thu, 20 Nov 2025 11:56:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 08/15] tests/functional/x86_64/test_memlock:
 Silence pylint warnings
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Eric Auger <eric.auger@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 BALATON Zoltan <balaton@eik.bme.hu>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251119082636.43286-1-thuth@redhat.com>
 <20251119082636.43286-9-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251119082636.43286-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 19/11/25 09:26, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Pylint complains about a missing "encoding" parameter for the open()
> function here, and about a missing return statement in the "except"
> block (which cannot happen since skipTest() never returns). Rework
> the code a little bit to silence the warnings.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/x86_64/test_memlock.py | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


