Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927C1C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 22:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbSWj-00013w-MH; Tue, 06 Aug 2024 18:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbSWi-00013A-KF
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 18:19:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbSWf-0003qr-9W
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 18:19:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2cf93dc11c6so867927a91.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 15:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722982766; x=1723587566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P4PgLfc4sPViRb2xw8vsREFOBq2byaL6LSyElc66Pic=;
 b=e2PkO8b/2MJEc9rHq4bmBuJTILI8nmmcwf/ooJO8PLQKvbC+hvIZDPZ/SIAEoEtRDZ
 HuEHBLh28mtXmVB0wHPPgaDsNKhtxCJOCsm9f2xQLM2Fy5ykAe1kmqJqzdLUB1Azino4
 Vm6flfZgPPrZrYzOQVjRXTiumyjADA5Qk69Y5aM2hyMY3jwk0afLoPfACBObJxn5QPjC
 qtCVpJ5RyNS6IucNRTwc7Y5P6JnfHbeZheYAn88E8ds1tbdQbo0cWDVB+JT6myDkybpB
 2cNJjeJLhytTzW8ZeVmSjeoeU22b3DD37phcYTJKOMZdjJ3Wi1wKhwTvoAkQx2YafRsz
 IrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722982766; x=1723587566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4PgLfc4sPViRb2xw8vsREFOBq2byaL6LSyElc66Pic=;
 b=eYbS6zbbJWzDA7lC9IOjYig1gukI0vT1K3Bg0ryMqDOR9tEFpBv5D5iJxm0hGQ+4b5
 Ets1AHm5/dA4dwvAkik6h0SctyRV9Hdvny0qEpvCkzynOPlY2Vi6qwzOVtKwUv7nrWrG
 cKEBbu4GxZrqjMh3H/cY4JxEbU8w+jq7eje7oXCLv9m71q1c3KnAj7Sx4lr725AxSuJn
 QuoV6UUdXFiTD1C+9nJdUAZr9FUoa5NDPIJ14WCyrg64ses3X7abVTSJ66xrmqaoO5G1
 8i8vtcILYhGKlhqhFrUNTQEedYECxI5z+XA9E3k64nIG67BUAsQF7jqv9FYwnjYuGoff
 ylWA==
X-Gm-Message-State: AOJu0YzbGYUVHi5g+Atwxiv619EgRyWuw3xAw+9IsiMQWWlNXFzaTv4D
 UyEcn25BjENV6QHIHIPKbEQPK6Dhzy2EAdv+04Ye6Ap7A+rPLLzJVKmPnqf03W8=
X-Google-Smtp-Source: AGHT+IG2lww5mNFwH4UXA9tpEUDJItEwl2vl1J0IgxpVKYNDcXRDM23RJetwvG+9EQgM4fIW8cl56Q==
X-Received: by 2002:a17:90a:d146:b0:2c9:7849:4e28 with SMTP id
 98e67ed59e1d1-2cff952d37fmr20899536a91.27.1722982766135; 
 Tue, 06 Aug 2024 15:19:26 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b36dd511sm23245a91.34.2024.08.06.15.19.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 15:19:25 -0700 (PDT)
Message-ID: <c8d1a52f-edba-46e8-90ba-50078434bf1e@linaro.org>
Date: Wed, 7 Aug 2024 08:19:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] various ppc fixes
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20240806131318.275109-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806131318.275109-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 8/6/24 23:13, Nicholas Piggin wrote:
> Nicholas Piggin (7):
>    ppc/pnv: Fix LPC serirq routing calculation
>    ppc/pnv: Fix LPC POWER8 register sanity check
>    target/ppc: Fix mtDPDES targeting SMT siblings
>    target/ppc: PMIs are level triggered
>    target/ppc: Fix doorbell delivery to threads in powersave
>    target/ppc: Fix HFSCR facility checks
>    target/ppc: Fix VRMA to not check virtual page class key protection

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

