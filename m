Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4930C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Htb-0004KG-Uh; Tue, 22 Apr 2025 13:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HtG-0004AS-RB
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:58:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HtF-0002Or-4m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:58:38 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-226185948ffso62939685ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745344715; x=1745949515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i1O++acnU7kIoYyWElxnRih+ulflDF7CMMs0rDxoXKg=;
 b=HQyQnotJ338Cp3ktHWgbDPSIUfSttLsp1a4D2GxCfxhHt0qqGs27DZBHeDwt43Y2vZ
 LrS4wVtvUAbUX1z+glOobr5larJiAmcdPTmp/maMnu91e3KJGH1FJrDpeoM+iHDPFxy0
 Yc4XBqH6HMpt5pgqNczcVqHO6NwocNpz3x3ldOmkcy1h2paCCxeH1mgsKfj+gGZRFHYb
 uYn7IdJIxl0ddkuNdLHS+7OuJm0H9omcvxWl/gcYK3ZSp9JfoGfAOB22OdvEj2Rq8HIf
 cubVaGrFNaAYba5kwZOurtNHcZkMSQh/CaWPNB+10pFmWCzTqb2XqorAMGHv3tzsLvuc
 kX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745344715; x=1745949515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i1O++acnU7kIoYyWElxnRih+ulflDF7CMMs0rDxoXKg=;
 b=pZr0pxRTGTwOCTGx1l/KjEpKNhPcORibcwMKxkhAPyZQDTLlXEhzx1d+AXAy5pXH3c
 Ocews5qUYNOeBkBDpsMnM/hwSLfCuikEjtZWW4ylulrDDI0kS+4mBcOZ6gwSXnGvf4Rd
 uqWmeO2CzsIFQGqwE2DjdP10E8+sNAVNxMqyGc/37RMEoR087rrH+A+3gvqEOU/e27E6
 07ulgd+7k2pEA/PcgCvtfyOoM0wkUwG8nKB/4uvgBx5UkhpIrNlX/oK1fCCIwOik5vRN
 2Oa5M68nY6hYvApWFj/VvhYJpPksdReFaUmbLgxkLzloX+kMIQke0eupvqbxIjh0L/9y
 7uqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq35ghOLQW4v904636BbZlGkA77zm1OWhaBy3JQkn8lO4iLnC65OCMaMa1MUqr4uwNdS2agFaYKW0m@nongnu.org
X-Gm-Message-State: AOJu0Yx87D1O0b9vKEsvAFCkUdFXG+yNLWfNF9M/XSlAMbyRDEcDSpdZ
 11GxcOYGCSTngDZNY7LJDKwBcf5ntlnfsHXOhYWKLI7wlXoUab02DqbActFX8PlYlvJCcy/vhBC
 1
X-Gm-Gg: ASbGncs9HiIeRKspOb0WH42OFll4CRgUjsM5d6f1XJ9jnZmlV2LThBnUUR1w3RVGv63
 cDqrFXgUr5e+8WwXXFg3eKDisM7hvdLsWN+tmCBjuprS4UJYydEoSn5KG2YHoWo2r60L70h/RFy
 SeGGtoArrDNKzQnJy+p7dIEQ6GUfvXHIQOGOyvWebIwQEyAn4yu8HJSgml/gzjli8Rm2ognGVTp
 u+75T5VBdtAwgSAV112TZNBuxGDerg9dqwWtQ7t2CerOrFHBjus0dxkM/Ojeidps14SJ8cT60hG
 Hf+xJg5tCizP88VK2i08dMjQaeQEIeZ9OnTSo2QHDgXpuljjzWCH5c2a0EZZGJiC83sJd8xVFqC
 o0gnpClw=
X-Google-Smtp-Source: AGHT+IH4nvQDJRWG8XFDmv8XeoclHDuwr/NzLPoCAbV+E6u05JtBY/SFhZPegiaf2L4iq/Nxy/GHCA==
X-Received: by 2002:a17:903:1a6b:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22c53581853mr232632335ad.16.1745344714720; 
 Tue, 22 Apr 2025 10:58:34 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1dc3sm88487245ad.205.2025.04.22.10.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:58:34 -0700 (PDT)
Message-ID: <bbe3c00c-4385-4c6b-9c75-0c8b14b40586@linaro.org>
Date: Tue, 22 Apr 2025 10:58:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 17/19] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Since commit 62b4a227a33 the default cpu type can come from the
> valid_cpu_types[] array. Call the machine_class_default_cpu_type()
> instead of accessing MachineClass::default_cpu_type field.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine-qmp-cmds.c | 5 +++--
>   target/ppc/cpu_init.c      | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

