Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD22C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl2jq-00060r-3q; Thu, 20 Feb 2025 04:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2jo-000605-V5
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:20:57 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl2jn-0001et-BT
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:20:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4399a1eada3so5689795e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 01:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740043253; x=1740648053; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9CA9Ulfr2g7JZ5XJNiiD4QhSsGUDB0n2H7fxdmLVzXk=;
 b=qQKqp7Z9L/9pHPfW4UT66D6BCX9tI2LHtKXsHqj0CufZF7elVh9JQQmHttzaXwcbc9
 J0Lh6IpqfhoYg3HgA/VoWEz7woT3A2j4QCIFeznLVTLmgHaxkx20rWozgSXwExjRPaP/
 L15bNIM4XInMQ1T+Z57WtnDELUF5ewVobgsbZvzpiwi4TNM418JpJyzxjLuhDYFZK7Uu
 tzuqS1e+Jl0LM4w4fIVCVNefVtwbi7nPwaPI7BfXhJMhKPWLDufgZlMgFKfMG58LEFBo
 kpgRRCIEDDCCccy9/9vbRE3St+6uQ7aYtFJ32me3zZMLa+XB6n1eLo56nRazbhZdsmRM
 FVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740043253; x=1740648053;
 h=content-transfer-encoding:subject:cc:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9CA9Ulfr2g7JZ5XJNiiD4QhSsGUDB0n2H7fxdmLVzXk=;
 b=uiE3/60zFOgznvdZylrXBNbDm0OmcrWO4BUdhEyJ82AuJfhi3Kghv91bW5FHB2PeEg
 JL4C5n5qPJRjyypoj4oOtR1gFNOKdocsCovjZTD/uzNHx1iYMApr15F5ZEg7lDjXUSET
 x6AZBnZrJBJHUd3K6h9xu+6chorUu5ws8zpMp9h7spwdHjrK8Vxp/pmrqlixcmT/cv+q
 uxIAfaU1B5wz9gCQBw9upqLzB9zGqwc5AKxWoXLuj/hkZF1JvzzozT4Rq4UzJvAEcjVo
 xk5iP7CjNF0XARJ5ebERbqS6ccKYzXQYwU9dZtWLjlv+0iOyA5GZRN1wsKr70MWcsp92
 PkaA==
X-Gm-Message-State: AOJu0Yzed76n909p7o/aKLVcZ7ZOhY9BnaZ4rMSk/lOTK5TCZMWB7gDa
 CH1S3I78H8VvLgaAF9RORVQ4zHH7ldC6binFUCPwhsyVP5TMR30bHTI+40PcKBVpuVTQqrKTz69
 yNzo=
X-Gm-Gg: ASbGnctvi5KtcwPaGB0ml6B6O4E2Z0iCwCm6BLd7TPdKZ7zidpMcOCpVKCxg0F+Fmqc
 3yo217rZq9npIt6y7m5g9njn/6G6nMOQlbnCwdVqJFh8u5wqR4psHoNDhCkYKjdxbZ6PzRWDMwC
 GXofExgMqEIc6HtcPfpj0AyNOkGKqeDCiMHDUTmOzdQRcADIvIFS/usI8bkyT491tPkRiQSkLX+
 aq4MxL37r/R4rjb5Ulpd5n8RQN6H0NHW52C4Isw1Wp6EM3T4m62+FTNlRqM3+vxUdJaCpbv89HA
 +dlsMn1X5DUb2iSrWZt/NYDcrhG1XAeHgjy8BSMiRThv1tg8HBeyhVcS+PM=
X-Google-Smtp-Source: AGHT+IHqwpj0241tkNqU/Yr+pFumYAUhupo4i+CcyeaKFqbi0brlPNvmpyyuy46xGK8RlSFAfY/enw==
X-Received: by 2002:a05:600c:4751:b0:439:5541:53cc with SMTP id
 5b1f17b1804b1-43999ddbbb3mr74227285e9.29.1740043253123; 
 Thu, 20 Feb 2025 01:20:53 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04ee48sm237613965e9.3.2025.02.20.01.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 01:20:52 -0800 (PST)
Message-ID: <97e66ba5-488f-4246-b4d9-466d29a86dff@linaro.org>
Date: Thu, 20 Feb 2025 10:20:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Any plan for command line '-g' option (graphical resolution and
 depth)?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Hi,

QEMU provides the global '-g' CLI option:

$ qemu-system-foo --help

   -g WxH[xDEPTH]  Set the initial graphical resolution and depth

This option is used to pass resolution/depth information to guest
firmwares in the machines defined in the following files:

   hw/ppc/mac_newworld.c
   hw/ppc/mac_oldworld.c
   hw/ppc/prep.c
   hw/ppc/spapr.c
   hw/sparc/sun4m.c
   hw/sparc64/sun4u.c

Examples:

- hw/ppc/spapr.c:1102:

   _FDT(fdt_setprop_cell(fdt, c, "qemu,graphic-width", graphic_width));

- hw/sparc64/sun4u.c:716:

   fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_WIDTH, graphic_width);


Obviously we have default values, which are different per architecture!
Clearly these ought to be machine properties.


It is also used to set TYPE_NUBUS_MACFB properties in hw/m68k/q800.c.
Here i suppose we could directly use '-global nubus-macfb.width=value'
etc. although I'm not sure it is the recommended way.

Should we start deprecating '-g' as a whole?

Regards,

Phil.

