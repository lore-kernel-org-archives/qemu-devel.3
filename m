Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C53CC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 07:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7r5u-0004gf-Ve; Thu, 24 Apr 2025 03:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7r5s-0004dT-N0
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:34:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7r5r-00050h-2v
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 03:34:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso3971545e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745480037; x=1746084837; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tSgDAThLi1NjyHe2CMmGioc8fHJkxyEm9ENg263Z14Y=;
 b=S9kXSzBhI/z+7NBJioy7yebDniJyH1ryxDO53x5PMEiQJW0zvZOcCR8cv0BZm5gswa
 mDYc14vI0bHVktJPFF8acihAw5wm7bOSX1ePelZI5TAY8YalwmtYMwcmUm5EgyJziXLY
 dNpbaZ1oy3A2fvpGxBhl6Dz0pHtZ2diNZXAk7o91y1ZcpRKc3AbyOdUzr6tSZLmH6Y/V
 zoS+1dTEC0KiZBZPzWhHTGl2XIX76bCd2r3e8N4SmrhxZzheLGvR0kwRPkI0zBJ2kRV1
 V42uCyYPbviJhdEwdOaiwZosPSssz++8W5ZQcyjt9upUU+M99SzL8zKTWMrlKWA/9mV7
 mMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745480037; x=1746084837;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tSgDAThLi1NjyHe2CMmGioc8fHJkxyEm9ENg263Z14Y=;
 b=QuCzxtpzRar3mX2W8pgyhI7fAerKhu8qWi1flYuUxcIRAKNJ2AYZrHyyGk5tQcQl5X
 YA81G7eCBk7Q7J/4H3LIe0QmnK/RGifz9Y4s14v6XVLwCFEqmgReWBp2ZttukKlwfmXB
 mV8qcafIJRmaKmmR1zR40Hv8TNzg0L6HUIEZRlFNVLGdmHynaHY+kjYM3WRwYJZmoLiu
 /xxF5nQftKao0MC0vZAfywDlWGhmkrXtAog6VQotEvRbixcpR+kwqmf6TQELCaIcrtVM
 16iBwNJhjrA9cmJrvb1fjSj0fpcIkdJa3P29SWgf7ZX2wKO6shRY4aE/PevQjY5/krHo
 G9Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2yRFZaHNjXh1eDUyq4S43d/oX8guljGl5HAAu5Te+y8aWqIVKckAp9a8o+UjHQWsyE5FCDPya3cyP@nongnu.org
X-Gm-Message-State: AOJu0YxhxXRu0lrCJ/TMDQ/XTcgVtTg+zwWjagZXIclLJWrrUGLJv93B
 w2zJMauCVRh5LITpeqnvtwmTHrMJ8nsTOeKuFXnH8w0YSmNHKIj8KopfyBJMNqo=
X-Gm-Gg: ASbGncutzWpHLuBydxhQ3B4tzOnTj4aUFkCPV4ipQyOL8uC3/HNpl99xQ40BdwIHefM
 ZQxnzow4sBPYaCo8DKBaJyIPEeUMZ3/hNBko3vh7IHn+ONkKT4odVloL1BczNIqy8dN5XmD8dHj
 XHgZoTYMopNj/fSoEOXiOjfQtyNWATQfcsdghVcRwgZSDuEIAfKIGy8PEw3mfm3aOkapK0C9YBP
 bGqnByHHu/cLuSKeypaoAF6u/F9ZxDOS4UXwr7+0DnN55YlAdjVa1GDQS2AsYDlH4/8bfEuTZVI
 RAqvKGq7HuF0dKFzBVLDCfR4x/NIz0dw6yurxyqL60TbtVs4X6ftEoTXcxVcB4l1h3Df3/TtLIY
 r59f/CZKMSD0kCg==
X-Google-Smtp-Source: AGHT+IGkDpTz4/Y4hjbVki6K8hC7K/JQ5r676VVYQSwuZHsCHUGmFUR+Y0AS5IK2tS43j/8FLsgptA==
X-Received: by 2002:a05:600c:4f4f:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-4409bd18939mr12061915e9.12.1745480037201; 
 Thu, 24 Apr 2025 00:33:57 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29bf8fsm9422595e9.1.2025.04.24.00.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 00:33:56 -0700 (PDT)
Message-ID: <d48bfcaa-5d98-41cf-9ab0-829ba5f8bdd7@linaro.org>
Date: Thu, 24 Apr 2025 09:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] include/exec: Move tb_invalidate_phys_range to
 translation-block.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/exec-all.h          | 4 ----
>   include/exec/translation-block.h | 4 ++++
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 24383b6aba..90986152df 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -120,10 +120,6 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>   #endif /* !CONFIG_USER_ONLY */
>   #endif /* CONFIG_TCG */
>   
> -/* TranslationBlock invalidate API */
> -void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
> -                              tb_page_addr_t last);
> -
>   #if !defined(CONFIG_USER_ONLY)

We don't need to include "exec/translation-block.h" anymore, please 
remove it.

