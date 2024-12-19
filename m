Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08506E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 18:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOKqE-0006rH-QK; Thu, 19 Dec 2024 13:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKq5-0006qi-IB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tOKq1-0005cZ-8v
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 13:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734631286;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54pDTFQxW9OpbnsdR+FouKMaCByKwry4P/Ob9hi5NVg=;
 b=gEKaR7g4348rDL9e0AIrElGJ8nZIILCf6YMTqTI5fQ6gHVGJYW5JMIQuidnwXNEEJsJmlk
 E0mHzA8xhpI2k20OB3v4T4VXOpJ12QlzfGPgx/tDqa3K3dVhDp5klJNJDrt94tNlp+eACC
 eMpZzgsAlxymiSzOuo/ptisLb4Ckzn4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-q64UCY0rPkuXH02NgZt-VA-1; Thu,
 19 Dec 2024 13:01:23 -0500
X-MC-Unique: q64UCY0rPkuXH02NgZt-VA-1
X-Mimecast-MFC-AGG-ID: q64UCY0rPkuXH02NgZt-VA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D279E1956057; Thu, 19 Dec 2024 18:01:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.54])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FED730044C1; Thu, 19 Dec 2024 18:01:17 +0000 (UTC)
Date: Thu, 19 Dec 2024 18:01:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, eduardo@habkost.net,
 armbru@redhat.com, pankaj.gupta@amd.com, huibo.wang@amd.com,
 jroedel@suse.com, dionnaglaze@google.com
Subject: Re: [PATCH v1 3/3] i386/sev: Add KVM_EXIT_SNP_REQ_CERTS support for
 certificate-fetching
Message-ID: <Z2RfamsMDDI5Jo0E@redhat.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
 <20241218154939.1114831-4-michael.roth@amd.com>
 <Z2MLfIFzzyEWEy5T@redhat.com>
 <20241218222951.v6yjhcd7j6uojcs4@amd.com>
 <Z2PVprpxdfa9MQR5@redhat.com>
 <20241219131601.ckebfuxy5ukpdcml@amd.com>
 <Z2QhjkgMQ0JDJYkb@redhat.com>
 <20241219174949.wtmw7gosb4hkfjxg@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241219174949.wtmw7gosb4hkfjxg@amd.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Thu, Dec 19, 2024 at 11:49:49AM -0600, Michael Roth wrote:
> On Thu, Dec 19, 2024 at 01:37:18PM +0000, Daniel P. Berrangé wrote:
> > IMHO we msut consider unlink() to be a valid thing, because the right
> > way for apps to perform crash safe atomic updates of existing files,
> > is to use rename() from a temporary file, and the rename() in has an
> > implicit unlink as part of its operation. ie apps would be doing:
> > 
> >    fd = open("foo.tmp")
> >    write(fd, ...)
> >    fsync(fd)
> >    close(fd)
> >    rename("foo.tmp", "foo")
> 
> If we still want to allow for this rather than enforcing in-place
> update, one alternative would be to just allow a separate lock file
> to be specified rather than locking the certificate file itself. That
> would provide a bit more flexibility.
> 
> I can update the QEMU implementation to take -certs-lock-file in
> addition to -certs-file so they can be specified separately. And if
> -certs-lock-file is not specified then QEMU will just assume
> management handles things different or has agreed to not do endorsement
> key updates while SNP guests are running.
> 
> I think we'd considered something like that originally but the thinking
> was that locking the certs themselves was more organic in terms of an
> "obvious"/natural solution. But it does end up being a bit more
> inflexible WRT how libraries/etc. might manage file updates underneath
> the covers, so maybe a lock file is the better approach after all.

If we want locking, I think locking the certs file directly is a nicer
idea, as it avoids everyone having to agree on the location of the
lock file, relative to the certs file.

The current locking code just needs to go inside a while(1) loop and
have fstat + stat added to detect the recreation race. For example:

  https://gitlab.com/libvirt/libvirt/-/blob/master/src/util/virpidfile.c#L376

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


