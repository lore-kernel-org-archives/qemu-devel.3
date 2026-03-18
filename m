Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B40FCD0CF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2m0a-0004V6-Nb; Wed, 18 Mar 2026 04:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2m0U-0004T7-II
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2m0R-00060P-Mo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773821514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0obZQtca6d6glbYBCYnsmcZ8egVVaPB3btnSlzkln+w=;
 b=VUA4sPCh0A/lTiEPLN9cvlWLScKTmQx1SFKVMzpNTY/rfsna6WD/2sp3nrjAP9RACePK2b
 PoVpUNWp3OpEObh1/RdtGFgNtUj9Z0MayMBv46g8EVGj1FqT9YOv/nLQ7ltuv88F3ixfjr
 DIyOTa/9js/ysnry2L9CDuqpzNRWhwI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-9ChEXmbaMI2lunrIPO3F2w-1; Wed, 18 Mar 2026 04:11:52 -0400
X-MC-Unique: 9ChEXmbaMI2lunrIPO3F2w-1
X-Mimecast-MFC-AGG-ID: 9ChEXmbaMI2lunrIPO3F2w_1773821512
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so91493085e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773821511; x=1774426311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0obZQtca6d6glbYBCYnsmcZ8egVVaPB3btnSlzkln+w=;
 b=dsJ5GrOO7kjOiTGKrfcceo3sGrtkUSmcwnvTsdFQ2yjv3bKs5DNsIB7TNPGMALxxEL
 1GACZrNc4/5qiFTSIeqC176BOu8bJAT8n9ueo9A/RHmDC1dabQoFWIUbXWOmuDw/Z4YG
 H4sTJwu85ILM2a3tV6xz07N+Qho87SKoZQKaflj6of/II9Ear3m1JUL6wQYt2tP+7+7f
 ZpHtFIrtTBQf7ZSE5Ws1LujRtvK8vsiyMQZE3Oxox5/yxvluBC+n6KvgeKiEmCuF4F80
 YqRRBhOJ11HEgki9RD9gq2kLlWzpIBTWIfxG/6aBX9lBk0N7HIW4RGilO2xmK02zI4z4
 Mqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773821511; x=1774426311;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0obZQtca6d6glbYBCYnsmcZ8egVVaPB3btnSlzkln+w=;
 b=qWX7KcnrpfiwL06lwQfU4m58Nq1iBTrVSAPcsd5C0qAA5Y1XC6ZfIY8org4WVDRjs/
 W34C+4N6N1exp2MrKxXvI/soo0J5Rj1DUrvNuKU49PfmkVQXJzuD6hVozd+O/WFkqUV9
 8LcvAb6Fk3PJ35arxB8ARGnjCAZ0KVLs1H9pRmTjnVP9r5R08Pg1++ZBD3afF6BWm6Bx
 Ur1+gHM0mFE+EPKqxASA6n8EhBc07BoiHAiRehvdBsbv0hq/gB4plpfdHLkAk+OH/iVx
 sREJUVx+l/2PdjTW8baM/eLDdlWk6LnN4Lvx0abtphQS6LLAS0xkMqADQKWDjzRw/2c+
 dwAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPMl7CR+h2O9Opc1Bp9XrwgW+YQtWIFeHFXwTMT/LuDetYHvDatvvnNiSWWfijdUjNCqo6JBf+tIPz@nongnu.org
X-Gm-Message-State: AOJu0YzZd67O6hxVFWrmTmB/Tr4LZRhTRQiBRAguwHsjmBi6nuh18JTL
 Bm9Pu591fqXtuEISGu3HpExAdFTCVFeOB4qtBDA+PfwC0zk0BYxlYJKTTvtYAzNoI5anzueC87Z
 5AZ0UKKDmnwPalDNRIaHKRPusUoNgi+nnWChxwJmsAG+FDkGUxrQIPiyi
X-Gm-Gg: ATEYQzyuxeGgR+4SSPilSGX6fv1i3O+HmUKINYgTIKq0ecxnsWr0WoFmAd65qZraXJL
 P2FZklBBNsbzLy56pJ33OccDpXsfUqOwq47AuyzP4RXmn86u2DhYGvSnF3tNdNrqQ/h//KsRzVa
 16ySzd5nz2ARJ4K10zcNj4aoFdsscYSStHePMZH7FAWzAwfZGH1w+ogNH5TU53Lt19M/KckzZer
 MUNhq35s4xJKRvWqqWMNWBNpyMV0ZI1oZdtdZ5kPzblPLpre2xRJsX3eb2/0MJ9aDmBl6S+9JLq
 3ZvTh7Ah9BwAHfa6qvhOg74oySczGFIXieI8v4zQY+w57HUoBGYrGjIB092EtLELJEfQcyWanut
 6P+pla3cO0l64HdD0/fBRa+gIpHaovqwCBTY+tPpBWXPXeZzkaaQMkW8Cz1bX
X-Received: by 2002:a05:600c:358e:b0:485:40a6:442e with SMTP id
 5b1f17b1804b1-486f41ff20dmr47327215e9.0.1773821511366; 
 Wed, 18 Mar 2026 01:11:51 -0700 (PDT)
