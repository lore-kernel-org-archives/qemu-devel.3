Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C77C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvk2-00083T-KQ; Fri, 31 Jan 2025 13:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tdvjx-00082m-IT
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tdvjv-00040y-7J
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738348057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1fgF0oxOuv/c51hzbPAf4dzHnxocuQUHifZqvhBl13E=;
 b=NpIaPWICaKqMKcv7oW3pHdWl38WFZXMM4fibFhyxWfPcDOXBLK4Dlc/IFuAUpqCkM0D4Tj
 rffdA+8JhHd07fuSqmsxxLRx5g13a9KyS1ylLi7goVqPQKGpAJ1R3FdKao1fym4n/VrOTQ
 q82CGFKR3nbNXbMkWcfZxOcykD/RWn8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-rJ2FS53cP5C0ymKX7MdmKg-1; Fri, 31 Jan 2025 13:27:35 -0500
X-MC-Unique: rJ2FS53cP5C0ymKX7MdmKg-1
X-Mimecast-MFC-AGG-ID: rJ2FS53cP5C0ymKX7MdmKg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43626224274so11697465e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738348054; x=1738952854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fgF0oxOuv/c51hzbPAf4dzHnxocuQUHifZqvhBl13E=;
 b=t5I5qZX51huLvx4xE1rysqS2wAGQPrg46Bydx/HB48A2axFJPIQdmVpDkpjrwX7l9w
 OLqLLFoT8xaARTpELzklXPGXG4MaVcliEvS7MHky3Wjo9j7DElikXAoypE45Ezv03mGd
 TjhqfjItqn/GC723S3I0H9qUzlBHRbJfZqRUIJoJqcoXY2OApfuiHKMCBppwQPrwm011
 mi3JMJFjlYaJ+1Ye2oS90d3LDkVzrZ2eiT22hGnB23U8/WXaWuV68h8TWMt+YOUATZz2
 hm8g4UoifWYVL+dT3LIJLIxDxN2kzYxNnPYy9mAcIuAquvNMjKtng4ZaPDWLg4EwakDc
 y3LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3bVrLeXYOUwu1qwmRczrTBUqHb4JBLAFHSkDKb/+fHBz2kQO/nmyR3pReU6Zqti+bbMQynnVw6VnM@nongnu.org
X-Gm-Message-State: AOJu0YxRhgTWyRds45e0SQ/pDuYIT6umTpvbivm2vnLgKrgf5QWW8uKN
 bQ846lhsm145+dWHh24AY8oNPKGC9nXXrRoF5JyPFJgSC8zPA03yH6napxRLv988Imz/3UoYPbc
 Ip9ls+rGtO3aH2TLira1ccEUWVXE53oQ/wk50pvIhkId7gwy/2KLpPKo00NN+WAcnp9VwvJhAXf
 Uq9mlMJ5PFdO8GBx0H4CeUXQh3nvQ=
X-Gm-Gg: ASbGncsutXMwLZWR07b+kTrIiTy70MkGP1NXoz/OPfc3Lo+pKB1BYyaIeG41N02q80K
 xIDTohwEZxP9ZhWHb7aE71cDJjWbyWE+0M9U8ECclG12iwMFuFsNbDFMSkcVy
X-Received: by 2002:a5d:5288:0:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38c51b5df32mr7816839f8f.24.1738348054501; 
 Fri, 31 Jan 2025 10:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjuSbM/qrVKiJ05icQUERlIhJRq8RcsL/5gDAvCAbWvG68rjTFDEsT514JBExK6jOm9Ro8GRryOPSZjNzpsHo=
X-Received: by 2002:a5d:5288:0:b0:385:ed16:c91 with SMTP id
 ffacd0b85a97d-38c51b5df32mr7816808f8f.24.1738348054184; Fri, 31 Jan 2025
 10:27:34 -0800 (PST)
MIME-Version: 1.0
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
 <20250124132048.3229049-52-xiaoyao.li@intel.com>
In-Reply-To: <20250124132048.3229049-52-xiaoyao.li@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 31 Jan 2025 19:27:23 +0100
X-Gm-Features: AWEUYZkOCXHaRFghbH3lPJIDTaOq5XDRPgCRkvXwg6ltj_mr-tmQcXbYqf1FsWk
Message-ID: <CABgObfb5ruVO2sxLCbZobiaqX-3h9Q+UKOZnp_hhxfJA=T-OJA@mail.gmail.com>
Subject: Re: [PATCH v7 51/52] i386/tdx: Validate phys_bits against host value
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jan 24, 2025 at 2:40=E2=80=AFPM Xiaoyao Li <xiaoyao.li@intel.com> w=
rote:
>
> For TDX guest, the phys_bits is not configurable and can only be
> host/native value.
>
> Validate phys_bits inside tdx_check_features().

Hi Xiaoyao,

to avoid

qemu-kvm: TDX requires guest CPU physical bits (48) to match host CPU
physical bits (52)

I need options like

-cpu host,phys-bits=3D52,guest-phys-bits=3D52,host-phys-bits-limit=3D52,-kv=
m-asyncpf-int

to start a TDX guest, is that intentional?

Thanks,

Paolo

> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/host-cpu.c | 2 +-
>  target/i386/host-cpu.h | 1 +
>  target/i386/kvm/tdx.c  | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 3e4e85e729c8..8a15af458b05 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -15,7 +15,7 @@
>  #include "system/system.h"
>
>  /* Note: Only safe for use on x86(-64) hosts */
> -static uint32_t host_cpu_phys_bits(void)
> +uint32_t host_cpu_phys_bits(void)
>  {
>      uint32_t eax;
>      uint32_t host_phys_bits;
> diff --git a/target/i386/host-cpu.h b/target/i386/host-cpu.h
> index 6a9bc918baa4..b97ec01c9bec 100644
> --- a/target/i386/host-cpu.h
> +++ b/target/i386/host-cpu.h
> @@ -10,6 +10,7 @@
>  #ifndef HOST_CPU_H
>  #define HOST_CPU_H
>
> +uint32_t host_cpu_phys_bits(void);
>  void host_cpu_instance_init(X86CPU *cpu);
>  void host_cpu_max_instance_init(X86CPU *cpu);
>  bool host_cpu_realizefn(CPUState *cs, Error **errp);
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index bb75eb06dad9..c906a76c4c0e 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -24,6 +24,7 @@
>
>  #include "cpu.h"
>  #include "cpu-internal.h"
> +#include "host-cpu.h"
>  #include "hw/i386/e820_memory_layout.h"
>  #include "hw/i386/x86.h"
>  #include "hw/i386/tdvf.h"
> @@ -838,6 +839,13 @@ static int tdx_check_features(X86ConfidentialGuest *=
cg, CPUState *cs)
>          return -1;
>      }
>
> +    if (cpu->phys_bits !=3D host_cpu_phys_bits()) {
> +        error_report("TDX requires guest CPU physical bits (%u) "
> +                     "to match host CPU physical bits (%u)",
> +                     cpu->phys_bits, host_cpu_phys_bits());
> +        exit(1);
> +    }
> +
>      return 0;
>  }
>
> --
> 2.34.1
>


