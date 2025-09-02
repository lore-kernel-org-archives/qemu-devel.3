Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ED6CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 17:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utUWF-0000gH-Lx; Tue, 02 Sep 2025 13:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utUW3-0000cB-9L
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:09:58 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utUVz-0007pg-Oj
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 13:09:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 8FDBBC017F;
 Tue, 02 Sep 2025 20:09:46 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i9jgSG3Gt0U0-w9TnjlYH; Tue, 02 Sep 2025 20:09:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756832985;
 bh=LI3kA5UcnCwjWrAYCfNamQKQBaAfd3GbsWCw+JlWvYw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=DF7rIGhIotg+oDwpS40zgDrP4vwYS4O4IkhHozrGNKD2rjEMvOagc36OWO3CLQZ1y
 wYTj3jbvF0O3bNh7NQFjzUPxAvTT22UXXu4XsuxIBzTlajVhwfvq8LV2z9IZeXds3G
 4BJLtmH7mZThtUn5wQctRrcwVGG7xfLlVTRpWW0o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c8b799f7-c549-4534-a156-99df204e62ec@yandex-team.ru>
Date: Tue, 2 Sep 2025 20:09:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Steven Sistare <steven.sistare@oracle.com>,
 "Chaney, Ben" <bchaney@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>,
 qemu-devel@nongnu.org
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <ef7fd47a-f7c0-4bca-823c-07005c5f1959@yandex-team.ru>
 <f3cb36ee-e677-4377-9e4d-652085b205aa@oracle.com>
 <3c939b30-2479-4bdd-8fa8-1dcd7adaada5@oracle.com>
 <2e6a35a4-b9b6-444c-90d7-1c748ad1b7d0@yandex-team.ru>
 <ccd353ef-26c7-4590-94ae-d8f6193c2805@oracle.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ccd353ef-26c7-4590-94ae-d8f6193c2805@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02.09.25 18:33, Steven Sistare wrote:
