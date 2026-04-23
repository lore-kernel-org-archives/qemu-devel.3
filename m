Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB61F9937B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 11:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFsQz-0003p8-4j; Thu, 23 Apr 2026 07:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsQu-0003oi-Ea
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:41:25 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFsQs-0003af-NR
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 07:41:24 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b24fede2acso42418595ad.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 04:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776944481; x=1777549281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=21DY5Fy7XvfIF3Ys9J8NGPXpgRm3LUjiZSova9ugCAg=;
 b=LzdRolLcREA6c50fuzZa7oEQ2rqh+rS2fksyzMlb9mAkMqO0q6+NDXaKDQMmEDAdYl
 Kq76BxtLAzTIF3JWDPO5AXW1HpB2yE8qhqjEJLiAMuP47JcOWrvg41p1aLFyB7XNAEkk
 H4g4DIMjgR09EDwsRQLOm2KIJ3e6PyUPOc6e850LZvZjpfYlJU8MPT8v7b+IzZcFUX9X
 +CvPwGcZO59IpVjnoWD9IXDMo3RtwWvUdlpbOfd17DPE2bh7VfD8VSjqfXhjaRORWgkG
 COSeT7newfE6KU7wi5MSzBOY0luYkp/YYAAs6Xz2Zc/0TtbyrDjb3bPJZ3sfJssJ2gGN
 fQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776944481; x=1777549281;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=21DY5Fy7XvfIF3Ys9J8NGPXpgRm3LUjiZSova9ugCAg=;
 b=J3YelPrsxiBpdpInnaQh/e+ipvToT0cKq+G57zDK4kvqtTTCLHLTGkQZVtbJBxSBnG
 MM3OxrvN8UppX3cUauaPbF6WdKgLVsa70029d65QZvSuwxnqseMX1Xe+na3XCrRLnQcy
 vQcD0SImP04LOmFsxixqhFrA5iFvTGCxHuL4EdjiFmrIxwnQnDNCebsPCfCmoC3zNATu
 0ISvOLAj+oMHW+JBmi0fOsj6yilymYmYSymAQs0VAiHCxgAhkj4BUCaKFoOt/6yNLWLK
 OmAc6FcVKU6przP31X0/IDYZlj/PL/kjGU+oZWcnn6cTdtwHwUhRX++4uG4QVUCjF6No
 i2/g==
X-Forwarded-Encrypted: i=1;
 AFNElJ83OTZ5UFiJ6Jf8ADHnT11+cfc3AQLAKHU8kgNF+gz9Tac/WzVPBDxgo9nz+n7CfxuHPy4jyM8Yg1xS@nongnu.org
X-Gm-Message-State: AOJu0YyXJT56ro2aIudnNEk7fL8z+HNIJ1wmtEfPJUQAoXuhfX/tiB7U
 HC588MRptPvwIipffeBtabe+2YLXesSZhbp9hBierLl2WrlZ7kl8spsZ21/bNcU4H+M=
X-Gm-Gg: AeBDietC6bQIU5+AHxoax0+fV6l/LLPBpBqzo+N0aA2kWJvbC8eMYJsV47rVOSCzrne
 xGmJc8UA08deftLGO8CZ+h/H7GkZNzrsY8dpMxjeV6ZMgk1prV5ZuKWtn/o/97N0QRz5nvPz3Af
 SPMEXNlv9DdcsSEc/nOTRw2UvhtVZB3ujuxEBixubPjzNKntpWWfbAc+PJZCEeIn8etllGzzL5r
 pK0ZykH9S1HSrqbyfcH9R/LwRqPOUSV65EhLzXyf6C8a6dUHSBA1R2vdFYGGnhdiUlzPTXiY/4l
 YkN8H5atO0R5VMCKkmTI+e4sctm0HDHUz9aRsTF4O9u4QzMH3OUgL/EDSy1/QjONCPpRP/Rgfem
 AWZZggIQZQxLUnKeORvJUIFo0fYYQT6dL8g2eJLmemeoSaQLeecSOr69JwSqOi0IqmXMtD/hsJr
 YBCpWYx8BtHT05ZhGc50cJvMGA/hVxGYTio/B99GbPt+6LF5Py4w==
X-Received: by 2002:a17:903:3c24:b0:2b0:445a:8c7b with SMTP id
 d9443c01a7336-2b5f9edf973mr289251725ad.15.1776944480970; 
 Thu, 23 Apr 2026 04:41:20 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20695sm191328935ad.56.2026.04.23.04.41.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 04:41:20 -0700 (PDT)
Message-ID: <6fc61e19-dca0-4d76-8b8e-f8a81c1515bf@linaro.org>
Date: Thu, 23 Apr 2026 21:41:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] tcg: Include missing 'tcg/tcg-op-common.h' header in
 'tcg-op-mem.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260423100612.27278-1-philmd@linaro.org>
 <20260423100612.27278-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423100612.27278-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/23/26 20:06, Philippe Mathieu-Daudé wrote:
> "tcg-op-mem.h" uses methods declared in "tcg/tcg-op-common.h".
> Include the latter to avoid when including the former:
> 
>    include/tcg/tcg-op-mem.h:34:5: error: call to undeclared function 'tcg_gen_qemu_ld_i32_chk'
>     34 |     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>        |     ^
> 
>    $ git grep -w tcg_gen_qemu_ld_i32_chk
>    include/tcg/tcg-op-common.h:328:void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
>    include/tcg/tcg-op-mem.h:35:    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
>    tcg/tcg-op-ldst.c:286:void tcg_gen_qemu_ld_i32_chk(TCGv_i32 val, TCGTemp *addr, TCGArg idx,
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 69cdc5babf9 ("include/tcg/tcg-op: extract memory operations to tcg-op-mem.h")

Pardon?  This isn't in master.

I recall this is one of Pierrick's patches, but we should fix it before committing.


r~