X-Received: by 2002:a05:600c:358e:b0:485:40a6:442e with SMTP id
 5b1f17b1804b1-486f41ff20dmr47326675e9.0.1773821510859; 
 Wed, 18 Mar 2026 01:11:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b51805291sm6391176f8f.0.2026.03.18.01.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 01:11:50 -0700 (PDT)
Message-ID: <40924489-a8bb-4f6f-b85e-6f53cf475304@redhat.com>
Date: Wed, 18 Mar 2026 09:11:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <20260317194241.869568-4-pierrick.bouvier@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260317194241.869568-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 3/17/26 20:42, Pierrick Bouvier wrote:
> Add stubs for needed functions.
> 
> As well, we need to add pixman to qemuutil library dependencies since
> pixman is transitively included from pci.h header, which is needed to be
> able to include prototypes for stubs we declared.
> In file included from include/ui/console.h:4,
>                   from ../hw/vfio/vfio-display.h:12,
>                   from ../hw/vfio/pci.h:25,
>                   from ../hw/vfio/igd-stubs.c:9:
> include/ui/qemu-pixman.h:10:10: fatal error: pixman.h: No such file or directory
>     10 | #include <pixman.h>
>        |          ^~~~~~~~~~
> 
> On OpenBSD, opengl headers are not available in default include path,
> and thus we need to add opengl to list of qemuutil dependencies.
> In file included from /home/root/qemu/include/ui/console.h:9:
> /home/root/qemu/include/ui/surface.h:11:11: fatal error: 'epoxy/gl.h' file not found
> 
> Finally, vfio_pci_hot_reset_info must be forwarded declared on non linux
> platforms:
> In file included from ../hw/vfio/igd-stubs.c:9:
> ../hw/vfio/pci.h:265:44: error: 'struct vfio_pci_hot_reset_info' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
>    265 |                                     struct vfio_pci_hot_reset_info **info_p);
>        |
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Duplicated Signed-off-by. I can fix when applying.

Thanks,

C.

> ---
>   meson.build          |  2 +-
>   hw/vfio/pci.h        |  2 ++
>   hw/vfio/igd-stubs.c  | 20 ++++++++++++++++++++
>   hw/vfio/pci-quirks.c |  5 -----
>   hw/vfio/meson.build  |  1 +
>   5 files changed, 24 insertions(+), 6 deletions(-)
>   create mode 100644 hw/vfio/igd-stubs.c
> 
> diff --git a/meson.build b/meson.build
> index b2154bb9287..ab726ea1152 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3781,7 +3781,7 @@ util_ss = util_ss.apply({})
>   libqemuutil = static_library('qemuutil',
>                                build_by_default: false,
>                                sources: util_ss.sources() + stub_ss.sources() + genh,
> -                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt])
> +                             dependencies: [util_ss.dependencies(), libm, threads, glib, socket, malloc, rt, pixman, opengl])
>   qemuutil = declare_dependency(link_with: libqemuutil,
>                                 sources: genh + version_res,
>                                 dependencies: [event_loop_base])
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index d6495d7f297..c3a1f53d350 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -258,6 +258,8 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp);
>   
>   extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
>   
> +struct vfio_pci_hot_reset_info;
> +
>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
>   void vfio_pci_post_reset(VFIOPCIDevice *vdev);
>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
> diff --git a/hw/vfio/igd-stubs.c b/hw/vfio/igd-stubs.c
> new file mode 100644
> index 00000000000..f7687d90912
> --- /dev/null
> +++ b/hw/vfio/igd-stubs.c
> @@ -0,0 +1,20 @@
> +/*
> + * IGD device quirks stubs
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/qmp/qerror.h"
> +#include "pci.h"
> +#include "pci-quirks.h"
> +
> +void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> +{
> +    return;
> +}
> +
> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
> +{
> +    return true;
> +}
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 7b907b9360d..ab864048943 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -11,7 +11,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include CONFIG_DEVICES
>   #include "exec/memop.h"
>   #include "qemu/units.h"
>   #include "qemu/log.h"
> @@ -1128,11 +1127,9 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>    */
>   bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp)
>   {
> -#ifdef CONFIG_VFIO_IGD
>       if (!vfio_probe_igd_config_quirk(vdev, errp)) {
>           return false;
>       }
> -#endif
>       return true;
>   }
>   
> @@ -1179,9 +1176,7 @@ void vfio_bar_quirk_setup(VFIOPCIDevice *vdev, int nr)
>       vfio_probe_nvidia_bar5_quirk(vdev, nr);
>       vfio_probe_nvidia_bar0_quirk(vdev, nr);
>       vfio_probe_rtl8168_bar2_quirk(vdev, nr);
> -#ifdef CONFIG_VFIO_IGD
>       vfio_probe_igd_bar0_quirk(vdev, nr);
> -#endif
>   }
>   
>   void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> index f2a7728d3d0..6c00a7f51bb 100644
> --- a/hw/vfio/meson.build
> +++ b/hw/vfio/meson.build
> @@ -17,6 +17,7 @@ vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
>   vfio_ss.add(when: 'CONFIG_VFIO_CCW', if_true: files('ccw.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_AP', if_true: files('ap.c'))
>   vfio_ss.add(when: 'CONFIG_VFIO_IGD', if_true: files('igd.c'))
> +stub_ss.add(files('igd-stubs.c'))
>   
>   specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>   


