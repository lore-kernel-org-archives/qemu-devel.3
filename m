Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AA7C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:21:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFJ8-0006t1-Uk; Tue, 08 Jul 2025 16:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZEDK-0007KS-7b
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZEDE-0006BJ-4C
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003762;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=44QR6KoW5uu6n00UV1FZxmx1WzQwzkeNmrceOwrELOQ=;
 b=U2kiPL9O2SxP1GXf6hvJlxrbfy0gT879t7tC47xwX3sqxxg0FQI1iN8ZdO/zG3fin4ubGI
 xlzS6lPm/R7XxSxlLTFnfT8myew8GicgkX7jdvP7igHl1IT5ClEf3T5+TUob8MXBX2zUqO
 3m0Sz+Rrk8EMQOoTTAM+8k9ZM2vS+ac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-n8nm0sg_MLWEYM59jyjrmA-1; Tue,
 08 Jul 2025 11:28:48 -0400
X-MC-Unique: n8nm0sg_MLWEYM59jyjrmA-1
X-Mimecast-MFC-AGG-ID: n8nm0sg_MLWEYM59jyjrmA_1751988527
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCEC218002ED; Tue,  8 Jul 2025 15:28:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6873195608F; Tue,  8 Jul 2025 15:28:39 +0000 (UTC)
Date: Tue, 8 Jul 2025 16:28:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v9 08/16] i386/sev: Refactor setting of reset vector and
 initial CPU state
Message-ID: <aG05JAMHDmfbpg_E@redhat.com>
References: <cover.1751554099.git.roy.hopkins@randomman.co.uk>
 <d3c2debca496c4366a278b135f951908f3b9c341.1751554099.git.roy.hopkins@randomman.co.uk>
 <aG04W_upzY6p7M1H@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aG04W_upzY6p7M1H@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Jul 08, 2025 at 04:25:25PM +0100, Daniel P. Berrangé wrote:
> On Thu, Jul 03, 2025 at 04:31:59PM +0100, Roy Hopkins wrote:
> > When an SEV guest is started, the reset vector and state are
> > extracted from metadata that is contained in the firmware volume.
> > 
> > In preparation for using IGVM to setup the initial CPU state,
> > the code has been refactored to populate vmcb_save_area for each
> > CPU which is then applied during guest startup and CPU reset.
> > 
> > Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> > Acked-by: Gerd Hoffman <kraxel@redhat.com>
> > Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> > ---
> >  target/i386/sev.c | 322 +++++++++++++++++++++++++++++++++++++++++-----
> >  target/i386/sev.h | 110 ++++++++++++++++
> >  2 files changed, 399 insertions(+), 33 deletions(-)
> > 
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index a84f5f5d28..a13f91e615 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> 
> 
> > +static void sev_apply_cpu_context(CPUState *cpu)
> > +{
> > +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> > +    X86CPU *x86;
> > +    CPUX86State *env;
> > +    struct SevLaunchVmsa *launch_vmsa;
> > +
> > +    /* See if an initial VMSA has been provided for this CPU */
> > +    QTAILQ_FOREACH(launch_vmsa, &sev_common->launch_vmsa, next)
> > +    {
> > +        if (cpu->cpu_index == launch_vmsa->cpu_index) {
> > +            x86 = X86_CPU(cpu);
> > +            env = &x86->env;
> > +
> > +            /*
> > +             * Ideally we would provide the VMSA directly to kvm which would
> > +             * ensure that the resulting initial VMSA measurement which is
> > +             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated from
> > +             * exactly what we provide here. Currently this is not possible so
> > +             * we need to copy the parts of the VMSA structure that we currently
> > +             * support into the CPU state.
> > +             */
> 
> Are there any parts of the VMSA described in the IGVM that we are
> unable to handle here ?
> 
> If so, what happens if those parts are set in the IGVM and their
> value doesn't match KVM's default ? Presumably that would become
> a measurement failure ?

Never mind, this is answered by the following patch.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


