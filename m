Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746F5CCD1AB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 11:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCFxQ-0001U7-1Q; Fri, 24 Oct 2025 07:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCFxK-0001Tf-3n
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:27:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCFxG-0003ZF-Lm
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 07:27:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761305252;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XseWFTip55d81N5cRWV84qEQeXCezeJaBKMQXKmPQtE=;
 b=BysD2fSqQNXCN0izT1wtJ15y268sCH2CWheHq9+qKzkLO98EYC6h3OE2pxLvqcBtALGmoP
 0Ka7gRHfzCw+nVNxLRou/T5xfc6KCjKNstIDWB7QeS4xH8uOpKqH4XEOHBK84ePbOrSKw9
 t1RLtdQxKB5u3ZUGFuONzSJ+Q0JObNA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-cuqsoXAsMm-UMxu6vS7cbg-1; Fri,
 24 Oct 2025 07:27:31 -0400
X-MC-Unique: cuqsoXAsMm-UMxu6vS7cbg-1
X-Mimecast-MFC-AGG-ID: cuqsoXAsMm-UMxu6vS7cbg_1761305250
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ED38196F748; Fri, 24 Oct 2025 11:27:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5982730002D7; Fri, 24 Oct 2025 11:27:26 +0000 (UTC)
Date: Fri, 24 Oct 2025 12:27:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
Message-ID: <aPtim8ZACUWyje2o@redhat.com>
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6pw1rfn.fsf@pond.sub.org>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Oct 24, 2025 at 01:15:40PM +0200, Markus Armbruster wrote:
> Bin Guo <guobin@linux.alibaba.com> writes:
> 
> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> > ---
> >  hw/intc/arm_gicv3_kvm.c | 1 -
> >  target/i386/sev.c       | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> > index 66b0dddfd4..6f311e37ef 100644
> > --- a/hw/intc/arm_gicv3_kvm.c
> > +++ b/hw/intc/arm_gicv3_kvm.c
> > @@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
> >          error_setg(&kvm_nv_migration_blocker,
> >                     "Live migration disabled because KVM nested virt is enabled");
> >          if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
> > -            error_free(kvm_nv_migration_blocker);
> >              return;
> >          }
> >  
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index 1057b8ab2c..fd2dada013 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
> >      ret = migrate_add_blocker(&sev_mig_blocker, &local_err);
> >      if (local_err) {
> >          error_report_err(local_err);
> > -        error_free(sev_mig_blocker);
> >          exit(1);
> >      }
> >  }
> 
> Does this fix use-after-free bugs?

I don't think so, because when migrate_add_blocker() returns error,
the Error for the blocker will have been propagated into the errp
parameter, and then set to NULL. So these two error_free calls
should be a no-op.

But wow, the migrate_add_blocker API design is unpleasant with its
pair of "Error **" parameters - it is practically designed to
maximise confusion & surprise.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


