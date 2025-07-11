Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F3BC83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 08:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9Xq-00022o-QG; Fri, 11 Jul 2025 04:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9Qt-0007V1-96
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ua9Qr-0002jq-Lp
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=at/nbeFYJMH5RLpDUXZNo8nUj1vyjG+skzjPpYRV5bE=;
 b=eGMqo732Hp0X0S9w71BEoF6drvDV7c9MexKTkXix9iDK7gUaSzpGUZX7zPY9OcO+51usb+
 ycjm4zd6CUNFuhrWCUvzdNzDA5VGkdSIwQidd0lUEptbZc4tpHNlsb5Ocackvqp6ljnG0B
 M0FYoMaCU18pezZgn8FJNrZ06jpeheY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Hd4TBjivP3mxOFzeYV-ojw-1; Fri,
 11 Jul 2025 04:48:33 -0400
X-MC-Unique: Hd4TBjivP3mxOFzeYV-ojw-1
X-Mimecast-MFC-AGG-ID: Hd4TBjivP3mxOFzeYV-ojw_1752223711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB5821800368; Fri, 11 Jul 2025 08:48:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A1A319560A3; Fri, 11 Jul 2025 08:48:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6255C21E6A27; Fri, 11 Jul 2025 10:48:27 +0200 (CEST)
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
Subject: Re: [PATCH v2 03/18] qapi: add cross-references to block layer
In-Reply-To: <20250711054005.60969-4-jsnow@redhat.com> (John Snow's message of
 "Fri, 11 Jul 2025 01:39:50 -0400")
References: <20250711054005.60969-1-jsnow@redhat.com>
 <20250711054005.60969-4-jsnow@redhat.com>
Date: Fri, 11 Jul 2025 10:48:27 +0200
Message-ID: <87jz4f865g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

John Snow <jsnow@redhat.com> writes:

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json   | 188 ++++++++++++++++++++---------------------
>  qapi/block-export.json |  36 ++++----
>  qapi/block.json        |  14 +--
>  qapi/transaction.json  |  12 +--
>  4 files changed, 125 insertions(+), 125 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f18db3149a3..ec4ea4ddd19 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json

[...]

> @@ -3089,7 +3089,7 @@
>  # necessary cleanup.  This command requires that all involved jobs are
>  # in the PENDING state.
>  #
> -# For jobs in a transaction, instructing one job to finalize will
> +# For jobs in a :qapi:cmd:`transaction`, instructing one job to finalize will
>  # force ALL jobs in the transaction to finalize, so it is only
>  # necessary to instruct a single member job to finalize.
>  #

You dropped the `transaction` references I asked you to drop except for
this one and ...

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

... this one.  Looks like an accident.  Let's drop these hunks.

[...]


