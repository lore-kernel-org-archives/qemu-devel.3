Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF0C1061B12
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7F6O-0005EY-CU; Mon, 30 Mar 2026 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F6L-0005E3-PT
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:04:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7F6J-0004I0-Pq
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:04:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66bb7e098b1so1435971a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774886666; x=1775491466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/NMoX3efZP+cHnDhORxzhusK8C2AHQfnHOU25vW1VMM=;
 b=Nco2wQ0LjnER6YCUUMmS78KxUeubcx2DZCfDOqXUVuLZzL359v5ydaGuQpJvzg6hMx
 ORQKywGg3iv3v3cKZ+a8vvn0rxPaQivUYj3kqBslZp7yrnb0UcV1nhLFhnChhRsvGCcd
 Bg5xW+U4XnzGY4VMiJj3gD6YehBKey2cGSfw/0qF95u8sE6eUwFu/dpGiBjPY5p2hEiL
 U03+VXffxGt5jzSlJtzwIecPyh2MVHzkqv5Sr6plsKYI54c9vkIGEUMJ1GWIHg5oT7Dt
 QYmpFLNCI4I8W9fD24ZsNohEIXjVvKEDoyB44NS/rub5R8G/Bq7pytOkU6/YdHK3Wo3X
 lEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774886666; x=1775491466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NMoX3efZP+cHnDhORxzhusK8C2AHQfnHOU25vW1VMM=;
 b=QbLMOSKTMCzygNRQ8/F4ZNcjrAksqX009OBP4KUQ99O+Wvldmq5nKqiOSenfZCnw+k
 Ex/yBZoOUpHMuXdhidezMhGsr+txcIur6KgV6OBohF+kIJK8f3Ez2WP3d87M7OaEeABm
 K2YA4yXDCaZDfJCrl9qo/Ewg6dcMZ1I/TtK8PfGop3bp0ZdVogMF69RYP8xlNi1z1FSv
 ze8VnXYPWAHoeSmuSFf0bEqhOecntXdlbAEJBh2JNsI5MLyetjRZijoG08klsMNA1kLB
 X5vvng1vJFKSHvycD4FKNddeCCwh+rFrqC1o4o44/qUbfT/CZa3CWFV1iKxEJdn5//GI
 i76Q==
X-Gm-Message-State: AOJu0Yw/qvPQ6Vm2N73laIS932UQ8pReICBT+92KSTJUpbyMUVyol5FU
 31I9+cXS50Xd/Y/BvAq505T6fc/jCihuoRg3f53M+idVB/dwW2mmLQHwGTM7NERA8Hs=
X-Gm-Gg: ATEYQzyKrJ/EZMAkaRDjDd1nCvOoRReYn07RTT9OU2FhuUSP4WPqHP8uT52GtjCh8+M
 dvEe99XELcAByeTyIomOfkGiXN5Xk7PvGVJIYUsrnf6ouUgQgmOadJJM4CBcZJMNTEIaSI2swCG
 p7n80q7J35CS+z0l3IbWxJWmfYvQHipTWJuB7VdH4bRmjh+KC2dDq0EKpAE77fUG71fupcWpJSO
 StldKkH3IInj5QW5mysdLaF1xip5O9TbheKl3z8hcJpysVINFkU+nTIJ+Dpq5zWOhTgZQ2AYcRM
 PbeCE7Z2CDSjdY9M6EZLpV7w0GJbyc3B0yKRGtqgKngRUub+18ZQz3KxdCWY+qOQ1+ufKntMFSx
 fL7c0ZP7v71J+5P7XEtLceddpGoDSIU/vfk43sKVzc/TPzajyvmc1w2m68AlDt/11vSF0O892/T
 9Wzk0RqyymVh6wCA0/gSR0QgPvokAF54UpoNIhj3f08NSSM/i0uP2QKuCfjJ/h694=
X-Received: by 2002:a05:6402:52d2:b0:668:1479:3c72 with SMTP id
 4fb4d7f45d1cf-66b28c52218mr6941852a12.15.1774886665798; 
 Mon, 30 Mar 2026 09:04:25 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66c074f0a49sm730979a12.1.2026.03.30.09.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 09:04:24 -0700 (PDT)
Message-ID: <6bbe4954-b99c-4bc0-a1db-ebfc0a24fe50@linaro.org>
Date: Mon, 30 Mar 2026 18:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for v11.0] hw/acpi: Do not save/load cpuhp state
 unconditionally
Content-Language: en-US
To: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260330053008.2721532-1-zhao1.liu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330053008.2721532-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 30/3/26 07:30, Zhao Liu wrote:
> Commit 7aa563630b6b ("pc: Start with modern CPU hotplug interface
> by default") removed the .needed callback (vmstate_test_use_cpuhp)
> from vmstate_cpuhp_state in both piix4.c and ich9.c.
> 
> However, PIIX4 is also used by non-PC boards - MIPS Malta, which does
> not select CONFIG_ACPI_CPU_HOTPLUG. For MIPS Malta, the linker resolves
> vmstate_cpu_hotplug to the stub one in acpi-cpu-hotplug-stub.c, which is
> a zero-initialized VMStateDescription with .fields == NULL.
> 
> Before commit 7aa563630b6b, .needed() of PIIX4's vmstate_cpuhp_state
> returned false for MIPS Malta since PIIX4PMState always initialized the
> field cpu_hotplug_legacy as true. Malta implicitly relies on this
> initial value to bypass vmstate_cpuhp_state. However, this is unstable
> because Malta itself does not support CPU hotplugging, whether via the
> legacy way or the modern way.
> 
> Commit 7aa563630b6b removed .needed() check for vmstate_cpuhp_state,
> this broke the existing dependency that Malta had relied on, forcing
> Malta to save and load vmstate_cpuhp_state during the save/load process,
> which in turn caused a segmentation fault due to NULL fields in the
> stub-compiled code.
> 
> Fix this by bringing back the .needed = cpuhp_needed callback for
> vmstate_cpuhp_state of PIIX4, that checks
> MachineClass::has_hotpluggable_cpus. Boards that do not support CPU
> hotplug (only MIPS Malta) will skip this subsection entirely, which
> is both correct and consistent with the previous behavior.
> 
> At the same time, add a similar .needed() check to ICH9. Although no
> boards with ICH9 are affected by this issue, this helps avoid potential
> issues in the future.
> 
> Reproducer (MIPS Malta):
>    $ qemu-img create -f qcow2 dummy.qcow2 32M
>    $ qemu-system-mipsel -nographic \
>        -drive if=none,format=qcow2,file=dummy.qcow2
>    [Type "C-a c" to get the "(qemu)" monitor prompt)]
>    (qemu) savevm foo    # segfault
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 7aa563630b6b ("pc: Start with modern CPU hotplug interface by default")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Tested with the following cases:
>   * savevm for MIPS Malta
>   * i386 migration:
>     pc v10.2 (before 7aa563) <-> pc v10.2 (with this fix)
>     q35 v10.2 (before 7aa563) <-> q35 v10.2 (with this fix)
>     pc v10.2 (w/o this fix) <-> pc v10.2 (with this fix)
>     q35 v10.2 (w/o this fix) <-> q35 v10.2 (with this fix)
>     pc v11.0 (w/o this fix) <-> pc v11.0 (with this fix)
>     q35 v11.0 (w/o this fix) <-> q35 v11.0 (with this fix)
> ---
>   hw/acpi/ich9.c  | 8 ++++++++
>   hw/acpi/piix4.c | 8 ++++++++
>   2 files changed, 16 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

