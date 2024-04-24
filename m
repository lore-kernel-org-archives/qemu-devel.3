Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CA9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzbNR-0005Uu-Vy; Wed, 24 Apr 2024 08:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzbNC-0005Sz-F9
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:05:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzbN9-0007k7-9u
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 08:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713960308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iVrYGxGITgZAFY6HD+X1tBO3SRfHgsn7badY2DEhpDg=;
 b=JqbUcttNY5GwiB7Bd4txd3x+XbftEA6QQAjhPS0A31CEHjVwrNyrDzzoECTVPa3MOfm2CD
 AMQxNy58bBig1QCSP4QTwoMXmO5EP04I/Gz+ysobkUM15m20BULPz+j6VJ74JynmWgm4Jk
 z5NQ2s6ibKiklnO8bhcGJEt8Lica0JQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-y4sIrR3vMDmJHjd237aVUA-1; Wed,
 24 Apr 2024 08:05:06 -0400
X-MC-Unique: y4sIrR3vMDmJHjd237aVUA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34FD629AC016;
 Wed, 24 Apr 2024 12:05:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E388B1C060D0;
 Wed, 24 Apr 2024 12:05:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8BB5621E6680; Wed, 24 Apr 2024 14:05:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  armbru@redhat.com,
 dave@treblig.org,  eblake@redhat.com,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
Subject: Re: [PATCH v3 4/5] qapi: introduce device-sync-config
In-Reply-To: <20240329183758.3360733-5-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 29 Mar 2024 21:37:57 +0300")
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
 <20240329183758.3360733-5-vsementsov@yandex-team.ru>
Date: Wed, 24 Apr 2024 14:05:04 +0200
Message-ID: <87bk5zvudr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Add command to sync config from vhost-user backend to the device. It
> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
> triggered interrupt to the guest or just not available (not supported
> by vhost-user server).
>
> Command result is racy if allow it during migration. Let's allow the
> sync only in RUNNING state.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9228e96c87..87135bdcdf 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -95,6 +95,7 @@ typedef void (*DeviceUnrealize)(DeviceState *dev);
>  typedef void (*DeviceReset)(DeviceState *dev);
>  typedef void (*BusRealize)(BusState *bus, Error **errp);
>  typedef void (*BusUnrealize)(BusState *bus);
> +typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
>  
>  /**
>   * struct DeviceClass - The base class for all devices.
> @@ -162,6 +163,7 @@ struct DeviceClass {
>      DeviceReset reset;
>      DeviceRealize realize;
>      DeviceUnrealize unrealize;
> +    DeviceSyncConfig sync_config;

I get

    include/hw/qdev-core.h:179: warning: Function parameter or member 'sync_config' not described in 'DeviceClass'

To fix this, cover the new member in the doc comment.

>  
>      /**
>       * @vmsd: device state serialisation description for

[...]


