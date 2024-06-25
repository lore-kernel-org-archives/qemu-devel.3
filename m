Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B142AC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 21:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMBsW-0006HU-9M; Tue, 25 Jun 2024 15:31:16 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBo7-00051t-Ty
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sMBnE-0003UE-Eb
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 15:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719343473;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fiBoRbKqcXPEaXb9Wfb7tOE/hP9waTBqlmTEDeA82AQ=;
 b=RfFX98lLlSPCZxQoFS4Kp5WEEFiX93gsmG2yKsILjOzyaM19vWFk/CFPJuIuAWPtk851FX
 1n5cp2c1V/HkEQAHbklBzpxMi+dkjkKXwJdFAGUQFUq42FvSQwHzu1XbefzwAovLD3qXu2
 N6dAut7NMG3kEX0k816//BYUj7EbTiY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-P0bWCPHlM1iTwXBfgWbUPQ-1; Tue,
 25 Jun 2024 15:05:35 -0400
X-MC-Unique: P0bWCPHlM1iTwXBfgWbUPQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC33C19560BC; Tue, 25 Jun 2024 19:05:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24B1519560AB; Tue, 25 Jun 2024 19:05:28 +0000 (UTC)
Date: Tue, 25 Jun 2024 20:05:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, peterx@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH RFC 1/2] migration: abort when switchover limit exceeded
Message-ID: <ZnsU9aWczE3vWISR@redhat.com>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-2-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621143221.198784-2-elena.ufimtseva@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 21, 2024 at 07:32:20AM -0700, Elena Ufimtseva wrote:
> Introduce capability switchover_abort and migration parameter switchover_limit
> to allow for live migration abort when the source downtime exceeded by
> switchover_limit.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  hw/core/machine.c                  |  1 +
>  include/migration/client-options.h |  1 +
>  migration/migration-hmp-cmds.c     | 10 ++++++
>  migration/migration.c              | 39 +++++++++++++++++++++
>  migration/migration.h              |  5 +++
>  migration/options.c                | 56 ++++++++++++++++++++++++++++++
>  migration/options.h                |  1 +
>  migration/savevm.c                 | 13 +++++++
>  qapi/migration.json                | 27 +++++++++++---
>  9 files changed, 149 insertions(+), 4 deletions(-)

> diff --git a/qapi/migration.json b/qapi/migration.json
> index 470f746cc5..069a44f207 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -469,6 +469,10 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @switchover-abort: abort migration if downtime exceeds the downtime
> +#     limit configured by the specified value by switchover-limit
> +#     migration parameter.
> +#
>  # Features:
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
> @@ -485,7 +489,7 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram', 'switchover-abort'] }
>  
>  ##
>  # @MigrationCapabilityStatus:
> @@ -821,6 +825,10 @@
>  #     See description in @ZeroPageDetection.  Default is 'multifd'.
>  #     (since 9.0)
>  #
> +# @switchover-limit: Switchover limit (ms) that would be used to
> +#     intiate abort of live migration if the total switchover time
> +#     exceeded downtime_limit + switchover_limit (Since 9.1)

IMHO switchover_limit should not exist.

When 'switchover-abort' is enabled, then the existing downtime_limit
semantics should just be defined to also include the switchover
time.  The admin (on behalf of the guest owner) only cares about
the overall downtime experianced by the VM, not the individual
phases of the switch process.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


