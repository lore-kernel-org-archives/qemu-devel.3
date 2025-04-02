Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3381C3601A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 12:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzwuH-0003Qm-SX; Wed, 02 Apr 2025 08:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwu4-0003Oj-1V
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tzwu0-0004mY-Oc
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 08:09:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743595741;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=lednpq/wcodxKFGbWUGqfrNDJL1JACgoI5X2E0pkt8E=;
 b=clIs3DYfc2OowS1u9tJ/MLZV6alQKndOcLSTlYafc6Q+IEip4xvCOL/yPh3IsokI5Tw1SN
 9S2QKaHVK5mawnFnO250T0N9tNfSftR5bae16nHva0Aq6fVWysTf20zGgg2PfCaI6NVkYQ
 ZFJ9mWrjBF7m3oe9iwKr9xbTguBRF2c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-jXbv36IfP429GAhY6x7jbQ-1; Wed,
 02 Apr 2025 08:08:57 -0400
X-MC-Unique: jXbv36IfP429GAhY6x7jbQ-1
X-Mimecast-MFC-AGG-ID: jXbv36IfP429GAhY6x7jbQ_1743595736
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 544B018001F8; Wed,  2 Apr 2025 12:08:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 861B0180B489; Wed,  2 Apr 2025 12:08:53 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:08:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH v8 17/55] i386/tdvf: Introduce function to parse TDVF
 metadata
Message-ID: <Z-0o0sYJcnqI23aX@redhat.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
 <20250401130205.2198253-18-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401130205.2198253-18-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 01, 2025 at 09:01:27AM -0400, Xiaoyao Li wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> TDX VM needs to boot with its specialized firmware, Trusted Domain
> Virtual Firmware (TDVF). QEMU needs to parse TDVF and map it in TD
> guest memory prior to running the TDX VM.
> 
> A TDVF Metadata in TDVF image describes the structure of firmware.
> QEMU refers to it to setup memory for TDVF. Introduce function
> tdvf_parse_metadata() to parse the metadata from TDVF image and store
> the info of each TDVF section.
> 
> TDX metadata is located by a TDX metadata offset block, which is a
> GUID-ed structure. The data portion of the GUID structure contains
> only an 4-byte field that is the offset of TDX metadata to the end
> of firmware file.
> 
> Select X86_FW_OVMF when TDX is enable to leverage existing functions
> to parse and search OVMF's GUID-ed structures.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> Changes in v8:
>  - Drop the failure handling of memcpy() since it cannot fail;
> 
> Changes in v7:
>  - Update license info to only use SPDX tag;
>  - use g_autofree to avoid manually free;
> 
> Changes in v6:
>  - Drop the the data endianness change for metadata->Length;
> 
> Changes in v1:
>  - rename tdvf_parse_section_entry() to
>    tdvf_parse_and_check_section_entry()
> 
> Changes in RFC v4:
>  - rename TDX_METADATA_GUID to TDX_METADATA_OFFSET_GUID
> ---
>  hw/i386/Kconfig        |   1 +
>  hw/i386/meson.build    |   1 +
>  hw/i386/tdvf.c         | 183 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/tdvf.h |  38 +++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 hw/i386/tdvf.c
>  create mode 100644 include/hw/i386/tdvf.h
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index cce9521ba934..eb65bda6e071 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -12,6 +12,7 @@ config SGX
>  
>  config TDX
>      bool
> +    select X86_FW_OVMF
>      depends on KVM
>  
>  config PC
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 10bdfde27c69..3bc1da2b6eb4 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -32,6 +32,7 @@ i386_ss.add(when: 'CONFIG_PC', if_true: files(
>    'port92.c'))
>  i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
>                                          if_false: files('pc_sysfw_ovmf-stubs.c'))
> +i386_ss.add(when: 'CONFIG_TDX', if_true: files('tdvf.c'))
>  
>  subdir('kvm')
>  subdir('xen')
> diff --git a/hw/i386/tdvf.c b/hw/i386/tdvf.c
> new file mode 100644
> index 000000000000..328d1b7ffdf8
> --- /dev/null
> +++ b/hw/i386/tdvf.c
> @@ -0,0 +1,183 @@
> +/*
> + * Copyright (c) 2025 Intel Corporation
> + * Author: Isaku Yamahata <isaku.yamahata at gmail.com>
> + *                        <isaku.yamahata at intel.com>
> + *         Xiaoyao Li <xiaoyao.li@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +
> +#include "hw/i386/pc.h"
> +#include "hw/i386/tdvf.h"
> +#include "system/kvm.h"
> +
> +#define TDX_METADATA_OFFSET_GUID    "e47a6535-984a-4798-865e-4685a7bf8ec2"
> +#define TDX_METADATA_VERSION        1
> +#define TDVF_SIGNATURE              0x46564454 /* TDVF as little endian */
> +
> +typedef struct {
> +    uint32_t DataOffset;
> +    uint32_t RawDataSize;
> +    uint64_t MemoryAddress;
> +    uint64_t MemoryDataSize;
> +    uint32_t Type;
> +    uint32_t Attributes;
> +} TdvfSectionEntry;
> +
> +typedef struct {
> +    uint32_t Signature;
> +    uint32_t Length;
> +    uint32_t Version;
> +    uint32_t NumberOfSectionEntries;
> +    TdvfSectionEntry SectionEntries[];
> +} TdvfMetadata;

struct field names starting with an initial capital is
not the usual QEMU code style. Can this be all initial
lowercase, with capital just for word separation.


> +
> +struct tdx_metadata_offset {
> +    uint32_t offset;
> +};
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


