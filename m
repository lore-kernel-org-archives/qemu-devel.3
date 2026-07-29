Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F42BC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp3MF-0000sO-Gl; Wed, 29 Jul 2026 08:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp3MD-0000qS-4m
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:25:57 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wp3M4-0005kO-TX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 08:25:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id DEB68C0AAB;
 Wed, 29 Jul 2026 15:25:42 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:484::1:24] (unknown
 [2a02:6bf:8080:484::1:24])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id ePdCwr6XdeA0-Nhb2ZpWv; Wed, 29 Jul 2026 15:25:41 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785327941;
 bh=5/xIQEmp9DsQhc72bHAGHnRW24IxsYrfnWKBp2fJVIQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fPqctSgKpXhuDAP54i8N8/urWI5GblEy/MsiU/dDrjHzOFBl5xO1Ac3Eoo+eHu0im
 MhNZ0VJ4MPrOr1yDCzSF5slHxN5hB+2fRgF8q/rISJJ7WGC64CC3PBsqIpHkSkCMcB
 ouKMCAErJ0Ogv4oSz0sxSSHyPTEgSUtMvD/Vn+IA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <86a38d6a-f9e4-4597-a7e6-9999cd8a11f6@yandex-team.ru>
Date: Wed, 29 Jul 2026 15:25:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 13/15] net/tap: support local migration with virtio-net
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20260729091334.1863155-1-vsementsov@yandex-team.ru>
 <20260729091334.1863155-14-vsementsov@yandex-team.ru>
 <87jyqeqbgx.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87jyqeqbgx.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 29.07.26 14:30, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Support transferring of TAP state (including open fd).
>>
>> Add new property "x-local-migration-supported", which defines
>> whether local-migration is actually supported for this TAP device.
>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>
>> Note that local-migration is enabled by global "local" migration
>> parameter, but individual devices may have additional options to
>> enable/disable it per device.
>>
>> The tricky thing is that we need to know whether to call open/connect in
>> TAP initialization code, i.e. we need to know the value of migration
>> parameter "local" when creating the TAP device.  For incoming migration,
>> we can know only for TAP devices created with QMP after setting the
>> migration parameter with QMP.
>>
>> So the full picture is:
>>
>> On source, to start outgoing "local" migration you need:
>>
>>   - migration parameter "local" set to true
>>   - "x-local-migration-supported" TAP option set to true (the
>>     default, starting from 11.2 QEMU Machine Types)
> 
> Is the machine type part still accurate?  The description in the QAPI
> schema has (default: false, since 11.2).

Oops, need to update commit message.

> 
>>
>> If at least one of these options is not set, TAP backend
>> doesn't participate in migration.
>>
>> On target, things are more difficult:
>>
>> Same, you need both "local" and "x-local-migration-supported"
>> be set. And same, if one of them is not set, TAP backend
>> is initialized as usual, and doesn't accept any incoming
>> state.
>>
>> Additionally, if you are going to set "local", it must be
>> set before creating the TAP device. If TAP device created
>> with "local" unset, it initializes as usual. If you enable
>> "local" after it and start incoming migration, it will fail
>> in .pre_load handler of TAP backend.
>>
>> Moreover, there are interface restrictions: if you create TAP
>> device when QEMU is in INCOMING state, and both "local"
>> and "x-local-migration-supported" set, most of TAP options are
>> not allowed, and script/downscript are required to be explicitly
>> unset (set to "" or "no").
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Ben Chaney <bchaney@akamai.com>
> 
> [...]
> 
>> diff --git a/qapi/net.json b/qapi/net.json
>> index acb8594c952..e6921912e12 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -437,6 +437,29 @@
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# @x-local-migration-supported: enable local migration for this TAP
>> +#     backend.  When set, local migration is enabled/disabled by
>> +#     migration parameter @local for this TAP backend.  When unset,
>> +#     migration parameter @local is ignored for this TAP backend.
>> +#     To be able to do incoming local migration of a TAP backend,
>> +#     migration parameter @local must be set _before_ creating the
>> +#     TAP backend.  Otherwise, TAP backend is initialized as usual,
>> +#     opening/creating TAP devices in kernel.  In this case further
>> +#     local incoming migration (with migration parameter @local set
>> +#     after creating TAP backend with @x-local-migration-supporeted
>> +#     parameter set) will simply fail.
> 
> Either have a a blank line here so you actually get two paragraphs, or
> refill the entire description to avoid the illusion of two paragraphs.
> 
>> +#     Moreover, when QEMU is in incoming migration state, migration
>> +#     parameter @local is set and @x-local-migration-supported is set,
>> +#     the following options are not supported and must not be set:
>> +#     @fd, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
>> +#     Additionally in this case @script and @downscipt must be
> 
> @downscript
> 
>> +#     explicitly disabled (empty strings or "no").
> 
> "no" is deprecated [PATCH 3].  We'll have to remember deleting 'or "no"'
> here when remove it.  Easy to forget.  Delete it now?
> 
> Maybe
> 
>     #     Additionally, @script and @downscript must be explicitly disabled
>     #     then.


Agree.

> 
>> +#     (default: false, since 11.2)
>> +#
>> +# Features:
>> +#
>> +# @unstable: Member @x-local-migration-supported is experimental.
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -455,7 +478,9 @@
>>       '*vhostfds':   'str',
>>       '*vhostforce': 'bool',
>>       '*queues':     'uint32',
>> -    '*poll-us':    'uint32'} }
>> +    '*poll-us':    'uint32',
>> +    '*x-local-migration-supported': {
>> +      'type': 'bool', 'features' : [ 'unstable'] } } }
>>   
>>   ##
>>   # @NetdevSocketOptions:
> 
> Naming is hard...
> 
> "Supported" sounds like a property of the QEMU process.  That's not what
> this is.  It's an on/off switch that happens to be in series with
> another on/off switch, namely migration parameter @local.
> 
> Maybe
> 
>      @permit-local-migration: permit local migration for this TAP
>          backend.  When set, local migration is enabled/disabled by
>          migration parameter @local for this TAP backend.  ...
> 

Good for me. Will use, if no more opinions.

Or x-permit-local-migration? I've added "x-" prefix as Michael suggested.
And it seems reasonable, as it's not only QAPI field, but also QOM property,
and we don't have "unstable" features for properties.

-- 
Best regards,
Vladimir

