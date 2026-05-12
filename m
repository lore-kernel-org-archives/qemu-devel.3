Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCF4CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqzN-0007JZ-7y; Tue, 12 May 2026 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMqzL-0007JE-4H
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMqzI-00073b-Cb
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778607222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4AIiyOL+STLETfRrukFNcHjutK/BcGRpomEgpxhn4M=;
 b=KyPxhV7MJE4T2gtKBrLIAiWeItzCe60Mfuz8ZZd1JNWqGAlpR3Ii9ylfXPCkrumTdgoeXG
 awIQ2bmwFqhn8hANIzb3rKigD0fGOEXHSCzefO3qwDDaWv/VsV0l+6ik2DzgNVo+MtTxOH
 ZnWfndPolq2DMhpehZT9ZtBxAPJe1YY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-dEdjZDpFNLGXle5zhKh9Sw-1; Tue,
 12 May 2026 13:33:35 -0400
X-MC-Unique: dEdjZDpFNLGXle5zhKh9Sw-1
X-Mimecast-MFC-AGG-ID: dEdjZDpFNLGXle5zhKh9Sw_1778607214
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F30061956080; Tue, 12 May 2026 17:33:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.86])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D728630001BB; Tue, 12 May 2026 17:33:32 +0000 (UTC)
Date: Tue, 12 May 2026 18:33:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: fatih =?utf-8?B?xZ9lbmVy?= <fatihsenerr@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/kvm: Fix Live Migration failure on Intel Ice
 Lake after OS upgrade (Ubuntu 20.04 to 22.04)
Message-ID: <agNkab2farpJHSNt@redhat.com>
References: <CAA1wZPc_RPc5NpN6Bg+4fW+PtbFSmR5uXGg4-bcvK4khOANUWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1wZPc_RPc5NpN6Bg+4fW+PtbFSmR5uXGg4-bcvK4khOANUWQ@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, May 12, 2026 at 11:02:37AM +0300, fatih şener wrote:
> Dear QEMU Developers,
> 
> We have identified a critical live migration failure on Intel Ice Lake
> platforms when using *CPU host-passthrough* in OpenStack environments. The
> issue specifically surfaced after upgrading compute nodes from *Ubuntu
> 20.04 to 22.04*.

IMHO that is not a valid usage scenario.

host-passthrough is only supportable with live migration if both sides
of the migration are *identical*. That means same CPU models, same
microcode version, same BIOS version, same BIOS settings, same kernel
version, same QEMU version. Vary any one of those factors as it looses
any guarantee of live migration safety for host-passthrough.

If those requirements can't be guaranteed, then we have a wide choice
of named CPU models that support migration across hosts with different
setups.

> *Technical Analysis:* The migration fails with KVM_SET_MSRS error while
> restoring MSR_IA32_PERF_GLOBAL_CTRL (0x38f). On Ice Lake CPUs, this
> register reports 0xf000000ff due to the 4th fixed-function counter (Perf
> Mon v5).
> 
> We observed that while the source host (20.04) allows this value, the
> target host (22.04 with a newer Kernel/KVM) enforces a stricter mask of
> 0x7000000ff. Even with identical hardware, the migration is rejected
> because the target KVM treats the 4th bit as reserved/invalid.
> 
> *Proposed Fix:* We propose intercepting the MSR write in
> target/i386/kvm/kvm.c to mask the value back to 0x7000000ff if 0xf000000ff
> is detected. This ensures backward compatibility across different kernel
> versions and stabilizes migration on Ice Lake hardware.
> 
> /* target/i386/kvm/kvm.c */
> for (i = 0; i < cpu->kvm_msr_buf->nmsrs; i++) {
>     if (cpu->kvm_msr_buf->entries[i].index == 0x38f &&
>         cpu->kvm_msr_buf->entries[i].data == 0xf000000ffULL) {
>         cpu->kvm_msr_buf->entries[i].data = 0x7000000ffULL;
>     }
> }
> 
> We have verified that this fix stabilizes our production environment and
> allows successful live migration between hosts with different kernel
> versions on Ice Lake hardware. We are looking forward to your technical
> feedback on this implementation. If there is a more architectural way to
> handle these MSR bitmasks upstream, we would be happy to discuss it. Best
> regards,
> -- 
> ● Fatih Şener - fatihsenerr@gmail.com

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


