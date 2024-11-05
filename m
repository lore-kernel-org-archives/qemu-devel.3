Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA9DD1267D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H5O-0007gc-AN; Tue, 05 Nov 2024 05:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8H5H-0007gB-3E
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8H5F-0003kI-B0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730803607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/WEwL9TkWSySnRfQq6doKrURf9dgdkbqXzEf7AEuYg4=;
 b=LlrOv/TJCy/dy5I1iQNG+t5P7tQ4t5EaeJMunsvwS2qJg0fQs7TETDw8naz9Qi/Gwdikxc
 4uS6knddUwTzOCirWkSzv3/nTeMN9q0qZz5jZAhf3+tv0IU6rzxTu7K4QZUi4a75nBOAZA
 ydyj38E5ed8jeYa4+osLeh+g7cG6LJk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-54uIS3cwMyOIjc-eRyHuIQ-1; Tue,
 05 Nov 2024 05:46:46 -0500
X-MC-Unique: 54uIS3cwMyOIjc-eRyHuIQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D0861956048; Tue,  5 Nov 2024 10:46:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7633E19560A2; Tue,  5 Nov 2024 10:46:38 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:46:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, rick.p.edgecombe@intel.com,
 kvm@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 24/60] i386/tdx: Setup the TD HOB list
Message-ID: <Zyn3irziLxvAzNCU@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-25-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-25-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 01:23:32AM -0500, Xiaoyao Li wrote:
> The TD HOB list is used to pass the information from VMM to TDVF. The TD
> HOB must include PHIT HOB and Resource Descriptor HOB. More details can
> be found in TDVF specification and PI specification.
> 
> Build the TD HOB in TDX's machine_init_done callback.
> 
> Co-developed-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> ---
> Changes in v1:
>   - drop the code of adding mmio resources since OVMF prepares all the
>     MMIO hob itself.
> ---
>  hw/i386/meson.build   |   2 +-
>  hw/i386/tdvf-hob.c    | 147 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/tdvf-hob.h    |  24 +++++++
>  target/i386/kvm/tdx.c |  16 +++++
>  4 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 hw/i386/tdvf-hob.c
>  create mode 100644 hw/i386/tdvf-hob.h
> 
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 3bc1da2b6eb4..7896f348cff8 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -32,7 +32,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
>    'port92.c'))
>  i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
>                                          if_false: files('pc_sysfw_ovmf-stubs.c'))
> -i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c'))
> +i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c', 'tdvf-hob.c'))
>  
>  subdir('kvm')
>  subdir('xen')
> diff --git a/hw/i386/tdvf-hob.c b/hw/i386/tdvf-hob.c
> new file mode 100644
> index 000000000000..e00de256ea8c
> --- /dev/null
> +++ b/hw/i386/tdvf-hob.c
> @@ -0,0 +1,147 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> +
> + * Copyright (c) 2020 Intel Corporation
> + * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
> + *                        <isaku.yamahata at intel.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */

Remove the boilerplate in favour of the SPDX tag.


> diff --git a/hw/i386/tdvf-hob.h b/hw/i386/tdvf-hob.h
> new file mode 100644
> index 000000000000..1b737e946a8d
> --- /dev/null
> +++ b/hw/i386/tdvf-hob.h
> @@ -0,0 +1,24 @@
> +#ifndef HW_I386_TD_HOB_H
> +#define HW_I386_TD_HOB_H

Add the SPDX tag to this file


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


