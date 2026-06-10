Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46819CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 08:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXEXZ-0005MF-76; Wed, 10 Jun 2026 04:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXEXX-0005Lt-Vk
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXEXW-0007V1-3S
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 04:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781081036;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMt/QVjb5NyMsvp+m0iq9oMiT2XM1F8pJBZRExXkZHE=;
 b=Sg/YdrUdXMRekvzUm4cEYZuC1PnrP4fXUCmZzlPhKPMpieSeqtfd5PH5+mtJz5qL3Swyhm
 Wn28STp2JOKEUInqGpmVTYMQfP+NJE2gKkPVfpHWu0Yh9cYAsrwrbhYltJo5N/2wopZ+le
 rhLOlFT+hs7UeMTNnceVLpNhtEoTnLo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-xDJd0PWjPcaYF9Mubfz_RA-1; Wed,
 10 Jun 2026 04:43:50 -0400
X-MC-Unique: xDJd0PWjPcaYF9Mubfz_RA-1
X-Mimecast-MFC-AGG-ID: xDJd0PWjPcaYF9Mubfz_RA_1781081028
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37AB7195608A; Wed, 10 Jun 2026 08:43:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D44C1800367; Wed, 10 Jun 2026 08:43:42 +0000 (UTC)
Date: Wed, 10 Jun 2026 09:43:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>,
 Kim Phillips <kim.phillips@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 2/9] target/i386: SEV: Ensure SEV features are only
 set through qemu cli or IGVM
Message-ID: <aikju95Eacl5KWAv@redhat.com>
References: <cover.1779281646.git.naveen@kernel.org>
 <6939de99f13d7170af68b74e711eb9f03f32f682.1779281646.git.naveen@kernel.org>
 <aifZY1h55L4jxGeO@redhat.com> <aikYQ3HW52rWMAAC@blrnaveerao1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aikYQ3HW52rWMAAC@blrnaveerao1>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Jun 10, 2026 at 01:43:52PM +0530, Naveen N Rao wrote:
> Hi Daniel,
> 
> On Tue, Jun 09, 2026 at 10:14:11AM +0100, Daniel P. Berrangé wrote:
> > On Wed, May 20, 2026 at 06:57:55PM +0530, Naveen N Rao (AMD) wrote:
> > > In preparation for qemu being able to set SEV features through the cli,
> > > add a check to ensure that SEV features are not also set if using IGVM
> > > files.
> > > 
> > > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > > Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> > > ---
> > >  target/i386/sev.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > > index 22c350fe14b7..641a295c42b7 100644
> > > --- a/target/i386/sev.c
> > > +++ b/target/i386/sev.c
> > > @@ -1908,6 +1908,16 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
> > >           * as SEV_STATE_UNINIT.
> > >           */
> > >          if (x86machine->igvm) {
> > > +            /*
> > > +             * Test only the user-set SEV features by masking out
> > > +             * SVM_SEV_FEAT_SNP_ACTIVE which is set by default.
> > > +             */
> > > +            if (sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE) {
> > > +                error_setg(errp,
> > > +                           "%s: SEV features can't be specified when using IGVM files",
> > > +                           __func__);
> > 
> > IMHO, including __func__ in error messages is redundant / undesirable.
> > The error msg  alone should be sufficient to diagnose problems.
> 
> Understood. Markus had a similar concern, though this is just following 
> the pattern in other messages in this function.
> 
> In fact, I checked and there are 40-odd uses of __func__ in 
> target/i386/sev.c, so this looks to be a common pattern used for SEV.  I 
> can submit a separate cleanup patch (independent of this series) if you 
> think we should make this change throughout.

If you want to do it a separate cleanup of __func__ in sev.c later
that's fine with me.

> > Perhaps we should include the actual feature values though
> > 
> >                            "SEV features 0x%x can't be specified when using IGVM files",
> >                            sev_common->sev_features & ~SVM_SEV_FEAT_SNP_ACTIVE);
> > 
> > this case, however, you should report which features are not permitted
> 
> Sure, I can incorporate your suggested change above unless you wanted 
> the individual SEV features to be called out/named?

Naming them individually is probably overkill for a scenario that
should hopefully be rare.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


