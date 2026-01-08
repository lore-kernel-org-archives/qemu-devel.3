Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EA9D1D48D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwWk-0005Am-6b; Thu, 08 Jan 2026 15:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwWi-00055G-4N
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:22:36 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwWg-0003rr-Om
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:22:35 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a0d0788adaso25514035ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767903753; x=1768508553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9NBrbjDRVXTDmJRT3xpB2IbPXUFDe3vBC3CLXWuK37I=;
 b=mrzSSmUANbOfR2fzF5lFVL0o7kjDc2LyulFj/hnYOrKFUozCaPyWBU5r6Ku0nkGXwM
 swFJmu74nxvDPdLrnUm+DusvLUBoJPYH9g2gND360DQm0YuhkfbHIXVTuJtNSb/q6gG6
 ss7HZotzHovkFQtsKQ1hDlOZoV1sXqiVbOy2ScAWw1OClz/+7OGt7TeOdU5xDdj3HOTK
 d10qA5nV6tJh1tUrfmObAaRWZflL9TxX1GMHJiVbAiixT3kRcB4PzQT2Ak0RM1o2wsyC
 iLmSSmUcb31kRhWzvG8ZiXcSc5JMxOgw45xcotbg7ke8ivFEcJpUa0OhaJnKraGn7SKw
 X0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767903753; x=1768508553;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9NBrbjDRVXTDmJRT3xpB2IbPXUFDe3vBC3CLXWuK37I=;
 b=nDhOSe942WaVeTB+tsdOIy07+9b4NJup4wh1n89YbJKKFDPsBrQ5NH887JCi3aJ2/H
 XGJjqFQe/6s4UhTCEg9rAQGvqiW3+2rXB80wzrFq6nNFwUkyZ7hbDHrSP6nhF5tBDVNA
 ORceg35QwPg/8n61GIxxxKcxEfTT3BUIxMLnIY8Gi3Vu2OKnGdqXjPkIYUcH6YCA0H1i
 GmxnWJ/DBUOCvzAKxfVrNM4bH6zJDfqmozDy3mjiGKhSPm3lj8fBeG7Lyvu/U8KxY0dy
 n0EZzg5J9DCMfZXv7k+YbB2fW+eZqxENQbl4+Dp1Ran4hGSMAOmKvHNC1Wi0N9vXWiOV
 KDnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaedqg3doq/amArw0CVx7bS8x8V47NNDPOrj18V0s1Hizor7btaRKFqNzIR/MC2zdHshRmNpJIPBYA@nongnu.org
X-Gm-Message-State: AOJu0YwdZhfdTVTOM4MvzvREzKq8t5H2kiZiG0QEYnDH1fdVgB10bGS7
 suypznIqNEQAOocn9TQARj9F/Sp7hVKktul4fVhi6kcH218RJI4PZoqTpZJCeM/44lo=
X-Gm-Gg: AY/fxX6I+/iOdtVTcy7oCgY7qZEgU1+IMXddEQjXAxOzz/mXipILQdgTEFwXZE4k91O
 kZx7mI4E97C4m+GP6WFvnZ1L16Ev9RCFfqYtjj2DNOe219Ci2A1lZ1PfRBrylRmmcUG40+LVqde
 6GajKguRZY5ZIxTzfsz4b1YVyVm8kgPsgeeQPPmt6ZNcnF0OYTXA7ho3Mjf9eGqEjNm4I7u2uqS
 hDWhXbpPjbi9y/CRJ6yN/6TK8LsOdfdc2A4DNL01kF98UaMxILGhQs2R3leYmoPR1tfhFYVKuoW
 6rB0f74eCBPWWQObmKhKpNLYvnTc45IunZrEKYbkIqoFbTa9Xx6nP75ur2aCcTYDc2/ELXDIhhr
 GW6fU/gNf9Ghg5CNvpvPfD8Z0OEhu9oQCW+Ze90qTeB8MzMrWQG7ui78JSlJd9IkwOd9DU69H2H
 zCfwFIrvhQK2HHURohpPXCuQ6O5igJayoTUnB7+TiHkeRRRKBDnlwRdgHL
X-Google-Smtp-Source: AGHT+IEdj0Dat0MdhgnA3OB+bL304O8BbfzYVhkEggwom+jqeWNpnPXtuy+MspT1r2WSzhwCv3cQUQ==
X-Received: by 2002:a17:902:cf42:b0:297:f0a8:e84c with SMTP id
 d9443c01a7336-2a3ee4b06d0mr72096585ad.52.1767903753217; 
 Thu, 08 Jan 2026 12:22:33 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2ea0sm88202845ad.62.2026.01.08.12.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:22:32 -0800 (PST)
Message-ID: <9172bfb9-e53a-417d-a7ed-9c1ba6dc976b@linaro.org>
Date: Thu, 8 Jan 2026 12:22:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/50] tcg: Replace TCG_TARGET_REG_BITS / 8
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-18-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Use sizeof(tcg_target_long) instead of division.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-gvec.c                | 2 +-
>   tcg/loongarch64/tcg-target.c.inc | 4 ++--
>   tcg/ppc64/tcg-target.c.inc       | 2 +-
>   tcg/riscv64/tcg-target.c.inc     | 4 ++--
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

