Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAC6D30006
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1maC-00031W-PP; Fri, 18 Oct 2024 08:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1ma3-0002zM-PE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1ma1-0002l8-2P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729256383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=3rc5Qaotp/On49ppQ7EnNENZI6ywzGQPtSmRQvUV8AE=;
 b=L5ytwRT2JpOV5yKK9FWU6d8drK2bwQzIBmT5gi9+ZucQIIKuqeQk/vUd2kwKOrRVOHKcpE
 3bs30+6BbQ4LaFpgOmAq2qsnVoLqgY6xA3GfSoqq3UxNTfP21HKW1dfszQVqxCGw1xAIRt
 k+xJtHsvuvLyVj7VEv6Tg3tSWndZjbs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-3uj4gfvSNR2EBuGU3-V_-Q-1; Fri,
 18 Oct 2024 08:59:42 -0400
X-MC-Unique: 3uj4gfvSNR2EBuGU3-V_-Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E1C71955DC6
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 12:59:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03B591956086; Fri, 18 Oct 2024 12:59:37 +0000 (UTC)
Date: Fri, 18 Oct 2024 13:59:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, pbonzini@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, vchundur@redhat.com,
 rjarry@redhat.com
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
Message-ID: <ZxJbtkMO1QcoiqVn@redhat.com>
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
 <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
 <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018142526.34a2de0a@imammedo.users.ipa.redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

