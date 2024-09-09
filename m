Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3633ECE589
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmNz-0006jQ-8a; Mon, 09 Sep 2024 17:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmNx-0006ir-DF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:57:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmNv-00070e-Cv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:57:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so175895966b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725919041; x=1726523841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3Oc0+hnWHYXtdc/4P9coG+NayW6+nuSmFZnKTnpRFE=;
 b=y64MKii/FBRWZ83hrBtn8G0UBEOfGUR9/WNf4FwpllRdkKq4x7Jj0qYCgQyzm7cZrv
 lCOiak7+u2mB/Lznzhhia3YOGjwonOuGQbmz7PmkzcEZEBj/YuwyIrl9/7FP4BesJh64
 gWbnv0JBO8+3CkILdtPzf9JfDUgAGOl+swM4X2OySdi0ebXBLuMDggc5tGAWrLbxIZLu
 juk48ujFnU8zre8bPc1QjWroJHO3QSWX5dap06FQozCccsQ/8syqKJ356xv9RjRmtLlz
 QY0siL9DQQsm2JHEu+fdsV/zJhQcBFURmyUSf9nVHhJRUQ9SwViYdHIn53mLWnqakrNm
 fs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725919041; x=1726523841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3Oc0+hnWHYXtdc/4P9coG+NayW6+nuSmFZnKTnpRFE=;
 b=g2XVRp48kobZRawimwYB8fwsgKxGBJIOD+rJvAi0EqAL2mHA0T0KENTl3yVxOu3wvV
 LPHT2/2Zbhl1fkGQ/8hnUZEVtQLH9xiPwbBMEXTyoMmqMmvPbmgBzmgixbqiCzWvKehz
 wEpB+D8UdcC1NGeiINfoH+IMglrA10gQt0C4h/Mil4ZGTizkR7Qy4Q6LCr3QR122WDei
 AJipJUjsnklsbVxFfe8W6mcTkc/8pVfCKW51cHDsioBjevwgridwbZCY4btHhXThxOB1
 OWnBlNGv2es99t6HQZUneJzP4dyQWq9RIYfT6X+WMjaepqMT8XY2mVqWXaJ6NOSC2zU6
 6oKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4K/oMf4hHEvAM1w26ZCARNI03Tzp6eokccoOFkWBDhWeHchYD1ZpEMOL2UN0V91VC5hZIC/4MKqJ2@nongnu.org
X-Gm-Message-State: AOJu0YxIuhrG2X6WzLRsEouilZxOQ6PUK3KBOKtDPqxdfwRJc7ca7K+K
 aCSkFb5X8rb/t31eRI7/Dj8+ULYyzOWdmywhCFZ/3IUub/LMX8o7phXtwIbfMD8=
X-Google-Smtp-Source: AGHT+IHNIvbuHmFSE3B4rNJNonbhDuHpH+PO1rHS0jXix/2ajAuSqSR1Aa2k/vHjg8TG2FNnXWIXbQ==
X-Received: by 2002:a17:906:dc8c:b0:a77:d52c:c42d with SMTP id
 a640c23a62f3a-a8a885bdfccmr1118726966b.13.1725919041135; 
 Mon, 09 Sep 2024 14:57:21 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c61185sm392131066b.100.2024.09.09.14.57.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 14:57:20 -0700 (PDT)
Message-ID: <9f258eaf-70c6-4737-ba24-8f3470269dda@linaro.org>
Date: Mon, 9 Sep 2024 23:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] target/sparc: Add FSR_QNE to tb_flags
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, chauser@pullman.com
References: <20240909180712.651651-1-richard.henderson@linaro.org>
 <20240909180712.651651-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909180712.651651-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 9/9/24 20:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/cpu.h       |  8 +++++++-
>   target/sparc/translate.c | 10 +++++++---
>   2 files changed, 14 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


