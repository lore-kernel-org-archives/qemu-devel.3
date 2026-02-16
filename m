Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8FAE7BD88
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrvkM-0004CN-4b; Mon, 16 Feb 2026 05:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvkK-0004Bx-5r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vrvkH-0005mV-UD
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771237344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4fkUz6bVuygUTd+Xe0xiBI4iHyk8L4fdLMV6McBM5XI=;
 b=LYRt8/y5LRQdFwWO+gRi9FOyffaj8p0lXWr9j6I742LAlvHT+VWxHeno2S1syJi/oWIBOa
 txj/eTIqhX3fi0JFdv5+aeev94qZGz65R9y3lcrYb0RD3zEaWjbTX2Ma9t6PGbcM56PTti
 BuuZTpGa5MqfajsNu68Itd1PnK7F7fo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-HdU9pgdFMfif_2gmq-Z0yw-1; Mon, 16 Feb 2026 05:22:22 -0500
X-MC-Unique: HdU9pgdFMfif_2gmq-Z0yw-1
X-Mimecast-MFC-AGG-ID: HdU9pgdFMfif_2gmq-Z0yw_1771237342
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88fcbe2e351so243621386d6.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 02:22:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771237342; cv=none;
 d=google.com; s=arc-20240605;
 b=NK3EYvbONzXObikGrfTSJ9HwfHORf6QJZcaQF9Lw4GfC0vzT+eaabtoAxGXdQ6jCBz
 SLuYy7HaBZa7uKbsNJPfPMU2jQWxoBeQvw4ZR4yvwQCyuWVhhlO9kIMGRu6lPPe3q27E
 HgVctAIAmOVyGjnSMiYs65Vn9wkYnFgfdZVB9IUFwn4+8gwIz9RqraE3hcjulebvJ+xj
 18G/MnbkYlVTtbOpT4J8vuFqYhZQzOpIofTkIzu1f5jKzy9p7MxYc0C5bysLlaaoNw36
 g7YhvYtxTJMa4MyNNxm6kmcjn++wp3mcQyTuHvWGHPuVqpXQVR1wCe4p2dkSbGwkYyJr
 SxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4fkUz6bVuygUTd+Xe0xiBI4iHyk8L4fdLMV6McBM5XI=;
 fh=sIsIOvEHAUniTyi3GhO91uUMlcdX4avqzqeMhQBuOOs=;
 b=kumbyDj4DcsvGmpyJK6fDUvYlQo/yMZPtNcqyNRdmEZYUyVwcOrmK1soQib3kr8uWj
 IyA0XROSlS0drFG1VJNnrKJuUDrO3gwi4HgMcftNe4tFqqWy4ZNN0RFM3leZSU/8IZ9H
 owD13xQPqhiLnBLTd75MVp+HnqqbCs6XdWHNpcMQ+b18l0ugu1Bvm41ERpz0KCAyXlTt
 vjQLRhldQ49yDM0R2/IoZpKv/AO49p9YVFn2QXVkkFCLY8RpI7o3Q2MyLmBa+zgE9nDB
 I7WfD3KJftgaZN3xlwvaxpOXuZveSUWaPhhx4VizR8c2a5WECv1N9v7nMnn/edkJgyHx
 mSdQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771237342; x=1771842142; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fkUz6bVuygUTd+Xe0xiBI4iHyk8L4fdLMV6McBM5XI=;
 b=ORpRuK+RWCSfHeg4o5rjBBNgxefhVnbYc4yDH5DExAFOi8NigwMXLNf/V3kQQ7WBIz
 /mOhPCgm81A84ukqKiCs2/oH3xmCFymGDrSj9viRvwAXuh0FXa0Krum8WwquYh7zuLwz
 k31clmgLQXFB/HRm5EVg4P0P3qEAhTp/sNUelWYrikeU4gFEpqWM859ijYlrSLPUnyd8
 UeTTy42MylPTcYe/+Xgh+ia0eVef0/f18Fk7LXcOALI6JEXskYROmqRMsQbAUWEbSR/2
 GqBV+bz9THRkD/iRSt+NQAejvLP4YmyshYt/GkjO3hiyEM3qscFqBrC8wYfUPXLGBaS6
 uCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771237342; x=1771842142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fkUz6bVuygUTd+Xe0xiBI4iHyk8L4fdLMV6McBM5XI=;
 b=Ngkl4wdxxN1iNqCc6rgMytI1vJbIb4dw/PewjnzYFDk41WDxaPzOdE8w4SE2jlOg7H
 ogMCpqLB79bNgB+2SE7UHhOTqLxDOlnaGm8YszxLmJHdy6eBj50/KHbj2JSk82uJyxgJ
 iRF8DDA3M5hO2h5H2d7jc6mpvQkMF0R7CwgfM82uN0BM9WmDxgBUOBCVI0QSiKRE+0eL
 yIegPWeRbYosaExQNA1AgPP3tjtvfDlwwPQ5lYiNC1KaVMyca5G3njY8P9eB6BgetQGc
 8UX8OKKnbzOfDmW78SimWrB/a0yZ7Dgec0YuMbTV8svhHtqHdifA1jaSa70y0Wd+guz/
 E3tA==
