Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A5FC83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWsA0-0007HF-Vx; Wed, 02 Jul 2025 03:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWs9y-0007GC-FY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uWs9w-0003es-1Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751442333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PQR2iF3FaLCUctJOpCoOmBqivCCF0XOLDg0HXfJmjvE=;
 b=Rnm6/KF4326Rcc/fcxf/2gae+ZfudxKUmRao3pr/Twm9IM4zWhDMvxe1hj0+5MUZ7Y3lqn
 4h9QcFI2CY4d8xUCANxaBmo8VYETJneQtEJW4a+YZa7ZbXBmrERUsonPWsKgJmGgPpW9j8
 Dqg7rLtUUrHaI6/ZfHvFbSgEWNL/+6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-KAK7cP4VO1qmN9bGNXIfFQ-1; Wed,
 02 Jul 2025 03:45:29 -0400
X-MC-Unique: KAK7cP4VO1qmN9bGNXIfFQ-1
X-Mimecast-MFC-AGG-ID: KAK7cP4VO1qmN9bGNXIfFQ_1751442328
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 932E218DA5CF; Wed,  2 Jul 2025 07:45:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.10])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B5371956053; Wed,  2 Jul 2025 07:45:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DA9D121E6A27; Wed, 02 Jul 2025 09:45:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?=
 <alex.bennee@linaro.org>,  Lukas Straub <lukasstraub2@web.de>,  Ani Sinha
 <anisinha@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,  Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,  qemu-block@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 03/18] qapi: add cross-references to block layer
In-Reply-To: <20250613203620.1283814-4-jsnow@redhat.com> (John Snow's message
 of "Fri, 13 Jun 2025 16:36:05 -0400")
References: <20250613203620.1283814-1-jsnow@redhat.com>
 <20250613203620.1283814-4-jsnow@redhat.com>
Date: Wed, 02 Jul 2025 09:45:23 +0200
Message-ID: <87frffqbn0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>  qapi/block-core.json   | 186 ++++++++++++++++++++---------------------
>  qapi/block-export.json |  36 ++++----
>  qapi/block.json        |  14 ++--
>  qapi/transaction.json  |  20 ++---
>  4 files changed, 128 insertions(+), 128 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f18db3149a3..74e6a81a5e9 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -3089,7 +3089,7 @@
>  # necessary cleanup.  This command requires that all involved jobs are
>  # in the PENDING state.
>  #
> -# For jobs in a transaction, instructing one job to finalize will
> +# For jobs in a :qapi:cmd:`transaction`, instructing one job to finalize will

Why and when do we need :qapi:cmd:?

>  # force ALL jobs in the transaction to finalize, so it is only
>  # necessary to instruct a single member job to finalize.
>  #

[...]

> @@ -5855,8 +5855,8 @@
>  # @BLOCK_JOB_PENDING:
>  #
>  # Emitted when a block job is awaiting explicit authorization to
> -# finalize graph changes via @job-finalize.  If this job is part
> -# of a transaction, it will not emit this event until the transaction
> +# finalize graph changes via `job-finalize`.  If this job is part
> +# of a :qapi:cmd:`transaction`, it will not emit this event until the transaction
>  # has converged first.
>  #
>  # @type: job type

[...]

> diff --git a/qapi/transaction.json b/qapi/transaction.json
> index 9d9e7af26cb..c02e402790e 100644
> --- a/qapi/transaction.json
> +++ b/qapi/transaction.json
> @@ -11,7 +11,7 @@
>  ##
>  # @Abort:
>  #
> -# This action can be used to test transaction failure.
> +# This action can be used to test `transaction` failure.

I have doubts about this one.

The comment isn't great to begin with.  It's from commit 78b18b78aa8
(blockdev: add Abort transaction):

    blockdev: add Abort transaction
    
    The Abort action can be used to test QMP 'transaction' failure.  Add it
    as the last action to exercise the .abort() and .cleanup() code paths
    for all previous actions.

So, Abort for testing transactionable commands' handling of transaction
failure, not for testing failure of the transaction command.  But the
link points to the command, and thus suggests it's about command failure.

Ideally, we'd point to some "introduction to transactions" text.  We
don't have one.

The other occurences of `transaction` are similarly problematic, except
for one noted below.  Let's leave the problematic ones alone in this
patch, to keep it mechanical and uncontroversial.

Not this patch's problem: the transaction command's doc comment is
*crap*.  Most of it discusses about snapshots, as if snapshots where the
only transactionable commands.  It talks about "the dictionary", and the
reader can only guess what that might mean.

>  #
>  # Since: 1.6
>  ##
> @@ -67,8 +67,8 @@
>  #
>  # Features:
>  #
> -# @deprecated: Member @drive-backup is deprecated.  Use member
> -#     @blockdev-backup instead.
> +# @deprecated: Member `drive-backup` is deprecated.  Use member
> +#     `blockdev-backup` instead.
>  #
>  # Since: 1.1
>  ##
> @@ -156,7 +156,7 @@
>  # @TransactionAction:
>  #
>  # A discriminated record of operations that can be performed with
> -# @transaction.
> +# `transaction`.

This link is a keeper.

>  #
>  # @type: the operation to be performed
>  #
> @@ -187,7 +187,7 @@
>  #
>  # @completion-mode: Controls how jobs launched asynchronously by
>  #     Actions will complete or fail as a group.  See
> -#     @ActionCompletionMode for details.
> +#     `ActionCompletionMode` for details.
>  #
>  # Since: 2.5
>  ##
> @@ -224,20 +224,20 @@
>  # support it, for example, qcow2, and rbd,
>  #
>  # On failure, QEMU will try delete the newly created internal snapshot
> -# in the transaction.  When an I/O error occurs during deletion, the
> +# in the `transaction`.  When an I/O error occurs during deletion, the
>  # user needs to fix it later with qemu-img or other command.
>  #
> -# @actions: List of @TransactionAction; information needed for the
> +# @actions: List of `TransactionAction`; information needed for the
>  #     respective operations.
>  #
>  # @properties: structure of additional options to control the
> -#     execution of the transaction.  See @TransactionProperties for
> +#     execution of the `transaction`.  See `TransactionProperties` for
>  #     additional detail.
>  #
>  # Errors:
> -#     - Any errors from commands in the transaction
> +#     - Any errors from commands in the `transaction`
>  #
> -# .. note:: The transaction aborts on the first failure.  Therefore,
> +# .. note:: The `transaction` aborts on the first failure.  Therefore,
>  #    there will be information on only one failed operation returned
>  #    in an error condition, and subsequent actions will not have been
>  #    attempted.


