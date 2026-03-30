Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC910FB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78eP-0006Ye-EP; Mon, 30 Mar 2026 05:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w78eN-0006Q0-7m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:11:11 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w78eL-0000Sl-7i
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:11:10 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-65015facf32so1831242d50.1
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 02:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774861868; cv=none;
 d=google.com; s=arc-20240605;
 b=O54MgYXTAKp48zymLN0g5apgis4Yvsjv97JAdfzKyE+qdikKzXtxR9FdhmdW0SX2yj
 5y+G0SWM2BPO0C1JfHyoMGeew5nFGHOEx17WaI7Piei37iD/Vgxp2QUU4dUfgSooQq1B
 /tu0v7vw0tB7VaKbCclHQXBF2zSFA/zfbcC9nIyaQ5L0hprXhXCI3rOV1wNSA58p+oxg
 jzcL3B3S+x6J/8CdsppUBgJmAvmoQpRtbuDqLbj1oAy4+/iYs+TNk4kn5BtOwxywcnIZ
 oOpY3QVUHAnoEuFrzOhZRu2syElJSVxTvMV3OPbSrDkxfVMCHhFx7kkffsqT9a2+doz7
 xsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=owI5dtMycZYaLEy36IjwxgMiUTF5C00eDcux482guz0=;
 fh=8c3t6UhRFb631nsWonrU6Bq/NesPFhq1XX2ZZlTsY7E=;
 b=RvUiQvcq4MLbVmmUIPCIz05z7Av59Uj290aocr7nwrC4dislQiFGBEoWYGtLBnoFuA
 7pIbB8GLr94FIr3mGtDpUcGBN2IrTztAV5GpmeEDQqbOCPwJSNd/Qfo66XpllhGVjdEL
 6BDuWgyS4AIdwCFt6F6o/Mar5NPmpa4KUNOd/S78gSq19GLIJFwdAxW9V4Dr+V3Oy9kx
 ZvBkyiR9WLyMno3DeSPRfN3/RzaBzjbhXmOSDB3bVgkcQd1oNQ3Khlfmd2YLTkLHhRRj
 4Bnm9hoeA0a420GraZqfQ/EpOTopSPF9Vm4Zb516jCXayCawduN+l7tc1EVllzjoSqTs
 fbSw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774861868; x=1775466668; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=owI5dtMycZYaLEy36IjwxgMiUTF5C00eDcux482guz0=;
 b=mZT1NhIoZ+z58z6H8sCqhP2UEeEfIZUtpmXwPZSNGNeyaL80XcJbMIkfl32pdQ0JFt
 JF50Qb/ohassTYV891L0mMCnRwNkTtpKAgzIj+wQMpnh2r3GGSRqQYRpy+ocqMGwNORR
 2uKmRG1lc3JMEEyBkfF8DWSpUDHr2gy6WTZyWULp/qT7hAzlTQbuJ76LW6lDuADxQsJu
 Snjm3Xvx7/54Orw2VmdzZYQbdbmcYHDmO3aoeA0yjVRhnFcQc9yt1VgiO3A0xWFUI1vf
 ruWd4N2j2/5Aa1ttWcL1CJpig6Jqj9AxZ0znQNw3nDAmIr7BHy9y6ZpZfBtHK1MiGx1s
 HPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774861868; x=1775466668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owI5dtMycZYaLEy36IjwxgMiUTF5C00eDcux482guz0=;
 b=qwX+dnEmdr4SFObIkW1P1qnlfYW0PdUFX1Bt0Kr0dwwPK4HQ8DCLFpw1Rqwc1RV6OD
 ThV+u7K2FJZKIQlH554+dNmqmt3zj3UQ0qieuvZ9VXrRkjTZP1cLckm4c5Z140WaR5tl
 sylh5bE75EDn3j8Jg3FOpPGewaWq/cJTjQvOBiBBDDCot0RB4cO0a/28tPZMuHX0NS28
 FtMk8RRMT3dV+222qyCjV1EjIr/ub3ITtvbiGszSgconLhXvLej9QIx7K2ZaaO5nckf3
 gOzlAzTAFZpSUK9u5M7kvw+CSNshQItFEgoq6SMk3B2f/9Rzsq1FkPjYdJ94xUwxiS0M
 AWZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzFxyh1UFRNh/dXDflNarReg3R9qvzwX1O/I2guzOtu6wL4yHQaR2oINvxcNzsMPSBdWTbyeucEczU@nongnu.org
