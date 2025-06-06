Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56375C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 15:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNZEA-0006LX-4W; Fri, 06 Jun 2025 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNZE7-0006L0-6i
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uNZE4-000255-OT
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 11:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749224603;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jImJgUIawBZnVXVa3ylGS29FiGJTmf/6EI2tleBz+bM=;
 b=FRSNkXM5Y/qNAgqdwg3h5E6d8DqEy4TaTQUxz/GhXILUxTkiyNcHt+levekNqboktqPzJZ
 ZBz7lsK0a0ixFgs6vHB7Mn4zNKkG32IyBIIftB/q/rDloTlFo9EPa3HA05eLQeqmwD7NIX
 LdK/g54SGE5QZUnVdgBqipOXZqH8wl0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-WCgKaTmVO3aDMMyM-4LixQ-1; Fri,
 06 Jun 2025 11:43:17 -0400
X-MC-Unique: WCgKaTmVO3aDMMyM-4LixQ-1
X-Mimecast-MFC-AGG-ID: WCgKaTmVO3aDMMyM-4LixQ_1749224596
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AAF91801A00; Fri,  6 Jun 2025 15:43:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A14C919560AE; Fri,  6 Jun 2025 15:43:13 +0000 (UTC)
Date: Fri, 6 Jun 2025 16:43:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: JAEHOON KIM <jhkim@linux.ibm.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 jjherne@linux.ibm.com, peterx@redhat.com, farosas@suse.de
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
Message-ID: <aEMMjtsKZLX_Bi03@redhat.com>
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
 <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
 <2c8d3cb2-b3ee-4738-871a-0dea2bff0e84@linux.ibm.com>
 <3004c91e-d515-4e22-902c-42cea83ce64b@oracle.com>
 <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <760af012-1265-4845-b7d2-793fe75c3a51@linux.ibm.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Fri, Jun 06, 2025 at 10:37:28AM -0500, JAEHOON KIM wrote:
> 
> On 6/6/2025 10:12 AM, Steven Sistare wrote:
> > On 6/6/2025 11:06 AM, JAEHOON KIM wrote:
> > > On 6/6/2025 9:14 AM, Steven Sistare wrote:
> > > > On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
> > > > > On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
> > > > > > When the source VM attempts to connect to the destination VM's Unix
> > > > > > domain socket(cpr.sock) during CPR transfer, the socket
> > > > > > file might not
> > > > > > yet be exist if the destination side hasn't completed the bind
> > > > > > operation. This can lead to connection failures when
> > > > > > running tests with
> > > > > > the qtest framework.
> > > > > 
> > > > > This sounds like a flawed test impl to me - whatever is initiating
> > > > > the cpr operation on the source has done so prematurely - it should
> > > > > ensure the dest is ready before starting the operation.
> > > > > 
> > > > > > To address this, add cpr_validate_socket_path(), which wait for the
> > > > > > socket file to appear. This avoids intermittent qtest
> > > > > > failures caused by
> > > > > > early connection attempts.
> > > > > 
> > > > > IMHO it is dubious to special case cpr in this way.
> > > > 
> > > > I agree with Daniel, and unfortunately it is not just a test issue;
> > > > every management framework that supports cpr-transfer must add logic to
> > > > wait for the cpr socket to appear in the target before proceeding.
> > > > 
> > > > This is analogous to waiting for the monitor socket to appear before
> > > > connecting to it.
> > > > 
> > > > - Steve
> > > 
> > > Thank you very much for your valuable review and feedback.
> > > 
> > > Just to clarify, the added cpr_validate_socket_path() function is
> > > not limited to the test framework.
> > > It is part of the actual CPR implementation and is intended to
> > > ensure correct behavior in all cases, including outside of tests.
> > > 
> > > I mentioned the qtest failure simply as an example where this issue
> > > became apparent.
> > 
> > Yes, I understand that you understand :)
> > Are you willing to move your fix to the qtest?
> > 
> > - Steve
> 
> Thank you for your question and feedback.
> 
> I agree that the issue could be addressed within the qtest framework to
> improve stability.
> 
> However, this socket readiness check is a fundamental part of CPR transfer
> process,
> and I believe that incorporating cpr_validate_socket_path() directly into
> the CPR implementation helps ensure more reliable behavior
> across all environments - not only during testing.
> 
> Just from my perspective, adding this logic to the CPR code does not
> introduce significant overhead or side effects.
> I would appreciate if you could share more details about your concerns, so I
> can better address them.

Requiring a busy wait like this is a sign of a design problem.

There needs to be a way to setup the incoming socket listener
without resorting to busy waiting - that's showing a lack of
synchronization.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


