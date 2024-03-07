Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD95CC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:47:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riALH-0006NL-Vg; Thu, 07 Mar 2024 04:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riALF-0006Fi-KT
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1riAL3-0004Hf-SX
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:47:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KjRhZfBsT8BzzABwscVBH7P7vOb7F/A+ZcDjGHpMePY=;
 b=LezlEZH3eRnBcW7OxpkIYTG1Wyz9NAaj3GPFDN415LqG+qlTyXHuaB9X3yZIbedTZVF+xW
 kOtVOZywAMfwEwvbMU3xRvjO1R9C0CgLAYJlN0P+8Oxziznec5HphWns7xjzeoc9F0pzZs
 C5efvWLZvfCzXzy6oSZuYabWSkVMgk8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-PUZFDSpBOqeNlQjsObuW8g-1; Thu,
 07 Mar 2024 04:46:50 -0500
X-MC-Unique: PUZFDSpBOqeNlQjsObuW8g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BF203C40B5F;
 Thu,  7 Mar 2024 09:46:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 28BFD111DCF0;
 Thu,  7 Mar 2024 09:46:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0062E21E6A24; Thu,  7 Mar 2024 10:46:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 3/6] qdev-monitor: add option to report GenericError
 from find_device_state
In-Reply-To: <20240301171143.809835-4-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 1 Mar 2024 20:11:40 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-4-vsementsov@yandex-team.ru>
Date: Thu, 07 Mar 2024 10:46:48 +0100
Message-ID: <87sf12cr1z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  system/qdev-monitor.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index 9febb743f1..cf7481e416 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -877,13 +877,20 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>      object_unref(OBJECT(dev));
>  }
>  
> -static DeviceState *find_device_state(const char *id, Error **errp)
> +/*
> + * Note that creating new APIs using error classes other than GenericError is
> + * not recommended. Set use_generic_error=true for new interfaces.
> + */
> +static DeviceState *find_device_state(const char *id, bool use_generic_error,
> +                                      Error **errp)
>  {
>      Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
>      DeviceState *dev;
>  
>      if (!obj) {
> -        error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
> +        error_set(errp,
> +                  (use_generic_error ?
> +                   ERROR_CLASS_GENERIC_ERROR : ERROR_CLASS_DEVICE_NOT_FOUND),
>                    "Device '%s' not found", id);
>          return NULL;
>      }
> @@ -947,7 +954,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
>  
>  void qmp_device_del(const char *id, Error **errp)
>  {
> -    DeviceState *dev = find_device_state(id, errp);
> +    DeviceState *dev = find_device_state(id, false, errp);
>      if (dev != NULL) {
>          if (dev->pending_deleted_event &&
>              (dev->pending_deleted_expires_ms == 0 ||
> @@ -1067,7 +1074,7 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
>  
>      GLOBAL_STATE_CODE();
>  
> -    dev = find_device_state(id, errp);
> +    dev = find_device_state(id, false, errp);
>      if (dev == NULL) {
>          return NULL;
>      }

I appreciate the attempt to curb the spread of DeviceNotFound errors.
Two issues:

* Copy-pasting find_device_state() with a false argument is an easy
  error to make.

* Most uses of find_device_state() are via blk_by_qdev_id() and
  qmp_get_blk().  Any new uses of qemu_get_blk() will still produce
  DeviceNotFound.

Hmm.


