Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32081CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtryB-0000R8-6p; Mon, 08 Apr 2024 12:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtry8-0000QH-4j
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:35:40 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtry6-0000cS-FZ
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:35:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6ecf8ebff50so2732779b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594136; x=1713198936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hymyiklYqbRzXVxFqxYABkMeV7D7cbVEHqcNwQ0Z5d0=;
 b=YVdZzZ0uDOy5itnHuv4K3u8RDyrj9LhbRFX0mUW2+CT92BgsIZGeG4MQxnu/C2IG2J
 rXmZ4UA/YPzDZTscMMXH1YUaMr7H1PNGuXuGozQSQPTYjaEzcPGRGUN/2xhjfDPWS7yh
 PrvLtwpjYjaH/kIZHKxvKBiAtJNTKVMhLY0C29a2EIoKzDqyfzU7QV9IXtFbFaDyrOEh
 1qQY4ewOU/Lw8SYT3hf7bAw6UrOUsUXPGnEvJGf16dzVBTp20HqpWrL2ejaVE/Wczk4q
 8TUFhBgQBGHkn6tXLCZ0W0BGbM45AdUTjXevFRCy9TiI/CwQlsKFS3debENacdom7NYM
 /g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594136; x=1713198936;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hymyiklYqbRzXVxFqxYABkMeV7D7cbVEHqcNwQ0Z5d0=;
 b=Vcs2QsUc7YWdjHB7wlYK7n435p2002stXirIYtSjI+IRBOfPoRICebBnkKpWb+3v1u
 EI/dTucFwbzd/qIjS4d3duIRODp2hnJKg+3T7KmyeDUF1/NHld+Y5/SeeFDadaDze1w7
 GuSvxBXh1yg+6t94/RiEDvEPTPcy9r4hMo/qgcOuAhaUIPrs8xSO2XIW5wcVOoT68hN+
 psaMgKABYOG+F5ZqR53NT+eQKRqHAf/n8rpFNmnDWmGXRdhOcmtfwEYr7DsNepwVIhe1
 AedqcyxiT7WhINbFxf0mjMLLO5GUx39Lv2838TLCJiCrX+jguU8RuWfgI2RyKDNVbH5M
 XiMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRoLXO5ZE7pYY7lI5IS6IN77B7T2qP9PcvrlP/1+cBYA0RLYWNeGcA5BCeXQ4j+ZaA/1F63iWdDJYNMNgPxFSWzwN4haU=
X-Gm-Message-State: AOJu0YzTcNtuUQ4y3lGRF03xcEuAYm29P4WJBjjLxckblmXQ+cJmvh42
 br1gDPgd6vhdOyYJ6Wx91RMX4Fz6c4HMVBqVZ6W6hNYbqWdrep4IYGmze7DXpsg=
X-Google-Smtp-Source: AGHT+IHqlSy6EvAi4o/GjALvFT8dffQWysRVFYwyMdabtNqBc8rWmXQWqGENPXw17caJVV7K/x4EUg==
X-Received: by 2002:a05:6a00:2d0b:b0:6ed:2f0d:8d73 with SMTP id
 fa11-20020a056a002d0b00b006ed2f0d8d73mr320368pfb.3.1712594136619; 
 Mon, 08 Apr 2024 09:35:36 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 r18-20020aa79892000000b006ecc858b67fsm6993993pfl.175.2024.04.08.09.35.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:35:36 -0700 (PDT)
Message-ID: <f9fc3f73-0645-4d9a-85ec-5071d1fc8d24@linaro.org>
Date: Mon, 8 Apr 2024 06:35:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 1/3] hw/block/nand: Factor nand_load_iolen()
 method out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408083605.55238-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/7/24 22:36, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/block/nand.c | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

