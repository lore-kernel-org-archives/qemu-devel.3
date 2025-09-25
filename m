Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9EFCAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:55:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kZ4-0003rx-2C; Thu, 25 Sep 2025 07:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v1kZ0-0003r0-Uj
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jdenemar@redhat.com>)
 id 1v1kYw-000394-Cc
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758801292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfF8v2dNTFOqrTPvgZqHOlsT7cc3pahG+YaTOEetdF8=;
 b=MGefiqzOHWSVCMcGbqamzwPPrNTKouxqL/mxoCABu4mYO7Ek29r3gvpq/oDtnWDPHlXe+N
 T37/yJ6BynE5c0OkHhDCDhEYi8qH6kDronwq1SiYoZjKQb5UB98aIy6kJkGSboAuGjVmyh
 /Op9k/cKb0HmNmRMxibSejwvIfnPTHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-V3Q4FSTQO3iyRa9uahOBaA-1; Thu,
 25 Sep 2025 07:54:44 -0400
X-MC-Unique: V3Q4FSTQO3iyRa9uahOBaA-1
X-Mimecast-MFC-AGG-ID: V3Q4FSTQO3iyRa9uahOBaA_1758801283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82832180034C; Thu, 25 Sep 2025 11:54:43 +0000 (UTC)
Received: from orkuz (unknown [10.43.3.115])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D4B01956095; Thu, 25 Sep 2025 11:54:42 +0000 (UTC)
Date: Thu, 25 Sep 2025 13:54:40 +0200
From: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915115918.3520735-5-jmarcin@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jdenemar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, when postcopy starts, the source VM starts switchover and
> sends a package containing the state of all non-postcopiable devices.
> When the destination loads this package, the switchover is complete and
> the destination VM starts. However, if the device state load fails or
> the destination side crashes, the source side is already in
> POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> up-to-date machine state as the destination has not yet started.
> 
> This patch introduces a new POSTCOPY_DEVICE state which is active
> while the destination machine is loading the device state, is not yet
> running, and the source side can be resumed in case of a migration
> failure.
> 
> To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> side uses a PONG message that is a response to a PING message processed
> just before the POSTCOPY_RUN command that starts the destination VM.
> Thus, this change does not require any changes on the destination side
> and is effective even with older destination versions.

Thanks, this will help libvirt as we think that the migration can be
safely aborted unless we successfully called "cont" and thus we just
kill QEMU on the destination. But since QEMU on the source already
entered postcopy-active, we can't cancel the migration and the result is
a paused VM with no way of recovering it.

This series will make the situation better as the source will stay in
postcopy-device until the destination successfully loads device data.
There's still room for some enhancement though. Depending on how fast
this loading is libvirt may issue cont before device data is loaded (the
destination is already in postcopy-active at this point), which always
succeeds as it only marks the domain to be autostarted, but the actual
start may fail later. When discussing this with Juraj we agreed on
introducing the new postcopy-device state on the destination as well to
make sure libvirt will only call cont once device data was successfully
loaded so that we always get a proper result when running cont. But it
may still fail when locking disks fails (not sure if this is the only
way cont may fail). In this case we cannot cancel the migration on the
source as it is already in postcopy-active and we can't recover
migration either as the CPUs are not running on the destination. Ideally
we'd have a way of canceling the migration in postocpy-active if we are
sure CPUs were not started yet. Alternatively a possibility to recover
migration would work as well.

Jirka


