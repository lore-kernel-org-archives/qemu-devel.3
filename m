Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75FC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE6e7-0006UC-Fr; Mon, 03 Jun 2024 08:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6e3-0006Rl-1n
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:18:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE6e1-0003DJ-AC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:18:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35e4d6f7c5cso1771360f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717417111; x=1718021911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3OONg6C0+7m9m/kZUoNC3/8TtlY2uSrQYaq1/r4ZvOc=;
 b=crAMzgTnXlTQk39uQ3z/gFDTy1lvEa3NDjSwf1CkZmrXBBqYWjs9BpigwjJGDHQLKa
 w+qjC294zVGL8BQQYi2lEzyIYF+Cb2krMFDne6j97cTZBh2U6Vyc9H1hfvfB8mavjeOa
 j/9iOPCgEgw3ryC+QrO95wnA4LmoZNEtWK//8WUrki0dqpYfB3ASe5VjP2wxEDi2Efw3
 OsSjwtUNyppultpc0s2uvXklOI97vaKgRySPDTQggyutIbQEpfix9dARBZRpH3Abi/80
 /iWhEd4EP9z/mn+2K4fZYMdCcuMmRg7IYVxN1op6mY3+/3oNhNuK1M72ga7frN/7bCAf
 fN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717417111; x=1718021911;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3OONg6C0+7m9m/kZUoNC3/8TtlY2uSrQYaq1/r4ZvOc=;
 b=vA6+g/moSBdZPDK0wU+KfuM0nyds/u2v0zgQ4IizeGclKSLMjoh8ZZC+XAdqnn1J9X
 2PtmK4womfsdlglWj9FoPIb9k4VI/pgbba3a9HjGEKC3z0KzTgtUGzqlR6FY7WfMbOTr
 FYU+zRJ7thJ25HZlFJRx8AicfhuGh1az9EIQiXOSf3wdWWNfyrn9oI9xFV3L3GKsxAPV
 O1K4cv6/yMeTMk8rRenVXwlYw5pfePeT4ECOH/EC5xrm4SZEUmirL55uNEpS+EDsXkOv
 FkPLC8pS7zfD/wzCdt+Q0yFs/IqbOoukGhy/vkMj9EhCta9hNiYNdh/TV+/pZeiPKGSR
 V3OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMKGhLDqI2FugBhhl2pdrpR15iPr7W7axkKK4FZX5YIalpQdGJRTZvOX/VGfrSmzVoZfbABNlfm0R6NFzy/SSTKETssA=
X-Gm-Message-State: AOJu0YwjS/PGJcfP3ZuzMVaXziYKPq1RI/vIk3JnQQ+R7ZaD8dRjQi2G
 pJJbeLmtlBS93phwL0X30+xov91c3D9pg++hvACEAaQTn21wAMmlJZjrU6KJuos=
X-Google-Smtp-Source: AGHT+IGRb7tYZqmmCbZbPejzCCTVHQLh4QPk5b0WHNMOvtnIPYPfJ49MT1iVwKeNkLkJjBdc/5wEyw==
X-Received: by 2002:a5d:4f8f:0:b0:356:50e7:e948 with SMTP id
 ffacd0b85a97d-35e0f32e295mr6989192f8f.67.1717417111223; 
 Mon, 03 Jun 2024 05:18:31 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0667366sm8588152f8f.111.2024.06.03.05.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 05:18:30 -0700 (PDT)
Message-ID: <fd73e8ad-8bd0-49bd-b0b7-6a0a2cf64992@linaro.org>
Date: Mon, 3 Jun 2024 14:18:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/32] hw/sd: Add emmc_cmd_ALL_SEND_CID() handler
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-17-clg@kaod.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230703132509.2474225-17-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/7/23 15:24, Cédric Le Goater wrote:
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/sd/sd.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


