Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBF0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 13:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc35m-0003DT-CM; Thu, 08 Aug 2024 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc35j-0003Bm-SV
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:22:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc35i-0005Pr-D8
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 09:22:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so1197658a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723123324; x=1723728124; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HxxYYRK8xPTAAtZz4NBF3fw+c8MfAmcqW7ro9vjYwEo=;
 b=SN3uBryP/ImKuxQpMSzLC+LdCXTW88kfDiQWNVtoIxZ7d9GHosCHCth5+YHRdq478u
 c3b1nkTztfFGjwWMrH6EgLwnouH84TR6wWIVPDz29pwcjoZ7SdtddhLWVZeaQ3QSUNnm
 vhBL1zvdzkhWXzTKw7MORrw+RKZ+A7BDcRFg4IQ5ijp2eGdR/pVGDVjP/geEkrxJ7yBC
 V+dxmEJZcmv5za6N8XQRRpz6D6sF4+62bQJqtPl1AFhWHhusK2KlRNQmOl5anNAiRiTv
 cXSIMQl6QjNRZBpbFr9dHmZxHkldxOOF7S6VG7hICGPMaExLVvw/mCH6NExjKrIW++SS
 8vDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723123324; x=1723728124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HxxYYRK8xPTAAtZz4NBF3fw+c8MfAmcqW7ro9vjYwEo=;
 b=lnFswmPBSYijHWlZhmqnjde7464C8/mhrCjJ6g4qhDKp/OF/+vH5x+zL/IhhC+EU+s
 fE/PyJFafXz/EdBK7C33RhDSK644ypxXtsyPXxEMc2ppepE+5+bbyuxvFPwRnioj3m2o
 GHxwjfvbwCVQm7zVrYqhbLN+GUYC8+ysZd9KAIWCgroCOI6P3bviuAtCkITqxmKrnaqi
 DFRIs9BpgYPsuGMdM2QMCuQqxFrXYK3TDmIFj3rufk88+TbYZ7MBme0sN560asUd2io2
 jX8WAsLhaD5iHyPVlB3cLtO38i563YH+qgpSUBX0WkZOPidwAopNrrSE/LrJjxGJ/5Ab
 jw3w==
X-Gm-Message-State: AOJu0YwnDIT+EO/Z54mpDf3D3gR2BZLttkhYd0OzJSn36Srd4NrYG6vX
 WTCkq9U24VbrYo82zpaOqiy1zDKbwMLO/LChFspY6vOV0eBaRrbQP4mWf3u31XT1K5XW948oCay
 6VcEF0P26Zlu2hopsM8qBXrmdDcFa0edDoprYow==
X-Google-Smtp-Source: AGHT+IENwk0JJig+wlmorFIG8Y+e4hsuLXVcuud5kPN9abfWQLkHektnO0aNcixTDRAhgq5NDZsMO692ZjGsT9PcieU=
X-Received: by 2002:a05:6402:458f:b0:5a1:fcf4:6016 with SMTP id
 4fb4d7f45d1cf-5bbb24113fcmr1151767a12.31.1723123324235; Thu, 08 Aug 2024
 06:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240801140609.26922-1-jim.shu@sifive.com>
 <20240801140609.26922-2-jim.shu@sifive.com>
In-Reply-To: <20240801140609.26922-2-jim.shu@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 14:21:53 +0100
Message-ID: <CAFEAcA84TVT+Op+ERLSxqKDyE0RB=gfoHUSRwo_jM-eZjwsiTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] hw/dma: xilinx_axidma: Correct the txlen value in
 the descriptor
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 1 Aug 2024 at 15:07, Jim Shu <jim.shu@sifive.com> wrote:
>
> Currently, txlen is always decremented to 0 before filling to the
> descriptor. Keep the origin txlen value to have the correct value of
> descriptor status field.
>
> It will fix the 'tx_bytes' statistic value in linux axi-ethernet driver.
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

