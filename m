Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DDCCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOE2-0001eB-Mq; Mon, 27 Oct 2025 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDODs-0001b4-Oq
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:29:25 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDODo-0006No-6G
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:29:23 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63e0dd765a0so4694176d50.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761575355; x=1762180155; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=krfY+RqSHB7QoE2xirwM20LswCrABvOqrofG4XQUIsQ=;
 b=m6b/ANU87njTSRpkt5JG/B78TJA/XlsWeCpKvVslxCbmU15pr519qTCLVuwMOUmfCh
 BoVWX9h9ZFLomuwr/Fhbk48qUTMmRw5bCHlZ17PaaS+5SnRw7SZL6JT+6cW28vUKBBVb
 H8+Z/Bzl0HXqEH5rTi72P25nNpV4vZDK1tMw9LMV2EzexH/TxYJJxjtvZEkTzyU9FNta
 QTmghLjyRvaBBLvoFhQEJkm8+nx5vMuTUFxgBRS94dsKCmcWt/qI1J4FYjntIH5+19TX
 G7bG1qSf4x1EAGPruP0wcuRj7pTua2GVjbS/mlu1JoL0+wACNg8F75bg5V4tnKiZT7Ly
 239w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761575355; x=1762180155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=krfY+RqSHB7QoE2xirwM20LswCrABvOqrofG4XQUIsQ=;
 b=lVwxeNTG047LOG/4x1Ojvyzg5PFq6YUlOxdxNpOWFCvOs+4ccH1U9zhu05662+Vmf2
 Qws3jK9oa3p/eHuqDmveU0sZgtDXw6rZYL7dekYvDKMlCs3NjiMinEBTTG7/YKBQ7KR9
 F8TIFWbh5s+4DrGowJ4JobJK01sqPiTvwpo8cQa2qUA3VGdzutnUDVsauDJMryoPPgwi
 ij991qDUTBzUXqmbnqky7nPhNKIjv0NC8+omVq6D4yDZHjSoPZIhypjQRjfIUgYO8rWh
 YjaVNABso28knUDxAvaMh7nWrcG86CiZybCXgl8PiMyT8kdABtLB7IzZK1CF7TEEcqNi
 ZHyw==
X-Gm-Message-State: AOJu0YzRThJZIhbOL4DAYLlTb75rvzVaypnh/96MJht8jCTlESy7kbiL
 w8v7wyjI8Y+6Uc10p/rTRhwNf7zSrzGbAn3XYQlAmYr0LV6pS56KXscqmr60Vv1T28qhMDAOU2L
 gnj/wmITcsRX477HNDFRTSBHOS+sH48u+f5Ua1Rg8Dw==
X-Gm-Gg: ASbGncsoNdaF2HNeG/MV+rMQR1+QHKhV3s0OYey6ykkBBZIrNAVPjBJSUTybW5IPYeT
 AfZ9+gqSKx9R/CzWW6eaFiLH6zQMbT59N79r4ygbvh2ZSjOEAl71QiUGnlABrLUjd0q9+wI3T3y
 S+tFLNZxsJQEPm47lG8WTwWFmX83/074RBqcmG8n0mIaNAZ0ey4CRipFtkPo3dgXX77hcUJ6vp1
 IkyLHzujuebrCclBErV5DZouYuLWWmPGfTGT83MkIoPD/58HijqaWAJF0zN+eII1Kv2VSjz
X-Google-Smtp-Source: AGHT+IHMjeouPDPKLn+WkJs8N4EXX+NwMlLcPLhifS8fwQRFsQIuF/k2ryKUZH9ksDPJoP1K5n9SiedV7FV/PCltxU0=
X-Received: by 2002:a05:690c:60c1:b0:784:94d5:847b with SMTP id
 00721157ae682-78617e4a752mr609297b3.20.1761575354705; Mon, 27 Oct 2025
 07:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20251026105320.5591-1-fanyihao@rt-thread.org>
 <20251026105320.5591-3-fanyihao@rt-thread.org>
In-Reply-To: <20251026105320.5591-3-fanyihao@rt-thread.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 14:29:02 +0000
X-Gm-Features: AWmQ_bmveuA1VeZeDaTe8AXODo5oo6O7YG4_9VySKCc5AosOaPU8_bmry8xJ580
Message-ID: <CAFEAcA8QBt8WgSxtrXhM1yut4jKpOpoc55L0R47eCKZV3FgyDg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hw/arm: Add support for the STM32F407-RT-SPARk
 board
To: fanyihao@rt-thread.org
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Sun, 26 Oct 2025 at 10:53, <fanyihao@rt-thread.org> wrote:
>
> From: Yihao Fan <fanyihao@rt-thread.org>
>
> This commit adds a new STM32F4spark machine broad using the STM32F407 SoC.
> The implementation is derived from the Netduino Plus 2 machine.
>
> Signed-off-by: Yihao Fan <fanyihao@rt-thread.org>
> ---
> --- /dev/null
> +++ b/docs/system/arm/STM32F407-RT-SPARK.rst
> @@ -0,0 +1,41 @@
> +STM32F407-RT-SPARK (``stm32_f4spark``)
> +============================================

I think it would be better to document this board
as part of stm32.rst, not as its own file.

Otherwise this looks OK.

thanks
-- PMM

