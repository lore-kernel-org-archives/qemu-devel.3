Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29774C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB5ol-0002nq-8i; Mon, 28 Sep 2026 03:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xB5oW-0002mc-HD
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:30:17 -0400
Received: from mail-oa2-x0f.google.com ([2607:f8b0:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1xB5oU-0003tx-2Y
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 03:30:16 -0400
Received: by mail-oa2-x0f.google.com with SMTP id
 586e51a60fabf-4881ca701a4so1306430fac.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 00:30:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790580612; cv=none;
 d=google.com; s=arc-20260327;
 b=o+F2FL+F7EvYi7H8FD0APZCEtOxUQ5xTrFS5gMnmycPquoJ5Vv8o2b0VnHfHXElGe6
 uwfMLT6LX8VskGe8Cqk36a9GPi4HMbxp6cOvaZQnEUps2LejQkZYysfx9Gx7nmr2gZb8
 n3V7JHC9rpTxK9n/g+YtpExWpvGFYLC4P/EwnIDIGKpGcGqYngmhP4PPuKf3HQOlOcLz
 tl1y5+fBo6twUsXx8aadP2WiEJus1cbnMTwsArcNkSO9r3STtxZtj4W0WMSXlpW1Owbp
 Xfy3r5u0qaaNtDcMVPVn+0brnlOTE54rMk0JGxuIinw8Pp7Vk1XFxUuoCxY2ILvwxCPS
 bhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0799OkhyTz5fJIugeMO9oeQBN8ZDEYgpoQhEI2EiyC0=;
 fh=JesqujW+4n5wwxEr9j0icqM59IeDN0FNO0hEq7vDO08=;
 b=PiyAMyqI6fClzvAz8XZCLzKYPfaSflJ6d3OfYzUFFfUXwqXroLCUZ/xqla6UV+ZaI0
 C7ve6h4UmzTfxh6om7d13oiQ3DpNUNw5HAGUsvV3iqo97rEs8ftJm5q4lUHx1XmpDJCz
 IhmAJjKRR9pIlIvIUdU5i9zWDSLMcPi168ziuzfKAIQAlJuodBzl6ouyg7gfbj4prXSR
 a0yqXPS/maT3P873LGFlqGHq5LCJPrSuoyxI9GtPBzZYJFT4oo1mqCeu3Nhd0EZ5D5LF
 hKQVjN6iyRUF41H/AKxf5j+4CdLansAg5iRGAnrILlaWGDoixlKeyyE6FULal1Rlqwlf
 ZUuw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790580612; x=1791185412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0799OkhyTz5fJIugeMO9oeQBN8ZDEYgpoQhEI2EiyC0=;
 b=ZT5y7JClL+Kx5lwlsqeS++vJ4s5ceiFouW/5oPd5ZbtsDhbI7ln+EHcmG5CoON1Z7z
 H2fHro5h8E/XgA2aAlLibPKO9TKyezmeb4LJGDb2iqHj00SurJjGL9G60s3U7kKmFhWM
 DZwpgi7Kwave5JHeRShJRuwCo/Bac9Qp5Dm8nXDuBlbBYBt4s9Lrzg8R4O3monzR/IFm
 ORLy0EG3QHOlGpahZFDCD4jdarEoBVvd80Wlo64XXd5HWnPBdsmUreaqRYyCdgOGsgGY
 MfrP3yoPT1z5Mjc5WGW6bC8bdqeMYP0gGuGJhOLUsHisOsC930l6RaURk99S5/2YHBxw
 gbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790580612; x=1791185412;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0799OkhyTz5fJIugeMO9oeQBN8ZDEYgpoQhEI2EiyC0=;
 b=YY9tH8NPafm8JtBb9KyTuqIoNEomiaSlNwBYpnxUrWSBBqLilySE4NJBffKphdXwoM
 J8l6pHzUtWMyWNSdzk/+bhYrgS+r5+CI7M5w/4VaWxeLLyxVoj45kOeUonfGMj7a2ZZh
 8ycIcd/vNYwgc0N80dQlui9qliKqU6MPhn3guU1LI6biVdOhe0WsuKTJN0tA/ck8T3Q2
 wfV7PPjnLG/m8qRh+3DpeD/jGiS52zN16wIv4ki7TCEFCg4WEJ7e/+4o/5SINS804v4A
 /hR/UtJ8LUvuXd7A874C9Kxj+tK3nmgDQjnLKf9eKDFbguDbASW1TSMMomF/agD6F0uN
 eQ8w==
X-Gm-Message-State: AFq9FYIi/D4je4aZcvky2pZZkLtWCAybAF/lV6NJ364Meyf26tQE8Vr2
 mwObeVqDejzT9s0fEESKUxTVxHM6C0bA+BFqMf3SBV414HMmqPuGdy7qvoc9bLy9MlfU8QKhb6n
 9zSp9d/ueRuMsQGLZL3nVVZ3X9aN9A+fesOdEki3Ayg==
X-Gm-Gg: AYBFou366JQ0sY43VC7cpNsIzrAh19UGv7+ecfFalmXPR1CUu25PwT0LOK5SvJG88ZO
 GLLnkmyrybeMLI4e9YUDIy4RbwDxpcDOe1pOcLltwq4NCXpGw5crpRvL6CitWBKfrsM9ZSC9Uli
 QKhOMa/aqZ8laSIGAJYvhGCeEkn7CFs1H88s3EdLArNj47aWWnZAjkCaRYrYNA0bRUFuorzWi1w
 e3ZeOyLke33Xlf0eG1bQC+NhGqYapT1tkNzfvOQ6B1h0N4M2FPo4QvJ/PV69wPi/ZOqLpX7qDh6
 M+fDLkqRp+KIs4ljtJuK+Eu+LZ5YuJwef0mdMIELRMEOuhHlZ2WV3l/n
X-Received: by 2002:a05:6871:88c1:10b0:493:6d53:a17a with SMTP id
 586e51a60fabf-4936d630b71mr5077247fac.23.1790580612088; Mon, 28 Sep 2026
 00:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
Date: Mon, 28 Sep 2026 09:30:00 +0200
X-Gm-Features: AclHuK_FMa8iT37nKkgObIO1gWskry6C-v3DvhPrseBvB8uQH7jMNvrxyphhiuk
Message-ID: <CAN-aV1FkruRxDPiveZiUiT8KXDW1VyhJgqq1rwdTpdg0EsF=1w@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] hw/core: Introduce Remote Port Co-simulation
 Protocol
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com, 
 peter.maydell@linaro.org, francisco.iglesias@amd.com, 
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai, 
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:30::f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-oa2-x0f.google.com
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

A gentle ping. Would appreciate some feedback on this series.

On Tue, Sep 15, 2026 at 6:01=E2=80=AFPM Ruslan Ruslichenko
<ruslichenko.r@gmail.com> wrote:
>
> From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
>
> This patch series introduces the Remote Port (RP) subsystem, a framework =
designed to connect QEMU with external simulation environments (such as Sys=
temC models or RTL simulators).
>
> Updates in v2:
>
> - Removed global 'machine-path' and 'sync-quantum' cmdline options
> - Added EventNotifier for communication between IO and CPU threads, inste=
ad of pipes and sockets
> - Made chrdev_id mandatory and simplified chardev configuration
> - MemoryTransaction .access handler dropped and reworked RPMemoryTransact=
ion to use existing .read/write_with_attrs
> - Reduced coupling with HW Device Tree by making rp devices register them=
selves within rp core using rp-chan property
> - Dropped debug macros and added tracepoints instead
> - Added reference to sample project using QEMU with SystemC
> - Addressed review comments from v1 patch series:
>   https://lists.gnu.org/archive/html/qemu-devel/2026-02/msg01760.html
>
> Origin:
> The Remote Port protocol was originally developed by Edgar E. Iglesias.
> The original source code is available in the QEMU repository at AMD: http=
s://github.com/Xilinx/qemu.
>
> Motivation
> In modern SoC and FPGA development, specialized hardware blocks are often=
 verified using SystemC, Verilog, or VHDL long before silicon is available.=
 While QEMU is optimized for high-performance CPU emulation and software de=
velopment, it requires hardware models to be rewritten in C, which is time-=
consuming and duplicates effort.
>
> The Remote Port (RP) subsystem addresses this limitation by enabling a Co=
-simulation environment. It allows QEMU to act as the high-performance Proc=
essing Subsystem, booting complex operating systems (e.g. Linux), while del=
egating specific peripheral modeling to external simulators (SystemC, RTL) =
via a socket connection.
>
> The Remote Port protocol provides a socket-based interface that supports:
>
> Memory Transactions: Bidirectional memory accesses (Master and Slave) all=
owing QEMU to access remote devices and vice versa.
> Interrupts/GPIO: Propagation of interrupt signals between QEMU and the re=
mote peer.
> IOMMU/ATS Support: Support for Address Translation Services, allowing rem=
ote devices to operate correctly behind IOMMU.
> Time Synchronization: Keeps QEMU and the external simulator in sync by ad=
vancing time in fixed steps (quantums).
>
> Integration with SystemC Ecosystem
>
> To connect the simulation side, the open-source libsystemctlm-soc library=
 [1] is used. It acts as a bridge, translating Remote Port protocol packets=
 into standard SystemC/TLM-2.0 transactions [2]. This allows users to attac=
h existing TLM-2.0 compliant models to QEMU.
>
> Architecture Overview
>
> The series is structured into the following logical components:
>
> 1. Core Protocol & Infrastructure
>
> Establishes the socket connection and handshake (Hello protocol).
> Implements the packet dispatch loop and thread management.
>
> 2. Memory Transaction Support
>
> RP Memory Slave: Allows the remote peer to initiate bus transactions with=
in QEMU.
> RP Memory Master: Represents a memory region in QEMU that forwards access=
es to the remote peer.
>
> 3. Address Translation Services (ATS)
>
> Implements the logic to handle ATS requests from remote masters.
> Integrates with QEMU's IOMMU notifiers to manage translation caches.
>
> 4. Device Tree (FDT) & Configuration
>
> Added FDT support for Remote Port Memory Master and GPIO
>
> Dependencies
>
> Patches 19-20 in series are based on the following previously submitted s=
eries:
> FDT based machine v3: https://lists.nongnu.org/archive/html/qemu-devel/20=
26-04/msg00415.html
>
> Instantiation of Remote Port via FDT also registers its reset handler,
> needed to start protocol thread.
>
> Validation:
>
> The Sample Project demonstrating test setup with QEMU/Remote Port and Sys=
temC emulated PL011 UART module available by following link:
> https://github.com/renesas/SysC_Island_MIT
>
>
> Patch Summary
> The series is organized as follows:
>
> System/Global:
>
> system/physmem: Add ats_do_translate helper
>
> Remote Port Core:
>
> hw/core: Add Remote Port protocol packet definition
> hw/core: Add Remote Port header helpers
> hw/core: Add Remote Port session state and hello protocol
> hw/core: Add Remote Port object skeleton
> hw/core: Add Remote Port protocol thread and handshake
> hw/core: Implement Remote Port response handling
> hw/core: Implement Remote Port time synchronization
> hw/core: Implement Remote Port irq, sync and ATS helpers
> hw/core: Add Remote Port files to build
>
> Memory & Bus Access:
>
> hw/core: Implement Remote Port bus access helpers
> hw/core: Add Remote Port Memory Master object skeleton
> hw/core: Implement Remote Port Memory Master bus transactions
> hw/core: Add Remote Port memory slave device
>
> ATS & Streams:
>
> hw/core: Add Remote Port Stream device
> hw/core: Add Remote Port ATS device skeleton
> hw/core: Implement Remote Port ATS logic and cache management
>
> FDT & GPIO:
>
> hw/core: Add Remote Port GPIO/Interrupt bridge
> hw/core: Add FDT support to Remote Port GPIO
> hw/core: Add FDT support to Remote Port memory master
>
> Links:
> [1] libsystemctlm library: https://github.com/Xilinx/libsystemctlm-soc
>
> [2] SystemC TLM description: https://systemc.org/overview/systemc-tlm/
>
>
> Ruslan Ruslichenko (20):
>   hw/core: Add Remote Port protocol packet definition
>   hw/core: Add Remote Port header helpers
>   hw/core: Add Remote Port session state and hello protocol
>   hw/core: Implement Remote Port bus access helpers
>   hw/core: Implement Remote Port irq, sync and ATS helpers
>   hw/core: Add Remote Port object skeleton
>   hw/core: Add Remote Port protocol thread and handshake
>   hw/core: Implement Remote Port response handling
>   hw/core: Implement Remote Port time synchronization
>   hw/core: Add Remote Port Memory Master object skeleton
>   hw/core: Implement Remote Port Memory Master bus transactions
>   system/physmem: Add ats_do_translate helper
>   hw/core: Add Remote Port ATS device skeleton
>   hw/core: Implement Remote Port ATS logic and cache management
>   hw/core: Add Remote Port memory slave device
>   hw/core: Add Remote Port GPIO/Interrupt bridge
>   hw/core: Add Remote Port Stream device
>   hw/core: Add Remote Port files to build
>   hw/core: Add FDT support to Remote Port GPIO
>   hw/core: Add FDT support to Remote Port memory master
>
>  hw/core/Kconfig                             |   4 +
>  hw/core/meson.build                         |  10 +
>  hw/core/remote-port-ats.c                   | 412 +++++++++++
>  hw/core/remote-port-gpio.c                  | 210 ++++++
>  hw/core/remote-port-memory-master.c         | 369 +++++++++
>  hw/core/remote-port-memory-slave.c          | 242 ++++++
>  hw/core/remote-port-proto.c                 | 467 ++++++++++++
>  hw/core/remote-port-stream.c                | 246 ++++++
>  hw/core/remote-port.c                       | 782 ++++++++++++++++++++
>  hw/core/trace-events                        |  22 +
>  include/hw/core/remote-port-ats.h           |  76 ++
>  include/hw/core/remote-port-gpio.h          |  34 +
>  include/hw/core/remote-port-memory-master.h |  81 ++
>  include/hw/core/remote-port-memory-slave.h  |  35 +
>  include/hw/core/remote-port-proto.h         | 541 ++++++++++++++
>  include/hw/core/remote-port.h               | 164 ++++
>  include/system/memory.h                     |   8 +
>  system/physmem.c                            |  53 ++
>  18 files changed, 3756 insertions(+)
>  create mode 100644 hw/core/remote-port-ats.c
>  create mode 100644 hw/core/remote-port-gpio.c
>  create mode 100644 hw/core/remote-port-memory-master.c
>  create mode 100644 hw/core/remote-port-memory-slave.c
>  create mode 100644 hw/core/remote-port-proto.c
>  create mode 100644 hw/core/remote-port-stream.c
>  create mode 100644 hw/core/remote-port.c
>  create mode 100644 include/hw/core/remote-port-ats.h
>  create mode 100644 include/hw/core/remote-port-gpio.h
>  create mode 100644 include/hw/core/remote-port-memory-master.h
>  create mode 100644 include/hw/core/remote-port-memory-slave.h
>  create mode 100644 include/hw/core/remote-port-proto.h
>  create mode 100644 include/hw/core/remote-port.h
>
> --
> 2.43.0
>

