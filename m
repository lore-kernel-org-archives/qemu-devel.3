Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DDEC83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 10:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufFYc-0000T8-SR; Fri, 25 Jul 2025 06:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufFYa-0000OJ-97
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 06:21:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufFYX-0000JT-0N
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 06:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753438893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xOUpPrbia1s7oZxsLo+FknE80KaTVSRba1HXNVXk4rA=;
 b=dNRwmJuAMehfbCwnFfPW09DwTTIjTRqnpLeYS7eZ/VxbJ0eHZT5dGJClFpJNiHb49VLxw6
 FNip95qJMZQ8Mk3YvYGg5c0VH3N8dkj3d6WwFytb1QoT+tqHMjxg/93+tYQoBAyLOewvBP
 Gnotp7RhE+1HLtllIQ4irHF1zIJV+ks=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-_Dx563h7NZGkEwC1rHsYlQ-1; Fri,
 25 Jul 2025 06:21:31 -0400
X-MC-Unique: _Dx563h7NZGkEwC1rHsYlQ-1
X-Mimecast-MFC-AGG-ID: _Dx563h7NZGkEwC1rHsYlQ_1753438890
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909F11800256; Fri, 25 Jul 2025 10:21:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC7A5195608D; Fri, 25 Jul 2025 10:21:28 +0000 (UTC)
Date: Fri, 25 Jul 2025 11:21:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] dump: enhance win_dump_available to report properly
Message-ID: <aINapSq8Dk4z6ozj@redhat.com>
References: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723170402.75798-1-nikolai.barybin@virtuozzo.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 08:04:02PM +0300, Nikolai Barybin wrote:
> QMP query-dump-guest-memory-capability reports win dump as available for
> any x86 VM, which is false.
> 
> This patch implements proper query of vmcoreinfo and calculation of
> guest note size. Based on that we can surely report whether win dump
> available or not.
> 
> For further reference one may review this libvirt discussion:
> https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
> [PATCH 0/4] Allow xml-configured coredump format on VM crash
> 
> Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
> ---
>  dump/win_dump.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/dump/win_dump.c b/dump/win_dump.c
> index 3162e8bd48..4bb1b28e63 100644
> --- a/dump/win_dump.c
> +++ b/dump/win_dump.c
> @@ -14,14 +14,74 @@
>  #include "qemu/error-report.h"
>  #include "exec/cpu-defs.h"
>  #include "hw/core/cpu.h"
> +#include "hw/misc/vmcoreinfo.h"
>  #include "qemu/win_dump_defs.h"
>  #include "win_dump.h"
>  #include "cpu.h"
> +#include "elf.h"
>  
>  #if defined(TARGET_X86_64)
>  
> +#define ELF_NOTE_SIZE(hdr_size, name_size, desc_size)   \
> +    ((DIV_ROUND_UP((hdr_size), 4) +                     \
> +      DIV_ROUND_UP((name_size), 4) +                    \
> +      DIV_ROUND_UP((desc_size), 4)) * 4)
> +
>  bool win_dump_available(Error **errp)
>  {
> +    uint64_t addr, note_head_size, name_size, desc_size;
> +    uint32_t size;
> +    uint16_t guest_format;
> +    uint8_t *guest_note = NULL;
> +    size_t guest_note_size = 0;
> +    VMCoreInfoState *vmci = vmcoreinfo_find();
> +    ArchDumpInfo dump_info = {};
> +    GuestPhysBlockList blocks = {};
> +    int ret;
> +
> +    if (!vmci || !vmci->has_vmcoreinfo)
> +        return false;
> +
> +    ret = cpu_get_dump_info(&dump_info, &blocks);
> +    if (ret < 0)
> +        return false;
> +
> +    guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
> +    if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF)
> +        return false;
> +
> +    size = le32_to_cpu(vmci->vmcoreinfo.size);
> +    addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
> +    note_head_size = dump_info.d_class == ELFCLASS64 ?
> +        sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
> +
> +    guest_note = g_malloc(size + 1);
> +    cpu_physical_memory_read(addr, guest_note, size);
> +    if (dump_info.d_class == ELFCLASS64) {
> +        const Elf64_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le64(hdr->n_namesz);
> +            desc_size = cpu_to_le64(hdr->n_descsz);
> +        } else {
> +            name_size = cpu_to_be64(hdr->n_namesz);
> +            desc_size = cpu_to_be64(hdr->n_descsz);
> +        }
> +    } else {
> +        const Elf32_Nhdr *hdr = (void *)guest_note;
> +        if (dump_info.d_endian == ELFDATA2LSB) {
> +            name_size = cpu_to_le32(hdr->n_namesz);
> +            desc_size = cpu_to_le32(hdr->n_descsz);
> +        } else {
> +            name_size = cpu_to_be32(hdr->n_namesz);
> +            desc_size = cpu_to_be32(hdr->n_descsz);
> +        }
> +    }
> +
> +    guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size, desc_size);

It feels like there is overlap between what this method has to do upto
here, with what the existing 'dump_init' has to do. Any possibility to
have a common helper to share logic ?

> +    if (guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64 &&
> +        guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32)
> +        return false;

This dupes a check in create_win_dump, but  misses the extra sanity
check from check_header. I think we should move the guest_note_size
check out of 'create_win_dump' and into 'check_header', then call
that from this code.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


