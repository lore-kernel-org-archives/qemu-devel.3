Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B65CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNocT-0002j5-ES; Fri, 15 May 2026 05:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNocQ-0002iu-So
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wNocL-0005O7-De
 for qemu-devel@nongnu.org; Fri, 15 May 2026 05:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778836440;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CtKYIYsK8VaSzILsKrTP63FekmBBQUnrknd7DcxyayQ=;
 b=i1xieDvF/zKdwKfBo6inZyHPOfqwDBokkhwHSzpaiYY465TQ2F5ONFkitM8yoPB7isgHvc
 QP0sUICcUW4sy0o38Evcxq9STF9yQkMwlW05Kemx46nIq1d3si7RkwMP4FGtQE0qek2y/B
 Jdb8SLSZWZpt3PE0LAFtG85wcWdznCI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-yWyLMxmsNceJL0SMINFH6g-1; Fri,
 15 May 2026 05:13:58 -0400
X-MC-Unique: yWyLMxmsNceJL0SMINFH6g-1
X-Mimecast-MFC-AGG-ID: yWyLMxmsNceJL0SMINFH6g_1778836437
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F33731956094; Fri, 15 May 2026 09:13:56 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.124])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89EDC1955F2D; Fri, 15 May 2026 09:13:55 +0000 (UTC)
Date: Fri, 15 May 2026 10:13:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: Limit USB 1.0 (UHCI/OCHI) and 2.0 (EHCI) to non-virt use cases
Message-ID: <agbjz1e5I6CvS8sS@redhat.com>
References: <agRC56rkfb4z6zSO@redhat.com>
 <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9_Xmy8FukkMDGVzU8LvE9giSp9zgrpiGvbxn=wNjJp-g@mail.gmail.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 15, 2026 at 08:49:24AM +0100, Peter Maydell wrote:
> On Wed, 13 May 2026 at 10:23, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > QEMU has implemented four generic USB controllers
> >
> >  * UHCI - USB 1.0 only
> >  * OHCI - USB 1.0 only
> >  * EHCI - USB 2.0 only (must have UHCI companions for 1.0 compat)
> >  * XHCI - All of USB 3.0, 2.0, 1.0 in one controller
> 
> > Thus to reduce our maint burden around security bug handling, it is
> > proposed henceforth to classify UHCI, OHCI and EHCI under the non-
> > virtualization use case and thus be excluded from security bug triage
> > processes. No CVEs would be assigned, bugs would be reported publically
> > in gitlab:
> 
> > The XHCI controller (specifically the hcd-xhci.c variant) would remain
> > as our only option for the virtualization use case, with security process
> > applied to bugs & eligible for CVE assignment:
> 
> I support this; I don't think there's any reason to use anything
> except XHCI in a modern VM, and the others are useful now
> largely in the emulation and retrocomputing areas.
> 
> I guess my question is how we communicate this to users, and
> whether there's some sort of timescale or if it's just
> "effective immediately". If we're fairly confident nobody's
> really using the old controllers in production then I guess
> we can just commit the policy update to security.rst and
> that then appears on the website ?

I'm intending to update this series real soon:

  https://lists.gnu.org/archive/html/qemu-devel/2025-09/msg05781.html

We could also make this more explicit in the USB docs

  https://www.qemu.org/docs/master/system/devices/usb.html


Since sending this mail, I realized that while (AFAIK) all apps are
using XHCI for provisioning new guests, RHEL still ships UCHI/EHCI
drivers. IOW from Red Hat's POV, we still need security bug coverage
for these devices, even if they're discouraged upstream. I'm trying
to see if we can get someone to take up maintainership, even if just
on an odd fixes basis, as without a maintainer I don't think it is
reasonable to expect upstream to promise any kind of security bug
support.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


