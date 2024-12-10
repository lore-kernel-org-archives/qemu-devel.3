Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FFFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKzKX-0007Mo-0b; Tue, 10 Dec 2024 07:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKzKU-0007Ma-Sp
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 07:27:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKzKS-0002lM-MN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 07:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733833619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2mGlA4KyEv3/Zo6RqZsFbOu9RvToTyGkfl5+YTUyogY=;
 b=VVV6fgN5gtMPbD3B5f4LRNrF3kx3A/a8wp/WYkW5gsJOPrqT8ixsRJyibASORpmKSeVVGu
 atSe4Mik3S1wWswOua5q6RtGrKy/i7Fei96x/bK6V0c59umvjfoh703v4ShmB2DivGIGNa
 /WqWbPOJt33/pwQRlPH5zlETqv+MdHI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-fqsXE63FO-e9pXzoVbDIRQ-1; Tue,
 10 Dec 2024 07:26:55 -0500
X-MC-Unique: fqsXE63FO-e9pXzoVbDIRQ-1
X-Mimecast-MFC-AGG-ID: fqsXE63FO-e9pXzoVbDIRQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B51C195609F; Tue, 10 Dec 2024 12:26:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40E6319560A2; Tue, 10 Dec 2024 12:26:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 089EA21EC35A; Tue, 10 Dec 2024 13:26:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 14/19] migration: cpr-transfer mode
In-Reply-To: <1733145611-62315-15-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Mon, 2 Dec 2024 05:20:06 -0800")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-15-git-send-email-steven.sistare@oracle.com>
Date: Tue, 10 Dec 2024 13:26:51 +0100
Message-ID: <87ikrr67w4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
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

> Add the cpr-transfer migration mode.  Usage:
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

Much technical detail here that won't make sense to the reader until
further down, but next to nothing on what the thing actually
accomplishes.  Makes the commit message unnecessarily hard to
understand.  But please read on.

> The migrate command stops the VM, saves CPR state to cpr-channel, saves
> normal migration state to main-uri, and old QEMU enters the postmigrate
> state.  The user starts new QEMU on the same host as old QEMU, with the
> same arguments as old QEMU,

Any additional requirements over traditional migration?

There, "same arguments" is sufficient, but not necessary.  For instance,
changing certain backends is quite possible.

>                             plus two -incoming options.

Two -incoming options to define two migration channels, the traditional
one of MigrationChannelType "main", and an another one of
MigrationChannelType "cpr"?

>                                                          Guest RAM is
> preserved in place, albeit with new virtual addresses in new QEMU.
>
> This mode requires a second migration channel of type "cpr", in the
> channel arguments on the outgoing side, and in a second -incoming
> command-line parameter on the incoming side.
>
> Memory-backend objects must have the share=on attribute, but
> memory-backend-epc is not supported.  The VM must be started with
> the '-machine aux-ram-share=on' option, which allows anonymous
> memory to be transferred in place to the new process.  The memfds
> are kept open by sending the descriptors to new QEMU via the CPR
> channel, which must support SCM_RIGHTS, and they are mmap'd in new QEMU.
>
> The implementation splits qmp_migrate into start and finish functions.
> Start sends CPR state to new QEMU, which responds by closing the CPR
> channel.  Old QEMU detects the HUP then calls finish, which connects
> the main migration channel.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I'd lead with a brief explanation of the feature and its benefits.
Could steam from the cover letter like this:

  New migration mode cpr-transfer mode enables transferring a guest to a
  new QEMU instance on the same host with minimal guest pause time, by
  preserving guest RAM in place, albeit with new virtual addresses in
  new QEMU, and by preserving device file descriptors.

Then talk about required special setup.  I see aux-ram-share=on.
Anything else?  Any differences between source and destination QEMU
there?

Then talk about the two channels.  First what they do, second how to
create their destination end with -incoming, third how to create their
source end with "migrate".

Finally mention whatever technical detail you believe needs mentioning
here.

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index a26960b..1bc963f 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -614,9 +614,44 @@
>  #     or COLO.
>  #
>  #     (since 8.2)
> +#
> +# @cpr-transfer: This mode allows the user to transfer a guest to a
> +#     new QEMU instance on the same host with minimal guest pause
> +#     time, by preserving guest RAM in place, albeit with new virtual
> +#     addresses in new QEMU.
> +#
> +#     The user starts new QEMU on the same host as old QEMU, with the
> +#     the same arguments as old QEMU, plus the -incoming option.

Two of them?

> +#                                                                 The
> +#     user issues the migrate command to old QEMU, which stops the VM,
> +#     saves state to the migration channels, and enters the
> +#     postmigrate state.  Execution resumes in new QEMU.

The commit message also mentions file descriptors are migrared over.
Worth mentioning here, too?

> +#
> +#     This mode requires a second migration channel type "cpr" in the
> +#     channel arguments on the outgoing side.  The channel must be a
> +#     type, such as unix socket, that supports SCM_RIGHTS.  However,

This is vague.  Would anything but a UNIX domain socket work?

Applies to both source and destination end?

> +#     the cpr channel cannot be added to the list of channels for a
> +#     migrate-incoming command, because it must be read before new
> +#     QEMU opens a monitor.

Ugh!  Remind me, why is that the case?

> +#                            Instead, the user passes the channel as a
> +#     second -incoming command-line argument to new QEMU using JSON
> +#     syntax.
> +#
> +#     Memory-backend objects must have the share=on attribute, but
> +#     memory-backend-epc is not supported.  The VM must be started
> +#     with the '-machine aux-ram-share=on' option.

What happens when the conditions aren't met?  migrate command fails
with a useful error message?

> +#
> +#     The incoming migration channel cannot be a file type, and for
> +#     the tcp type, the port cannot be 0 (meaning dynamically choose
> +#     a port).

Which of the two channels are you discussing?

> +#
> +#     When using -incoming defer, you must issue the migrate command
> +#     to old QEMU before issuing any monitor commands to new QEMU.

I'm confused.  Not even qmp_capabilities?  Why?

> +#     However, new QEMU does not open and read the migration stream
> +#     until you issue the migrate incoming command.
> +#
> +#     (since 10.0)
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>  
>  ##
>  # @ZeroPageDetection:

[...]


