Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF6CE7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 10:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLggS-00010O-5y; Thu, 12 Dec 2024 05:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLggQ-0000z4-Cg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:44:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tLggO-0003xP-Qt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734000276;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dcgtjfCJpDdDbCSyBT6hHdmEEgYsRQZlBdZakRzbIfc=;
 b=Ln3ONx+NL2kafqGSxG2J8R/dXO34WbbEzkJ8gemXu0OpkGznC/ALvkf7fjrLx8kO751+po
 JmFnkFHb03HL0ReqTeT6fq+v1UEcp2JvsMY0wFRpsxA1xG2jKqTZntJwL/Y6S9moxYgtLI
 fRpeFzq0OdlhVwPZLTxcEIx9pj37uro=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-whlzZLkeMieTyNZGvziX4g-1; Thu,
 12 Dec 2024 05:44:35 -0500
X-MC-Unique: whlzZLkeMieTyNZGvziX4g-1
X-Mimecast-MFC-AGG-ID: whlzZLkeMieTyNZGvziX4g
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D33FB19560A5; Thu, 12 Dec 2024 10:44:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44A73195605A; Thu, 12 Dec 2024 10:44:31 +0000 (UTC)
Date: Thu, 12 Dec 2024 10:44:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: Re: [PATCH v2 23/31] tests/functional: convert tests to new
 archive_extract helper
Message-ID: <Z1q-jI4uEE4gx5qT@redhat.com>
References: <20241211172648.2893097-1-berrange@redhat.com>
 <20241211172648.2893097-24-berrange@redhat.com>
 <aa64a0d8-7285-4f75-9618-e31d0222c30f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aa64a0d8-7285-4f75-9618-e31d0222c30f@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Thu, Dec 12, 2024 at 11:34:19AM +0100, Thomas Huth wrote:
> On 11/12/2024 18.26, Daniel P. Berrangé wrote:
> > Replace use of utils.archive_extract and extract_from_deb with the
> > new archive_extract helper.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> ...
> > diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
> > index 8f2810f3af..155855541f 100644
> > --- a/tests/functional/qemu_test/linuxkernel.py
> > +++ b/tests/functional/qemu_test/linuxkernel.py
> > @@ -3,11 +3,9 @@
> >   # This work is licensed under the terms of the GNU GPL, version 2 or
> >   # later.  See the COPYING file in the top-level directory.
> > -import os
> > -
> >   from .testcase import QemuSystemTest
> >   from .cmd import wait_for_console_pattern
> > -from .archive import deb_extract
> > +
> >   class LinuxKernelTest(QemuSystemTest):
> 
> Cosmetical nit: Two empty lines should be enough, no reason to add a third one.

Yes, I was aiming to fixup to two lines where I touched code, since that
is what python linters would want us to have.

> 
> Apart from that:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


