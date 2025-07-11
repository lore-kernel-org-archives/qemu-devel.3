Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B97C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9LP-00069p-A6; Fri, 11 Jul 2025 04:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9CK-0000tO-BZ
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9CE-00073B-O2
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752222809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LsA6eAo8b1QqCEiAkyyYlZllBA1ZALFLqOa0SK9dJBo=;
 b=CWuf4qioi337qRi8HKz8FBn95Jo3zM/Q/sHHjLJ0yW0TXn+qkBRPZYDEIoqogsqm1tzrGj
 3ujBmL74WY8EJan+b2Hg9ClLfdyYOjyLrbT/Mf0yQIKatEXVHDPOVNWbhXDjrhofgz0BNH
 /a/tc0J9wjkNVqnZaEVfsgvgpfKUInM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-Cia62iroOjWXtIQPoyTdXQ-1; Fri,
 11 Jul 2025 04:33:25 -0400
X-MC-Unique: Cia62iroOjWXtIQPoyTdXQ-1
X-Mimecast-MFC-AGG-ID: Cia62iroOjWXtIQPoyTdXQ_1752222804
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2709818011CD; Fri, 11 Jul 2025 08:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 89FFB1956094; Fri, 11 Jul 2025 08:33:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4C2721E6A27; Fri, 11 Jul 2025 10:33:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Lukas Straub <lukasstraub2@web.de>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eduardo Habkost <eduardo@habkost.net>,  Peter Xu
 <peterx@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Jason Wang <jasowang@redhat.com>,  Igor
 Mammedov <imammedo@redhat.com>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 06/18] qapi: add cross-references to job.json
In-Reply-To: <20250711054005.60969-7-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:39:53 -0400")
References: <20250711054005.60969-1-jsnow@redhat.com>
 <20250711054005.60969-7-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 10:33:18 +0200
Message-ID: <8734b39lf5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/job.json | 71 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 35 deletions(-)
>
> diff --git a/qapi/job.json b/qapi/job.json
> index c1ddae9c0fe..a6026f6a810 100644
> --- a/qapi/job.json
> +++ b/qapi/job.json
> @@ -10,26 +10,26 @@
>  #
>  # Type of a background job.
>  #
> -# @commit: block commit job type, see "block-commit"
> +# @commit: block commit job type, see `block-commit`
>  #
> -# @stream: block stream job type, see "block-stream"
> +# @stream: block stream job type, see `block-stream`
>  #
> -# @mirror: drive mirror job type, see "drive-mirror"
> +# @mirror: drive mirror job type, see `drive-mirror`
>  #
> -# @backup: drive backup job type, see "drive-backup"
> +# @backup: drive backup job type, see `drive-backup`
>  #
> -# @create: image creation job type, see "blockdev-create" (since 3.0)
> +# @create: image creation job type, see `blockdev-create` (since 3.0)
>  #
> -# @amend: image options amend job type, see "x-blockdev-amend"
> +# @amend: image options amend job type, see `x-blockdev-amend`
>  #     (since 5.1)
>  #
> -# @snapshot-load: snapshot load job type, see "snapshot-load"
> +# @snapshot-load: snapshot load job type, see `snapshot-load`
>  #     (since 6.0)
>  #
> -# @snapshot-save: snapshot save job type, see "snapshot-save"
> +# @snapshot-save: snapshot save job type, see `snapshot-save`
>  #     (since 6.0)
>  #
> -# @snapshot-delete: snapshot delete job type, see "snapshot-delete"
> +# @snapshot-delete: snapshot delete job type, see `snapshot-delete`
>  #     (since 6.0)
>  #
>  # Since: 1.7
> @@ -59,13 +59,14 @@
>  # @standby: The job is ready, but paused.  This is nearly identical to
>  #     @paused.  The job may return to @ready or otherwise be canceled.
>  #
> -# @waiting: The job is waiting for other jobs in the transaction to
> -#     converge to the waiting state.  This status will likely not be
> -#     visible for the last job in a transaction.
> +# @waiting: The job is waiting for other jobs in the
> +#     transaction to converge to the waiting state.  This
> +#     status will likely not be visible for the last job in a
> +#     transaction.

Line breaks only, looks like an accident.  Let's drop the hunk.

