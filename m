Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C206EC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUipF-0000CO-Iz; Tue, 30 Jan 2024 02:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUip9-0000AV-VD
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:46:29 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rUip5-0005Pq-S4
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:46:26 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5102a877d50so3786412e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706600782; x=1707205582; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pLCk1x2NqjuwUJCTuMgcYdr6vMLmCmpL4zLCwESvIQA=;
 b=WVDT/nQTnnipGfgmh13vmfYX6P8h20fANlv88eMja9/Nw1rLTMQZcjd23N3kmCG1hj
 MQ0CrGUTvQFzibwt+028852Mg2pbYJkCG+4ZGrCpcvp9hQKZ+FcJ8Wh3J1XE89oTm63v
 d+LotZP8GIUefBFDbd35pYg+EUnFgRrS2AFK4m7n/kpw4wGwoxxvcGH71REIJDERXk80
 yBMX0tt1/jQwfB2x3PC4Iuh//duduyU4UpxtHt82WQMthMNC1c3fBU5O4bw3jsEiu0eM
 j2p+VN9XvQ/EDdHZqzKI7czIgXhHnbjStpMn0GwZYUU0BilOOdnVL//4n7JmmsKUFYAY
 kZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706600782; x=1707205582;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pLCk1x2NqjuwUJCTuMgcYdr6vMLmCmpL4zLCwESvIQA=;
 b=cfC8HDdGzlgE9nJ084CCpdrFmTFxfyLUmReuNu91jj6BqrcTWMYDE2JgyjnUaeVcxv
 uHXzl15wl6KCRWd/1lbQalc6LgMOofJX0TTG7vFDTTgXreAkZvEdjubmujREziCkt99U
 +eAuyQC9DVEWLi0ugpHFkPmNfO4oGvglONVEaQIEe0RdfR3gtP3mhCSY0NbkD/O2r1SS
 M926Cp1TrBqffgOzKc1gbUYZSwDtsG5HdjT92GqI4e8QrprzSgAZ8e2FsyN155gbNsnV
 UPcKzyRm6KTHqvB/uQXnoeO8xctngF54uItzRrmfpNgS60p0FCrEAeaQuPv/4Hw76js5
 /f0Q==
X-Gm-Message-State: AOJu0YyOhJnrajorNmhobnyRbHB8byMDDgjKUUGs8yOznsdJ6RDShO2C
 f+ORWELl3JF0LFArt9UXIxHuF0t/qhlW50gp1UeJhmkhnUyR9IbaShU74qTJJaE=
X-Google-Smtp-Source: AGHT+IEDxLGU8zLNKuKfpVmnKpVbBRkSWhKgxIUCPocx491ZR73d8Pck4/v2HKAym0jpXYAUjYGRew==
X-Received: by 2002:ac2:53b0:0:b0:510:cf0:7b8 with SMTP id
 j16-20020ac253b0000000b005100cf007b8mr4438287lfh.36.1706600781944; 
 Mon, 29 Jan 2024 23:46:21 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.134])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a05600c475200b0040e9f7308f4sm12261110wmo.10.2024.01.29.23.46.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 23:46:21 -0800 (PST)
Message-ID: <238c5053-47d2-42c2-a012-5a88f318e290@linaro.org>
Date: Tue, 30 Jan 2024 08:46:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] include/hw/core: Add mmu_index to CPUClass
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240129233043.34558-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

On 30/1/24 00:30, Richard Henderson wrote:
> To be used after all targets have populated the hook.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 2c284d6397..4385ce54c9 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -103,6 +103,8 @@ struct SysemuCPUOps;
>    * @parse_features: Callback to parse command line arguments.
>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
>    * @has_work: Callback for checking if there is work to do.
> + * @mmu_index: Callback for choosing softmmu mmu index;
> + *       may be used internally by memory_rw_debug without TCG.
>    * @memory_rw_debug: Callback for GDB memory access.
>    * @dump_state: Callback for dumping state.
>    * @query_cpu_fast:
> @@ -150,6 +152,7 @@ struct CPUClass {
>       void (*parse_features)(const char *typename, char *str, Error **errp);
>   
>       bool (*has_work)(CPUState *cpu);
> +    int (*mmu_index)(CPUState *cpu, bool ifetch);

Can the index ever be negative?

Would it be useful to also have a mmu_index_max() so we could
check mmu_index() is in range in the final cpu_mmu_index()?

>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                              uint8_t *buf, int len, bool is_write);
>       void (*dump_state)(CPUState *cpu, FILE *, int flags);


