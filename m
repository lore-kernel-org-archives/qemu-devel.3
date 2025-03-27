Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F62FC36011
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txodI-0006eV-5Q; Thu, 27 Mar 2025 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txodG-0006cm-1M
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:54:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1txodE-0000OR-AL
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743087294;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OPfZCq1yBX3u0TLKpvUCfXtatrQ4gpTdm49B6uBySic=;
 b=WxjlYRI1RjJ9qJ45woK7FpkyVMNfZlpwnfmq+AM/K4Itroaq/jzg40GmMwql+kgybFiNBo
 xkLZTx45MoGa+sgBc9hg8vZfYyXJDI/eVDCZfut8YIb5NlvW4BQoTQV6gyI4LBd1BfN9fc
 CdzHe+dugiOqFqqB14ZHXmNz6UFr59I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-AEAnI6VFPF2wcZbGtsUo1Q-1; Thu,
 27 Mar 2025 10:54:51 -0400
X-MC-Unique: AEAnI6VFPF2wcZbGtsUo1Q-1
X-Mimecast-MFC-AGG-ID: AEAnI6VFPF2wcZbGtsUo1Q_1743087290
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E91C818001F6; Thu, 27 Mar 2025 14:54:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.90])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7DAB192C7D7; Thu, 27 Mar 2025 14:54:46 +0000 (UTC)
Date: Thu, 27 Mar 2025 14:54:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>
Subject: Re: [PATCH 1/4] migration/savevm: Add a compatibility check for
 capabilities
Message-ID: <Z-Vms2l4jZ_eV-aa@redhat.com>
References: <20250327143934.7935-1-farosas@suse.de>
 <20250327143934.7935-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327143934.7935-2-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Mar 27, 2025 at 11:39:31AM -0300, Fabiano Rosas wrote:
> It has always been possible to enable arbitrary migration capabilities
> and attempt to take a snapshot of the VM with the savevm/loadvm
> commands as well as their QMP counterparts
> snapshot-save/snapshot-load.
> 
> Most migration capabilities are not meant to be used with snapshots
> and there's a risk of crashing QEMU or producing incorrect
> behavior. Ideally, every migration capability would either be
> implemented for savevm or explicitly rejected.

IMHO, this a prime example of why migration config shouldn't be held
as global state, and instead passed as parameters to the commands
that need them.  The snapshot-save/load commands would then only
be able to accept what few settings are actually relevant, instead
of inheriting any/all global migration state.

> Add a compatibility check routine and reject the snapshot command if
> an incompatible capability is enabled. For now only act on the the two
> that actually cause a crash: multifd and mapped-ram.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2818

Issue is 2881 not 2818                                   ^^^^^^^

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/options.c | 26 ++++++++++++++++++++++++++
>  migration/options.h |  1 +
>  migration/savevm.c  |  8 ++++++++
>  3 files changed, 35 insertions(+)

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


