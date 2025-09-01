Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9679CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut26t-0002DY-62; Mon, 01 Sep 2025 06:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut26r-0002DE-AZ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ut26l-0008RH-OK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756723794;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YHntFevXo73QLVEqNQao70/IiH3hy0xtaU592yGchNE=;
 b=BI9tSqeqL6qalxRGIlj8Vk8K2yagvp8pdfCyyQJ4H+z9IcgUefo7k43Gk4Hmvg5VHUtmL3
 Z8T8ttHhfryuXwdgGwv/BInrF/92h4l9/RMvy+rVR1+eVQWCUq7Pot1gNxLsrq9rjgQjI0
 IcWS8s8Xl9dGAgagGfcVF5w8oA4j/ew=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-TtzD-cfyO12eMGyYT0Ayug-1; Mon,
 01 Sep 2025 06:49:50 -0400
X-MC-Unique: TtzD-cfyO12eMGyYT0Ayug-1
X-Mimecast-MFC-AGG-ID: TtzD-cfyO12eMGyYT0Ayug_1756723789
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AEE61956087; Mon,  1 Sep 2025 10:49:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ACA7180028F; Mon,  1 Sep 2025 10:49:46 +0000 (UTC)
Date: Mon, 1 Sep 2025 11:49:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: Re: [PATCH v7 09/14] hw/misc: Add RISC-V CPC device implementation
Message-ID: <aLV6RjGTizwAbyd-@redhat.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
 <20250901102850.1172983-10-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250901102850.1172983-10-djordje.todorovic@htecgroup.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 01, 2025 at 10:29:05AM +0000, Djordje Todorovic wrote:
> Add RISC-V implementation of the Cluster Power Controller (CPC) device.
> It is based on the existing MIPS CPC implementations but adapted for
> RISC-V systems.
> 
> The CPC device manages power control for CPU clusters in RISC-V
> systems.
> 
> This is needed for the MIPS BOSTON AIA board.
> 
> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/misc/Kconfig             |   4 +
>  hw/misc/meson.build         |   1 +
>  hw/misc/riscv_cpc.c         | 271 ++++++++++++++++++++++++++++++++++++
>  include/hw/misc/riscv_cpc.h |  75 ++++++++++
>  4 files changed, 351 insertions(+)
>  create mode 100644 hw/misc/riscv_cpc.c
>  create mode 100644 include/hw/misc/riscv_cpc.h
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index c72927c3ff..1e35bcd443 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -124,11 +124,15 @@ config MIPS_ITU
>  config RISCV_CMGCR
>      bool
>  
> +config RISCV_CPC
> +    bool
> +
>  config MIPS_BOSTON_AIA
>      bool
>      default y
>      depends on RISCV64
>      select RISCV_CMGCR
> +    select RISCV_CPC
>  
>  config MPS2_FPGAIO
>      bool
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index ef891e465b..1f9945755f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -158,6 +158,7 @@ specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cp
>  specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>  
>  specific_ss.add(when: 'CONFIG_RISCV_CMGCR', if_true: files('riscv_cmgcr.c'))
> +specific_ss.add(when: 'CONFIG_RISCV_CPC', if_true: files('riscv_cpc.c'))
>  
>  system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>  
> diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
> new file mode 100644
> index 0000000000..6a6cf72d45
> --- /dev/null
> +++ b/hw/misc/riscv_cpc.c
> @@ -0,0 +1,271 @@
> +/*
> + * Cluster Power Controller emulation
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later

As this was copied from an existing file, just leave the original GPL
header here unchanged, don't add a SPDX tag to pre-existing code, only
to newly authored files.


> diff --git a/include/hw/misc/riscv_cpc.h b/include/hw/misc/riscv_cpc.h
> new file mode 100644
> index 0000000000..3e908f4f44
> --- /dev/null
> +++ b/include/hw/misc/riscv_cpc.h
> @@ -0,0 +1,75 @@
> +/*
> + * Cluster Power Controller emulation
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * Copyright (c) 2025 MIPS
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + *
> + */

Same points as above.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


