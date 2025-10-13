Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1ADDCCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 11:57:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8H9O-00075e-Q8; Mon, 13 Oct 2025 07:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8H9M-00075P-U7
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8H9D-0001FH-2o
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 07:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760356523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Blzz0GTJo5AVg0MjZ5Opc4xBO0NSf/zcz3nqTeFMfM0=;
 b=LRCjiHTDiuwkp8pKc04nKciYuCTxR3mudEJ6NLbgZ9ptVDwcyoXnYCn51Cxl/i3/ARBnH3
 fk6b8K7YwBEYt571p5OsgvSb2lyomw6Lm/vx9Shz3iSbXS284qpNT2GqN9rZBMqkntcisf
 H6uc5lYgD070zzmYzrtjfCJWnoYXjuk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-Qa4IVXstMrmem5vO9Bv62Q-1; Mon,
 13 Oct 2025 07:55:20 -0400
X-MC-Unique: Qa4IVXstMrmem5vO9Bv62Q-1
X-Mimecast-MFC-AGG-ID: Qa4IVXstMrmem5vO9Bv62Q_1760356519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10599180045C; Mon, 13 Oct 2025 11:55:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AC961954102; Mon, 13 Oct 2025 11:55:18 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 170F218000B2; Mon, 13 Oct 2025 13:55:16 +0200 (CEST)
Date: Mon, 13 Oct 2025 13:55:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Markus Armbruster <armbru@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <wz4s6ty4jsmi57i7i6th4f2gdpbamiz67cfhyrbhdiusbis4ov@qcdqmui3a52r>
References: <20251010071008.2555267-1-kraxel@redhat.com>
 <aOluUdjaqw2XBzjr@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOluUdjaqw2XBzjr@gallifrey>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> > +typedef struct {
> > +    uint64_t             Magic1;
> > +    uint64_t             Magic2;
> > +} MEM_DEBUG_LOG_MAGIC;
> > +
> > +/* find log buffer in guest memory by searching for the magic cookie */
> > +static dma_addr_t find_ovmf_log_range(dma_addr_t start, dma_addr_t end)
> > +{
> > +    static const MEM_DEBUG_LOG_MAGIC magic = {
> > +        .Magic1 = MEM_DEBUG_LOG_MAGIC1,
> > +        .Magic2 = MEM_DEBUG_LOG_MAGIC2,
> > +    };
> > +    MEM_DEBUG_LOG_MAGIC check;
> > +    dma_addr_t step = 4 * KiB;
> > +    dma_addr_t offset;
> > +
> > +    for (offset = start; offset < end; offset += step) {
> > +        if (dma_memory_read(&address_space_memory, offset,
> > +                            &check, sizeof(check),
> > +                            MEMTXATTRS_UNSPECIFIED)) {
> > +            /* dma error -> stop searching */
> > +            break;
> > +        }
> > +        if (memcmp(&magic, &check, sizeof(check)) == 0) {
> > +            return offset;
> > +        }
> > +    }
> 
> This feels like a genericy function for searching memory
> that could go in util/ - if we haven't already got one
> (and then passing the magic in).

Quick grep doesn't look like we already have one.
Are there more possible users?

> Also, why is this dma_addr_t - is that for IO addressing?

dma_memory_read takes dma_addr_t (and I want use that so I get errors
back when trying to read address space not backed by ram.

> > +    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
> > +        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
> > +        X86MachineState *x86ms = X86_MACHINE(ms);
> > +
> > +        /* early log buffer, static allocation in memfd, sec + early pei */
> > +        offset = find_ovmf_log_range(0x800000, 0x900000);
> > +        if (offset != -1) {
> > +            return offset;
> > +        }
> > +
> > +        /*
> > +         * normal log buffer, dynamically allocated close to end of low memory,
> > +         * late pei + dxe phase
> > +         */
> > +        end = x86ms->below_4g_mem_size;
> > +        start = end - MIN(end, 128 * MiB);
> > +        offset = find_ovmf_log_range(start, end);
> > +        return offset;
> > +    }
> > +
> > +    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
> > +        object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
> > +        /* edk2 ArmVirt firmware allocations are in the first 128 MB */
> > +        VirtMachineState *vms = VIRT_MACHINE(ms);
> > +        start = vms->memmap[VIRT_MEM].base;
> > +        end = start + 128 * MiB;
> > +        offset = find_ovmf_log_range(start, end);
> > +        return offset;
> > +    }
> 
> Have you considered punting this to the machine type definition
> somehow; like making it set a list of {start, end} (and maybe
> a flag to say it's ovmf if it knows) ?

Advantage being?

The memory areas searched are quite specific to the firmware log, I
don't see other use cases being able to reuse that ...

take care,
  Gerd


