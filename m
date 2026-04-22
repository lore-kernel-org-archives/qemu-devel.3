Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32355FA1FD7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFatp-0002Dy-Aq; Wed, 22 Apr 2026 12:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFatf-0002Ck-Nf
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:57:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFatd-0002Dc-Nm
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 12:57:55 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so24976645e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776877071; x=1777481871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DbTeMp0F6npNH4gs60DUNZm6vpG8shzFCghJCd+tOro=;
 b=pYXhh+JqchMsCzXSwdYupdwEYdhn3WQXhghMjEuEEmRUmZFOGhdT0Hx70+HcC9vbMv
 +kLopuHlRjf8zc+eRn+UXBo9bDmxzZOnyszp4PJhoWdGISGcqp6vrV2i4/bBpHslcrlg
 567yG6sDjs83EeyuzvWGxpXTPKbTkZ78taivZHpj/I/NNYddDGQZCoXSYaoyZEWvHSL0
 ghL2PL0eXvB8m6jUJjknqQZ4WOk72pGVv8bCVmb+6DBab0QeuL/cr1Hg7+3KZE6GP5xL
 u4IkoNKaGUcbz8iwjftE9pSP0160RsuowqQ98k4WCx0wgBFd3/yc6wk96LBRWGhnUiCK
 avuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776877071; x=1777481871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DbTeMp0F6npNH4gs60DUNZm6vpG8shzFCghJCd+tOro=;
 b=jGkpKqWz+Jf6ko2G1g+j0/2N9vDGXOXygkpokhQqv5kWPHvfZCVZxI7zNoTt5lNDUP
 fOV0jUXwliEvrzjbMb9jfTcM/jsLWHsbhs9ynIyiKhw00gd1K3rs6VfQN8SSDn1mXDwY
 e9zn0Um+/HpsOWFlLmOj4lsV7ZaFepD8Pyq/BXSW+uoTYOiu9JChw9pGp3k3pVk7aXiU
 pEGAzAIwvwMsir+3C7f3w3t+2x0tbDEYvPiQi4Z/r06BEhXwTKd2S75kh7AOMLXQMNQ9
 y/PxEu8gpCgj+X/lR79z0ZKB43XhM55umHejgQKHmMhY3YqqhgjMosNooXvs9iZ0SKmM
 BKxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Bset9Y1GfQCib4KOicD859jXusWSJUi0RN7UONtaRMAv0JacwcV5uy3Eur1abM75W925uyioQj2qB@nongnu.org
X-Gm-Message-State: AOJu0YyPiv5VxsDju6wZfXCQAFDwqLbNdumwJlef/p+a5OA1iLXmUhhd
 rAYfG/Hjaf8nqGz6ClYBLtQVd21asGyac29B61dX4v+oJx+g3+MW7VLgjDl88zWOKBdjz+kqbOq
 MQ4xSyb0=
X-Gm-Gg: AeBDieuM2sWGjAv153el3eYI9hItxrEAdAIWXM48RfgHI7ios+Wo4SGsFtXA7FX0G+H
 IFxbvAUrt+j5pd3agWyxJmmT7eLVJMLoxIcTG2a7IC5giWAvuqFAUKuuDfOJ6fnhxXKGS6Pg22n
 HobR2HFDNx5GuP0s8kyljepHKvTZlGhiXjGRmH8ozk6YsrkjrB9m6TLd6hL2spXwNZOiLq0g//T
 IanNBv2JNb2bWVrOzBn+g2gycxR4o5cuYUJtXeo0s/5AzqD2oZ7Cpto8fW3mxt6jm0ls9kSzDA3
 TEkVs1wXJmtvjGRS2DWgZDaghE2fmpzWP2swXisCZJI+RalKEruRp9ArkvzlzYxkHj58woqYfj5
 OsXULBTU/ULlNiNnCxNKB48KE6+CBdrc13aNFobQYM8LaQ1r1CpXFfzLMsTFvHytrAE9tdMdNY0
 vCGU1L49uk0Z+NmgHLT3vVDHXIYvimcrfxzD11NQ5QrZ+PR6xQ/h3t9Rtf65OdoN3aHZkqynd9m
 1gU
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488fb8b9deamr269580515e9.13.1776877070648; 
 Wed, 22 Apr 2026 09:57:50 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb72d365sm229925445e9.1.2026.04.22.09.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:57:49 -0700 (PDT)
Message-ID: <a0835cb6-50b7-4db3-b747-bf3d5a4badd9@linaro.org>
Date: Wed, 22 Apr 2026 18:57:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/32] target/arm: ensure aarch64 DISAS_WFE will exit
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mohamed Mediouni <mohamed@unpredictable.fr>,
 kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
 <20260422125250.1303100-27-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260422125250.1303100-27-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 22/4/26 14:52, Alex Bennée wrote:
> This mirrors the logic for DISAS_WFE in 32 bit world.
> 
> Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 073454b9195..d79c8ab431b 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>           case DISAS_WFE:
>               gen_a64_update_pc(dc, 4);
>               gen_helper_wfe(tcg_env);

If we mirror the logic we can also mirror the comment,
otherwise the description rationale isn't very helping:

             /*
              * The helper can return if the event register is set, so we
              * must go back to the main loop to check for events.
              */

> +            tcg_gen_exit_tb(NULL, 0);
>               break;
>           case DISAS_YIELD:
>               gen_a64_update_pc(dc, 4);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