X-Gm-Message-State: AOJu0YzDutxUgWy9Lt6g0Mr3HSSqVd3GfOZDaE1sfIGrrnuSnzrsFxM5
 fYtXwCOVgSaMEWB6H/6bBdx8Ibc6R79VvceC7ncXKL/KftLOh4APRtyXwhxwagZwVKgvcJzQfaW
 fCL7rsLlOaOsBdRBgIpU5cerlHNqyREYcoZiyx/u2gw==
X-Gm-Gg: ATEYQzwV0cWWOPUYOUkLFw79TIneAKZdYGpWMK+3vekLxaYTiUCnkMXqFDtq2lvcr83
 12lVFyUItFsrSWC6+ZwSOjw1w6h7RssWS+fcv3jw620qCORBBNOcAD/MRS829f5UbBLhIcSAWlU
 yblDEQh5Y4jwkRa9UTaVANmLE4BI8QTcIF5174/CMyjetg2dWTTELH9Gh9IJRfN17WKJjCHhRPQ
 JvSNn6KPTrUhTBS0Eg41BJbC81IzXYXtahNebOFg23G0n6k3RdqB9XdGMAiFPXkBHq5ASyTJ+rF
 DPKIm0Fw+vEtMs6+QfvzjXdRXHVkL+q8/VbXeyN2peRajArskf0vO+DA0PMhqX6olA8=
X-Received: by 2002:a05:690e:144b:b0:650:1403:dc8f with SMTP id
 956f58d0204a3-6501403dda7mr4676066d50.23.1774861868020; Mon, 30 Mar 2026
 02:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260330053008.2721532-1-zhao1.liu@intel.com>
In-Reply-To: <20260330053008.2721532-1-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 10:10:56 +0100
X-Gm-Features: AQROBzCi1SWx7l4v55XoUYRzHuUUJgKvQSVMZiztJrZw9pPkCa-xjIuj3VD5v3w
Message-ID: <CAFEAcA_jt7ghdLoCNi6K7Ld3ByM04Z+ANiKr_yU6ihR3s0svAQ@mail.gmail.com>
Subject: Re: [PATCH for v11.0] hw/acpi: Do not save/load cpuhp state
 unconditionally
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=83?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Mon, 30 Mar 2026 at 06:04, Zhao Liu <zhao1.liu@intel.com> wrote:
>
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
>   $ qemu-img create -f qcow2 dummy.qcow2 32M
>   $ qemu-system-mipsel -nographic \
>       -drive if=none,format=qcow2,file=dummy.qcow2
>   [Type "C-a c" to get the "(qemu)" monitor prompt)]
>   (qemu) savevm foo    # segfault
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 7aa563630b6b ("pc: Start with modern CPU hotplug interface by default")
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> Tested with the following cases:
>  * savevm for MIPS Malta
>  * i386 migration:
>    pc v10.2 (before 7aa563) <-> pc v10.2 (with this fix)
>    q35 v10.2 (before 7aa563) <-> q35 v10.2 (with this fix)
>    pc v10.2 (w/o this fix) <-> pc v10.2 (with this fix)
>    q35 v10.2 (w/o this fix) <-> q35 v10.2 (with this fix)
>    pc v11.0 (w/o this fix) <-> pc v11.0 (with this fix)
>    q35 v11.0 (w/o this fix) <-> q35 v11.0 (with this fix)

Tested-by: Peter Maydell <peter.maydell@linaro.org>

I filed a bug yesterday to track this, so we can also say
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3360

-- PMM

