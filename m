Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACB9E6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 20:17:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEDbq-0005by-RD; Thu, 21 Nov 2024 15:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDbl-0005PP-4i
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:16:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tEDbj-0004Zq-7G
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 15:16:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4315f24a6bbso10622595e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 12:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732220213; x=1732825013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m85383M9HM68mDxjKFnfgQNVEeZzdeoFmra44TWvAH8=;
 b=RB8JlNMo306n/7usyrvNC+wJ5UikCC+YAYg01Lb22bzCsyLPjtx2MYpi9Svf+Q5qIo
 0ATf59OeeeGPPLQyNm6fUph2bUiBBo6wToXicHAOzgqG3dz529A7xZe4uGZaRBOWSFPd
 PhduwQg3phgXBY+wQ9CzDRo8TuSwIxksQQ8aLdksnQEToJnKLPs3lFuakpuA24sAAQLm
 XALPumXM4ApDMnjw1wRP5wJS6kDw77aon9pbeDk7zQEWrMvTVKVXBYAvKgWWygFK0Q0f
 cm2xyYJR1l305qkUFcPMO9G1Kgl5bEkYQ8LfHO5VIoumWEcqZ523hmItN8An/G+3yNSb
 2LCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220213; x=1732825013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m85383M9HM68mDxjKFnfgQNVEeZzdeoFmra44TWvAH8=;
 b=GmToNE8DDO6jsLn/x6AyJ0n7jXqy/VwOEUFFfFfUA3pIfb9juDS9Z5+HW88STmzkbW
 ZlGoZyQlA6U4uWaxMBtnz1Ry1jsp4hy/ayKs5oO/xflIoHUQdL2V2EJ0tHO3jWCoQzZx
 zHTfIJIlC4Zc5DzQ2l+amouDtud/UQG4Z+MKrwyHw4KrlCfRZ1lJSJzy3C+/QO8IP60d
 WJrdpUoTxXapOFZi2d8Ja8WRTOQItlazA3eBUa17WUqy2LVRiPVq/Wcx69bbMhJaow+c
 44pnhwkM0Y5DutpaCuV+CS1qzOk4RckTQEV4dnQvYJ7J+QuJT7Ki0YdhIVUDANsn+kSu
 xiDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6daBVd6VCaAffqHExGLSl/zgesk13Tmiuao68hU32QpATmCFyrgkADcrcK3vb2ZzQU02wuU9nIKQA@nongnu.org
X-Gm-Message-State: AOJu0YzeKfCREfgZVkeRT08sH07fGiBTzBb1gbUgZ58KrZCKLhp27yWu
 kzdMzR70CJrm4CwmdCQN8HH8PRQDJKS5lIC8Vb75AKHCdK3pM4aSiBUr+hZxMQo=
X-Gm-Gg: ASbGncvdc1fAl2yFOi4aO/8Ia/ummH5u+6yBAy4Jyzve9eDGG+eYpXnHeejtAV1FpEw
 6TDEHRpc2Jnxh/eqsniegNtvIM0VzAFjHZZhUIxqugdmzNY5wpAuIeQhdLoVc3nkKAVGy0w/QTR
 jJL5mwhHYHHbpf62u3Imc9Dj6OX//D7lYsHslDprAsRYLAmN2+6OwO3IqaySWDrcVVHtgoLYeam
 Hg/a/S8NBMsLEjxvhSXUD4jGzDco6im9ufNiihej5jRSQp/3Hp4vcggoDw0SircywlA
X-Google-Smtp-Source: AGHT+IHBm2LWAEub6vqEoxHjI3UEhwk5ZpxuS12NmU2UokN7aoNOV6dK+tqAT2U0v9Knb+Eek95Hmg==
X-Received: by 2002:a05:600c:3150:b0:42f:310f:de9 with SMTP id
 5b1f17b1804b1-433ce434707mr1391295e9.15.1732220213590; 
 Thu, 21 Nov 2024 12:16:53 -0800 (PST)
Received: from [192.168.1.121] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde06ed1sm3560835e9.6.2024.11.21.12.16.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 12:16:53 -0800 (PST)
Message-ID: <2c310757-5293-436e-8981-b1536b0fd009@linaro.org>
Date: Thu, 21 Nov 2024 21:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] qom: Use machine_get_container()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20241121192202.4155849-1-peterx@redhat.com>
 <20241121192202.4155849-11-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121192202.4155849-11-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 21/11/24 20:21, Peter Xu wrote:
> Use machine_get_container() whenever applicable across the tree.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/core/gpio.c        | 3 +--
>   hw/core/qdev.c        | 3 +--
>   hw/core/sysbus.c      | 4 ++--
>   hw/i386/pc.c          | 4 ++--
>   system/ioport.c       | 2 +-
>   system/memory.c       | 2 +-
>   system/qdev-monitor.c | 6 +++---
>   system/vl.c           | 3 +--
>   8 files changed, 12 insertions(+), 15 deletions(-)

Preferably s/qom/qdev/ in subject (I can do it if queuing),

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


