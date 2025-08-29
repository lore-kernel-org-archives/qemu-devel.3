Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7479CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNg7-0007fm-T9; Sat, 30 Aug 2025 11:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5p0-0005Hl-4Q
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:35:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us5oy-0002dh-JR
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:35:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so2296059b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756499738; x=1757104538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n3hAh1vvE5/5Bt/BWpyuzvDztQhRPCBEBCTLFQPijQM=;
 b=ELNDTStWrmz9MryFXYjS/4AqgK5CUspT7IySgK36vjXc4U9Q/9hsFza3ynXWclKasG
 D+IzAOq0N/wqr2H0crNIfW+X900BeXKXyznmT8nx1CeBhyoKzdw7htnf2NDsRIdnoZDs
 9L6Sai1esc3juC4YB45cJgfVve+JeLv7OSbRPe656WusHiyGX+DTLC0ZdZZCUaNb2ypc
 OwEif/nmptrcO7PLinQuFcef8mZ8qjhrRtO0NiNpgrYnNhRam7vO/K1Lx08o3EbST42R
 T75/9+Tui0ynT12l1sQEvq+uU6NhELKC71T85aczrlf2QGVBxTX7R075wz/xUA4zHqHz
 dvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756499738; x=1757104538;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n3hAh1vvE5/5Bt/BWpyuzvDztQhRPCBEBCTLFQPijQM=;
 b=Y/DU1D8MQVtlTKevnmhfxmXTzhwHRd31ZayDQpzAtXycVxlEyMP3wpWBUZtv9KDRFE
 rPhmT3Hvr3lO42g0aA0kykZ8XBNsziCQbJZlf8MQRnRs1s71DbObPgQW/x2e1ovC08u8
 XYEvJrWFPmYYsljo2uKp4UFOxxEzG1ZOL/2spqp+Y3fnACvn7cAUAdvmItsm0iDdMp4i
 eu6UeQLfNhc7ME9cDpyQeNQEkQqLvIQW30uTGvY1HxPu+OTfdmG5qtGTLU0Vnf5Flui6
 98IiC4snGDj01B+Zu9OcgR0NCbRS3Ujekklty9cQ/7k74avixqGiIudarTUjabRXgRtY
 Vs3g==
X-Gm-Message-State: AOJu0YyOelvr86Y032Rer4GVHQ7rPQ+Lqi6iWgSBvWUa2gtKQT8TEqcK
 PXANcJc78PnhIg1B6AzPn70qmYXwVoZJYidk4EVO8NWYFwK9zV6P/QYGREuQ97V+xrU=
X-Gm-Gg: ASbGnct5981mj5ypdsQWjrge9q7JD65nF2SQEb0JArwnZk5zJ5/sVMrXYO0U91I3heI
 K36Ym82wqWpQ+nKh5phlWoQgC9MlcakhTuCbqYXRUXebV4YWdgA0RodNHt6B92szVNsjrZKeT17
 HfzpX+dcuVRs720xBs4XVH7u/V14DMUafZajQ1IbvuG1MiVbSNc47zQBaxri3TU/wVjcK1Mj5FX
 7hOjfSQvrRRarp++tX5aUws1H7KbHW5sZfz+WTT4qhTHDt35vi6eeWtj4/EELWwAQN+CyINeYHp
 mDvXdgfMI5Swjrz/Kxl3n58XRB0naIDhukM1gP8+VP3teI7/fmh6XVQq3DqfxSNMJjpNDCIox9O
 Q8EUKUx7sR+gzbrbsfzRtD2YsIww5ztnlhfstGQOjYHa6GnhwUy3zSzk1Bj43Pw7mmdjuykwlRt
 7z9oLHrI8=
X-Google-Smtp-Source: AGHT+IHnlIgxeImVA7YaPEACD2FcX2OVSzkioCaJdcwfM/Kb7b3EmG2yaLU2lLMj0Aucxxe5MtTSyw==
X-Received: by 2002:a05:6a00:2e07:b0:771:e4e5:2ea0 with SMTP id
 d2e1a72fcca58-771e4e53316mr20930338b3a.10.1756499738173; 
 Fri, 29 Aug 2025 13:35:38 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a2b2f56sm3210585b3a.26.2025.08.29.13.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 13:35:37 -0700 (PDT)
Message-ID: <ee00c8da-47a5-4add-9237-c8907891ec26@linaro.org>
Date: Fri, 29 Aug 2025 20:03:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 38/87] linux-user/arm: Expand target_elf_gregset_t
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-39-richard.henderson@linaro.org>
 <CAFEAcA_a-G1hgeefCxdZQMxcGv4=-23fRMM8TifPTuBCJcbKVw@mail.gmail.com>
 <e5ff8c1a-4f6e-42f3-9ff5-38dcee98cefd@linaro.org>
 <CAFEAcA_8uPM5rkRfqp3AKM5J6vkswAAuZDVTyiEs1J56jvzHug@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_8uPM5rkRfqp3AKM5J6vkswAAuZDVTyiEs1J56jvzHug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/29/25 18:35, Peter Maydell wrote:
> Compare the "FIXME" comment in the m68k elf_core_copy_regs(),
> and contrast the way our x86 code is explicitly
> putting some other value in orig_ax. Are these different
> kinds of orig_foo, or are we doing unnecessary work on
> x86, or missing something for arm and m68k?
I really don't know the answer to that one.
I'll put a fixme back here for now.


r~

