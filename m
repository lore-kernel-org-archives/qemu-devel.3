Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48F8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjGje-000591-AE; Mon, 13 Jul 2026 09:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGjb-00058i-B1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjGjZ-0002Vi-5I
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 09:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783949407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+FKdLuifXUDZbOQcO2ez48J7/+BA6g59O+aOscsDors=;
 b=PkglVgLPdZC1DA4m/AiXKGTohe3V643Ckx2yDw72Ty/9RSfZuukjoXHLsny4Rfmt74TCxv
 5ZSTthfzrRFIZBr41bBLSPhOA+rnZ/bvo98ePevg6fEmp3gMmD2puZxZeMJywB3vlXUxbI
 c5jScd4Mm19JUtrn+4WY+7r1N9PsO5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-VJP6DUCHNr-PCWAYlgOgKw-1; Mon,
 13 Jul 2026 09:30:04 -0400
X-MC-Unique: VJP6DUCHNr-PCWAYlgOgKw-1
X-Mimecast-MFC-AGG-ID: VJP6DUCHNr-PCWAYlgOgKw_1783949401
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D0DF180AC52; Mon, 13 Jul 2026 13:29:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B054D1800674; Mon, 13 Jul 2026 13:29:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C04221E6920; Mon, 13 Jul 2026 15:29:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>,  jasowang@redhat.com,
 mst@redhat.com,  peterx@redhat.com,  farosas@suse.de,
 raphael.s.norwitz@gmail.com,  bchaney@akamai.com,  qemu-devel@nongnu.org,
 berrange@redhat.com,  pbonzini@redhat.com,  yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>,  Jason Wang <jasowangio@gmail.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
In-Reply-To: <0fd09b96-068f-415d-9bd8-0506958710f1@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 13 Jul 2026 14:51:49 +0300")
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <875x2juxru.fsf@pond.sub.org>
 <0fd09b96-068f-415d-9bd8-0506958710f1@yandex-team.ru>
Date: Mon, 13 Jul 2026 15:29:50 +0200
Message-ID: <87y0fff25t.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 13.07.26 10:57, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> Support transferring of TAP state (including open fd).
>>>
>>> Add new property "local-migration-supported", which defines
>>> whether local-migration is actually supported for this TAP device.
>>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>>
>>> Note, that local-migration (including migrating opened FDs
>> 
>> Scratch the comma after "Note", ...
>> 
>>> through migration channel, which must be UNIX socket), is
>> 
>> ... and the one before "is".
>> 
>>> enabled by global "local" migration parameters. But individual
>>> devices may have additional options to enable/disable it
>>> per device.
>>>
>>> The tricky thing, is that we need to know, should we do
>> 
>> Do you mean "The tricky thing is that we ween to know whether to call"?
>
> yes
>
>> 
>>> call open/connect in TAP initialization code. That means,
>>> that on incoming migration we want to know status of
>>> "local" migration parameter at time of creating TAP device.
>>> So, currently, for incoming local migration only TAP device
>>> created through QMP is supported, as you need to set migration
>>> parameter first (through QMP as well).

Possibly clearer:

    The tricky thing is that we need to know whether to call open/connect
    in TAP initialization code, i.e. we need to know the value of
    migration parameter "local" when creating the TAP device.  For
    incoming migration, we can know only for TAP devices created with QMP
    after setting the migration parameter with QMP.

>>>
>>> So the full picture is:
>>>
>>> On source, to start outgoing "local" migration you need:
>>>
>>>   - migration parameter "local" set to true
>>>   - "local-migration-supported" TAP option set to true (the
>>>     default, starting from 11.2 QEMU Machine Types)
>>>
>>> If at least one of these options is not set, TAP backend
>>> doesn't participate in migration.
>>>
>>> On target, things are more difficult:
>>>
>>> Same, you need both "local" and "local-migration-supported"
>>> be set. And same, if one of them is not set, TAP backend
>>> is initialized as usual, and doesn't accept any incoming
>>> state.
>>>
>>> Additionally, if you are going to set "local", it must be
>>> set before creating the TAP device. If TAP device created
>>> with "local" unset, it initializes as usual. If you enable
>>> "local" after it and start incoming migration, it will fail
>>> in .pre_load handler of TAP backend.
>> 
>> Out of curiosity, how would such a failure look like?
>
> TAP is initialized as usual, so the answer depends on the options.
>
> For incoming migration we should open TAP without "ifname" argument.
> If so (and "local" is not set), new TAP device will be created. It
> shouldn't trigger any additional problems I think.
>
>
> Checking with test:
>
>    diff --git a/tests/functional/x86_64/test_tap_migration.py b/tests/functional/x86_64/test_tap_migration.py
>    index bcc0a60dfe9..94982bc7b55 100755
>    --- a/tests/functional/x86_64/test_tap_migration.py
>    +++ b/tests/functional/x86_64/test_tap_migration.py
>    @@ -316,8 +316,8 @@ def prepare_and_launch_vm(
>             else:
>                 tap_name = TAP_ID
>
>    -        self.set_migration_capabilities(vm, local)
>             self.add_virtio_net(vm, vhost, tap_name, local, incoming)
>    +        self.set_migration_capabilities(vm, local)
>
>         def add_virtio_net(
>             self, vm, vhost: bool, tap_name: str, local: bool, incoming: bool
>
>
> Leads to
>
> qemu-system-x86_64: TAP is already initialized and cannot receive incoming fd
> qemu-system-x86_64: warning: qemu_fclose: received fd 27 was never claimed
> qemu-system-x86_64: load of migration failed: Invalid argument: error while loading state for instance 0x0 of device 'netdev.1/0/net-tap': pre load hook failed for: 'net-tap', version_id: 0, minimum version_id: 0, ret: -22
>
> on target, and failed migration, as expected.

How is the user supposed to reason their way from here to "oh, I need to
create my TAP device with QMP and after setting @local"?

>
>> 
>>> Moreover, there are interface restrictions: if you create TAP
>>> device when QEMU is in INCOMING state, and both "local"
>>> and "local-migration-supported" set, most of TAP options are
>>> not allowed, and script/downscript are required to be explicitly
>>> unset (set to "" or "no").
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

[...]


