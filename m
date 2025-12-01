Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7469CD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ4dc-00063k-Kt; Mon, 01 Dec 2025 09:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ4db-00063a-L4
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ4da-0007cE-1S
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:12:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764598340;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=0B0imrKlv6KQ4GG03oIU6wgaNWxHtxb3Y2lJz4xSfaI=;
 b=bETmvPc/IJtmkEsY/wcg+hL/I9WfvnFrFxDqim/ouKZiCA7Bt2spR6BzXFnERp4c87a3gj
 IZPEvPWvl2krX/RzbsiSlCM5A6WU0k3toK+URIuGcAb4srb59EZztdgB5WGaBWa1t+gUYQ
 j6mcJ8+3EDCamTS/OtJaWpsyshynkAk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-o9Q7cfJBMhaPOk-li8EKFQ-1; Mon,
 01 Dec 2025 09:12:18 -0500
X-MC-Unique: o9Q7cfJBMhaPOk-li8EKFQ-1
X-Mimecast-MFC-AGG-ID: o9Q7cfJBMhaPOk-li8EKFQ_1764598337
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 061CC19560BF; Mon,  1 Dec 2025 14:12:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60946195608E; Mon,  1 Dec 2025 14:12:12 +0000 (UTC)
Date: Mon, 1 Dec 2025 14:12:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Chalios, Babis" <bchalios@amazon.es>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: Re: [RFC PATCH 3/4] hw/acpi: add VM generation counter field to
 VMClock
Message-ID: <aS2iOER6KBMMtJ0X@redhat.com>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-5-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251201125023.18344-5-bchalios@amazon.es>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 01, 2025 at 12:51:10PM +0000, Chalios, Babis wrote:
> The final published version of the VMClock specification adds support
> for an extra vm_generation_counter field which allows hypervisors to
> differentiate between live migration and snapshot loading events. During
> the latter, apart from adjusting clocks, guests might want to take
> further actions such as resetting network devices, updating UUIDs,
> reseeding entropy pools, etc.
> 
> VM generation counter itself is stored in the guest memory region and
> exposed to guest userspace, so we don't need to serialize it within
> vmstate_vmclock as well.
> 
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
>  hw/acpi/vmclock.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/acpi/vmclock.c b/hw/acpi/vmclock.c
> index c582c0c1f8..47cbba4496 100644
> --- a/hw/acpi/vmclock.c
> +++ b/hw/acpi/vmclock.c
> @@ -20,6 +20,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
>  #include "migration/vmstate.h"
> +#include "migration/misc.h"
>  #include "system/reset.h"
>  
>  #include "standard-headers/linux/vmclock-abi.h"
> @@ -64,6 +65,7 @@ void vmclock_build_acpi(VmclockState *vms, GArray *table_data,
>  static void vmclock_update_guest(VmclockState *vms)
>  {
>      uint64_t disruption_marker;
> +    uint64_t vm_generation_counter;
>      uint32_t seq_count;
>  
>      if (!vms->clk) {
> @@ -79,6 +81,16 @@ static void vmclock_update_guest(VmclockState *vms)
>      disruption_marker++;
>      vms->clk->disruption_marker = cpu_to_le64(disruption_marker);
>  
> +    /*
> +     * We only increase the vm_generation_counter when loading from a snapshot,
> +     * not during live migration
> +     */
> +    if (!migration_is_running()) {
> +        vm_generation_counter = le64_to_cpu(vms->clk->vm_generation_counter);
> +        vm_generation_counter++;
> +        vms->clk->vm_generation_counter = cpu_to_le64(vm_generation_counter);
> +    }

I don't believe this conditional works. Run it with

  $ qemu-system-x86_64 -monitor stdio -device vmclock
  (qemu) migrate tcp:localhost:9000

and

  $ qemu-system-x86_64 -monitor stdio -device vmclock -incoming tcp:localhost:9000


and the vm_generation_counter always gets updated on every migrate
operation.

'migration_is_running()' is always returning 'false' when this callback
is triggered on the target.

Even if it were to return 'true' as this code expects, this would not
allow to distinguish between snapshots and live migration. The QEMU
"migrate" / "migrate-incoming" commands are used by mgmt apps to
implement snapshots. From QEMU's POV, live migration and snapshots
are indistiguishable operations, both using the same functionaility.

eg
  $ qemu-system-x86_64 -monitor stdio -device vmclock
  (qemu) migrate file:snapshot.img

and

  $ qemu-system-x86_64 -monitor stdio -device vmclock -incoming file:snapshot.img


and we can't check the QEMU migration target being "file:" and mgmt
apps can use the "fd:" protocol to pass in a pre-opened target which can
be a socket or pipe or file.

Only the mgmt app knows if this is for a snapshot or a live migration or
something else.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


