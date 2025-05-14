Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F08C3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 09:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF8VB-0003L2-5O; Wed, 14 May 2025 05:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF8VA-0003Js-6e
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:34:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uF8V7-0005MZ-S8
 for qemu-devel@nongnu.org; Wed, 14 May 2025 05:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747215248;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGUlKZwHss10wpl/1cvwlxQU+f1G90NgrSD1KE9Li7s=;
 b=DvJcmcVJ83NX7vEfDC0LheMkGM3w5jfgf8OBzfQr3rcSLDDBB2auOw6SxU7PNBi71AFE9Q
 MfGN4u5EBLFOqZGreFTO3WXUzE6D7/HOknmaPnEfBWe8ZuBkzNCmhSAbPj/zjG6/VlR8eV
 6fT9umLZ1XkYpgyXZBhAl/KWIW9TJPI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-eJgJVRelMm6Bv2ddU7fw5A-1; Wed,
 14 May 2025 05:34:06 -0400
X-MC-Unique: eJgJVRelMm6Bv2ddU7fw5A-1
X-Mimecast-MFC-AGG-ID: eJgJVRelMm6Bv2ddU7fw5A_1747215245
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11F5119560BF; Wed, 14 May 2025 09:34:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97D2D1800361; Wed, 14 May 2025 09:34:02 +0000 (UTC)
Date: Wed, 14 May 2025 10:33:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Clark <michael@anarch128.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
Message-ID: <aCRjhghDuv4EuLr4@redhat.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
 <aCRROhtUyLK7axOf@redhat.com>
 <6f3e890f-5424-4052-9025-696ca1426c36@anarch128.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f3e890f-5424-4052-9025-696ca1426c36@anarch128.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 14, 2025 at 09:23:58PM +1200, Michael Clark wrote:
> On 5/14/25 20:17, Daniel P. Berrangé wrote:
> > On Wed, May 14, 2025 at 07:39:27PM +1200, Michael Clark wrote:
> > > diff --git a/disas/x86-core.c b/disas/x86-core.c
> > > new file mode 100644
> > > index 000000000000..c4f7034e3420
> > > --- /dev/null
> > > +++ b/disas/x86-core.c
> > > @@ -0,0 +1,2716 @@
> > > +/*
> > > + * Copyright (c) 2024-2025 Michael Clark
> > > + *
> > > + * SPDX-License-Identifier: MIT
> > 
> > Note that we expect contributions to be under GPL-2.0-or-later, unless
> > derived from existing code that forces use of a different license, which
> > needs to be explained in the commit message
> 
> okay no problem, I can do that. there is a freestanding external origin:
> 
> https://github.com/michaeljclark/x86

IIUC, that would only apply to the x86-core.c file - the other files
tagged with MIT look like thy were written just for QEMU inclusion.

> I had a re-spin sitting in my queue for some time and I didn't have any
> changes pending so I thought I would send it out. I would have folks
> try it in private if they were considering merging it in the future.
> one must balance the weight of future maintenance. I know that capstone
> can be used to do the same so it is more of an FYI at this point.

Ok

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


