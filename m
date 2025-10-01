Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DEECCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sRf-0005j3-Q7; Wed, 01 Oct 2025 04:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v3sRe-0005gj-DZ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v3sRS-00084d-My
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759308238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HD1USyFlcVERwYbB32aIKjN98NywyUJETPwweD72wew=;
 b=G15114hwRpKBjvR9t3RBHtjEhDtqRfumAcwQQfT0h+MG1NeVdhqZZYZhgw3zAHC1O6rlMc
 8tdpgl7UC9x/bHCzSNFrHHe3c7UKEh3tqwUhoGezWfRmMVzbKdALu34vi2Wpp269+PkwcT
 9qezb8gWwn9Szi0Z9OOpneHN6tRAFrw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-sZCYS_TfM0exF0uhn0OyiQ-1; Wed,
 01 Oct 2025 04:43:54 -0400
X-MC-Unique: sZCYS_TfM0exF0uhn0OyiQ-1
X-Mimecast-MFC-AGG-ID: sZCYS_TfM0exF0uhn0OyiQ_1759308233
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 690FF195608E; Wed,  1 Oct 2025 08:43:53 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EC9D19560B4; Wed,  1 Oct 2025 08:43:51 +0000 (UTC)
Date: Wed, 1 Oct 2025 10:43:50 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNzpxr7N420TUIIf@orkuz.int.mamuti.net>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net> <aNw35iWaNDnYXOz7@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNw35iWaNDnYXOz7@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 30, 2025 at 16:04:54 -0400, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> > On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > > do vm_start(), at the end of which RESUME event will be generated.  So
> > > RESUME currently implies both disk activation success, and vm start worked.
> > > 
> > > > may still fail when locking disks fails (not sure if this is the only
> > > > way cont may fail). In this case we cannot cancel the migration on the
> > > 
> > > Is there any known issue with locking disks that dest would fail?  This
> > > really sound like we should have the admin taking a look.
> > 
> > Oh definitely, it would be some kind of an storage access issue on the
> > destination. But we'd like to give the admin an option to actually do
> > anything else than just killing the VM :-) Either by automatically
> > canceling the migration or allowing recovery once storage issues are
> > solved.
> 
> The problem is, if the storage locking stopped working properly, then how
> to guarantee the shared storage itself is working properly?
> 
> When I was replying previously, I was expecting the admin taking a look to
> fix the storage, I didn't expect the VM can still be recovered anymore if
> there's no confidence that the block devices will work all fine.  The
> locking errors to me may imply a block corruption already, or should I not
> see it like that?

If the storage itself is broken, there's clearly nothing we can do. But
the thing is we're accessing it from two distinct hosts. So while it may
work on the source, it can be broken on the destination. For example,
connection between the destination host and the storage may be broken.
Not sure how often this can happen in real life, but we have a bug
report that (artificially) breaking storage access on the destination
results in paused VM on the source which can only be killed.

So I believe we should do better if reasonably possible. People don't
like losing their VMs just because they tried to migrate and something
failed.

Jirka


