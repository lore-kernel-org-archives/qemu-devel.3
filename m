Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE09C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 10:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Oby-0007Ut-C9; Mon, 29 Apr 2024 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1Obv-0007UQ-5M
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:51:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1Obg-0005Gi-VA
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 06:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714387893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09BC6M2fLkDhLNm35ENPj0sI1N8FrXAiBP1X0vAU85A=;
 b=dxoVKiMCch14IPrb/sJMECFw4JbOo3GBHwQglrMIGybPPc2oMt/r11IwUn2dR6b2TbEKEd
 RQMHbV7Bdt/WChPvoG3jtDtPMkWaXDfyO4J8tEB7jaW7tuGjTnZeiN/y0TDZlql7J6AFcT
 GgoBTJhkgPSuEIr0TkkXCr81ZYNJgv4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-Na4P2FqWMDqUpxPoHbKt_g-1; Mon, 29 Apr 2024 06:51:29 -0400
X-MC-Unique: Na4P2FqWMDqUpxPoHbKt_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 810F6830D37;
 Mon, 29 Apr 2024 10:51:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 16E851121306;
 Mon, 29 Apr 2024 10:51:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04AF621E66C8; Mon, 29 Apr 2024 12:51:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org,  raphael@enfabrica.net,  mst@redhat.com,
 kwolf@redhat.com,  hreitz@redhat.com,  pbonzini@redhat.com,
 berrange@redhat.com,  eduardo@habkost.net,  dave@treblig.org,
 eblake@redhat.com,  qemu-devel@nongnu.org,  yc-core@yandex-team.ru
Subject: Re: [PATCH v3 4/5] qapi: introduce device-sync-config
In-Reply-To: <60a332e2-f18c-4c78-9ea9-344ab49e9b8e@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 29 Apr 2024 11:18:14 +0300")
References: <20240329183758.3360733-1-vsementsov@yandex-team.ru>
 <20240329183758.3360733-5-vsementsov@yandex-team.ru>
 <87plufvv4s.fsf@pond.sub.org>
 <60a332e2-f18c-4c78-9ea9-344ab49e9b8e@yandex-team.ru>
Date: Mon, 29 Apr 2024 12:51:26 +0200
Message-ID: <87le4wjvbl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

> On 24.04.24 14:48, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Add command to sync config from vhost-user backend to the device. It
>>> may be helpful when VHOST_USER_SLAVE_CONFIG_CHANGE_MSG failed or not
>>> triggered interrupt to the guest or just not available (not supported
>>> by vhost-user server).
>>>
>>> Command result is racy if allow it during migration. Let's allow the
>>> sync only in RUNNING state.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]

>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>> index 0117d243c4..296af52322 100644
>>> --- a/include/sysemu/runstate.h
>>> +++ b/include/sysemu/runstate.h
>>> @@ -5,6 +5,7 @@
>>>   #include "qemu/notify.h"
>>>   
>>>   bool runstate_check(RunState state);
>>> +const char *current_run_state_str(void);
>>>   void runstate_set(RunState new_state);
>>>   RunState runstate_get(void);
>>>   bool runstate_is_running(void);
>>> diff --git a/qapi/qdev.json b/qapi/qdev.json
>>> index facaa0bc6a..e8be79c3d5 100644
>>> --- a/qapi/qdev.json
>>> +++ b/qapi/qdev.json
>>> @@ -161,3 +161,24 @@
>>>   ##
>>>   { 'event': 'DEVICE_UNPLUG_GUEST_ERROR',
>>>     'data': { '*device': 'str', 'path': 'str' } }
>>> +
>>> +##
>>> +# @device-sync-config:
>>> +#
>>> +# Synchronize config from backend to the guest. The command notifies
>>> +# re-read the device config from the backend and notifies the guest
>>> +# to re-read the config. The command may be used to notify the guest
>>> +# about block device capcity change. Currently only vhost-user-blk
>>> +# device supports this.
>> 
>> I'm not sure I understand this.  To work towards an understanding, I
>> rephrase it, and you point out the errors.
>> 
>>       Synchronize device configuration from host to guest part.  First,
>>       copy the configuration from the host part (backend) to the guest
>>       part (frontend).  Then notify guest software that device
>>       configuration changed.
>
> Correct, thanks

