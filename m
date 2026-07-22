Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B943C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWcy-0002LK-56; Wed, 22 Jul 2026 09:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmWcs-0002G2-O3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmWcp-0005sP-Fg
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784725478;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gDylmEcv0VIKUXdb/4kLIAKCNnbiAzPEvpCFp0zwgA=;
 b=PnsbnEwCG3mVFXxoLY6aKjObVrlyUalCHgQXdZtNAn+fVcQjabmRau+9JSAJNWG3h3Wrgb
 MfZ58JoyCvh8snISWY5xpwYQeiZUQ95ex0Z9izke1BeeiML2SAedIpl4fS/kimjl4MUMZB
 YbeLb5LVujIAf/k/bgD4qeAFYjs7sCg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-CjZxZXv_PlW_2fYs0Zu8sw-1; Wed,
 22 Jul 2026 09:04:34 -0400
X-MC-Unique: CjZxZXv_PlW_2fYs0Zu8sw-1
X-Mimecast-MFC-AGG-ID: CjZxZXv_PlW_2fYs0Zu8sw_1784725473
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53E3018002DE; Wed, 22 Jul 2026 13:04:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.82])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8671930040BE; Wed, 22 Jul 2026 13:04:30 +0000 (UTC)
Date: Wed, 22 Jul 2026 14:04:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 devel@lists.libvirt.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH for 11.1] crypto: deprecate the AF_ALG crypto backend
Message-ID: <amC_22Ax6xTqzyfD@redhat.com>
References: <20260722115701.716516-1-berrange@redhat.com>
 <7421bba8-74d2-4e8f-ad4c-a4c06df1a385@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7421bba8-74d2-4e8f-ad4c-a4c06df1a385@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Jul 22, 2026 at 03:03:16PM +0200, Cédric Le Goater wrote:
> On 7/22/26 13:57, Daniel P. Berrangé via Devel wrote:
> > Linux 7.1 has deprecated the AF_ALG crypto backend:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a67afb1884ba815079bd43d5c998e155e03b08b6
> > 
> > And has documented it to be always slower than userspace crypto:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5624ea54f3ba5c83d2e5503411a31a8be0278c1e
> > 
> > as a result of dropping support for zero-copy and hardware
> > accelerators:
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7524070f26d8d347c26787dc297fb844baa26abf
> >    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ffdd2bc378953b525aca61902534e753f1f8e734
> > 
> > The main use case for the AF_ALG impl was to improve the performance
> > of virtio-crypto with the cryptodev-backend-builtin driver. In
> > practice this did not matter since 'cryptodev-backend-lkcf' can do
> > offload to the kernel via the keyctl syscall, and 'cryptodev-vhost-user'
> > can offload to an external process which can optionally integrate with
> > hardware accelerators without kernel assistance.
> > 
> > The AF_ALG backend has no user visible configuration options at runtime,
> > it is unconditionally tried with any use of the cipher APIs. So it does
> > not strictly have to go through the deprecation process, however, it is
> > left available initially in case there was an unexpected use case that
> > relies on it which may be faster with old kernels before the above Linux
> > commits.
> > 
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   docs/about/deprecated.rst | 21 +++++++++++++++++++++
> >   meson.build               |  6 ++++++
> >   2 files changed, 27 insertions(+)
> > 
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 0c656a968f..54b2662752 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -416,6 +416,27 @@ ABI is long-obsolete. We are therefore deprecating both OABI support
> >   and NWFPE emulation, and they will be removed in a future QEMU
> >   release.
> > +Build features
> > +--------------
> > +
> > +Crypto AF_ALG backend
> > +---------------------
> 
> 
>   Crypto AF_ALG backend (since 11.1)
>   ''''''''''''''''''''''''''''''''''
> 
> ?

Oppps, yes, of course it needs a version :-)

> 
> With that,
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