>  #
>  # @pending: The job has finished its work, but has finalization steps
>  #     that it needs to make prior to completing.  These changes will
> -#     require manual intervention via @job-finalize if auto-finalize
> +#     require manual intervention via `job-finalize` if auto-finalize
>  #     was set to false.  These pending changes may still fail.
>  #
>  # @aborting: The job is in the process of being aborted, and will
> @@ -75,7 +76,7 @@
>  #
>  # @concluded: The job has finished all work.  If auto-dismiss was set
>  #     to false, the job will remain in this state until it is
> -#     dismissed via @job-dismiss.
> +#     dismissed via `job-dismiss`.
>  #
>  # @null: The job is in the process of being dismantled.  This state
>  #     should not ever be visible externally.
> @@ -91,21 +92,21 @@
>  #
>  # Represents command verbs that can be applied to a job.
>  #
> -# @cancel: see @job-cancel
> +# @cancel: see `job-cancel`
>  #
> -# @pause: see @job-pause
> +# @pause: see `job-pause`
>  #
> -# @resume: see @job-resume
> +# @resume: see `job-resume`
>  #
> -# @set-speed: see @block-job-set-speed
> +# @set-speed: see `block-job-set-speed`
>  #
> -# @complete: see @job-complete
> +# @complete: see `job-complete`
>  #
> -# @dismiss: see @job-dismiss
> +# @dismiss: see `job-dismiss`
>  #
> -# @finalize: see @job-finalize
> +# @finalize: see `job-finalize`
>  #
> -# @change: see @block-job-change (since 8.2)
> +# @change: see `block-job-change` (since 8.2)
>  #
>  # Since: 2.12
>  ##
> @@ -138,7 +139,7 @@
>  #
>  # The job will pause as soon as possible, which means transitioning
>  # into the PAUSED state if it was RUNNING, or into STANDBY if it was
> -# READY.  The corresponding JOB_STATUS_CHANGE event will be emitted.
> +# READY.  The corresponding `JOB_STATUS_CHANGE` event will be emitted.
>  #
>  # Cancelling a paused job automatically resumes it.
>  #
> @@ -173,7 +174,7 @@
>  # cancellation.
>  #
>  # The job will cancel as soon as possible and then emit a
> -# JOB_STATUS_CHANGE event.  Usually, the status will change to
> +# `JOB_STATUS_CHANGE` event.  Usually, the status will change to
>  # ABORTING, but it is possible that a job successfully completes (e.g.
>  # because it was almost done and there was no opportunity to cancel
>  # earlier than completing the job) and transitions to PENDING instead.
> @@ -192,14 +193,14 @@
>  #
>  # This is supported only for drive mirroring, where it also switches
>  # the device to write to the target path only.  Note that drive
> -# mirroring includes drive-mirror, blockdev-mirror and block-commit
> +# mirroring includes `drive-mirror`, `blockdev-mirror` and `block-commit`
>  # job (only in case of "active commit", when the node being commited
>  # is used by the guest).  The ability to complete is signaled with a
> -# BLOCK_JOB_READY event.
> +# `BLOCK_JOB_READY` event.
>  #
>  # This command completes an active background block operation
>  # synchronously.  The ordering of this command's return with the
> -# BLOCK_JOB_COMPLETED event is not defined.  Note that if an I/O error
> +# `BLOCK_JOB_COMPLETED` event is not defined.  Note that if an I/O error
>  # occurs during the processing of this command: 1) the command itself
>  # will fail; 2) the error will be processed according to the
>  # rerror/werror arguments that were specified when starting the
> @@ -217,14 +218,14 @@
>  # Deletes a job that is in the CONCLUDED state.  This command only
>  # needs to be run explicitly for jobs that don't have automatic
>  # dismiss enabled.  In turn, automatic dismiss may be enabled only
> -# for jobs that have @auto-dismiss option, which are drive-backup,
> -# blockdev-backup, drive-mirror, blockdev-mirror, block-commit and
> -# block-stream.  @auto-dismiss is enabled by default for these
> +# for jobs that have @auto-dismiss option, which are `drive-backup`,
> +# `blockdev-backup`, `drive-mirror`, `blockdev-mirror`, `block-commit` and
> +# `block-stream`.  @auto-dismiss is enabled by default for these
>  # jobs.
>  #
>  # This command will refuse to operate on any job that has not yet
>  # reached its terminal state, CONCLUDED.  For jobs that make use of
> -# the JOB_READY event, job-cancel or job-complete will still need to
> +# the JOB_READY event, `job-cancel` or `job-complete` will still need to
>  # be used as appropriate.
>  #
>  # @id: The job identifier.
> @@ -236,10 +237,10 @@
>  ##
>  # @job-finalize:
>  #
> -# Instructs all jobs in a transaction (or a single job if it is not
> -# part of any transaction) to finalize any graph changes and do any
> -# necessary cleanup.  This command requires that all involved jobs are
> -# in the PENDING state.
> +# Instructs all jobs in a :qapi:cmd:`transaction` (or a single job if it
> +# is not part of any transaction) to finalize any graph changes and do
> +# any necessary cleanup.  This command requires that all involved jobs
> +# are in the PENDING state.
>  #
>  # For jobs in a transaction, instructing one job to finalize will
>  # force ALL jobs in the transaction to finalize, so it is only

You dropped the `transaction` references I asked you to drop except for
this one.  Looks like an accident.  Let's drop the hunk.


