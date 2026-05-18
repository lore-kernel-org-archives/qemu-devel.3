Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5CBCD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 14:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOynI-0004k8-FR; Mon, 18 May 2026 10:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOynH-0004jj-3K
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:18:07 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOynF-0001H3-9t
 for qemu-devel@nongnu.org; Mon, 18 May 2026 10:18:06 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3699cdeec05so679117a91.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779113883; x=1779718683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WI/nIvpEhoQScTkzouFkp8AsQD9ku6GNYeDVIQqPwo4=;
 b=uGB8AwVxMGesRYpxXx3IG5+VJePIrbHDki50GlBMqsc5V76TTY3h4Adcw8obAludsp
 rB5DVo6joT7ERMqh7Xtw1HmB+jBhlHqI8RHcEP+DYqQ0KIT5yMLylOX5cVxuLyr45SQv
 dQRJdW/72l5eiMBo5I9el/RlQKVAKJlIvire+XCe5YtCuvrz9JELqB3Jarwtp7wzzXMx
 fE9pnemygdZ7rq7U7tq5AJbM/mXRgQdz6IEQI92LgzkdJUURN3fXILGNGzIz6uVRR63D
 oTt3zFVOj+NsxW3q1poPoa20rQ4oWlrqmcf3owMvrp6W3gGTwJvGQ0FdQdnNNZ9U8iGD
 ORAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779113883; x=1779718683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WI/nIvpEhoQScTkzouFkp8AsQD9ku6GNYeDVIQqPwo4=;
 b=ItzY06Et8qnyrGEjGaJWSm6ZwMY6n2FWhTaKKkvc56c0U4k4Mfz6H89m+exfdhiLUu
 e5ExhoriwRLHYRaOHS+psqwVvPJ25Tx5BmyI/oqs/AuyncRG3GyhxwNXGmMzKjFo6wZP
 k/tVZ82s9xmt3EWO3yjyB11s4j34nj9HHIRjsWlQ1aQEaBux/47dVPisWUWv960SfJ74
 SBFVVRQAAfD7Ulown/rHAsnJnpBEGpZ1J4nuI/gseGSvctRa4riLlDzig8hJF6pD15mh
 Xthi/nZ2ksg2rqIiIOpZZtZ6jpXJzh/6z9+A2yz6nP0FppfUrWK8HfcmU7Brb4lvzCsm
 iu3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wI5Mfmto52dKEDKzzvlGgGH4iyg53T6Q2qONdnMzZ8aQ/aLFQ1zy8Kn0g8FPVUBhkXMVE1CuvzdOd@nongnu.org
X-Gm-Message-State: AOJu0YzgxXUSkuoLXjJ2iNq9NBU4B5f7OfP9ItIn5BTjjd7HqxxuS+cJ
 p3h5OLdoVa4asqfoRzRvH7uOzZFPhg9PZJREc8Bmv3+JAxcB5yw7Qj7lrNou2X6z0Ik=
X-Gm-Gg: Acq92OHV8mXt5bOm8woNaKuVjzcaogkGAESGkWWRUaSZGnIRkyJqevP9LP6aeYF8sU8
 pmcIRgk/iwFMQp6xOcErcBZYJnOADIUkA5hZV7WNs8HAK7PNcx7qxhk2TC5zLmdf7VS23qc2NpO
 X0IlF7lLiTypTXuOT26OhcXJDvt61PDamLmp65vz4ioYFdTJTHtYhaRYoYQWQiAHSEzSlahKLaQ
 qA/PkcopoOmnuhydU2cTDCC6u7921lZEFax/J/5c4Hc513s1A5Ce9PSEjav+/qCvPTOiXJFw/Y0
 FHw71GmTbsF4AUle3o3hSkIk3Bx10uZfXYKJlgmztRVLevzui9quoJDqcFG4npE54oxMl2kkRhN
 PW43X/X8OBNHX6wPK2V1CcMIqASq8WHXxVkYX1mHW60iywnO9Gv7eknNXABH7EUgutm0ySWFPjE
 4SZktZjw3Y63npvrrHwS5FvOXzEarwLvHVbQnV
X-Received: by 2002:a17:90a:c42:b0:369:7421:6d2b with SMTP id
 98e67ed59e1d1-3697421b9e8mr5488115a91.19.1779113883333; 
 Mon, 18 May 2026 07:18:03 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695652466dsm5566415a91.0.2026.05.18.07.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 07:18:02 -0700 (PDT)
Message-ID: <b30d5c87-b410-41c5-a0f6-d912e6150676@linaro.org>
Date: Mon, 18 May 2026 07:18:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/35] target/mips: add Octeon ZCB and ZCBT instructions
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
 <20260517-mips-octeon-missing-insns-v2-v8-12-206151ee77ec@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-12-206151ee77ec@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 5/17/26 22:29, James Hilliard wrote:
> +    for (int i = 0; i < 8; i++) {
> +        TCGv_i64 slot = tcg_temp_new_i64();
> +
> +        tcg_gen_addi_i64(slot, line, i * 16);
> +        tcg_gen_qemu_st_i128(zero128, slot, ctx->mem_idx,
> +                             mo_endian(ctx) | MO_128);
> +    }

Since you've changed to 128-bit store, you might want to use MO_ATOM_NONE.  Otherwise 
you're requesting 128-bit atomic stores, which are not available on all hosts.  Neither 
setting exactly matches hardware cacheline locking, so IMO either setting is equally 
inaccurate.


r~

