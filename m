Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203B7C021A6
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticbQ-00088D-1q; Thu, 13 Feb 2025 12:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticaX-0007vI-Pf
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:01:24 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticaV-0006Xx-To
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:01:21 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f78b1fb7dso19264035ad.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466078; x=1740070878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i0GnvwYOIWLSQrskx04NfY5AicyRrWaJKwfVxy9bfdE=;
 b=ycZMyc1WlEf6PjdsZCbCx+p0vG31cBm7w5S+71Sb+I03S4TbKtUaWqrqEDECVui1gw
 csJktmcxbzemv2VCGHep0M3TNqYw3eafkYokn3ycOHiDHJCgiGZhWOaml7ZC13G5zG2l
 wdGR6YOh32av+rsR/y+aq2ur+zspTiXbp590j4Px1aMjCHV26A9gVzwGfcFRdalii8sd
 hn8f6SJl5kpTteT1rRRVUfVMU52cO0S6UhMFILQicunBXZJjHahvNtWI1fr3ispYoTXV
 0AoNXHfvpY6V5DybofJu3+Drq2GKs5JuP858F+xvDduId97Ob48la1gFG1fWPuyjGmfA
 jtfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466078; x=1740070878;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0GnvwYOIWLSQrskx04NfY5AicyRrWaJKwfVxy9bfdE=;
 b=JbM0pzWY803byJuqle711W5HnS4q3S+mbR+dzyWpOBC6heLk92LTbKcAcKfiQFqlh+
 kHfRNg7oaYX8+tUrZhjFsSc1ByGQa2PutaZllp1sCPbYNc4vgajlc+X65PiXmSc5vvd+
 fJouEkNWlK+7FEdhENcrX1c+X0HSafuPigcA3HZ7paI4LhYOZHaWwieWU7cYG6Q8kQcF
 8WmEvUQw6UeICbNejXw56jbAtISvTRYAy21jcocutnl2l1YcpZG58qaMVX6jivaXU8BW
 RWMxJjs9jvD1RfNxjkGBLOjTp413sOfV+pv2G174jLP/Ya72W2ulGqabHE0WbIfSJU15
 UFnw==
X-Gm-Message-State: AOJu0YxnKLeYe4Imc/oB407mnnSBHTEIluYsc/mjCisBsuDcvzO5bHTP
 +0XQPvPUEWyfRoRK9cXHKuCUPqYMs2DYRNYzHVi4Lx1MSYIZ8SCMKikbLMJTOeJqAmWhlFNBUQs
 A
X-Gm-Gg: ASbGnctNawxvnsm1oHzs91bu9lFprYCIa1rekjWMNd+1BsuHXysKHWqPeviHPWhHH1i
 H4q+PLj1AmL0Y1yzOXbcU5IbA3/QvQNyfiEUzQ2pB1PGWsfaz6Vu+M+LlCztfGRvgKLL7Igr4aS
 VtD63QOlmyr3PY3FR2e2KtJJumvT2Xmn4ZvCJvc2Li77bqtnl4TkjnPIjGOSe9VF0ZHzB6chFY7
 /tu9fB5HQ79vEclTPq7iFRG3m9ByD6OYK00jcRIhRzG78iDH+Cjbk4e+0vr0Aeq29e6H/yrtY/N
 r0cTY205YTeljl4yqUVHzzUUC8d7K4nse8ULZWAVZpCYtXu9mVlaX5Y=
X-Google-Smtp-Source: AGHT+IFpt4iQClQbeMi7QcPIfprDiEidUCs/e0gUOvgz9hB15JWm9nJlN57i00IVRwe2KnccC9jZDg==
X-Received: by 2002:a05:6a00:3029:b0:732:1ffc:36fa with SMTP id
 d2e1a72fcca58-7322c37860amr11363026b3a.4.1739466078095; 
 Thu, 13 Feb 2025 09:01:18 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adbf21517eesm565415a12.13.2025.02.13.09.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:01:17 -0800 (PST)
Message-ID: <8e6c8b1a-a7ea-4bd9-97c3-2f671fd40b83@linaro.org>
Date: Thu, 13 Feb 2025 09:01:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] hw/intc/xilinx_intc: Make device endianness
 configurable
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> 
> Add the "endianness" property to select the device endianness.
> This property is unspecified by default, and machines need to
> make it explicit.
> 
> Set the proper endianness for each machine using the device.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/intc/xilinx_intc.c                    | 59 ++++++++++++++++++------
>   hw/microblaze/petalogix_ml605_mmu.c      |  3 ++
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  3 ++
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/riscv/microblaze-v-generic.c          |  1 +
>   5 files changed, 53 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

