Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F740C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 19:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tptzd-0000Td-Nv; Wed, 05 Mar 2025 14:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tptz0-0000RS-RK
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:00:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tptyy-0008Rw-Rd
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 14:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741201239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NJpep1+3wehVtsrzLv1L0fsIwnpgJQcq4eB4UU9fp0A=;
 b=aFnF3EB6Smxh3YN6Ss/HC8vGb4q4XOwgwhogymDGIkkgPKaB2m/x3DOJ1cPmrD+XA8hT9M
 1fmuhL5QJoeiAWGTyr0Ugd7LBdCFf/CEIm7EuY6gr/YuyzQPnnv20HiaBgp2NUrj99xQzR
 w9VlTPjILf+nHtLcVe+9A1YikxJZ63o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-KCS7fDRUPGCj963pL9wV4w-1; Wed,
 05 Mar 2025 14:00:26 -0500
X-MC-Unique: KCS7fDRUPGCj963pL9wV4w-1
X-Mimecast-MFC-AGG-ID: KCS7fDRUPGCj963pL9wV4w_1741201225
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37E3F180AF51; Wed,  5 Mar 2025 19:00:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.105])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD0E8300019E; Wed,  5 Mar 2025 19:00:21 +0000 (UTC)
Date: Wed, 5 Mar 2025 13:00:19 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH] nbd: Defer trace init until after daemonization
Message-ID: <rneigfb34ioetuhdx7djytxwvlznccorfvtwse6k7s7eqmh3qd@64bbms3gqdv7>
References: <20250227220625.870246-2-eblake@redhat.com>
 <ecfdf860-7bbd-4744-9195-2eee2c7a0d05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfdf860-7bbd-4744-9195-2eee2c7a0d05@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 05, 2025 at 07:55:48AM +0100, Thomas Huth wrote:
> On 27/02/2025 23.06, Eric Blake wrote:
> > At least the simple trace backend works by spawning a helper thread,
> > and setting up an atexit() handler that coordinates completion with
> > the helper thread.  But since atexit registrations survive fork() but
> > helper threads do not, this means that qemu-nbd configured to use the
> > simple trace will deadlock waiting for a thread that no longer exists
> > when it has daemonized.
> > 
> > Better is to follow the example of vl.c: don't call any setup
> > functions that might spawn helper threads until we are in the final
> > process that will be doing the work worth tracing.
> > 

...
> This also sounds like the best option to me!
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks; added to my NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


