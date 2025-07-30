Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF68C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 06:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh00J-00031P-E9; Wed, 30 Jul 2025 02:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uh003-0002uU-Nv
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:09:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uh001-0007kk-8o
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:09:14 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-31f017262d9so2575145a91.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 23:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753855752; x=1754460552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hu5W31oVRaVj3n+KUItVSwkb7CdY33qAamuvJG03f3Q=;
 b=hX0/NbJPUm0AI++kEcVSs48Z3VetKPMiWMJW9LOY/sp7eQGbCGb4t53OoaYAn0F4z1
 4JYKxUEuGTotHnCW7zqffiM6xxYPbFyNncSaPR367TzMsaQLnB14c8yKDT+mMN5m2PAG
 X2cNr7uu2xEx+68GtsjAzUacbDWfP+QDXngbXPwc0KZU4mm0NyE9PR77RTsc47ndx3YK
 vJtwgEtj5AZ2nRzbA7M2utXu3c5TDoZqqTkqxoTXw1RyIQUrX2Xm6veKgjetHt3Eb7NP
 SkORedWN7i0JAIYmR7Qft3RRosi3o9LPOR/0OTghgfiPqueg6WZripF/iUr3DW8u/N9m
 E9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855752; x=1754460552;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hu5W31oVRaVj3n+KUItVSwkb7CdY33qAamuvJG03f3Q=;
 b=ffcS+6DrjagpdbDe6zM0SJ7Q8ZpP0w/9yfbURgRxBriwdZ73Q/6o5EoXB40t659l0s
 +x2vSLf5zoCkZjlzxj1tbT7i2kq+t5ufOzzZKh/eaIHmlEcxCbV6vMNwl/8F6UpkHoYY
 KwYTvF32lgiTiPowvYQ/S7lTMjdvB60kwgrQeyQUb3OLQFZVroZ3u8FS3se1gqcNj+so
 hQLekkSA1vfYwHdnhIHEThekyJdIlLODgj1+7WNMi7DSKHMwapb9j5HQXvz8JAGSsAA0
 k+oayF0LFUnc64OeI7QlAFFWX3zaLaeHMAzSBzQNehwMLYZfkYMyWo5R5fHZ4LDsuJu9
 YyQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUGVGKbsTwX8YLXCfQsjQCai7hl4+p0lUmltKtXN73HFxNd3clxq5EyO9VzAmF7d/OQn/I+C/E+/zS@nongnu.org
X-Gm-Message-State: AOJu0Yxq05BklhWXEIPXtjAxwDsv4dkBc4U+pdp/oGphxmMjWGG/Vrps
 Lyk9+kIh9XhQ3Q7AdfArEJCJm7tMNc7p9guSf5iSX72ms1EvzyBPC///XW3jSLvalrY=
X-Gm-Gg: ASbGncvRJMScwdQB0jPvx2WpSAtClrR4ADXMoZHm0+sEzLoDOIRFFGV8qyIEVYlOrui
 eBqHnuXfuboamj/T9blQ3diNR70JuYaBUVChfaB+UmuFBcPdkQec4Cut19hWFlQXtEenLLalU84
 y328xZFTZyEDCX5Uy5o9YM87nuzOxPwGBBT4PaHbo1zTMEBYYUsrP1tdFdFr4cxQwZ3h/H8stza
 0GLd4KSvUYHzlck/raVdLy8dWvS4hObjMS+Nb6JMcPUehuZiUYvurWyMRIJn8LMPxHH3dTu3UGN
 KpBNZJPALOqLQ86tj0f8SrwT2FWE/wc7piJmYzjiIZcPFoeK2zTnKuNDt9RBzfqGIPxjiIu5TVv
 AyFF2buLPue1W+lU9u7TfEqoZfk7k/N2oBGJpOFk06U5mXGw+l1TxhlEDa9T7qcqXDP0FSt9Kis
 9e2Q==
X-Google-Smtp-Source: AGHT+IFDcHhSGUoVNuWBFR09waKH2/WXe50Pg6DSRCAhrgQkRijA1hQGXpkCiu3dk8IyuOsnOqnJeQ==
X-Received: by 2002:a17:90b:4c48:b0:316:3972:b9d0 with SMTP id
 98e67ed59e1d1-31f5dc953d4mr3148987a91.0.1753855751709; 
 Tue, 29 Jul 2025 23:09:11 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63df3ccasm956555a91.23.2025.07.29.23.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 23:09:11 -0700 (PDT)
Message-ID: <30943042-e33a-4e87-9673-569da18065db@linaro.org>
Date: Tue, 29 Jul 2025 20:09:08 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] target/loongarch: Use MMUContext in
 get_physical_address()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030828.3426053-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030828.3426053-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 7/29/25 17:08, Bibo Mao wrote:
> With function get_physical_address(), parameter MMUContext is added
> and remove parameter address, prot and address.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        |  3 +--
>   target/loongarch/cpu_helper.c     | 32 ++++++++++++-------------------
>   target/loongarch/tcg/tlb_helper.c |  8 +++++---
>   3 files changed, 18 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