> On 9/1/2025 7:44 AM, Vladimir Sementsov-Ogievskiy wrote:
>> On 29.08.25 22:37, Steven Sistare wrote:
>>> On 8/28/2025 11:48 AM, Steven Sistare wrote:
>>>> On 8/23/2025 5:53 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>>> On 17.07.25 21:39, Steve Sistare wrote:
>>>>>> Tap and vhost devices can be preserved during cpr-transfer using
>>>>>> traditional live migration methods, wherein the management layer
>>>>>> creates new interfaces for the target and fiddles with 'ip link'
>>>>>> to deactivate the old interface and activate the new.
>>>>>>
>>>>>> However, CPR can simply send the file descriptors to new QEMU,
>>>>>> with no special management actions required.  The user enables
>>>>>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>>>>>> is cpr=off.
>>>>>
>>>>> Hi Steve!
>>>>>
>>>>> First, me trying to test the series:
>>>>
>>>> Thank-you Vladimir for all the work you are doing in this area.  I have
>>>> reproduced the "virtio_net_set_queue_pairs: Assertion `!r' failed." bug.
>>>> Let me dig into that before I study the larger questions you pose
>>>> about preserving tap/vhost-user-blk in local migration versus cpr.
>>>
>>> I have reproduced your journey!  I fixed the assertion, the vnet_hdr, and
>>> the blocking fd problems which you allude to.  The attached patch fixes
>>> them, and will be squashed into the series.
>>>
>>> Ben, you also reported the !r assertion failure, so this fix should help
>>> you also.
>>>
>>>>> SOURCE:
>>>>>
>>>>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :0 -nodefaults -vga std -qmp stdio -msg timestamp -S -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on
>>>>>
>>>>> {"execute": "qmp_capabilities"}
>>>>> {"return": {}}
>>>>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>>>>> {"return": {}}
>>>>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>>>>> {"return": {}}
>>>>> {"execute": "cont"}
>>>>> {"timestamp": {"seconds": 1755977653, "microseconds": 248749}, "event": "RESUME"}
>>>>> {"return": {}}
>>>>> {"timestamp": {"seconds": 1755977657, "microseconds": 366274}, "event": "NIC_RX_FILTER_CHANGED", "data": {"name": "vnet.1", "path": "/machine/peripheral/vnet.1/virtio-backend"}}
>>>>> {"execute": "migrate-set-parameters", "arguments": {"mode": "cpr-transfer"}}
>>>>> {"return": {}}
>>>>> {"execute": "migrate", "arguments": {"channels": [{"channel-type": "main", "addr": {"path": "/tmp/migr.sock", "transport": "socket", "type": "unix"}}, {"channel-type": "cpr", "addr": {"path": "/tmp/cpr.sock", "transport": "socket", "type": "unix"}}]}}
>>>>> {"timestamp": {"seconds": 1755977767, "microseconds": 835571}, "event": "STOP"}
>>>>> {"return": {}}
>>>>>
>>>>> TARGET:
>>>>>
>>>>> sudo build/qemu-system-x86_64 -display none -vga none -device pxb-pcie,bus_nr=128,bus=pcie.0,id=pcie.1 -device pcie-root-port,id=s0,slot=0,bus=pcie.1 -device pcie-root-port,id=s1,slot=1,bus=pcie.1 -device pcie-root-port,id=s2,slot=2,bus=pcie.1 -hda /home/vsementsov/work/vms/newfocal.raw -m 4G -enable-kvm -M q35 -vnc :1 -nodefaults -vga std -qmp stdio -S -object memory-backend-file,id=ram0,size=4G,mem-p
>>>>> ath=/dev/shm/ram0,share=on -machine memory-backend=ram0 -machine aux-ram-share=on -incoming defer -incoming '{"channel-type": "cpr","addr": { "transport": "socket","type": "unix", "path": "/tmp/cpr.sock"}}'
>>>>>
>>>>> <need to wait until "migrate" on source>
>>>>>
>>>>> {"execute": "qmp_capabilities"}
>>>>> {"return": {}}
>>>>> {"execute": "netdev_add", "arguments": {"cpr": true, "script": "no", "downscript": "no", "vhostforce": false, "vhost": false, "queues": 4, "ifname": "tap0", "type": "tap", "id": "netdev.1"}}
>>>>> {"return": {}}
>>>>> {"execute": "device_add", "arguments": {"disable-legacy": "off", "bus": "s1", "netdev": "netdev.1", "driver": "virtio-net-pci", "vectors": 18, "mq": true, "romfile": "", "mac": "d6:0d:75:f8:0f:b7", "id": "vnet.1"}}
>>>>> could not disable queue
>>>>> qemu-system-x86_64: ../hw/net/virtio-net.c:771: virtio_net_set_queue_pairs: Assertion `!r' failed.
>>>>> fish: Job 1, 'sudo build/qemu-system-x86_64 -…' terminated by signal SIGABRT (Abort)
>>>>>
>>>>> So, it crashes on device_add..
>>>>>
>>>>> Second, I've come a long way, backporting you TAP v1 series together with needed parts of CPR and migration channels to QEMU 7.2, fixing different issues (like, avoid reinitialization of vnet_hdr length on target, avoid simultaneous use of tap on source an target, avoid making the fd blocking again on target), and it finally started to work.
>>>>>
>>>>> But next, I went to support similar migration for vhost-user-blk, and that was a lot more complex. No reason to pass an fd in preliminary stage, when source is running (like in CPR), because:
>>>>>
>>>>> 1. we just can't use the fd on target at all, until we stop use it on source, otherwise we just break vhost-user-blk protocol on the wire (unlike TAP, where some ioctls called on target doesn't break source)
>>>>> 2. we have to pass enough additional variables, which are simpler to pass through normal migration channel (how to pass anything except fds through cpr channel?)
>>>
>>> You can pass extra state through the cpr channel.  See for example vmstate_cpr_vfio_device,
>>> and how vmstate_cpr_vfio_devices is defined as a sub-section of vmstate_cpr_state.
>>
>> O, I missed this.
>>
>> Hmm. Still, finally CPR becomes just an additional stage of migration, which is done prior device initialization on target..
>>
>> Didn't you think of integrating it to the common scheme: so that devices may have .vmsd_cpr in addition to .vmsd? This way we don't need a global CPR state, and CPR stage of migration will work the same way as normal migration?
> 
> I proposed a single migration stream containing pre-create state that was read early,
> but that was rejected as too complex.
> 
> I also proposed refactoring initialization so the monitor and migration streams
> could be opened earlier, but again rejected as too complex and/or not consistent with
> a long term vision for reworking initialization.
> 
>> Still2, if we pass some state in CPR it should be a kind of constant. We need a guarantee that it will not change between migration start and source stop.
>>
>>>
>>>>> So, I decided to go another way, and just migrate everything backend-related including fds through main migration channel. Of course, this requires deep reworking of device initialization in case of incoming migration (but for vhost-user-blk we need it anyway). The feature is in my series "[PATCH 00/33] vhost-user-blk: live-backend local migration" (you are in CC).
>>>
>>> You did a lot of work in those series!
>>> I suspect much less rework of initialization is required if you pass variables in cpr state.
>>
>> Not sure. I had to rework initialization anyway, as initialization damaged the connection. And this lead me to idea "if rework anyway, why not to go with one migration channel".
>>
>>>
>>>>> The success with vhost-user-blk (of-course) make me rethink TAP migration too: try to avoid using additional cpr channel and unusual waiting for QMP interface on target. And, I've just sent an RFC: "[RFC 0/7] virtio-net: live-TAP local migration"
>>>
>>> Is there a use case for this outside of CPR?
>>
>> It just works without CPR.. Will CPR bring more benefit if I enable it in the setup with my local-tap + local-vhost-user-blk capabilities ( + ignore-shared of-course)?
>>
>>
>>> CPR is intended to be the "local migration" solution that does it all :)
>>> But if you do proceed with your local migration tap solution, I would want
>>> to see that CPR could also use your code paths.
>>>
>> CPR can transparently use my code: you may enable both CPR and local-tap capability and it should work. Some devices will migrate their fds through CPR, TAP fds amd state will migrate through main migration channel. 
> 
> OK, I believe that.
> 
> I also care about cpr-exec mode.  We use it internally, and I am trying to push
> it upstream:
>    https://lore.kernel.org/qemu-devel/1755191843-283480-8-git-send-email-steven.sistare@oracle.com/
> I believe it would work with your code.  Migrated fd's in both the cpr channel and
> the main migration channel would be handled differently as shown in vmstate-types.c
> get_fd() and put_fd().  The fd is kept open across execv(), and vmstate represents
> the fd by its value (eg a small integer), rather than as an object in the unix channel.

I'm close to publish new version, which will include

> 
>> Making both channels to be unix-sockets should not be a considerable overhead I think.
>>
>> Why I like my solution more:
>>
>> - no additional channel
>> - no additional logic in management software (to handle target start with no QMP access until "migrate" command on source)
>> - less code to backport (that's personal, of course not an argument for final upstream solution)
>>
>> It seems that CPR is simpler to support as we don't need to do deep rework of initialization code.. But in reality, there is a lot of work anyway: TAP, vhost-user-blk cases proves this. You series about vfio are also huge.
> 
> TAP is the only case where we can compare both approaches, and the numbers tell
> the story:
> 
>    TAP initialization refactoring: 277 insertions(+), 308 deletions(-)

Actually, I've done a lot more refactoring than required for TAP local migration, trying to make the whole initialization more clear and consistent. And it's a good base for any modification of TAP device I think.

>    live-TAP local migration:       681 insertions(+), 72 deletions(-)

But 369 is last patch which is not for commit, and 65 a first patch with tracepoints (look at it tap_dump_packet() - thanks to AI, really helps to debug network problems, when you see packet dumps in QEMU log)
So, more honest estimate is ~250, which is in good accordance with Live update tap.

>                          total:    958 insertions(+), 380 deletions(-)
> 
>    Live update tap and vhost:      223 insertions(+), 55 deletions(-)
> 
> For any given system, if the maintainers accept the larger amount of change,
> then local migration is cool (and CPR made it possible by adding fd support
> to vmstate+QEMUFile)

Yes, native support for fds in migration API opens the doors:)

>.  But the amount of change is a harder sell.

Yes, that's right. But live-TAP isn't really big. Unlike live-vhost-user-blk unfortunately.

>> What is the benefit of CPR against simple (unix-socket) migration?

> CPR supports vfio, iommufd, and pinned memory.  Memory backend objects are
> created early, before the main migration stream is read, and squashing
> CPR into migration for those cases would require a major change in how
> qemu creates objects during live migration.

Yes, understand: less things to change in initialization code = we can cover more things..

For my downstream I need TAP, vhost-user-blk and vfio. So vfio would be the most interesting challenge, if I try to make a kind of live-vfio local migration.

- it already supported by CPR, so it would be really hard to cell 1-2 thousands of additional code lines) But I'll see, may be it will not be so much.
- we already have support in downstream, which we've never tried to send. It based on getting fds from source and passing them to target by management software.. But of course one day we should sync with upstream.

> 
> Hence CPR is the method that works for all types of objects.  The mgmt
> layer does not need to support multiple methods of live update, depending
> on what devices the VM contains.
> 

So, I'll keep my live-migrations not to be a separate mode. And they may be used as part of CPR, and I'm saving a chance to switch to CPR if needed.

Thanks for detailed answer!

-- 
Best regards,
Vladimir

