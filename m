Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DFBCF6A8B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 09:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdmBV-0004CL-6P; Thu, 08 Jan 2026 04:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdmBT-0004As-Lw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:19:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdmBR-0003sF-5L
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 04:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767863995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bF3lYiqI1h8Qw7SMkUPHGWBWPwzmpDwpu/dI+6DG77g=;
 b=a2iiQk9c19FI1VznmJUao+9v4Xcwe/QlzizupurCkNYkl68pR5jF5QQvgUz7ouz05heL1W
 lgVJiAqXi89vGaCLUZDay+YIurFvMghd8adeGWlNt1W1WBoLYWPyeVw+wev3aGBvyBOFOH
 Amav7VNL9k5KWJEeB7teZbJ7vQ5rIgw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-4Zq8Y8dDNgCpSAwNM79zQA-1; Thu,
 08 Jan 2026 04:19:51 -0500
X-MC-Unique: 4Zq8Y8dDNgCpSAwNM79zQA-1
X-Mimecast-MFC-AGG-ID: 4Zq8Y8dDNgCpSAwNM79zQA_1767863990
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C128195605F; Thu,  8 Jan 2026 09:19:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9892E30002D1; Thu,  8 Jan 2026 09:19:47 +0000 (UTC)
Date: Thu, 8 Jan 2026 09:19:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, mst@redhat.com, jjherne@linux.ibm.com,
 alifm@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Subject: Re: [PATCH 03/10] pc-bios/s390-ccw: Split virtio-ccw and generic
 virtio
Message-ID: <aV92sIzeHSCYI1Bz@redhat.com>
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-4-jrossi@linux.ibm.com>
 <1a5926ec-8bf5-49de-9228-595d3910275f@redhat.com>
 <bbb1ec46-3e59-4bfb-b656-7f07570ab981@linux.ibm.com>
 <8d4d72e3-b4f5-40bd-9676-b14150f8daf8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d4d72e3-b4f5-40bd-9676-b14150f8daf8@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Jan 08, 2026 at 07:02:47AM +0100, Thomas Huth wrote:
> On 07/01/2026 17.38, Jared Rossi wrote:
> > 
> > 
> > On 1/7/26 4:40 AM, Thomas Huth wrote:
> > > On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> > > > From: Jared Rossi <jrossi@linux.ibm.com>
> ...
> > > > diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> > > > index 0f4f201038..0488b3a07e 100644
> > > > --- a/pc-bios/s390-ccw/virtio.c
> > > > +++ b/pc-bios/s390-ccw/virtio.c
> > > > @@ -2,6 +2,7 @@
> > > >    * Virtio driver bits
> > > >    *
> > > >    * Copyright (c) 2013 Alexander Graf <agraf@suse.de>
> > > > + * Copyright 2025 IBM Corp. Author(s): Jared Rossi <jrossi@linux.ibm.com>
> > > 
> > > I assume you wanted to put Authors on a separate line?
> > 
> > I don't quite understand what you are asking about here.  Or maybe I
> > don't understand how to attribute the authors in this case?
> > 
> > Much of this was just copy/pasted to the new file, so I included the
> > existing byline too.  Should I format things differently?
> 
> No, you don't have to change it, I was just surprised to see "Copyright" and
> "Author(s):" in the same line. People normally put it on separate lines, see
> e.g. cio.c, menu.c or virtio-scsi.c in the pc-ios/s390-ccw/ directory.

The reason for the usual separation is that they have different effects.

Any text that is part of a  "Copyright" line is legally associated with,
and their presence is protected by the license terms.

Lists of authors have no legal effects, they're merely credits, and are
not protected by the license.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