On Fri, Oct 18, 2024 at 02:25:26PM +0200, Igor Mammedov wrote:
> On Wed, 16 Oct 2024 14:56:39 +0200
> "Anthony Harivel" <aharivel@redhat.com> wrote:
> 
> > Hi Igor,
> > 
> > Igor Mammedov, Oct 16, 2024 at 13:52:
> > > On Wed, 22 May 2024 17:34:49 +0200
> > > Anthony Harivel <aharivel@redhat.com> wrote:
> > >  
> > >> Dear maintainers, 
> > >> 
> > >> First of all, thank you very much for your review of my patch 
> > >> [1].  
> > >
> > > I've tried to play with this feature and have a few questions about it
> > >  
> > 
> > Thanks for testing this new feature. 
> > 
> > >  1. trying to start with non accessible or not existent socket
> > >         -accel kvm,rapl=on,rapl-helper-socket=/tmp/socket 
> > >     I get:
> > >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: vmsr socket opening failed
> > >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/socks: kvm : error RAPL feature requirement not met
> > >     * is it possible to report actual OS error that happened during open/connect,
> > >       instead of unhelpful 'socket opening failed'?
> > >
> > >       What I see in vmsr_open_socket() error is ignored
> > >       and btw it's error leak as well
> > >  
> > 
> > Shame you missed the 6 iterations of that patch that last for a year. 
> > I would have changed that directly !
> > Anyway I take note on that comment and will send a modification.
> > 
> > >     * 2nd line shouldn't be there if the 1st error already present.
> > >
> > >  2.  getting periodic error on console where QEMU has been starter
> > >       # ./qemu-vmsr-helper -k /tmp/sock
> > >      ./qemu-system-x86_64 -snapshot -m 4G -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock rhel90.img  -vnc :0 -cpu host
> > >      and let it run
> > >
> > >       it appears rdmsr works (well, it returns some values at least)
> > >       however there are recurring errors in qemu's stderr(or out)
> > >       
> > >       qemu-system-x86_64: Error opening /proc/2496093/task/2496109/stat
> > >       qemu-system-x86_64: Error opening /proc/2496093/task/2496095/stat
> > >
> > >       My guess it's some temporary threads, that come and go, but still
> > >       they shouldn't cause errors if it's normal operation.
> > >  
> > 
> > There a patch in WIP that change this into a Tracepoint. Maybe you can 
> > SSH to the VM in meanwhile ?
> 
> it's just idling VM that doesn't do anything, hence the question.  
> 
> > 
> > >       Also on daemon side, I a few times got while guest was running:
> > >         qemu-vmsr-helper: Failed to open /proc at /proc/2496026/task/2496044
> > >         qemu-vmsr-helper: Requested TID not in peer PID: 2496026 2496044
> > >       though I can't reproduce it reliably  
> > 
> > This could happen only when a vCPU thread ID has changed between the 
> > call of a rdmsr throught the socket and the hepler that read the msr.
> > No idea how a vCPU can change TID or shutdown that fast.
> 
> I guess it needs to be figured out to decide if it's safe to ignore (and not print error)
> or if it's a genuine error/bug somewhere
> 
> > >  3. when starting daemon not as root, it starts 'fine' but later on complains
> > >       qemu-vmsr-helper: Failed to open MSR file at /dev/cpu/0/msr
> > >     perhaps it would be better to fail at start daemon if it doesn't have
> > >     access to necessary files.
> > >  
> > 
> > Right taking a note on that as well.
> > 
> > 
> > >  4. in case #3, guest also fails to start with errors:
> > >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: can't read any virtual msr
> > >       qemu-system-x86_64: -accel kvm,rapl=on,rapl-helper-socket=/tmp/sock: kvm : error RAPL feature requirement not met
> > >      again line #2 is not useful and probably not needed (maybe make it tracepoint)
> > >      and #1 is unhelpful - it would be better if it directed user to check qemu-vmsr-helper
> > >  
> > 
> > I will try to see how to improve that part. 
> > Thanks for your valuable feedback.
> > 
> > >  5. does AMD have similar MSRs that we could use to make this feature complete?
> > >  
> > 
> > Yes but the address are completely different. However, this in my ToDo 
> > list. First I need way more feedback like yours to move on extending 
> > this feature.
> 
> If adding AMD's MSRs is not difficult, then I'd make it priority.
> This way users (and libvirt) won't have to deal with 2 different
> feature-sets and decide when to allow this to be turned on depending on host.
> 
> > 
> > >  6. What happens to power accounting if host constantly migrates
> > >     vcpus between sockets, are values we are getting still correct/meaningful?
> > >     Or do we need to pin vcpus to get 'accurate' values?
> > >  
> > 
> > It's taken into account during the ratio calculation which socket the 
> > vCPU has just been scheduled. But yes the value are more 'accurate' when 
> > the vCPU is pinned.
> 
> in worst case VCPUs might be moved between sockets many times during
> sample window, can you explain how that is accounted for?
> 
> Anyways, it would be better to have some numbers in doc that would
> clarify what kind of accuracy we are talking about (and example
> pinned vs unpinned), or whether unpinned case measures average
> temperature of patients in hospital and we should recommend
> to pin vcpus and everything else.
> 
> Also actual usecase examples for the feature should be mentioned
> in the doc. So users could figure out when they need to enable
> this feature (with attached accuracy numbers). Aka how this
> new feature is good for end users and what they can do with it.
>  
> > >  7. do we have to have a dedicated thread for pooling data from daemon?
> > >
> > >     Can we fetch data from vcpu thread that have accessed msr
> > >     (with some caching and rate limiting access to the daemon)?
> > >  
> > 
> > This feature is revolving around a thread. Please look at the 
> > documentation is not already done:
> > 
> > https://www.qemu.org/docs/master/specs/rapl-msr.html#high-level-implementation
> > 
> > If we only fetch from vCPU thread, we won't have the consumption of the 
> > non-vcpu thread. They are taken into account in the total.
> 
> one can collect the same data from vcpu thread as well,
> the bonus part is that we don't have an extra thread
> hanging around and doing work even if guest never asks
> for those MSRs.
> 
> This also leads to a question, if we should account for
> not VCPU threads at all. Looking at real hardware, those
> MSRs return power usage of CPUs only, and they do not
> return consumption from auxiliary system components
> (io/memory/...). One can consider non VCPU threads in QEMU
> as auxiliary components, so we probably should not to
> account for them at all when modeling the same hw feature.
> (aka be consistent with what real hw does).

I understand your POV, but I think that would be a mistake,
and would undermine the usefulness of the feature.

The deployment model has a cluster of hosts and guests, all
belonging to the same user. The user goal is to measure host
power consumption imposed by the guest, and dynamically adjust
guest workloads in order to minimize power consumption of the
host.

The guest workloads can impose non-negligble power consumption
loads on non-vCPU threads in QEMU. Without that accounted for,
any adjustments will be working from (sometimes very) inaccurate
data.

IOW, I think it is right to include non-vCPU threads usage in
the reported info, as it is still fundamentally part of the
load that the guest imposes on host pCPUs it is permitted to
run on.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


