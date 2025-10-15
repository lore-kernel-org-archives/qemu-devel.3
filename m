Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DF8CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96A1-0007yS-Fe; Wed, 15 Oct 2025 14:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v969y-0007xA-Jc
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:23:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v969m-0001bv-Cf
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:23:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-330469eb750so8688957a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760552602; x=1761157402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hbitwHwtYXho+UK9WPfLlPmwjk8FV+3XRRCwzWLXGfU=;
 b=IJDE9AfDP1N2ERMpT/5/E4EDuNpWIhFlUZy0HT1izLvNJQIxNC949sSxlhUELXzk1k
 EKBE/HDIzn737XEN+dYAL20S+9MoYuTnG5DHMd55GK1PG4N9B1ufXGPe/KRtNT9SWltn
 Mrdo5uLEdLU+wgAUlgJkDhGKUSjWn/KMUYbs7xApzEw1sPqN9c2GE7XgUTMOy6Ic+p6f
 0rQF14Zr0biGT43TWgBfOTeZ58aIYUpD22TZxrtdFZLvyTCSrNryOHA2tMeBnn20Zdw9
 iwQW1QtINZxxwWIXh5mAruAikjHa8lDOF6ugKwJImpdRrTh/heidKC2Vq1F35NNNRYrL
 5SlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760552602; x=1761157402;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hbitwHwtYXho+UK9WPfLlPmwjk8FV+3XRRCwzWLXGfU=;
 b=awtblHPEGrq2xuiTuahlk9J3CMt9ENhylrOtzEwOmWqCsZh05uAbQzdDVnC/1wKmFg
 02jvdqSFiwHSJWuBcQywtHTkm7tm3l8LH+y2vQaJbB0MdESS/9NQzbCwGnQco1WmXqFl
 8hNb/qa5oCbTs1I89NXXV76VN6U960bx9OWZU8/KM6Y2ZtExEIhq/bIsWNYm24TbY9KT
 BhGRlO1Y3npx4LhpUL+tUl7sKoFCHRFe4CCf7MGdQOc7l+k7WV1rbzcD2pOf96XaFeEF
 8/8jG+qh5fFQop9/vlPLcnLX53VqqVxhRoUebjGDnIK1HDVwnERFiqoOwNzR/0aPnnV4
 pRiw==
X-Gm-Message-State: AOJu0YzIZclxuHfe42GBT/Vy8fTAEQWAR9moaBVUUh/XXFawbHzGtMYb
 Aw9xGaNWt9aXv86ijG5+NHUfVzpnROKUYOuJ4VMltmzatiiObOaR2iac7BJ4eY/ynoIGg3fkh6G
 Rvze33Bc=
X-Gm-Gg: ASbGnctzN/i/ONb0o10mpqtJk6DPfCL6elk5ftMTotWuss+ZuIYwGo+3pjeWPY9o6Sq
 QXymjvGUjReSUIZZN1ID2rv+wBPAHpXHKTTTH74YpKBqjJWoqDgt8tL83+ei4ALKuJxfptzNYSl
 6kSck6DRmlKWVHWSleVxjzhaQwIoEQjfKB7+kI7BcPk+eikGnzgC0hYzt4pZLU+fVgYO+eZyPGD
 2lyjCkkpdK2CgKYujU1fmfTwuadTm6kEf/SDwLGZO0PFwwP5CjV66fhkNVnKxEtqdvfuIKKCjXl
 EnoZqRDGXmaCxN5MNyLX07sC3m1X4zFry9w1uQEGc3NCg3FhkmLDtkFn7nAnRRvLo9PRDSDu50K
 n3aGLFzv8X7iBf9OF2Tn36E4LAWUwhdFBSwLBPHI8fduFz2fmu+O6LgjUga7y5qIcnMLnXA==
X-Google-Smtp-Source: AGHT+IFO20uGC21XXwIWp8DRMWV3rzgHZgwPxz75lKVbo+JaJXjKXBLqCYRQNYJypqGEiW7k8o0j1A==
X-Received: by 2002:a17:90a:e7d2:b0:332:8133:b377 with SMTP id
 98e67ed59e1d1-33b51119058mr43036473a91.15.1760552601548; 
 Wed, 15 Oct 2025 11:23:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33ba86b9f13sm77629a91.15.2025.10.15.11.23.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 11:23:21 -0700 (PDT)
Message-ID: <c5b8c67d-0694-43e9-96ec-eebbecc8b24a@linaro.org>
Date: Wed, 15 Oct 2025 11:23:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] target/microblaze: Remove target_ulong use in
 helper_stackprot()
To: qemu-devel@nongnu.org
References: <20251015180115.97493-1-philmd@linaro.org>
 <20251015180115.97493-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251015180115.97493-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/15/25 11:01, Philippe Mathieu-Daudé wrote:
> Since commit 36a9529e60e ("target/microblaze: Simplify
> compute_ldst_addr_type{a,b}"), helper_stackprot() takes
> a TCGv_i32 argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Anton Johansson<anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/microblaze/helper.h    | 2 +-
>   target/microblaze/op_helper.c | 4 ++--
>   target/microblaze/translate.c | 4 ++--
>   3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

