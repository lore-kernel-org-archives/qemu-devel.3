Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21793CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 08:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAlOi-0006sb-FP; Mon, 20 Oct 2025 04:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlOg-0006sG-BI
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:37:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAlOe-0000U9-1x
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 04:37:42 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-471bde1e8f8so5293665e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760949457; x=1761554257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GLgxL2x6goTrPhrn3hFdeRxuHjJBo3AFvQ4p1WpDj3g=;
 b=W5RB3qPLTTTLD/PoEio1/O79F2QmDDkeBluM850X+yWWDxmWxWxLn9zxQvN0+gshRk
 6ORIQTDPtby/iCUO8NLJ09xH5os3puk3O5wxjDt5VmKFB7CN3M3dfLpwd2Fsgsb0L4zj
 T9Sk74AwpobirFwFERuRudqf/EjBFQ6+yGKObLRkjLlkaI4nKkbjzhOBKduNV1GEKH95
 hFrK8HPHIDU15Hi1x++Bf42Si2XegWs4RHROJQ7ILaTyLfjKJbtop6RM3+H97QdoWwFe
 syvzKHPH99PLyImCnPslqRfs7jj/uxBdtlZ7wckICMfAoemEfiy5vRmL8kNcqnAlqxFd
 zTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760949457; x=1761554257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GLgxL2x6goTrPhrn3hFdeRxuHjJBo3AFvQ4p1WpDj3g=;
 b=izy8izj0Ql9XvEyB8tZXoHUMnlrB9jFrv/DvF43B7oG1Kwxw4P9EmsMbukxPk3kgB2
 7MVMyPpI/D8Pn6ilIaYfHwgUuym9lcg2HA1Dg69cFgAf2ePizpEb1xilj9FMldTL9JvJ
 idmpjoA4su6lD3lz0jZab6h6kSx5hJdzgL0aHm49Dn917kDQZbNnG65jsm93ycikO8hJ
 tJ0YSFSeM0JoB5Npuy9woWw/001iHutmXjDSSEfgHB0pcFa66ZrFx5XB6lQsYpSYUiDq
 GNf0GeTehavX6SrhK1lVzhL/ZdvJs+Zy2f3X6pEbrpozP99jdDmaCvlnHKeD8K1wiRpg
 qBFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaOl8Q5iT/iEonad4Hhqe7erDe6vHXOKa8Y5bhxcw5ATASU7Odk4YgdLPd61/XZzq8PTBM+M+NQt+L@nongnu.org
X-Gm-Message-State: AOJu0YxH7B3VXyKAfuOZRmNYAZPcN4S6WGob+s67goX4ah3ZDpSGQE8Q
 9lpvbQ0i5vust7RtAkBMC1hHYfNZ6u1StZb0BAAeOszwhyc4+EnQEB1ZU3KMcBHUVt6ZbQBNoUg
 puLtNYcY=
X-Gm-Gg: ASbGncu7rmXT+EtLfd8maGfe+2/XDgfJNxElAZtGpJ5WDPbZDuj4DA9fC2xrjYAmaia
 NFflM7RsovqIAzBJdG/ueFY5pwkHvhI578RwT/SdWu+UjYK24LceRuNofNecvxeQtRL+1magDVR
 RIVoI2DTmlUoJCxdg5kbGeRS76Mba/4ibPC/QknTyRsyqvsL4GGehRBfvl+WQrmzjsKb5L55Q5H
 47SYmQj32meSBtGCXt8tzPv1sZZKBfQUucvgXJWZHIAW74ON/dAaJQCGf4g1WbXe0lfiO1JeJKH
 8gHRg9csigXAErzy54LIFhpDXy/IMcSnw0w3di9qVUufWRM/0VfISpQWQTDxrtitzhnHFp1uXdv
 DmbVVFr2PHKYAD7kruV5x22jf0uKAQiYA3OfbMQEUPVMT9Yrhy5W6gEOY8A6fnY7FIFNLRHFD3y
 Sgjny5ZTr+5Jb6TTxawhYkXEdhBkZAGWZezH1O7tPr2koxXuiDjhZkyg==
X-Google-Smtp-Source: AGHT+IH9Dvll//eE/ueNoxK6IBKB4JuF4eDzpsXVAQqweTQJn9XWnoe0M/S0z9YtsbR3pfWxaHG/hQ==
X-Received: by 2002:a05:600c:3555:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-4711786d42dmr88461575e9.5.1760949457023; 
 Mon, 20 Oct 2025 01:37:37 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47154d382d8sm135394965e9.12.2025.10.20.01.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 01:37:36 -0700 (PDT)
Message-ID: <89dd6315-2062-4770-aedd-90479d9bb351@linaro.org>
Date: Mon, 20 Oct 2025 10:37:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] hw/pci-host/raven: Simplify direct config access
 address decoding
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1758219840.git.balaton@eik.bme.hu>
 <2d0d90d16bb02cb9c0606ca8690cf22d296f982c.1758219840.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2d0d90d16bb02cb9c0606ca8690cf22d296f982c.1758219840.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/9/25 20:50, BALATON Zoltan wrote:
> Use ctz instead of an open coded version and rename function to better
> show what it does.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/pci-host/raven.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


