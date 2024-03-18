Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A80DC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 15:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFGV-0000NS-7H; Mon, 18 Mar 2024 11:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFGR-0000MD-LF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rmFGF-0008Sm-Ss
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 11:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710777048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D4t+F05LcxYJzY/SOfIFEjyZxI8u4VlmTFQBBGEo4gk=;
 b=Smm/88bwqjDzPVo2Kbcn/upUbr41zcs1R89xroDUKcaoiV00bYDgaywl1cj+do3z9dP+nP
 Yfho8MCIhCPYeiuKrVP+em9bXLRrnNgsArGP89Uh/iQcK5PRvqZJAKNeVmGqgUrw4v6KUG
 u5Ojmoh88o9rMQb36MFnpMeSf+Eht/g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-J1JeeIUEPz-bz4zAQmtI8Q-1; Mon, 18 Mar 2024 11:50:45 -0400
X-MC-Unique: J1JeeIUEPz-bz4zAQmtI8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA81B822487;
 Mon, 18 Mar 2024 15:50:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA7ECC04222;
 Mon, 18 Mar 2024 15:50:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A56FC1800D54; Mon, 18 Mar 2024 16:50:39 +0100 (CET)
Date: Mon, 18 Mar 2024 16:50:39 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/3] kvm: add support for guest physical bits
Message-ID: <u6gdfu6qabzmfh6fa4llhmntjq6bq666tlg64r7gxrgsuldwyy@ei7byjx7t3v5>
References: <20240313132719.939417-1-kraxel@redhat.com>
 <20240313132719.939417-3-kraxel@redhat.com>
 <4cbf6d9c-3916-4436-abfe-10b35734b67a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cbf6d9c-3916-4436-abfe-10b35734b67a@intel.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

  Hi,

> > diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
> > index 9c791b7b0520..a2b7bfaeadf8 100644
> > --- a/target/i386/kvm/kvm-cpu.c
> > +++ b/target/i386/kvm/kvm-cpu.c
> > @@ -18,10 +18,36 @@
> >   #include "kvm_i386.h"
> >   #include "hw/core/accel-cpu.h"
> > +static void kvm_set_guest_phys_bits(CPUState *cs)
> > +{
> > +    X86CPU *cpu = X86_CPU(cs);
> > +    uint32_t eax, guest_phys_bits;
> > +
> > +    if (!cpu->host_phys_bits) {
> > +        return;
> > +    }
> 
> This needs explanation of why. What if users set the phys-bits to exactly
> host's value, via "-cpu xxx,phys-bits=host's value"?

If host_phys_bits is not enabled it is possible to set phys-bits to any
value today (including invalid values not supported by the host).  With
this the same applies to guest_phys_bits.

My intention was to continue allowing any guest_phys_bits + phys_bits
with TCG, for testing purposes.  But thinking again this logic is
flawed, if TCG is used the control flow doesn't land here in the first
place.

So, I think this can be dropped.

> > +    ret = host_cpu_realizefn(cs, errp);
> 
> We need to check ret and return if !ret;

Fixed.

thanks,
  Gerd


