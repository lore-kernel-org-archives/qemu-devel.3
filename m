Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87161CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcwv-0002Li-5f; Fri, 21 Nov 2025 21:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMc9v-0006a3-2K
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vMc7t-0004C0-IZ
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:11:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763773746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+F6WIwWKwxNMDi4qAm/LtNKAUJiCHrgptJWiL6wqhg=;
 b=TvG7uB1kKr9m1vvhpc5lcBHOFQ/0g1mlwkXzmJWK0a7xofYVUMK8neukWK+aOW7Z9UMy5W
 LK8OdQa1zKfdbV19NMapenMJQVPLOy2JXUe8UxHdtzWKDgTUR6P2xtdpWMouH+bSPVeh0u
 izfMEUV7vPrkF7OspxLm8iUroBVEhtw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-MO7MSC3_PVG92bf0qfucPQ-1; Fri, 21 Nov 2025 08:48:49 -0500
X-MC-Unique: MO7MSC3_PVG92bf0qfucPQ-1
X-Mimecast-MFC-AGG-ID: MO7MSC3_PVG92bf0qfucPQ_1763732928
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b96038aa68so2311790b3a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 05:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763732928; x=1764337728; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+F6WIwWKwxNMDi4qAm/LtNKAUJiCHrgptJWiL6wqhg=;
 b=LW/bn4zQFCX80JCMwcIw9p1F/dEJ33jh+stSGqm2DC+DNnfG99KDHpL/VG1V7X/Iyi
 f19laEkVQCs87M7CIGMGXLhlCQfg1JmlKoAI0KQ2bGrlRRSXbA8ySDGz83KBZSbtImka
 m7S6FF6TksXSBcvBPjtFp0/+L+29VDz0LZVxHZ4MOZTcGDVd7TfjumuaUT052sb9ZwY4
 hHXtff4LgIxIGMPzZhYiB45uQDTcpYcv4IhhI0Va9DdVJKrC1aECaK5EjGBzKKVIpdWo
 qP9s40H2XZvctwXOWd1tnzMF9Dvs0/4hAWS9DypgjKIFquxuj9wN1odFtgPKpm3WCAnR
 7SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763732928; x=1764337728;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j+F6WIwWKwxNMDi4qAm/LtNKAUJiCHrgptJWiL6wqhg=;
 b=YLVBrfrifEK7d8VNk3kXFou9RiyZgaEUHuxU4zj59CDMIEZq9Clk0g8KgYgq6nAyfb
 N/qdCn21lKlJ7NKu5sqMirFOmMHeMcaCANMwmaTrv4Cavu3obRkGnHwkSznj7XL2pO0u
 ML3uch/mT6jX6s7oftq9tw7FcHUO/jMrwP/R0kStlBXG1vPjIprauDXSug1XWGYwK3Cx
 uruc7Fshnr7J9mvXPKXOSXZokstOco/ulERKuaCxNQ/ibPTCyx6lEpjPa2M6mDaBtNFN
 bjyaNpT66Ewh3Is4Jc8A86LSDlbpOvb0orLwyr5cp8gHAMkGY89UjmRS4SrwMtbQzhqq
 K2Eg==
X-Gm-Message-State: AOJu0Yw+NUoiTsFLwiQVz/f7BcH79lDLPvPKBLz5s2ZquNvYBPnuLndu
 x8R4x0khVm4CBXiPM4xj+qG9CknBX3gtimYY28b8RTFdofjZv/u4xyB/oan81V0QtmdoH7ieuMY
 DhywnsCz9oECoG+H44/VAb5SBfuYucF1pDbgtt/EY+bLYiVWDegJC3RgR
X-Gm-Gg: ASbGncsosy/7flxEp2oSVaggTp5gHzhDUslD3qT7v4uvQj7TVB1CsytuQRrbFpJbtbV
 APrE6itY3VNSem72EJr36iWkxff7RrtI4arBFjnNF0GLCzJuVvyu/5DAxCljigHGR1lBzoZMy18
 qu9miIwatIrA0/GEe7Hb88AqXUkHnLmB1sC5aKqGHBTJcqUmurDrllaxiDSsRAELndWgX6f7axE
 He7YJPfHpcEiRZ9AoLEhULQEOiKEIeepxNliZmmDwuPN7UIYCja9eMCB9z5x2c7ChadSOBXmRVK
 aLqTCYej04deXG+oiUDjkF0ARS0+/XJ3oakZT9xXTRcpSyfSenPRMdSnLwbDKhEmUeK3mMNFsP/
 STbnz9l67eR+9wiBjmY7FKG1omutpcCrfalkYID5S6JTqVALNLD49W1m/
