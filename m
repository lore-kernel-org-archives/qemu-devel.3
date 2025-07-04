Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDA5C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiWt-0007Ow-GN; Fri, 04 Jul 2025 11:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiWr-0007MD-25
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:40:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiWp-0000I4-8C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:40:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso15383255e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751643641; x=1752248441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4eHeWA/GQGNp/88g85GnxJ2dZI4A+ddZnlpnJQ674o8=;
 b=EwyMOe8Qxb6a+tN2LfmMIiWv08bb1yxms0swjVq9+k3VI0QdHS9a+7YVeGz4sez7j4
 SMtUovsUcra0kGcVuO75SFDh07/WFG/N7RQjpCV3Erqsg/7NpD3FeLqpAcg1KFC/9Uoi
 ocAcLqqCQAUIldlOjF3E3wUZQIqsx7OrzxByzVZCj66lBjKTR1hCbV/MEFww/fnHV0HL
 QGqrVWI/giAm6MDlzgRS1s0M0WqzF4W9rbHqywWcwjfzrqpDn5/fZdOnJo8OGS7Ti05Z
 fBx2BadNmviPtaIuleXETugSL/aWX1SQhQHzD32TTFpEM1AxhAah1jDjIM/OujYk+9v1
 arrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643641; x=1752248441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4eHeWA/GQGNp/88g85GnxJ2dZI4A+ddZnlpnJQ674o8=;
 b=ud0W0vhVGNiD8+5hG+EhtP1eYBCLwWG6d/jd6z/kBFE2L36PkmQFaIIkV5x3bg0iqV
 t6cVDfPvAhxODAgMT0lbjae7oIJtiuz3qU6xlXv8Ic2DFNgzDl1KCjObYLGRJeBoMf5X
 fE+COwvlRQ2vZInOtGZ6HOJSbJYdyHwjkA9cZhtoZwgCA9jTkA4vQ56ZRjH2eaHh3hVz
 u8WsdMWL+SgRs2lOh8BilX630PR05hgsOB+hTOvjRKJki2yhZlrgv9yCHZHnHRBoG9UN
 1CjC8ILSwHyYuq0uOUxFLZjnMY4FtIz3bCOFtk9bgnoHI83KoNANfdo357JkpS8zuZ1A
 AUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGAvBV9+KE7Ms3fm6TzndsdLHs9eT+xPCRWmrnh9alsFCmWHrEWiocTV2ZrERp/KdzwRhHziViorcp@nongnu.org
X-Gm-Message-State: AOJu0YxAOi9/Cm/HotZvOUDDMTDnF1EpoE7Gkbfzn9SEeJt3xobzOUDn
 Bbz+AFagU+Jf5PyE6hFF5NHZ2e01JnYq3tTCzy7wa3CFr9J+awRf6L30ny48ptaK1pw=
X-Gm-Gg: ASbGncvLBpkjVos0brCwG19VvdR10FvEp45b8lEP75z0NdKFjHv1KxnB6IHjjLDoT6Q
 uqEMvsXTkPOu0ASdfywA51GY5t27Z3Yx/ehG/8KG9FUuVtlgQQPYesebr40CjECvgMoTQISYJtz
 uhj0bKm8qy7S50hDvsyB6hC2p9UYxCT6sbYRuzqPcg6vhOJD7HHyUln5ulrEbx+NW4MLd+78cqw
 dgjhleS/DdTt3kLdwBzBuwCwvVhcj5/NHvuT3rfJy6IexHuh2Mlpu/inePBgUuUGEOsxjH6vR7I
 HWkcIxGA7qE2AXW0yHbJNe5Vmzk0riX12G6MPIZIvyuCSp92WAky5PNVQcJTpBhwAyjvlJZbPEs
 dLl2CSLapVYeunvgVMENbhIKe974AdmXaueE=
X-Google-Smtp-Source: AGHT+IGP7kYMUSfuXhtazJFSQ3PEFs4ZF1oWLJFVSJNn1P8Uu2LCElNgabVJ2RvDQW2dYiamAHXCYw==
X-Received: by 2002:a05:600c:15cb:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-454b262bffemr21700525e9.10.1751643641530; 
 Fri, 04 Jul 2025 08:40:41 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1628ff9sm29484535e9.11.2025.07.04.08.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 08:40:41 -0700 (PDT)
Message-ID: <8202aa15-17ee-4d52-b7f4-50045727010f@linaro.org>
Date: Fri, 4 Jul 2025 17:40:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm/kvm: shorten one overly long line
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-6-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141927.38963-6-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/7/25 16:19, Cornelia Huck wrote:
> Fixes: 804cfc7eedb7 ("arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/kvm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

