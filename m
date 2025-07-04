Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiTl-0002pJ-0g; Fri, 04 Jul 2025 11:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiTi-0002oH-1T
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:37:30 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiTf-0006gj-VA
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:37:29 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so840439f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751643446; x=1752248246; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YD701x7IKyZ2ra7Y45S1Cdb1cWu0AX/3K+UUTjCG5WQ=;
 b=CYFruR7zwTDqUuJKxGJCn+c+Sz5AWN3JICuMAERnKsPGbwPbEIoHza30f9OqGWpcQw
 DMYq7SMoAqd0zejnMonSTRXcCzKxoncZizdr1kZAlmPG/SPSMfksQ4mau9wPCMxsFMwJ
 dDcM8ICPEMI92EidyN01iWfG0+pipJzmltFk0xY6QC+28+aT28aVvBWH/33SGsu87DYV
 BCA8RVkW0AntjNwed64ZCSBE3MSWWn7d2q0fAKddWEF7Jf1TpUo+4X28T4c2Ims8HMXy
 sp4Oc4dlbi6cZkJ98NJGWdlsNqDFFuZHgRoZHr8DvArN1gXt+canYm5oTaXOBOlj5x9D
 +1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643446; x=1752248246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YD701x7IKyZ2ra7Y45S1Cdb1cWu0AX/3K+UUTjCG5WQ=;
 b=dsg+M6wHXNO8vJbTxpJwo831OVw9YS6Nq8U5OG0NBSN1rGkCa2tJlIq8Byt0BGQaat
 TgAkCc4PNAtndaEEQTO5qCG0N9IR6KGzJepdz1JWp6TaG96MdAF9xf/5rwjw5gsrG+bI
 jXk0psnhI1Wq44pGeioArHogWZo6Mho6SOf/NKZLgNCjXeJFQmdDB/Pgj0JPWF97DOYM
 nZDc8ylYrgGAp8Iv/bfL00PiIq8g5iZo/bbPaL0oiuBUGhm+kCn+M/GkCQ6ytFAB5XM5
 eHG8achln+JHUVeDj31HmorIf7ugfCIqLm/XTIGGf3MQ9xbDKTDd1ZRaFD+lojlRC3n5
 Rygg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIwhMgT/TumCO/4MtCkbv/SjtuRAqQdWwQPaeXXwiRzEEqj8MCUX46m7PUltEFMs7MnHPb4AMeCKuR@nongnu.org
X-Gm-Message-State: AOJu0YxosuJAk7wBpkBmyOqQkMi2/JQuypS2fCEOdML1JGPzb7tDPuSv
 1XEJgxSQCFXIq+1m3vfmaRYDHiMJbTq+y0h5zkIMmA7HJREV0CdLWlmH6Zz4TqdfvkU=
X-Gm-Gg: ASbGnctO6VIePbiEPHQVFTA8smqTOSpPf1RGumsPSTBNk5nhFBed0DjhWcdlVlf1Mg+
 H6uxjgx0IrWM1/XiqAve08c1ca7hbk+6US2ANDGORqUX8n4WIhAz02ZB00Xp+q4yaVSUp9QdDoN
 IjfWCwX7sc+bCFkJgOeehp2zJsIvBvPB2O7iQTl2dJK/zd4jL6fq5TST7U24AzQXVT4CsuYeco9
 ClGLNdHIJM0e9BfISg1G2kAUE0/8m0TfZz6GnYEb91XCkqr2pXfhfZdoP9LX6q7t9yLm0zX27If
 PjvCCVLdsHsmMG+IoGcfK/cir/J+/t28NS5Us9Nm0KXlkcBANhNgK/EWEk3RGFw95CPVXZFaigP
 XexKspjqLIIaOOWZHNUJ/NIjFs8BGrF0Z+NpVr6d19zdCAQ==
X-Google-Smtp-Source: AGHT+IH3OvVRllGKibnvzD1eKzHi2RSZHiXYBlb9RnQ5W17JRe7tsiZ70Lqt8zEMMEpfKD2G3OIy4w==
X-Received: by 2002:a05:6000:24c1:b0:3a4:f70d:8673 with SMTP id
 ffacd0b85a97d-3b497020775mr2555969f8f.25.1751643445786; 
 Fri, 04 Jul 2025 08:37:25 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47225a6fasm2693094f8f.81.2025.07.04.08.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 08:37:25 -0700 (PDT)
Message-ID: <23aef7fd-e780-4f73-9792-1bffa1ad40fe@linaro.org>
Date: Fri, 4 Jul 2025 17:37:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm/cpu: store id_afr0 into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-2-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141927.38963-2-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/intc/armv7m_nvic.c        |  2 +-
>   target/arm/cpu-sysregs.h.inc |  1 +
>   target/arm/cpu.h             |  1 -
>   target/arm/cpu64.c           |  4 ++--
>   target/arm/helper.c          |  2 +-
>   target/arm/tcg/cpu-v7m.c     | 12 ++++++------
>   target/arm/tcg/cpu32.c       | 22 +++++++++++-----------
>   target/arm/tcg/cpu64.c       | 16 ++++++++--------
>   8 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


