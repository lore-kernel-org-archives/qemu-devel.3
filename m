Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E0BC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 20:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSM5p-0000KQ-91; Thu, 19 Jun 2025 16:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM5l-0000K2-4C
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:42:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSM5j-0005XK-LR
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 16:42:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-453634d8609so3842435e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750365753; x=1750970553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkcOD4SvM/H+dbxbmKI+AnvLQoGyQ+BDDk/tJn1Fheo=;
 b=KOmgYae+qap0JMztBpUrD4vpB4E569AaMLwyhXqauC0yMe3KweP9V7ZOHMmOkR+Fy3
 F2nmeNFvYEXim+/FLSZLS46xkCD41kIAHIgzy8tHlkNGJ5+lCvJIWGGUoc2U7MLes4ia
 eWkUDD+ASLzItArD0rbBt2GSWaJ5JuNcCTbwmNQdHqHuFW/ssq7Tcjy8757daMdtbPAS
 6vyL3X8+0NKp5w+oe1TAy1tmg1Dsi4HDuk4FftcCQW2cPA7+FzlYNKr68M/jWmol/nK3
 z9V3jjLUeUg0APQh2p1e/93AQAtIdhpOFFPTCmdtl7ZJvugHQBUAXi+l2r3cOhNt1To9
 VGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750365753; x=1750970553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkcOD4SvM/H+dbxbmKI+AnvLQoGyQ+BDDk/tJn1Fheo=;
 b=A0iEwK6dGq0lQWnxs64TlV1mkGf06Anc3FCz2opkjs8NmXPV62fJrQtpECPKhcqEXd
 vftWttDsbXp0V5vZR/LxJAsr+0zl4hzFijaYetwZUgq/GKluieuxZFDDPsrDrfxf1Fw1
 8ODDlzMf4PGeFNC+enpmExyOI80kZh1c5txsDWOLBJsmDK14iIA2Pa1Fm6D9CbDy/6EJ
 r9/1qa7m/RgwCs5Dh/PNTuMZdX0atn5T4yO5f7JU6axXpvh97RpDosZNeng8QXiVlNMK
 BN3jnaJgVjh5/u2UV5Syq2iqrlC/P2kFNQ3JS3wSJ+qxxsi9bs2B5qz1IMPVVIPI//T+
 Uw9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpzt/sVIqQzxPUj0rDP80UfqjVeWL41kJTkoZ6y6wJlbQgJLKQw7wQHXcnxf8eIQ8+mJOj6Bc4oYFz@nongnu.org
X-Gm-Message-State: AOJu0YzXgFcU8etTvFDGo0gavFOauoY8GwO/zagXdMA8IGpRKg0wvzks
 lqeYLtyuoxAtwUpmMFEtwOuycBTTqW50AbbEh1ZTU+1BcZbVS8yoYKhWhxmWVpxhwlA=
X-Gm-Gg: ASbGncuGPYZ5/DZNayZt6l+Sdwt47mYDU6ppCLyqsAxhDMSoQc3/Cnbe76q4xQ2LYYU
 +Q7esZzGRxlxsKUsNCLEU++N+oweMEFD82u/iiR2x4MmGYQofGsWVWrxedS/v1N4OxkfVoLAPua
 eAXdeSw3dQB1wqj44knrzRCUOKEM/hr7XeQag7/vsUfD3XWP50DkTIuROsX2/6aqPRY/ghR0TaX
 A8seUrNBybznQIT9flA7eCcko21x89GYYscLmTtna1MzMT/WVTUBHm/zLYJ4fLV9Rz9fekRToUJ
 wkufkgzq1IHQQLSEFD4F9vxsxtdqI13+t8U0Y1SQhMC5NQENuCRlDcRyxX/2lWcqHJI2ls8X3vI
 =
X-Google-Smtp-Source: AGHT+IGE1h3KEgON98zfUXeh8o0PU4lcZ8RO7Qdv6Gpl4UJ8NVrZ3mUJmPYDiD+yoNtizQIS710IVg==
X-Received: by 2002:a05:600c:840f:b0:453:c39:d0d0 with SMTP id
 5b1f17b1804b1-4536539c48cmr1767305e9.13.1750365753585; 
 Thu, 19 Jun 2025 13:42:33 -0700 (PDT)
Received: from [192.168.69.167] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11881basm273902f8f.72.2025.06.19.13.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 13:42:33 -0700 (PDT)
Message-ID: <22e2f144-1fa4-4a24-96ea-2a1eaf9a74bf@linaro.org>
Date: Thu, 19 Jun 2025 22:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] hw/i386/pc_piix.c: hardcode pcms->pci_bus to
 NULL in pc_init_isa()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
 <20250618112828.235087-12-mark.caveayland@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250618112828.235087-12-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
> By definition PCI can never be enabled on an isapc machine so hardcode the PCIBus argument
> of pc_nic_init() to NULL.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/i386/pc_piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


