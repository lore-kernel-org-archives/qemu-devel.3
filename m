Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD8C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 06:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0aQ7-000776-C8; Fri, 04 Apr 2025 02:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0aPx-00075U-O8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 02:20:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0aPu-0001n9-VG
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 02:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743747635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y4vSFDHA/S1LujYAkyph9Y7agrggL87V1HrxDD7eFXw=;
 b=hmHIXSBBHVSH455Z09dZ5RrIsk7HI1Gb/GXVhJJX0O1Xkns4aJUXbXT1XQXWO1kOzxz2Cr
 pS+R0jjj+FaIXx7hXaWDPBQPAgEyE0hPh8C67n+D0LCy9YmLuqOHudogntgRiOdgWoaq7I
 BTPU7Nq8ehBN273mZCwY+SmJLvtzu2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-138jdI7ROze0pTn5UFsS6A-1; Fri,
 04 Apr 2025 02:20:30 -0400
X-MC-Unique: 138jdI7ROze0pTn5UFsS6A-1
X-Mimecast-MFC-AGG-ID: 138jdI7ROze0pTn5UFsS6A_1743747629
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68FFC1800257; Fri,  4 Apr 2025 06:20:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 398A61809B67; Fri,  4 Apr 2025 06:20:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 98FC021E66C7; Fri, 04 Apr 2025 08:20:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  eblake@redhat.com,  jsnow@redhat.com,
 devel@lists.libvirt.org,  pkrempa@redhat.com,  michael.roth@amd.com,
 pbonzini@redhat.com
