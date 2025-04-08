Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC34C369A4
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 09:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u25FA-0001iE-Fg; Tue, 08 Apr 2025 05:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u25F0-0001hY-N6
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u25Ey-0007oA-FS
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 05:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744104449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMatneAWevYAc+lcOxRW8LhQ535JGWLNZNB11/znHUc=;
 b=cZIhwnrdBU3rZu8kxdycTVxp2PljHC/HFSPNyjlJf5zaijD0TKlAlezHucVX76x7PEHKTS
 +FHmDIFH5Z/hg6JEtw6yX2kQsONAOO6L91WRlttT2C4L5zG4Pbj/trkOduOqTtf6Yi+Omd
 kjPUaRJb9DdEfWvVDKwyksfXMmNfAYI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-OcCbdq3pOw6sc7sM6aUCoA-1; Tue,
 08 Apr 2025 05:27:28 -0400
X-MC-Unique: OcCbdq3pOw6sc7sM6aUCoA-1
X-Mimecast-MFC-AGG-ID: OcCbdq3pOw6sc7sM6aUCoA_1744104447
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4DDC180049D; Tue,  8 Apr 2025 09:27:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAD01180B48C; Tue,  8 Apr 2025 09:27:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D76421E6773; Tue, 08 Apr 2025 11:27:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  hreitz@redhat.com,
 kwolf@redhat.com,  armbru@redhat.com,  eblake@redhat.com,
 jsnow@redhat.com,  devel@lists.libvirt.org,  pkrempa@redhat.com,
 michael.roth@amd.com,  pbonzini@redhat.com
Subject: Re: [PATCH v2 1/2] qapi: synchronize jobs and block-jobs documentation
In-Reply-To: <20250404193154.707145-2-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 4 Apr 2025 22:31:53 +0300")
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
 <20250404193154.707145-2-vsementsov@yandex-team.ru>
Date: Tue, 08 Apr 2025 11:27:23 +0200
Message-ID: <877c3vm29w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Actualize documentation and synchronize it for commands which actually
> call the same functions internally.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qapi/block-core.json | 59 +++++++++++++++++++++++++-------------------
>  qapi/job.json        | 29 ++++++++++++++++++++--
>  2 files changed, 61 insertions(+), 27 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index b1937780e1..d74a1f8b8b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2956,13 +2956,14 @@
>  #
>  # Pause an active background block operation.
>  #
> -# This command returns immediately after marking the active background
> -# block operation for pausing.  It is an error to call this command if
> -# no operation is in progress or if the job is already paused.
> +# This command returns immediately after marking the active job for
> +# pausing.  Pausing an already paused job is an error.
> +#
> +# The job will pause as soon as possible, which means transitioning
> +# into the PAUSED state if it was RUNNING, or into STANDBY if it was
> +# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
>  #
> -# The operation will pause as soon as possible.  No event is emitted
> -# when the operation is actually paused.  Cancelling a paused job
> -# automatically resumes it.
> +# Cancelling a paused job automatically resumes it.
>  #
>  # @device: The job identifier.  This used to be a device name (hence
>  #     the name of the parameter), but since QEMU 2.7 it can have other
> @@ -2982,9 +2983,8 @@
>  #
>  # Resume an active background block operation.
>  #
> -# This command returns immediately after resuming a paused background
> -# block operation.  It is an error to call this command if no
> -# operation is in progress or if the job is not paused.
> +# This command returns immediately after resuming a paused job.
> +# Resuming an already running job is an error.
>  #
>  # This command also clears the error status of the job.
>  #
> @@ -3004,10 +3004,14 @@
>  ##
>  # @block-job-complete:
>  #
> -# Manually trigger completion of an active background block operation.
> -# This is supported for drive mirroring, where it also switches the
> -# device to write to the target path only.  The ability to complete is
> -# signaled with a BLOCK_JOB_READY event.
> +# Manually trigger completion of an active job in the READY or STANDBY
> +# state.  Completing the job in any other state is an error.
> +#
> +# This is supported only for drive mirroring (which includes
> +# drive-mirror, blockdev-mirror and block-commit job (only in case of
> +# "active commit", when the node being commited is used by the guest)),

I agree with Eric: needs a rephrasing to avoid the nested parenthesis.

