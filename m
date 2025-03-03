Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A51C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 16:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp91s-00066e-UD; Mon, 03 Mar 2025 11:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tp91k-0005v4-RY
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tp91g-00045I-NT
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 11:52:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741020732;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cdo6Bxbn64bN0AU6kbFdcdsRRWd0KXbA+tBS82Hgx0s=;
 b=f1yE48hPdECi5GuA7bFYlwS5uzHBbhQEbxwKlFG/PQzBSRqE1HIRf79hjq9cL8GB3T/03K
 kvTjgafkpguBNFN20cRC6jxPZRBWX2UAaKTcPyU0W5R6VVYwRALjvgUMf2iXY5ee8JRBCy
 5i4edIPesphj9p5SIlgWtOU0Sf0CDIc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-o_nI3AaHNYSqVAZM-lPhPA-1; Mon,
 03 Mar 2025 11:52:09 -0500
X-MC-Unique: o_nI3AaHNYSqVAZM-lPhPA-1
X-Mimecast-MFC-AGG-ID: o_nI3AaHNYSqVAZM-lPhPA_1741020727
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C53451954B20; Mon,  3 Mar 2025 16:52:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D430180035E; Mon,  3 Mar 2025 16:52:03 +0000 (UTC)
Date: Mon, 3 Mar 2025 16:51:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 1/2] vfio: Make vfio-pci available on 64-bit host
 platforms only
Message-ID: <Z8XeLwi9mFJixx-8@redhat.com>
References: <20250226084721.232703-1-clg@redhat.com>
 <20250226084721.232703-2-clg@redhat.com>
 <a39e97c2-c6fd-34e4-f91b-b3491185b789@eik.bme.hu>
 <c60b7780-5b3f-43a0-a7f1-30820d4e6fb8@redhat.com>
 <7982159d-710f-4948-830f-ab61b100a5d6@redhat.com>
 <a19520bf-9e0a-4a63-bc31-06b63e23c3d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a19520bf-9e0a-4a63-bc31-06b63e23c3d3@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 03, 2025 at 03:53:29PM +0100, Philippe Mathieu-Daudé wrote:
> On 3/3/25 15:43, Paolo Bonzini wrote:
> > On 2/26/25 17:26, Cédric Le Goater wrote:
> > > On 2/26/25 15:12, BALATON Zoltan wrote:
> > > > On Wed, 26 Feb 2025, Cédric Le Goater wrote:
> > > > > VFIO PCI never worked on PPC32 nor ARM, S390x is 64-bit, it might have
> > > > > worked on i386 long ago but we have no plans to further support VFIO
> > > > > on any 32-bit host platforms. Restrict to 64-bit host platforms.
> > > > > 
> > > > > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > > > > Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> > > > > Cc: Eric Farman <farman@linux.ibm.com>
> > > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > > Signed-off-by: Cédric Le Goater <clg@redhat.com>
> > > > > ---
> > > > > hw/vfio/Kconfig | 2 +-
> > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/hw/vfio/Kconfig b/hw/vfio/Kconfig
> > > > > index 7cdba0560aa821c88d3420b36f86020575834202..6ed825429a9151fcdff33e95d1a310210689b258
> > > > > 100644
> > > > > --- a/hw/vfio/Kconfig
> > > > > +++ b/hw/vfio/Kconfig
> > > > > @@ -7,7 +7,7 @@ config VFIO_PCI
> > > > >     default y
> > > > >     select VFIO
> > > > >     select EDID
> > > > > -    depends on LINUX && PCI
> > > > > +    depends on LINUX && PCI && (AARCH64 || PPC64 || X86_64 || S390X)
> > > > 
> > > > Are these defined for the host or target?
> > > 
> > > host.
> > 
> > No, Zoltan is correct.  They are defined for the target,
> 
> Oops indeed, not my day.
> 
> > so if you build for 32-bit ARM you'd still get things with "depends on
> > AARCH64" in qemu- system-aarch64.  You can check that you have
> > 
> > config SBSA_REF
> >      bool
> >      default y
> >      depends on TCG && AARCH64
> > 
> > but on x86-64:
> > 
> > $ qemu-system-aarch64 -M help|grep sbsa
> > sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
> > 
> > 
> > > As per commit 6d701c9bac1d3571e9ad511e01b27df7237f0b13 "meson: Deprecate
> > > 32-bit host support", support will be fully removed in 2 releases and
> > > it doesn't need to be addressed by VFIO.
> > 
> > Note that a deprecation *allows* full removal in 2 releases.  We have a
> > lot of things that are deprecated but have not been removed.  For
> > example
> > 
> >     Short-form boolean options (since 6.0)
> >     ''''''''''''''''''''''''''''''''''''''
> > 
> >     Boolean options such as ``share=on``/``share=off`` could be written
> >     in short form as ``share`` and ``noshare``.  This is now deprecated
> >     and will cause a warning.
> > 
> > is deprecated to *allow* switching command-line options from the "qemu-
> > options" parser to the "keyval" parser that doesn't support short-form
> > boolean options, but it's unlikely that qemu-options will drop support
> > for short-form boolean options.
> 
> In another thread Daniel said deprecated options shall be removed, the
> only justification for delay being man power, IIRC.

Right, after 2 releases a deprecated thing is open to deletion.

Deleting still requires someone to do the work though, so we end up with
things living longer than the 2 release deprecation period until someone
with motivation comes along to do the deletion. 

If we change our mind & truly don't want to delete something, then the
deprecation notice is supposed to be removed, not left around forever.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