X-Gm-Message-State: AOJu0YzcUcTi5tKjBihqMcoA1Gu4nP6vOBoWd8GfSxucef/O6beyG5KA
 SHxkgwZb7OeI2E1uhP0KeIwNbBcNyQxktLYs+NxUSdqgww2K4ZqYjVp2g87egySSuOwetMg13gy
 JYtldcYry5YglhjSq8Sxkth+dvu4GCqBi+cEbeboPojYsHcbIB64W0sbybqUNyhnNF9OoFnIuvU
 dU8M8pzAGE5M8iDLk2mMRDneUSkZv/PXU=
X-Gm-Gg: AZuq6aL15CFyL5dujVtc/VWITDv++0QyeO5o3mtf77Iye2GXxALk3WFUmOalPMaBvp5
 bUFXi8awMfoc8q6y88Iza16rTUxsmlXCJWWPCLWD2OD3LJn4f48xO6It/YVRnPp1sZxzaF110L8
 VFcQujNhaZ+3PeVFR/+bgnK3CV3Jk15gafLSVmtHbuKPelWR3RVErmIzBzB5O5a9vpCuQrFQLKI
 yI346U/IfFHdYdHxHkEpiAZVTQOa+P8hcQj
X-Received: by 2002:a05:6214:c42:b0:894:3bac:49d1 with SMTP id
 6a1803df08f44-8973f2a161cmr122634036d6.11.1771237342050; 
 Mon, 16 Feb 2026 02:22:22 -0800 (PST)
X-Received: by 2002:a05:6214:c42:b0:894:3bac:49d1 with SMTP id
 6a1803df08f44-8973f2a161cmr122633856d6.11.1771237341642; Mon, 16 Feb 2026
 02:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-8-imammedo@redhat.com>
