Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD068D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:27:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC064-0007Ip-ID; Fri, 15 Nov 2024 12:27:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC05v-00076M-Dt
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tC05t-0001dU-8P
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731691611;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ot7Dr2IBF2Q9/oMfsnzhAlSiXcYHXH2GDgp6wP3SdPM=;
 b=UDNPQ52DdR+740bDqWm/u7x3jYWM29CTjZc7IQrk7GBAA2OFZuIwp2kif4YsF/uP6SV8PG
 tEmUQEp6cpvioqXOR7SB4mOKSaAFxB0VZKcpHw1+dMxwylFqTPcN9eXPTFVmrRjmqY+Scp
 SYFx2VbwKQfc/VVHVAZmML5/UpgpnXc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-cmYzDuC7OSyUsc58X3dJRQ-1; Fri,
 15 Nov 2024 12:26:50 -0500
X-MC-Unique: cmYzDuC7OSyUsc58X3dJRQ-1
X-Mimecast-MFC-AGG-ID: cmYzDuC7OSyUsc58X3dJRQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 384BC1936164
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 17:26:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DFAC3003B71; Fri, 15 Nov 2024 17:26:45 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:26:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 6/8] qom: introduce qdev_new_dynamic()
Message-ID: <ZzeEUgv0npL4IfFn@redhat.com>
References: <20241111155555.90091-1-berrange@redhat.com>
 <20241111155555.90091-7-berrange@redhat.com> <ZzZh2GHJm1L-mq5D@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzZh2GHJm1L-mq5D@x1n>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 14, 2024 at 03:47:20PM -0500, Peter Xu wrote:
> On Mon, Nov 11, 2024 at 03:55:53PM +0000, Daniel P. Berrangé wrote:
> > qdev_new() has a failure scenario where it will assert() if given
> > an abstract type. Callers which are creating qdevs based on user
> > input, or unknown/untrusted type names, must manually check the
> > result of qdev_class_is_abstract() before calling qdev_new()
> > to propagate an Error, instead of asserting.
> > 
> > Introduce a qdev_new_dynamic() method which is a counterpart to
> > qdev_new() that directly returns an Error, instead of asserting.
> > This new method is to be used where the typename is specified
> > dynamically by code separate from the immediate caller.
> > 
> > Do likewise with qdev_try_new_dynamic() as a counterpart to
> > qdev_try_new().
> 
> Since at it, would it make sense to simply replace qdev_try_new() with
> qdev_new_dynamic(), assuming it plays similar role of "it can fail" version
> of qdev_new()?

That is tricky as callers of qdev_try_new have to distinguish between
expected failures and unexpected failures.

That said you made me look at the usage patterns and I concluded these
xxx_try_new() methods are a bad design for other reasons, so I have
simply eliminated them entirely in v3.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


