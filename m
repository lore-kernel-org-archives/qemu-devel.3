Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92181C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pJ-00063E-8s; Thu, 17 Sep 2026 00:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ov-0004YK-4g
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:34:01 -0400
Received: from mail-pz2-x17.google.com ([2607:f8b0:4864:3b::17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ot-0007ZM-Lw
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:34:00 -0400
Received: by mail-pz2-x17.google.com with SMTP id
 41be03b00d2f7-cc1cea48edcso285179a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619638; x=1790224438; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9fdcx2tFZ+1ayClJOSMOnPXmlL0geB9YVXkz+ZGV+74=;
 b=R+FDFTifvjvzuaHLf8Ec8vEZN411NV7db0B+IpPI0D4SJ5UKTYocilBeBbbsu8J3sM
 htr+5coIZg6R07Sb2EHYzt5ZQHJtkx/fHcy98n8V9NzDtaHvxenH/n1I+DYQLGAJzvQC
 Q48sTlHcWpQ6X2GjQGK/PJQ3XNxzQBs3R9lEmFjo2ZinbZnPKSwkFCUmj+xpXC4W87hW
 LndgUAoL0ZiTaTXgJ/7Yv1X34Lzr5vsQhhWssxdWFwO+sC+YmhBjbQuUBrYKz6cp8xIn
 b5npjyGjqX+H4wrnlTjb3CFguCaNf9ZVm5eoEWvhTwjflLRkYNC8b3per4lgTftPKApy
 c1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619638; x=1790224438;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fdcx2tFZ+1ayClJOSMOnPXmlL0geB9YVXkz+ZGV+74=;
 b=a0dB7X1PBMSCAR0sgFcA4IPVVZQVdbBcUo3c+CI+0wJgKNDsVVa6sqAEB4OB2lCJlM
 v+asGot4qjab3Scb6WROD2ZcwN3zyzpMtm4exHdTUASNmGDug/qn1dfjD+2rVe+OY9VZ
 6thQ7c9o3t4Yq7Nw8Dt9oUjsbcpGc15NZi8AbuxeDmVox3ii5GiL/MVP0W2gbHZ6Xb8s
 hD5ptFhobkYHWwqrD0CykGC/WHOxvZF+aT2YjFvF3lso2wFmFROUalM9HPW50Db7Vbrr
 GRbpx28TK4uU7Q8YtHTIcsDH6kJY9t1vc45tTQAHnZGpM1TrEB8/hNIw18txXZJ3T8hn
 plRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwDkFD64QudhU9h9ceejdadUWnM+y7mnPx9Qfyqu7lagb03hP6bjS8TocgTfU7T570hovTDySK6mj9D@nongnu.org
X-Gm-Message-State: AFuF++kr85jgUxtediQRNKPFgnsXrX1TT0+ARdbMOWw2zU0XUwfLcVEr
 tB6KiBfongDeOLwKCcqaJloQNJ4Q7GSVqjxnhJ/QlTRu494Fz9gNryx6Me6Kv6EJL/jmZS+3Tx8
 v+Hd7wpU=
X-Gm-Gg: AYBFou3RwbfL4B2hN/8DKFteQ7VMIdHoHBML7k5mlwABJSNuNoQ4UVunfCjul4V7N63
 pE1YdCRbMq9IB0bQoeYj8EjA/bmbJ42vHsZZNvlEMmPVUoEDKiXFVBc7mV6TMJYaRjXCeOwY5ZZ
 phVEQuhhi/841qkNeT+bURCezzHk9HHWMV7vpNtA2Hvih8JooMft+95eUvQ9P4m0YEqYL0Dqj20
 FwFNsvnrUI53aYtXSnzj+SfyCAypgVIDwD/flDgxQ2p4A+Tw8B/gRiDkoYdLyCYXA9/xecHCjHh
 tpLSG1JI2GBO+p79TXYJF8C3BgPG74eulWRNA0hSZzaFYeg7aEcR+kw2oq/XEvqT498jIU/fDAu
 i/in2zBLwS+ZMvE57ZjJbf7baktk4ycfyW3ZcjCUL3DHVqcR20YU2HnH9xGpT4bsiRaIYTCq8Dv
 fQCXbAzKuPj/2MNJDAr9DxcKI+jD+PtU2hWjQ6KbnTVXMQT7tD9Xr6663+OkZphj7IA9DyA/V2Z
 VH/VkXgd+bx44z4qai6MUvEJeWeW1yC1pNLZ4VclWNKbuTIpnBfrJJxnBcuEg==
X-Received: by 2002:a05:6a21:7116:b0:3da:b8b4:91d7 with SMTP id
 adf61e73a8af0-3dd5f3c26d4mr13914559637.2.1789619637854; 
 Wed, 16 Sep 2026 21:33:57 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:325f:1938:d075:8c13?
 ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a175sm12459737eec.9.2026.09.16.21.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 21:33:57 -0700 (PDT)
Message-ID: <3bcaec47-eec2-4892-9624-33941b5663de@linaro.org>
Date: Wed, 16 Sep 2026 18:33:54 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/loongarch: strip flag bits in lddir/ldpte address
 calculation
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, numpy1314 <xzj13@mail.ustc.edu.cn>
References: <20260917040828.32648-1-prcups@krgm.moe>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260917040828.32648-1-prcups@krgm.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::17;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x17.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/16/26 18:08, SignKirigami wrote:
> -        base = base & palen_mask;
> -
> +        /* Strip flag bits (0-11) from base before address calculation. */
> +        base = (target_ulong)FIELD_EX64(base, TLBENTRY_64, PPN)
> +               << TARGET_PAGE_BITS;

This drops the masking due to PALEN.

I think you want

     /* Strip flag bits (0-11) from base before address calculation. */
     base = base & palen_mask & ~MAKE_64BIT_MASK(0, 12);


r~

