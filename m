Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF5CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 15:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux5Kh-0000SX-Rh; Fri, 12 Sep 2025 11:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ux5KE-0000Kb-1A; Fri, 12 Sep 2025 11:04:39 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ux5K8-0001Vc-UL; Fri, 12 Sep 2025 11:04:33 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id B81AD8079E;
 Fri, 12 Sep 2025 18:04:22 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b3c::1:2f] (unknown
 [2a02:6bf:8080:b3c::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id L4Od7j0GteA0-XgQdnLN4; Fri, 12 Sep 2025 18:04:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757689462;
 bh=RDT8yG7+YHP1NRbDf0tqBWa1bSP08B/Npmo2Q8FUWD0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=GFw8Z/YUZtbgakMmCDW4KGdo6UlEWsSGsATRAVoIb1nBftupeYh53QxBo1/kRpXgi
 BNQLTjT+gP68snRSsr5ohFWSavB/NhTT8iC68whYqHmxCdhqz9g2ZgmwQohePuCKTg
 BuFQ3JtaYjg/y3sARp0jzNri6LWEN5mZBocjSMFc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4baf248e-9578-4230-8417-ff7c776f59cf@yandex-team.ru>
Date: Fri, 12 Sep 2025 18:04:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] chardev-add: support local migration
To: Markus Armbruster <armbru@redhat.com>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael@enfabrica.net, sgarzare@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, kwolf@redhat.com, hreitz@redhat.com,
 berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, steven.sistare@oracle.com,
 den-plotnikov@yandex-team.ru, Laurent Vivier <lvivier@redhat.com>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-25-vsementsov@yandex-team.ru>
 <87wm634t3v.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wm634t3v.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12.09.25 17:56, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> This commit introduces a possibility to migrate open chardev
>> socket fd through migration channel without reconnecting.
>>
>> For this, user should:
>>   - enable new migration capability local-char-socket
>>   - mark the socket by an option support-local-migration=true
>>   - on target add local-incoming=true option to the socket
>>
>> Motivation for the API:
>>
>> 1. We don't want to migrate all sockets. For example, QMP-connection is
>>     bad candidate, as it is separate on source and target. So, we need
>>     @support-local-migration option to mark sockets, which we want to
>>     migrate (after this series, we'll want to migrate chardev used to
>>     connect with vhost-user-server).
>>
>> 2. Still, for remote migration, we can't migrate any sockets, so, we
>>     need a capability, to enable/disable the whole feature.
>>
>> 3. And finally, we need a sign for the socket to not open a connection
>>     on initialization, but wait for incoming migration. We can't use
>>     @support-local-migration option for it, as it may be enabled, but we
>>     are in incoming-remote migration. Also, we can't rely on the
>>     migration capability, as user is free to setup capabilities before or
>>     after chardev creation, and it would be a bad precedent to create
>>     relations here.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 
>> diff --git a/qapi/char.json b/qapi/char.json
>> index f0a53f742c..5b535c196a 100644
>> --- a/qapi/char.json
>> +++ b/qapi/char.json
>> @@ -280,11 +280,23 @@
>>   #     mutually exclusive with @reconnect.
>>   #     (default: 0) (Since: 9.2)
>>   #
>> +# @support-local-migration: The socket open file descriptor will
>> +#     migrate if this field is true and local-char-socket migration
>> +#     capability enabled (default: false) (Since: 10.2)
>> +#
>> +# @local-incoming: Do load open file descriptor for the socket
>> +#     on incoming migration. May be used only if QEMU is started
>> +#     for incoming migration and only together with local-char-socket
>> +#     migration capability (default: false) (Since: 10.2)
>> +#
>>   # Features:
>>   #
>>   # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
>>   #     instead.
>>   #
>> +# @unstable: Members @support-local-migration and @local-incoming
>> +#            are experimental
>> +#
>>   # Since: 1.4
>>   ##
>>   { 'struct': 'ChardevSocket',
>> @@ -298,7 +310,9 @@
>>               '*tn3270': 'bool',
>>               '*websocket': 'bool',
>>               '*reconnect': { 'type': 'int', 'features': [ 'deprecated' ] },
>> -            '*reconnect-ms': 'int' },
>> +            '*reconnect-ms': 'int',
>> +            '*support-local-migration': { 'type': 'bool', 'features': [ 'unstable' ] },
>> +            '*local-incoming': { 'type': 'bool', 'features': [ 'unstable' ] } },
>>     'base': 'ChardevCommon' }
>>   
>>   ##
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 2387c21e9c..4f282d168e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -517,6 +517,11 @@
>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>   #     such as a file.  (since 9.0)
>>   #
>> +# @local-char-socket: Migrate socket chardevs open file descriptors.
>> +#     Only may be used when migration channel is unix socket. Only
>> +#     involves socket chardevs with "support-local-migration" option
>> +#     enabled.  (since 10.2)
>> +#
>>   # Features:
>>   #
>>   # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>> @@ -536,7 +541,8 @@
>>              { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>              'validate-uuid', 'background-snapshot',
>>              'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit', 'mapped-ram'] }
>> +           'dirty-limit', 'mapped-ram',
>> +           { 'name': 'local-char-socket', 'features': [ 'unstable' ] } ] }
>>   
>>   ##
>>   # @MigrationCapabilityStatus:
> 
> I understand why we need a knob to enable the feature.  A
> MigrationCapability looks fine to me.  We could perhaps come up with a
> better name, but let's leave that for later.
> 
> I'm unsure about making users mark the sockets (really: the sockets
> wrapped in a character device backend) to be migrated that way.
> 
> Which sockets are users supposed to mark, and how would they know?
> 
> What happens when a user marks the QMP socket?  You called that a "bad
> candidate".
> 
> Doesn't feel like good user interface design.
> 
> Could QEMU decide (in principle) which sockets are suitable for
> sending down the migration channel?
> 
> If yes, could we make it do the right thing automatically?  Or at least
> a check that stops the user from doing the wrong thing?
> 

Yes, I'm thinking about this too. In my live-TAP series, I don't migrate TAP
netdev in separate, but it's migrated as part of virtio-net device. I hope,
it should be possible to do something similar here.

So the good target interface for me now is one "migarate-fds" (or better named)
capability, which turns on the whole feature both for virtio-net and vhost-user-blk
devices (and probably future ones). With additional optional device parameters
to be able to disable fds-migration per-device.

-- 
Best regards,
Vladimir

