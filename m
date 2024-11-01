Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A83E6B243
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 11:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ptL-0008Pl-Vi; Fri, 01 Nov 2024 07:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6ptK-0008PV-4E
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:32:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t6ptI-00070p-Ee
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 07:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730460751;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0JUC+kHTFRG6fVmvxchTBDugXpBgb1YjFJ3hv9tCo0=;
 b=EaGflDSFlv2Ko/tkd5LUlZDuyIlWNVG7cpVFJKGMItr36b0ahNVJLIcFQebkXSnVKemnrB
 d9iYQ6rWPck3SCx3RiQPZwT/9+DjiRSSMBHAZIEaAPFJLe26MphUYMzmxoAD96t66JhmP8
 e1aZMtbcXJM3tNgV47HRqhNYQGYxULo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-FHgNeh5xNNO2RLOIrdA2YQ-1; Fri,
 01 Nov 2024 07:32:29 -0400
X-MC-Unique: FHgNeh5xNNO2RLOIrdA2YQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C410D19560AE
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2024 11:32:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D1581956086; Fri,  1 Nov 2024 11:32:27 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:32:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC 3/5] convert code to object_new_dynamic() where appropriate
Message-ID: <ZyS8SM-0jsG23IA2@redhat.com>
References: <20241031155350.3240361-1-berrange@redhat.com>
 <20241031155350.3240361-4-berrange@redhat.com>
 <ZyPYreQWvtG7bH3P@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZyPYreQWvtG7bH3P@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On Thu, Oct 31, 2024 at 03:21:17PM -0400, Peter Xu wrote:
> On Thu, Oct 31, 2024 at 03:53:48PM +0000, Daniel P. Berrangé wrote:
> > In cases where object_new() is not being passed a static, const
> > string, the caller cannot be sure what type they are instantiating.
> > There is a risk that instantiation could fail, if it is an abstract
> > type.
> > 
> > Convert such cases over to use object_new_dynamic() such that they
> > are forced to expect failure. In some cases failure can be easily
> > propagated, but in others using &error_abort maintainers existing
> > behaviour.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  chardev/char.c                   |  5 ++++-
> >  hw/core/bus.c                    |  2 +-
> >  hw/core/cpu-common.c             |  2 +-
> >  hw/core/qdev.c                   |  4 ++--
> >  hw/i386/x86-common.c             |  5 ++++-
> >  hw/i386/xen/xen-pvh.c            |  2 +-
> >  hw/vfio/common.c                 |  6 +++++-
> >  hw/vfio/container.c              |  6 +++++-
> >  qom/object_interfaces.c          |  7 ++-----
> >  qom/qom-qmp-cmds.c               | 15 +++++++++------
> >  tests/unit/check-qom-interface.c |  3 ++-
> >  tests/unit/test-smp-parse.c      | 20 ++++++++++----------
> >  12 files changed, 46 insertions(+), 31 deletions(-)
> 
> I think we could leave the test cases alone without _dynamic(), because
> they do test static types (even if they used "opaque"..), and they should
> really (and forever) assert on failures..
> 
> IMHO we should keep _dynamic() usages small if we'd like to introduce it,
> only in the paths where its failure will be properly handled.  Basically, I
> think we shouldn't use _dynamic() if we know it'll be error_abort.. because
> that's fundamentally identical to object_new().

For the sake of other readers, here's what you already figured out from
looking at patch 5...

The end of this series will enforce that the argument to object_new()
is a static, const string. It will become a compile error to pass a
variable to object_new(), and thus all such cases need switching to
object_new_dynamic(), even if they just end up passing in &error_abort
in some cases. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


