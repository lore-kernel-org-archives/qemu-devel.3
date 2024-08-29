Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29747C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 19:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjkwg-0005xN-0B; Thu, 29 Aug 2024 15:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sjkwe-0005wl-RX
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 15:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sjkwc-0001WA-JW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 15:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724960192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lxi8M8+/L34KoCPpLOFJ28DABfbf3tVIfOGjnU8veAs=;
 b=LFXz3EZbnWHds4wmOn4VJLaFyL10SpUIIDz205V9j0w8IL0/FGdM9c/PTbi0DiUPD2S/P8
 IVZfPO/IKw8SXB8//LGKTEz1zRBGj1P3L7q8I7tmejmN6qdRnHFRzsQOcO5RDm2yuB1QI6
 4A9OjnQej4y5+/klkC1Ta/TTouwjyyU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-u_TRa157N0azMimkoe3eQw-1; Thu,
 29 Aug 2024 15:36:28 -0400
X-MC-Unique: u_TRa157N0azMimkoe3eQw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93C3A1955D4C; Thu, 29 Aug 2024 19:36:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67CCF19560A3; Thu, 29 Aug 2024 19:36:25 +0000 (UTC)
Date: Thu, 29 Aug 2024 14:36:22 -0500
From: Eric Blake <eblake@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 Johannes Stoelp <johannes.stoelp@googlemail.com>
Subject: Re: [PATCH for-9.2] kvm: Use 'unsigned long' for request argument in
 functions wrapping ioctl()
Message-ID: <xnhwmoi2yuoclzfzeazt25ykfpbkcxovu2a4dqkbcuho2x5iw5@mqea5ylhdmpu>
References: <20240815122747.3053871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815122747.3053871-1-peter.maydell@linaro.org>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 15, 2024 at 01:27:47PM GMT, Peter Maydell wrote:
> From: Johannes Stoelp <johannes.stoelp@googlemail.com>
> 
> Change the data type of the ioctl _request_ argument from 'int' to
> 'unsigned long' for the various accel/kvm functions which are
> essentially wrappers around the ioctl() syscall.
> 
> The correct type for ioctl()'s 'request' argument is confused:
>  * POSIX defines the request argument as 'int'

A bit of history: POSIX defined ioctl() because of the old Solaris
STREAMS interface, that ended up deprecated in Issue 7 (2004) and
removed in Issue 8 (just released this year).  So POSIX no longer
specified a signature for ioctl().  Admittedly, it DID add a new
interface posix_devctl() designed to be a "portable" replacement for
what ioctl() did (by being a new interface, there is no longer a
question on what type it has), with the intent that libraries will
eventually implement it (perhaps as a wrapper around the real ioctl),
and that one uses 'int' for the command, and replaces the varargs of
ioctl with a more direct specification of pointer and length.

https://pubs.opengroup.org/onlinepubs/9799919799/functions/posix_devctl.html

>  * glibc uses 'unsigned long' in the prototype in sys/ioctl.h
>  * the glibc info documentation uses 'int'

Arguably, that's a bug in glibc for being self-inconsistent.

>  * the Linux manpage uses 'unsigned long'
>  * the Linux implementation of the syscall uses 'unsigned int'

And there's more of the history, which didn't become apparent until
64-bit architectures became common, but where we now have fallout like
this thread.

> 
> If we wrap ioctl() with another function which uses 'int' as the
> type for the request argument, then requests with the 0x8000_0000
> bit set will be sign-extended when the 'int' is cast to
> 'unsigned long' for the call to ioctl().
> 
> On x86_64 one such example is the KVM_IRQ_LINE_STATUS request.
> Bit requests with the _IOC_READ direction bit set, will have the high
> bit set.
> 
> Fortunately the Linux Kernel truncates the upper 32bit of the request
> on 64bit machines (because it uses 'unsigned int', and see also Linus
> Torvalds' comments in
>   https://sourceware.org/bugzilla/show_bug.cgi?id=14362 )
> so this doesn't cause active problems for us.  However it is more
> consistent to follow the glibc ioctl() prototype when we define
> functions that are essentially wrappers around ioctl().
> 
> This resolves a Coverity issue where it points out that in
> kvm_get_xsave() we assign a value (KVM_GET_XSAVE or KVM_GET_XSAVE2)
> to an 'int' variable which can't hold it without overflow.

For the record, despite POSIX having picked a signed type, I am
totally in favor of an unsigned type in any of our uses.

> 
> Resolves: Coverity CID 1547759
> Signed-off-by: Johannes Stoelp <johannes.stoelp@gmail.com>
> [PMM: Rebased patch, adjusted commit message, included note about
>  Coverity fix, updated the type of the local var in kvm_get_xsave,
>  updated the comment in the KVMState struct definition]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is a patch that was posted back in 2021, and I reviewed it
> at the time
> https://lore.kernel.org/qemu-devel/20210901213426.360748-1-johannes.stoelp@gmail.com/
> but we never actually took it into the tree. I was reminded of it
> by the Coverity issue, where a change to Coverity means it now
> complains about the potential integer overflow when we put one
> of these high-bit-set ioctls into an "int". So I thought it would
> be worth dusting this off and getting it upstream.
> 
> For more discussion of the ioctl request datatype see also the
> review thread on the previous version of the patch:
> https://lore.kernel.org/qemu-devel/CAFEAcA8TRQdj33Ycm=XzmuUUNApaXVgeDexfS+3Ycg6kLnpmyg@mail.gmail.com/
> 
> Since this doesn't actually cause any incorrect behaviour this
> is obviously for-9.2 material.
> ---
>  include/sysemu/kvm.h     |  8 ++++----
>  include/sysemu/kvm_int.h | 16 ++++++++++++----
>  accel/kvm/kvm-all.c      |  8 ++++----
>  target/i386/kvm/kvm.c    |  3 ++-
>  accel/kvm/trace-events   |  8 ++++----
>  5 files changed, 26 insertions(+), 17 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> +++ b/include/sysemu/kvm_int.h
> @@ -122,10 +122,18 @@ struct KVMState
>      bool sync_mmu;
>      bool guest_state_protected;
>      uint64_t manual_dirty_log_protect;
> -    /* The man page (and posix) say ioctl numbers are signed int, but
> -     * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
> -     * unsigned, and treating them as signed here can break things */
> -    unsigned irq_set_ioctl;
> +    /*
> +     * POSIX says that ioctl numbers are signed int, but in practice

Maybe s/POSIX/older POSIX/ (given that newer POSIX does not specify
ioctl at all)

> +     * they are not. Linux, glibc and *BSD all treat ioctl numbers as
> +     * unsigned, and real-world ioctl values like KVM_GET_XSAVE have
> +     * bit 31 set, which means that passing them via an 'int' will
> +     * result in sign-extension when they get converted back to the
> +     * 'unsigned long' which the ioctl() prototype uses. Luckily Linux
> +     * always treats the argument as an unsigned 32-bit int, so any
> +     * possible sign-extension is deliberately ignored, but for
> +     * consistency we keep to the same type that glibc is using.
> +     */
> +    unsigned long irq_set_ioctl;
>      unsigned int sigmask_len;
>      GHashTable *gsimap;

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


