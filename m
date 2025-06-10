Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87585C71130
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP28k-00057a-Su; Tue, 10 Jun 2025 12:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP1LO-0001Q2-QC
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uP1LJ-0008Bk-8C
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 11:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749571011;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMhPAuXRHNwaFwWidIKGtMPeUCkcvA0svjUZfXoeofo=;
 b=BPOi0Si5uZlyy+8pVIBXi5gOeIJpHb0rVw3hyQAFvCLDm4dJFrs1RSJqNNmW8AY2BA0sc9
 N57+RAnUylx9za0MnsuJceNVhcwUsUYjQ1TmU6iqBRPlskcbVUjAokGBVe6jGVfVsMOwq2
 WpVe9DV6u2Ja1zT2a+bMXA3kKfqRWx8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-eiwta7BMMu6GtLFiepudcA-1; Tue,
 10 Jun 2025 11:56:43 -0400
X-MC-Unique: eiwta7BMMu6GtLFiepudcA-1
X-Mimecast-MFC-AGG-ID: eiwta7BMMu6GtLFiepudcA_1749570997
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CAE319560B2; Tue, 10 Jun 2025 15:56:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.87])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E682219560B2; Tue, 10 Jun 2025 15:56:32 +0000 (UTC)
Date: Tue, 10 Jun 2025 16:56:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 00/31] Skip automatic zero-init of large arrays / structs
 in I/O paths
Message-ID: <aEhVrceTYtLlqe84@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
 <50405e77-e665-4772-9715-3901730d00fd@linaro.org>
 <aEgri00LXfeRQRJ2@redhat.com>
 <4d03fe23-86a1-4030-b5fc-8de8be461770@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d03fe23-86a1-4030-b5fc-8de8be461770@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 10, 2025 at 05:00:43PM +0200, Philippe Mathieu-Daudé wrote:
> On 10/6/25 14:56, Daniel P. Berrangé wrote:
> > On Tue, Jun 10, 2025 at 02:49:02PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 10/6/25 14:36, Daniel P. Berrangé wrote:
> > > > This series is an extension of Stefan's proposal:
> > > > 
> > > >     https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg00736.html
> > > > 
> > > > It used '-Wframe-larger-than=4096' to identify all code locations
> > > > with more than 4k on the stack. Any locations in the I/O paths
> > > > were chosen to avoid automatic zero-init, to eliminate the performance
> > > > overhead of the automatic initialization.
> > > 
> > > Should we eventually add it to our default CFLAGS?
> > 
> > You mean as a way to impose a hard limit on stack frame size ?
> 
> Yes, we could use -Wframe-larger-than=50000 for this release, then
> aim to reduce by 5/10k every release until some reasonable limit...

I guess the key thing is to define approximately what our target
should be ?

There are some large stack frames in QEMU device I/O paths that are
not unreasonable to have, because they avoid need to malloc in the
I/O path. A greater many devices have 4/8k buffers for copying
data around, and some bigger ones are fairly valid to have too.

On the flip side there's still way too much use of PATH_MAX that
is gratuitous and should be removed, but its hard to enforce the
latter without negatively impacting the former.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


