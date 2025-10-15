Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54B8CCD193
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 20:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v98R6-0003SH-N5; Wed, 15 Oct 2025 16:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98R4-0003Rl-IS
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:49:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v98R2-0005vb-IB
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 16:49:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ee12a63af1so16339f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 13:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760561361; x=1761166161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3fcsMmUg68iaBzAiKcvZOSVWTZmzAtvjqas+XdxAfe4=;
 b=xGgNLLYZTjWRxi39ed5vIHYEWHWRd4onwaek3ZrDvQWaFwc3mb5jU9BTVzlc2+qtyy
 wgnkaiaAaA/FQCJtpd805IbV9O+72H+DzNZWFITiDxP9Whcjn1XZ3655GRpBJMGZQxyN
 taXCNmrAabo1Wp1/iWs6fzCfOnUY1VIZmb5quR+3w5vFH+deRuTy9Zyjq09VMCTKUT+F
 VohdGSobIrBpC4WWZVHc8yDiNGVgtsPxfsRAGYGqC0OHlpVaoYV6Ki68CbKNggVQ/Pz/
 X9f1SRDQ73Shry9hkf1LIM3hr7gFHN9wrNffnSchuFyMKs7L/fQ/MLM6KSLolkUyhc0o
 /gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760561361; x=1761166161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fcsMmUg68iaBzAiKcvZOSVWTZmzAtvjqas+XdxAfe4=;
 b=Y5mOZAcjzIyvnIfqwzO7aXIWKh9//bVzqqoQPoe6n1GZUk75z/wE1JAxUQENe+yBQr
 vh2U/MVw4LxUKYVggyhCQPHGTgj9u2l/b+YAlUNFM8es/QdU/xLVeB8ZD6PdglR/dSd/
 qgf8h0eGqQdioeqAK2u3hG/S+OssL8tdiBt+ZnbFSUL1+htvnzx4p1bCFyqoWpKcrkzp
 AC5RfqY4qV2oD+kHmjFHOJabQwO8Fuj/PdDsH8YLD3ahqq0Aq83PdwdOdEMPpRL7yw72
 FfhE+6FhchisXRagbecJAxYG2WVaPjWKgCW5M6yEUqb30/59WPcYEOKy1Snui3pa0nqH
 JIgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0PWEd/R1mTFtlVglMqEuo2a9t7rgIA5p65NYGSkhMoJFxpCWszvvL9vQLtHUVGyCAff/vtRsvdxY2@nongnu.org
X-Gm-Message-State: AOJu0YwJN8oTDhFQao6p/Gqf0AunJl25FbzcY08L4TMmAz7RyaWVxVBk
 QmFIuPd9jU1WtdR9pxp+O4gyiF3kl0q273CML2YpSxU+wYBDS+bY5BaNZaGxXCLuRRc=
X-Gm-Gg: ASbGncvOOXAi//VmwqbbylVcAx4afb4Am1Ujsi9QL9k9gezz5oVim1Os0vba5WLayA0
 uaNeBMGt8ZAf7EchdScWGDOaIQZs5DludNSVR7haEh6wLatrovo9XeNUXiDZHlnaV8tiQ9s/TkZ
 XGgoKXzGq5o7YelEy8Sy+9v/X2cLiexOwOF6zC5lZI5fIn6b5PRNGfZ7rxZPh4TW+9VruMi6aiz
 vLKhh3d3gz4soYlpBFvs/fnKYiPK0JE0B+sS4w03jt16DouZf0jyJXIvLcwPz/Fke/6Yhmg3K3b
 7ZDQ+QH988eRoxDIibWL7berGfFQUq4CuotauppF8GHXtgSc1Zx/3iFkrlylYE1Klk3bBNTwPuZ
 td1U+V2NdwxOLrWQ5K86xc65qzVWdM9qRAsiMI1eEsFQg6wNxOfL90GgUIhPrFwpYpKjAplAe9y
 TZdJXp2aTAF+peXdFrYeKG9uQ=
X-Google-Smtp-Source: AGHT+IEw3dYcVd9QKYg1Q7/SLx7pOWnlUMmE/K5OvAvP5TRvrPDWuS+hQDaBqbPmh5XVwjkOeidH7A==
X-Received: by 2002:a05:6000:40ca:b0:426:ea7b:8043 with SMTP id
 ffacd0b85a97d-426ea7b856amr6265257f8f.52.1760561361282; 
 Wed, 15 Oct 2025 13:49:21 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm16699415f8f.38.2025.10.15.13.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 13:49:20 -0700 (PDT)
Message-ID: <aceb0e08-bb3a-4a6f-a9bc-23fb81da6a81@linaro.org>
Date: Wed, 15 Oct 2025 22:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/34] target/riscv: Move CSR declarations to separate
 csr.h header
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-33-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014203512.26282-33-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 14/10/25 22:35, Anton Johansson wrote:
> Most of these definitions save riscv_csrr, riscv_csrrw, riscv_csr_read,
> riscv_csr_write are only used in target/.  Move declarations to a
> separate headers which will soon be made internal to target/.
> 
> csr.h is temporarily included from cpu.h to not break includes from
> outside target/, this include will be removed in the following commit.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/riscv/cpu.h            | 82 +-----------------------------
>   target/riscv/csr.h            | 94 +++++++++++++++++++++++++++++++++++
>   target/riscv/cpu.c            |  1 +
>   target/riscv/csr.c            |  1 +
>   target/riscv/gdbstub.c        |  1 +
>   target/riscv/kvm/kvm-cpu.c    |  1 +
>   target/riscv/op_helper.c      |  1 +
>   target/riscv/riscv-qmp-cmds.c |  1 +
>   target/riscv/th_csr.c         |  1 +
>   9 files changed, 102 insertions(+), 81 deletions(-)
>   create mode 100644 target/riscv/csr.h


> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 1934f919c0..f8d3bc0df1 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -20,6 +20,7 @@
>   #include "exec/gdbstub.h"
>   #include "gdbstub/helpers.h"
>   #include "cpu.h"
> +#include "csr.h"

   #include "target/riscv/csr.h"

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


