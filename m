Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93933C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofrv-0003gM-Kq; Tue, 28 Jul 2026 07:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wofru-0003g9-HK
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:21:06 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lpieralisi@kernel.org>)
 id 1wofrs-00075l-Pa
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 07:21:06 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C08760A9E;
 Tue, 28 Jul 2026 11:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4031F000E9;
 Tue, 28 Jul 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785237661;
 bh=tMmthg5QOwk/FUXaXgk/6L7Fh6QZ5tRAI7epZh6STjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cs8I++fp+QyWQn6MvZa/IFmUpxSlRWOpIjNyPxnhgd6xrKyMJC+C/f6mqniHyaAPD
 R6Ziqi28s/xfDKGE9kBpMw1T8dZcAff7t8r6/ZvX+LgSpBA7Qjw/3nbB9zWaXKfJdS
 3UEiQbAMhl3Qx82xtgekAe+jqOu348xm+H2IpTLzxRZaO7iv2+vd7UUZ3gOlEZQGfA
 spKgnQ2xvQUdhZXI0JkFmbEzoW+lLM/8npqP6SoeT7lHXPnn7WObyxXeZ3NKpHeewj
 4At8XyXC7VmeS45wm9DufLnU67iOXrgldg7sZm6FxOAGhEwybBGiDtJaPtWmUTgGxh
 Hao2MWx19ZBjw==
Date: Tue, 28 Jul 2026 13:20:56 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, pankaj.gupta@amd.com,
 isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
 ackerleytng@google.com
Subject: Re: [PATCH RFC 10/12] accel/kvm: Don't default to private attributes
 for in-place conversion
Message-ID: <amiQmARN-r2RSaax@lpieralisi>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-11-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528000416.8161-11-michael.roth@amd.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=lpieralisi@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 27, 2026 at 07:03:35PM -0500, Michael Roth wrote:
> Without in-place conversion, QEMU can still access shared memory to load
> initial state into guest memory prior to launch even if the GPA's memory
> attributes default to private, since userspace is accessing a completely
> separate pool of memory. With in-place conversion, all these accesses
> would need to first be converted to shared, then back to private, since
> the memory all comes from guest_memfd and only shared memory can be
> accessed by userspace.
> 
> To avoid sprinkling these differences in behavior throughout QEMU when
> in-place conversion is enabled, just default to shared. This does not
> compromise guest security, since Confidential VMs will necessarily
> enforce this via trusted entities, and simply generate implicit page
> state changes if their default expectations don't match KVM's. However,
> in most cases a guest will explicitly convert memory to a particular
> state before actually using it, so even these implicit conversion
> requests should be rare.

I assume you want to prevent peppering code with convert-in-place
conditional paths where, if we default to private, certain mem copies
to guest memory would fault.

Flip side: we default to shared, we leave the current code paths unchanged
(that assume double backing) but we end up (eg on CCA) populating guest memory
twice, once with a copy to shared guest memfd memory (that is basically
useless because populating in CCA is destructive) and then populating
the guest memory region using CCA KVM interface (KVM_ARM_RMI_POPULATE).

I am just thinking aloud and sharing what I have noticed so far.

Lorenzo

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  accel/kvm/kvm-all.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index fd01435a0f..c3d399517d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1808,7 +1808,26 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>              abort();
>          }
>  
> -        if (memory_region_has_guest_memfd(mr)) {
> +        /*
> +         * Without in-place conversion, QEMU can still access shared memory
> +         * to load initial state into guest memory prior to launch even if
> +         * the GPA's memory attributes default to private, since userspace
> +         * is accessing a completely separate pool of memory. With in-place
> +         * conversion, all these accesses would need to first be converted
> +         * to shared, then back to private, since the memory all comes from
> +         * guest_memfd and only shared memory can be accessed by userspace.
> +         *
> +         * To avoid sprinkling these differences in behavior throughout QEMU
> +         * when in-place conversion is enabled, just default to shared. This
> +         * does not compromise guest security, since Confidential VMs will
> +         * necessarily enforce this via trusted entities, and simply generate
> +         * implicit page state changes if their default expectations don't
> +         * match KVM's. However, in most cases a guest will explicitly
> +         * convert memory to a particular state before actually using it, so
> +         * even these implicit conversion requests should be rare.
> +         */
> +        if (memory_region_has_guest_memfd(mr) &&
> +            !(current_machine->cgs && current_machine->cgs->convert_in_place)) {
>              err = kvm_set_memory_attributes_private(start_addr, slot_size);
>              if (err) {
>                  error_report("%s: failed to set memory attribute private: %s",
> -- 
> 2.43.0
> 

