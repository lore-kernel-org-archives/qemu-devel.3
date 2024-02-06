Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D74C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMIM-0002x8-Sl; Tue, 06 Feb 2024 09:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXMIK-0002uU-Qz
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rXMIH-0001z6-US
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707229165;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=J9chu5wku+L3X9QPTB+fSQGGxovjB2xXfo4JagUQgzg=;
 b=HacZlEuw86Q2PyeNJCxbNe22aSBt/GiHEvJbOhcaqbxHI7O85cWwV49PSshJAcC/uh/jMB
 cUunLOprSH3sQZYvzx28Z7XfS8QxUSxF7CyPIEQWlIPs6D+qUucKOMgZz6+7/87NtfrxQW
 IGHMu3zN/yJfDPuYRrepELHgxsAcruI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-aRudN138Po2190E2fcy1Sg-1; Tue, 06 Feb 2024 09:19:21 -0500
X-MC-Unique: aRudN138Po2190E2fcy1Sg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEFC8868A21;
 Tue,  6 Feb 2024 14:19:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A99641103A;
 Tue,  6 Feb 2024 14:19:18 +0000 (UTC)
Date: Tue, 6 Feb 2024 14:19:16 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH 0/4] Confidential Guest Support: Introduce kvm_init()
 and kvm_reset() virtual functions
Message-ID: <ZcI_5IbCltQbqhIz@redhat.com>
References: <20240206082852.3333299-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206082852.3333299-1-xiaoyao.li@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 06, 2024 at 03:28:48AM -0500, Xiaoyao Li wrote:
> This series is inspired and suggested by Daniel:
> https://lore.kernel.org/qemu-devel/ZbfoQsEuv6_zwl3b@redhat.com/
> 
> Currently, different confidential VMs in different architectures have
> their own specific *_kvm_init() (and some have *_kvm_reset()) exposed
> for KVM stuff when it's a confidential VM. e.g., sev_kmv_init() for x86
> SEV, pef_kvm_init() and pef_kvm_reset() for PPC PEF, and s390_pv_init()
> for s390 PV VMs.
> 
> Introduce a generic .kvm_init() and .kvm_reset() functions in
> ConfidentialGuestSupportClass, so that different cgs technologies in
> different architectures can implement their own, while common interface
> of cgs can be used.
> 
> This RFC implements two helper functions confidential_guest_kvm_init()
> and confidential_guest_kvm_reset() in Patch 1. In the following patches,
> they are called in arch specific implementation. X86 will benefit more
> for the generic implementation when TDX support is added.
> 
> There is one step forward possible, that calling
> confidential_guest_kvm_init() before kvm_arch_init() in kvm_int() in
> accel/kvm/kvm-all.c. This way, each arch doesn't need to call in their
> arch specific code.
> 
> X86 fits it, however I'm not sure if ppc and s390 fit it as well.
> Because currently, ppc calls it in machine->init()
> and s390 calls in MachineClass->init(). I'm not sure if there is any
> order dependency.

IIUC that s390 call is still a machine->init method, rather than
class init.

I think this series is nice, but its up to the KVM maintainers
to decide...


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


