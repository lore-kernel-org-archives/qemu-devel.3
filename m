Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F8AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 23:27:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts8zv-0006hB-7f; Tue, 11 Mar 2025 19:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts8zt-0006gg-JH
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:26:53 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1ts8zr-0006Jm-R7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 19:26:53 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7c0155af484so827331085a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 16:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741735609; x=1742340409; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=+PFj3ZOULY5GcWv54Pei91RhX86LhchEXibDupxoDcM=;
 b=Uh66ZaIKUSlfk4c4pI1vZxeqc5059eeJS2EiHIxR9dP5+bPDw76PQo51tSMZeZDrEo
 c9HnbzTjE9wsvRcTZv8Zx9X99Pm84oDbC8GXYmYme4IBFWpusaMasw5maEjJ0iIzuLp4
 VSDn63vyMRkp2cAbmZ+MlUhXOsWuW2YLNw1D2jbnqcwapxaUeGrSK0SpT45Taqx1nmqd
 0YL5Y2BL6we/y/KmRmLJe6ymaPX6QtWxAi8KWlxfGH1v8jrxnysP7hzNygsWHmQbYANC
 SnPYyrgY0Bm721OL5D6SzOt9nrYLLjan+82J5/Ve83N+WKyZ/mssfPfRxKo5a6er2IXC
 z9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741735609; x=1742340409;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+PFj3ZOULY5GcWv54Pei91RhX86LhchEXibDupxoDcM=;
 b=DQ393ibACALnkh/40gwlsY/H7D83s+83x9DML1mQfUh3UkD9EGPjLM422vrmgIDdCf
 03yNNRvxTR5Wrf+oG1lhvqr5vCUvrn69f95JFgOtdhBuD9zLN0gtunKQ3FNcUONVn/d9
 o6wjSuW5JPIby7Rvj1gTxqUI8lIsVnjkTN+H19TSDYiBOUSxbLdI2NJQpPZbMQkjkhKd
 9um1/+uMSZ2g6UTJL10hWqSjGx/jZA6bGuN7d+ECz3hIupHjYMxFnVHltkppLnVbntuV
 q+a8MYSMSsZ2gq7aSmJyN6652PFkFrOxB9sl5aTtjNwvO1H//562T2DXa8n1Pd00OENc
 6gTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSpHMz6O9U7XzIJZLLAUPZ7CN7pI0mBWrj51AKMAFyrWNGzgFzbT4pWYBP4QfrV/GgQNPfw74Ch36s@nongnu.org
X-Gm-Message-State: AOJu0Yyy3ONETWb2L4gtFYQuTf7uRh7iwS1EOstwPgH6j9FYs3NIKsO2
 5VhSDbZLSMHm9NT5rG3l3/FvBXMDTwUmeAuWany5hueQwyRdxWcr
X-Gm-Gg: ASbGnctWcPh3WIXjOgRNJUuteMPplNENC/q0+qInRZlhkqfQX5mM8oK1/kj2YwRX61V
 g+0zRXCjjL6q86TpF1vhrBadwXWdknDbS5+SvWKftJ6CEK1rLD+54XYYSHSJsc7N/pu52Zfr0tW
 CcN+3MtVBW2PKb6oho4fQOjMGipyiqlWdozYRI5+i033wclfsrfW6NrH4X5CSZur5L9mERolXvi
 46GWx7wdV/3b1MjomLxgrJGKosFOxZSJpnEV5kfUxG+7AiFCVPfXvI/suBMsp0ItkTNaMfh2Vb1
 JWXQlvtGwJ02/gZmTGoUHqK/9qXNCWs329YR3NoGuV+pmzHD7SEUli7E7Bsu1GE=
X-Google-Smtp-Source: AGHT+IGggNujyvIcYZYZZob3QgD5UlSFKI+17zowLF8r9yw/9pyUyEWwdk8KP2vI9X8qKOt5SO58pg==
X-Received: by 2002:a05:620a:6412:b0:7c5:3e76:bcd7 with SMTP id
 af79cd13be357-7c53e76be91mr2239175885a.37.1741735609142; 
 Tue, 11 Mar 2025 16:26:49 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:a832:3b35:d71f:4119])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c55d83959bsm229239585a.8.2025.03.11.16.26.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Mar 2025 16:26:48 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052628.1011210-1-brian.cain@oss.qualcomm.com>
 <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052628.1011210-29-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
Date: Tue, 11 Mar 2025 18:26:46 -0500
Message-ID: <00aa01db92dd$0fa87e90$2ef97bb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQERX/uiI+LG127bCFnOJB03IqEGrgJRPWMEtPBv8kA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250311-4, 3/11/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:26 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 28/38] target/hexagon: Initialize htid, modectl regs
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 36a93cc22f..2b6a707fca 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -26,6 +26,7 @@
>  #include "fpu/softfloat-helpers.h"
>  #include "tcg/tcg.h"
>  #include "exec/gdbstub.h"
> +#include "cpu_helper.h"
> 
>  static void hexagon_v66_cpu_init(Object *obj) { }  static void
> hexagon_v67_cpu_init(Object *obj) { } @@ -290,11 +291,18 @@ static void
> hexagon_cpu_reset_hold(Object *obj, ResetType type)
>      set_float_default_nan_pattern(0b11111111, &env->fp_status);
> 
>  #ifndef CONFIG_USER_ONLY
> +    HexagonCPU *cpu = HEXAGON_CPU(cs);
> +
>      if (cs->cpu_index == 0) {
>          memset(env->g_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>      }
>      memset(env->t_sreg, 0, sizeof(target_ulong) * NUM_SREGS);
>      memset(env->greg, 0, sizeof(target_ulong) * NUM_GREGS);
> +
> +    if (cs->cpu_index == 0) {
> +        arch_set_system_reg(env, HEX_SREG_MODECTL, 0x1);
> +    }

Combine with previous check cs->cpu_index == 0?

> +    arch_set_system_reg(env, HEX_SREG_HTID, cs->cpu_index);
>  #endif
>  }

Otherwise
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>



