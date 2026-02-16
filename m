Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45104E63F33
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 07:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrtDB-0002fu-FK; Mon, 16 Feb 2026 02:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrtD2-0002fW-Kv
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:39:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrtCw-0002HH-R3
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771227584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9Sd22frdKEr2L0ol1+aGwYGCZ26GSezlhVAp+dwe5g=;
 b=V9b8dOaZtLtlCC9rVd7rMBEmfk4WPPtrj8ABtIICOj3paoMic57DP6Om1rOp+O4nBJ+4vA
 zpSUst0iOj0+Dc1jnn0DRPttVqyBn6vM+95OsiiFZOZjkOyk1azyJhUKvNjA+eI2kzXXBW
 G5H1iXkRdAhbfIPTrzkliUIPSy9tYgY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-vL1znrBhOwm2hl8MhZTcrQ-1; Mon, 16 Feb 2026 02:39:43 -0500
X-MC-Unique: vL1znrBhOwm2hl8MhZTcrQ-1
X-Mimecast-MFC-AGG-ID: vL1znrBhOwm2hl8MhZTcrQ_1771227583
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5033b62efa7so219799631cf.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 23:39:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771227583; cv=none;
 d=google.com; s=arc-20240605;
 b=ATk9E3iFyRByADoX0cKhqYdEaX1g0Rx2oAQF1fYQFY2bHfxedgydl4RU3zEIwyGOyj
 PjL2mSLT8KHbIL6u2qFuYxYP9Mfb0NM9Qv4MgYYHY/BXZPehWB+rM/XACCAUEMyA4cTd
 Q/rJvc5887ZSwPrzBi0nl7n/uNdek2fbMmun6tPbtpSeS0VjiVQ1s+o43/pDxnSMze/i
 q+lpkhSCe/Gs86ruZJJECZTF4mD9YfCAOrGPCAP3KbBvCjdzygBlh7xwkMpz9w4RIKJe
 45YN7pZOf+iiFKxc4Yo5ZSBtsAdWHTRh+e2xk0E9J71ZggHNsZybBaKxjVpQ/9sW2xiI
 lutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u9Sd22frdKEr2L0ol1+aGwYGCZ26GSezlhVAp+dwe5g=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=by0pbTpnyQwkhCctr7n8oyPBt4LmR+BfvZlEZm7DYLHbVlX7CrEE0uVrs2a5o4MYi9
 EV561agEe6PcYjHED5cyZxbxsUXkAjdRe6yvachjjo202zxH/Hbz0k8kQ+WWRdArlp2U
 aM6fhBxt6/fPmTyw5BDdkz+3a5Eui1sUhurqz9KyswHJ1+YoMNAjuNLqGjoMZ0p4KHqb
 YEPZoJlcl97vfj2FropWpXbzTPAbys39QRh8DMip0TpiNDxo+RL2i/xX6KBg4UR8KoXK
 4B7fLgcDvrOnrmrfMvUlFGsCLbdlowLz6u7k0D4ukSBWBDP+pyZp53GEBzgRbgLhFHGB
 +/ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771227583; x=1771832383; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u9Sd22frdKEr2L0ol1+aGwYGCZ26GSezlhVAp+dwe5g=;
 b=jjuGSP+RHuRvTxz0tFN55BgeYjSfuEVRtZ3MzBUMypwD8ftY6pafJNYAVW4AHDc/N7
 Gu2fcmZkEg85aB+qYf+Q3H5GHlup8nh6ejOhtNlBF8fug3wPdVFe3vIzTqIKD7UYSpFC
 9UCW5wQLacq6egyAvA7Fj5zvPaMR9x7Kjl4Wzcmdm6AUIM/DsSttuR1efIiLrMcrxVUr
 tVkDTEhqRU4JDin7qR2QpWuI0XNs9CuLnKrtyg6o+SaFUayJmf5ECLuXetUIzgAxYy0Y
 PvrG2sNBPYY0JgJ+J1VMD/yhuvUT4RoGQcp09FQZPm4YAKNhOr2zZirfH27of5OvF+w0
 dABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771227583; x=1771832383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u9Sd22frdKEr2L0ol1+aGwYGCZ26GSezlhVAp+dwe5g=;
 b=X2wq32PuQ+XStJGyOgI04dFkb4H4NW7XcahnoR8gyc2tCrl8iYLR3jRXTtf7aVeBn6
 fjfxsXmilrIvYkZvp4hdKSDcJLGGEssOKe+qyP+dxrst5BxcEd/badYMs6dImBjv2kEM
 xEbU4oDop94+52Gl9t2sxCDEQNUCghDpwbihf0nnzBUny7o7u1ENRGgnwNDvu9TFGLKC
 w0scrQ5eFIjHRtkdkEJdpUfwDuelwImXES/n8pjAhfBBqrTNY5fR1ufhxDpX+KWZSJGG
 azelToCEItl1jlNAwGzupOWgJDhhCb2SVd6Skk3JHo3TVMk0zaZBcK9JJHiCspVOicHc
 YNyw==
