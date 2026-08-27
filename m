Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE83FC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZKg-0002T1-Jr; Thu, 27 Aug 2026 08:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wzZKf-0002Sk-OE
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:35:49 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonb@tenstorrent.com>)
 id 1wzZKa-0006Ln-7G
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:35:49 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b15c6fb864so1990560e87.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:35:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787834141; cv=none;
 d=google.com; s=arc-20260327;
 b=f9anlRoItGbgT94vQXzajl2bDnOGbPq2K/cBr6MoynLtx8RnTTCwmPCerBdsXQVUhC
 rehIun02kWlCbEH88bAFquLbQeyOQfrnCQuC8MdtO2JWxFb8ppMtB2D9eq3uNI+AYTbo
 b5bbO7Nt/BSFm6pVpevlIq81XlLRKY69wfR5qG5m09mogeHmpwbmlQVBvbn6UQ/a5G7l
 gOK4RnwfekidCbVoH8fL0mXcEIz/l4iwYX1pQjDbwNk9cTZZT9UQn3H/FnerX6Z03vS7
 XHFWewQxK0LFVBMaJLJbH95PMexy/DEFAaDcpbcLp+3E/p7J1QoGMFpovKDgvE4oX0I1
 1XSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bmBiCjz4FpP+Mho9Hs6imIP8cwNxfTOgBgowViwavFM=;
 fh=JVjhD0d1qV20tgfiFXJkiL0YeDJV7KC7pkJHtQ8h2YU=;
 b=gNypaw66a/uJwxcVaf89+KYWysRhgCVB19O/PJHlKs5fXii+rTzlICnLYNQVBypCw3
 869f9ReuXubJahZhQzHw8MuL+uKtSFIzK1cwZO/3OEayB52WTEzz0JGtoajfw50ZIXa2
 ybx+Ld/CPdbm6/afzqhK5uZG0bTVg8lqj3RghUOS16GogV6ibWu6ovsmqgL/01woh4/b
 riHXSqTQkRQNxcffDuKJGC4XefhhkoMw1BrCSUoM2HihGPipPWEnlDiehd/7RmVv2EV5
 xFBC9WMIfpNG5tGYTP33XIlh0SNravSB4Gx/yK8jrbkt1df9bg9hrzBFjVxl2g1X9nt2
 hxsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1787834141; x=1788438941; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bmBiCjz4FpP+Mho9Hs6imIP8cwNxfTOgBgowViwavFM=;
 b=Xd919A4dj3zxevWSTKP9Y++FJkVxGyZvLTbnlmCXrGe4dx39eiKLGAliu/9nV7e4cC
 9+7mDUIp7ctC0K5ocLWTDHT/y/UhVtGBF1gfOgsroVANMWSKSz5W+svaSD2Is/2Fx9l5
 OvP/zNI+etdLcxHHeu4gtofKE4eEl6Up5CyXHO3LXRJtF+eAk4qCTeAYE/bGdlKpJ66j
 dwqqEcLwhM5jDs0/qX4Rb03nqc9o4E1lvbD5mZ3mz7brvQvjz8//+8zOL421qYa0GO2H
 Tj+bJysAuMGCeyLACbhaJMcn9JGQ/Wl/4ENu2gFJjt4IXjv/VyQFKGzlsKKQonynbIud
 /2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787834141; x=1788438941;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=bmBiCjz4FpP+Mho9Hs6imIP8cwNxfTOgBgowViwavFM=;
 b=R5mJ7fqwAI3tKG3xExJ2qAtzsnkAU6THXvAqLrRJ07zcmCxBrQ5MGm8L2XfpdSNHD+
 2gr1YTfgb7JVduFznvsmls4TF1/VcDpKXaApp7JEkgR1PDPdQrD2DxvEpmwLVOi2K6x1
 KKc+q0KVzDDxKCV6/wM+sRqvKsmjshS6FGysrhMgbA4JQ0BvucaSb44q5E1RFVKcVWwa
 Pf85rKuLCvPl/6pdslCbI1ewdcUzMi/80VsOCAu/VfRc/wtqt1LxDxBr7L+Q82aNo088
 he8km8ef7ikzVMvNsGhxYMu6TuhYbYAI7yUyyfbiqxevFVnljGFWiP4kFa4mkIqtfCiz
 SflA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjUNHtsEff6N4LkGsyZtwYotcX5UGi1t8oTQE2w3WlKXwVoPhgNtha2EC2zANHeLvHniuVn3UEkyqd@nongnu.org
