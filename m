Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32609CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 15:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwivJ-0007v6-Fm; Thu, 11 Sep 2025 11:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwivG-0007uZ-9W
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:09:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uwivE-0006tQ-18
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 11:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757603353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnoq4CAsD+we8U0Odad9LfhrPkcOd710QDgu4Q/MlTo=;
 b=bZo3J3p/aWgIz+V08J2LfzRsFYe9ICRVy8s0tsCEY4Jwx+bRH3nwG3cMp/9PgnZatH+wwI
 peNpiT3blD+YATnmwS8Dr6evxQ/uBQoW+VUObVGb9qfMvJLtu3Bce8UONARjzVFvRLQI69
 QFspoJUE47Lz7xmhrXucEjZrNSqFssU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-cx8fxh-uN6eGA0xfk-h6Cg-1; Thu,
 11 Sep 2025 11:09:12 -0400
X-MC-Unique: cx8fxh-uN6eGA0xfk-h6Cg-1
X-Mimecast-MFC-AGG-ID: cx8fxh-uN6eGA0xfk-h6Cg_1757603351
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2FE31800451; Thu, 11 Sep 2025 15:09:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6132D1944CCA; Thu, 11 Sep 2025 15:09:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91E3A21E6A27; Thu, 11 Sep 2025 17:09:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
In-Reply-To: <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 14 Aug 2025 10:17:21 -0700")
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
Date: Thu, 11 Sep 2025 17:09:07 +0200
Message-ID: <87v7lpdo18.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Add the cpr-exec migration mode.  Usage:
>   qemu-system-$arch -machine aux-ram-share=on ...
>   migrate_set_parameter mode cpr-exec
>   migrate_set_parameter cpr-exec-command \
>     <arg1> <arg2> ... -incoming <uri-1> \
>   migrate -d <uri-1>
>
> The migrate command stops the VM, saves state to uri-1,
> directly exec's a new version of QEMU on the same host,
> replacing the original process while retaining its PID, and
> loads state from uri-1.  Guest RAM is preserved in place,
> albeit with new virtual addresses.
>
> The new QEMU process is started by exec'ing the command
> specified by the @cpr-exec-command parameter.  The first word of
> the command is the binary, and the remaining words are its
> arguments.  The command may be a direct invocation of new QEMU,
> or may be a non-QEMU command that exec's the new QEMU binary.
>
> This mode creates a second migration channel that is not visible
> to the user.  At the start of migration, old QEMU saves CPR state
> to the second channel, and at the end of migration, it tells the
> main loop to call cpr_exec.  New QEMU loads CPR state early, before
> objects are created.
>
> Because old QEMU terminates when new QEMU starts, one cannot
> stream data between the two, so uri-1 must be a type,
> such as a file, that accepts all data before old QEMU exits.
> Otherwise, old QEMU may quietly block writing to the channel.
>
> Memory-backend objects must have the share=on attribute, but
> memory-backend-epc is not supported.  The VM must be started with
> the '-machine aux-ram-share=on' option, which allows anonymous
> memory to be transferred in place to the new process.  The memfds
> are kept open across exec by clearing the close-on-exec flag, their
> values are saved in CPR state, and they are mmap'd in new QEMU.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  qapi/migration.json       | 25 +++++++++++++++-
>  include/migration/cpr.h   |  1 +
>  migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>  migration/cpr.c           | 26 ++++++++++++++++-
>  migration/migration.c     | 10 ++++++-
>  migration/ram.c           |  1 +
>  migration/vmstate-types.c |  8 +++++
>  migration/trace-events    |  1 +
>  8 files changed, 143 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index ea410fd..cbc90e8 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -694,9 +694,32 @@
>  #     until you issue the `migrate-incoming` command.
>  #
>  #     (since 10.0)
> +#
> +# @cpr-exec: The migrate command stops the VM, saves state to the
> +#     migration channel, directly exec's a new version of QEMU on the
> +#     same host, replacing the original process while retaining its
> +#     PID, and loads state from the channel.  Guest RAM is preserved
> +#     in place.  Devices and their pinned pages are also preserved for
> +#     VFIO and IOMMUFD.
> +#
> +#     Old QEMU starts new QEMU by exec'ing the command specified by
> +#     the @cpr-exec-command parameter.  The command may be a direct
> +#     invocation of new QEMU, or may be a non-QEMU command that exec's
> +#     the new QEMU binary.

Not sure we need the last sentence.

If we keep it, maybe say "a wrapper script" instead of "a non-QEMU
command".

> +#
> +#     Because old QEMU terminates when new QEMU starts, one cannot
> +#     stream data between the two, so the channel must be a type,
> +#     such as a file, that accepts all data before old QEMU exits.
> +#     Otherwise, old QEMU may quietly block writing to the channel.
> +#
> +#     Memory-backend objects must have the share=on attribute, but
> +#     memory-backend-epc is not supported.  The VM must be started
> +#     with the '-machine aux-ram-share=on' option.

I assume violations of this constraint fail cleanly.

> +#
> +#     (since 10.2)
>  ##
>  { 'enum': 'MigMode',
> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>  
>  ##
>  # @ZeroPageDetection:

Acked-by: Markus Armbruster <armbru@redhat.com>

[...]


