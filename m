Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BBFE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:23:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgWw-000745-ND; Mon, 09 Dec 2024 11:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgWv-00073v-Ct
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:22:41 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgWs-0002jH-VF
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:22:40 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1712848f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733761356; x=1734366156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U8lhwXx6N4KO095OntGCcoEScVr+W/k5Q0g084Q1qyA=;
 b=O0HQ5RcG8cRdSp5Vt7DFFAl0ac2qdrtnagtivR4WnS2QCWrt5+8WTrVsFPWmVXX1+h
 ShKpQ4BWF6tEvJ+ewmRwUlWxGVtCh4+PnwPtGS+iMvo8rjBWAUs6s6wB3jBhr0CotYuG
 NX170KNlVh3ZSA+Yq+mLoL1LV2YNbK7Ih40iAF95FLgweXs5UsNCUz2EzG+B8M0FTCeR
 pFoRWKislDKnK/pZ0BxbXQOEfHGgl8/ExKJ5BjoonXqRhz6HB+rSBGfLSj1gDqwklQj9
 Tpc/GKPiAEwqtn8mWQxvpW6NMTR7ZmPwOXE2XApTSJlRTgppRxmwN0nNhtnLwJZYXrR0
 g1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761356; x=1734366156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U8lhwXx6N4KO095OntGCcoEScVr+W/k5Q0g084Q1qyA=;
 b=r7GKp0klgV74+/Swl8ma9mwClbSbExK68eOnHDJlXUBvtx21sxU7GrDS6r3fgqx4du
 RHTe59FBTykLtAsLSFSuEuteL79mcZe/Sdu47S1aqfK+zbnTfhsWrO/WV+AwJ1B9IRCI
 GXZZ0boBzmhbRbt59iwclscbQlfDab77Cuh/I2YrAwCg/W8aHRzZqcbrfTyxEUXzvm0i
 fN9oOyXalYt3qcyyInjiPgCTQNq95MSXRWGvyGBKl1zFdlLAbgwEY3XC9ylkSrlYksV+
 WxjsIEdwpoU0PKUCUdaPS8patMg5EuiKtyFENHSCP5tDG2tB6ZBVA+CAX4tauhKDSMOm
 QPjQ==
X-Gm-Message-State: AOJu0Yyy8qB7V0IWNCA+eUiP7UwCn33AlPG6CX+TW0+Y4p4XQN/ZqJ92
 7Xy82JykV0GgDP6lbJ3PYN8HMM5HvVuTieRunJ5+1rUU9/hBJF569zk4iZtDELU=
X-Gm-Gg: ASbGncs+nN4TWF8qCmD6BZuAbZT5YXXnD/4LrLH50/cBzLyGrbyd1pmqbs22qSdDb1v
 o8jPlSGacwRpDHqixr2uh+WCJ07FuYINwaXAKoZGlWCKrC95fLOW98/EQk8lGv3wll1xy7Qu2/t
 FWVts50vmz+ImIkS9ivXZOd4b0vwiubVCIhP02WwU1fv2fVRtiDW4kxGpzf+JQ+G3j0Fcf9nxvx
 SRyhXVtCLJjEwnEX53kz3HiHtuPnPEA4wrgJIni4f7nc0UFb0XUMZxXgUs43WF2GTbMWSoI9mDk
 xyEZhXMtdCBZAMCsrP7EBJC2NUXZPLX1
X-Google-Smtp-Source: AGHT+IHgFMjbbVNnVKTURxjC9bV5ynREE1UGeU4i1sd/EHNIMxDdf4bfZxh96Gu5VjCUyjdbn8iB5Q==
X-Received: by 2002:a5d:5f8d:0:b0:385:f984:2cbc with SMTP id
 ffacd0b85a97d-386453e4994mr876734f8f.34.1733761356088; 
 Mon, 09 Dec 2024 08:22:36 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f1125e69sm79428235e9.32.2024.12.09.08.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:22:35 -0800 (PST)
Message-ID: <2e219dd1-c9a7-4bc6-b33e-c4918e5b59c2@linaro.org>
Date: Mon, 9 Dec 2024 17:22:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] hw/net/can: clean-up unnecessary includes
To: Pavel Pisa <pisa@fel.cvut.cz>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241209100635.93243-1-alex.bennee@linaro.org>
 <202412091223.02308.pisa@fel.cvut.cz>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <202412091223.02308.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 9/12/24 12:23, Pavel Pisa wrote:
> Hello Alex,
> 
> On Monday 09 of December 2024 11:06:35 Alex Bennée wrote:
>> The event_notifier, thread and socket includes look like copy and
>> paste of standard headers. None of the canbus devices use chardev
>> although some relied on chardev to bring in bitops and byte swapping
>> headers. In this case include them directly.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> Tested on Debian/GNU/Linux for SJA1000 and CTU CAN FD
> 
> QEMU=/home/pi/repo/qemu/qemu-build/qemu-system-x86_64
> 
> $QEMU -enable-kvm -kernel $KERNEL \
>        -m 512M \
>        -initrd ramdisk.cpio \
>        -virtfs local,path=shareddir,security_model=none,mount_tag=shareddir \
>        -vga cirrus \
>        -append "console=ttyS0 \
>        -object can-bus,id=canbus0-bus \
>        -object can-host-socketcan,if=can0,canbus=canbus0-bus,id=canbus0-socketcan \
>        -device kvaser_pci,canbus=canbus0-bus \
>        -device ctucan_pci,canbus0=canbus0-bus,canbus1=canbus0-bus \
>        -nographic
> 
> By the way, I would like to discuse how to update CTU CAN FD a SJA1000
> IRQ handling to allow mapping on FPGA target platform buses from command
> line.

+ Gustavo

> 
> I have some working prototype
> 
>    https://github.com/ppisa/qemu/commits/net-can-ctucanfd-platform/
> 
> but I have some questions how to implement interrupts processing
> (or logic function) correct and acceptable way. I wills tart new
> thread and hope somebody responses and teaches me what is the
> proper solution.
> 
> Best wishes,
> 
>                  Pavel


