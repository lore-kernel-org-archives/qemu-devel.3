Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFFAC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRUD-0002Wo-3i; Mon, 10 Feb 2025 05:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRU4-0002NG-P0
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:57:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRU2-0007bv-QY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:57:48 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4368a293339so47024465e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739185065; x=1739789865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQ0d68J6CSkPJ4a5Kj11f7PJeVojd4EozTX1jYlbGRQ=;
 b=GnQHa8IMnw/r/9qYP0jDsmnlwx9FfNztpP0qJfj3/hvqgBI5vX1MYP7HmEAIImxGQ5
 5ASbl++GbpxTcQlVClDVIFsrrjA9Y8wUYuj94dUYkI9WOHmC+qqb2caaKBIQWNmCuB8j
 6fm1PgAdpp3AbR5Fp1mwN0NarLTFYwjn4oBUznWRbfcE+ndVTpCnCobqPcteHl3R5iG+
 qDDSqkipuTRPHQXzsHj4RhzQ+bHXf5XffcKbaSggtk4ydXKBLIA3DPix34dEF9z6q+bJ
 dsKpj5OvPqRFw8ULQ7ZEmyohyTINRI3aixB0exo/8UOllPZvl2Adtgs6o8S0m/Kfg2vz
 CBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739185065; x=1739789865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lQ0d68J6CSkPJ4a5Kj11f7PJeVojd4EozTX1jYlbGRQ=;
 b=hDnFaI7UaxPR7zmb1gua+vgg4537ftWtDyaQZXmFWDtLbh0X9T65y0aAqQHDueb5u+
 aGlZv0b8zWKXAeQHDUAX3ZkRP7RGCh2Rp2CP3PJi4iudC5u8lFIJw0R8NzGn3q9mRTwe
 JnwAdG7T1YQmM+igSt9AvTL6MtOYSIvFqsE0PfTuh09qQlWOcxk26BC16JMLVpWYtSSA
 b2e5wTrQMKWEkfkKm0a393ryq2VhVK3DssZG1cQ3KiaJibI0jiEodGZN88oFjX+4xdmR
 NrE/fV3xfyRUGbwG+95CKJ7KXT33dF3wuf/Ju37U26wyt322aOy6kVYfDYFnQ/3Qk7ty
 5qXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOggwkkge/yzzAs9gOWzALU36QdTS2tQDYH5rA/DyZEGOxSiZ+807bHTBQDciNxxwECX38FG9kldRE@nongnu.org
X-Gm-Message-State: AOJu0YzkDiPVbezeCQpCBTmXaLKFOx1CTGEVAOa5uat0HYlId+ZlW41+
 a5pZjD3OTHN6M+Sv6m94MZ6s70xMYs76gRJx9zLgzI9xEjpGVNRhlxcB5eG4Fv8=
X-Gm-Gg: ASbGnctWYzHRFdL/HKjnhawH6qdFU/Rc8owEewKTasdUJ51IZpaaQOz1JHCx4B75QF3
 luI+QdLXWUH0Dmstn3/brWpHsNMAr7fPT/wYDYY0cYqK6IUTfzqLA35brMvmnZRdfqPRW42CF7H
 OSeuyMdcf49O6hMf3woryP7xFXaFGGP/ISmglyi2kCXRoPaU9UMjPjL3Wnm153t5GR6C7PMf9hz
 BHGt/XI4IH71UNa89kULaub3GEJIGB1DfF+5i+bu5gzGhYccYMQpjwfnLMB4C4d2rXmKJvsWrQD
 wjJOE0CnAXg0c6gX+ZeO1I0bRibYwSBukxLq0+89ansqf+NoZ96iWpjohZbCcn9j
X-Google-Smtp-Source: AGHT+IGQjDhax5bzCyH6Ld6+bq32EaW3g4kyM0k/W/+x+eERoHvYVJ9Lc2oYP0oWZz2Vr09KT0MGuA==
X-Received: by 2002:a05:600c:3d07:b0:439:4700:9eb3 with SMTP id
 5b1f17b1804b1-43947009ff1mr16625415e9.3.1739185065260; 
 Mon, 10 Feb 2025 02:57:45 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5a8a9e4sm10609465f8f.10.2025.02.10.02.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:57:44 -0800 (PST)
Message-ID: <f0a0f932-5394-4dd8-8185-1fa4e8947a13@linaro.org>
Date: Mon, 10 Feb 2025 11:57:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] hw/openrisc: Support monitor dumpdtb command
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo
 <arikalo@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
 <20250206151214.2947842-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206151214.2947842-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 6/2/25 16:12, Peter Maydell wrote:
> The openrisc machines don't set MachineState::fdt to point to their
> DTB blob.  This means that although the command line '-machine
> dumpdtb=file.dtb' option works, the equivalent QMP and HMP monitor
> commands do not, but instead produce the error "This machine doesn't
> have a FDT".
> 
> Set MachineState::fdt in openrisc_load_fdt(), when we write it to
> guest memory.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/openrisc/boot.h | 3 ++-
>   hw/openrisc/boot.c         | 7 +++++--
>   hw/openrisc/openrisc_sim.c | 2 +-
>   hw/openrisc/virt.c         | 2 +-
>   4 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


