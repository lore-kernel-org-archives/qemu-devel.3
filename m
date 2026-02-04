Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE23E9539C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnccL-0003bH-56; Wed, 04 Feb 2026 08:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnccJ-0003b7-VL
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:08:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vnccI-0007QZ-7Z
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:08:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770210501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8+48y17rmgCRAVb1aKA4ukwPDg7phhqainuUs5j16l0=;
 b=FzByfV9v+4qfpEYPSGZXyqWUpOuTCc0aW2F8ZYOiqSWFQCkeTPTbAoU4SiKp8kYexrW9Hy
 W5WN9acPrR5tDF8SaKINxLOOekWHOkZMn/sZPD7GoDz77NoT/VqAxuwUg9sFli3l3LFT2D
 uORXVgOeDtRZf6N0rEyvANObnw+6fDs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-Ixwc3Ka9NQ6L0eMRHUjvQw-1; Wed,
 04 Feb 2026 08:08:18 -0500
X-MC-Unique: Ixwc3Ka9NQ6L0eMRHUjvQw-1
X-Mimecast-MFC-AGG-ID: Ixwc3Ka9NQ6L0eMRHUjvQw_1770210496
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88B4619560AE; Wed,  4 Feb 2026 13:08:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 369F21800464; Wed,  4 Feb 2026 13:08:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D38F721E692D; Wed, 04 Feb 2026 14:08:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  thuth@redhat.com,  eblake@redhat.com,
 farosas@suse.de,  peterx@redhat.com,  zhao1.liu@intel.com,
 wangyanan55@huawei.com,  philmd@linaro.org,  marcel.apfelbaum@gmail.com,
 eduardo@habkost.net,  davydov-max@yandex-team.ru,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru,  leiyang@redhat.com,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
In-Reply-To: <20260201162001.296328-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sun, 1 Feb 2026 19:19:55 +0300")
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
Date: Wed, 04 Feb 2026 14:08:11 +0100
Message-ID: <87tsvwwtac.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> We are going to implement backend-transfer feature: some devices
> will be able to transfer their backend through migration stream
> for local migration through UNIX domain socket. For example,
> virtio-net will migrate its attached TAP netdev, with all its
> connected file descriptors.
>
> In this commit we introduce a migration parameter, which enables
> the feature, for supporting devices (no one at the moment).
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>  void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..cbe88f0c91 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -828,7 +828,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           'backend-transfer'] }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1004,6 +1005,13 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: Enable backend-transfer feature for devices that
> +#     supports it.  In general that means that backend state and its

support

> +#     file descriptors are passed to the destination in the migraton
> +#     channel (which must be a UNIX socket).  Individual devices
> +#     declare the support for backend-transfer by per-device
> +#     backend-transfer option.  (Since 11.0)
> +#
>  # Features:
>  #
>  # @unstable: Members @x-checkpoint-delay and
> @@ -1043,7 +1051,8 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': 'bool' } }
>  
>  ##
>  # @query-migrate-parameters:

With the grammar fix, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


