Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9390C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri9sa-0002aG-6w; Thu, 07 Mar 2024 04:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ri9sY-0002a1-LP
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ri9sX-0003zA-6F
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709803048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U3KQpxuw9N1ldY/yvxjX2Wql1pieA5NS1EEd1L4F0cc=;
 b=ZodaK26VuslRx559MQCIO0Um+HXflgu5Qeeh62QklNCP6k3b1lKCvUuTotp47PghdabB3a
 JapmEkoG3xEjteIeJMfKJS8PVcFq+YZ2F2MzBor99YUWwzpYTrtXGz9eXQUwvLuJS9RVIq
 ZhWvlbfybfwyZjWSZ0fA/KxsuMGZXRk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-iZlos96xMLqdq-30aQu5UA-1; Thu,
 07 Mar 2024 04:17:23 -0500
X-MC-Unique: iZlos96xMLqdq-30aQu5UA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 051593C025C7;
 Thu,  7 Mar 2024 09:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BF2432166AF0;
 Thu,  7 Mar 2024 09:17:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EC1F21E6A24; Thu,  7 Mar 2024 10:17:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v2 2/6] qdev-monitor: fix error message in
 find_device_state()
In-Reply-To: <20240301171143.809835-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Fri, 1 Mar 2024 20:11:39 +0300")
References: <20240301171143.809835-1-vsementsov@yandex-team.ru>
 <20240301171143.809835-3-vsementsov@yandex-team.ru>
Date: Thu, 07 Mar 2024 10:17:21 +0100
Message-ID: <87wmqecsf2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

> This "hotpluggable" here is misleading. Actually we check is object a
> device or not. Let's drop the word.
>
> SUggested-by: Markus Armbruster <armbru@redhat.com>

"Suggested"

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  system/qdev-monitor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
> index a13db763e5..9febb743f1 100644
> --- a/system/qdev-monitor.c
> +++ b/system/qdev-monitor.c
> @@ -890,7 +890,7 @@ static DeviceState *find_device_state(const char *id, Error **errp)
>  
>      dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
>      if (!dev) {
> -        error_setg(errp, "%s is not a hotpluggable device", id);
> +        error_setg(errp, "%s is not a device", id);
>          return NULL;
>      }

Perhaps including what @id resolved to could be useful, but that's
out of scope for this patch.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