X-Gm-Message-State: AOJu0YyD0l/acqhJUjiBWVpIkN82/K0q6e1WZGFwEWyE9N0zJDgPX8td
 Yo/tele05KgjNIDci5DvBKzhE7hsndhDEgz+VNWAZ8AYvyo44OGcJTJ4+qIPcTFUZ3xd4BIF0/b
 1sqt7lK2pxufGqAeBL+YWCEf8B9Y4WDVS17Vcq07zgGbYbr5qMl50m3y3/6plpNh1Bh2oVYt8LM
 Gcetbw/wihz00MMIqbZcsG+FztTaBZiAU=
X-Gm-Gg: AZuq6aJxmEUQaGInwjI78IAk1OvDUv00hcVFCf48DHxkpAzdKpBysapNfJKJb8colug
 YnVXvpbhCW3LxIpkH/NmSF+54DpcUa7xkAjUSMe/CDi4l+eDbSh7FQMDxeX5O2qp6pvJAw09g4m
 YyIYFVhABOLZ2bPRvcICmSmMvwSjSztlzh4Ulbj7uRb9ICCFO1s9B0BfpKuiJjt1GuLC9isVgXy
 UgYyG/9+IfTkBVqHGtQUakAAnOIzk67pUGW
X-Received: by 2002:ac8:5d56:0:b0:505:e4ea:ffa6 with SMTP id
 d75a77b69052e-506a8334d80mr126180791cf.54.1771227582723; 
 Sun, 15 Feb 2026 23:39:42 -0800 (PST)
X-Received: by 2002:ac8:5d56:0:b0:505:e4ea:ffa6 with SMTP id
 d75a77b69052e-506a8334d80mr126180631cf.54.1771227582275; Sun, 15 Feb 2026
 23:39:42 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-1-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 13:09:30 +0530
X-Gm-Features: AaiRm50yzQvxM6JFqzm6QkPaj1LbcPcUNJlzlsZLfJc1sDnbojyB4oYdJltW6V8
Message-ID: <CAK3XEhNNRDRyg5hNUwpoYo8KS2CbyPEBHnzqjFH1zY8jjFhwCg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Introduce ACPI watchdog for Q35 and arm/virt boards
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 6, 2026 at 6:44=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> Windows doesn't ship built-in TCO watchdog driver, and users are
> forced to install vendor specific driver(s) if such exists.
> However OS provides a generic watchdog driver that uses
> ACPI WDAT table [1] to abstract actual hardware behind it.
> The same applies to ARM version of Windows.
>
> This series adds
>  *  WDAT table tailored for TCO watchdog that Q35 already
>     has as part of ICH9 chipset and a knob to enable it.
>  *  SBSA GWDT to arm/vit machine with WDAT table tailored
>     for it and necessary tweaks to GWDT to make usable
>     with WDAT driver.
>
> Guest OS support is present since Windows Vista and Linux since 2016[2].

I am confused. The linux documentation for arm64 says WDAT is not supported
https://www.kernel.org/doc/html/latest/arch/arm64/acpi_object_usage.html


