Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998B5FD2D81
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzx8L-0001wY-W3; Tue, 10 Mar 2026 09:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzx8K-0001w0-Gd
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzx8H-0007LZ-Jr
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773149300;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4+ChmXtU7qut63MZnUfzM6oclWjnFWgdkH9qHLj+PFI=;
 b=QZy6Nz4c/y9vUUUN7+JgrJE9GMFgcJqOdIi2c7SI51RJV7iI5pA70OpFt6Ofg4YltJyR8p
 mA3XeMmQmQbtBad3UJBvFPe4BSY6KbynclPLrOtwE7Ix7b9Iup/L3Qw4VcglXfyduj2Mhm
 ntB+C9c5M/BwGTRXdkw8VS5l6peA1Fs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-cXOamq5tP16zUwbXgI9BAQ-1; Tue,
 10 Mar 2026 09:28:17 -0400
X-MC-Unique: cXOamq5tP16zUwbXgI9BAQ-1
X-Mimecast-MFC-AGG-ID: cXOamq5tP16zUwbXgI9BAQ_1773149296
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C1E195605C; Tue, 10 Mar 2026 13:28:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.213])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FD7E19560A6; Tue, 10 Mar 2026 13:28:12 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:28:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 17/32] accel: mark kvm, xen & hvf as secure; tcg &
 qtest as insecure
Message-ID: <abAcaahy_FsBonZ7@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-18-berrange@redhat.com>
 <daec1668-d4a2-4aca-829d-250779b6efe1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <daec1668-d4a2-4aca-829d-250779b6efe1@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 10, 2026 at 02:09:45PM +0100, Philippe Mathieu-Daudé wrote:
> On 26/9/25 16:01, Daniel P. Berrangé wrote:
> > TCG is too complex to be considered to provide a security boundary
> > for malicious guest workloads. QTest is only used for functional
> > testing and thus is not relevant to mark secure.
> > 
> > KVM, HVF and Xen, meanwhile are all servicing virtualization use
> > cases which must provide security.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   accel/accel-common.c      | 1 +
> >   accel/accel-system.c      | 1 +
> >   accel/accel-target.c      | 1 +
> >   accel/hvf/hvf-accel-ops.c | 1 +
> >   accel/hvf/hvf-all.c       | 1 +
> >   accel/kvm/kvm-accel-ops.c | 1 +
> >   accel/kvm/kvm-all.c       | 1 +
> >   accel/qtest/qtest.c       | 2 ++
> >   accel/tcg/tcg-accel-ops.c | 1 +
> >   accel/tcg/tcg-all.c       | 1 +
> >   accel/xen/xen-all.c       | 2 ++
> >   11 files changed, 13 insertions(+)
> 
> 
> > diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> > index 8b794c2d41..e807103379 100644
> > --- a/accel/hvf/hvf-accel-ops.c
> > +++ b/accel/hvf/hvf-accel-ops.c
> > @@ -397,6 +397,7 @@ static const TypeInfo hvf_accel_ops_type = {
> >       .parent = TYPE_ACCEL_OPS,
> >       .class_init = hvf_accel_ops_class_init,
> >       .abstract = true,
> > +    .secure = true,
> 
> IMHO an accelerator must be at least "supported" (in the MAINTAINERS
> definition, "Someone is actually paid to look after this") to declare
> it secure.

Sounds reasonable to me.

> So far HVF is not, and the current developers interacting with it
> don't seem to have time to cary such burden / responsibility.

Ok.

> >   };
> >   static void hvf_accel_ops_register_types(void)
> > diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> > index 0a4b498e83..1d49a59053 100644
> > --- a/accel/hvf/hvf-all.c
> > +++ b/accel/hvf/hvf-all.c
> > @@ -304,6 +304,7 @@ static const TypeInfo hvf_accel_type = {
> >       .parent = TYPE_ACCEL,
> >       .instance_size = sizeof(HVFState),
> >       .class_init = hvf_accel_class_init,
> > +    .secure = true,
> >   };
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


