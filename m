Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0A2D2F03F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkMk-0006TK-DP; Tue, 27 Jan 2026 09:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkkMa-0006Ng-M0
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:48:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vkkMY-00088B-2s
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769525293;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+PEZNetx70wHLfhgHg7E3APQrAc/SnbN6QkvUAJR+s=;
 b=YpId+TzaKj348CBnyVIx8X9vB8tsX5h9orYLTcGYMxp8wJiDZ2XgIQugT4oSnI75F2lc9W
 XTmX/LVF7x4gBuTrllT2Fpss9httErXNe5eC/TUALyDfIc1l3xTnfmLfKl4IGbMMv6FgSL
 vWMfEhReOwxTLy2GX05G+ZMje5PuGP0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-ShLC6tWFPOStPgKhAeLXSg-1; Tue,
 27 Jan 2026 09:48:08 -0500
X-MC-Unique: ShLC6tWFPOStPgKhAeLXSg-1
X-Mimecast-MFC-AGG-ID: ShLC6tWFPOStPgKhAeLXSg_1769525287
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 170001955D80; Tue, 27 Jan 2026 14:48:06 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.228])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91B330002D1; Tue, 27 Jan 2026 14:48:00 +0000 (UTC)
Date: Tue, 27 Jan 2026 14:47:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Faria <afaria@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Qing Wang <qinwang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 4/5] scsi: save/load SCSI reservation state
Message-ID: <aXjQHRZlrNt_BLSA@redhat.com>
References: <20260126194735.46167-1-stefanha@redhat.com>
 <20260126194735.46167-5-stefanha@redhat.com>
 <aXfHu-NsoFpBbXRL@redhat.com> <20260126221343.GA51466@fedora>
 <aXh9QKV68zIrLdLs@redhat.com> <20260127144159.GA69685@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127144159.GA69685@fedora>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 27, 2026 at 09:41:59AM -0500, Stefan Hajnoczi wrote:
