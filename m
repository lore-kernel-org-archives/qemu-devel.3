Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F43CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPSpw-0001bj-1p; Tue, 19 May 2026 18:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSpt-0001bG-Nw
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:22:49 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPSps-0002WS-C6
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:22:49 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-366375c4076so1491437a91.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779229367; x=1779834167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W1qCR3UPxl6dfcB9M70dN1HWicU2bvBBAylBEIcJk/o=;
 b=D0tYPPuA9l00CsRzBugbnWOysHdQjO1tVbXmFmKJ5zhWiM7KN5nAJ18mC75li2P6+m
 CCB0jTrw6g4KnyUkJ1sHwwJNZ2ot1A77+LYYFednVHWyITMePOXVGlCUvQ/vJql86mej
 vNYd7kO1PB+vN/s00zMTRWoAmmFv5NP0hNVR8INdGwEy1Jjw2YJ2PmmOEQzKYLBd4X07
 3ybi6dG79nEkiI+H1kWEjFn9yDf/AlznyNABsbTsejeCk7nx+k94WPKlQIu9kkwLU/IG
 te/u4CI6QzLLiW/iK5o6qYc1DA5ClY4EhzmzQB7lDxIcqJrCVTSg02WUXECBUgk2C85L
 m99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229367; x=1779834167;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W1qCR3UPxl6dfcB9M70dN1HWicU2bvBBAylBEIcJk/o=;
 b=kiDHri2irt0pHRPPtRVYv6kAG83aa5VM8EwB+Y+Z5yE4BItp5iwp00U2UPUbysdvLB
 kB6y+UGfB8Eiyf3wyhDmosSxGnVS7bJvQu8YXndm0lTIiIaLL66n7aSfjZukRVqss+cW
 eW8vJn00Zn9ETNuJdMTB4GgeiSnr8RIy+X0kgwZW5GREwCrMoq/WVw1SdonbKw2O7/Z+
 okL5AO7fdffBUgVQtJzapnk3oV2O2Bv/kOz0Htjw3DB8GLNcmB7o9av/pcFt49exkMyl
 id73rJPxq21ZrLGF2yUEdnzPruD+dpz7GOpSMyOKysZsVftkmGe0n47jTlcyNg/iDI8d
 VuwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hQmGTvXIWvam/D/4rnohRZIpXF+VMLbq4WfHC3kaGSg4K6XIr3nqzYQXTeMDtORFoLZVNoWP//SGQ@nongnu.org
X-Gm-Message-State: AOJu0YyYOeKE8tmX8DF/u4Ar2kl2xvn0m2o+DtH4yCw24P9JcyQdCn1u
 Od5XTKkTxqZlAcZvc8HSQwQpCAAauoaLgjdPGv80IqMzfjY35Rkq65e/hhQXkEWJkC4=
X-Gm-Gg: Acq92OERjyye7b2lNMrtILiSd8Cfl06mI1w8JbdaM9mOM6GMEOi/r0QqmlBj2H9sAu0
 4D6ugFnD11tTUX40banVvotuCFfTHuGk/wMvXvYBXOp6NdDLjpprIPqCzEuyt8hC0/AtwW76GfY
 ZvQgbqm3oafI0DSsOqyq2A0+yjsI/K5vtB4Z6RQBEXtv36fzkh4sj72yWs3YmMeWvxIekuB0imr
 TU/G98iRaJfBbSzm1UG3dPW25ym+HtnuuzMmY9lL6NrFhLDw+EYOuifLiF7r3Gu5t9w1v5jruBa
 sw/FcD3S/1PsgjHadUcn8sBVHGkjBoyUEezE7mQj1m8fGkXo0Bbu52K0UL1tdcfj9FEC++x0owj
 8gflSBiSG9XDzQpgTFsnmHvy/OE+2easHpMu+Pz1GDz9TY0shrYf5JsDE6Ks0un5FuCD6h7jzTh
 D7yArMYaXGVC4IBHG3oGuvkypGAZlwWgwcMSho
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id
 98e67ed59e1d1-36951ca7638mr21206807a91.24.1779229366554; 
 Tue, 19 May 2026 15:22:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3695124601asm15216167a91.2.2026.05.19.15.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:22:46 -0700 (PDT)
Message-ID: <bfecd168-8d23-4e94-bba0-4ab8361a0640@linaro.org>
Date: Tue, 19 May 2026 15:22:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/tcg-ops: Fix reStructuredText format
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260519210019.11665-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260519210019.11665-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 5/19/26 14:00, Philippe Mathieu-Daudé wrote:
> In the standard reStructuredText inline markup, italic
> text is surrounded by one asterisk.
> 
> Fix incomplete style from commits 5e97a28a8b9 ("tcg: convert
> tcg/README to rst") and 76f42780292 ("tcg: Add add/sub with
> carry opcodes and infrastructure").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

