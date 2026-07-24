Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90152C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBcp-0002fz-5p; Fri, 24 Jul 2026 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBcl-0002fJ-Kb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:51:19 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wnBcj-0004yM-3e
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:51:18 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6688acd1a51so116733d50.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 01:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784883075; cv=none;
 d=google.com; s=arc-20260327;
 b=hRYkEu/o3hRi9Uv+5tbxQY0opYHEGXhyEuVCFu5SncjGTqvcGQtePp/uAjehllLn6o
 i4Kipjd+89otrjweCHwdVzmrAV/zOwpUHVqFt+siy9at0eIiBTE4tBSYZdsZrme6Vrns
 +uLi68gWtqCY2fXtND1qWEzqyiu6Gih4uirlUuy/vLk/Bj5MF+fKufRl2qiZiCJE/SEp
 Flqdf1LYCWnomTgQ8MiOwgGxaHX2J2SsTJSrCDzBM6wWF73QKXQ04kuFssqJ1mGsUzRJ
 Uu/lqEkyzk9MX6Qi0S1HFMrZ5TIgY6+Jz47Q0RDaNYyboTa3Iwxj3YHRBZa0GeRXxwdl
 Bj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=83DBOW8oqGPBXm4HlQaeqeZrwMM6Oa9NcxRXyxiT6dg=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=U9ybxRu5k6m+6atlHJPlhjeyVQBe707GDeBwTomlVq+8YRv8Vis0DdTVwh3ztDY/Dl
 8ySDf4slbZ2JZ1EJnMDnYzESJgmrgvNoeNtJPr/0fFOUXjatwlbRCSrrArI9P8Uu0r/f
 xtTk6DSMDJ89GN98YLwTF6MG5W4hYq3eIDx0aN48GRNYFG4CAH/kSBTN/J4LIb206veq
 ipTzd0h+624+Mvz2dIJUfmWQTqhh4SWXBPIGWHQg7Tl6HaWAq0BblRZO36919R86F6o/
 AmRWU4Q2mJR7Jvn0blUaOJziPvFOF5T55lu3l/1aopPRvhWM2VgRDofd4nf1Cu8GatOv
 H1tg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784883075; x=1785487875; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=83DBOW8oqGPBXm4HlQaeqeZrwMM6Oa9NcxRXyxiT6dg=;
 b=EKt1ppgFmsdU8czLtVcvZBeZ+Nhcef+c1NUxNHM8kT3QAftV+AoU46tRz2YFNEJhZk
 juKQntTdynTreIdlftR8A0r5LeJSjjZ4BVq5VUQJJzbKjc2Qxix9SRNJzLbsPCKGOPqK
 ci+I/Dz4fQMDxulHHwnKY7tRl6vY58XrEiY8JCbq9TxdIAxJWL6cHjsRRanN4lZ4FAMQ
 T7b6n2gMERUdDClkQeWqxIXCGxmnrg/NWGURtBzLgJ/9T4OhThfR1WD9GK+xNWOfqiZR
 dICH+SPwWALNviJe050VPzZvizQGrZuOBD6OBuzTIpGMPA9p/qMCmsRaXiEMP+LPYnFW
 8P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784883075; x=1785487875;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=83DBOW8oqGPBXm4HlQaeqeZrwMM6Oa9NcxRXyxiT6dg=;
 b=ivRLoOfBM+qiPyYsL4ykFiy1eZKOc7UALDffeKr0oXoNFVetmY78/v4PggK6N7NuG9
 PpgseXYq66uqGXULts59oxw2Ock5fKwiOAh4Dxld/dmFfT1XBrmo8P+4WQ/lh6wOXsmA
 EGEMq4/FJARP32XpLA3X/H3IO/oa36npTq+1oXWEpA6VZHXtTQixMa0T6jlXzfmiVpuj
 FCm/INSaimYuN8np4zHl4oPnUHTu+ZrXL1fiIdX7Yq8Fo0vxRMu2Gv+D6G1vXKn94rdh
 QY5+R1t4smx5xRxazyvEcqbdTaOOgu8hC51A+J8iumSEMn2KY7c6BCndwcUADiuvI9Yt
 yL+w==
X-Gm-Message-State: AOJu0YycFKakgVdKIU4NxbehdFGBDUiwf0i/JBcYChrbV0bfzae28r47
 cxzFrZiVO/tti1omekaY8Rb9BzO9FL9B/zKHGCEJWbvr0hEd+2cDcp4WsMUSt0njdqZ6tEC5wx8
 qAdKdWQYFD+TdXrTsKSJBokewcwYURJfEFmYMMz2GfA==
X-Gm-Gg: AR+sD12V4jXkp/WtnhlVcX0B+Lma9ScfaDpOH+JKtZjwT0mIf/Iu/FAiW2+QDAlIIF7
 ZqEWUcUbPZWj/I/iX4nYgIDfWhuJ3h0oAWs3pQxIwGNYOx2Q0xlFPYIDsFu4irPaMYzM/GnXrbf
 xeS2snvV6PiNP0d3tnW1vZ1SqWog1s06qV5i2uGq5qP0KOJL+Dgfi46tndBs6t0HgHzUMJ4NxHH
 dxmYjVA967D1z+zgfKXTaK3jVIL+1opqV0FXCoP2sAdeilT51mJmEZAILAuksXgqb6qRDM1LfY9
 LGfu8+/sUBtKagaiJ8TFvErtdbrCanXiJW8Z8ZOyAZn7b5qvx5iek8Lk
X-Received: by 2002:a05:690e:2504:10b0:667:f20a:4cc8 with SMTP id
 956f58d0204a3-668a4fa438fmr1410038d50.51.1784883075505; Fri, 24 Jul 2026
 01:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260723233605.805-1-simonxhy0404@gmail.com>
 <20260723233605.805-2-simonxhy0404@gmail.com>
In-Reply-To: <20260723233605.805-2-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Jul 2026 09:51:04 +0100
X-Gm-Features: AUfX_myKoo3QaeYZUQ_jABz2gDQLLlgmCQErJTkBCf0s2CX3tFqr9yU4rGlaXGs
Message-ID: <CAFEAcA_Ybrqb0g-cZYf6yL2eHRUZ6PfeWQMiVrVVeFJFp3q8KA@mail.gmail.com>
Subject: Re: [PATCH 1/4] target/arm/tcg/cpu-v7m.c: add cortex-m85 model
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 24 Jul 2026 at 00:36, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add Arm Cortex-M85 CPU, modeld after the existing M55 CPU.
> The new M85 feature PACBTI is not implemented in QEMU and the midr value
> is based off the r1p1 product revision identifier.

The major reason IMHO to add a Cortex-M85 model would be to
have a CPU that supports M-profile PACBTI, so wouldn't
it be better to implement the feature first and then
add the CPU and the board model that uses it ?

thanks
-- PMM

