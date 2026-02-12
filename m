Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B029BEE3698
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZRO-00063g-Lp; Thu, 12 Feb 2026 11:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRM-000639-Ms
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:16 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqZRL-0006Rl-5V
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:21:16 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7964f1405a0so652257b3.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 08:21:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770913274; cv=none;
 d=google.com; s=arc-20240605;
 b=D9meffw1if+jB22q2jZMem0TQ67SeFBhpiiQzfE+za9OPH/yvAXvRsPDqxZtoiBBIA
 eDrkZxPUYFnql2XY9gZQkuAWjDzLboENIkF31BVjG1c80TkAaHE5FdUDu5Wt41t28G8H
 iHbTpoeAQZcC2hAT4og2WhZSRIWr8zdn4qtiHyClhudQb9w8mbEqtL4wWTCY8CURDICa
 /qefFc3Kbc5oT/k3qbjJ+JiiGEijDaHMhYiTpGe4pKw+XIgakQjVkHxoSvRIdmWjvV8R
 yWmgyE/YndJigXDKL3brRNuFVjY4QDrHheri5zRqOYym07gpW24rPK+MrP8PdJqz6SHu
 ZV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=J+hH5QHZ6MTGHjJRM9ctVaK2HdbK8rHKvehtTlCff5Q=;
 fh=Ka5Fm2uGNoMN6LvftSCwVWZ6LDxGZumgYDW+5kU6bEI=;
 b=OtwSTU8ez+C16tia0J7cPwAWYRgt/5F+mH9k5R0LHO9sSTTTrHCfWGkKZ9WV3WRlyi
 AbJGE79NHAUloNvnO3I1y/EyebwhNsE2ZkUdpZ2QZbqaPwy+sX/Xwg25CsA7jSvkGOKX
 kwjDz4kvfBU7lmcrzyZhGEWIJ+V+cTqD9WZMEjcS35Zyx87rnqAaekggpFpn7d66KPq0
 +cvjkeMS8pMZS66rJq9PMTkmhi3ZQ7FaU0qN4wYwLKjdY9mhqPDO5XT9q0YqBmvneMO8
 4rUIVEazgBanHk1WxFMFDTcyehD49oNvdh1obkg7f6gcYJLPO3j3mBNFILxIF89nbFxk
 Ad1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770913274; x=1771518074; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J+hH5QHZ6MTGHjJRM9ctVaK2HdbK8rHKvehtTlCff5Q=;
 b=hnhibW2JSnDNYsfyOC3rPmBwUsK9EY2fxNfAFz6noUfhWMOGZgNR/tT/8ef5Bl0GW3
 64K9lRDyV9ERdGrt7t/ZUV1SLH0pej6/cBapIrr66Td+bugS6HQ3yAwXNKhK8dQYzZjV
 vMdWKeqRhSv9ylCPaRdWrG4XLmFFLqgnwLNYwuNmE4cbUeuJLMe9hvivSN786ZPWGMl0
 8srZLDPX7GDzT09mJ1n5SuyF9HR/mRUnIXYSMP9dsKxHijmEw+yRhZxVWW/VCOSsnYos
 niV2p20uq3bzZM1UmtlnHjrSAodRlAjihMl/nrPTcQGj9HrolbhHovL4SiZZ71PhuGuR
 lH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770913274; x=1771518074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J+hH5QHZ6MTGHjJRM9ctVaK2HdbK8rHKvehtTlCff5Q=;
 b=skFKAdMF2wMrnRH2vGsnQHQmsFJeSCmyj+TQgpEImIMd+06RD9ze28HxoSKlnl8LAe
 cnSb+/ilx47INMhyvbDqakDwTEDPgbaF9gwqVcknZNgRayFo+Alr3JMJzcaHoUaNHy77
 cQAIE8rFvZBk8CCHrVq+r29SfnLuO/eiv/Zzne0xjMZdTeXK8SvEP9Hz9HYUyxfRv49m
 t8HTiHBZymz2LqiEfVcOwbpjlocf7KHSSdFZnqWFIjnkTwARXyridCuzxrM9AGHTzfpY
 oU2ibv7bf7+E/UcedIF17EYQGyO5LWPxIemTGwMBif63OYhtFgfOPM0BX7i5msDFq9Tl
 goTg==
X-Gm-Message-State: AOJu0YyWX6hZzJy2iayfMLpFJJYWznnKqTmgp8nYRRbplbAT/dD+9KdF
 OnCFom63LUNn8cjgw/ch69kSfbQ4G6wkv1Di21WVJGMDUJj0hsSJ4JwrPh7cVdth/Yvwka3yFIG
 /yjwcr4jE2D54sDAXqWsGvgfmQpcA0kVaGsuEZVEC5Q==
X-Gm-Gg: AZuq6aKc4wOIGoE/L+JH/DzgJ1H3qovPJA8IWxOmdfR74eXi8lGE7H/+9eNPI3+WjCW
 LysGF0V0+A5ih6CfzKVyfwIlOU5HScqczsRGyXAQkxzOy+cb3MiR0u9us2cIafVToyzXYS6K+AF
 MIWWYRkWo6/LiOuUXy2vijujh7X4Inw9ZxjplU9HGI7zZRfYx+V9sHsBTnMHdNIRmQ4tRRm2Vm1
 bPGUHE6QGhPesczS556Kv5+XUaoTfW63JsLtAYY1kNCdA0/pJk/MxIYm9x2wlEpp+Ee45/iABs/
 qVusG7fsfYRqeZquXDMTEzGFT/ByEtVzECa5LTfS2pch4Q+UzYxD4+Df/yd7vqWSOL4=
X-Received: by 2002:a05:690c:c24b:b0:796:4626:7433 with SMTP id
 00721157ae682-797377aef5cmr27693237b3.46.1770913273723; Thu, 12 Feb 2026
 08:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20260210225100.1573968-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20260210225100.1573968-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 16:21:02 +0000
X-Gm-Features: AZwV_Qht3pv7NxWRJISp-BF0aD8BfH_btjEqlHwDcncd1A6UgsHReD2vZ9Gi0f8
Message-ID: <CAFEAcA-HsnZuFNoVN3dL5zHN7mpWGSd0jsNFNXq3ahkMoB7RxA@mail.gmail.com>
Subject: Re: [PULL 0/1] Plugins: fix windows cross compilation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Tue, 10 Feb 2026 at 22:51, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> The following changes since commit 0b91040d23dc8820724a60c811223b777f3bc6b7:
>
>   Merge tag 'pull-loongarch-20260210' of https://github.com/gaosong715/qemu into staging (2026-02-10 09:12:38 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pbo-linaro/qemu tags/pr-plugins_llvm_dlltool-20260210
>
> for you to fetch changes up to b0353beebb0c4fa4059c88362561a8362ada8b4c:
>
>   plugins: fix cross-build using LLVM for Windows targets (2026-02-10 12:58:31 -0800)
>
> ----------------------------------------------------------------
> plugins: fix cross-build using LLVM for Windows targets (Mohamed Mediouni <mohamed@unpredictable.fr>)
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

