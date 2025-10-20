Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A93FCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmcB-0001eF-Cd; Mon, 20 Oct 2025 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAmc8-0001dv-Fg
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vAmc6-0002lt-Bw
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760954136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IJFyJvEcd0PRaUHc/dRw8sJ1sKTemxbnJ0Y8F+XB1w8=;
 b=W7Juyt1IL4/40qrR08H0B72Zh+YrNfQmOGjoVp600l+o34xPkhL5krJBRX52yqBg3MTC2I
 24Epc5ieseJkRsDmxuAt0C5G1I/0hoUYyOtdH0BQIMo6lW5XWl62fsyD61pw9Q2+udQP9l
 HuGVXrAXIw7DTcBSYg/eMcJa3gLjauI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-fgkRDBMwNiyY_pOcCQbJTw-1; Mon,
 20 Oct 2025 05:55:32 -0400
X-MC-Unique: fgkRDBMwNiyY_pOcCQbJTw-1
X-Mimecast-MFC-AGG-ID: fgkRDBMwNiyY_pOcCQbJTw_1760954131
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F08401801312; Mon, 20 Oct 2025 09:55:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B2FA1800452; Mon, 20 Oct 2025 09:55:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 972E121E6A27; Mon, 20 Oct 2025 11:55:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Stefano Garzarella
 <sgarzare@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz
 <hreitz@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Eric Blake <eblake@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH 2/2] vhost-user-blk: support inflight migration
In-Reply-To: <20251020054413.2614932-3-dtalexundeer@yandex-team.ru> (Alexandr
 Moshkov's message of "Mon, 20 Oct 2025 10:44:16 +0500")
References: <20251020054413.2614932-1-dtalexundeer@yandex-team.ru>
 <20251020054413.2614932-3-dtalexundeer@yandex-team.ru>
Date: Mon, 20 Oct 2025 11:55:27 +0200
Message-ID: <878qh599tc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Alexandr Moshkov <dtalexundeer@yandex-team.ru> writes:

> In vhost_user_blk_stop() on incoming migration make force_stop = true,
> so GET_VRING_BASE will not be executed.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

Your cover letter explains why this is useful.  Please work it into your
commit message.

[...]

> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..c9fea59515 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -517,9 +517,13 @@
>  #     each RAM page.  Requires a migration URI that supports seeking,
>  #     such as a file.  (since 9.0)
>  #
> +# @inflight-vhost-user-blk: If enabled, QEMU will migrate inflight
> +#    region for vhost-user-blk.  (since 10.2)
> +#

Any guidance why and when users would want to enable it?

Is it a good idea to have device-specific capabilities?

>  # Features:
>  #
> -# @unstable: Members @x-colo and @x-ignore-shared are experimental.
> +# @unstable: Members @x-colo and @x-ignore-shared,
> +#     @inflight-vhost-user-blk are experimental.

"and" is misplaced now.  Fix:

   # @unstable: Members @x-colo, @x-ignore-shared, and
   #     @inflight-vhost-user-blk are experimental.

Use the opportunity and insert a blank line here.

>  # @deprecated: Member @zero-blocks is deprecated as being part of
>  #     block migration which was already removed.
>  #
> @@ -536,7 +540,8 @@
>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>             'validate-uuid', 'background-snapshot',
>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
> -           'dirty-limit', 'mapped-ram'] }
> +           'dirty-limit', 'mapped-ram',
> +           { 'name': 'inflight-vhost-user-blk', 'features': [ 'unstable' ] } ] }

Long line.  Obvious line break:

              { 'name': 'inflight-vhost-user-blk',
                'features': [ 'unstable' ] } ] }

>  
>  ##
>  # @MigrationCapabilityStatus:


