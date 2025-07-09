Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C3EC83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 13:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZVAB-0004nn-67; Wed, 09 Jul 2025 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZVA9-0004n2-Oe
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:48:42 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZVA8-0005e2-6z
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 09:48:41 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-73ce7b40d7aso310542a34.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752068917; x=1752673717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VE42BoWHx3azFelddDoVoUa15MHCuSUyGX50d3xnUaM=;
 b=GLOYkcTABwWtVxuEYo4tmMFEMDtlKffrorAE5rymzKfUAbhMbg4NVblz77pKwLzSuD
 ZnocvUKVfML2oVMiVAuX6ZLZakNyiRaFajiUQRjOr1LM0OSZ7KACX+TghqTVNqQtch0v
 VoZERf6ULduvp9D8ia2KQTG5Ujtdx5/PKSYhoqfQMiFz5pZbstcAE3b+EhEvMdxhOhdd
 IjKQ9YgbNYpoFPaS9eM/X0uKaVpj0abQWLNgZGrnQAIIqZ5/LGOqMQxf29nSEeKhEL/8
 EDaqbRDnl/nnQmYCHmmZ/PDx/DXAyFd5GbL68/FsPoXKkwRKNL2pZ4+RJNORFG7qU3E9
 xILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752068917; x=1752673717;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VE42BoWHx3azFelddDoVoUa15MHCuSUyGX50d3xnUaM=;
 b=R6XxjThMyLZhfsqjKziFaXgnLQZ/715jIdhDmCF/Y1BmykOCdeRUj0L0sUptldUKGR
 1FlS3fsaUxqp/X+3+/x4GUEkM6PN3Z0iwrHQcWcXHW18dWEkPicBy7er/1bYicMoWLac
 f8+6KnFzqt4RGYHXOfgzd44aQ+6CbptmRasK2f+KhyHV1wYQXJxh2yPVZSoYqkzaUWNj
 zHxwwlTi2K/g+YVlSOG8ZAEi+hJFRVZtkKWnUIwSAYGuKesomP5juLCPRGld7ZPr36Z7
 Uz0tSd/sBx9az73iIr8JLpqEYbC4sQmRJUFOeWJF+hYgR7BjjR3oxJeoEPHf2TY72KYg
 XpsQ==
X-Gm-Message-State: AOJu0Ywgkjfwk1UwjqzJro94+Y4xbA1MvcuCPrbgqMsr7QpzKtcDnzbu
 Nuf9fv1CUUk7E4ukE8nE0EXw3AC5djIHCiw0Nh1cuEytUvFqWqDL6wKyEVDf15+lwJpq59CuZZD
 OYSFm
X-Gm-Gg: ASbGnctChRUAxcJxOA44WNgJlOo/JeDs9V8mZmHL2VDFrDTghp92ViAaPYDUw8zIgvq
 PQVqizLiS5/0eRRreL4LWIz4RJUEEMJfx3n6ThN+bLbY5qj2XP6yoNQCJbVnqVY9SdtJC7tlpnc
 5mzympQJKpTlkAfxqLIN9Yomo4tOiWyyU+k+qEY40uCYK8G4b3CPyQ1VTCKJRn2oVrUsHU31JZO
 8pzIV4MaR1M/+Q0wTnqPFO3PxlrxnJV6nKf1n30dP8AtTJ0/kjo2077aX/sOlFnHmWI9UsQxIVd
 hOg1ZDTj7seKHgMIbqsk+ASXNI75IKjH+S8THCCLsnQB06cUhwUYAkievSo8wOZAmh/1bi5HPUY
 XKzXCEOGqqEcWfQ==
X-Google-Smtp-Source: AGHT+IG5effbUd14vQ6hTaTQoGfFOzOuUcrmawyLn3efF5LQm1o25Pgb0NrT3p7+dqUyWJE4JEuyCw==
X-Received: by 2002:a05:6830:3688:b0:73a:8a05:cd3d with SMTP id
 46e09a7af769-73cd7774ca3mr5387225a34.0.1752068917606; 
 Wed, 09 Jul 2025 06:48:37 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f7902716d9sm3450910fac.40.2025.07.09.06.48.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:48:37 -0700 (PDT)
Message-ID: <a3d766b3-6567-4d7b-9656-7e3d6f3bea94@linaro.org>
Date: Wed, 9 Jul 2025 07:48:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/intc/arm_gicv3_kvm: Drop DPRINTF macro
To: qemu-devel@nongnu.org
References: <20250708115238.667050-1-peter.maydell@linaro.org>
 <20250708115238.667050-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708115238.667050-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 7/8/25 05:52, Peter Maydell wrote:
> We don't generally like DPRINTF debug macros, preferring tracepoints.
> In this case the macro is used in only three places (reset, realize,
> and in the unlikely event the host kernel doesn't have GICv3 register
> access support). These don't seem worth converting to tracepoints,
> so simply delete the macro and its uses.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> If anybody needs to debug this code they can add useful tracepoints
> at that point. I don't think these DPRINTFs will help at all.
> ---
>   hw/intc/arm_gicv3_kvm.c | 13 -------------
>   1 file changed, 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

