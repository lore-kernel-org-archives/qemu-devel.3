Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E7BC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAVf-0005NM-6u; Thu, 07 Mar 2024 04:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riAVd-0005Mw-29
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riAVb-0007zI-HI
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709805470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twUEYVqo8nKUoPXLxvaCuPBDdTRCXWBUTL2Ttg7Ia7c=;
 b=GqZA27yN+XQBGo5A0fkobNemk5gYQPqZTi6zovXydCt9k6tR5/T9AiRBq6OtMM9xZuK43j
 tFxkHWyk+dDNj2ZBU2EGkj6NDkxRnog9b3tB5RbMUPrDcYjfRtQW9pc0s4LwmQxNpJiHUH
 qZImEuOWfL2Vx1v8VREv6/USV81Zhk4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-3wrm1dhsMLCJvQcOq01ocg-1; Thu,
 07 Mar 2024 04:57:49 -0500
X-MC-Unique: 3wrm1dhsMLCJvQcOq01ocg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7945C1C00431;
 Thu,  7 Mar 2024 09:57:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1503BC0423E;
 Thu,  7 Mar 2024 09:57:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1EA121E6A24; Thu,  7 Mar 2024 10:57:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 armbru@redhat.com,  eblake@redhat.com,  qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
Subject: Re: [PATCH v2 5/6] qapi: device-sync-config: check runstate
In-Reply-To: <20240301171143.809835-6-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 1 Mar 2024 20:11:42 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-6-vsementsov@yandex-team.ru>
Date: Thu, 07 Mar 2024 10:57:46 +0100
Message-ID: <87jzmecqjp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Command result is racy if allow it during migration. Let's allow the
> sync only in RUNNING state.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

If I understand this correctly, the previous commit introduces a race,
and this one fixes it.

We normally avoid such temporary bugs.  When avoidance is impractical,
we point them out in commit message and FIXME comment.

> ---
>  include/sysemu/runstate.h |  1 +
>  system/qdev-monitor.c     | 27 ++++++++++++++++++++++++++-
>  system/runstate.c         |  5 +++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 0117d243c4..296af52322 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -5,6 +5,7 @@
>  #include "qemu/notify.h"
>  
>  bool runstate_check(RunState state);
> +const char *current_run_state_str(void);
>  void runstate_set(RunState new_state);
>  RunState runstate_get(void);
>  bool runstate_is_running(void);
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index e3107a12d7..b83b5d23c9 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -23,6 +23,7 @@
>  #include "monitor/monitor.h"
>  #include "monitor/qdev.h"
>  #include "sysemu/arch_init.h"
> +#include "sysemu/runstate.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-qdev.h"
>  #include "qapi/qmp/dispatch.h"
> @@ -983,7 +984,31 @@ int qdev_sync_config(DeviceState *dev, Error **errp)
>  
>  void qmp_device_sync_config(const char *id, Error **errp)
>  {
> -    DeviceState *dev = find_device_state(id, true, errp);
> +    MigrationState *s = migrate_get_current();
> +    DeviceState *dev;
> +
> +    /*
> +     * During migration there is a race between syncing`config and migrating it,
> +     * so let's just not allow it.
> +     *
> +     * Moreover, let's not rely on setting up interrupts in paused state, which
> +     * may be a part of migration process.

Wrap your comment lines around column 70, please.

> +     */
> +
> +    if (migration_is_running(s->state)) {
> +        error_setg(errp, "Config synchronization is not allowed "
> +                   "during migration.");
> +        return;
> +    }
> +
> +    if (!runstate_is_running()) {
> +        error_setg(errp, "Config synchronization allowed only in '%s' state, "
> +                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
> +                   current_run_state_str());
> +        return;
> +    }
> +
> +    dev = find_device_state(id, true, errp);
>      if (!dev) {
>          return;
>      }
> diff --git a/system/runstate.c b/system/runstate.c
> index d6ab860eca..8fd89172ae 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -189,6 +189,11 @@ bool runstate_check(RunState state)
>      return current_run_state == state;
>  }
>  
> +const char *current_run_state_str(void)
> +{
> +    return RunState_str(current_run_state);
> +}
> +
>  static void runstate_init(void)
>  {
>      const RunStateTransition *p;


