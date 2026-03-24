Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B904E9A77B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50oj-0003PZ-2x; Tue, 24 Mar 2026 08:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w50oh-0003PA-Pi
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w50og-0007eI-Ac
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774355101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A5CNMxRj7FcuwrMHHihwhK3y61hsh6xRS3E8NXikRus=;
 b=Q22xeStXJdlybWGlhN8YAO192/n+FN7LyljRbsz5S/SPWXOIKQC8kf7ZudDsNb0yeL8Hvu
 h/7Jh4oc9R3FaMf5yaw9vrWGQBtYjGyva2fjkOvAO3JPRro/4WyrnyVw8MxfsuX5wAzJmL
 W6BPgl2cT5XVBmzEIBgQiNr8jxUPFTM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-1pulcM_SPQO2LChAPiW_Yw-1; Tue,
 24 Mar 2026 08:24:57 -0400
X-MC-Unique: 1pulcM_SPQO2LChAPiW_Yw-1
X-Mimecast-MFC-AGG-ID: 1pulcM_SPQO2LChAPiW_Yw_1774355095
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F6CC1944EB3; Tue, 24 Mar 2026 12:24:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A398419560B1; Tue, 24 Mar 2026 12:24:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4828E21E6937; Tue, 24 Mar 2026 13:24:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  armbru@redhat.com,
 eblake@redhat.com,  farosas@suse.de,  peterx@redhat.com,
 zhao1.liu@intel.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net,
 davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 th.huth+qemu@posteo.eu,  berrange@redhat.com,  pbonzini@redhat.com
Subject: Re: [PATCH v13 3/8] qapi: add local migration parameter
In-Reply-To: <20260319155333.260341-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 19 Mar 2026 18:53:27 +0300")
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
 <20260319155333.260341-4-vsementsov@yandex-team.ru>
Date: Tue, 24 Mar 2026 13:24:51 +0100
Message-ID: <87341ptnxo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> We are going to implement local-migration feature: some devices will be
> able to transfer open file descriptors through migration stream (which
> must UNIX domain socket for that purpose).  This allows to transfer the
> whole backend state without reconnecting and restarting the backend
> service. For example, virtio-net will migrate its attached TAP netdev,
> together with its connected file descriptors.
>
> In this commit we introduce a migration parameter, which enables
> the feature for devices that support it (none at the moment).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 7134d4ce47e..cf7037ed3fc 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -831,7 +831,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           'local'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1007,6 +1008,12 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @local: Enable local migration for devices that support it.  Backend
> +#     state and its file descriptors can then be passed to the
> +#     destination in the migration channel.  The migration channel
> +#     must be a Unix domain socket.  Usually needs to be enabled per
> +#     device.  (Since 11.0)

Sure your're still targeting 11.0?

> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1046,7 +1053,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*local': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

With the appropriate Since: tag
Acked-by: Markus Armbruster <armbru@redhat.com>


