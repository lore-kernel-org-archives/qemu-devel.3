Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D99CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH1x2-0006jr-Gq; Thu, 06 Nov 2025 10:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vH1wp-0006jJ-LM
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:31:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vH1wi-00005R-Ch
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762443036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqKIjdcnX0t4eNyj9Q85mXqGongwITHoEzL9GLdnrR0=;
 b=SyoWo7Sou6pMh0BBGg/vhlBGjt34yKN6nCYFVS9fH4iR5c2TvQ2ynohxfg7aWDEK6wLlfu
 xDaNQbTKIRD3i8wF3hZEHNt3ztk4+k5ulHBpKZQ2WTg4dLV3i0/TYzUvPaqfQ8Nt4sQeJs
 eSuxrERizSj5yNzLJxuszsgV9l8mFXA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-GOHx_dosN_60D6Am80bysQ-1; Thu,
 06 Nov 2025 10:30:32 -0500
X-MC-Unique: GOHx_dosN_60D6Am80bysQ-1
X-Mimecast-MFC-AGG-ID: GOHx_dosN_60D6Am80bysQ_1762443030
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 095781800250; Thu,  6 Nov 2025 15:30:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4585719560BD; Thu,  6 Nov 2025 15:30:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF45421E6A27; Thu, 06 Nov 2025 16:30:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com,  jasowang@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  peterx@redhat.com,
 farosas@suse.de,  eblake@redhat.com,  thuth@redhat.com,
 philmd@linaro.org,  zhao1.liu@intel.com,  qemu-devel@nongnu.org,
 leiyang@redhat.com,  davydov-max@yandex-team.ru,  yc-core@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: Re: [PATCH v9 2/8] qapi: introduce query-backend-transfer-support
In-Reply-To: <20251030203116.870742-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 30 Oct 2025 23:31:09 +0300")
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
 <20251030203116.870742-3-vsementsov@yandex-team.ru>
Date: Thu, 06 Nov 2025 16:30:25 +0100
Message-ID: <87jz03fab2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
> Let's add a command to list supporting devices (no one for now),
> together with necessary infrastructure in qdev code.

Use case?

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  include/hw/qdev-core.h |  7 +++++++
>  qapi/qdev.json         | 26 +++++++++++++++++++++++++
>  system/qdev-monitor.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 2caa0cbd26..0551fbaa6c 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -96,6 +96,7 @@ typedef void (*DeviceReset)(DeviceState *dev);
>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>  typedef void (*BusUnrealize)(BusState *bus);
>  typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
> +typedef bool (*DeviceSupportBackendTransfer)(DeviceState *dev, Error **errp);
>  
>  /**
>   * struct DeviceClass - The base class for all devices.
> @@ -174,6 +175,12 @@ struct DeviceClass {
>      DeviceUnrealize unrealize;
>      DeviceSyncConfig sync_config;
>  
> +    /**
> +     * @backend_transfer_support: reports support for backend-transfer
> +     * migration of the device.
> +     */
> +    DeviceSupportBackendTransfer backend_transfer_support;
> +
>      /**
>       * @vmsd: device state serialisation description for
>       * migration/save/restore
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index e14a0c9259..d7e878d58d 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -188,3 +188,29 @@
>  { 'command': 'device-sync-config',
>    'features': [ 'unstable' ],
>    'data': {'id': 'str'} }
> +
> +##
> +# @DevPath:
> +#
> +# @path: the device's QOM path
> +#
> +# Since: 10.2
> +##
> +{ 'struct': 'DevPath',
> +  'data': { 'path': 'str' } }
> +
> +##
> +# @query-backend-transfer-support:
> +#
> +# Returns list of devices, supporting backend-transfer
> +# migration.

Suggest

   # Return the devices that support backend-transfer migration.

> +#
> +# Features:
> +#
> +# @unstable: The command is experimental.

The conventional text ist "This command is experimental."

> +#
> +# Since: 10.2
> +##
> +{ 'command': 'query-backend-transfer-support',
> +  'features': [ 'unstable' ],
> +  'returns': [ 'DevPath' ] }
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index ec4a2394ce..9d3d961c15 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -939,6 +939,49 @@ void qmp_device_del(const char *id, Error **errp)
>      }
>  }
>  
> +static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
> +{
> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
> +
> +    if (!dc->backend_transfer_support) {
> +        error_setg(errp, "backend-transfer is not supported for '%s'",
> +                   object_get_typename(OBJECT(dev)));
> +        return false;
> +    }
> +
> +    return dc->backend_transfer_support(dev, errp);
> +}

@errp is useless in this patch: the only caller passes NULL.  Took me a
minute to check it doesn't remain useless.  The next patch puts it to
use.

> +
> +static int qdev_add_if_backend_transfer_supported(Object *obj, void *opaque)
> +{
> +    DevPathList **list = opaque;
> +    DeviceState *dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
> +
> +    if (dev != NULL && qdev_backend_transfer_support(dev, NULL)) {
> +        DevPath *el = g_new(DevPath, 1);
> +        *el = (DevPath) {
> +            .path = g_strdup(dev->canonical_path),
> +        };
> +        QAPI_LIST_PREPEND(*list, el);
> +    }
> +
> +    /* Recursively check all children */
> +    object_child_foreach(obj, qdev_add_if_backend_transfer_supported, opaque);
> +
> +    return 0;
> +}
> +
> +DevPathList *qmp_query_backend_transfer_support(Error **errp)
> +{
> +    DevPathList *result = NULL;
> +    Object *peripheral = machine_get_container("peripheral");
> +
> +    object_child_foreach(peripheral, qdev_add_if_backend_transfer_supported,
> +                         &result);
> +
> +    return result;
> +}
> +
>  int qdev_sync_config(DeviceState *dev, Error **errp)
>  {
>      DeviceClass *dc = DEVICE_GET_CLASS(dev);


