Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3133606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H9ZiQENo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRBHd-0008Az-QL; Wed, 11 Nov 2026 11:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRBHT-00086R-In
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:34:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRBHR-0007rS-V4
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 11:34:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794414875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WmpJeNNs2lizRiupR2jkzW9fuMTz/fqx19rPG2ixhSI=;
 b=H9ZiQENoIVZN0X413YNrIGbyijvB83hzJMb6cpPW8p7mVlrKQ/QLmty4sBn16yc7Bj8/oS
 +cvaWtw/L9haR9voH5dpaq8AQcI5/cnEWYZu/SVJOr3tcJDLVWqZBDdzrMBsYC62WMmh+c
 uYNW4Ya3KmJyVOjV/S5fQsZ0i1GbBq0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-2S1B_QDZPKW2XX0TJpgLxg-1; Wed,
 11 Nov 2026 11:34:33 -0500
X-MC-Unique: 2S1B_QDZPKW2XX0TJpgLxg-1
X-Mimecast-MFC-AGG-ID: 2S1B_QDZPKW2XX0TJpgLxg_1794414872
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAE381955BC1; Wed, 11 Nov 2026 16:34:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCF541956087; Wed, 11 Nov 2026 16:34:29 +0000 (UTC)
Date: Wed, 11 Nov 2026 10:34:27 -0600
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 2/5] migration/postcopy: set destination
 postcopy-active in the run BH
Message-ID: <avSYgKj47LSRKOm8@redhat.com>
References: <20261110183257.2930908-1-den@openvz.org>
 <20261110183257.2930908-3-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110183257.2930908-3-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Tue, Nov 10, 2026 at 07:32:54PM +0100, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") made
> the destination enter POSTCOPY_ACTIVE in loadvm_postcopy_handle_run(),
> before it schedules loadvm_postcopy_handle_run_bh(), and only the BH
> starts the VM or moves it to RUN_STATE_PAUSED. Management reacting to
> the destination's postcopy-active event can therefore still find the
> VM in RUN_STATE_INMIGRATE, where blockdev-add creates inactive nodes
> and attaching a device to them fails with "Block node is read-only".
> 
> Move the transition to the end of the run BH, after vm_start() or
> runstate_set(), as process_incoming_migration_bh() does for precopy
> COMPLETED. Without a return path the listen thread enters
> POSTCOPY_ACTIVE directly, and the fast snapshot load path switches
> right after scheduling the BH; in both cases the state is no longer
> POSTCOPY_DEVICE when the BH runs and the transition is a no-op.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>
> ---
>  migration/savevm.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

I'll defer to Peter's judgment on this one and 4/5, but the
descriptions in the cover letter and commit message make sense to
me. Meanwhile, I'm setting up to play with 3 and 5/5 to see if I can
review those tests for catching the issues documented here, even if
I'm less comfortable being the sole reviewer on the code changes that
got them to pass.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


