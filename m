Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A391E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8L2-00013P-Pz; Tue, 07 Jan 2025 07:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV8Ky-0000zF-Pv
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:05:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tV8Kw-0007aD-Ki
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736251529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SsGVkR2GPSmKQ0BN3mgiFjQzgJ3K4A4z8hdH9ACqaeQ=;
 b=T4clMuQhzvlRVmHubzy6L0MasErLadc+6trTDSuebDgrEhpcs3Qh4YPbDq0qoiwzTvOx0+
 Pg78gBH5lIWUQYKjDMHNO0AAJLYjnLaEVZ8z4JNA9NiuQTtbY3atncJDOg+kq7UwL3DZx0
 8mfi+KdhHOqGkjdwIxrMR8Pj3IQEGag=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-Co0jDsHCM1Kl30vJeOQpNw-1; Tue,
 07 Jan 2025 07:05:25 -0500
X-MC-Unique: Co0jDsHCM1Kl30vJeOQpNw-1
X-Mimecast-MFC-AGG-ID: Co0jDsHCM1Kl30vJeOQpNw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D5BD19560BA; Tue,  7 Jan 2025 12:05:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE18D19560A2; Tue,  7 Jan 2025 12:05:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8135C21E6924; Tue, 07 Jan 2025 13:05:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange"
 <berrange@redhat.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
In-Reply-To: <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Tue, 24 Dec 2024 08:17:00 -0800")
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
Date: Tue, 07 Jan 2025 13:05:20 +0100
Message-ID: <87ed1eakxr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add the cpr-transfer migration mode, which allows the user to transfer
> a guest to a new QEMU instance on the same host with minimal guest pause
> time, by preserving guest RAM in place, albeit with new virtual addresses
> in new QEMU, and by preserving device file descriptors.  Pages that were
> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
> descriptor of the device that locked them remains open.
>
> cpr-transfer preserves memory and devices descriptors by sending them to
> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
> be sent over the normal migration channel, because devices and backends
> are created prior to reading the channel,

Is that an artifact of the way QEMU starts up, or is it fundamental?

>                                           so this mode sends CPR state
> over a second "cpr" migration channel.  New QEMU reads the cpr channel
> prior to creating devices or backends.  The user specifies the cpr channel
> in the channel arguments on the outgoing side, and in a second -incoming
> command-line parameter on the incoming side.
>
> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
> which allows anonymous memory to be transferred in place to the new process
> by transferring a memory descriptor for each ram block.  Memory-backend
> objects must have the share=on attribute, but memory-backend-epc is not
> supported.
>
> The user starts new QEMU on the same host as old QEMU, with command-line
> arguments to create the same machine, plus the -incoming option for the
> main migration channel, like normal live migration.  In addition, the user
> adds a second -incoming option with channel type "cpr".  The CPR channel
> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>
> To initiate CPR, the user issues a migrate command to old QEMU, adding
> a second migration channel of type "cpr" in the channels argument.
> Old QEMU stops the VM, saves state to the migration channels, and enters
> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
> resumes.
>
> The implementation splits qmp_migrate into start and finish functions.
> Start sends CPR state to new QEMU, which responds by closing the CPR
> channel.  Old QEMU detects the HUP then calls finish, which connects the
> main migration channel.
>
> In summary, the usage is:
>
>   qemu-system-$arch -machine aux-ram-share=on ...
>
>   start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>
>   Issue commands to old QEMU:
>     migrate_set_parameter mode cpr-transfer
>
>     {"execute": "migrate", ...
>         {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

[...]

> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index f31deb3..2210f0c 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -15,6 +15,7 @@
>  #include "qemu-file.h"
>  #include "migration.h"
>  #include "migration/vmstate.h"
> +#include "migration/client-options.h"
>  #include "qemu/error-report.h"
>  #include "qemu/queue.h"
>  #include "trace.h"
> diff --git a/qapi/migration.json b/qapi/migration.json
> index a605dc2..35309dc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -614,9 +614,47 @@
>  #     or COLO.
>  #
>  #     (since 8.2)
> +#
> +# @cpr-transfer: This mode allows the user to transfer a guest to a
> +#     new QEMU instance on the same host with minimal guest pause
> +#     time, by preserving guest RAM in place, albeit with new virtual
> +#     addresses in new QEMU.  Devices and their pinned pages will also
> +#     be preserved in a future QEMU release.

Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
guest pause time by transferring guest RAM without copying it."

If you want to mention the guest RAM mapping differs between old and new
QEMU, that's fine, but it's also detail, so I'd do it further down.

> +#
> +#     The user starts new QEMU on the same host as old QEMU, with
> +#     command-line arguments to create the same machine, plus the
> +#     -incoming option for the main migration channel, like normal
> +#     live migration.  In addition, the user adds a second -incoming
> +#     option with channel type "cpr".  The CPR channel address must
> +#     be a type, such as unix socket, that supports SCM_RIGHTS.

Permit me to indulge in a bit of pedantry...  A channel address doesn't
support SCM_RIGHTS, only a channel may.  A channel supports it when it
is backed by a UNIX domain socket.  The channel's socket's transport
type need not be 'unix' for that, it could also be 'fd'.

Suggest something like "This CPR channel must be a UNIX domain socket."

If you want to say why, that's fine: "This CPR channel must support file
descriptor transfer, i.e. it must be a UNIX domain socket."

If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
UNIX domain socket."

> +#
> +#     To initiate CPR, the user issues a migrate command to old QEMU,
> +#     adding a second migration channel of type "cpr" in the channels

in the channel's

> +#     argument.  Old QEMU stops the VM, saves state to the migration
> +#     channels, and enters the postmigrate state.  Execution resumes
> +#     in new QEMU.
> +#
> +#     New QEMU reads the CPR channel before opening a monitor, hence
> +#     the CPR channel cannot be specified in the list of channels for
> +#     a migrate-incoming command.  It may only be specified on the
> +#     command line.

This is a restriction that could conceivably be lifted in the future,
right?

What happens if a user tries to specify it with migrate-incoming?  Fails
cleanly?  What's the error message?

Maybe simply:

         Currently, the CPR channel can only be specified on the command
         line, not with the migrate-incoming command.

with a big, fat comment explaining the restriction next to the spot
that reports the error.

> +#
> +#     The main channel address cannot be a file type, and for the tcp
> +#     type, the port cannot be 0 (meaning dynamically choose a port).

What's "the tcp type"?  URI "tcp:..." / channel
addr.transport=socket,addr.type=inet?

> +#
> +#     Memory-backend objects must have the share=on attribute, but
> +#     memory-backend-epc is not supported.  The VM must be started
> +#     with the '-machine aux-ram-share=on' option.
> +#
> +#     When using -incoming defer, you must issue the migrate command
> +#     to old QEMU before issuing any monitor commands to new QEMU.
> +#     However, new QEMU does not open and read the migration stream
> +#     until you issue the migrate incoming command.

I think some (all?) instances of "old QEMU" and "new QEMU" would read
better as "the old QEMU" and "the new QEMU".

> +#
> +#     (since 10.0)
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>  
>  ##
>  # @ZeroPageDetection:
> @@ -1578,11 +1616,12 @@
>  # The migration channel-type request options.
>  #
>  # @main: Main outbound migration channel.
> +# @cpr: Checkpoint and restart state channel.
>  #
>  # Since: 8.1
>  ##
>  { 'enum': 'MigrationChannelType',
> -  'data': [ 'main' ] }
> +  'data': [ 'main', 'cpr' ] }
>  
>  ##
>  # @MigrationChannel:


