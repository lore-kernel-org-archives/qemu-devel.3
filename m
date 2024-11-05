Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3E6D1267E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H1k-0002d6-1J; Tue, 05 Nov 2024 05:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8H1i-0002cs-0x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8H1f-0003PE-QT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730803387;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fjQMb444NpSo3Nqa82o/omKxuraxwlFuyfDE/0Lkv3c=;
 b=B4Kcs5z57U836rqjtEEp43lW03gVd/aCHiizLM2JyKkBgEUcB2PsOA1lzccv134tM0GWpq
 3P3PBfahLJKe9tOCJw4sGTadaHlai3fPaIqBaZn43KjQ+6CvunqfG/nnxj3wnvhJOcEeB8
 KSXcxdlwhDz2F7xn4Rg1i6bkfgl2vFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-RY5z4U_cNgG8cD171WNHxg-1; Tue,
 05 Nov 2024 05:43:00 -0500
X-MC-Unique: RY5z4U_cNgG8cD171WNHxg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08251956089; Tue,  5 Nov 2024 10:42:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D7BE6300018D; Tue,  5 Nov 2024 10:42:51 +0000 (UTC)
Date: Tue, 5 Nov 2024 10:42:47 +0000
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
Subject: Re: [PATCH v6 18/60] i386/tdvf: Introduce function to parse TDVF
 metadata
Message-ID: <Zyn2p9wD2SnisXhT@redhat.com>
References: <20241105062408.3533704-1-xiaoyao.li@intel.com>
 <20241105062408.3533704-19-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105062408.3533704-19-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 05, 2024 at 01:23:26AM -0500, Xiaoyao Li wrote:
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
>  hw/i386/tdvf.c         | 200 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/tdvf.h |  51 +++++++++++
>  4 files changed, 253 insertions(+)
>  create mode 100644 hw/i386/tdvf.c
>  create mode 100644 include/hw/i386/tdvf.h
> 
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 86bc10377c4f..555a000037bc 100644
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
> index 000000000000..4afa636bfa0e
> --- /dev/null
> +++ b/hw/i386/tdvf.c
> @@ -0,0 +1,200 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later

Since you have this SPDX tag....

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

...you should omit the GPL boilerplate text here, as the new
QEMU standard is to use only SPDX for new files.


> +
> +int tdvf_parse_metadata(TdxFirmware *fw, void *flash_ptr, int size)
> +{
> +    TdvfSectionEntry *sections;

g_autofree TdvfSectionEntry *sections = NULL;

will avoid the duplicated 'g_free' calls later

> +    TdvfMetadata *metadata;
> +    ssize_t entries_size;
> +    int i;
> +
> +    metadata = tdvf_get_metadata(flash_ptr, size);
> +    if (!metadata) {
> +        return -EINVAL;
> +    }
> +
> +    /* load and parse metadata entries */
> +    fw->nr_entries = le32_to_cpu(metadata->NumberOfSectionEntries);
> +    if (fw->nr_entries < 2) {
> +        error_report("Invalid number of fw entries (%u) in TDVF Metadata",
> +                     fw->nr_entries);
> +        return -EINVAL;
> +    }
> +
> +    entries_size = fw->nr_entries * sizeof(TdvfSectionEntry);
> +    if (metadata->Length != sizeof(*metadata) + entries_size) {
> +        error_report("TDVF metadata len (0x%x) mismatch, expected (0x%x)",
> +                     metadata->Length,
> +                     (uint32_t)(sizeof(*metadata) + entries_size));
> +        return -EINVAL;
> +    }
> +
> +    fw->entries = g_new(TdxFirmwareEntry, fw->nr_entries);
> +    sections = g_new(TdvfSectionEntry, fw->nr_entries);
> +
> +    if (!memcpy(sections, (void *)metadata + sizeof(*metadata), entries_size)) {
> +        error_report("Failed to read TDVF section entries");
> +        goto err;
> +    }
> +
> +    for (i = 0; i < fw->nr_entries; i++) {
> +        if (tdvf_parse_and_check_section_entry(&sections[i], &fw->entries[i])) {
> +            goto err;
> +        }
> +    }
> +    g_free(sections);
> +
> +    return 0;
> +
> +err:
> +    g_free(sections);
> +    fw->entries = 0;
> +    g_free(fw->entries);
> +    return -EINVAL;
> +}
> diff --git a/include/hw/i386/tdvf.h b/include/hw/i386/tdvf.h
> new file mode 100644
> index 000000000000..593341eb2e93
> --- /dev/null
> +++ b/include/hw/i386/tdvf.h
> @@ -0,0 +1,51 @@
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

Same note about only using SPDX.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


