Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB60C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:26:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2QpN-0000lb-It; Thu, 02 May 2024 03:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2Qoy-0000L8-Rq
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2Qox-0005cB-CT
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714634733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1l8jGXxGY9bCK1OlWriGupGmabEoHJdF+Uq2Rm63FmY=;
 b=iTqPw9lDgtar4G68UeHGOxGikWdNRHel3GwILMSYHrX9KAUa0vgyjgcHolmrch1s7sWFh9
 D0wi/wP2fMADSlpFu0obGcCd7qLoBtPPIgglpVLrsPDdZE1VM3mrWOPPekCvufL5hOA16D
 /oWj08YbzrO+EhfIkKNPeoCjhl8Kxk0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-mKuPZ5MDPTOq18Dbgclumg-1; Thu, 02 May 2024 03:25:27 -0400
X-MC-Unique: mKuPZ5MDPTOq18Dbgclumg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CCBB812C39;
 Thu,  2 May 2024 07:25:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 292D8492BC7;
 Thu,  2 May 2024 07:25:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 19C9521E6811; Thu,  2 May 2024 09:25:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 qemu-devel@nongnu.org,  eblake@redhat.com,  eduardo@habkost.net,
 berrange@redhat.com,  pbonzini@redhat.com,  hreitz@redhat.com,
 kwolf@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH v4 3/3] qapi: introduce device-sync-config
In-Reply-To: <a5993c67-6631-4fd0-a67b-c9dd52596030@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 1 May 2024 11:50:12 +0300")
References: <20240429101623.1992943-1-vsementsov@yandex-team.ru>
 <20240429101623.1992943-4-vsementsov@yandex-team.ru>
 <877cgfcley.fsf@pond.sub.org>
 <2f3f4354-7a98-48e9-84fa-4962f129a26f@yandex-team.ru>
 <a5993c67-6631-4fd0-a67b-c9dd52596030@yandex-team.ru>
Date: Thu, 02 May 2024 09:25:26 +0200
Message-ID: <87ikzwr7yx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 30.04.24 11:31, Vladimir Sementsov-Ogievskiy wrote:
>> On 30.04.24 11:19, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Add command to sync config from vhost-user backend to the device. It
>>>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>>>> triggered interrupt to the guest or just not available (not supported
>>>> by vhost-user server).
>>>>
>>>> Command result is racy if allow it during migration. Let's allow the
>>>> sync only in RUNNING state.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>>> index 264978aa40..47bfc0506e 100644
>>>> --- a/system/qdev-monitor.c
>>>> +++ b/system/qdev-monitor.c
>>>> @@ -23,6 +23,7 @@
>>>> =C2=A0 #include "monitor/monitor.h"
>>>> =C2=A0 #include "monitor/qdev.h"
>>>> =C2=A0 #include "sysemu/arch_init.h"
>>>> +#include "sysemu/runstate.h"
>>>> =C2=A0 #include "qapi/error.h"
>>>> =C2=A0 #include "qapi/qapi-commands-qdev.h"
>>>> =C2=A0 #include "qapi/qmp/dispatch.h"
>>>> @@ -971,6 +972,53 @@ void qmp_device_del(const char *id, Error **errp)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>  }
>>>>
>>>> +int qdev_sync_config(DeviceState *dev, Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_GET_CLASS(dev);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!dc->sync_config) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "device-s=
ync-config is not supported for '%s'",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_get_typename(OBJECT(dev)));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOTSUP;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return dc->sync_config(dev, errp);
>>>> +}
>>>> +
>>>> +void qmp_device_sync_config(const char *id, Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 DeviceState *dev;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * During migration there is a race between s=
yncing`configuration and
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * migrating it (if migrate first, that targe=
t would get outdated version),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * so let's just not allow it.
>>>
>>> Wrap comment lines around column 70 for legibility, please.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Moreover, let's not rely on setting up int=
errupts in paused
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * state, which may be a part of migration pr=
ocess.
>>>
>>> We discussed this in review of v3.=C2=A0 You wanted to check whether the
>>> problem is real.=C2=A0 Is it?
>>
>> We discussed it later than I've sent v4 :) No, I didn't check yet.
>
> Checked. Seems this works (in scheme pause -> migrate -> resume, interrup=
ts are migrated and triggered on target after resume), so my doubt was wron=
g.

Thanks!

[...]


