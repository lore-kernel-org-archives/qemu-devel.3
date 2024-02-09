Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576DAC48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 11:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYP4i-0000vK-MM; Fri, 09 Feb 2024 06:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP4d-0000qM-KG
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:29:40 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYP4b-0005qp-PS
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 06:29:39 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-561519f8698so53600a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 03:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707478176; x=1708082976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cb1Xxs2xqn2fJ0hzaTAXVtttAW9cBvuoicOsfXWBMJU=;
 b=D6QZ/x6zqDO/PstZwois7bv8TszQrtg0h6CS1TacWeSfmX1z/eJrr5tn07IFRuGoy/
 EsFJ3vOR+s7lRrHTlT9caJ/k9YjVV/2VpY8Mymg6ZSv6GmA1Y5jhD3lc65z2yetJQAFr
 2g+3iV6T4WBOG1ASvdlVz5QMpwI+G/6mxsW1+omFCbhU7RMTeqmHNc7EdtTL5+bSeCVx
 ImDPV6TUIVh0ICb+8dCz4ZbU8WFQJWrYf55F2bCzwFDyIdS6eiaUOFZRprYoxdXA3Qms
 lLhiPPdiQ+OZWdTCsMPC0NBiOziCGt/zIaCZav04rASS4/45xFrUp1oRWnZZVRxAyUdm
 v3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707478176; x=1708082976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cb1Xxs2xqn2fJ0hzaTAXVtttAW9cBvuoicOsfXWBMJU=;
 b=RYQuF52rCDyVWq/HG7GNui7TqI/sHqoOUyKL2z8H+Gae2CBXi7ZKt9g57zrPU7/yCj
 m2orFP5qTwzr4H02yKsj8IwHjurmusj/99g37TgX33oFNhNKMdp39+xnjB33v4EwRXms
 FiQ+KqImqWExdFChNvtf47mo4BO7K9rIVCP5TcrjOLa+9R6g6FYgq53uBYRfbM7RZo8H
 LrGVRmFhM5Z4Gi26VTP/1dg4bT9RuG+5PCME8Az3PQYHdwJEt/CaqjccJrAgYjs/r3Ds
 PacIlRBZo0HuYPqL8K4ucyPog6CK5PsBAQ2NdiBPGDi96B1t/GK2qx4JZ7cjkqVJUUzg
 NTLg==
X-Gm-Message-State: AOJu0YyqqHbyPUykaym4dB+Xm6AjHXI9+O6tgn10HTD0dn5LO3IsUW3z
 ssEXsrJGDonmoiUas4eHBsTHpL0FV5OpFBy+LZsiATOWPc/P6wP51/Vbryr4DFumSlvh505lucr
 27RsIYjBic6mb41AU0DFo2TT7a9z/gIMSnJc+/A==
X-Google-Smtp-Source: AGHT+IE4NgclQBR0jGGB8sjjWUWRwBp84FeAzapLuMwUe7juCj1EHlZntgX/Qck0FSRq3u5lcAwaOuyPP/4g7G1Wt7Y=
X-Received: by 2002:aa7:c994:0:b0:561:2094:a7c5 with SMTP id
 c20-20020aa7c994000000b005612094a7c5mr1214971edt.39.1707478176233; Fri, 09
 Feb 2024 03:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-4-philmd@linaro.org>
In-Reply-To: <20240208181245.96617-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 11:29:25 +0000
Message-ID: <CAFEAcA-5HV5xYSK4fnWmOsXHTGU-tw0ff5psRtnxXo+J5Wy1YA@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] hw/rx/rx62n: Only call qdev_get_gpio_in() when
 necessary
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Instead of filling an array of all the possible IRQs, only call
> qdev_get_gpio_in() when an IRQ is used. Remove the array from
> RX62NState. Doing so we avoid calling qdev_get_gpio_in() on an
> unrealized device.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

