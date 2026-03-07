Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090CBF55102
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyu2L-00053q-Vh; Sat, 07 Mar 2026 10:57:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyu2I-00053X-6T
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:57:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyu2G-00049T-Gi
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:57:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4852fdb36a8so5666345e9.2
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772899067; x=1773503867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dlSK1j/VjooLvCJuHt+EHfwQhEZiRMPePR057knV1iM=;
 b=WBK11m40kN0MTP3Yn92NMpVzXo6SEMA9BupUnHq3DdnI9ejyHIwkHpvscOF7H/O3Mf
 5AAKj2g5WhuDgc6axg5A040cg5yHc66SNs7/tsAFd3YUn/4nR0RIT0a7ozso5cSh9bcc
 dKplk80RFl0cd76e12Bw1lNbyoD1BrP0vrc1/uJ8i4hGK73wtFNaxf0G3FcFSjvb/vc0
 YHTh0t8xGamddpFd1jTixA5HsbLlWcLWZYXPiebk5Ga600bxx6Sb7RISzNlTIi2oLbPo
 Agpk0C+HURr52IaDowhtVhU0dd/qIz3slZ/T7pjVzQVplkfiaUOHnE3Al+ye0JXvZFJ+
 XoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772899067; x=1773503867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dlSK1j/VjooLvCJuHt+EHfwQhEZiRMPePR057knV1iM=;
 b=PohZziVzgl3xQRubnWtYSgfmt4PxAtdYooF6D9iRvP0CBxMF1MlkW/NIS744gcpSuE
 hXfXQUAZuHOLoy2lZ7UhrBZP6ModZoa5zAVyCYosqBfRrU07y01y/tQPmOoAruAbXTwO
 AK9KsX1GKH7+Ur1rVrz3GZWpGdcBCCBuszIG7wOyDoHAzOvGqpWBeQEde5ZMJNHO/xh0
 BHbfyOkWqu6g62lVBg6/zZCZlquWMXXp7c/Pw19ypti7PsGqtTpN1YiSFroWu8N4l5oV
 J3bMmXwQDKSIyu4N0Ouk6n3HOk9r8jEwjxTHrgdXJpLG0mjcEOM06VX0rwvd9fjMzIp8
 3Ljw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8Xhl16aWSAwG6GuO0mxulEGeBru6R4qyGLc2xT3wY3j+jnpMbG3sEtS7RNoNUqW0BmaHFkUgX3CR7@nongnu.org
X-Gm-Message-State: AOJu0Ywgs4HnYuFnfGml4iFV7BLdL9FoDJtsZ5pzncbsDfkOKcqjSIsS
 cW6t1X7Vyj35QvJ6KNxsvNbMuC8zpzmwUhxIcp+7RZunlyjLEvl/VpXON33ePDG2UE0=
X-Gm-Gg: ATEYQzwN+Pfw7L3wPl8+OA8exh82IH7gvdBkLaZuqNhkC4V6JFueiKLC94MhDWVxGxI
 lU/aJYdNikRuc7vhxfkgImE3BVui0AGpYb+FQ0kaTmaTkru1pWS/y4QtKHtsyip68sDj75WgqWb
 wzYnfpM1OJZjaqAPFpdkt+797yuynNUTYUg8mdv7opCVQjw4kahY5zntBxXAIOc9vu46r0Enovy
 GVjokRUrrWwIkYer1EbCKH88FVQetZ/VYHoVnT20YVwcNE2FqWRzcTQNgFPktrQWqApFJyUxcW8
 ilM7UWoB0UO9dFWoVhwQ/An16TfvBWQSU0G9LwhyqEUiaCV4p/5L08fi67kaXPkFUr+MCQKYNUf
 PwnDyOUoape8POAdoJzHXETKLu94z6q4bh+DIsFAXt2dYWNg9QMpu++hoCiaPckaBwSqM3oZlru
 KMSI2vZ3D+5NIUI4q5fIweWEq0j6NGavZJ5HkDyizjbvE8MzFKT1yFF/4kthe7W73NNg==
X-Received: by 2002:a05:600c:198f:b0:483:6ff1:18b with SMTP id
 5b1f17b1804b1-485268bd6cbmr99614835e9.0.1772899066745; 
 Sat, 07 Mar 2026 07:57:46 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae56300sm11518010f8f.37.2026.03.07.07.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Mar 2026 07:57:46 -0800 (PST)
Message-ID: <17294e54-cce8-43e1-863e-e1b2583763ad@linaro.org>
Date: Sat, 7 Mar 2026 16:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw: Make qdev_get_printable_name() consistently
 return freeable string
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
References: <20260307155046.3940197-1-peter.maydell@linaro.org>
 <20260307155046.3940197-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260307155046.3940197-3-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/3/26 16:50, Peter Maydell wrote:
> The current implementation of qdev_get_printable_name() sometimes
> returns a string that must not be freed (vdev->id or the fixed
> fallback string "<unknown device>" and sometimes returns a string
> that must be freed (the return value of qdev_get_dev_path()). This
> forces callers to leak the string in the "must be freed" case.
> 
> Make the function consistent that it always returns a string that
> the caller must free, and make the three callsites free it.
> 
> This fixes leaks like this that show up when running "make check"
> with the address sanitizer enabled:
> 
> Direct leak of 13 byte(s) in 1 object(s) allocated from:
>      #0 0x5561de21f293 in malloc (/home/pm215/qemu/build/san/qemu-system-i386+0x1a2d293) (BuildId: 6d6fad7130fd5c8dbbc03401df554f68b8034936)
>      #1 0x767ad7a82ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
>      #2 0x5561deaf34f2 in pcibus_get_dev_path /home/pm215/qemu/build/san/../../hw/pci/pci.c:2792:12
>      #3 0x5561df9d8830 in qdev_get_printable_name /home/pm215/qemu/build/san/../../hw/core/qdev.c:431:24
>      #4 0x5561deebdca2 in virtio_init_region_cache /home/pm215/qemu/build/san/../../hw/virtio/virtio.c:298:17
>      #5 0x5561df05f842 in memory_region_write_accessor /home/pm215/qemu/build/san/../../system/memory.c:491:5
>      #6 0x5561df05ed1b in access_with_adjusted_size /home/pm215/qemu/build/san/../../system/memory.c:567:18
>      #7 0x5561df05e3fa in memory_region_dispatch_write /home/pm215/qemu/build/san/../../system/memory.c
>      #8 0x5561df0aa805 in address_space_stm_internal /home/pm215/qemu/build/san/../../system/memory_ldst.c.inc:85:13
>      #9 0x5561df0bcad3 in qtest_process_command /home/pm215/qemu/build/san/../../system/qtest.c:480:13
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e209d4d7a31b9 ("virtio: improve virtqueue mapping error messages")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/qdev.c         |  4 ++--
>   hw/virtio/virtio.c     | 12 +++++++++---
>   include/hw/core/qdev.h | 16 ++++++++++++++++
>   3 files changed, 27 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

