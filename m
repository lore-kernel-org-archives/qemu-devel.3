Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7306ACD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 23:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQvzN-0001Tv-2c; Sat, 23 May 2026 19:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQvzL-0001TV-7C
 for qemu-devel@nongnu.org; Sat, 23 May 2026 19:42:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQvzI-0005tQ-6j
 for qemu-devel@nongnu.org; Sat, 23 May 2026 19:42:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so8649492b3a.1
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779579749; x=1780184549; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4NmHYbmkN99YTaYm3YZ9RyEPODunxB6B0P6RGAYlVtU=;
 b=khzaAy9qEEXxasBvmEa2/kWVsbP/AMrwMynx7YU3SfByxp/r6A3/arazFoqLgNMFhR
 pw3o0ph8P2IxgU0fJ/DrRWfRz/3FvAIjvTr2V3j28Da9MX1pkAo6yJq8fbflgsg6jm5A
 zUTEQC/8lePOfVrzsoffdE0XqgQtzskXFIvntnHiajIwZUM02EniSZ47XHDK7o4cBCtg
 fSxcWrs3c3BJiprWqbUZdykKFFWUx7u+0JoXXMHT+voN8AkXWKKGi9bloBqmiiCGiz3m
 FHBacfXqswAqPA4tSnT0Bzo2/0pm/lhlTZ0tkgJd81+0xwjrz7PqwrVfBrtvL9zQFuCT
 /PdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779579749; x=1780184549;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4NmHYbmkN99YTaYm3YZ9RyEPODunxB6B0P6RGAYlVtU=;
 b=FF2pqMDtfBPxhpvOWsglGHop/Th98DW2D58GpXbNoiauwWAKQlX/TPwBsCt0kgjeIB
 OxuIkrto5Gq5fJM4wL+T/Hv+lRN4DEUA1Dpgegoy1ANGN/FBfqrLvBs56Zos7BebQ1VU
 AxnOXQtdiNieAWGLBrBqZZ4ejqIxO02fFgdu/bGWz0Aun0hzzg/OvpbFQ2CGy+p97uvf
 YqcvpMCaJmSIhKmoBpbYFoXRZrHTZk7hGa+bRkjU4VtVGQwbQaOm3U1oUM701vq53pyr
 0wP8/kKDge5qj37WhGR/DgmxB7p8BshjDto9Fh5wqhK5tQN1tSMkbu2nopTGs6niv5Qf
 9H3g==
X-Gm-Message-State: AOJu0YwEil/Rj4pHhQeH9J+pakwvQtKbo1poefO8PXiTFTMix+LZaKAq
 NXfwRjRSeW9Te4XVuEnxeGv1PQiCgewXfWCf+HMKzAW1Fr9ChfUPCMvFNvJZff2BXkY=
X-Gm-Gg: Acq92OHMbufUE67oLUPlMy4aiqbKJJjNb46QhY/nS26xwHPPmx+RnBfdZDTL2DtnuPa
 EzgvkF20JS9atNLPrbFiEe9301YZn2d46TIsUYc/i3R18GAV2Zu/uY8q8gPMOGIxl4OA4Qefgue
 6Hlp+PpvG8kWhN40EqyGr/i+TLjokige6vzA3vg9PsPhyxFkh3RMRGAxLoY+PAhxBNEDQOY5sDx
 vOryKyCgS92yq2gmUvuLTkQn6P1xwZqNn9GTENE4GAupPp7YiIyMa7CslHv7c9PyketY6Tvcjaz
 J8azq0hCoCULU/LIFEx6Ho57gFJGE3wFT+O8VBJNxZbXhLrBGCDsyrZ++NyTjYmuEJK2MnoddVg
 8/DYz5CpOPvp13OeRFQbCnlKjud2XKfQly8UcDhGTDkDccGCu2t2e6z3XeiEDwccIvFCU0ZuMHt
 XqGMby+qulxrFDmNwYXw2/5jYPZJj+RqRvDUto7uvJbWjj8WIlJUQ=
X-Received: by 2002:a05:6a00:a10:b0:83d:446c:2aa4 with SMTP id
 d2e1a72fcca58-8415f33ded0mr9206672b3a.33.1779579748561; 
 Sat, 23 May 2026 16:42:28 -0700 (PDT)
Received: from [192.168.64.110] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9e1fsm6630351b3a.6.2026.05.23.16.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2026 16:42:28 -0700 (PDT)
Message-ID: <3405f773-b045-4867-953b-8b1d3ebfc501@linaro.org>
Date: Sat, 23 May 2026 16:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: implement FEAT_RNG_TRAP for RNDR/RNDRRS
To: "Jason L. Wright'" <wrigjl@proton.me>
Cc: qemu-devel@nongnu.org
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260519153249.31100-2-wrigjl@proton.me>
 <47c1bfab-8d88-4e61-b374-8c6b101daaaf@linaro.org>
 <ahHM82Qn7BwxRaVA@Jasons-MacBook-Pro.local>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ahHM82Qn7BwxRaVA@Jasons-MacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/23/26 08:51, Jason L. Wright' wrote:
> On Fri, May 22, 2026 at 04:00:05PM -0700, Richard Henderson wrote:
>> I did this myself 9 months ago, but never posted it for some reason.
>>
>> https://gitlab.com/rth7680/qemu/-/commit/2598d4896e19376fbae3926728ac737e7bbea190
>>
>> static CPAccessResult access_rndr(CPUARMState *env, const ARMCPRegInfo *ri,
>>                                     bool isread)
>> {
>>       if (env->cp15.scr_el3 & SCR_TRNDR) {
>>           return CP_ACCESS_TRAP_EL3;
>>       }
>>       /*
>>        * Note that FEAT_RNDR_TRAP may be implemented without FEAT_RNDR.
>>        * In that case, if the trap is not enabled, the read undefs.
>>        */
>>       if (!cpu_isar_feature(aa64_rndr, env_archcpu(env))) {
>>           return CP_ACCESS_UNDEFINED;
>>       }
> 
> Should I pull this into my diff and resubmit? It's definitely the
> right idea (I didn't think about this possibility).
>>
>>       if (cpu_isar_feature(aa64_rndr, cpu) ||
>>           cpu_isar_feature(aa64_rndr_trap, cpu)) {
>>           define_arm_cp_regs(cpu, rndr_reginfo);
>>       }
>>
> Same with this? (adding the || rndr_trap to what is already there).

Yes, I think so.


r~

