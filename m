Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFDCC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 18:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZwBj-0006cI-W6; Thu, 10 Jul 2025 14:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvXN-0003hc-Ax
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:58:39 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZvXK-0005pT-6s
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 13:58:25 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2ea65f5a0easo894119fac.1
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752170292; x=1752775092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Ukm5CD6xYz/03rckvlKVObmuaG1Y9I4P+4Q6jNXL38=;
 b=i+z3QuvaWVI9e//Gqh48+hWTLK9j9Ta88AqbC2xF+ZD/pZGx/IBbyCGCTuL0L3cIvy
 HLXfU9QiWwvJpPaAEw2qaVflYWtc0B5uLheBkg38Sw9UWs1SoC9AAJRe89nsh5tpYpAI
 dfr6noNMJAXGcB2TepJrZe4OmO6PTFASi155BZ/bUOz2gqcx++RFsKe06Ugj5ZMCaEd2
 3ZF7J6UIyUqxTaSHlRSmUfio/0m0KHFGjCDqc8trPSd8iLyxaMNkLW0Bb6BRfoMUh5wP
 BSlKGuxLfV1W97/x8tKmdQ/qUrO3UKIU8008YpOPyzt4tYe2rhmLjNOMV9QJNHd55A9K
 KQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752170292; x=1752775092;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Ukm5CD6xYz/03rckvlKVObmuaG1Y9I4P+4Q6jNXL38=;
 b=ZX+kcksWZD+4oto+IvoNHpARsW0g7EBDFnGMk9P9aWPUjQKCwy0eNgyxDTrul/Fje1
 4apcdgou+kmSP70w36+uRCEXNIMG+LYoL6cXGGBv65ETmM9auFGJg+0jmh8Ps5O0ZQI6
 hXD9764GM/PeyM05wwsaHKT+PkYOBheJcIvksQ6nW3CqdRiuR9TY7ujmxyUU7lEdBUgF
 LCIaP+pC+MocKY7yybjJX7X6nznG4Qb0IvE+oHQ8Z+gj7vrMQd77UiZpTEn1BpaxlEIs
 wdlOorc5TpUIFAfSmbVccj774jskWeGDphhjuTMj0MiLui3l9oVWUJ9gcJ1QrQXjW+Bs
 pjKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbBUduEBhcjrPfkGHRnAPZQIkCroD+/gQldVmcCvqMokNRq5+y6lpVbyeXWaW6GaLVtHvEjIYyeXrK@nongnu.org
X-Gm-Message-State: AOJu0YzKJ5Z961rySITETx0slpmwAG/hYl7yPk6h4bppIE5M0zPNwQfM
 P0kaL+RedlTDILxgZoRiijbnGlle3fxFOZUxSd8lxYodbTDx3O5Mn0+aQCwdnDBIioPSJ0AU4xA
 10pnxdGI=
X-Gm-Gg: ASbGncv9IIXm3z932hGf2Xq+BkCAASBrPrMRjUaC7q414zmc4qv+Ojem8KfPtUrS6V8
 JApTWj7e9bGXJjDA67eN7xuJhjusBRBtFAf9ku1i4UoXi9YmjW6n04DjJ5HJsBNPgmheVtf7y3t
 apGz7vA+AH9lH4jnpVWAKEUG+4X4MIvvKd/SVApcTc4kyjYX8Bwmtq0IXiM2kZgqQYmrkKi7M3I
 UTLpz2lCA2RVrZiWmhuFClUwHQblIXXehSNvN7T7LrTtepnN5+2pTxWWENcpRzkl4ldOHgoNUkj
 /dmB/qUWoJ8XIfmG11M4eHd0BqrudIWvziuiKdlCqYA+Gq5cg4mZ4sAlvclR7/eE+XQfxl4rHtg
 Uv2wZUNK74gWwEA==
X-Google-Smtp-Source: AGHT+IFY2TjElw0i9YULUHDuCjv1UE8NKI8zW8p/WkhiFHldvEt6xHrFI48IB20zy1Xf1S2O8OWywg==
X-Received: by 2002:a05:6870:2151:b0:2eb:a2ef:901b with SMTP id
 586e51a60fabf-2ff2671375amr174960fac.14.1752170292512; 
 Thu, 10 Jul 2025 10:58:12 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1174bdf9sm392961fac.50.2025.07.10.10.58.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 10:58:12 -0700 (PDT)
Message-ID: <98ea92b7-d078-4976-8511-d68818270cf6@linaro.org>
Date: Thu, 10 Jul 2025 11:58:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] linux-user/gen-vdso: minor error handling improvements
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20250710170707.1299926-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710170707.1299926-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2f.google.com
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

On 7/10/25 11:07, Peter Maydell wrote:
> These two small patches improve the error handling in the gen-vdso
> program. Error handling isn't particularly critical here because
> the tool only gets run during the QEMU build process on input
> that we trust (because we generated it by calling a compiler
> for the guest architecture), but these were easy to do.
> 
> The main motivation here is that Coverity complained about not
> checking fseek()'s return value.
> 
> thanks
> -- PMM
> 
> Peter Maydell (2):
>    linux-user/gen-vdso: Handle fseek() failure
>    linux-user/gen-vdso: Don't write off the end of buf[]
> 
>   linux-user/gen-vdso.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 

Queued, thanks.

r~