X-Gm-Message-State: AFuF++mx/EzCWIjfhm+ZCoSqGD9C66spw3eE8/IqIcqF5yqrIYrxXoTf
 r1SV4719XWeBq1oaCfrZSB/cJzF0HcSmaIwtTOklJiFL/1q1I54nlwid4T2xaL1+oxVzCHS3rZd
 aRInFd7sI0emsz/rGGW5EAbdRQ4EMLfaQv5LkHTk39vc1OxqwdK8QahMbIw==
X-Gm-Gg: AR+sD12OMIpV0YhWuC1HAYflX5cA1WYEgugE8ZBioSpQ4TqqT06qSZgNpNC457oRX1d
 YCcJJXw7snFP2Gnkz7/f0A+Cdbj4bbDdK7q8+C5c/zzCFbSVOrw237l+SfhU395Nn37CmkQ3Igy
 IwjxHY9hkLqYcnEFgjN6CmllqF+iN2lQiyj2orTG+hvTAFFMiDGzK58Qlp5zT8GUMIx1tauJQe8
 ywioa1mSwY86tLFbfAUXkb2gG8v5lG7KTVrq7sOPMvkx3MvHKFh3hyoGQUq8mXvDinsXXw/PItu
 GUED+eJNDf5CrPoqLRAtHb+qJirJHM1BB6F/y6UTauNRogd2FFqrNwOiDRVryE91NqLJ/Qf9Rw=
 =
X-Received: by 2002:a05:6512:6d:b0:5b3:e02:b3a0 with SMTP id
 2adb3069b0e04-5b4a90439a2mr4240415e87.7.1787834141422; Thu, 27 Aug 2026
 05:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260811104301.1377245-1-liliang2057@phytium.com.cn>
 <df5ee5defd5fd2363df46a61aca2eacb697cc9aa.camel@wdc.com>
In-Reply-To: <df5ee5defd5fd2363df46a61aca2eacb697cc9aa.camel@wdc.com>
From: Anton Blanchard <antonb@tenstorrent.com>
Date: Thu, 27 Aug 2026 22:35:29 +1000
X-Gm-Features: AcwNN1XiItSGYxVfWHWw4WP2l5jxpttKmGavz8HrMk6Unx7ewnIUXox8RcOFlA8
Message-ID: <CAN7m+mAFT2Cm2yvHb9KKRe6GH=Rg-S+8NXYSjkFhXEJS0wtD7g@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC PATCH 0/1] RISC-V vector fault-only-first vl
 truncation under plugin memory callbacks
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "liliang2057@phytium.com.cn" <liliang2057@phytium.com.cn>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "joel@jms.id.au" <joel@jms.id.au>, 
 "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "chao.liu@processmission.com" <chao.liu@processmission.com>, 
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, 
 "tangtao1634@phytium.com.cn" <tangtao1634@phytium.com.cn>, 
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=antonb@tenstorrent.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Hi Alistair,

> > We hit this in practice while generating SimPoint BBVs for
> > SPECcpu2017 500.perlbench_r under a memory-observing plugin:
> > the instruction stream diverged from the plugin-disabled
> > baseline at perl_parse's vectorized strlen.

> Is this what you were talking about?

We hit this with xalanbmk, but it is the same issue.

Thanks,
Anton