> On Tue, Jan 27, 2026 at 08:54:24AM +0000, Daniel P. Berrangé wrote:
> > On Mon, Jan 26, 2026 at 05:13:43PM -0500, Stefan Hajnoczi wrote:
> > > On Mon, Jan 26, 2026 at 07:59:55PM +0000, Daniel P. Berrangé wrote:
> > > > On Mon, Jan 26, 2026 at 02:47:34PM -0500, Stefan Hajnoczi wrote:
> > > > > Add a vmstate subsection to SCSIDiskState so that scsi-block devices can
> > > > > transfer their reservation state during live migration. Upon loading the
> > > > > subsection, the destination QEMU invokes the PERSISTENT RESERVE OUT
> > > > > command's PREEMPT service action to atomically move the reservation from
> > > > > the source I_T nexus to the destination I_T nexus. This results in
> > > > > transparent live migration of SCSI reservations.
> > > > > 
> > > > > This approach is incomplete since SCSI reservations are cooperative and
> > > > > other hosts could interfere. Neither the source QEMU nor the destination
> > > > > QEMU are aware of changes made by other hosts. The assumption is that
> > > > > reservation is not taken over by a third host without cooperation from
> > > > > the source host.
> > > > > 
> > > > > I considered adding the vmstate subsection to SCSIDevice instead of
> > > > > SCSIDiskState, since reservations are part of the SCSI Primary Commands
> > > > > that other devices apart from disks could support. However, due to
> > > > > fragility of migrating reservations, we will probably limit support to
> > > > > scsi-block and maybe scsi-disk in the future. In the end, I think it
> > > > > makes sense to place this within scsi-disk.c.
> > > > > 
> > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > ---
> > > > >  include/hw/scsi/scsi.h |  1 +
> > > > >  hw/core/machine.c      |  4 ++-
> > > > >  hw/scsi/scsi-disk.c    | 81 ++++++++++++++++++++++++++++++++++++++++-
> > > > >  hw/scsi/scsi-generic.c | 82 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  hw/scsi/trace-events   |  1 +
> > > > >  5 files changed, 167 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > > > > index c5ec58089b..a3e246dbd9 100644
> > > > > --- a/include/hw/scsi/scsi.h
> > > > > +++ b/include/hw/scsi/scsi.h
> > > > > @@ -253,6 +253,7 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int target, int lun);
> > > > >  
> > > > >  /* scsi-generic.c. */
> > > > >  extern const SCSIReqOps scsi_generic_req_ops;
> > > > > +bool scsi_generic_pr_state_preempt(SCSIDevice *s, Error **errp);
> > > > >  
> > > > >  /* scsi-disk.c */
> > > > >  #define SCSI_DISK_QUIRK_MODE_PAGE_APPLE_VENDOR             0
> > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > index 6411e68856..16134f8ce5 100644
> > > > > --- a/hw/core/machine.c
> > > > > +++ b/hw/core/machine.c
> > > > > @@ -38,7 +38,9 @@
> > > > >  #include "hw/acpi/generic_event_device.h"
> > > > >  #include "qemu/audio.h"
> > > > >  
> > > > > -GlobalProperty hw_compat_10_2[] = {};
> > > > > +GlobalProperty hw_compat_10_2[] = {
> > > > > +    { "scsi-block", "migrate-pr", "off" },
> > > > > +};
> > > > >  const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
> > > > >  
> > > > >  GlobalProperty hw_compat_10_1[] = {
> > > > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > > > index 76fe5f085b..8845ab1192 100644
> > > > > --- a/hw/scsi/scsi-disk.c
> > > > > +++ b/hw/scsi/scsi-disk.c
> > > > > @@ -28,6 +28,7 @@
> > > > >  #include "qemu/hw-version.h"
> > > > >  #include "qemu/memalign.h"
> > > > >  #include "hw/scsi/scsi.h"
> > > > > +#include "migration/misc.h"
> > > > >  #include "migration/qemu-file-types.h"
> > > > >  #include "migration/vmstate.h"
> > > > >  #include "hw/scsi/emulation.h"
> > > > > @@ -122,6 +123,7 @@ struct SCSIDiskState {
> > > > >       */
> > > > >      uint16_t rotation_rate;
> > > > >      bool migrate_emulated_scsi_request;
> > > > > +    NotifierWithReturn migration_notifier;
> > > > >  };
> > > > >  
> > > > >  static void scsi_free_request(SCSIRequest *req)
> > > > > @@ -2737,6 +2739,25 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
> > > > >  }
> > > > >  
> > > > >  #ifdef __linux__
> > > > > +/*
> > > > > + * Preempt on the SCSI Persistent Reservation on the source when migration
> > > > > + * fails because the destination may have already preempted and we need to get
> > > > > + * the reservation back.
> > > > > + */
> > > > > +static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
> > > > > +                                         MigrationEvent *e, Error **errp)
> > > > > +{
> > > > > +    if (e->type == MIG_EVENT_PRECOPY_FAILED) {
> > > > > +        SCSIDiskState *s =
> > > > > +            container_of(notifier, SCSIDiskState, migration_notifier);
> > > > > +        SCSIDevice *d = &s->qdev;
> > > > > +
> > > > > +        /* MIG_EVENT_PRECOPY_FAILED cannot fail, so ignore errors */
> > > > > +        scsi_generic_pr_state_preempt(d, NULL);
> > > > 
> > > > I feel like we ought to 'warn_report'  any errors related to failing
> > > > to acquire persistent reservations.
> > > > 
> > > > In the unlikely event an error occurs, whomever has to deal with
> > > > the resulting support ticket will want to know something went wrong
> > > > from the QEMU logs.
> > > 
> > > Good idea.
> > > 
> > > I'm also not sure how to best approach logging in general. Usually QEMU
> > > does little logging when the VM is running, but it has become
> > > increasingly difficult to get information out of QEMU via tracing or
> > > monitor commands since nowadays QEMU might be running in a locked down
> > > container. Debugging PR migration issues would be easiest if the trace
> > > events introduced in this series were actually printfs to stderr, but
> > > that's not traditionally how QEMU did things.
> > 
> > I wouldn't overthink this - just pass a locall "Error *err" object
> > instead of NULL, and then warn_report_err on the result. Just needs
> > to be a marker in the that something has gone wrong, which we could
> > not propagate to the mgmt app in the normal manner since we have no
> > error path here.
> 
> Yes, sounds good.
> 
> > 
> > Debugging /anything/ in QEMU is easiest if the trace events were
> > actually prints, but that thinking leads to us enabling tracing
> > all the time, everywhere which is impractical
> > 
> > At the same time it is common for apps to have some level of
> > "always on" debugging collected and so we perhaps do have a
> > general conceptual gap in QEMU.
> > 
> > If we thinking of trace events as being equiv to "DEBUG" level
> > log events, would it help if we could annotate a subset of
> > trace events as "INFO" level and do something with them by
> > default. eg perhaps we have an ring buffer tracing target that
> > collects "INFO" events continuously and can be asked to dump
> > out its state in error scenarios ?
> 
> I need to research SystemTap inside container scenarios more first.
> Ideally we could rely on the DTrace probes, but it needs to be easy for
> users to collect information from their containers. I suspect there will
> be permission problems as well as multiple steps required to just find
> the container where QEMU is running, which makes this hard for users.

Agreed, I'd expect to use systemtap with a containerized QEMU would
generally involve an account outside the container on the host OS.
While it might be possible to open up the kernel / seccomp perms
in just the right way to get things working inside the container,
that's unlikely to be permitted in any public cloud solution, and
probably also blocked in many other places. I think this pushes
towards the need for a more traditional "logging" like facility.

We do have the "log" backend already of course but not neccessarily
enabled by distros, but that's something they need to consider.

An always-on ring buffer would be more like a "flight recorder"
scenario to reduce the overheads compared to actually logging to
disk / external service until a failure scenario arrives.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