Perhaps

  Synchronize guest-visible device configuration with the backend's
  configuration, and notify guest software that device configuration
  changed.

  This may be useful to notify the guest of a block device capacity
  change.  Currenrly, only vhost-user-blk devices support this.

Next question: what happens when the device *doesn't* support this?

>> I wonder how configuration can get out of sync.  Can you explain?
>> 
>
> The example (and the original feature, which triggered developing this) is vhost disk resize. If vhost-server (backend) doesn't support VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, neither QEMU nor guest will know that disk capacity changed.

Sounds like we wouldn't need this command if we could make the
vhost-server support VHOST_USER_SLAVE_CONFIG_CHANGE_MSG.  Is making it
support it impractical?  Or are there other uses for this command?

>>> +#
>>> +# @id: the device's ID or QOM path
>>> +#
>>> +# Features:
>>> +#
>>> +# @unstable: The command is experimental.
>>> +#
>>> +# Since: 9.1
>>> +##
>>> +{ 'command': 'device-sync-config',
>>> +  'features': [ 'unstable' ],
>>> +  'data': {'id': 'str'} }
>>> diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
>>> index 7e075d91c1..cb35ea0b86 100644
>>> --- a/system/qdev-monitor.c
>>> +++ b/system/qdev-monitor.c
>>> @@ -23,6 +23,7 @@
>>>  #include "monitor/monitor.h"
>>>  #include "monitor/qdev.h"
>>>  #include "sysemu/arch_init.h"
>>> +#include "sysemu/runstate.h"
>>>  #include "qapi/error.h"
>>>  #include "qapi/qapi-commands-qdev.h"
>>>  #include "qapi/qmp/dispatch.h"
>>> @@ -969,6 +970,52 @@ void qmp_device_del(const char *id, Error **errp)
>>>       }
>>>   }
>>>   
>>> +int qdev_sync_config(DeviceState *dev, Error **errp)
>>> +{
>>> +    DeviceClass *dc = DEVICE_GET_CLASS(dev);
>>> +
>>> +    if (!dc->sync_config) {
>>> +        error_setg(errp, "device-sync-config is not supported for '%s'",
>>> +                   object_get_typename(OBJECT(dev)));
>>> +        return -ENOTSUP;
>>> +    }
>>> +
>>> +    return dc->sync_config(dev, errp);
>>> +}
>>> +
>>> +void qmp_device_sync_config(const char *id, Error **errp)
>>> +{
>>> +    DeviceState *dev;
>>> +
>>> +    /*
>>> +     * During migration there is a race between syncing`config and
>>> +     * migrating it, so let's just not allow it.
>> 
>> Can you briefly explain the race?
>
> If at the moment of qmp command, corresponding config already migrated to the target, we'll change only the config on source, but on the target we'll still have outdated config.

For RAM, dirty tracking ensures the change gets sent.  But this is
device memory.  Correct?

>>> +     *
>>> +     * Moreover, let's not rely on setting up interrupts in paused
>>> +     * state, which may be a part of migration process.
>> 
>> What dependence exactly are you avoiding?  Config synchronization
>> depending on guest interrupt delivery?
>
> Right, guest is notified by pci_set_irq.

If we allowed it in paused state, the delivery of the interrupt would be
delayed until the guest resumes running.  Correct?

>>> +     */
>>> +
>>> +    if (migration_is_running()) {
>>> +        error_setg(errp, "Config synchronization is not allowed "
>>> +                   "during migration.");
>> 
>> qapi/error.h:
>> 
>>       * The resulting message should be a single phrase, with no newline or
>>       * trailing punctuation.
>> 
>> Drop the period, please.
>
> Will do
>
>> 
>>> +        return;
>>> +    }
>>> +
>>> +    if (!runstate_is_running()) {
>>> +        error_setg(errp, "Config synchronization allowed only in '%s' state, "
>>> +                   "current state is '%s'", RunState_str(RUN_STATE_RUNNING),
>>> +                   current_run_state_str());
>>> +        return;
>>> +    }
>>> +
>>> +    dev = find_device_state(id, true, errp);
>>> +    if (!dev) {
>>> +        return;
>>> +    }
>>> +
>>> +    qdev_sync_config(dev, errp);
>>> +}
>>> +
>>>   void hmp_device_add(Monitor *mon, const QDict *qdict)
>>>   {
>>>       Error *err = NULL;

[...]


