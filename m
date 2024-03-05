Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD5BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:58:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVIp-0004Mh-Df; Tue, 05 Mar 2024 08:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhVIn-00042h-AE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rhVIl-0006qQ-9U
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709647070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+5CJuO59jm3H0HA8beka8VW7L6jr5umZrJG+B8qOSo=;
 b=EeQYpPWneLbP+EILFqkR18D1vsBworFD6OnZmWSfdgy2rL1Sdy3FyD1+j6ZaYwsG1IQ1KR
 vYIBHFlG94jcc3e44aBa2sJz9YZKJPFkZAZS9SUQrThAMGHTHu0rmuWcDOcwzdpNh63Pl3
 FeNwdnw0G6JR0c6UdMUHuq/Yo29OojI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-qJZceKIsPrS6v-jt2LjrBQ-1; Tue, 05 Mar 2024 08:57:49 -0500
X-MC-Unique: qJZceKIsPrS6v-jt2LjrBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11CB2185A789
 for <qemu-devel@nongnu.org>; Tue,  5 Mar 2024 13:57:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C97F10E4F;
 Tue,  5 Mar 2024 13:57:47 +0000 (UTC)
Date: Tue, 5 Mar 2024 13:57:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: pbonzini@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 vchundur@redhat.com
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
Message-ID: <Zeck2gcPLe3NdmD_@redhat.com>
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com>
 <Zbi9vjPCsia58LG4@redhat.com> <CZL1LKPLC005.2WG9X653U6H6D@fedora>
 <ZeXfPdp-Ul3vxlxL@redhat.com> <CZLUM0L9G5U3.1UOBP5UFKY1AA@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CZLUM0L9G5U3.1UOBP5UFKY1AA@fedora>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 05, 2024 at 02:25:09PM +0100, Anthony Harivel wrote:
> Daniel P. Berrangé, Mar 04, 2024 at 15:48:
> > On Mon, Mar 04, 2024 at 03:41:02PM +0100, Anthony Harivel wrote:
> > > 
> > > Hi Daniel,
> > > 
> > > > > +        if (s->msr_energy.enable == true) {
> > > >
> > > > This looks to be where we need to check that both the host CPU
> > > > vendor is intel, and the guest CPU vendor is intel, and that
> > > > the host CPU has the RAPL feature we're using.
> > >
> > > Checking for the host cpu and RAPL enable is fine and done. 
> > > 
> > > But checking for guest CPU is confusing me. 
> > > The RAPL feature is enable only with KVM enable. 
> > > This means "-cpu" can only be "host" or its derivative that essentially 
> > > copy the host CPU definition, no?
> >
> > KVM can use any named CPU.
> >
> > > That means if we are already checking the host cpu we don't need to do 
> > > anything for the guest, do we ?
> >
> > When I first wrote this I though it would be as simple as checknig a
> > CPUID feature flag. That appears to not be the case, however, as Linux
> > is just checking for various CPU models directly. With that in mind
> > perhaps we should just check of the guest CPU model vendor
> > == CPUID_VENDOR_INTEL and leave it at that.
> >
> > eg, create an error if running an AMD CPU such as $QEMU -cpu EPYC
> 
> The idea looks good to me. Now the hiccups of this solution is that 
> I cannot find a way to reach CPUArchState at this level of code (i.e 
> kvm_arch_init() ) with only the MachineState or the KVMState. 
> I can only reach the topology with x86_possible_cpu_arch_ids().
> 
> CPUArchState struct is holding the cpuid_vendor variables where we can 
> use IS_INTEL_CPU() for checking.
> 
> Maybe you know the trick that I miss ?

I think perhaps you can do a check in kvm_cpu_realizefn() from
target/i386/kvm/kvm-cpu.c, as you have CPUX86State state which
is what IS_INTEL_CPU wants.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


