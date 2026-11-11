Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1A606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F0g6m1DE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRCBV-0005bQ-6P; Wed, 11 Nov 2026 12:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRCBJ-0005Rp-CK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 12:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRCBF-0004Og-OS
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 12:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794418335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KkQ+BPtabpv5eIJTQ5/AJ6HOfsFuUbTf036tJJdO9oc=;
 b=F0g6m1DEOjS+8uc7GE1lrotBF9wnZO/JOLNI0BWnQwhdKnLsuaJNDjV+1N2mfrP820BQwP
 XqODZ2iRwAiatOHHw+yDs5Femc8GvQ4Sh2/DvcEFOMP4Af3Hl44sh7uMpzotFwShdjXbRo
 wUfmplEmSePD8hEDbbROQeOJM9JG9rw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-qKRFqmhpNe6q29Cdxk_dwQ-1; Wed,
 11 Nov 2026 12:32:11 -0500
X-MC-Unique: qKRFqmhpNe6q29Cdxk_dwQ-1
X-Mimecast-MFC-AGG-ID: qKRFqmhpNe6q29Cdxk_dwQ_1794418330
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10AE1953979; Wed, 11 Nov 2026 17:32:08 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFDC6421; Wed, 11 Nov 2026 17:32:06 +0000 (UTC)
Date: Wed, 11 Nov 2026 11:32:04 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 3/5] tests/qtest/migration: check the destination run
 state in postcopy tests
Message-ID: <avSlft9YtBrdT8H_@redhat.com>
References: <20261110183257.2930908-1-den@openvz.org>
 <20261110183257.2930908-4-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110183257.2930908-4-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 07:32:55PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The destination must not report postcopy-active or completed while it
> is still in RUN_STATE_INMIGRATE. The destination autostarts in these
> tests, so the run state change emits RESUME and the order is visible in
> the event stream: record a MIGRATION postcopy-active or completed event
> seen before RESUME and fail the postcopy tests on it once the
> destination has completed.
> 
> migrate_postcopy_start() waited for the destination's RESUME with
> qtest_qmp_eventwait(), which reads events past the event callback and
> drops the ones it does not want. Poll query-status instead, so every
> destination event reaches the callback.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  tests/qtest/migration/framework.c      |  6 ++++--
>  tests/qtest/migration/migration-qmp.c  | 10 ++++++++--
>  tests/qtest/migration/migration-qmp.h  |  3 ++-
>  tests/qtest/migration/migration-util.c |  8 ++++++++
>  tests/qtest/migration/migration-util.h |  2 ++
>  5 files changed, 24 insertions(+), 5 deletions(-)

Took me a while to figure out that I needed a temporary:

$ sudo sysctl -w vm.unprivileged_userfaultfd=1

to get the test to pass/fail rather than skip, but with that done, I
can confirm that the test was sufficient to show failure without 2/5,
and pass when the series is applied in order. I'd be remiss if I did
not mention how handy it was to have AI help me dig up the specific
configuration and tests I needed to run for double-checking your patch
(thankfully, much different than the ethical worries about using AI to
write a patch in the first place).

Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


