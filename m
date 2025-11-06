Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F27CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2Ba-0003ob-0T; Thu, 06 Nov 2025 10:46:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vH2BY-0003oR-Pi
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:46:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vH2BX-0006TG-0H
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:46:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762443961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1fruWoZzRF6uN8gIgmdyy9gHwZ61THyow0OOWWweOCQ=;
 b=OpmUWjF3GE9YEapPk0tFyMaT8QLdFJEVBtQUqCOLfj+IZjRI5lYO9m4CrRpT/63tO0zDyS
 TxK5MzSsrhsRtYRBFFB4Y9IJ13tgmB3OK3+m0e4cl3FCeM1Ov3EXIHRc75qpMUSp06tY82
 haBy5O9FZNm17EfdvmAdzfLR7d35ogQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-jUOCLHxZMleZU0u5_r_gig-1; Thu,
 06 Nov 2025 10:44:47 -0500
X-MC-Unique: jUOCLHxZMleZU0u5_r_gig-1
X-Mimecast-MFC-AGG-ID: jUOCLHxZMleZU0u5_r_gig_1762443886
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 564601801233; Thu,  6 Nov 2025 15:44:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED0EC1945110; Thu,  6 Nov 2025 15:44:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 96C7B21E6A27; Thu, 06 Nov 2025 16:44:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  jasowang@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  peterx@redhat.com,
 farosas@suse.de,  eblake@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  zhao1.liu@intel.com,  qemu-devel@nongnu.org,
 leiyang@redhat.com,  davydov-max@yandex-team.ru,  yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v9 3/8] qapi: add backend-transfer migration parameter
In-Reply-To: <20251030203116.870742-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 30 Oct 2025 23:31:10 +0300")
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
 <20251030203116.870742-4-vsementsov@yandex-team.ru>
Date: Thu, 06 Nov 2025 16:44:41 +0100
Message-ID: <87ecqbf9na.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> We are going to implement backend-transfer feature: some devices
> will be able to transfer their backend through migration stream
> for local migration through UNIX domain socket. For example,
> virtio-net will migrate its attached TAP netdev, with all its
> connected file descriptors.
>
> In this commit we introduce a migration parameter, which pick
> devices for backend-transfer migration in context of next
> outgoing or incoming migration. Of course, user is responsible
> to pick same set of devices on source and target.
>
> QMP command query-backend-transfer-support command may help
> to prepare such set as intersection of
> query-backend-transfer-support results on source and target.
>
> With this commit, no device yet support backend-transfer,
> so passing something other then empty list to backend-transfer
> migration parameter will fail.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>  void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index be0f3fcc12..9478c4ddab 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -951,9 +951,15 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of devices (IDs or QOM paths) for
> +#     backend-transfer migration.  When enabled, device backends
> +#     including opened fds will be passed to the destination in the
> +#     migration channel (which must be a UNIX domain socket).  Default
> +#     is no backend-transfer migration. (Since 10.2)

Two spaces after '.', please.

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -978,7 +984,8 @@
>             'mode',
>             'zero-page-detection',
>             'direct-io',
> -           'cpr-exec-command'] }
> +           'cpr-exec-command',
> +           { 'name': 'backend-transfer', 'features': ['unstable'] } ] }
>  
>  ##
>  # @MigrateSetParameters:
> @@ -1137,9 +1144,15 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of devices (IDs or QOM paths) for
> +#     backend-transfer migration.  When enabled, device backends
> +#     including opened fds will be passed to the destination in the
> +#     migration channel (which must be a UNIX domain socket).  Default
> +#     is no backend-transfer migration. (Since 10.2)

Likewise.

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # TODO: either fuse back into `MigrationParameters`, or make
> @@ -1179,7 +1192,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': [ 'str' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @migrate-set-parameters:
> @@ -1352,9 +1367,15 @@
>  #     is @cpr-exec.  The first list element is the program's filename,
>  #     the remainder its arguments.  (Since 10.2)
>  #
> +# @backend-transfer: List of devices (IDs or QOM paths) for
> +#     backend-transfer migration.  When enabled, device backends
> +#     including opened fds will be passed to the destination in the
> +#     migration channel (which must be a UNIX domain socket).  Default
> +#     is no backend-transfer migration. (Since 10.2)

Two spaces after '.', please.

> +#
>  # Features:
>  #
> -# @unstable: Members @x-checkpoint-delay and
> +# @unstable: Members @backend-transfer, @x-checkpoint-delay and
>  #     @x-vcpu-dirty-limit-period are experimental.
>  #
>  # Since: 2.4
> @@ -1391,7 +1412,9 @@
>              '*mode': 'MigMode',
>              '*zero-page-detection': 'ZeroPageDetection',
>              '*direct-io': 'bool',
> -            '*cpr-exec-command': [ 'str' ]} }
> +            '*cpr-exec-command': [ 'str' ],
> +            '*backend-transfer': { 'type': [ 'str' ],
> +                                   'features': [ 'unstable' ] } } }
>  
>  ##
>  # @query-migrate-parameters:
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 9d3d961c15..549c77b2f0 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -939,6 +939,19 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +bool migrate_backend_transfer(DeviceState *dev)
> +{
> +    const strList *el = migrate_backend_transfer_list();
> +
> +    for ( ; el; el = el->next) {

Please use

       const strList *el;

       for (el = migrate_backend_transfer_list(); el; el = el->next) {

> +        if (find_device_state(el->value, false, NULL) == dev) {
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
>  static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
>  {
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);
> @@ -952,6 +965,24 @@ static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
>      return dc->backend_transfer_support(dev, errp);
>  }
>  
> +bool migrate_backend_transfer_check_list(const strList *list, Error **errp)
> +{
> +    const strList *el = list;
> +
> +    for ( ; el; el = el->next) {

Likewise.

> +        DeviceState *dev = find_device_state(el->value, true, errp);
> +        if (!dev) {
> +            return false;
> +        }
> +
> +        if (!qdev_backend_transfer_support(dev, errp)) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static int qdev_add_if_backend_transfer_supported(Object *obj, void *opaque)
>  {
>      DevPathList **list = opaque;


