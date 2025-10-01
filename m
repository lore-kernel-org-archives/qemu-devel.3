Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8928CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yah-0004iv-Ab; Wed, 01 Oct 2025 11:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yaW-0004Qh-4G
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:17:54 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yaD-0002Yh-Cv
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:17:50 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-70ba7aa131fso149106d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331846; x=1759936646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=owZ/AbZLPEx+WYON7DFac7UGhkY/pashPH2lAkp21f4=;
 b=tF9qaSN4mfbGQGTaYgifH6CETBYzNTa29EjfIHKoJVD3Egh3e8LyfqOKyRIj5nBCjA
 FcQzuc6r3GeUkMSfJqEBr6u3eUHCdE26btnqg9MZyD5J3Xy1BvJMXqwdRlY174lumHT9
 o0G2vIqqHvvCon1J0UguAq83Da4a4wwh1zcXlmw1PgMkmy6po1DXyNs7QdfJOmwJJD/I
 /lK/X49G4/I32vM3UvZ5DWuGb3DPIm41p1Oyvcs4XoCb2Y2QPyWD4mF0qK94fJf+IwHk
 cDYBmrLuZ6ixb+IXesOBBWuAZfuLCqu5irJH235nJ1u+NyO+PCL471YwPGQ5/TvmRlWW
 c7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331846; x=1759936646;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=owZ/AbZLPEx+WYON7DFac7UGhkY/pashPH2lAkp21f4=;
 b=wC0pWkNvMdXR0YAXalcS4tIZVmucbCBmDmTdaHSIIPA31P22ZeSfEXEP/tNNu/MWxY
 bZxot4Gij0NTVq0i1/iD7kbL65pudxccBUK98SaC4QnqOPQe1alP70MzQwX8TSBH0vxC
 Mf+N7hxWnfJUOWVmpcqXuGZSI4hRpDZ9Ah1DLquQZ+OF4lckCrGwEwdY28lR2dUfuKqT
 nI/X1gSUiGCVO557Yqax+gcZuZkG8yT8BnLTbrcqVrX8r4yRlqA8XYqWO+dIBibUXOM3
 Rc9yZJmDdeKi4PDoqhVSyU6DAjBbcA/k21M+FzQJuornfhHYHohlZ+pl1hh4U2jmoMn+
 5xsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU9eohu+QXRZMs2dWachHYcYt7Xf7yarhN6H4yz5fPjlbaVkI72VmrMEMMYvqFVfHPrcL0JT7XCjUU@nongnu.org
X-Gm-Message-State: AOJu0Yw8uvHUp8lwqnixyRF0jfnuKjnr7+bjZWViu9umaa5xhB8ztOcs
 CzghsSNtS67x0lzgv7dSw2nlNWTALbx21r3t6TU0khFnefr+gHx6I0+pSid2r6RX1nk=
X-Gm-Gg: ASbGncuha4p0IYVsNmDru7Po+MVrJfRJQhpaDGG/BgF8Dn45kePgQS6f2wlt6Ei17yj
 9OVeF87mmlZa2+ib+cvKTi5uo25JuKLjTRGsuf8xqyIv9W2js1dAYNUcIAsq9ld4Q4xVhgBLMFe
 vrBMiE7XlUmXV435m/6l0qrP/peEs/ZT/9am9/zxfklr4n7f7YI+p23sMUitKW1kNfPMOJUWkX/
 YYrivWHMgoWsBlnj023o5P/SiW2COE0ePNuX4QGF1pDpvz1MbnMzJat+R2wNkO+HIopJZPCnSuu
 xUTmMGX9ZsWjxlSRO02y9sE5y4V/zN7Lb5ffDTIulc7b+r3FNmDv7EsnNty4XQLRCQwRqeeo6z0
 HGtY4+puvLAN3jQuZcVYnhVMHxnbAs5JvdEqjal7vMzt6OpeQFo3mgr3qdQiBK85PwBL1ztCWr5
 P9xhDGGLK1rr+g0BWUPH1hh9S3VPHC3xg=
X-Google-Smtp-Source: AGHT+IEeIZeL5sLmUDnYsS0BRKGQCqrHgqw5WQ6copwY9zL3KPyAKzC/eSGmG3CGRNOCnJ+3vVCByQ==
X-Received: by 2002:a05:6214:d4f:b0:820:a83:eb04 with SMTP id
 6a1803df08f44-8739ed0f384mr39904616d6.20.1759331845822; 
 Wed, 01 Oct 2025 08:17:25 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8016cda5c02sm117353726d6.51.2025.10.01.08.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:17:25 -0700 (PDT)
Message-ID: <bd3931a1-c013-47bc-a21f-dfb2285dadd4@linaro.org>
Date: Wed, 1 Oct 2025 08:17:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/25] system/physmem: Un-inline
 cpu_physical_memory_set_dirty_range()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 53 ++-------------------------------------
>   system/physmem.c          | 51 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+), 51 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

