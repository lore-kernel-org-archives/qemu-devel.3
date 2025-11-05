Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FA4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 09:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGZNk-0004MB-QN; Wed, 05 Nov 2025 04:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGZNe-0004I2-T1
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:00:39 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGZNc-0006wi-5u
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 04:00:38 -0500
Received: by mail-ed1-x544.google.com with SMTP id
 4fb4d7f45d1cf-640860f97b5so5943589a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 01:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762333233; x=1762938033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGeKEIbtdYP9kp2ppoTf0hicn+Cfkbek003e0gTLPnU=;
 b=rWA3MSZcM6MV/wfuW7d9UdIFItUM3+LC8zI9iKlI/Bjv70KdBP4BBNNOO5Xs6cU0SO
 saR0zQrH3Yl4081vIJMRTv/9R8WsjS03GatndJuis/0S0yuFmAjGt5Qdb6h5ngsMUdEq
 192w0W5KKc+bX7OUFZiUzwqQJVZWu94Iz/AdkvjqZGpNNXzYpNZW4Lg3fKqOBYIKnVpK
 EBiznB62tuT+O1IT0QIyRfAAGXa5ABaO5+Q9+mja4PkVnwRNRwaxWey+VIU7IBthC5oF
 cbEAeERC+0lCHA122bds+Fad+xWXLWNel7gmnGvQZpnJWd9eBmlvdMHIYaX0yM1FdGNj
 NJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762333233; x=1762938033;
 h=content-transfer-encoding:in-reply-to:cc:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iGeKEIbtdYP9kp2ppoTf0hicn+Cfkbek003e0gTLPnU=;
 b=hVmWsVYyM1LnawUJlyu6kFjxzFSzh1FE9OPsy+yx1vvpeUbq2Cl4rBc7anRSWzv+fl
 svQliTId0RVGqJfq/cyedTT4g5J4q9rdUWS+Tro/l2PLnDw0XpuX1ns1uQBfMtnUvzdC
 vj9TLBmWtW8zwFecoHW4KMTa4XQN/8Oq7uTUtkbBElpXdVza1LAoXiQFc16Ftk8/9JWT
 +hRFPdjfu5JdAKzQpy8wKT9KEKI6Snb4pryfW1OqJLUHmpT0Vk5d5KJOdbKKMeqvq8EC
 MfojF6s3y4hMAkp1lgyJlLJ59vkoIFx6I0ly6KmCHDyWXaPLKmF8KJiZ969dzm+QgPtO
 n3VQ==
X-Gm-Message-State: AOJu0Yx3xOTTpj3ytri2/iy+FSl4+yj4foOi58ISwq+awu651inbxkMu
 WSvHIFlhc3LfOpPffUJul33zAlZbgSvz2CrgQDVrcBEY2rc2xzYoligU3HHg8Fima94=
X-Gm-Gg: ASbGncusxpevx04krLEQAJUxiY04I3Lz6aN1vktvHhCpoOQLTU+Ncxq8dxCekDUQtaD
 rX78mutAnjohzIBm0P/mImB8dCm7qKsNd51/1OKRdD6ylvIbwifRwVQulDrMFp3gu7h1qHZJLeJ
 XDcv3seiKUoLFIFlLr6G/ZjgwpvQcOMe9OxUkP5Kv2lKvR0A7DD73Z2Aj0Oaoj9gsWXPtMOHibX
 bwV/dz1b6kjg6mXiIO5zrCMH94BI5jkXGT2LnO7hEXBdH5xeNZHc/K0iiAjjo5J74BiYMEycmNu
 4B7ONVeTfIaKeRbqoaaM+z29nbI51Y8+xaTQ54elcaeEozwJtD0h065qemmOzdw7rNY3Rb5o6x3
 TJh+UHq61f7Pq6NH6f9zVN+85/CIzEfwiv6vn9wWGzFk2QwYQrhS9nqCoH8C4ArJfzbXo1QXhqL
 FxQaaq/wQ5neaEWCTY/ag=
X-Google-Smtp-Source: AGHT+IHW/KjFHNMCWsSmQB2xZf33xuSeiaJ4QN31F/CVPUGbLvDhpQ9Jm83Y7K66B69fJh5I83AhJw==
X-Received: by 2002:a17:907:9815:b0:b6d:552f:e15d with SMTP id
 a640c23a62f3a-b726516ffc0mr198245366b.10.1762333228767; 
 Wed, 05 Nov 2025 01:00:28 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723db0f1besm432099166b.31.2025.11.05.01.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 01:00:28 -0800 (PST)
Message-ID: <8a7d477e-269d-4e68-9fc4-6c881cf9393f@linaro.org>
Date: Wed, 5 Nov 2025 10:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Misc HW patches for 2025-11-04
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
References: <20251104174823.92412-1-philmd@linaro.org>
Cc: qemu-devel@nongnu.org
In-Reply-To: <20251104174823.92412-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x544.google.com
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

Hi,

On 4/11/25 18:48, Philippe Mathieu-Daudé wrote:
> The following changes since commit e9c692eabbbb7f395347605a6ef33a32d398ea25:
> 
>    Merge tag 'next-pr-pull-request' of https://gitlab.com/berrange/qemu into staging (2025-11-04 15:17:31 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20251104
> 
> for you to fetch changes up to f79fec0275ee7a5151ced9b893c4af676c7f5db6:

I missed Cédric Le Goater provided his Tested-by tag via IRC, so
amended to the relevant commits and regenerated the tag (no other
change). New tag hash is 1eb18789f8863e7ee89c1dc06b2de806442b4927.

Note I also ignore this checkpatch error:

ERROR: line over 90 characters
#242: FILE: scripts/mkemmc.sh:216:
+echo "  -device 
emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"

> ----------------------------------------------------------------
> Misc HW patches
> 
> - Add RPMB emulation to eMMC model :)
> - Use generic MachineState::fdt field in microvm machine
> - Remove dead code in ac97_realize()
> ----------------------------------------------------------------
Regards,

Phil.

