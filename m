Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DDFC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 17:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhtEs-0003hR-80; Fri, 01 Aug 2025 13:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhroF-0005gH-MP
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:36:42 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhroD-0006fm-39
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:36:39 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8bbb605530so2847513276.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754062596; x=1754667396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yMvKXmjoJ303EF8Y4YrknUJIsr3edeY5ngcYh+NBvls=;
 b=V1Vh+RBkAUfroXjowQmru8SWr0wIEtjdKOfzheYg0zMuLDwsASelmVQIXbuodhv8hQ
 ffcXHiHTJ+iAPevWYUxC/PV2mwRitJypFF9tdOfL4RzXOHQ7cKf55cNMIml2tRTKePAa
 RUKcpf6Mm8ilqKI8l3lMXWewowcYUJVokfw+Xzn/cM8KkvWTV3kgMup44EYvdOgP4lPm
 grFvPBUzA6lBkur1YcmyMVzEJdGXBcwPkPkqtC/xG5s2cG1uBH9/e8L7mFCRW9XFWRsX
 i2eIhAwocHVNwtbepWOm95zy6GZXjLVAIEPvn5zKvVbGb6kCLbor8Rv4HqGxjBz//1gA
 36YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754062596; x=1754667396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMvKXmjoJ303EF8Y4YrknUJIsr3edeY5ngcYh+NBvls=;
 b=DF2Y9U/nSZTQfvjEBVSanfC5Iz6DfUaI3FQBfvkxCCQdTvJ+4i+vVo6HG++3BhgX+R
 FloZoG9Qr+A9vZcUlFaaGz32Y83nR139JerzVFA/KuG4FWKGMyy4u+hDG3IjjyEYKz7x
 zzrTEMyzbs+ORD3vzF/FWTn7gEhOfu66Gg/mta+pIEmpZF7WPM8IjSAW0acFYAy2x6w1
 esrz+Ygsbmcj2MeINtvLQkXT8kqUoutA1FHPfJX2yyOSXTjdl5L0vptjel030plFujrb
 NrmQ+lxlfsPcfZNUvDg7ZCLrLZCRdqJ38XymeG0oMYxYg6gG/zGY2gGn1YK+RtQQbith
 q9DQ==
X-Gm-Message-State: AOJu0YyyWik8+N8h4eqxiMpoKM+Zq/EcuCGWLooaYBtr8cVMt0Y0J2fg
 wrQ2UJIqlZOKDz0Okxn6KCNRqUCzATUooCwL2OZ4qXieu0mbPv7pQvG3b4aw4go6Mk9Tw1uRIgL
 MyqCaGkDOhZznzTFOm0A9IARWf5hoXPWrupY4s532wTv5QHwGsItp
X-Gm-Gg: ASbGncvTTNYmWI6/eg8nk56LJT/2a/u4hcp+Hs/PFsffHCwChII2g4RnZ6pu0yuyDMV
 av3eCgjYblm+BEmlIWnMA0IIPUcG7WTgayHLqW6yURTzOdugfJdJc/c61p4pjSiWpYq6xcPzE3S
 2vqCE22oh3EMyBy42ISeZ/ZK1fMcBCNh+UPmM/j+v/53kAIM7AbWGN1uLsi/lMhgc7vsop1Ey4w
 8ZsbaaI
X-Google-Smtp-Source: AGHT+IGbcqD1GAFvr2gP0SXIzeJZCQrU+hMnACHNq8mLrsgFvo2DzlE4dsPX9CWcyAkr6QQCq89c1L6mUtk/pcVX+O8=
X-Received: by 2002:a05:690c:10d:b0:70e:7158:6fda with SMTP id
 00721157ae682-71b5a74aa83mr81846137b3.9.1754062595563; Fri, 01 Aug 2025
 08:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-21-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 16:36:23 +0100
X-Gm-Features: Ac12FXw5JbF9gNgTBB34I_yvme559wvDDQLyKA0xO2HBPYrBZG7qlKNk3hD9gns
Message-ID: <CAFEAcA-0+UgxAUPaOyoPquWc4f4u==Y_enPEpi8WUq7rz3Vsag@mail.gmail.com>
Subject: Re: [PATCH 20/89] linux-user: Move target_cpu_copy_regs decl to qemu.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The function is not used by bsd-user, so placement
> within include/user/cpu_loop.h is not ideal.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

