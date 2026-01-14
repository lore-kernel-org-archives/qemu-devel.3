Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B244CD37E33
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18k-0007tN-7H; Wed, 14 Jan 2026 08:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg18i-0007sj-OX
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg18h-0006iU-4f
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768398141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AMRCv75HNbXpFQErk1zJDDifYJTryGXBsLJZVDeC/8M=;
 b=jOQ3xHlcrfuHWNwGErI0QSWYku5I+v0IaoPT51Lb9gYPLZmIQKAXPdQBsOzsngpoCx90yh
 kvYKeQqnKHEr0JIRawzrvt6P29hgUYu01B5OSRI5ojQWa1EjFlDyB6nUdG7mPp8nhgSU3M
 jPfLsmP2SND64PVdJWa8YfEV3bktdSI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-s3X1erIJPgqaue7rK9_ROA-1; Wed,
 14 Jan 2026 08:42:20 -0500
X-MC-Unique: s3X1erIJPgqaue7rK9_ROA-1
X-Mimecast-MFC-AGG-ID: s3X1erIJPgqaue7rK9_ROA_1768398139
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 757CD1956096; Wed, 14 Jan 2026 13:42:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5242A19560A2; Wed, 14 Jan 2026 13:42:17 +0000 (UTC)
Date: Wed, 14 Jan 2026 13:42:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 23/32] hw/hyperv/vmbus: add support for confidential
 guest reset
Message-ID: <aWedNoIHcSJfTm4Z@redhat.com>
References: <20260112132259.76855-1-anisinha@redhat.com>
 <20260112132259.76855-24-anisinha@redhat.com>
 <cbfdd456-76c9-4280-8d58-b5a2d38b3900@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cbfdd456-76c9-4280-8d58-b5a2d38b3900@maciej.szmigiero.name>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Jan 14, 2026 at 02:38:54PM +0100, Maciej S. Szmigiero wrote:
> On 12.01.2026 14:22, Ani Sinha wrote:
> > On confidential guests when the KVM virtual machine file descriptor changes as
> > a part of the reset process, event file descriptors needs to be reassociated
> > with the new KVM VM file descriptor. This is achieved with the help of a
> > callback handler that gets called when KVM VM file descriptor changes during
> > the confidential guest reset process.
> > 
> > This patch is untested on confidential guests and only exists for completeness.
> > 
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> >   hw/hyperv/vmbus.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> 
> Quick question: is this patch set targeting QEMU 11.0 or which version?

Patches are always assumed to be targetting current git master unless
the cover letter / subject line explicity says otherwise.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


