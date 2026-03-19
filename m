Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACD3108E1E2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3BAL-0003Hm-3T; Thu, 19 Mar 2026 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3BAH-0003Ge-TC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1w3BAF-0002sf-Dt
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773918221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1eoBXyJHj/P9KfELbcErak9nD0X1SYOJZfak0IUzKnM=;
 b=Pxahz7jKM9v5pBGd4OqnHnWYAcd+7ULsSfXC9UYX85Tgnr7gCv9MsPzoAPm9Ct0xwo27lY
 DdZo6JLAPakZyGbsqCMsPGPxf9ZcVkl42lk9oRLrwhFW+emWx3DYWdM+oKvM9oe0q2MaTe
 Bvaj38LfOK8UL+rqiVo4xNyBORSsBHQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-aUYxXJ_YMS6BySi01V17RA-1; Thu, 19 Mar 2026 07:03:39 -0400
X-MC-Unique: aUYxXJ_YMS6BySi01V17RA-1
X-Mimecast-MFC-AGG-ID: aUYxXJ_YMS6BySi01V17RA_1773918218
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c6e24ee93a6so1288617a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 04:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773918218; x=1774523018; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eoBXyJHj/P9KfELbcErak9nD0X1SYOJZfak0IUzKnM=;
 b=uEDjBk8KncawhIm7j0+NJ3zHCO0FE37zWrSqdLXBYqqmuN4mJN5SEu9Luwba7NLhon
 rUPQoAOWJFAvTDSLielFY5tavXPaiWoLtyh3WTemA7Neg0w7vn9DqrjyMf6+bMz2EcG2
 hfdXDOcTa41qvi+z5V1mgTVs5QhMeSKwqM9AKdQyH6AkLYw5eUvoodggWlfiS0URaL9p
 /8b/eWESXI9GcPb40kaf+V/TaJ9z8n8nM2980v/bWtQb1vgI+a1I5cR6+8p9dtfzFh6A
 TRF+KagkxyW9eIIrLFYfrvJy2S7BDgf507bxYKvFJ9dmhVLve9jkj06gjc6DLqY6p7Mi
 LqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773918218; x=1774523018;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1eoBXyJHj/P9KfELbcErak9nD0X1SYOJZfak0IUzKnM=;
 b=T4QN/6MZ2cs5dC16/nloFUGEe8Aoy1FoK9vydpPkqF3hZdy7aj6e8o65fxkyfJrAbV
 VHFbfxD0Dtks9wQkM3B6MejYV2fMyZMpLeBe12SbBgjtR8wA4CC4sY/r1uek2KvaNuGq
 4ao9Jr0TBZfBqRF2djGHDRqpuXcqqvtZj+rh72z5+uc4sVPQOYxoCm63bc8mlvBo5MJc
 nMf9eLEx3CZ3HkRKylOVY/zuMd+EjEPT7FKpG0WQj+cF0o8eiP0Plq1pGCjLZBbrWTl5
 FgltpzQVycPcXo0oW0iKK9cm7cPycMtBmPYfE1Op/CSlJW8Donf2+zORKYTAXj46oPb4
 T5zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtQcGBkHAX/cp+uycovuyUKamJ93ojCp1VZ4bxyg+PUUN/HgfzKXqsRd21SqNtcO7MP6FvDQVU/A9r@nongnu.org
X-Gm-Message-State: AOJu0YyzcYFEeLiv5sBkkSx2L+coWsQfwH1yMiUVyzKmpUlc1hVzJvVb
 oP615fTBnXrbuNEEwmWxMpa7XcedYqOhmQssW/25pUVGM/qGQNg+RjHX6qSX9Vje5dEAvEyGB71
 LQUOWIeE5Pb4RUQS1ZZrk3xT+kFNhwcMjYw+8+qr5LsH3dYJKcQCsY2gF
X-Gm-Gg: ATEYQzzAvLBVNprEDygQxAn+gKOduqPXLHKoATjP0k5WZXEbrFZTZbh2UU5zixgm5xQ
 f0OWqz6fibVgqa9kEfZBYVBgde/qgZGDK7wRrD/cWOQBdVgiu0bFJfevUjwrp5u6EzpRtZSwi6i
 O3wQmse8u5g0MoVB2V3DZVEHaQAPnbe9RwTDUDQDRDAlT0o3XSuKBn9Nn5j/+K/17E44zN3BTxD
 xT1CRUBqo/uUZV0W03q27R9aBlDFTr++EkurUOa4CFAd9qv5KD2tThhXgqaNJxqXZ6dNKx17kav
 UJi6mRdMhTStod9fguF6UZqegP6bY2AD/IwIQj5Qo7sD5hGCKnJsTRsS+0YuLsTqOBDrLvJ1kaq
 wWPIQoTWF5sPKC73MNGT4pja4SgipOti6ynGgdbm9kkt/lK05UnarcvM/J18ahE2bVDSz4Q==
X-Received: by 2002:a17:903:1b2b:b0:2b0:4d7d:fb9a with SMTP id
 d9443c01a7336-2b0772a3ed1mr27028315ad.26.1773918218493; 
 Thu, 19 Mar 2026 04:03:38 -0700 (PDT)
X-Received: by 2002:a17:903:1b2b:b0:2b0:4d7d:fb9a with SMTP id
 d9443c01a7336-2b0772a3ed1mr27028175ad.26.1773918218146; 
 Thu, 19 Mar 2026 04:03:38 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e41927bsm73422975ad.10.2026.03.19.04.03.34
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Mar 2026 04:03:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH for-11.0 1/2] i386/pc_sysfw: stub out
 x86_firmware_configure
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260319101128.116301-2-anisinha@redhat.com>
Date: Thu, 19 Mar 2026 16:33:22 +0530
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B0297D88-2C9C-4329-9D55-F72FA6BAEB8D@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
 <20260319101128.116301-2-anisinha@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tsirkin <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 19 Mar 2026, at 3:41=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> x86_firmware_configure requires ovmf support. Add a stub for this =
function call
> for cases where OVMF is not supported.
>=20
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> hw/i386/pc_sysfw_ovmf-stubs.c | 5 +++++
> 1 file changed, 5 insertions(+)
>=20
> diff --git a/hw/i386/pc_sysfw_ovmf-stubs.c =
b/hw/i386/pc_sysfw_ovmf-stubs.c
> index aabe78b271..b53906a052 100644
> --- a/hw/i386/pc_sysfw_ovmf-stubs.c
> +++ b/hw/i386/pc_sysfw_ovmf-stubs.c
> @@ -24,3 +24,8 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, =
size_t flash_size)
> {
>     g_assert_not_reached();
> }
> +
> +void x86_firmware_configure(hwaddr gpa, void *ptr, int size)
> +{
> +    g_assert_not_reached();
> +}

This change alone won=E2=80=99t work for the CONFIG_PC case. I need to =
move x86_firmware_configure() to pc_sysfw_ovmf.c Will fix in v2 after I =
run my changes through CI.

> --=20
> 2.42.0
>=20


