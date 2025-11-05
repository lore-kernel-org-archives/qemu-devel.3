Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B66CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 13:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGdrA-0006t1-8A; Wed, 05 Nov 2025 08:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdr7-0006sL-Sc
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:47:22 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vGdr6-0003R0-BW
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 08:47:21 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so438505366b.2
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762350439; x=1762955239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SE8ujVEEsGDzJz5HQhQqCEUAuZw4B0wKwXYz0ENvS6c=;
 b=nmdL1pqmZd/5KKPZI2aLJPuv5YM+YGQ7uA19tZ3zMpDWBXuVlfqIqKLsSC48TgTQUP
 XKmX/DG+TI88nfcMIm+oGc5gDsiN0GFy/n+22Gj+EnBxqQBkfyRzLb8qASmjbcxI9afB
 +dbSF02/LBMQgFrl2ZlfEq9CT7zjgxqFlCDPIl3L3OUUV/53PDAR1GdyE2m3dUwha6Qs
 o6rY3Da60fdrb7Vn+QyBHJ3aZvrbSGE9kiao/9kWiISxsR/oBweqUnWIPOVSkQGY86g8
 BhnLpOnxwQXS9W9tS3PnF/FhzEhw+dJD2Q2EVFsxZZ8ALVnorTLVbUozZWxRjQ9Fx6Tm
 gTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762350439; x=1762955239;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SE8ujVEEsGDzJz5HQhQqCEUAuZw4B0wKwXYz0ENvS6c=;
 b=G3C3WCJqoIhouyws/snH/URVKVaOuQIUjESXpR1AOMGrBLOXOalWuyh99aAP1GzZmA
 IlOnA+Thex6IuF6gHWuCn5uPLVVlt1FMUDNaHEVvhcZj6LCeFmGWJogt3sy2NPErMqz7
 zhJu2G5f5A1pHK1d2tuIKcw/Gu3kk5QH1I3iUIMQ8FGv2SuglqHIG7gnvvrj80d/b9n/
 iGxqnqlozDqt6bZWyczdulrVHssgDDrLJFxpRKgdJDY2TWrYT+gha7stqQ1iELWDbSp6
 td0bdUOHamz+EQSyrMlofgQ2jS37PjaIQ9ZWv6K1LlhMeotx7Yjs/VoKfGo2QzeM563K
 Ffyw==
X-Gm-Message-State: AOJu0YzXMV6amuxD4kdm2tV3wY89QxhxxTSxoe1eU8nuseCjGKV862kx
 PdrshfkbUfRa2/zO4My4+h7K0qRS66v0glAaa22LOcXfEokKueqoIfj/Q9la0E03ErE=
X-Gm-Gg: ASbGnctZtOGvxNVpldq4AtlXIyskT7SBRFR38+ik6kzr7IE4dtw2fl0gI6dNAYUMtOf
 NSIM6lTDYR44aeAyxOPSAGI0gpCW+/oKWIe2Do6X+knJRNrVVH/rW6VwnaRzU1nC0EypF9PwtA5
 qaklEtyIi/KJLZQzXLwTF65zZg1IKEcreJeCJxOFz51XX8/XVZ5p2gn8lflRgokHnPppQ0cw8RT
 z+ms5ujGvh9CyQeQIVPY+t0NqTyHJ71cnqBhgDojGbhyIr0i9mYS0qMYAsevHf5dEBOmIv1yiOk
 xNdU3bZ4xwGviUA7shimgYjU4XRis6TZ60RygCS+wQevvExt154tdnP1yZMq8dHWLMMyhJWSuhQ
 DDES465n3al4lODGynkUwmS6dY0qE1YjLai6zJ8zlvjr8K7ioD7bji1tZtLHnHbo+wzedgcIfQF
 O6k7gSxrzK78pNzqa1mG2XQoqi/B8=
X-Google-Smtp-Source: AGHT+IGXpc84J67LP/rEGZJEPHh6Pyv92ewXT7bZhQuKm9H0rY9TuAj6VvtomPVT2RgsgsUrGD9oFQ==
X-Received: by 2002:a17:907:da5:b0:b41:b0c4:e74c with SMTP id
 a640c23a62f3a-b72654e1f0cmr343145666b.33.1762350438880; 
 Wed, 05 Nov 2025 05:47:18 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3292sm498997266b.6.2025.11.05.05.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Nov 2025 05:47:18 -0800 (PST)
Message-ID: <a0331285-dc74-4943-aede-d870f01ec81b@linaro.org>
Date: Wed, 5 Nov 2025 14:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/8] Misc HW patches for 2025-11-04
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20251104174823.92412-1-philmd@linaro.org>
 <8a7d477e-269d-4e68-9fc4-6c881cf9393f@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <8a7d477e-269d-4e68-9fc4-6c881cf9393f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

On 11/5/25 10:00, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 4/11/25 18:48, Philippe Mathieu-Daudé wrote:
>> The following changes since commit e9c692eabbbb7f395347605a6ef33a32d398ea25:
>>
>>    Merge tag 'next-pr-pull-request' of https://gitlab.com/berrange/qemu into staging 
>> (2025-11-04 15:17:31 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/philmd/qemu.git tags/hw-misc-20251104
>>
>> for you to fetch changes up to f79fec0275ee7a5151ced9b893c4af676c7f5db6:
> 
> I missed Cédric Le Goater provided his Tested-by tag via IRC, so
> amended to the relevant commits and regenerated the tag (no other
> change). New tag hash is 1eb18789f8863e7ee89c1dc06b2de806442b4927.
> 
> Note I also ignore this checkpatch error:
> 
> ERROR: line over 90 characters
> #242: FILE: scripts/mkemmc.sh:216:
> +echo "  -device emmc,boot-partition-size=$bootsz,rpmb-partition-size=$rpmbsz,drive=emmc-img"
> 
>> ----------------------------------------------------------------
>> Misc HW patches
>>
>> - Add RPMB emulation to eMMC model :)
>> - Use generic MachineState::fdt field in microvm machine
>> - Remove dead code in ac97_realize()
>> ----------------------------------------------------------------
> Regards,
> 
> Phil.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

