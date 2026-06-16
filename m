Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76FD3CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY3U-0008O0-MB; Tue, 16 Jun 2026 13:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZY3Q-0008Na-JV
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:58:28 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZY3O-0003xJ-Pp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:58:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso36374355ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781632704; x=1782237504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KFiaA1OSX1GXONmlm2tLaMW0UQHltvIz2eQOwqUzZME=;
 b=vNHrdFLyTvrAxMYcVRKm5/6jox74Mn8Lv2AmtvrPDEfZ0rwPsKxU9/lWKwdQ8N1+5j
 lt+El6yHHtz5lg+nGpHnelAdm0k21jJpRjeKtVVBk0oeubX8+5P1ITR0yP+6PKYAfKCU
 G+FDFiYMf/ePSTZpD2l2l5GGUu+MW+DqcEGc9iG95M6Ouy1PvYA7BnQop59GAvKekLoM
 rltjDFJAM8fSb5+m2AMCVjCu8dlmZTYumVXA/p1H2IQFQCD53/7Rm+UZoqw/7oH/qa4h
 fu3Sm1igi4FQg0BZ6fHD0q8FdqIomyMcPEYvSoiXKOOZlqTXsr2B24jo6/k2R4ERrelK
 GBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632704; x=1782237504;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KFiaA1OSX1GXONmlm2tLaMW0UQHltvIz2eQOwqUzZME=;
 b=ZRdYziGvMH6N2Y1CmI08iT02gvYU3VIeZpLqjRmUx62XTmnfXBdHkB8aviI+sTug7a
 Ppl5ZgaYi4DbMvHDkgEPxJbJIrTBLValxrplJGrmy8DqErVKmnUMb5QisG2ZHtXImJDB
 4sQ8PRIYOYpVFKg1tP5r7Mh3/9Hu57BFVtApZgasTz8uKi0zDbmt5jtsBoxoBEJhJ/gw
 g7CBUFMjgXT6g6MrZj3LUUdbWeRPcG+coMSEgAr96a8yEETFYfgBwWHo5YfzrgAVrQG0
 WR1qtKZVxVbdL1DDrCv1PY7OpizB5cHacOkP0PzpkypZJmadL19dCY8x8O6AWYD6p646
 5WMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TpHNqxJulJthabVRcGUqbvrfMTHDlVRgaMZhmGARsOPLvkijyxBQGabapxD7db4AeZRIjH5GHCJD+@nongnu.org
X-Gm-Message-State: AOJu0Ywu98gzwf6nrv7k8wtg+b+6my+G0iDwjzcZ0koR6macMqof5ZBx
 q0PAqgRp/zzerrmmD+ZehnAqVLB7SrTUWKMGL0Tr3Aa8eH5tmBd28M2s7i+MCOBZ/9o=
X-Gm-Gg: Acq92OEog6Va202q7WxXGe6PCcy+53rnomi5a1QHZj8hdQs2aeqE3Fzed/4CEM0Cts0
 Ze2ySJjhvNjcl8EyoS6X7WS7Agp+61AUtlFne+qHj+wCnQSi3AVHhlO/absEch4mhai7K0B+OOT
 69Gm+rJo+vVKTbEOC/3ROuIJ1BHCkFu5fCcHES2cG+PJJyVV8isaPW7C/Ejcv06x+UeRjckTrq/
 COjzFBAIYctt36wVYPlciNOwuAHYqQzvGr43ENjULkldE6xAIMQ+bKAjxrOzNn2heZrs7iberTU
 shZvI+5qFRV9USyQdMSzTiquVfAk4z1qvUW9Fn5Wk6nqkf0FMUGJc7jMrvUfIozCNoLspeUcE3Q
 5qbm+rZmntjjT8xSitcinQJKHTS8bw90fdEcSDlAYas504U1B4/xlSUJh0onrLRNWonyWlO8e/9
 pYKwADOjN6kEL8oSVEwztinrXnc5zgzHEar/3spLdjuxbiWZOI0RfD8A0OxYlWn8d9XeaKBNAoW
 8RH/CY=
X-Received: by 2002:a17:903:166e:b0:2bf:128d:f7ff with SMTP id
 d9443c01a7336-2c6bc0ab997mr826575ad.16.1781632704112; 
 Tue, 16 Jun 2026 10:58:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c432c8c1f9sm143842615ad.59.2026.06.16.10.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:58:22 -0700 (PDT)
Message-ID: <2cf33941-82f9-4497-b7be-2fd61c4275e9@linaro.org>
Date: Tue, 16 Jun 2026 10:58:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] accel/tcg: Remove pre-vCPU
 ignore_memory_transaction_failures flag
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-6-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153432.92939-6-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 6/16/26 08:34, Philippe Mathieu-Daudé wrote:
> @@ -1291,8 +1294,10 @@ static void io_failed(CPUState *cpu, CPUTLBEntryFull *full, vaddr addr,
>                         unsigned size, MMUAccessType access_type, int mmu_idx,
>                         MemTxResult response, uintptr_t retaddr)
>   {
> -    if (!cpu->ignore_memory_transaction_failures
> -        && cpu->cc->tcg_ops->do_transaction_failed) {
> +    if (unlikely(tcg_ignore_memory_transaction_failures)) {
> +        return;
> +    }

Any reason not to pull this from MACHINE_CLASS(current_machine) instead of a global?


r~

