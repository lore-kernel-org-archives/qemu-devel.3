Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7D6CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNUBp-0000b4-3A; Mon, 24 Nov 2025 05:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNUBi-0000ZO-Ud
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:52:55 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNUBh-0000TR-A9
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:52:54 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b3d4d9ca6so3332425f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763981570; x=1764586370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iK/lamIa2GP8d2MmAgVK21zQ9jh5z0bwbWrJlAfHUxI=;
 b=G/jPafW0UpAuBRnY7jAKHjXbY7Qra8F5jY/B9bb7NttXZ8+3XVPX/rNRMporCjgtVH
 9Qyfr/mOZ0ufSNCAyIiizXoSiHdrqTn+8UVpHNEI9nLW9ipSSaLt8Cn3cp9Zt/oY4qgc
 IxvicKdu8siTjO/DBiBr0DO76hTVNkEeHebn73HCZLG4zjTN6j+Gj37DAD10SioOiEHe
 CZypYBGPkZkrikALA+ACsQ4J5SqsNSkILAFivEfIaYHLkfZy6ZL75+0e2DYp5wGhrtZY
 oLj5OaUtNlheutRwpYregp5oSjSGWGt5GkIzdtWpi62Q8A1GlxzVqj9N2bxFm4QrLX+x
 3GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763981570; x=1764586370;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iK/lamIa2GP8d2MmAgVK21zQ9jh5z0bwbWrJlAfHUxI=;
 b=Yb4Q0e7wh6DU4EqQXGRXji2bLhs3uuEGGLFsdBJzODhJdKRuCzIueZhs30rz16zwAi
 tnWr6lPNlieKgLKjIVR5cnQdXk1AtorLawGF4Tn36/U7840R2nSCxMWaqNT/CljQ9xS6
 Gv1ABAFEZaNdJU5puVBcg28AYkYfIzdrph4pTX3ZcbulkdNm7P81qxcrVx8wSqIdEjsT
 KXQtJxqgjqNMaRZKrQq6HQwtoHjh4TRX92ZFLnvs+g8dL58OJVO9wIy++B9iTN4OAZRz
 XyueALEX3d+LbvwZsckn+3YDnM1c12QFNkuM+nP8heoZyCpCiTnRL2odeWGZw0G2jCia
 FrUw==
X-Gm-Message-State: AOJu0YyAEUqXgEMlxUVMBlZ8DAAxLi6i2S26FIIe1C9MZwiZeQAO9jkW
 C7vx8ewsDq41w00mXoUZEz6t9kVqAtXRee6cqluQEMSYaOOyrLnZsg8v8Kmis0WHZWk=
X-Gm-Gg: ASbGncs83InhBafjVCPq+X9ejg8L7ctXk8qQbOmMcqNX0fSHHBcHQQjnOE3dXb3a3nr
 oRbKovR2jR5aI8fs9wpGcLngntkAqEVXTrz8WhE3DuESU2p8Oib4Ja8qu3X2h+frg82GT+5JqdS
 Xsg7TcG0d57EfmTf2f0r/9ZlG62t1VLTU55SgbxUs9M6Za8vyVAeDK+jfTK185MuDR7PdYBJBzU
 n2c58tSwzf+HMPBs8N48nzJSGs+Pc5CZAPZ/QXhABL71AUbVxZDBXE0Ar1tkP7iT10nZ/ohm6KO
 pJbOA5/awm4Ywbjt4VAvTNR8BmjejHujVno0bse8tDeKX7zk9djtuOvSRnjxy1sCoeFuGoC/hH8
 10iqYeXB40jHBNxoND4ZEjn3mwtGKilP0RKu9vrJYiC7AuINjmkubKTK3L4hzjXonQZYXtX8yrg
 TcQpALIkuVHXk=
X-Google-Smtp-Source: AGHT+IFbgBMF20woWNeceW2OLZW9UzKbeZOc7MdUEAQ6zkpQk/eNWuZtBmInvriEfIgjQNxZzNGZ7w==
X-Received: by 2002:a05:6000:2893:b0:42b:31a5:f032 with SMTP id
 ffacd0b85a97d-42cc1d2d586mr13073922f8f.28.1763981570422; 
 Mon, 24 Nov 2025 02:52:50 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7ec454csm26687694f8f.0.2025.11.24.02.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 02:52:49 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC43A5F83A;
 Mon, 24 Nov 2025 10:52:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  David
 Woodhouse <dwmw2@infradead.org>,  Paul Durrant <paul@xen.org>,  Eduardo
 Habkost <eduardo@habkost.net>,  xen-devel@lists.xenproject.org,  Anthony
 PERARD <anthony@xenproject.org>,  Stefano Stabellini
 <sstabellini@kernel.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] hw/i386/isapc: Remove dead Xen code
In-Reply-To: <20251123185832.53802-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 23 Nov 2025 19:58:32
 +0100")
References: <20251123185832.53802-1-philmd@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 24 Nov 2025 10:52:48 +0000
Message-ID: <87bjkraein.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We don't use Xen on the isapc machine: let's remove
> pointless code.

Are you sure about this? The older Xen config did support:

  isa
      Simulate an ISA only system

  isa (Default=3D0; Value=3D'no|yes')=20

I don't know why anyone would want a ISA capable HVM machine these days
but I would at least want to know when Xen dropped this as an option in
the commit message.

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/i386/isapc.c | 27 ++++-----------------------
>  1 file changed, 4 insertions(+), 23 deletions(-)
>
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 1ba9ae22cc3..1e13a30c505 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -17,8 +17,6 @@
>  #include "hw/ide/ide-bus.h"
>  #include "system/kvm.h"
>  #include "hw/i386/kvm/clock.h"
> -#include "hw/xen/xen-x86.h"
> -#include "system/xen.h"
>  #include "hw/rtc/mc146818rtc.h"
>  #include "target/i386/cpu.h"
>=20=20
> @@ -37,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>      ISABus *isa_bus;
>      uint32_t irq;
>      GSIState *gsi_state;
> -    MemoryRegion *ram_memory;
>      DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>      int i;
>=20=20
> @@ -77,15 +74,9 @@ static void pc_init_isa(MachineState *machine)
>      /*
>       * There is no RAM split for the isapc machine
>       */
> -    if (xen_enabled()) {
> -        xen_hvm_init_pc(pcms, &ram_memory);
> -    } else {
> -        ram_memory =3D machine->ram;
> -
> -        pcms->max_ram_below_4g =3D 3.5 * GiB;
> -        x86ms->above_4g_mem_size =3D 0;
> -        x86ms->below_4g_mem_size =3D machine->ram_size;
> -    }
> +    pcms->max_ram_below_4g =3D 3.5 * GiB;
> +    x86ms->above_4g_mem_size =3D 0;
> +    x86ms->below_4g_mem_size =3D machine->ram_size;
>=20=20
>      x86_cpus_init(x86ms, pcmc->default_cpu_version);
>=20=20
> @@ -94,17 +85,7 @@ static void pc_init_isa(MachineState *machine)
>      }
>=20=20
>      /* allocate ram and load rom/bios */
> -    if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, system_memory, 0);
> -    } else {
> -        assert(machine->ram_size =3D=3D x86ms->below_4g_mem_size +
> -                                    x86ms->above_4g_mem_size);
> -
> -        if (machine->kernel_filename !=3D NULL) {
> -            /* For xen HVM direct kernel boot, load linux here */
> -            xen_load_linux(pcms);
> -        }
> -    }
> +    pc_memory_init(pcms, system_memory, system_memory, 0);
>=20=20
>      gsi_state =3D pc_gsi_create(&x86ms->gsi, false);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

