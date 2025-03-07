Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E71C282D0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 16:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqaj3-0006cP-Af; Fri, 07 Mar 2025 11:39:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqaj0-0006by-TK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:39:02 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqaiz-0008GB-4r
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 11:39:02 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bc4b1603fso13149755e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 08:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741365539; x=1741970339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsN796fT1MUB+6f45xEUPhBXN85cvrnDmFHPcvjv2MA=;
 b=jy/vnG1H5tMKX0nyrxUrsejKppvl92+U6NKidIxh9ZfjMpLGaDIFGY4mBdsGIX+sH0
 A+dHx1y1XNwHmLwxrMvKzT8c5tHQ4MzXLIKj/A6TLxt8wrv/8OhhXW6tj5Yf0EPfjRAv
 vp+bJipUIBVUwgiuPhNCQr33FPpvqk+Bydnnqajt5E7kHmNf2nQdh6Dl+GaltxZN1gUl
 449XyfHABMHmmJ2vGCKwqpm2NwoZghOODqgTkpKpWjZPkrrreb25HYLcSv4ciJCMPsbf
 5zXAsZoauIA0JfZ7i0ZrNyRhrJb/QUEFcqQhrnbFT8R4hjHwGictomfKHJ1TWSeWGUD6
 DgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741365539; x=1741970339;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BsN796fT1MUB+6f45xEUPhBXN85cvrnDmFHPcvjv2MA=;
 b=nCuGKy0cPLUx2dHKNdIBpmBQCh9WfhBBd65uygQYgajaqGpNeIDL+L0TBGp1PzbVz4
 ihbcCENU/B1cgAxzHD7E0kXGhzBHbpG5qKcZ/6Zh+h/ZbaBh793Fhz435Bx9BjoBvJxK
 OY1QqZHXkuoWs4JWGotYBb4uxHHxCBcoypb+CYMeVQmwM3rmsjbxAYLxnlphsWkd702Z
 I3n6SgJOn+SWZwVU2IgeLVXTH3WHfXoIuRScNeZ5o1byastsm/yxx0Xxj7YMOcqq/c/M
 DP9y1U16tb/76lfdSOus8tBPbhRE+jfUoewxLozJIwCiEccTQR1KIA0+BUG6Xofluim9
 bxjA==
X-Gm-Message-State: AOJu0YzZ5X3qQeS5WiHGuK/6YjWnvIySdGMBozQ1GAEyz7stW28QXL88
 2T7ARFxdzZ+Wyf3HI6FY3OvgorJghnOX1UVBWzIpHHAZRPEftcMTAwGhELTq7s4=
X-Gm-Gg: ASbGncu1c90zZzLaIoqxC3bHmLqxkKHV5WBzfo+XfGXhBD6SVlqQOPFKASSIf2qU8b7
 2KbBZFuMl9qLJMEyB7MmxADS3ogL5sr9p4tPh0y2Mk2k2sMVM1FbsXxpuH3sOasMKReOr3c3r3w
 DgQ8It3nL5f1rNCPIHmI8Sc+iXl0GJqsOip2qa2eK0HP9N8u6QirAn6O2p1IdekN42SFNmsxQBo
 7dQZdZI8d7kkIE+KuPNthWQojU/eqUSk70nCT5BtpJk9wcmCh+DZJw5x0ijccHK9x+2GQYPPcyH
 E6+avJ8symy2F5IwsCsXhmWzoQ7YkGFf+I9T9vMuihijEzs=
X-Google-Smtp-Source: AGHT+IECmvnc9OHYpAWJ99LpKNZmByGVrdc4wfQCg9chJ2lLaTMlScHI+ns8sSr/HCWgR7/jpls3VQ==
X-Received: by 2002:a05:600c:4e8e:b0:43b:cc3c:60bc with SMTP id
 5b1f17b1804b1-43c5a60ed21mr30750915e9.15.1741365539128; 
 Fri, 07 Mar 2025 08:38:59 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426c33asm89820945e9.3.2025.03.07.08.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 08:38:58 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C491D5F90C;
 Fri,  7 Mar 2025 16:38:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Ani Sinha <anisinha@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
In-Reply-To: <20250307151543.8156-6-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 7 Mar 2025 16:15:41
 +0100")
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 07 Mar 2025 16:38:57 +0000
Message-ID: <877c503ie6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> Use qemu_arch_available() to check at runtime if a target
> architecture is built in.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/virtio/virtio-mem.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 5f57eccbb66..8c40042108c 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -15,6 +15,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
> +#include "system/arch_init.h"
>  #include "system/numa.h"
>  #include "system/system.h"
>  #include "system/reset.h"
> @@ -170,13 +171,16 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock=
 *rb)
>   * necessary (as the section size can change). But it's more likely that=
 the
>   * section size will rather get smaller and not bigger over time.
>   */
> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S39=
0X)
> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
> -#elif defined(TARGET_ARM)
> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
> -#else
> -#error VIRTIO_MEM_USABLE_EXTENT not defined
> -#endif
> +static uint64_t virtio_mem_usable_extent_size(void)
> +{
> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
> +        return 2 * 128 * MiB;
> +    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
> +        return 2 * 512 * MiB;
> +    } else {
> +        g_assert_not_reached();
> +    }
> +}

What happens if/when we have multiple arches available? Won't we want to
know which CPU the virtio-mem device is attached to or do we take the
minimal value over the whole system?

>=20=20
>  static bool virtio_mem_is_busy(void)
>  {
> @@ -721,7 +725,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM=
 *vmem,
>                                              bool can_shrink)
>  {
>      uint64_t newsize =3D MIN(memory_region_size(&vmem->memdev->mr),
> -                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
> +                           requested_size + virtio_mem_usable_extent_siz=
e());
>=20=20
>      /* The usable region size always has to be multiples of the block si=
ze. */
>      newsize =3D QEMU_ALIGN_UP(newsize, vmem->block_size);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

