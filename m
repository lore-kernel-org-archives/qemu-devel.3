Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F24F8DFC3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDU7E-0001Rv-US; Thu, 16 Apr 2026 17:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU7D-0001RT-BA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:19:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDU7B-0005M4-7j
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 17:19:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4888375f735so84702225e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 14:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776374346; x=1776979146; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/c3vlMit3dPmd3z7jb/JC3WMXwyDtiPqxRxLjyk+N4=;
 b=ECLSsutpEFWPU2NQeLcx2JtGmvF2HbUZ+9UjXqYm3DpOpFtkqrRlPHsut2IihmTE/p
 qdfcBMZerJ9ZI+5VehT64z9BAVI5nzfuB6Ll0OoUPS1Xm+pivGuBfC3eQKcURUQwxmdP
 5yy/pV63H41lpoItGjv7guEN+Xl4r0M2MDhYiMJjcIt3k94rA/TPAO5CstlhPOK1nxWb
 J430V7fAHNDX3ckTNK/8BOFEwiZ2qxoAb8MZTaO+BqUcTn3fB/qm4uVlY9o74qz8fDq6
 6QKBnwoFxcBgY064rL1XJwI0US80FUQe+I1jKAwGRcxVXGeHhPsdM2hOElKINOTNPn4/
 qBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776374346; x=1776979146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/c3vlMit3dPmd3z7jb/JC3WMXwyDtiPqxRxLjyk+N4=;
 b=UjNyPNuoxX5Izylc8p7pk+4W4ZoP1ML4AKTzsxRfokUhJDUvNTStDMXPfKZA3tRuNQ
 c0SxGrXPgSlSAtktcX+okNmEMgdXpvECpEUmX6qOuq3qDAlc8wMTD6NtxuwweR6G1UVm
 FrtLtSQ/b4ACa0IqEfhBf/dr7rwy0QIITwBqWHd22Xl+sBquoPlQYyBIBCP1cQZEvjIZ
 RBp6s41DeDcT1VskpX0xLMgzFn111tuNXFwNmMQr1Msgjz0snsrB46gp9lGprDMigM++
 FbyPmv2VpFddWBa8tf39PShFrr13mknje7av/DmTK668n5V8Cn8XfuNpGhtoxhPDjc1R
 jffw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9qBC4mkaGZJo+iG06GphRxvmEQwJpLJnGZsa0rrLHs4090WCFdPuGa8i7iIqX3c7mR8HfQGP5WbHr+@nongnu.org
X-Gm-Message-State: AOJu0YxY73OK/jnD/bbBEMVtH730rIqsBHM85zdVNwHd51VBJN2vu5UF
 bVk83jH2kKei62B/Z4K9K6WxnmZwzW4PLxxttQL/T9wZRkyOH+0PL95oeBvlr4JSv5w=
X-Gm-Gg: AeBDievO7WUOdar9ZGDJXIu/l/ukeCI7ioBiP1QsyT2uxdlOJ6SANk/4xlGSak7xhUX
 ynRm05bZxgBrvdSNe79dvWJsJf1AzComKNWnVHi39yr0ud6jegncpjvg4tsba8xQGb0rYmIswYI
 84lXnBufxVTvzPeJ3ubfU6iKxiji3Xx7YfHI8+KDjSGnRyUH2EtwygN+jrFmGQWaCP7TttQOyxP
 oYyC6leoDSNrpedfbgjgduNvKlmi/GdT6pEodwhcptaVIq1nwT4yCBKDtym2xNnqeG9WVgM8fog
 sVNCPGw6IxdLlCtW2Vsq3Jb1FOjcjOsMTpG9WVegKzL7+WgUD5zKm2z0e4dGKKnbwNmL352HBoa
 aIqSj13u8249sUX2BiXaRLmdMY4ascRsJniM0NGUaP34LN142tCZFWVc3WK/yBvegrA+jyOuKFZ
 GtA+vib5yEnzSweungGAcRj62+n0KvuhLtUS6yfCasOBVuGsahI0/RAEztxK9SY5kcNMhtAbCkx
 ES9BUz5QsGn8RQ=
X-Received: by 2002:a05:600c:45d1:b0:488:b098:b653 with SMTP id
 5b1f17b1804b1-488fb75a1bdmr2725365e9.13.1776374346179; 
 Thu, 16 Apr 2026 14:19:06 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b8f8sm82092765e9.4.2026.04.16.14.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 14:19:05 -0700 (PDT)
Message-ID: <46a10ac4-a267-458e-973e-a784173460a3@linaro.org>
Date: Thu, 16 Apr 2026 23:19:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] target/hexagon: add build config for softmmu
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 pierrick.bouvier@oss.qualcomm.com, Paolo Bonzini <pbonzini@redhat.com>
References: <20260416210305.2255579-1-brian.cain@oss.qualcomm.com>
 <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416210305.2255579-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/4/26 23:03, Brian Cain wrote:
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   MAINTAINERS                                 |  1 +
>   configs/devices/hexagon-softmmu/default.mak |  7 +++++++
>   configs/targets/hexagon-softmmu.mak         |  7 +++++++
>   target/hexagon/cpu.h                        |  7 +------
>   target/hexagon/cpu.c                        |  3 +--
>   target/Kconfig                              |  1 +
>   target/hexagon/Kconfig                      |  2 ++
>   target/hexagon/meson.build                  | 13 ++++++++++++-
>   8 files changed, 32 insertions(+), 9 deletions(-)
>   create mode 100644 configs/devices/hexagon-softmmu/default.mak
>   create mode 100644 configs/targets/hexagon-softmmu.mak
>   create mode 100644 target/hexagon/Kconfig


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 9883c4d1681..355abb4fd24 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -713,9 +713,8 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, int mmu_idx,
>   #endif
>   
>   static const TCGCPUOps hexagon_tcg_ops = {
> -    /* MTTCG not yet supported: require strict ordering */
>       .guest_default_memory_order = TCG_MO_ALL,
> -    .mttcg_supported = false,
> +    .mttcg_supported = true,
>       .initialize = hexagon_translate_init,
>       .translate_code = hexagon_translate_code,
>       .get_tb_cpu_state = hexagon_get_tb_cpu_state,

Please commit this change as a separate patch, explaining why
we can do that in the description.

