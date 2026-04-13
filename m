Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD4EF531DE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQPy-0000wR-4O; Mon, 13 Apr 2026 19:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQPw-0000vU-MP
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:08 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCQPv-0007RK-4l
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:10:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso53074155e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776121805; x=1776726605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nT6MBic3zRD9hJ6QMNU4WWheucpSrr5PGWxkNRXjzPc=;
 b=qWWFM0SEWJXjCzw0nrAzh0e0voFbrs642O2kf57uE2kP9HgkxDDmhOyc3jEIqgaj+e
 T6cUEULIQPLpNKuPJ7JCC8yR5r7GlOTS/huGRUK+XLiWgZ2UtykCbF1QUbg+lVCcGODt
 SoJmpbRKTV8ZHI+X6Bu4NdSu9104WjgNQHLtMQD2hP+b9fn85deGzDHpHzCkAIP77WSR
 FM4Loi0qKUlFgLbKeSjQtj4hOcAQv7PArKShQflbjTi5doWWxRUwOtwEl0/BRbHXtEZz
 AVpX5kATjRPijg1u+vEJHPiUJWd7a3p7egKOnLv4UIQ00vTzBi4JO8Oxxs9nT5JImk5N
 KWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776121805; x=1776726605;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nT6MBic3zRD9hJ6QMNU4WWheucpSrr5PGWxkNRXjzPc=;
 b=mm/ppXAaTjDGHjqVwMe0lOYnbf8NajlA4VzZoIw+U4OuApyTmSXszV6Q1s02ujAkWz
 81lWxOTykPx/LDE89YzlSgYBfvexEaA1ykLQja6Dqyn72kwVz71wgNvi9zRupe2Y3fyQ
 2eyT3C4GWISQzJF5R2N3PZ3ge0fqPP0u2NnmXXh2JNFRPheFYN066ISNHJRmcNIcm5ha
 +zARgSeJEm5t60XaqimDPcaXdZBJe20locfNEe2rbcoCM4ctN3bLM7g6sOgyi+S0tA1p
 DEW63HLk+uHCMzciLoVxkWg4ztCSiocS80Do9Aoc12hCaMu332Soymq3o9ThPtZjJO7D
 R63w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8U3fZSvMBqrVt9d1w753chfOR9O6xKCMAGQtWGys2zX/m3/81DFv2Fm53TcORzQlp/wCni40kFzS1H@nongnu.org
X-Gm-Message-State: AOJu0YzJPjJaP5YiKCIy5G/b9/4WPYPL5TK+N/YYr6aUWdgypUlE/LNc
 HwiAmjB69dZNdPb7GhkhfWA38IFillVW2h87dGwJD49a94qT46f2ELNy/36luaL3b/o=
X-Gm-Gg: AeBDietZ8k6glEMpnJftJe826VyLePJioz7wcOhrKklBjgoUCpPb2fvwh0OzOoSgovM
 ZnNWMUY0K8KAAtAJjfhzavuwFSiwXppjbEuIMZHyF+4rWrcqooHO6Nb+a++dWaRsNLPR0EAaIgP
 dayYD/cNYwjFEJNEPak30w0xqoqGZnJcgENc5adXE21ANi6ZdbP+DRAQNkhMNLFIXlvlHWLptaP
 9GP1dOrUW3DrlVL6ICbuCYs3loSRXg6tI4Zcq4hw4cLQ32ecXPFbpj9xsgBWCH9EXDBfoG8Dx8y
 o4suw8lS8Xyu2z1W6DX/mY61VJG8g+zG9p3SG5EIdEgPXW49Us+YfBU/gp9s3ymBjeYQBpFLyS0
 y+zzEDreDTJ2ex4H2/iuDSMAVlVn7W4/NT1lj6plGzqN17e6SHXxTu6F+8yqJpSDwM+DwZo5PjH
 1YcR//NeW9qkDsuztTBueZSfH2wgt42q8s4/kvYL6m2QlZpE54o95H4UImpoNFgkKYSg==
X-Received: by 2002:a05:600c:c0c8:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488d67bbc13mr151085355e9.4.1776121805586; 
 Mon, 13 Apr 2026 16:10:05 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1e217sm2977515e9.5.2026.04.13.16.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:10:04 -0700 (PDT)
Message-ID: <dd333659-7bb5-4010-8bb1-515347b1e313@linaro.org>
Date: Tue, 14 Apr 2026 01:10:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/65] hw/intc/arm_gicv5: Implement gicv5_class_name()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260327111700.795099-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 27/3/26 12:16, Peter Maydell wrote:
> Implement a gicv5_class_name() function that does the same job as
> gicv3_class_name(): allows board code to get the correct QOM type for
> the GIC at runtime depending on whether KVM is enabled or not.
> 
> For the GICv5, we don't yet implement KVM support, so the KVM-enabled
> codepath is always an error.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>   hw/intc/arm_gicv5_common.c         | 12 ++++++++++++
>   include/hw/intc/arm_gicv5_common.h | 10 ++++++++++
>   2 files changed, 22 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