>
> One can test it launching VM with following options:
>    -machine acpi-watchdog=3Don
> to trace access to TCO registers one can add to CLI:
>     -trace "tco_*"
> to trace access to GWDT registers one can add to CLI:
>     -trace "sbsa_gwdt*"
>
> To verify that guest uses WDAT (both Windows and Linux would use it if pr=
esent),
>   * on linux make sure that watchdog service is configured/enabled
>    (use wdctl to check what watchdog device to use and confirm that it's
>     wadt based one) and then trigger kernel panic with command:
>       echo c > /proc/sysrq-trigger
>   * on Windows kill svchost process, running cmd in admin mode:
>       taskkill /f /im svchost.exe
>
> Tested with WS2025 & RHEL9.6 & Fedore 43 (aarch64)
>
> git tree at: https://gitlab.com/imammedo/qemu/-/commits/gwdt_v2
>
> 1) http://msdn.microsoft.com/en-us/windows/hardware/gg463320.aspx
> 2) https://lwn.net/Articles/700524/
>
> PS:
>  previous revision (q35 only):
>  https://patchwork.ozlabs.org/project/qemu-devel/cover/20251030123750.136=
175-1-imammedo@redhat.com/
>
> Also CCing SBSA folks to see if they are interested in adding it to their
> reference machine
>
> Igor Mammedov (11):
>   acpi: add API to build WDAT instructions
>   machine: add "acpi-watchdog" property
>   x86: q35: generate WDAT ACPI table
>   tests: acpi: x86/q35: whitelist new WDAT table
>   tests: acpi: x86/q35: add WDAT table test case
>   tests: acpi: x86/q35: update expected WDAT blob
>   arm: add tracing events to sbsa_gwdt
>   arm: virt: create GWDT watchdog paired with WDAT ACPI table
>   tests: acpi: arm/virt: whitelist new WDAT table
>   tests: acpi: arm/virt: add WDAT table test case
>   tests: acpi: arm/virt: update expected WDAT blob
>
>  include/hw/acpi/wdat-gwdt.h            |  19 ++++
>  include/hw/acpi/wdat-ich9.h            |  15 ++++
>  include/hw/acpi/wdat.h                 | 118 +++++++++++++++++++++++++
>  include/hw/arm/virt.h                  |   3 +
>  include/hw/core/boards.h               |   1 +
>  hw/acpi/aml-build.c                    |  14 +++
>  hw/acpi/meson.build                    |   5 +-
>  hw/acpi/wdat-gwdt-stub.c               |  16 ++++
>  hw/acpi/wdat-gwdt.c                    |  92 +++++++++++++++++++
>  hw/acpi/wdat-ich9-stub.c               |  15 ++++
>  hw/acpi/wdat-ich9.c                    |  87 ++++++++++++++++++
>  hw/arm/Kconfig                         |   1 +
>  hw/arm/virt-acpi-build.c               |  16 ++++
>  hw/arm/virt.c                          |  26 ++++++
>  hw/core/machine.c                      |  20 +++++
>  hw/i386/acpi-build.c                   |  12 +++
>  hw/watchdog/sbsa_gwdt.c                |   8 ++
>  hw/watchdog/trace-events               |   9 ++
>  tests/data/acpi/aarch64/virt/WDAT.wdat | Bin 0 -> 260 bytes
>  tests/data/acpi/x86/q35/WDAT.wdat      | Bin 0 -> 308 bytes
>  tests/qtest/bios-tables-test.c         |  34 +++++++
>  21 files changed, 510 insertions(+), 1 deletion(-)
>  create mode 100644 include/hw/acpi/wdat-gwdt.h
>  create mode 100644 include/hw/acpi/wdat-ich9.h
>  create mode 100644 include/hw/acpi/wdat.h
>  create mode 100644 hw/acpi/wdat-gwdt-stub.c
>  create mode 100644 hw/acpi/wdat-gwdt.c
>  create mode 100644 hw/acpi/wdat-ich9-stub.c
>  create mode 100644 hw/acpi/wdat-ich9.c
>  create mode 100644 tests/data/acpi/aarch64/virt/WDAT.wdat
>  create mode 100644 tests/data/acpi/x86/q35/WDAT.wdat
>
> --
> 2.47.3
>


