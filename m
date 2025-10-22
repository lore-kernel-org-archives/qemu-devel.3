Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19888CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 11:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXDn-0004wo-GV; Wed, 22 Oct 2025 07:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBXDk-0004w4-Q0
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:41:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBXDZ-0002xa-Tq
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 07:41:28 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8C15B5972DF;
 Wed, 22 Oct 2025 13:41:22 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id N6jhwlRbZUeh; Wed, 22 Oct 2025 13:41:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 750E95972DE; Wed, 22 Oct 2025 13:41:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7301B59703F;
 Wed, 22 Oct 2025 13:41:20 +0200 (CEST)
Date: Wed, 22 Oct 2025 13:41:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 =?ISO-8859-15?Q?Volker_R=FCmelin?= <vr_qemu@t-online.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 13/42] hw/audio: simplify 'hda' audio init code
In-Reply-To: <20251022065640.1172785-14-marcandre.lureau@redhat.com>
Message-ID: <91f1eeb7-00ef-c8a7-7025-b8d9e43da42b@eik.bme.hu>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-677167698-1761133280=:88897"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-677167698-1761133280=:88897
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 22 Oct 2025, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> For consistency, use only qdev_device_add() to instantiate the devices.
> We can't rely on automatic bus lookup for the "hda-duplex" device though
> as it may end up on a different "intel-hda" bus...

Maybe this needs a better commit message. My first question was how is 
this simpler when it's 6 lines more and at least to me less obvious what 
it does. The real goal may be to make it independent from PCI for the next 
patch so maybe that's what the commit message should also say.

Regards,
BALATON Zoltan

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> hw/audio/intel-hda.c | 14 ++++++++++----
> 1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
> index 6a0db0dd9e..14bcf1257d 100644
> --- a/hw/audio/intel-hda.c
> +++ b/hw/audio/intel-hda.c
> @@ -21,6 +21,7 @@
> #include "hw/pci/pci.h"
> #include "hw/qdev-properties.h"
> #include "hw/pci/msi.h"
> +#include "monitor/qdev.h"
> #include "qemu/timer.h"
> #include "qemu/bitops.h"
> #include "qemu/log.h"
> @@ -30,6 +31,7 @@
> #include "intel-hda.h"
> #include "migration/vmstate.h"
> #include "intel-hda-defs.h"
> +#include "qobject/qdict.h"
> #include "system/dma.h"
> #include "qapi/error.h"
> #include "qom/object.h"
> @@ -1305,15 +1307,19 @@ static const TypeInfo hda_codec_device_type_info = {
>  */
> static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
> {
> -    DeviceState *controller;
> +    g_autoptr(QDict) props = qdict_new();
> +    DeviceState *intel_hda, *codec;
>     BusState *hdabus;
> -    DeviceState *codec;
>
> -    controller = DEVICE(pci_create_simple(bus, -1, "intel-hda"));
> -    hdabus = QLIST_FIRST(&controller->child_bus);
> +    qdict_put_str(props, "driver", "intel-hda");
> +    intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
> +    hdabus = QLIST_FIRST(&intel_hda->child_bus);
> +
>     codec = qdev_new("hda-duplex");
>     qdev_prop_set_string(codec, "audiodev", audiodev);
>     qdev_realize_and_unref(codec, hdabus, &error_fatal);
> +    object_unref(intel_hda);
> +
>     return 0;
> }
>
>
--3866299591-677167698-1761133280=:88897--

