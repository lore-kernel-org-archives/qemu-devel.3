Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIGs-0000CF-6X; Mon, 13 Jul 2026 11:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjIGq-0000Bu-Jr
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:08:36 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjIGn-0005mc-NR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:08:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a25:0:640:ba29:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 08E598083F;
 Mon, 13 Jul 2026 18:08:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id Q8Qg050aEa60-NNvqnWYP; Mon, 13 Jul 2026 18:08:28 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783955308;
 bh=5kFLsTktGoitj7aDDhchk1Cs8Kz54gKYodU78kmpQHc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=t9Kj04W4MZkTqd1nJYnPuwwguutZicBThVDKg4s7id3R3okJcH9TTPXceJM4Oo9Ok
 R15Jd1fufYKl0YvhNwv5RexfEyZ8fSNt9CPknwa/xZpbWELWvpZ643F9mymjn7PvLC
 EE36hUo8b/BpQjNQHe7LfshwPXhDFCJpIuuzRux8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5af44296-ea89-402c-b4fb-b9b0acee3b54@yandex-team.ru>
Date: Mon, 13 Jul 2026 18:08:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <875x2juxru.fsf@pond.sub.org>
 <0fd09b96-068f-415d-9bd8-0506958710f1@yandex-team.ru>
 <87y0fff25t.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87y0fff25t.fsf@pond.sub.org>
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

On 13.07.26 16:29, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 13.07.26 10:57, Markus Armbruster wrote:
>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>
>>>> Support transferring of TAP state (including open fd).
>>>>
>>>> Add new property "local-migration-supported", which defines
>>>> whether local-migration is actually supported for this TAP device.
>>>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>>>
>>>> Note, that local-migration (including migrating opened FDs
>>>
>>> Scratch the comma after "Note", ...
>>>
>>>> through migration channel, which must be UNIX socket), is
>>>
>>> ... and the one before "is".
>>>
>>>> enabled by global "local" migration parameters. But individual
>>>> devices may have additional options to enable/disable it
>>>> per device.
>>>>
>>>> The tricky thing, is that we need to know, should we do
>>>
>>> Do you mean "The tricky thing is that we ween to know whether to call"?
>>
>> yes
>>
>>>
>>>> call open/connect in TAP initialization code. That means,
>>>> that on incoming migration we want to know status of
>>>> "local" migration parameter at time of creating TAP device.
>>>> So, currently, for incoming local migration only TAP device
>>>> created through QMP is supported, as you need to set migration
>>>> parameter first (through QMP as well).
> 
> Possibly clearer:
> 
>      The tricky thing is that we need to know whether to call open/connect
>      in TAP initialization code, i.e. we need to know the value of
>      migration parameter "local" when creating the TAP device.  For
>      incoming migration, we can know only for TAP devices created with QMP
>      after setting the migration parameter with QMP.
> 
>>>>
>>>> So the full picture is:
>>>>
>>>> On source, to start outgoing "local" migration you need:
>>>>
>>>>    - migration parameter "local" set to true
>>>>    - "local-migration-supported" TAP option set to true (the
>>>>      default, starting from 11.2 QEMU Machine Types)
>>>>
>>>> If at least one of these options is not set, TAP backend
>>>> doesn't participate in migration.
>>>>
>>>> On target, things are more difficult:
>>>>
>>>> Same, you need both "local" and "local-migration-supported"
>>>> be set. And same, if one of them is not set, TAP backend
>>>> is initialized as usual, and doesn't accept any incoming
>>>> state.
>>>>
>>>> Additionally, if you are going to set "local", it must be
>>>> set before creating the TAP device. If TAP device created
>>>> with "local" unset, it initializes as usual. If you enable
>>>> "local" after it and start incoming migration, it will fail
>>>> in .pre_load handler of TAP backend.
>>>
>>> Out of curiosity, how would such a failure look like?
>>
>> TAP is initialized as usual, so the answer depends on the options.
>>
>> For incoming migration we should open TAP without "ifname" argument.
>> If so (and "local" is not set), new TAP device will be created. It
>> shouldn't trigger any additional problems I think.
>>
>>
>> Checking with test:
>>
>>     diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
>>     index bcc0a60dfe9..94982bc7b55 100755
>>     --- a/tests/functional/x86_64/test_tap_migration.py
>>     +++ b/tests/functional/x86_64/test_tap_migration.py
>>     @@ -316,8 +316,8 @@ def prepare_and_launch_vm(
>>              else:
>>                  tap_name = TAP_ID
>>
>>     -        self.set_migration_capabilities(vm, local)
>>              self.add_virtio_net(vm, vhost, tap_name, local, incoming)
>>     +        self.set_migration_capabilities(vm, local)
>>
>>          def add_virtio_net(
>>              self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
>>
>>
>> Leads to
>>
>> qemu-system-x86_64: TAP is already initialized and cannot receive incoming fd
>> qemu-system-x86_64: warning: qemu_fclose: received fd 27 was never claimed
>> qemu-system-x86_64: load of migration failed: Invalid argument: error while loading state for instance 0x0 of device 'netdev.1/0/net-tap': pre load hook failed for: 'net-tap', version_id: 0, minimum version_id: 0, ret: -22
>>
>> on target, and failed migration, as expected.
> 
> How is the user supposed to reason their way from here to "oh, I need to
> create my TAP device with QMP and after setting @local"?

Not trivial, yes.

I can update error message to

    TAP is already initialized and cannot receive incoming fd. For local migration, "local" migration parameter must be set _before_ creating TAP device.

> 
>>
>>>
>>>> Moreover, there are interface restrictions: if you create TAP
>>>> device when QEMU is in INCOMING state, and both "local"
>>>> and "local-migration-supported" set, most of TAP options are
>>>> not allowed, and script/downscript are required to be explicitly
>>>> unset (set to "" or "no").
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> 
> [...]
> 


-- 
Best regards,
Vladimir

