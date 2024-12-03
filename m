Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638E5E69EA6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 15:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUqa-0001ti-8j; Tue, 03 Dec 2024 10:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIUqR-0001lG-Fq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:29:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIUqO-0008FA-4n
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 10:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733239782;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=A6jIbmPKzR6N4F6oBh3e8hjbQ3sBvVXeNf1bxCLxGXc=;
 b=WKIxbzpnbf7WeF5Qgy3x9MbbTyj7NuyVo9znDKy8CDRU6URwkQrMDTC0C17dMfHY7o3Gqv
 6do76eWOeghE8Qc24dnJC04c1OlYG8BHdtxxN+7a6tXYQJxM7AoDE2dhSXiWYLcyapIXdh
 YFpLK0WGQIecxHPTTt6z99xy0MKzBWU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-4URXFgwLNCeajkEsJJEvig-1; Tue,
 03 Dec 2024 10:29:37 -0500
X-MC-Unique: 4URXFgwLNCeajkEsJJEvig-1
X-Mimecast-MFC-AGG-ID: 4URXFgwLNCeajkEsJJEvig
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E7FE1954ADC; Tue,  3 Dec 2024 15:29:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86D3A1956054; Tue,  3 Dec 2024 15:29:31 +0000 (UTC)
Date: Tue, 3 Dec 2024 15:29:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, pbonzini@redhat.com,
 imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <Z08j2Ii-QuZk3lTY@redhat.com>
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
 <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com>
 <ZwyRsq4EIooifRvb@intel.com>
 <bbcfcbbd-1666-4e97-ae18-f47202d89009@intel.com>
 <ZxDS4L8vSr3HfFIh@intel.com>
 <b43557f7-49ff-43bb-8a8c-887b8220e1e8@intel.com>
 <Z060VQVV6ONK9Qd2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z060VQVV6ONK9Qd2@intel.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Dec 03, 2024 at 03:33:41PM +0800, Zhao Liu wrote:
> > However, back to the patch, I think we cannot change it as this patch
> > directly. Instead, we need a compat_props for the changed behavior, because
> > this isn't a bug fix and it introduces guest-visible differences.
> 
> This is a fix, not a new feature, so compat_props is not needed.

Note from QEMU's POV, whether or not a change requires use of compat_props
is NOT determined by whether it is a bugfix or feature.

The decision is driven by whether a running guest OS will continue to
function correctly when it is live migrated between 2 QEMUs, before/after
the commit.

If the commit breaks a running guest, then toggling usage of the changed
code based on compat_props is required. Sometimes we can get away without
this for bug fixes, other bug fixes not so lucky.

My gut feeling is in this case we're probably safe-ish without compat_props,
as topology is the kind of info that's read once at OS startup and then
cached until reboot. So changing the logical processor per package
behind a running guest (probably) won't cause trouble.

One of the i386 maintainers should sanity check though, as this code isn't
my normal area of expertize

> 
> > For ancient Intel CPUs, EBX[23:16] did represent the number of Logical
> > processor per package. I believe this should be the reason why QEMU
> > implemented it as is:
> > 
> >   - on SDM version 013, EBX[23:16]: Number of logical processors per
> > physical processor; two for the Pentium 4 processor supporting
> > Hyper-Threading Technology.
> > 
> >   - on SDM version 015, it changed to: Number of initial APIC IDs reserved
> > for this physical package. Normally, this is the number of logical
> > processors per physical package.
> > 
> >   - on SDM version 016, it changed to: Maximum number of logical processors
> > in this physical package.
> > 
> >   - finally, starting from SDM version 026, it changed to what reads now:
> > Maximum number of addressable IDs for logical processors in this physical
> > package.
> 
> And this is an architecturally defined CPUID, so SDM ensures backward
> compatibility.
> 
> Regards,
> Zhao
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


