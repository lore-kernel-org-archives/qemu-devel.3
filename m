Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E73FC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEl37-0002Za-RI; Wed, 05 Jun 2024 03:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEl36-0002Yn-B5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:27:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEl34-0004sm-Ju
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:27:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-354f14bd80cso1471410f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717572425; x=1718177225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YR1AiB63s+GAFEkJc37f9XD5H8rjjISy46H2gZtQfqE=;
 b=C4k9rB0KrODKuMDNTGFTF/Vh4E7zJWx6AksQ1vlE+MkUKPITJennKl0cZ82qwUAqHe
 MuvsNTTQ6Jsf+pjHhz9eyokAv49v0BbDU3VAeVKoV8W/NhO5C8ehCxz43ZqKDXEov/D+
 5kzohfzkdOp2CPxGcZY0usdQI81qwdO791FAtyvYFLTkJ60QFZSwBgj1ulWNH5aGI7Mo
 ktoahtKP9UmyxpPkwCXGJAWjFbZ358+cFjl8TCB1LM557HBD2rmHhQ5X8ltSAcIweTr3
 Uab1YR6hfWMUCAAHdTQrmWx5Kvddl008xIeE05u0qsS8nczp8ZWtTnCovC3CCCIYghIT
 Rgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717572425; x=1718177225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YR1AiB63s+GAFEkJc37f9XD5H8rjjISy46H2gZtQfqE=;
 b=rkscmg2RmZ/GnlaPkWlJByJQuo/Aw9/VTKG8VTK0131Fe+xCfqKb4cjJkzBYcooCsl
 vPY0gImd+Z6WMfwNuOjb20Rkj3qHAmFaPhF7TzFnUslojaWPAOVEwH6njas0wObTwmaB
 veL+8TTgX50P2TIaV6KlXssHzcmkpSdBtp4uarkeFlkD6A7y9ztovAq4V7vobcaHxzKm
 gQrQFHM39TlMHfOxlC6hWVyC+wlnOP/cKvrqxhqhsNWK4o/LyEhoC8fc7U/YLFTDDenp
 6tqHGJnxCR8hJg+G+4/BqnARqNBCYbVRjDsiddLD/SOjD8ABRR5ylemcWdAFcxOSowNU
 D87w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAUQL8DgXVRrFLJ3bVYBAKNNwLSip54/1cbNBRO23SMGTO048Po8g+RfFUbQ1oWiRQdHRQxpG3prvUvD32LB/qxDE0yS8=
X-Gm-Message-State: AOJu0YzMYZ2OwXUxPVO73bl5Tnkw/pwitp7lL2b5jZmlLU5wrzIhecCg
 eWirsrkRJY5Cpju7v0NcFbcsCfyyiS20VMAeeBbZTMXZ53WylOA+97rs5fJb3Lps1yVFHLxIuHv
 9SPs=
X-Google-Smtp-Source: AGHT+IGZfM9P+ro8iXjQvuvPLW0otVHcdvYmpOPBIyLH98QJEsd3NBwwH75HGqXIKp5cIOECB5CstA==
X-Received: by 2002:a5d:5f89:0:b0:35e:7e6a:254c with SMTP id
 ffacd0b85a97d-35e8ef86feemr1545503f8f.44.1717572424757; 
 Wed, 05 Jun 2024 00:27:04 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c10f2sm13502193f8f.10.2024.06.05.00.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:27:04 -0700 (PDT)
Message-ID: <8e2e8cff-fee8-4188-86d8-55dc1ff5520f@linaro.org>
Date: Wed, 5 Jun 2024 09:27:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 35/37] target/sparc: Implement MWAIT
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-36-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/insns.decode |  1 +
>   target/sparc/translate.c  | 11 +++++++++++
>   2 files changed, 12 insertions(+)


> +static void do_wrmwait(DisasContext *dc, TCGv src)
> +{
> +    /*
> +     * TODO: This is a stub version of mwait, which merely recognizes
> +     * interrupts immediately and does not wait.

If icount is used, do we need to consume some instructions from the budget?

> +     */
> +    dc->base.is_jmp = DISAS_EXIT;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


