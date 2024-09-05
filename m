Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F49CD5BA2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 09:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm97A-0004q7-DU; Thu, 05 Sep 2024 05:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sm978-0004pa-BF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 05:49:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sm976-0006KO-RD
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 05:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725529755;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OivPxGIHHhykoH10i0ADJzQwQgX6yrBwT3TD5PLf6pY=;
 b=SumyY2RQtPi3lrp++gHTqTE4hIF1hjzvhl1Xzn9l6TlF2wxSJIZ6zq/MzCGYmCLktWoZ7j
 w9/fApPxzNbuB62Jbog4T0+7vh37lfB0AsxDCTsEsfzrnpyYj4Nf1/rDtwfCyOpofRkkSh
 kF6qIj/A9cC+qs5tEn27eeR9vR9J0II=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-iXqbsuG6PFG7yBpn8-XTwg-1; Thu,
 05 Sep 2024 05:49:13 -0400
X-MC-Unique: iXqbsuG6PFG7yBpn8-XTwg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 962BA19560A2; Thu,  5 Sep 2024 09:49:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87136195608A; Thu,  5 Sep 2024 09:49:08 +0000 (UTC)
Date: Thu, 5 Sep 2024 10:49:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Ztl-kEs3pebSF4aP@redhat.com>
References: <46b63356-9602-4fa2-9d31-186f5f85151f@oracle.com>
 <Zr9q4muKZmYCf9mv@x1n> <Zr9tYsmy8j2t8fq0@redhat.com>
 <Zr9xcmUfkYAWnXH-@x1n> <Zr93oOn9J5JLs2Rn@redhat.com>
 <Zr97ms6Ur9HH_EXG@x1n>
 <d45761d3-6bee-42ac-9752-1192b3bae6ef@oracle.com>
 <ZsYzIN5pM9Ad_DYn@x1n>
 <e1284027-6860-460c-8f3c-5b9c34e2c351@oracle.com>
 <Ztjd9nsrqgjfYTz1@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ztjd9nsrqgjfYTz1@x1n>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 04, 2024 at 06:23:50PM -0400, Peter Xu wrote:
> On Wed, Sep 04, 2024 at 04:58:14PM -0400, Steven Sistare wrote:
> > On 8/21/2024 2:34 PM, Peter Xu wrote:
> > > On Fri, Aug 16, 2024 at 01:09:23PM -0400, Steven Sistare wrote:
> > > > On 8/16/2024 12:17 PM, Peter Xu wrote:
> > > What I read so far from Dan is that cpr-transfer seems to be also preferred
> > > from Libvirt POV:
> > > 
> > >    https://lore.kernel.org/r/Zr9-IvoRkGjre4CI@redhat.com
> > > 
> > > Did I read it right?
> > 
> > I read that as: cpr-transfer is a viable option for libvirt.  I don't hear him
> > excluding the possibility of cpr-exec.
> 
> I preferred not having two solution because if they work the same problem
> out, then it potentially means one of them might be leftover at some point,
> unless they suite different needs.  But I don't feel strongly, especially
> if cpr-exec is light if cpr-transfer is there.
> 
> > 
> > I agree that "Dan the libvirt expert prefers cpr-transfer" is a good reason to
> > provide cpr-transfer.  Which I will do.
> > 
> > So does "Steve the OCI expert prefers cpr-exec" carry equal weight, for also
> > providing cpr-exec?
> 
> As an open source project, Libvirt using it means the feature can be
> actively used and tested.  When e.g. there's a new feature replacing CPR we
> know when we can obsolete the old CPR, no matter -exec or -transfer.
> 
> Close sourced projects can also be great itself but naturally are less
> important in open source communities IMHO due to not accessible to anyone
> in the community.  E.g., we never know when an close sourced project
> abandoned a feature, then QEMU can carry over that feature forever without
> knowing who's using it.

In terms of closed source projects, effectively they don't exist from a
QEMU maintainer's POV. Our deprecation & removal policy is designed so
that we don't need to think about who is using stuff.

When QEMU deprecates something, any users (whether open source or closed
source) have 2 releases in which to notice this, and make a request that
we cancel the deprecation, or change their code.

Libvirt is special in the sense that we'll CC libvirt mailing list on
changes to the deprecated.rst file, and we'll often not propose
deprecations in the first place if we know libvirt is using it, since
we can ask libvirt quite easily & libvirt people pay attention to QEMU.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


