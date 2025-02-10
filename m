Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A950C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUoN-0003Ap-Da; Mon, 10 Feb 2025 09:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUoD-00035M-GU
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:30:52 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1thUoB-00087y-Js
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:30:49 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso3613263276.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739197846; x=1739802646; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cFImeAuzMskLt5/hknU5oGD3tZhASYQ5K70QvKwOzuE=;
 b=Fs1CbZVyMKRF7N9vrfBoi8t/BynvVuPejUF3XDozeEiO/YtJLCe5IXwYWYi7ey8O66
 cdCVvWvb6dHtkV3jaDiWpCJyRN+1csTgsrM7e7Qo/nWbCnhoYMucNBHklFiW0i+XtApw
 lFhJd6ewMvMeviBkUF+XX0/XC2puXObNEHw1sItFsDZ5nJ6z+x0I/+tvupmLc42S7wX0
 tKQiIZ9sxTci/TeytrZOHy/m5nwLEw3ISfPdykx6AlovXBAcpzBOm8oABVC/8wPjvr9y
 FUP8ndWeAMZ/ZMYXU7C76KY3ff+l+XQQl34qPgg8kb5i7LNXCrH0GckoyFUsR80yMVYo
 V32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197846; x=1739802646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFImeAuzMskLt5/hknU5oGD3tZhASYQ5K70QvKwOzuE=;
 b=oevFgki+qwOsw5gKQwqOphTfvLc9XQ1k8vG60GUHntKc7G+JVn3CjSwAtInT0/Aoyz
 hUnlRxThc4DeSEfNItQxKQucOLQH58y8V47z/PpVSZc2oEKuou3NmJjPws0QS6fFVbvx
 bvFljDfDDiwkL2fIQ7Gp+qb0PJDzyDWXJ4Gfg8QQRccwh++xrD3+z4dfusV0PRP4ayiA
 5zpTrPh3+/CZYt8/zSDkk/dmyTCipL5/360Bh9HeyOO5KXLASDADdVtOAEyjV1anyZao
 41jOc7teNeOCvBXvItX/BEJ055lvEYJ4PvQQ7IQ4seFRzSmFlDGKnhG+fn9HE4uKNBbX
 WFXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5QI+d2v6Y5I6Z7x5xU92I2q1mzfi+V2WIeNtaHcLd8XEzYh3fLN86RfSySmyUfe9c20lHQuOPSsBa@nongnu.org
X-Gm-Message-State: AOJu0YxBwZER4ib/q3SXZRj8LrCdC4ynKJ4DFwWyroic6egaGTItDwi0
 0P0HFipVaW5OkFWaMUUrZ/hqjg6qDuZ9SKYXVMwfKDKaqT0U5IIWMbVdgv+4zLgNBKxWIWXdwKm
 wetiEfCn3Ho+/fJkqXiRoeCrkSS4uAI1gesxnvw==
X-Gm-Gg: ASbGncsAEo1dVTTXIFheRHKNJz6vGmTkKIGqpY8B6ftVpnhSF2+YuSNb5YDwsYkB9jW
 KSH+UPt+aByKcR0C/ihzI4pIbJ2593FU35I3hlc0jGv4FmlRmM/kmwih2JyNJ6fF5FyLZyDEW4w
 ==
X-Google-Smtp-Source: AGHT+IFi/AAn0pXfMcosLF+Wchz/c6K3W08w6Dw0xNOsnzByckvxcVv7LrORN87SgKhyTq7xBlG/QdWnQaNRStQWKw0=
X-Received: by 2002:a05:6902:2807:b0:e58:1575:6fa6 with SMTP id
 3f1490d57ef6-e5b4625a6cdmr11074754276.34.1739197845707; Mon, 10 Feb 2025
 06:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20250206221203.4187217-1-wuhaotsh@google.com>
 <20250206221203.4187217-18-wuhaotsh@google.com>
In-Reply-To: <20250206221203.4187217-18-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Feb 2025 14:30:33 +0000
X-Gm-Features: AWEUYZlVWYBwhAqjyoTwlukbdbNwAfr2Ety-Fy0KL1RxkwNmOq_Fhi04Bdehtk0
Message-ID: <CAFEAcA_oiCOQeZgb2LxjqYTL3yK0i52OabYHQqT7P0WVg6_C=w@mail.gmail.com>
Subject: Re: [PATCH v4 17/17] docs/system/arm: Add Description for NPCM8XX SoC
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com, 
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com, 
 titusr@google.com, chli30@nuvoton.corp-partner.google.com, 
 pbonzini@redhat.com, jasowang@redhat.com, alistair@alistair23.me, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Thu, 6 Feb 2025 at 22:12, Hao Wu <wuhaotsh@google.com> wrote:
>
> NPCM8XX SoC is the successor of the NPCM7XX. It features quad-core
> Cortex-A35 (Armv8, 64-bit) CPUs and some additional peripherals.
>
> This document describes the NPCM8XX SoC and an evaluation board
> (NPCM 845 EVB).
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  docs/system/arm/nuvoton.rst | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

