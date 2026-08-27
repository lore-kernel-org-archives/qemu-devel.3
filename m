Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA42C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wze6v-0005oT-1e; Thu, 27 Aug 2026 13:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wze6p-0005jL-Vp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:41:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wze6m-0002i6-Ij
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:41:51 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso160328a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787852507; x=1788457307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ltjglv55yzCu+dxAA84sfK43x2fhm0yqmOMlBGGkQuY=;
 b=WS8q+lj380ys48BjwQzO4MZ6I9/QizbDn7VX4vzgmOdoEGdmHfDdSzcLug5nwBMH2G
 0xk4L9ir4s4UnUtOU8lypm/0ZTkhEiwFpQDotrGoi0dSPXw63Yrq9YYlR4I7i7QOQ/54
 z82AkTkGDnqY+JVgnX5g/xMPr1QTjBiJqn1NzzWfQhaAwzQ3CrrJ/8eHQiavpnQ+vqn1
 pnQbJBhoHn5Je3HayHtC4Twkf3uiLT9i7J7Uph1HuCUmGUJQdMDjUawRbRJrGu/RtSfG
 Id8TjbPNKSv009t+U0YOcCzUCy7m0PNC1uTmtOfSdVh70RSoMLyO4mKiHHdUJibzxG1I
 G6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787852507; x=1788457307;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ltjglv55yzCu+dxAA84sfK43x2fhm0yqmOMlBGGkQuY=;
 b=MnTT2OTnefTivn1s7jGv85ndF6JFze9qMHTpR701oTcX4Zuh7Hpg4DHOSAMwDwZYiH
 VA7sbTPRsza6k9A2ypYMDI8y61rF2SUKHh0lapJmniZv1J0YQ51+gqnkabSkAzYG6mH8
 B7vMXT81wFivVjAqZCuQrptbEIZGjSaxnKCOPd0BWghJN5PcbjwBR2jxw3WWel5Hk47f
 BbHSCCjRg0QdgHXpKPypc9e2EYD95Nm0bgw557GvZ+gc6VswfQPdLv8X+EqA0lXhwF33
 BrN9iSy2UupDEedlPJZ+TCY9FY57dr2OYh4eQ+oqu4Ol1SFElTmc5VniT/zHElcIx3XF
 XRLQ==
X-Gm-Message-State: AFuF++np04bs0l1i8wM+YXy0sBUFtH6dN0mc7pS6jlPdYOr8auOrwXRi
 dZ8/wMR948h/p9zF9r+puk9H4bqfOnXVyGmJG/kAYPyHI0DbD4n/A4hbxsacO+LrKaUAjnQ44mM
 lPVQUfgU=
X-Gm-Gg: AR+sD13GUKT76sroonFavwxJIDbbstlBnrLpMfB3ahBYReuM07eFAXfTD2d8TOV+HVr
 vFcVkSAZODSVi/qy/p25hz9yVy3RhREcquCS2DU/jJ4jJnIx5RMaPIyl4xc1Z2ZRhKdu94yMzGW
 f6eR6Bt1BypMDJE4WSe/MLT9oPMcO/zS4jryQYRwU16dQW9Emrmx3Q3g3HB+s+m6fkCAfI8Shm0
 9dHBeVmVXt89EvyBtapvPTp7gt1ZzRh4LmytKTiGxC7s3kjIrHFgrjNBlxUIraNA+HRHaXn3s7R
 +oRodwFE9TSCRIti+/p1oSSjglo++q4mbXJuUi8Vt7FaeM5tM0rD/gSLkfSqbyUwzu/q335wJrZ
 /beSKoP/oeVWTlZm+4aIoYuaX8OiCvzO+iVsgp903r9XqbJ3SclpUS8pRlVPNxHKnpzpoIBHwqc
 SDU6mMBIU1FUVRxMqb5ifNXRzTegoFn28gOBSo9b9Q5sqB9NrfPEuhKSxT5nGhL2DHEuvMP2Tpc
 IhSbwKwRJE+PrgK2myI8q9IvpX9
X-Received: by 2002:a17:90b:3e48:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-396d0ebd7fbmr1790042a91.7.1787852506843; 
 Thu, 27 Aug 2026 10:41:46 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b112b57bsm3778421a91.17.2026.08.27.10.41.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 10:41:46 -0700 (PDT)
Message-ID: <fe07003e-e3a2-429e-a0ee-9bc8525fe198@linaro.org>
Date: Thu, 27 Aug 2026 10:22:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] tcg patch queue
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20260827044502.778915-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827044502.778915-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 8/26/26 21:44, Richard Henderson wrote:
> The following changes since commit 562bae590f194fb590beb5c65da44fc35ab9f64a:
> 
>    Merge tag 's390x-20260826' ofhttps://gitlab.com/efarman/qemu into staging (2026-08-26 13:40:41 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20260826
> 
> for you to fetch changes up to 01e1455139196cc8d6bcde7d2f918348a90f7f26:
> 
>    util/cpuinfo-aarch64: Fix build with older glibc headers (2026-08-26 21:25:04 -0700)
> 
> ----------------------------------------------------------------
> disas: Replace straggling CS_ARCH_SYSZ
> tcg: Fix typo in tcg_gen_hswap_i64
> tcg/aarch64: Use tgen_brcondi in tcg_out_qemu_ldst_i128
> util/cpuinfo-aarch64: Fix build with older glibc headers

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

