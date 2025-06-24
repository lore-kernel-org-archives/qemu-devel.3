Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE34C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 22:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUC0y-0001nQ-OM; Tue, 24 Jun 2025 18:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUC0x-0001n0-2R
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:21:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUC0v-0007pV-FO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:21:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7490cb9a892so400491b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750803671; x=1751408471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2RtVo/99MxAe4lWx/LDKX+rRlYczxFUn8btimGsQ4E=;
 b=C3xt+MbnKEq+6oYzxbiiojfdff8cuvo2Ww2lEi4qFsfrfIqg6sDnjsFPwV2MGfpcFE
 NEMBQ27Rq6Wjb6F6xkB/b1zZfqy2Ac0//2qvG1ov77mqXLFL+vpZSHELimt1qfc+Fdy7
 y+i/MFIfrbTyyw08CHM23GHbFznPs36PkIV7G+ZAEmiNn+YzEdN105gEY2QoZw/zsuYU
 SZ1eNUJ6hl3eAil3a9Q76TnZnMc09d0Q/Uab8+vn5IeSLytXWNqSIecW49xHW5WnWJhE
 7/6s4Sy+Qi5Xi71eYsFuq36gEU2NttLwzraxIsDT4dzBJ8r+Q8vsVHsRbuAguwc7Ajqw
 TDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750803671; x=1751408471;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u2RtVo/99MxAe4lWx/LDKX+rRlYczxFUn8btimGsQ4E=;
 b=BrQA4IsFueoiaCbqiwksR0xNdApZhy8RRJEemmgHFFcAxNNxBeEjYzLsBG6dY0BEJD
 hz0pLayfxAYbhZc0dHzQpZgX54D8eaTE/G0YJeN11yxa4FUrRlwHjpYor5HvmfIi1KSQ
 iwnqZA8U9v1UBvo/KKrNdtF3T4IPX2wVgpsmtZaRRDmHVkANxMv5B9tSn+PzfumMvLbg
 UwEERaF+da+rhrUPYj9riLhGrNQreOQDjLI+O8h/9jqXFtV9DKmuMfbb2NO3TRK9EGiC
 RdRVqqmUB2R0pas28pQCRuOW8MxRAYIHUasCcOavL4axtg899omt5miWyoD+xlu/M0V7
 CtbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAxlX9ysGCLQF9oaXrdLwm6PT9bivd+nhrZXQTTMX3+y85YuuiBjZx7mwoCpXW99rovZqJWebQ9NPK@nongnu.org
X-Gm-Message-State: AOJu0Yzj5jNaqnBBXUY1ht76W3qd4Rhy1KR8Y8sDyBpwaKD5L9ZaS200
 PAeMGRR1H9kRViwjFrJi7O4rrhBKUR+u8xzf0aWx9ifOenlve/Ee+mxjvu3i9imxELI=
X-Gm-Gg: ASbGncuvkYhqoHCdD0RjGRHabv6UI1zqRqXzHz8zZErPjXVv+95M9AB/AevL70E2/Z0
 7aNn9N8Mc0pPje2Py3pAkmxsnzAE68ZBhKgn8jsIqkwC9HHquXJEcGH7y2+AZRL4Z5ViQE5rAAk
 Km/y+PtphcH5ax/RGXOwob+sBEbFdF0Sl6DZEL6DmxtNU4ranYVvAbKfJHrRwbdOFWafEwoDEgV
 Ty5bLdFsSYoW4/pIxlF/PNhX78YBO6TgYsnLIxxYJjfaixLbuKUVbczUm5INMOA2oovFOLDhCqP
 nv9mfF+PMuXRiWmQls/zPLHj7PxgA6Fee6PA3PgBo14Sv3Nu6k1YQypE0nK9FPOYoRkiYTokHcU
 =
X-Google-Smtp-Source: AGHT+IFjliYWPSupR8d6aFGX/0nRh1nlB+gmhH9bF1l1AjVDqO/HV1vav8pkx6SRNfQmoJx/yIPTWw==
X-Received: by 2002:a05:6a00:2ea3:b0:748:323f:ba21 with SMTP id
 d2e1a72fcca58-74ad446244dmr1120265b3a.1.1750803670655; 
 Tue, 24 Jun 2025 15:21:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8850081sm2896294b3a.108.2025.06.24.15.21.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 15:21:10 -0700 (PDT)
Message-ID: <9c403745-16f8-4a89-8369-ff36ac022acc@linaro.org>
Date: Tue, 24 Jun 2025 15:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] tcg/optimize: Introduce arg_const_val
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505202751.3510517-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 5/5/25 1:27 PM, Richard Henderson wrote:
> Use arg_const_val instead of direct access to the TempOptInfo val
> member.  Rename both val and is_const to catch all direct accesses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 78 ++++++++++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 37 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


