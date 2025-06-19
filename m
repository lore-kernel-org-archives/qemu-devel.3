Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0B0C77B7A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM64-0000MR-1d; Thu, 19 Jun 2025 16:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM61-0000LW-Ea
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:42:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM5z-0005bK-Ki
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:42:53 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-453066fad06so7221075e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365770; x=1750970570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iPhIMM73bBRj4RyXNFDggG79DLPlHwWNCe9xdE+dmBI=;
 b=ug1bMt6HujmX/+R1OVS5N9cfTv90J9M1c2HZOaYqQ1wv0l7tKQyqLKhGOTtMZQ2mxi
 IsXOzsAnHPu79LL99r04wcDJm37SlYMA68PKU0svnCdI4Op0YTO4PYk+XQVeIR8g2CPn
 X8BeDd5uaxO3lL0gtiKDORf3K2kIfVv7LeQxB2v3fbIpZOqtaRpThJY9NAdN7OfwdShS
 r5/Lrz7hm2JfG+MpqLenAoBqLcqJNrc8G3/SFuPTcRHeTIpXqYcU+kLqTnc486LBLicq
 dsQBVd1MgYQSpUAib9nPpwTRpGfNVDFTu/mS/IrGa9ucGSk9BK+NaUrNXLTBKMlnD04e
 RTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365770; x=1750970570;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPhIMM73bBRj4RyXNFDggG79DLPlHwWNCe9xdE+dmBI=;
 b=S+PxIZWFziwlKbLkCJYUU+M1UAHh49Zp19sl1EkzE53rYw//OiiEKfYqCRV3+xyD3C
 CnCgj7IrO6WSgcL7Nk6Qg9oabcyQbgchj8gm3OX3RqKtgzyAS3bEje2OEVzR/C/XNxTJ
 nxFeJ6M7TAS/tSn5GsnFzxBraevPGnxgJhAv5TkWa2DLlHdL/t5yGTlgvtB+u5YbgnU2
 HPYaSC7J5heFZlnUSHc7YvFBB3ccPMfo0oLK08INDwJVtgeLuJ3wHQQYf5wmf/mi0Gsk
 Xs22ACQ8V6CchW7iPu/AYyESVI8t4tBPLa1hWFvAt0TX9bOL4bulPl0XQDhJ624jejbB
 hJJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEwzERSRR/ubPoMnyQoXtfxUbd/uSyLmLqlDIoYX4OyNhHChSZg0eMhykxNpo+AZ5YoJw6/zMdSF+q@nongnu.org
X-Gm-Message-State: AOJu0YzSYHMG7n1+Wdm+FD8FTIDRQhc/TWv3tZEf8ZPCMR1QpUyhcsEz
 OD+0GIqBZWnxG81r5E0TQ0BYau0qA59xrvBFq+xDje3dSbugURbarqhcxXEJpqQqmEU=
X-Gm-Gg: ASbGnct+SLHZAbQDPVt+iHNPBpXranlYl/rMg2fLAqB7Og1y7xeb3XxaNt37WXnz14L
 Z+Gh/I2DKHkDpAFTIYUKP2+MpHh+3LgHsbkTADGPbSqixOGVmFgfi+T9jD2VKqDPBhfqceXAlAa
 j0lFgmDMOdBSN5eEgFqTss/rszX303jgH1dclWx9zYHLc7e7/RVjXwhwcUNpq6aoR+SXjUkR1mP
 CeElmZwvNKfsujZxZ4fTVgU8QOdKVwXnVgCKsT4aPK9ozVfa6v0IxUPrGN0X7CqwDRGUzDKftlT
 j3B6B9G3fjO7x9Yej+i0WfzqdlpykkIcZok24OWRzoAt1vcWBXZReJZ1hISg04yVKz70aPx4JHk
 =
X-Google-Smtp-Source: AGHT+IFvglpkbXSWETLGgLyNUUdeEPowIvtUh2vGZLbd9uY1w26dIJC7feO63gAmV0SUZwPogWh85Q==
X-Received: by 2002:a05:600c:a00d:b0:445:1984:2479 with SMTP id
 5b1f17b1804b1-4536539214emr1546095e9.5.1750365769746; 
 Thu, 19 Jun 2025 13:42:49 -0700 (PDT)
Received: from [192.168.69.167] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d117bf84sm289199f8f.52.2025.06.19.13.42.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:42:49 -0700 (PDT)
Message-ID: <cf804316-b44d-4d44-90ce-15ec7ac56ca9@linaro.org>
Date: Thu, 19 Jun 2025 22:42:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-11-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-11-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/6/25 13:27, Mark Cave-Ayland wrote:
> By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
> set via pcmc->pci_enabled.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


