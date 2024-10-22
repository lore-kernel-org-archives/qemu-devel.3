Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7906D2C55E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Ft8-0000zG-TD; Tue, 22 Oct 2024 10:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Fsx-0000vi-Rw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t3Fsu-0006vV-Es
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729607359;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqVR261PUo/NOW5kNtai2pVQKfWJLgVOdR0IhsTjPys=;
 b=YJzkWjnJTpzcsQSw0o2p6qzDa937zJgMb5SdxlaFXjEgZOJv8gtzeS0yjMOHKVm8wkj0RP
 ZfvvEg4VKmKK8MZeutCOuKSs1h5V17YSHSzRZBrFwfQaTC+L8SQhsnC1NW5oX5e1dU3960
 //8PXWsqQKmNaNhcVkKyR6rSlMCoDmQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-N7IeTogvOLKLglUPbJp7mQ-1; Tue,
 22 Oct 2024 10:29:18 -0400
X-MC-Unique: N7IeTogvOLKLglUPbJp7mQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 251A11955D4B
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:29:17 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9899C1955F42; Tue, 22 Oct 2024 14:29:14 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:29:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anthony Harivel <aharivel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <Zxe2tcMcHs6eYsp0@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
 <ZxJbtkMO1QcoiqVn@redhat.com>
 <20241022144615.203cf0da@imammedo.users.ipa.redhat.com>
 <ZxelgDeuZaia-Vqf@redhat.com>
 <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D52ED9BSZU9P.32LYD3328YTTN@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Oct 22, 2024 at 04:16:36PM +0200, Anthony Harivel wrote:
> Daniel P. Berrangé, Oct 22, 2024 at 15:15:
> > On Tue, Oct 22, 2024 at 02:46:15PM +0200, Igor Mammedov wrote:
> >> On Fri, 18 Oct 2024 13:59:34 +0100
> >> Daniel P. Berrangé <berrange@redhat.com> wrote:
> >> 
> >> > On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
> >> > > On Wed, 16 Oct 2024 14:56:39 +0200
> >> > > "Anthony Harivel" <aharivel@redhat.com> wrote:
> >> [...]
> >> 
> >> > > 
> >> > > This also leads to a question, if we should account for
> >> > > not VCPU threads at all. Looking at real hardware, those
> >> > > MSRs return power usage of CPUs only, and they do not
> >> > > return consumption from auxiliary system components
> >> > > (io/memory/...). One can consider non VCPU threads in QEMU
> >> > > as auxiliary components, so we probably should not to
> >> > > account for them at all when modeling the same hw feature.
> >> > > (aka be consistent with what real hw does).  
> >> > 
> >> > I understand your POV, but I think that would be a mistake,
> >> > and would undermine the usefulness of the feature.
> >> > 
> >> > The deployment model has a cluster of hosts and guests, all
> >> > belonging to the same user. The user goal is to measure host
> >> > power consumption imposed by the guest, and dynamically adjust
> >> > guest workloads in order to minimize power consumption of the
> >> > host.
> >> 
> >> For cloud use-case, host side is likely in a better position
> >> to accomplish the task of saving power by migrating VM to
> >> another socket/host to compact idle load. (I've found at least 1
> >> kubernetis tool[1], which does energy monitoring). Perhaps there
> >> are schedulers out there that do that using its data.
> 
> I also work for Kepler project. I use it to monitor my VM has a black 
> box and I used it inside my VM with this feature enable. Thanks to that 
> I can optimize the workloads (dpdk application,database,..) inside my VM. 
> 
> This is the use-case in NFV deployment and I'm pretty sure this could be 
> the use-case of many others.
> 
> >
> > The host admin can merely shuffle workloads around, hoping that
> > a different packing of workloads onto machines, will reduce power
> > in some aount. You might win a few %, or low 10s of % with this
> > if you're good at it.
> >
> > The guest admin can change the way their workload operates to
> > reduce its inherant power consumption baseline. You could easily
> > come across ways to win high 10s of % with this. That's why it
> > is interesting to expose power consumption info to the guest
> > admin.
> >
> > IOW, neither makes the other obsolete, both approaches are
> > desirable.
> >
> >> > The guest workloads can impose non-negligble power consumption
> >> > loads on non-vCPU threads in QEMU. Without that accounted for,
> >> > any adjustments will be working from (sometimes very) inaccurate
> >> > data.
> >> 
> >> Perhaps adding one or several energy sensors (ex: some i2c ones),
> >> would let us provide auxiliary threads consumption to guest, and
> >> even make it more granular if necessary (incl. vhost user/out of
> >> process device models or pass-through devices if they have PMU).
> >> It would be better than further muddling vCPUs consumption
> >> estimates with something that doesn't belong there.
> 
> I'm confused about your statement. Like every software power metering 
> tools out is using RAPL (Kepler, Scaphandre, PowerMon, etc) and custom 
> sensors would be better than a what everyone is using ?
> The goal is not to be accurate. The goal is to be able to compare 
> A against B in the same environment and RAPL is given reproducible 
> values to do so.

Be careful with saying "The goal isnot to be accurate", as that's
a very broad statement, and I don't think it is true.


If you're doing A/B comparisons, you *do* need accuracy, in the
sense that if a guest workload config change alters host CPU
power consumption, you want that to be reflected in what the
guest is told about its power usagte.

ie if a change in B moves some power usage from a vCPU thread
to a non-vCPU thread, you don't want that power usage to
disappear from what's reported to the guest. It would give you
the false idea that B is more efficient than A, even if the
non-vCPU thread for B was cosuming x2 what the orignal vCPU
thread was for A.

What I think you don't need is for the absolute magnitude of
the reported power consumption to be a precise match to the
actual power consumption.

ie if A and B are reported as 7 and 9 Watts respectively, it
doesn't matter if the actual consumption was 12 and 15 watts.

The relationship between the two measurements is still valid,
and enables tuning, despite the magnitude being under-reported.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


