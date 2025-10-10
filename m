Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D47CAC5BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 08:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v78eq-00042j-UZ; Fri, 10 Oct 2025 04:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78ep-00042b-O8
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v78ek-0007p3-RN
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 04:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760085554;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BfrPMHJYvTkmNjp6IZnGIlUOFxqGXOgS+qxlJXvM4Mg=;
 b=fxLZ0H9N26IH00qsVCJ4Tb1cErPIe9BI8juHuVTHKG97x8CfwBsxcAu/Ij7apUibZenB7Z
 XzWmOFKtuoQqkB7oQ/1M1XlVhAEYZQ40uQjEoceLqndIVjfGLSRw1dUf2/ttGI63MpBziW
 uaKmW9qg8rro7W9wX0Iwe/ryLoBFV6U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-HxR6y0dpMxiGG6aaGsgHpg-1; Fri,
 10 Oct 2025 04:39:11 -0400
X-MC-Unique: HxR6y0dpMxiGG6aaGsgHpg-1
X-Mimecast-MFC-AGG-ID: HxR6y0dpMxiGG6aaGsgHpg_1760085550
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AFD7195608D; Fri, 10 Oct 2025 08:39:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9671955F22; Fri, 10 Oct 2025 08:39:06 +0000 (UTC)
Date: Fri, 10 Oct 2025 09:39:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
 "query-balloon" after CPR transfer
Message-ID: <aOjGEPHsSCc0ULma@redhat.com>
References: <20250928085432.40107-7-zhenzhong.duan@intel.com>
 <1ba0dbca-08b2-4f80-ba12-01884a25ef0d@oracle.com>
 <IA3PR11MB913635F06F6522102D8FC15D921AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <78df77e2-43a6-48d6-b09e-fcc61a662b6e@oracle.com>
 <IA3PR11MB9136EF2C01DAB2C2EA261CC092E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ab688cce-283d-4541-b7ca-be651085979e@oracle.com>
 <aOfEiogVQiAhBqMG@redhat.com>
 <2ac44a27-d4f2-4191-a9c3-513af25925b0@oracle.com>
 <aOfIgzCkwmtVXhvt@redhat.com>
 <IA3PR11MB9136738C2CE19566F4543DFE92EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA3PR11MB9136738C2CE19566F4543DFE92EFA@IA3PR11MB9136.namprd11.prod.outlook.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 10, 2025 at 03:54:42AM +0000, Duan, Zhenzhong wrote:
> 
> 
> >-----Original Message-----
> >From: Daniel P. Berrangé <berrange@redhat.com>
> >Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
> >"query-balloon" after CPR transfer
> >
> >On Thu, Oct 09, 2025 at 10:32:34AM -0400, Steven Sistare wrote:
> >> On 10/9/2025 10:19 AM, Daniel P. Berrangé wrote:
> >> > On Thu, Oct 09, 2025 at 10:11:17AM -0400, Steven Sistare wrote:
> >> > > On 10/8/2025 6:22 AM, Duan, Zhenzhong wrote:
> >> > > >
> >> > > >
> >> > > > > -----Original Message-----
> >> > > > > From: Steven Sistare <steven.sistare@oracle.com>
> >> > > > > Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when execute
> >> > > > > "query-balloon" after CPR transfer
> >> > > > >
> >> > > > > On 9/30/2025 2:00 AM, Duan, Zhenzhong wrote:
> >> > > > > > > -----Original Message-----
> >> > > > > > > From: Steven Sistare <steven.sistare@oracle.com>
> >> > > > > > > Subject: Re: [PATCH v2 6/6] accel/kvm: Fix SIGSEGV when
> >execute
> >> > > > > > > "query-balloon" after CPR transfer
> >> > > > > > >
> >> > > > > > > On 9/28/2025 4:54 AM, Zhenzhong Duan wrote:
> >> > > > > > > > After CPR transfer, source QEMU closes kvm fd and sets
> >kvm_state to
> >> > > > > > > NULL,
> >> > > > > > > > "query-balloon" will check kvm_state->sync_mmu and trigger
> >NULL
> >> > > > > pointer
> >> > > > > > > > reference.
> >> > > > > > > >
> >> > > > > > > > We don't need to NULL kvm_state as all states in kvm_state
> >aren't
> >> > > > > released
> >> > > > > > > > actually. Just closing kvm fd is enough so we could still query
> >states
> >> > > > > > > > through "query_*" qmp command.
> >> > > > > > >
> >> > > > > > > IMO this does not make sense.  Much of the state in kvm_state
> >was
> >> > > > > derived
> >> > > > > > >from ioctl's on the descriptors, and closing them invalidates it.
> >Asking
> >> > > > > > > historical questions about what used to be makes no sense.
> >> > > > > >
> >> > > > > > You also have your valid point.
> >> > > > > >
> >> > > > > > >
> >> > > > > > > Clearing kvm_state and setting kvm_allowed=false would be a
> >safer fix.
> >> > > > >
> >> > > > > Setting kvm_allowed=false causes kvm_enabled() to return false
> >which should
> >> > > > > prevent kvm_state from being dereferenced anywhere:
> >> > > > >
> >> > > > >       #define kvm_enabled()           (kvm_allowed)
> >> > > > >
> >> > > > >     Eg for the balloon:
> >> > > > >
> >> > > > >       static bool have_balloon(Error **errp)
> >> > > > >       {
> >> > > > >           if (kvm_enabled() && !kvm_has_sync_mmu()) {
> >> > > >
> >> > > > OK, will do, clearing kvm_allowed is a good idea.
> >> > > >
> >> > > > Currently there are two qmp commands "query-balloon" and
> >"query-cpu-definitions"
> >> > > > causing SIGSEGV after CPR-transfer, clearing kvm_allowed helps for
> >both.
> >> > > > But clearing both kvm_allowed and kvm_state cause SIGSEGV on
> >"query-cpu-definitions".
> >> > > >
> >> > > > I'll send a patch to clearing only kvm_allowed if you are fine with it.
> >> > >
> >> > > I still don't love the idea.  kvm_state is no longer valid.
> >> > >
> >> > > It sounds like "query-cpu-definitions" is missing a check for
> >kvm_enabled().
> >> >
> >> > This patch  / bug feels like it is side-stepping a general conceptual
> >> > question.  After cpr-transfer is complete what QMP commands are still
> >> > valid to call in general ? This thread mentions two which have caused
> >> > bugs, but beyond that it feels like a large subset of QMP comamnds
> >> > are conceptually invalid to use.
> >>
> >> Agreed. I don't see why these commands should be issued to the dead
> >instance.
> >> How about migration status, quit, and nothing else?
> >> Half serious.
> >
> >I was hoping you'd suggest such a short list :-)
> >
> >Essentially a case of calling qmp_for_each_command(), and in the callback
> >run qmp_disable_command() for everything not in the allow-list.
> 
> Thanks for your suggestion, I agree this is a perfect scheme, but is also heavy on this corner case😊
> Just curious if we need to do same for live migration. E.g., send qmp command on source qemu after live migration.

At the end of a normal migration, there is no functional reason to prevent
use of any QMP command.  Indeed we need to have the ability to carry on
using the orignal source QEMU, in case the final steps on migration on
the target fail and we need to restart the source.

The cpr-transfer is unusual in the restrictions it has after completion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