> +# where it also switches the device to write to the target path only.
> +# The ability to complete is signaled with a BLOCK_JOB_READY event.
>  #
>  # This command completes an active background block operation
>  # synchronously.  The ordering of this command's return with the
> @@ -3017,8 +3021,6 @@
>  # rerror/werror arguments that were specified when starting the
>  # operation.
>  #
> -# A cancelled or paused job cannot be completed.
> -#
>  # @device: The job identifier.  This used to be a device name (hence
>  #     the name of the parameter), but since QEMU 2.7 it can have other
>  #     values.
> @@ -3035,10 +3037,12 @@
>  ##
>  # @block-job-dismiss:
>  #
> -# For jobs that have already concluded, remove them from the
> -# block-job-query list.  This command only needs to be run for jobs
> -# which were started with QEMU 2.12+ job lifetime management
> -# semantics.
> +# Deletes a job that is in the CONCLUDED state.  This command only
> +# needs to be run explicitly for jobs that don't have automatic
> +# dismiss enabled. In turn, automatic dismiss may be enabled only
> +# for jobs that have @auto-dismiss option, which are drive-backup,
> +# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
> +# block-stream.
>  #
>  # This command will refuse to operate on any job that has not yet
>  # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
> @@ -3055,12 +3059,17 @@
>  ##
>  # @block-job-finalize:
>  #
> -# Once a job that has manual=true reaches the pending state, it can be
> -# instructed to finalize any graph changes and do any necessary
> -# cleanup via this command.  For jobs in a transaction, instructing
> -# one job to finalize will force ALL jobs in the transaction to
> -# finalize, so it is only necessary to instruct a single member job to
> -# finalize.
> +# Instructs all jobs in a transaction (or a single job if it is not
> +# part of any transaction) to finalize any graph changes and do any
> +# necessary cleanup.  This command requires that all involved jobs are
> +# in the PENDING state.
> +#
> +# For jobs in a transaction, instructing one job to finalize will
> +# force ALL jobs in the transaction to finalize, so it is only
> +# necessary to instruct a single member job to finalize.
> +#
> +# The command is applicable only to jobs which have @auto-finalize option
> +# and only when this option is set to false.
>  #
>  # @id: The job identifier.
>  #
> diff --git a/qapi/job.json b/qapi/job.json
> index cfc3beedd2..c8736f2a05 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -156,6 +156,9 @@
>  # This command returns immediately after resuming a paused job.
>  # Resuming an already running job is an error.
>  #
> +# This command also clears the error status for block-jobs (stream,
> +# commit, mirror, backup).
> +#
>  # @id: The job identifier.
>  #
>  # Since: 3.0
> @@ -184,7 +187,22 @@
>  ##
>  # @job-complete:
>  #
> -# Manually trigger completion of an active job in the READY state.
> +# Manually trigger completion of an active job in the READY or STANDBY
> +# state.  Completing the job in any other state is an error.
> +#
> +# This is supported only for drive mirroring (which includes
> +# drive-mirror, blockdev-mirror and block-commit job (only in case of
> +# "active commit", when the node being commited is used by the guest)),
> +# where it also switches the device to write to the target path only.
> +# The ability to complete is signaled with a BLOCK_JOB_READY event.
> +#
> +# This command completes an active background block operation
> +# synchronously.  The ordering of this command's return with the
> +# BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
> +# occurs during the processing of this command: 1) the command itself
> +# will fail; 2) the error will be processed according to the
> +# rerror/werror arguments that were specified when starting the
> +# operation.
>  #
>  # @id: The job identifier.
>  #
> @@ -197,7 +215,11 @@
>  #
>  # Deletes a job that is in the CONCLUDED state.  This command only
>  # needs to be run explicitly for jobs that don't have automatic
> -# dismiss enabled.
> +# dismiss enabled. In turn, automatic dismiss may be enabled only
> +# for jobs that have @auto-dismiss option, which are drive-backup,
> +# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
> +# block-stream. And historically it's enabled by default for these
> +# jobs.

Scratch "And historically"?

>  #
>  # This command will refuse to operate on any job that has not yet
>  # reached its terminal state, JOB_STATUS_CONCLUDED.  For jobs that
> @@ -222,6 +244,9 @@
>  # force ALL jobs in the transaction to finalize, so it is only
>  # necessary to instruct a single member job to finalize.
>  #
> +# The command is applicable only to jobs which have @auto-finalize option
> +# and only when this option is set to false.
> +#
>  # @id: The identifier of any job in the transaction, or of a job that
>  #     is not part of any transaction.
>  #


