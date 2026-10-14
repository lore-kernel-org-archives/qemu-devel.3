Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788E7CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGt2x-0004lR-1D; Wed, 14 Oct 2026 03:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2u-0004jE-Sm
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:05:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGt2s-0002QG-Vv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 03:05:04 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c2e62319cfaso65388666b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 00:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791961501; x=1792566301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iFRBwBJ10G8cgvcqy8C4pgWaA6Ht9NjFn83tPt48rKg=;
 b=C3L+oK5iKcsEcK5fD9WLhDvKMjMn8GlQugRwfVYaQ4o+mZ64U9FevyhEL0wQP32KIX
 HwTVXYn4TSnhsEq7ybg40JTvLl+BE8NPWYrD/ZfzPw4iMCLOvnG7kt3EjhwGefoaty2E
 wryOmYuO9wL17ZxXqYp40kKJeFDvOSlEZifSP7ZHHVuy2bicF2OmLCtkRmzWHOvO0l7o
 lUoNGijMETHwAexecZlYEJp5b/kP0F1m2JmeP+djJd4DXHfZjQnh0AtET0gB6ngv26zx
 Bd/CzCb8p38WaYRp+MGj95O536zrVTqxMofO3k0Htf8/OMPbXmxiJpJ8XMvy+aiziboo
 JDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791961501; x=1792566301;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iFRBwBJ10G8cgvcqy8C4pgWaA6Ht9NjFn83tPt48rKg=;
 b=Zo5VxLfKDpjEoPzJdAwR8WlNn2Rwla00U9ppMOlMqNnEKNmIrFDD4mAntunw8p9G7t
 n0ZaMATFQRw39VAEmWhNladDj6IBzPgQlUvok6942N3UU6HrkaX89aNHjmCdt1TNflOl
 t359YAZFvGH2BcwIgrs2Y7HRJcZeASNcKPjRHPIiVisYqCivdYZwLEFjeeKV8AmPhCU6
 QKRIsK9nQFIjQ4R3uaBTXy7uOU9zWf0UvnD8iEjVg4QWO094bmBOOZa6aFYxG+6oLZEK
 4cuLZiya2s7W6CrxWB8X+6W7B+1l6sCmyvPNp3ofJN21Npbo1rx0nP12NGPHeo/n1nG9
 nejw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3UsN0R9KxhBN8cJjwv8IImdoVqDV7M6Krt5ivQokpXrG1UjCp0/Z3kQkt/4PsgD1JDFqrpYGpmMH2@nongnu.org
X-Gm-Message-State: AFq9FYJbok/nhvi8SJTDBC41p5vWGsQC8GuKG95ZMIk4dzA6Qpuj+LWZ
 xEoiykZFnBPAoFUh1Ldd5pGkQLHe5h3/VgQKSiY4wn92XHqRI4hvnuOMTn15MWIBiFE=
X-Gm-Gg: AYBFou0NSSurQMMXkXmLELHLwJQ/7medh1iSUbI8syNrb8lPWDpPZNqX1yrRJOLSDbR
 Sh7l+Y/gD5NfWfbdHgB4lsSXe1z91og19CsMHUO7Jd71cdHMKvwok0cnQva2Ea44LutibdiO/WY
 05eUCC2vFa11CpabxD/yzg6ZABnoo9TfxY9NJwIxlO7mzi7vG59IoHySBe5Zj7hfQzwOmiD9rhC
 OlORAemfmhp6IzrI/+J2CFOxFQViObvNFpXlgciW2eufnbUHS/ZuFghszf3Ju341vcjoeYn+DwN
 r3afobiwIQhfgvccDWXioZ5dT7ibEz+Y0WnYi/aEGypSs87HZL5PgmfOEagFOclsWdpSZYnYkK6
 P5wdxAR8D7nNzah5kFM85W6IPHC5d72EBWg6+OI8QQqJyTjLu8gYlcbVBdZIyvLiK/uiNaBWZ/I
 RcgrTcZg3E1ICHMiyty3nvuTO72FHM9i1Duv7fPtsSkkrvBZYWfNeMvvtqBB77wvhW/IqkQLNhx
 0qoa1jJvb59s5OVWdx2YfBJMuYOyVXxiw1kFkSLfjmYFnsMex/JaWzE8ZlVMGH8bw==
X-Received: by 2002:a17:907:d10:b0:c2e:49b4:ab8b with SMTP id
 a640c23a62f3a-c31a9fcead1mr1440919566b.8.1791961501193; 
 Wed, 14 Oct 2026 00:05:01 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de77606fbsm3736693f8f.53.2026.10.14.00.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 00:04:59 -0700 (PDT)
Message-ID: <589dc808-8e3d-497d-b4c0-582308d78e9e@linaro.org>
Date: Wed, 14 Oct 2026 09:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>, qemu-devel@nongnu.org
Cc: stanleyjhu@google.com, pierrick.bouvier@oss.qualcomm.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com
References: <cover.1791802312.git.jeuk20.kim@samsung.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <cover.1791802312.git.jeuk20.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/12/26 12:58, Jeuk Kim wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> The following changes since commit 615ece3c406b262996e569f29ea6eed0d81c4d8d:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2026-10-09 15:49:53 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20261012
> 
> for you to fetch changes up to c44c626e28f1c87e89decaa73756d081f069b9d3:
> 
>    docs/system: Add UFS emulation page (2026-10-12 19:50:56 +0900)
> 
> ----------------------------------------------------------------
> ufs queue
> 
> - Track and cancel pending SCSI requests.
> - Add QUERY_TASK and ABORT_TASK handling.
> - Add UFS emulation documentation.

Applied, thanks.

r~

