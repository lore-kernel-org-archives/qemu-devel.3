Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F6FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeJo-0001zf-CY; Mon, 11 Mar 2024 07:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rjeJn-0001zG-5U
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rjeJl-000487-Oy
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 07:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710158383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uRyEkCKNkPVnOj3uensDQWTBZOHL7iOI9MqexSDkxoM=;
 b=WhCcHBjgIX35ULgmyKutxD8/YlSHzF/zNMR6LUtW5D+x4xuM44EP367H+vUa0kGOBycfUA
 PCuz+F9tyzrQu0h436tAhTZCMMojeOS5SWnehtVgGPCKMoOcK8FnpAhQglCPlpyS+/EWtB
 n90hS9j9dSQw8uZwgc/O+1HPRVNTA+I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-pzQ_R8s9N2264nbHyKsxiA-1; Mon,
 11 Mar 2024 07:59:30 -0400
X-MC-Unique: pzQ_R8s9N2264nbHyKsxiA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E97BE1C04330;
 Mon, 11 Mar 2024 11:59:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C60DB492BC4;
 Mon, 11 Mar 2024 11:59:29 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8FBC91801A82; Mon, 11 Mar 2024 12:59:28 +0100 (CET)
Date: Mon, 11 Mar 2024 12:59:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Tom Lendacky <thomas.lendacky@amd.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] kvm: add support for guest physical bits
Message-ID: <q6zckxcxwke2kdlootdq3s7m2ctcy7juuv3fsezhpw3nqyewxo@sqku62f25gdc>
References: <20240305105233.617131-1-kraxel@redhat.com>
 <20240305105233.617131-3-kraxel@redhat.com>
 <CABgObfZ13WEHaGNzjy0GVE2EAZ=MHOSNHS_1iTOuBduOt5q_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZ13WEHaGNzjy0GVE2EAZ=MHOSNHS_1iTOuBduOt5q_3g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 952174bb6f52..d427218827f6 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > +    guest_phys_bits = kvm_get_guest_phys_bits(cs->kvm_state);
> > +    if (guest_phys_bits &&
> > +        (cpu->guest_phys_bits == 0 ||
> > +         cpu->guest_phys_bits > guest_phys_bits)) {
> > +        cpu->guest_phys_bits = guest_phys_bits;
> > +    }
> 
> Like Xiaoyao mentioned, the right place for this is kvm_cpu_realizefn,
> after host_cpu_realizefn returns. It should also be conditional on
> cpu->host_phys_bits.

Ok.

> It also makes sense to:
> 
> - make kvm_get_guest_phys_bits() return bits 7:0 if bits 23:16 are zero
> 
> - here, set cpu->guest_phys_bits only if it is not equal to
> cpu->phys_bits (this undoes the previous suggestion, but I think it's
> cleaner)

Not sure about that.

I think it would be good to have a backward compatibility story.
Currently neither the kernel nor qemu set guest_phys_bits.  So if the
firmware finds guest_phys_bits == 0 it does not know whenever ...

  (a) kernel or qemu being too old, or
  (b) no restrictions apply, it is safe to go with phys_bits.

One easy option would be to always let qemu pass through guest_phys_bits
from the kernel, even in case it is equal to phys_bits.

> - add a property in x86_cpu_properties[] to allow configuration with TCG.

Was thinking about configuration too.  Not sure it is a good idea to
add yet another phys-bits config option to the mix of options we already
have ...

In case host_phys_bits=true qemu could simply use
min(kernel guest-phys-bits,host-phys-bits-limit)

For the host_phys_bits=false case it would probably be best to just
not set guest_phys_bits.

take care,
  Gerd


