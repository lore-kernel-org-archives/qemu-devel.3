Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C441FD2502D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 00:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vej23-0002u1-6E; Sat, 10 Jan 2026 19:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej20-0002nO-44
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:10:08 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vej1x-00082l-FT
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 19:10:07 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-34c24f4dfb7so2901829a91.0
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 16:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768090204; x=1768695004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PVqSnrbLkVB6Fdf0k5K/Lr7w7wrD97RqumNzrRijUVM=;
 b=AjfGjZ9Erm7aqmATanLO3WeWj9nH7cF2MOm2vpTfoe0gEwmU+nCT/zmOLn99Yrb0H2
 BZCPEdWlpc/dDgCVOtIE5SzK07KYfzJiETkHNfaSNrPSnaaFW3g3d8EFPhPZuPN2bKfA
 U4qapOnwQ7Z7eU0Oi/EbXECgDID1OK2OMRoTgFSVsQODXsyev6EKkmeJS3Fa+lcDIK7w
 ETlX0IL40jA8vQ9RaYRLffhM9zx3WNdottTBiLdimQ0858NjiZS8hExnG5yw6RXvrwb+
 II0KD7nPOPzE/BUZurjriraLPJfi4E3dYFP24aIOxhoYQ4v+9kA7KD++ZmyNVeJWswNy
 bdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768090204; x=1768695004;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVqSnrbLkVB6Fdf0k5K/Lr7w7wrD97RqumNzrRijUVM=;
 b=cecTKkEvN9gAmTwsZCeiYosxMEssRry1j8OMz35NMs1viCYh8n33sUJTg4VG3s0voJ
 a66L0S/g0Id3f/H7Gukjxz+n7+SZv+2WknwHV4wSW/SuNMkdu+3+dJCjqxqNCRJHYNYZ
 sdNtTqGlv80OVJeD9K6G34OkKOeiDpQhZfwzos8H1C6spI2TosyMi1W0HTgWb+Kr9Tqz
 Ta9c7fIvQN2pBcoUc0SIW1ERU6PjD97o6DvQc/BAX7MX0dQg87Qk4Kv3+oH7jW74L1bb
 LQiUqpt5tTwJSj4L9PqIkVymM4bXJwYXzw9oxEobdzTDOpF3eeOPkvHYSBYNmKSf6K8f
 92aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdISh83j71o0uDyiHa0ldgE84bIsd1IGThZvyooUHEsJwf20zmK2a1VVIuQTilW2UcmsTxiRZb7DhI@nongnu.org
X-Gm-Message-State: AOJu0Yx3blr7l27IQu2g4U+zmvacJ+mVSG0xhPIRUP3/xGKJBkQTdTvx
 T1Zb7XycUDmY+JGSnldOaD7WNBmm+6FX8NJJQuc5yaK0n7va4Uww40OqEjOI0XP0Pq0=
X-Gm-Gg: AY/fxX5gOswPsh4fRi6emF26tVERw9q0LaWbKx2OcxvVoPaQdp/DIrIri2QOfORt7e+
 lirS6StDN6W7YgaGVLbLkoOshU5ro3s0iUmnoPLenWDCSWkL1EJYFZ3Zvz8SthLcEu8m1uJJsyv
 IcwIi16QW2qYf4KeiER3tjwe6UCNBMCycqonpOntUSccGDPOT5Rkpm/vdfBrpgCLPLJhlP2Fhlx
 UcfnzO286JjBM2uRHn+on5UK7i77rw+MYaDo2C8hguCdNCAOC+YO6fNLYdf4Irv9vZONZkFi5a6
 xO49JDSyqaCmae8F7HatUS+DqoObyPdoIEiJ83FEO4CwB9GhKDxsYBAGTauyRuTghgIHyoFVmN+
 1cM7ucdZLEG5oyb43ZX6Gmd3K0Z4nguI+aFQj4x4cy/MIXo8VzrkgC1gBqlCrCDHFZ0smt5EoKb
 k8MvGWbwJFo3eWndWypgK65XAOaw==
X-Google-Smtp-Source: AGHT+IEQRN+9yz5CPxIYfTEgLu/g9Ib21kP8tZKRD5qzgLjBBw2xKLA0cMN+OO4AzrVzgINHIs6mSw==
X-Received: by 2002:a17:90b:1c87:b0:34c:635f:f855 with SMTP id
 98e67ed59e1d1-34f68c33ab8mr14643785a91.7.1768090203865; 
 Sat, 10 Jan 2026 16:10:03 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f2347e3edsm3189222b3a.49.2026.01.10.16.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 16:10:03 -0800 (PST)
Message-ID: <bd0a1f29-df4a-40e2-85b4-4498c00737d6@linaro.org>
Date: Sun, 11 Jan 2026 11:09:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/openrisc: Remove unused 'gdbstub/helpers.h'
 header in helper.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Anton Johansson <anjo@rev.ng>, 
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Stafford Horne <shorne@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260107200702.54582-1-philmd@linaro.org>
 <20260107200702.54582-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260107200702.54582-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 1/8/26 07:06, Philippe Mathieu-Daudé wrote:
> "gdbstub/helpers.h" uses target-specific symbols, but we don't
> need it, so remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/openrisc/interrupt.c | 1 -
>   target/openrisc/mmu.c       | 1 -
>   2 files changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

