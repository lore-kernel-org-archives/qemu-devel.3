Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB479CED241
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxv7D-0000gC-CN; Mon, 07 Oct 2024 17:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv72-0000UV-TB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:17:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxv71-00017T-Dw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:17:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20b5affde14so36549715ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728335870; x=1728940670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fEczIr49pHVDmhTYxLG19feKRvTV2OhUJFNmzSuMIOA=;
 b=BQ7OWvVcM4+FscqGgRgzPaCreYPL840tYopWHyiOAZcIJpTvYI6uy9eDyp1Ms0OYAl
 /PTKZO5KEOK9Z7I9MhCu5T3VfLf5ncbb9HJKlyChGjFKg3R9tpK1MYsBSH1g5WNVd3Xl
 qf2xo2KTDSL8rDxHJ3+Cv83COLY4FGzKR80Q5RhEBSH0ab1370G6RN1hQ1iQByrv197i
 fmgbOxIRhfZH5yOFNOGc1MigUqNeuGH8NFY0kK7UPah7RgxB5FX+axrE1wZtBZCtt3Cq
 dCKQlihWwTp0o94/aki5qn4zb3aUwXy4jrX/GbZm0DtFgS7W+aRNUIvn4GuWmvTiTS4r
 Te9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728335870; x=1728940670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fEczIr49pHVDmhTYxLG19feKRvTV2OhUJFNmzSuMIOA=;
 b=cHs/gHI4SIbKql2ZuQzMEk89VOjNVGlbDfMgQo9KEdfQiOWJ9V/kKVgnoapRRz38z0
 kE7g0HEqH2wiuFvcp+0caPIoIsx4skTTZdnFpv/wXRziMFI6J3ayTkKGHChshgo1euoj
 iO3b2gQoLVAKPSnSH4zoewLVF/A5nrNnWOGZ5WraLW1WemHRfOu/uZCA0KhDiRCDfcD2
 slb4ajgT5tboof47GrxHINAQdrvHZDo4ebyNXnd+cQvlho7xwMNdsTEu1iCmKsVjoKBL
 gKn6RrXm2SuTvGHXeoI7Z9PQRx+Vnm0dVlnKPJ82PdT6GZJM83qWch5nDuqvJlVPNbQi
 dAlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmV/5SI58+EohfbgH7EsFuIVtbZ07+vn4hB+jOhiSwTKuEfoqNqLL87sadOV3dMazggeMy8WI9nk3T@nongnu.org
X-Gm-Message-State: AOJu0YxjJcd/seLpA7W2RH+GSHghoEHk0QrPBuz57KATmOaLhJMzVlRz
 beMCC1+kMZZKNtkJ34cBq2OU4UUn2yGBmQyPs/qdmr3h3d9MZ4p5sUXWs6UYdgE=
X-Google-Smtp-Source: AGHT+IF+iFo3nBQNt0M8YZHcNiHTBYDMbNha0m/y303BWu+LZ6fyagZobPptPmMv/9P7CxHL+SpzJA==
X-Received: by 2002:a17:902:f691:b0:20b:af36:eb3 with SMTP id
 d9443c01a7336-20bff047d4fmr190816015ad.40.1728335869923; 
 Mon, 07 Oct 2024 14:17:49 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13989814sm43541095ad.269.2024.10.07.14.17.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:17:49 -0700 (PDT)
Message-ID: <5c98fb68-df29-43e4-a759-a4b8f9a6bf0e@linaro.org>
Date: Mon, 7 Oct 2024 18:17:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] include/exec/memop: Move get_alignment_bits from
 tcg.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> This function is specific to MemOp, not TCG in general.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memop.h | 23 +++++++++++++++++++++++
>   include/tcg/tcg.h    | 23 -----------------------
>   2 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


