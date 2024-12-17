Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709C9E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZOA-0005W7-1G; Tue, 17 Dec 2024 10:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tNZO7-0005VV-N6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:21:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tNZO5-0004W2-Pt
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734448887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLXIcfhEljzQGKGN6Spe/86GGKOa6LWHXnv/zAkDeQw=;
 b=G0TgHaLDvqRtoqHpmDeOvw+tqwAKsRsQ96u/pa4SbJ2HL7j9MMMvT1wcQbe4F563k3rmyR
 UWH1MIIOqqsBCIvqYixU+bD2+ILz+/I9hPpTt1HsfTMMfIjW7G0SDHIv5Pe3CHcUHdj8Jr
 p++l5QnSGXX1ux/AWA+csZT0LIswMMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-368-zHj2tfTzNMy9l1G9k50q_Q-1; Tue,
 17 Dec 2024 10:21:24 -0500
X-MC-Unique: zHj2tfTzNMy9l1G9k50q_Q-1
X-Mimecast-MFC-AGG-ID: zHj2tfTzNMy9l1G9k50q_Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DAA11955F2B; Tue, 17 Dec 2024 15:21:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.88])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 744BA195395A; Tue, 17 Dec 2024 15:21:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 430E01800399; Tue, 17 Dec 2024 16:21:20 +0100 (CET)
Date: Tue, 17 Dec 2024 16:21:20 +0100
From: Gerd Hoffman <kraxel@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
Message-ID: <rnhi7vmax2vicc56xpaltjbfnffto3k7awaum4eblqlts4uhd2@ivqgxapmdnj2>
References: <20241216114841.1025070-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216114841.1025070-1-anisinha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> +Fw-cfg Files
> +************
> +
> +Guests drive vmfwupdate through special ``fw-cfg`` files that control its flow
> +followed by a standard system reset operation. When vmfwupdate is available,
> +it provides the following ``fw-cfg`` files:
> +
> +* ``vmfwupdate/cap`` (``u64``) - Read-only Little Endian encoded bitmap of additional
> +  capabilities the interface supports. List of available capabilities:
> +
> +     ``VMFWUPDATE_CAP_BIOS_RESIZE        0x0000000000000001``
> +
> +* ``vmfwupdate/bios-size`` (``u32``) - Little Endian encoded size of the BIOS region.
> +  Read-only by default. Optionally Read-write if ``vmfwupdate/cap`` contains
> +  ``VMFWUPDATE_CAP_BIOS_RESIZE``. On write, the BIOS region may resize. Guests are
> +  required to read the value after writing and compare it with the requested size
> +  to determine whether the resize was successful. Note, x86 BIOS regions always
> +  start at 4GiB - bios-size.
> +
> +* ``vmfwupdate/opaque`` (``1024 bytes``) - A 1KiB buffer that survives the BIOS replacement
> +  flow. Can be used by the guest to propagate guest physical addresses of payloads
> +  to its BIOS stage. It’s recommended to make the new BIOS clear this file on boot
> +  if it exists. Contents of this file are under control by the hypervisor. In an
> +  environment that considers the hypervisor outside of its trust boundary, guests
> +  are advised to validate its contents before consumption.
> +
> +* ``vmfwupdate/disable`` (``u8``) - Indicates whether the interface is disabled.
> +  Returns 0 for enabled, 1 for disabled. Writing any value disables it. Writing is
> +  only allowed if the value is 0. When the interface is disabled, the replace file
> +  is ignored on reset. This value resets to 0 on system reset.
> +
> +* ``vmfwupdate/bios-addr`` (``u64``) - A 64bit Little Endian encoded guest physical address
> +  at the beginning of the replacement BIOS region. The provided payload must reside
> +  in shared memory. 0 on system reset.

I'd suggest to make all integers u64 (little endian).

Any specific reason why vmfwupdate/opaque is 1024 bytes?
How about using 4096 (aka PAGE_SIZE) bytes?

> +On reset, the hypervisor evaluates whether ``vmfwupdate/disable`` is ``1``. If it is, it ignores
> +any other vmfwupdate values and performs a standard system reset.
> +
> +If ``vmfwupdate/disable`` is ``0``, the hypervisor checks if bios-addr is ``0``. If it is, it
> +performs a standard system reset.

What is 'standard system reset' in SEV-SNP mode?  I think qemu does not
support it right now and will simply poweroff the guest instead.  Will
that continue to be the case?  Or should qemu re-create the VM context
in that case, simliar to the firmware update case, except that qemu
would have to use the default firmware image then?

Will the vmfwupdate be supported without SEV-SNP too?  Might be useful
for development + testing.  If so the spec should clarify what happens
in that case, because the concept of "shared memory" does not exist
then.

take care,
  Gerd


