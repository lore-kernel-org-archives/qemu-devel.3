Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF41CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZXr4-0003Zs-Sd; Tue, 16 Jun 2026 13:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXqx-0003Rc-1k
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:45:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZXqt-0008NK-Qp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:45:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2c0c1e0b0faso30830795ad.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781631930; x=1782236730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6f/dAqkTwaDzkzlnCO1W31wgMvqKPUWCLQYJ4Mdv/nk=;
 b=oNWLg8JyddEjtyUfoXlGencHGeRhgTdE1u66lnRPkfTJIW4nLCLZCa1OAzCAUOXJL8
 6twNe9NSM9rJz0Oe2Zi8af4oGczzL8PMYFBo24PawvaKwe87zQ3GKf0sIguiyumDSt5E
 2qYOmmt31q8zFmjYaPESb5Lq+vgtw7RYY4WwghdXFmJa88ooqCNnbxme23K+AmRuw464
 8m21kdynGSnd5LH0iJGh0gHSUEwzSP6LnRrvNjX5h4KfqYG0+BXAABakmfjEQPey4qeU
 JtnakNfcRrg+28v5v9sFyMLFFAP8PaLiVmlE6snRs4seQfUg6JAC0IJySu/XWjOvrnIa
 GoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781631930; x=1782236730;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6f/dAqkTwaDzkzlnCO1W31wgMvqKPUWCLQYJ4Mdv/nk=;
 b=bxtj5hOpND58yMX99tOLigx/c+7HSjNlJdVeZBsaETHQ7LYM1t3prg+WISia5roqpY
 NHbeGvQeu33wSyBKOTpWzcnwaN4Kpr3v34NcpcuGGpnh4VWnck/qf7DCY6vMfBw6q/ZU
 1j0Y0ZjVkCWfpyE4klQbIGfK9VgvwyYctC3Gui/rJaZGgyO81oci4n/yRX6uszzqNVjC
 tSbMhJfwiG2F8XQM/zeMwTp3TgIHe2c2JZX7TAmiWabc/rKFcvKqJQO9pJkLPF+Yz8pO
 Aa9BP/o6DFPI3LoWHA4f33aRmJ6Yw8OZMnEUuYzkEWwfwmu6QDknwfADhNbAizxK9DMp
 QP4Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/J+VLtxbwlcemCvW5JwiJ8npEu041ZH/Yun6p0Q9gphyrowSFncJfEWi3IzVjV+xkblWiTJpWCgrLe@nongnu.org
X-Gm-Message-State: AOJu0Yyd9KpqlruEraD+rgbsHobhQ1fOEtjAfNtpMw+zUMjHImNDtLiY
 6rb7lwWp5GpWEQKIaq8Wda2KSPI2gehIftGUbHuraU3NcK+YqHI/0n0TSCECT+MPPnY=
X-Gm-Gg: AfdE7ckEUUkesEqVJ4/hE0bHbCEb8+uwY6nYdLyOWoLI7njx+Sj9IgVsAlsvqglur5W
 gQ7eDDMtWLO9V0KTY0KLrj8L8lYapjZiES5qiNeUf6SqE6nWS8cBC0FMUktwwpoAbL6NfDdNOvi
 fla6N3c1qKY3qhCwR1x0ZydAMoQJX9daQNQlYqDCJD7gqWW/qM+HCkgK4l6swjUy91yknOlMHc3
 YDv4LXyWaSAb+2+7uIzjqTWBWHn3lQzvdhOrysA2imPS+kOJNIPF7HZaRS5UOghkAgtQy5mWQuP
 QCx1UDU2loRecnL0ukJtDs0eAuKzyCH2h6RONAJzfL1osgizWwOfVpcr8H+/CP5ch5LIy1KalSL
 LYG/pjo2hjANcTFTXcS3ZqPwtaj9Lc0X2Zu3CLF7wnylfFck1fuAEA3yeMyeRyKZKs9hXjPqhgF
 K8/EmGe+wrLr0jkHJGRgnBMZQgCvY2I4cdkDvxskG4ZjTr5J5ALDLuBYTZI0k/+0dSS+A8jemsQ
 xaBQpE=
X-Received: by 2002:a17:903:2b03:b0:2c6:afa8:c181 with SMTP id
 d9443c01a7336-2c6bc0b11a9mr645295ad.1.1781631930248; 
 Tue, 16 Jun 2026 10:45:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac7fbsm147149345ad.42.2026.06.16.10.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:45:29 -0700 (PDT)
Message-ID: <392ceec7-68d3-4d6c-b200-232f59cbc9fb@linaro.org>
Date: Tue, 16 Jun 2026 10:45:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/tcg: Restrict IOMMU declarations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260616153633.93267-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616153633.93267-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/16/26 08:36, Philippe Mathieu-Daudé wrote:
> Move the two TCG-specific IOMMU method declarations from the
> generic "exec/cpu-common.h" header to "accel/tcg/iommu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/iommu.h | 7 +++++++
>   include/exec/cpu-common.h | 3 ---
>   accel/tcg/cpu-exec.c      | 4 +++-
>   3 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

