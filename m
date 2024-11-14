Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77180D68B2C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 14:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBb0A-0000x9-9w; Thu, 14 Nov 2024 09:39:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBb06-0000wc-Fw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:39:14 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBb04-0005Ph-P1
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 09:39:14 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso102385666b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 06:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731595151; x=1732199951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VpHaewQCZx5iIqtXZ24/DsL9Msh11eix3xm02THTUiw=;
 b=f1kXuDpZDBhSlbxPeIesqrn6afbLOdc4BpFcec0SJKMAn9bxEmUJU7EVDAN+b6+pB+
 TP8F/pT4YMPI06EZES5dz+nIxgi1aWOAp/oAWXEAgBLEwP0i/GarYs9jZ2nVenfeCyhM
 klPSQOPac3kdLhhCDRBa4F9bRoMNyekM0zxfz89uZc3KBRQxd/Hoa1N0KRe0VJgCYJ0H
 rYubxBvAugUlj4VUQvxr5py2sW7dRxipPg15OXSRYAJgGMp5c7Kq1ugaNYgEP/Biifto
 envSN+MRZjdJvC3jpV08vpUF22En87efSNgK3NZF8QUYKD4UdWQAgevh8vF9ykv0scXL
 go7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731595151; x=1732199951;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VpHaewQCZx5iIqtXZ24/DsL9Msh11eix3xm02THTUiw=;
 b=HHl8UNEhBDRPW9PIwbWFySOVhLIGaCN3/I8IfJUtijUnhjuBcixBDSTUXanqGwOV3z
 SMhH1rEVMZwYhs49SlBtoaRg41H94CSqymOfwR3JGNcGznDZtfF6d3/W1dSJC8gN+/1d
 NsiaUf+CztYszuhoUDEbG5soJb0B+DR4b+UNI6kLIPDwwPKSGCaoeF0hMMmEGFYwbl7E
 V+TJHV1Y2EoWX6dYj7QvTCdh4roF1uYNEhPy265vqC/Qn1Tb+sNaIbQu8bbQWl2siYy8
 y74F71ryVFZXeqDjHSAepuPFvy6LEBfrHHFj+wjlJd1o6RS3ASlk8E3wgPDQigQ97hfj
 pAnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBg7eN5UXeH/VTYxbIaiVrTVYRgR4wtP0blTInM+pH1BlWqHSAwjntGza8fg6s12DZj/FXpJbdAYLm@nongnu.org
X-Gm-Message-State: AOJu0YzAYYCexX8kIEQ0BLWxUD1fvRmZ6K2m0IPPpu1aqVv4sM3NiBh7
 WAHGpvbx0OpQKriiQcoAHDQF2tiTclILNYXM0hhgLge9NCbCSiPNMMJybBhzD3o=
X-Google-Smtp-Source: AGHT+IF/yQpu72n0vnf4zw0Uy3UvJSUlUvbXzYEM7dkMSLHO/i9htEVSpuYXgYp/sTm4cCSFVwkvTw==
X-Received: by 2002:a17:907:9702:b0:a99:fa4e:ba97 with SMTP id
 a640c23a62f3a-a9eeffdd0dbmr2553046566b.39.1731595151067; 
 Thu, 14 Nov 2024 06:39:11 -0800 (PST)
Received: from [192.168.69.174] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e08618asm70809866b.181.2024.11.14.06.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 06:39:10 -0800 (PST)
Message-ID: <5b7f8e4f-ad65-4484-9ccb-961588c6148b@linaro.org>
Date: Thu, 14 Nov 2024 15:39:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/mos6522: Fix bad class definition of the MOS6522
 device
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-stable@nongnu.org
References: <20241114104653.963812-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114104653.963812-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 14/11/24 10:46, Thomas Huth wrote:
> When compiling QEMU with --enable-cfi, the "q800" m68k machine
> currently crashes very early, when the q800_machine_init() function
> tries to wire the interrupts of the "via1" device.
> This happens because TYPE_MOS6522_Q800_VIA1 is supposed to be a
> proper SysBus device, but its parent (TYPE_MOS6522) has a mistake
> in its class definition where it is only derived from DeviceClass,
> and not from SysBusDeviceClass, so we end up in funny memory access
> issues here. Using the right class hierarchy for the MOS6522 device
> fixes the problem.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2675
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/misc/mos6522.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 51f233ec92 ("misc: introduce new mos6522 VIA device")
and Cc qemu-stable?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



