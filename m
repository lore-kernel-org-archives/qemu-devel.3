Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75BBC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaN9-0005pj-Of; Fri, 26 Jan 2024 23:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaN3-0005jJ-Gi
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:32:46 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaN1-0006dj-Eh
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:32:45 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ddc1b30458so1319437b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329962; x=1706934762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpcZbpxYzsftSGS3IhizKTdpzgFfdx0nNcivBFLn568=;
 b=GOFH5a2nTjNoDG1oBMoGBeL87IT+LwnOQvWejYWjZA0AwT5DnLuT63TkY8tPMQwlna
 gXICqs7PnhyiX4++nSxnh/OZqfo1FYKems8Ft4D3aImFAC3gnOiukZQt/+haxaYrGvl5
 wmDiUFkVYsxJH0LR5M4UzbphoNdO6hTcbVEp+BSn47N5kHWorydDqdQWrgP6FxYuTfoI
 dt1IKcG0vaXtRyvU7HbDca4hoFbolRNHOHafv9SVpI3M8LOinz1EIYgodlda/7vPGyY9
 FIKL4kt7BJeQNBVOM/kpYusBpOXJfU01OVpVZfOi/4wCtN8xkeCIzkwIGEBuvcEDG6Xi
 v30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329962; x=1706934762;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpcZbpxYzsftSGS3IhizKTdpzgFfdx0nNcivBFLn568=;
 b=w8QXKgzjJduseQcSInq2rRGL4FUB2wK278XSf1xigQrx4K1MZqfaRyMM/olbvW9hPW
 2oR9uNOeyC9uPnDMchW/C6gd+tQzG1iLh3Q1pQJz60DjZBQF+jhoPfE8N+u5lyZA66pC
 IIGiDAMtNji9gfMUqc0MDGaVcU2ab9rcvPRvriMDj13ytO2C+HDcBLIFYxB1oFlrA9Bo
 +93xT2CtcyFJGbHlz+2FJ2OqvNaAkcHcguUCxBwX1gwX3QVktIIULamI8alDZoC8VNxV
 iyWoOGqLhBLwrOxagCaweScreJmKmAY4eyhV4OMeIMNDYGehWgFaMFLMmm4yFOuMCQjr
 EFGg==
X-Gm-Message-State: AOJu0YzB+WB8zqYsyJ1WGwXQGPoEzcay0ScinF8iOaGdxqXKNY96IQmo
 7kwuT70Q/m+FALFIy6qcRYLZcrFKWgMz95QmwninOfANNmVO4+ha7hkU4pRkikM=
X-Google-Smtp-Source: AGHT+IGQJJjC006wbCQ/854m722vZVLJ2hno75TBkDlRv2wj7d0EzMXW8ilopMFNcEtnqjaqxRcBxA==
X-Received: by 2002:a05:6a00:1f11:b0:6d9:b267:5d68 with SMTP id
 be17-20020a056a001f1100b006d9b2675d68mr971408pfb.22.1706329962054; 
 Fri, 26 Jan 2024 20:32:42 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a056a00179800b006d9a6a9992dsm1864732pfg.123.2024.01.26.20.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:32:41 -0800 (PST)
Message-ID: <2610f0e8-2096-4c80-99a0-78f97a662f0f@linaro.org>
Date: Sat, 27 Jan 2024 14:32:39 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/23] target/m68k: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/m68k/cpu.c       | 30 ++++++++++--------------------
>   target/m68k/gdbstub.c   |  6 ++----
>   target/m68k/helper.c    |  3 +--
>   target/m68k/m68k-semi.c |  6 ++----
>   target/m68k/op_helper.c | 11 +++--------
>   target/m68k/translate.c |  3 +--
>   6 files changed, 19 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