In-Reply-To: <20260206131438.1857182-8-imammedo@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 16 Feb 2026 15:52:10 +0530
X-Gm-Features: AaiRm50Kgb0cTwGJiB6bADULXPlSVzgNXShlAgSGtiph9Sw5S9ckf4mKnIIgQJE
Message-ID: <CAK3XEhMYzsmbhE1S3ZFdV-oQpesuy24FVb_rn=sdcRYi6xKScQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] arm: add tracing events to sbsa_gwdt
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Feb 6, 2026 at 6:45=E2=80=AFPM Igor Mammedov <imammedo@redhat.com> =
wrote:
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Other than what mentioned below,
Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/watchdog/sbsa_gwdt.c  | 8 ++++++++
>  hw/watchdog/trace-events | 9 +++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 7ade5c6f18..d159e61c34 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -24,6 +24,7 @@
>  #include "migration/vmstate.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
> +#include "trace.h"
>
>  static const VMStateDescription vmstate_sbsa_gwdt =3D {
>      .name =3D "sbsa-gwdt",
> @@ -62,6 +63,7 @@ static uint64_t sbsa_gwdt_rread(void *opaque, hwaddr ad=
dr, unsigned int size)
>          qemu_log_mask(LOG_GUEST_ERROR, "bad address in refresh frame rea=
d :"
>                          " 0x%x\n", (int)addr);
>      }
> +    trace_sbsa_gwdt_refresh_read(addr, ret);
>      return ret;
>  }
>
> @@ -93,6 +95,7 @@ static uint64_t sbsa_gwdt_read(void *opaque, hwaddr add=
r, unsigned int size)
>          qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame rea=
d :"
>                          " 0x%x\n", (int)addr);
>      }
> +    trace_sbsa_gwdt_control_read(addr, ret);
>      return ret;
>  }
>
> @@ -127,6 +130,7 @@ static void sbsa_gwdt_rwrite(void *opaque, hwaddr off=
set, uint64_t data,
>                               unsigned size) {
>      SBSA_GWDTState *s =3D SBSA_GWDT(opaque);
>
> +    trace_sbsa_gwdt_refresh_write(offset, data);
                                                                       ^^^^=
^
this is 64 bit.

>      if (offset =3D=3D SBSA_GWDT_WRR) {
>          s->wcs &=3D ~(SBSA_GWDT_WCS_WS0 | SBSA_GWDT_WCS_WS1);
>
> @@ -141,6 +145,7 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offs=
et, uint64_t data,
>                               unsigned size) {
>      SBSA_GWDTState *s =3D SBSA_GWDT(opaque);
>
> +    trace_sbsa_gwdt_control_write(offset, data);

Same here ...

>      switch (offset) {
>      case SBSA_GWDT_WCS:
>          s->wcs =3D data & SBSA_GWDT_WCS_EN;
> @@ -180,6 +185,7 @@ static void wdt_sbsa_gwdt_reset(DeviceState *dev)
>  {
>      SBSA_GWDTState *s =3D SBSA_GWDT(dev);
>
> +    trace_sbsa_gwdt_reset();
>      timer_del(s->timer);
>
>      s->wcs  =3D 0;
> @@ -196,10 +202,12 @@ static void sbsa_gwdt_timer_sysinterrupt(void *opaq=
ue)
>
>      if (!(s->wcs & SBSA_GWDT_WCS_WS0)) {
>          s->wcs |=3D SBSA_GWDT_WCS_WS0;
> +        trace_sbsa_gwdt_ws0_asserted();
>          sbsa_gwdt_update_timer(s, TIMEOUT_REFRESH);
>          qemu_set_irq(s->irq, 1);
>      } else {
>          s->wcs |=3D SBSA_GWDT_WCS_WS1;
> +        trace_sbsa_gwdt_ws1_asserted();
>          qemu_log_mask(CPU_LOG_RESET, "Watchdog timer expired.\n");
>          /*
>           * Reset the watchdog only if the guest gets notified about
> diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
> index ad3be1e9bd..5be430fb9e 100644
> --- a/hw/watchdog/trace-events
> +++ b/hw/watchdog/trace-events
> @@ -33,3 +33,12 @@ spapr_watchdog_expired(uint64_t num, unsigned action) =
"num=3D%" PRIu64 " action=3D%u
>  # watchdog.c
>  watchdog_perform_action(unsigned int action) "action=3D%u"
>  watchdog_set_action(unsigned int action) "action=3D%u"
> +
> +#sbsa_gwdt.c
> +sbsa_gwdt_refresh_read(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] -=
> 0x%" PRIu32
> +sbsa_gwdt_refresh_write(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] =
<- 0x%" PRIu32
                                                                      ^^^^^=
^^
This needs to be 64 bit.

> +sbsa_gwdt_control_read(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] -=
> 0x%" PRIu32
> +sbsa_gwdt_control_write(uint64_t addr, uint32_t value) "[0x%" PRIu64 "] =
<- 0x%" PRIu32

Same here .

> +sbsa_gwdt_ws0_asserted(void) "WS0 signal is asserted"
> +sbsa_gwdt_ws1_asserted(void) "WS1 signal is asserted"
> +sbsa_gwdt_reset(void) "reset watchdog to defaut state"
                                                                         ^^=
^^^^
typo.