Subject: Re: [PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
In-Reply-To: <20250401155730.103718-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Tue, 1 Apr 2025 18:57:30 +0300")
References: <20250401155730.103718-1-vsementsov@yandex-team.ru>
Date: Fri, 04 Apr 2025 08:20:23 +0200
Message-ID: <8734eosb14.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> For change, pause, resume, complete, dismiss and finalize actions
> corresponding job- and block-job commands are almost equal. The
> difference is in find_block_job_locked() vs find_job_locked()
> functions. What's different?
>
> 1. find_block_job_locked() do check, is found job a block-job. This OK
>    when moving to more generic API, no needs to document this change.
>
> 2. find_block_job_locked() reports DeviceNotActive on failure, when
>    find_job_locked() reports GenericError. So, lets document this
>    difference in deprecated.txt. Still, for dismiss and finalize errors
>    are not documented at all, so be silent in deprecated.txt as well.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>
> Hi all!
>
> That's a continuation of my "[RFC 00/15] block job API"[1], exactly, the
> simplest part of it - deprecating block-job-* commands which simply
> duplicate job-* ones.
>
> Note that the old series was started with trying to introduce job-change
> command as substitution to both block-job-change (which only can change
> mirror copy-mode parameter), and block-job-set-speed. It was rather
> complicated and controversial attempt, which latest implemenation was
> "[PATCH v3 0/7] introduce job-change qmp command"[2].
>
> In [2] Kevin noted, that we'd better follow existing blockdev-reopen
> approach of changing options (i.e. specify all options) than introduce a
> new one. But, on the other hand, now I'm afraid, that rewriting in
> third tools simple call to (old good) block-job-set-speed into
> job-change(_all_options_ + changed speed) is too much work just for
> "having nice interface". And too much for the only two options we want
> to change.
>
> So, let's just start from something more obvious. Finally,
> we can simple keep block-job-set-speed and block-job-change as is,
> as they (unlike other block-job-* commands) are not duplicated by
> similar job-* commands.
>
> [1] https://patchew.org/QEMU/20240313150907.623462-1-vsementsov@yandex-team.ru/
> [2] https://patchew.org/QEMU/20241002140616.561652-1-vsementsov@yandex-team.ru/

Thank you for your efforts at making the interfaces cleaner, simpler,
and less redundant.

>  docs/about/deprecated.rst | 31 +++++++++++++++++++++++++++++++
>  qapi/block-core.json      | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e2b4f077d4..eed3356359 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -148,6 +148,37 @@ options are removed in favor of using explicit ``blockdev-create`` and
>  ``blockdev-add`` calls. See :doc:`/interop/live-block-operations` for
>  details.
>  
> +``block-job-pause`` (since 10.1)
> +'''''''''''''''''''''''''''''''
> +
> +Use ``job-pause`` instead. The only difference is that ``job-pause``
> +always reports GenericError on failure when ``block-job-pause`` reports
> +DeviceNotActive when block-job is not found.

block-job-pause's doc comment:

    # The operation will pause as soon as possible.  No event is emitted
    # when the operation is actually paused.  [...]

job-pause's:

    # The job will pause as soon as possible, which means transitioning
    # into the PAUSED state if it was RUNNING, or into STANDBY if it was
    # READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.

Either one of them is incorrect about event emission, or there is
another difference.

> +
> +``block-job-resume`` (since 10.1)
> +''''''''''''''''''''''''''''''''
> +
> +Use ``job-resume`` instead. The only difference is that ``job-resume``
> +always reports GenericError on failure when ``block-job-resume`` reports
> +DeviceNotActive when block-job is not found.

block-job-resume's doc comment:

    # This command also clears the error status of the job.

Nothing like that job-resume's.  Either one of them is incorrect /
incomplete about the error status clearance, or there is another
difference.

> +
> +``block-job-complete`` (since 10.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Use ``job-complete`` instead. The only difference is that ``job-complete``
> +always reports GenericError on failure when ``block-job-complete`` reports
> +DeviceNotActive when block-job is not found.

block-job-complete's doc comment:

    # Manually trigger completion of an active background block operation.
    # This is supported for drive mirroring, where it also switches the
    # device to write to the target path only.  The ability to complete is
    # signaled with a BLOCK_JOB_READY event.
    #
    # This command completes an active background block operation
    # synchronously.  The ordering of this command's return with the
    # BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
    # occurs during the processing of this command: 1) the command itself
    # will fail; 2) the error will be processed according to the
    # rerror/werror arguments that were specified when starting the
    # operation.

job-complete's:

    # Manually trigger completion of an active job in the READY state.

Is the latter lacking useful information?

> +
> +``block-job-dismiss`` (since 10.1)
> +'''''''''''''''''''''''''''''''''
> +
> +Use ``job-dismiss`` instead.

block-job-dismiss's doc comment:

    # For jobs that have already concluded, remove them from the
    # block-job-query list.  This command only needs to be run for jobs
    # which were started with QEMU 2.12+ job lifetime management
    # semantics.

I figure "started with QEMU 2.12+ job lifetime management semantics" is
an awkward way to say "auto-dismiss is false".

job-dismiss's doc comment:

    # Deletes a job that is in the CONCLUDED state.  This command only
    # needs to be run explicitly for jobs that don't have automatic
    # dismiss enabled.

@auto-dismiss defaults to true for jobs that support controlling it:
drive-backup, blockdev-backup, block-commit, drive-mirror,
blockdev-mirror, block-stream.  I guess these are exactly the commands
that already existed when we added "QEMU 2.12+ lifetime management".

I figure it's always false for the other jobs, but that doesn't seem to
be documented anywhere.

> +
> +``block-job-finalize`` (since 10.1)
> +''''''''''''''''''''''''''''''''''
> +
> +Use ``job-finalize`` instead.
> +

block-job-finalize's doc comment:

    # Once a job that has manual=true reaches the pending state, it can be
    # instructed to finalize any graph changes and do any necessary
    # cleanup via this command.  [...]

There is no member @manual anywhere in the QAPI schema.  I figure this
should be @auto-finalize.

job-finalize's doc comment:

    # Instructs all jobs in a transaction (or a single job if it is not
    # part of any transaction) to finalize any graph changes and do any
    # necessary cleanup.  This command requires that all involved jobs are
    # in the PENDING state.

Nothing on @auto-finalize.

@auto-finalize defaults to true for jobs that support controlling it.
These are exactly the ones that support @auto-dismiss.

I figure @auto-dismiss is always false for the other jobs, but that
doesn't seem to be documented anywhere.

The only other bits related to @auto-dismiss and @auto-finalize seem to
be two states in JobStatus:

    # @pending: The job has finished its work, but has finalization steps
    #     that it needs to make prior to completing.  These changes will
    #     require manual intervention via @job-finalize if auto-finalize
    #     was set to false.  These pending changes may still fail.
    [...]
    # @concluded: The job has finished all work.  If auto-dismiss was set
    #     to false, the job will remain in the query list until it is
    #     dismissed via @job-dismiss.


Is it possible to observe @concluded via QMP when @auto-dismiss is on?

What about @pending?

Aside: getting rid of auto-dismiss and auto-finalize some day would be
nice.

>  ``query-migrationthreads`` (since 9.2)
>  ''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e1..264be8413b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2968,6 +2968,11 @@
>  #     the name of the parameter), but since QEMU 2.7 it can have other
>  #     values.
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated.  Use @job-pause
> +#     instead.
> +#
>  # Errors:
>  #     - If no background operation is active on this device,
>  #       DeviceNotActive
> @@ -2975,6 +2980,7 @@
>  # Since: 1.3
>  ##
>  { 'command': 'block-job-pause', 'data': { 'device': 'str' },
> +  'features': ['deprecated'],
>    'allow-preconfig': true }
>  
>  ##
> @@ -2992,6 +2998,11 @@
>  #     the name of the parameter), but since QEMU 2.7 it can have other
>  #     values.
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated.  Use @job-resume
> +#     instead.
> +#
>  # Errors:
>  #     - If no background operation is active on this device,
>  #       DeviceNotActive
> @@ -2999,6 +3010,7 @@
>  # Since: 1.3
>  ##
>  { 'command': 'block-job-resume', 'data': { 'device': 'str' },
> +  'features': ['deprecated'],
>    'allow-preconfig': true }
>  
>  ##
> @@ -3023,6 +3035,11 @@
>  #     the name of the parameter), but since QEMU 2.7 it can have other
>  #     values.
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated.  Use @job-complete
> +#     instead.
> +#
>  # Errors:
>  #     - If no background operation is active on this device,
>  #       DeviceNotActive
> @@ -3030,6 +3047,7 @@
>  # Since: 1.3
>  ##
>  { 'command': 'block-job-complete', 'data': { 'device': 'str' },
> +  'features': ['deprecated'],
>    'allow-preconfig': true }
>  
>  ##
> @@ -3047,9 +3065,15 @@
>  #
>  # @id: The job identifier.
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated.  Use @job-dismiss
> +#     instead.
> +#
>  # Since: 2.12
>  ##
>  { 'command': 'block-job-dismiss', 'data': { 'id': 'str' },
> +  'features': ['deprecated'],
>    'allow-preconfig': true }
>  
>  ##
> @@ -3064,9 +3088,15 @@
>  #
>  # @id: The job identifier.
>  #
> +# Features:
> +#
> +# @deprecated: This command is deprecated.  Use @job-finalize
> +#     instead.
> +#
>  # Since: 2.12
>  ##
>  { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
> +  'features': ['deprecated'],
>    'allow-preconfig': true }
>  
>  ##


