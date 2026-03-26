Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEFC109E540
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 03:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5b6N-0006HA-CQ; Wed, 25 Mar 2026 23:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b6L-0006Gr-70
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:09:41 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w5b6J-0003dV-OO
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 23:09:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so12185165ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 20:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774494578; x=1775099378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z06/UZIyiVNTVYAT3tYR5ReyKJPPyvNphoZ5dbS7jSg=;
 b=DBOpS/tFC7LyjUL7lsHy42Jif07RCr1uRgvm/JwjoV4+1FjR2A3kzMh+g9dFbBr/Ve
 LEZR5nhSr8/qCohkEVg3iFO6hLDt0PXqDBPREtzJV+Ok8T1X9ResLeHlfTdoIHM1WiCH
 1VvmoTTU6QO/mqgvImjSLyjFkARub2fxv5X/AJtyDBrUA2WZ/ABxngP+gOzGP/cWFjJI
 7fxLgFjzSW8Aq/gkNRxq3Fn/KHj69f8aIgT0+gqXYw34gcoXVu1YJULuPVNIJBRFdMeb
 5oETm4rNvZt6oQdzq/suBfeLJ6oVAMQWpGDT8XsFI6dujRS5AEvNXbs/7xSMSC0Exziw
 YKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774494578; x=1775099378;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z06/UZIyiVNTVYAT3tYR5ReyKJPPyvNphoZ5dbS7jSg=;
 b=J+EMB0JDvhBBBPTBZ5juBmFy43l/syoweGxxVpU1gQd7n+gfZ4z8lF4eeO7I4+PieI
 X0FPL9bQnyCNGlHlq60wCrP4t+mYmn7E/o9qbzAZlcraMLFksgDmL9kCqMDhAfl+M3xB
 kk+o6jGUDICsyWILSZnxT8j00jgVXw7R3QaiiBgGEEOKnD33XjecBe1J7JVrfQs5c9LG
 k+qrWGyJ9+gPnhke2TDgQIRDyAgaelSJIBw+WuWX/9lxSauh4w7z1EJDT4Sv52K1grrI
 J3RE+I9zNkzEu811Fjuu+aevB8o2hLDAljaGhM6ksXXhvpXSlxEvo+bdNEigQoeuzFpN
 iqkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOn+CBnZJT920YAnos2DRYZJqsMEefHGtiYoOKfxRPXyiSU6PX9c2odHPbk64PH/Ww5Wz1Svfb9qlW@nongnu.org
X-Gm-Message-State: AOJu0YwP3q3uNtlUZNBYmFzLtIop/JwjODy/yug9DSqpUyzgTjLiL0Zc
 lLOVwOkMd6JSKFLsf8egXq+VT/JXyFBpfN65AQg7lXRA6OBUXl2ILg3waqGRkyKSNdc=
X-Gm-Gg: ATEYQzxGqRL/XzMdUgr8L0XZsTVeuW+nO6ap3DOhHXhwQLEaBQSrQHWzRG4qBk/F7h9
 eKaQmBBkHaWQnzgFRweWd7er/eYJ0sMSJGVvdhflP40Fq2I3TNsc2s9+wW0e+F21J96OZ33OL2p
 /fP67DgwCSBeh1/Gaemf1TkIUDn6X/LW4ibBIJGJGFpOtll4+lPVcqMVdDlyH8+xrdbbXbyRu0v
 Gjse3ua/H9F3Fc1sV5ndBP/GFtwZVCCO5n48ije5bGrn8Fxsz/aOAeHydn7DJ5hl0An1yBgnIw9
 wdwHCkVxvDS9Jca5zaia+osfdUqorO8DG741gECIX57Sbfg5ulhl6caUy8nwNWNGZKyW82yadf3
 oCgaPpaI/BInsPOhHJd2sj9hiNWYSgAUC/J6W3CCc6kHPtKxLTOnIQrOcwL1OncQIA8bXPsLxOg
 z5Dypui4DF8I2++T2MgokStv4juyQulRrQX9YK2Y1hkA==
X-Received: by 2002:a17:902:f70d:b0:2b0:c060:aab8 with SMTP id
 d9443c01a7336-2b0c060afe1mr12462255ad.9.1774494577753; 
 Wed, 25 Mar 2026 20:09:37 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc783099sm16007305ad.18.2026.03.25.20.09.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 20:09:37 -0700 (PDT)
Message-ID: <4d0eefe2-062e-4e79-897c-bb8d8edcb507@linaro.org>
Date: Thu, 26 Mar 2026 13:09:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/mips: Inline cpu_ld{uw,l}_code() calls in
 set_badinstr_registers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260320074555.33974-1-philmd@linaro.org>
 <20260320074555.33974-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320074555.33974-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/20/26 17:45, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_lduw_code() and cpu_ldl_code()
> wrappers, inline them. Directly replace MO_TE by mo_endian_env(env).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/system/tlb_helper.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

