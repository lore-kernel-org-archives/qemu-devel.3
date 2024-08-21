Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0E2C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 05:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgdih-0002Cb-19; Wed, 21 Aug 2024 01:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgdie-0002C2-Pl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:17:16 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sgdiQ-0003k2-SV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 01:17:16 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d5f5d8cc01so26680a91.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 22:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724217420; x=1724822220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m8Di7DpQoe+JJzsnRI8PO118YHlNLVxRdBMq068wPPU=;
 b=s9Y5ECYZZ3vzlC7EhsanpPnFVADSONR/0Tpk0czAkXcx8oRdAStFodjziPxYxKNaTR
 g6oZOkrhrcF88ECyOxY2CgJ1T9nT4gS+rpI9PEYuPf7T3tEtkEFbXl5F3pGeXHTKjyLL
 /NHYbxs72L44NUwEIVs6OKy65bNi7MVc+i1bRx/shxNLr0xVSj4IkOOp4FJD/Dta0HoH
 0n77smt/6MJOtdH+pzg5F9F+MNQRb2wYZF2AiM9tZqXdvi52jVY8W4uZE2i56ZiV4Gkt
 eVYPFp69oretclDQDzu9OuV5jve6EPJ1lack9awR7j4faPXDuRtIjUcjta6mPf3qz0kV
 u3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724217420; x=1724822220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m8Di7DpQoe+JJzsnRI8PO118YHlNLVxRdBMq068wPPU=;
 b=E9Wcv3omNiImWD4Lr0c+Hz+oHKQBz0x9/JKBZw4zBqR928HPWAE5W8bTY0GatOoXFr
 5Wf2uD3Hv98IM4H8jb1FEHFQtTSkfhRSkziMteJSOfpUFdbuJHxd92OYGarhHGINN2pe
 I9pTfyXRv71BOolUzwk9aNstzmw2mrnQYcSfoQtwyIzuCt/75Dk2nEOtwTxXQhJoGHr2
 pOjP93HyuZ9CC38FC2Gcgv3BbmaF6sgnO13MegqAMq8LtShOXx0DwROVt5r1r9+NQfr6
 kNHIYR7E7VA1A0xQ5HrSKdmmrZiYtGv5uX+pEO6r+kai72p9Bwcbiu6ersMOeXN0hrHB
 a1Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRIV53MmcUtv5aSZv369sXrN5Cxh7brPwVVD6Z0BIIcZpECViVPYzYdSgk4+TThw48vUTlUiQyWM2B@nongnu.org
X-Gm-Message-State: AOJu0YzcIR5gIHsTiImEhRITZINASULGiE+wPU5LBFChGp3Sdq32euXp
 9c88rMCTc12SKZ1XYI2Vw+QtCxuueecBu1NmwX7cBeGPM5gT/Yi/8/ml66mZc7I=
X-Google-Smtp-Source: AGHT+IHB3PdpwUYG8+M69hJufGawT7a3Teb0WHYuE3cT2+CdnjM5ggfiLjEd3+NN8o003LaMIq24iQ==
X-Received: by 2002:a17:90b:1a8f:b0:2c9:63fb:d3ab with SMTP id
 98e67ed59e1d1-2d5e9a6817fmr2019165a91.22.1724217420305; 
 Tue, 20 Aug 2024 22:17:00 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7fdc:73f7:8bc4:7fda?
 (2403-580a-f89b-0-7fdc-73f7-8bc4-7fda.ip6.aussiebb.net.
 [2403:580a:f89b:0:7fdc:73f7:8bc4:7fda])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebb4d565sm655503a91.35.2024.08.20.22.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2024 22:16:59 -0700 (PDT)
Message-ID: <f370ec28-e844-4427-9fb7-d4cf4aa55bc5@linaro.org>
Date: Wed, 21 Aug 2024 15:16:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] gdbstub: Use specific MMU index when probing MTE
 addresses
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <20240808051531.3183498-1-gustavo.romero@linaro.org>
 <20240808051531.3183498-2-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240808051531.3183498-2-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/8/24 15:15, Gustavo Romero wrote:
> @@ -458,8 +459,10 @@ static void handle_q_memtag(GArray *params, void *user_ctx)
>           gdb_put_packet("E03");
>       }
>   
> +    /* Find out the current translation regime for probe. */
> +    mmu_index = cpu_mmu_index(env_cpu(env), false) & ARM_MMU_IDX_COREIDX_MASK;

No need for mask, that's part of the core tcg interface.

With this and the two other copies fixed,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

