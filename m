Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA3BD3E787
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 10:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zZU-0006Wi-5M; Thu, 07 Nov 2024 05:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zZR-0006WK-Pp
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:16:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t8zZQ-0000dI-8d
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 05:16:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d3ecad390so1089760f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 02:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730974614; x=1731579414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9gYnlZC2TOl43HBrigVa8fPxeD9d64i5XYQI8DPz8pw=;
 b=LU/kcPkjxK3Moy5xBnhyS8puZ3E/nKjdSJXZcLnwCAJRoVUQVUTgjHe+Z1kSExupCO
 yOabjkyc34G5QWXzlezecYMbnQu3dgoJuu4CIvRd44vz9/ttXaAC3Qtm8ecQ52YbBmsS
 IDwVEExqMo53LZS6LMecqbkxC6fsNqwpwRRwoC4L2vfE3YtmQWvs5HDFR85gPH+g27Z7
 KIDra3TdHcX6OjIozaREBaUjDrwzQ0WLEqug5WYhRd47scrEvSJgtOwa4kV2edW/nBrU
 H4AysjKlxs/auU6MwHbV5FJKhUnABQizJKLvemYW2+jiLagKllTo/0WZ3kJmOLOMpEFK
 6gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730974615; x=1731579415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9gYnlZC2TOl43HBrigVa8fPxeD9d64i5XYQI8DPz8pw=;
 b=QVsYt1L6H8/kphqwl2wNCFnIPgmlhPOjQHx/9ylL/7+oQlknzSbSfKpaphkPYBOI7j
 I5Jm1HCekycvAWFr343MpRAHlsCmMexYPbHpzw4a7Nj8Or0P5YD7FvmH/9BLBLftzPd1
 mVH5wx/eic4gz+NceO4f1rJZL/qWfMTYJq3YSpXlX3Isa5LDbPxbLeeAJUwGGe6kdCEs
 SZNYLlvglvQpXluNPz80Fawu/haM4fjcK0QxVuFxDoNSR+NIC5Fe52A+CDu8hdRj+F4O
 OR9PL00J8D0RKKaeSsDqAqhzr52dOZe8S6tB07aqY8G7sS+WCtkDSg2oAOPNae2JZ2bk
 WHjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnaIPEc6DjTJqAtC3RZFVZtd8CpXBQWnnm5JDLXwpV8Z0e8sfbb9nvrAhY3HUM65yhvBaZlolVEzOU@nongnu.org
X-Gm-Message-State: AOJu0YyK8lvUyvj9L6G8Y/2kBsDcRw8vMzNysTnZCGr3hwVYYPlKdb7U
 G4OU/T8dr/4fkrAadrpODxGWsyRnf/rvnOoaux2F8tFn4SygEBMWvNFfEzmgwmQ=
X-Google-Smtp-Source: AGHT+IEXYfVzx/po6J+VWCGc4YVDQZS0mFoSLGmV76k/yBedF420iF2B8L3qZbDFicDCxEqRGbx+IQ==
X-Received: by 2002:a5d:5847:0:b0:37c:c9bc:1be6 with SMTP id
 ffacd0b85a97d-381ec5e2787mr1939775f8f.16.1730974614646; 
 Thu, 07 Nov 2024 02:16:54 -0800 (PST)
Received: from [172.16.23.118] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707c8sm1307720f8f.17.2024.11.07.02.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2024 02:16:54 -0800 (PST)
Message-ID: <ba287e3a-8fc7-4c56-8206-3469401a6626@linaro.org>
Date: Thu, 7 Nov 2024 10:16:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/16] hw/net/xilinx_ethlite: Simplify by having
 configurable endianness
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, devel@lists.libvirt.org,
 qemu-ppc@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241107012223.94337-1-philmd@linaro.org>
 <20241107012223.94337-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241107012223.94337-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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

On 11/7/24 01:22, Philippe Mathieu-Daudé wrote:
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -121,9 +121,11 @@ petalogix_s3adsp1800_init(MachineState *machine)
>       sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[TIMER_IRQ]);
>   
>       dev = qdev_new("xlnx.xps-ethernetlite");
> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>       qemu_configure_nic_device(dev, true, NULL);
>       qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>       qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    qdev_prop_set_bit(dev, "little-endian-model", !TARGET_BIG_ENDIAN);

Surely only one of these.

r~