X-Received: by 2002:a05:6a00:73a7:b0:7aa:8c11:b520 with SMTP id
 d2e1a72fcca58-7c41e6f85b1mr5428880b3a.7.1763732928043; 
 Fri, 21 Nov 2025 05:48:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJOOyLt24wTeytOAaTI6/XGYVDnbu/8SCrj0ZSnYrKDSUxCkvHhUq1VBUb4DQEJMPFx2Rilw==
X-Received: by 2002:a05:6a00:73a7:b0:7aa:8c11:b520 with SMTP id
 d2e1a72fcca58-7c41e6f85b1mr5428855b3a.7.1763732927660; 
 Fri, 21 Nov 2025 05:48:47 -0800 (PST)
Received: from smtpclient.apple ([106.212.87.16])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f174c9dasm6149063b3a.65.2025.11.21.05.48.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Nov 2025 05:48:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.7\))
Subject: Re: [PATCH 4/4] igvm: move igvm file processing to reset callbacks
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251118122133.1695767-5-kraxel@redhat.com>
Date: Fri, 21 Nov 2025 19:18:32 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <155EBDE9-0859-4235-8685-13B3398A35C9@redhat.com>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-5-kraxel@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.7)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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



> On 18 Nov 2025, at 5:51=E2=80=AFPM, Gerd Hoffmann <kraxel@redhat.com> =
wrote:
>=20
> Move igvm file processing from machine init to reset callbacks.  With
> that the igvm file is properly re-loaded on reset.  Also the loading
> happens later in the init process now.  This will simplify future
> support for some IGVM parameters which depend on initialization steps
> which happen after machine init.

LGTM.

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> backends/igvm-cfg.c |  7 +++++++
> hw/i386/pc_piix.c   | 10 ----------
> hw/i386/pc_q35.c    | 10 ----------
> 3 files changed, 7 insertions(+), 20 deletions(-)
>=20
> diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
> index 08501a67e58e..c1b45401f429 100644
> --- a/backends/igvm-cfg.c
> +++ b/backends/igvm-cfg.c
> @@ -15,6 +15,8 @@
> #include "system/igvm.h"
> #include "system/reset.h"
> #include "qom/object_interfaces.h"
> +#include "hw/qdev-core.h"
> +#include "hw/boards.h"
>=20
> #include "trace.h"
>=20
> @@ -44,7 +46,12 @@ static void igvm_reset_enter(Object *obj, ResetType =
type)
>=20
> static void igvm_reset_hold(Object *obj, ResetType type)
> {
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    IgvmCfg *igvm =3D IGVM_CFG(obj);
> +
>     trace_igvm_reset_hold(type);
> +
> +    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
> }
>=20
> static void igvm_reset_exit(Object *obj, ResetType type)
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 7b3611e973cd..b3b71df64bfc 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -320,16 +320,6 @@ static void pc_init1(MachineState *machine, const =
char *pci_type)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
> -
> -#if defined(CONFIG_IGVM)
> -    /* Apply guest state from IGVM if supplied */
> -    if (x86ms->igvm) {
> -        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> -                ->process(x86ms->igvm, machine->cgs, false, =
&error_fatal) < 0) {
> -            g_assert_not_reached();
> -        }
> -    }
> -#endif
> }
>=20
> typedef enum PCSouthBridgeOption {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6015e639d7bc..f2e6ebfe294c 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -328,16 +328,6 @@ static void pc_q35_init(MachineState *machine)
>                                x86_nvdimm_acpi_dsmio,
>                                x86ms->fw_cfg, OBJECT(pcms));
>     }
> -
> -#if defined(CONFIG_IGVM)
> -    /* Apply guest state from IGVM if supplied */
> -    if (x86ms->igvm) {
> -        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> -                ->process(x86ms->igvm, machine->cgs, false, =
&error_fatal) < 0) {
> -            g_assert_not_reached();
> -        }
> -    }
> -#endif
> }
>=20
> #define DEFINE_Q35_MACHINE(major, minor) \
> --=20
> 2.51.1
>=20


