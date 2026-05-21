Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4532CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 22:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQBq8-0003jq-Og; Thu, 21 May 2026 18:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQBq6-0003jL-9H
 for qemu-devel@nongnu.org; Thu, 21 May 2026 18:26:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQBq4-0004rp-H1
 for qemu-devel@nongnu.org; Thu, 21 May 2026 18:26:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2ba1e9d3687so43576365ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779402358; x=1780007158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2mHBuhYSpxU5skmfSO6AU3CIxp+C0QHuzWbEoJRAEug=;
 b=EUjSTELhffa1cy/y940RA2wVTWxiHyenmzYgCTTJRCeAyU8spV6yBos7eJlw+KDXUL
 WkvBsidFVS5SWbpxs+oI+AcEMMB04H/MNvvprrlIXzJ981C6xgQhTo8xWvltPs15tep3
 smcdh39E2dlnPDZ8Y5s0ltvw94VSnXpV+CBgR4G+EosNHXT0qk2SEqUL022ccQf8529B
 G0zitWiH6Z+7naZryZDt9tq48GmXMcr4jfCkbntDw9tFGjLaXVwkBJZx84pzs2p22XGo
 cKAcuieG0M2TFftVgMVLTSA48ptK62kWrGBY5dkW0S8oH/wo9PHJicTDK/+bQ9ybJvWE
 tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779402358; x=1780007158;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2mHBuhYSpxU5skmfSO6AU3CIxp+C0QHuzWbEoJRAEug=;
 b=HLi1A76dPfdYyETsEJ4ACVFu6gnseSevQ6eOuxF+bdwMs4G3DhYfyMwYm5muK+HA+6
 Aoy7QHKSYKDmgJ+snpXH/WDlKew1fxmhIMWojSKE0tCzBr5giX+bVBIpcIuteY04e/Rw
 an7TowDOPVXCCQwSuvEw1dSGmvdYyhAauVnfFTShPfp1MQw9av0f+UB2v03zOZaPFfkP
 Z0gM5xBoBPSug9s4WwA2G1uKhZo3muIAndQywOT/69CvNWWJ8CBGxm6VhVTASoJ9YtET
 RXA0GCOshOlrZm/6bCchP4cfDGiktZWEK/uwUmHElv9mCkU3m2eVhN+gv8m8ru8WXyKX
 s9GA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CFamHErRRC97+xuOEoETB7yWJOItlDG6c768BpgHBP19M8JmhUDyM3QhzjqkudyMGdwAlNfrmHU5m@nongnu.org
X-Gm-Message-State: AOJu0YwQGbRwlmy236PyeKcyqAelgGV3XNMFDH2+mAiKHfWZhYkLT3XT
 5bLKz2ldu05J2J4TfsTWgYlTGdXXjcAURO4KKLImIpNUU4MOnHhd1EervnJE1dNGFGg=
X-Gm-Gg: Acq92OE6qmWZdHak1gvW5gwZuETPzHtlYjcc8OqMvJN+ssfJwEDsrf6oyt+fYrzbcHc
 u5wyOwrxVhjh0l422pzsoCnu69UTlZWqvJYAyn1HE8z3LQTfNoeNaqgQvzCHv+Icm7GYhFLeHx2
 3SSVxRLZntTMuUcmHOH/OqJ32bq2KjckUFwNGl6h/baDOshZblpfozSJpsReFDltCg/IhZ2hWWb
 sdOtcTD/klK+xLf0oYcyFuDkpw74eI8SDRcWPni6OolZoRr6rH6EaobYpEx9RK7j/5VVtR/8x8v
 O/xF31VpxjQnSMHyZpIpUL4/rco5liJvGdu+gLAg81tpiY/wvVVsdKUbAY6pQ3fxUXekFZOwUdx
 de6FizMWZepe5R7BHn8yeeWUGqlZlblH8KU5SVZ7XddY7tikx6TDS8CILV6TpRkr82YKu99FgdK
 8ke8Tu92yYdbsbG1jR08xboU348sP7BYJmidjNnRW+
X-Received: by 2002:a17:903:2f06:b0:2bd:c925:3a16 with SMTP id
 d9443c01a7336-2beb039078amr9111475ad.2.1779402357572; 
 Thu, 21 May 2026 15:25:57 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb114b3b3sm2454695ad.39.2026.05.21.15.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2026 15:25:57 -0700 (PDT)
Message-ID: <40d39b34-84a6-407c-b988-d9a2f68feb5b@linaro.org>
Date: Thu, 21 May 2026 15:25:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 03/22] target/mips: add Octeon COP2 crypto helper
 plumbing
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v13-3-5a4cb8ec9cd3@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-3-5a4cb8ec9cd3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/21/26 11:05, James Hilliard wrote:
> Add the Octeon COP2 crypto helper source file and build it with the MIPS
> TCG target. This provides the common compilation unit for the COP2 engine
> helpers.
> 
> The instruction dispatch itself remains fully decoded by decodetree, and
> operation selectors call per-operation helpers rather than a common
> selector-dispatch helper.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v9 -> v10:
>    - Remove shared-window selector constants and the shared-mode setter.
> 
> Changes v8 -> v9:
>    - Split helper plumbing out of the former monolithic COP2 helper patch.
>    - Keep shared-window selector arithmetic local to octeon_crypto.c.
> ---
>   target/mips/tcg/meson.build     |  1 +
>   target/mips/tcg/octeon_crypto.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
> index fff9cd6c7f..4ee359874a 100644
> --- a/target/mips/tcg/meson.build
> +++ b/target/mips/tcg/meson.build
> @@ -18,6 +18,7 @@ mips_ss.add(files(
>     'lmmi_helper.c',
>     'msa_helper.c',
>     'msa_translate.c',
> +  'octeon_crypto.c',
>     'op_helper.c',
>     'rel6_translate.c',
>     'translate.c',

This could be moved to the MIPS64 list below, but that would require splitting the 
DEF_HELPER lines to a new file.  Something to explore later.


r~

