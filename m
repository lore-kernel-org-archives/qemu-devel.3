Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA40ECD988
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 17:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2j6-0005Pc-2m; Thu, 05 Feb 2026 12:01:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2iv-0005Hi-2Z
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:00:58 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vo2ir-00048s-0h
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 12:00:55 -0500
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso1009177b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 09:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770310851; x=1770915651; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GIwG029PLkxEIALciyhg77ZlbFgT4Ix1hMiA2K++pOg=;
 b=LRz4msJpbWfIRO9MkCx1GsDdVtgYq4KCU4LB+enOvYc0viMKvtcjF53v0gblEHZ2My
 8lqvPsAJ0IFJGSOM4FXfrAWFIuOuf911le6RZIhMbROh8sMIY7imMTeYMf5pG4gz2NZd
 4IIc1QAbEn1gRvXrnNuXxNnB/k2psWM4oyeO/T9gDEhEcc1C+bgADy1afxQMnylMB6SZ
 h7nVCApqzF7sEcy39jiwl61EwuyWeq9/GXmmCcAyZf9cr7SHogfjNM54k8YWDgkqrRiX
 f6adlH3RVLlZP6+8fEtwxsknL4zmYzZgH84IvDAppaNzPMrE48yKYYGxXuhNJTLmarhC
 LkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770310851; x=1770915651;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GIwG029PLkxEIALciyhg77ZlbFgT4Ix1hMiA2K++pOg=;
 b=O1/s/BXnAlTwAxmwpKN139D1OhOYiXThnDTE2pTPOy+rrTyMaLAy0c2X4I6mEoCopS
 yj4Cfo/pJq2RnZRDkwO34rcZgBi4i39rQxkorLZHzg1Fub+x65seRdI9J0FjAGweDZi9
 2Pz7nOt6fUIhl+9X3miSgb15WzM+0t4k3c+xnWa4Y7gA8F7/iVUyzTS77/5S0z+tshEi
 4gji5TxI3nwsJ2rDJMKUnXLSojOLTZqU5Y0FeQc7T1N24PoQOR/tQLRGtVIX20j2AwQp
 ApbJ0oEAIfP75szGqUGFrVcVVfnnljCnLpweJ5qKqrDsgDsUz5LwMoy1g6fE7kFKoFlR
 XAcQ==
X-Gm-Message-State: AOJu0YzCuLm3OWrJi/WrcQMUlX7VxzNvUoVVgiiY0SZetkuuujTJNqiX
 28qt5b8YWKoBGPqm+GHfqAOy1sqB71sXQI9SAAXs9iM10tExfHs9Sdny4MzFODVqD8A=
X-Gm-Gg: AZuq6aLJCT+LWPhJ4lfTJfhgCo9JA2G24sRT1v6mgPa2Gdi8/3GMVtUPap0pQa1N9Fu
 y/tacBe1u2WACVRAeO8+rQtHy3eg+uXgenDIAk1Yt7AXV3fWJdk1nEAKjfcNnX2Xgk6zw2vMPdv
 ODAnYblvboSy8f7uYWV0+fTdtYQ9DJb3FA398fRVMLNBR4WDChdfSoJOovGwOC7hj0+rrNQJslR
 7/ymr1ZXUmWRHAxbxOMte+KSO/dGwxFtA5xrHXbV+LrxkP/cH2YWCSAJSKSgJn/x8CLHhLkMFOB
 gKJkuUi51Ky8x1sDm2MWBAYgVBWpIvtMYeWTfN3fgdbKyS6RWPJbg+uk1u4yf6eA0VkivNnX05j
 +2O9GtrE6e+9z84XRoNmN3fO9xf2vGbjyTOajMDkuzmpzAcR97Oe/cLz3bx7ii4T0nS3TduCUoz
 oVm2r1+KrKxSOFdgRq9U6+bQwE+bRizuLV3NZEfO1HU32KiwaMAYRC
X-Received: by 2002:a05:6a00:808c:b0:81f:3f03:6846 with SMTP id
 d2e1a72fcca58-8241c64b0a6mr6306567b3a.47.1770310850819; 
 Thu, 05 Feb 2026 09:00:50 -0800 (PST)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8241d47dcd4sm7549244b3a.54.2026.02.05.09.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 09:00:50 -0800 (PST)
Date: Fri, 6 Feb 2026 01:00:45 +0800
From: Max Chou <max.chou@sifive.com>
To: =?utf-8?Q?S=C3=A9bastien?= Michelland <sebastien.michelland@inria.fr>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Jean-Michel Gorius <jean-michel.gorius@irisa.fr>
Subject: Re: [PATCH v2] target/riscv: fix require_rvv passing on non-RVV CPUs
Message-ID: <aYTKYkBT7kWlcdpx@sifive.com>
References: <20260205125255.1219082-1-sebastien.michelland@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260205125255.1219082-1-sebastien.michelland@inria.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2026-02-05 13:52, Sébastien Michelland wrote:
> @@ -153,7 +153,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
>  
>  #ifdef CONFIG_USER_ONLY
>      fs = EXT_STATUS_DIRTY;
> -    vs = EXT_STATUS_DIRTY;
> +    vs = riscv_has_ext(env, RVV) ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
>  #else
>      flags = FIELD_DP32(flags, TB_FLAGS, PRIV, env->priv);

Hi Sébastien,

This v2 is good, but there’s a potential bug when users enable embedded
vector extensions (e.g., ZveXX) that aren’t standard RVV.

I suggest that we replace the RVV check with a check on the Zve32x,
which will be implied by all embedded vector extensions and standard
RVV.

    vs = cpu->cfg.ext_zve32x ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;

rnax

