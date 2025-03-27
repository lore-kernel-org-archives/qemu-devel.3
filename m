Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1DDCC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 12:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txmCP-000428-Fe; Thu, 27 Mar 2025 08:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1txmCI-0003wy-Jz; Thu, 27 Mar 2025 08:18:58 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1txmCF-0005LV-C5; Thu, 27 Mar 2025 08:18:58 -0400
Received: from blackfin.pond.sub.org
 (p200300d36f33fd00dda5bc774eb05696.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f33:fd00:dda5:bc77:4eb0:5696])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id A28D3201DE;
 Thu, 27 Mar 2025 13:18:48 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 848C521E66C5; Thu, 27 Mar 2025 13:18:46 +0100 (CET)
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
In-Reply-To: <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com> (Hanna
 Czenczek's message of "Wed, 26 Mar 2025 14:56:16 +0100")
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
 <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
Date: Thu, 27 Mar 2025 13:18:46 +0100
Message-ID: <87tt7eu0nt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:4f8:13b:3ad0:1::3;
 envelope-from=armbru@pond.sub.org; helo=oxygen.pond.sub.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.083, SPF_HELO_NONE=0.001,
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
Reply-to:  Markus Armbruster <armbru@redhat.com>
From:  Markus Armbruster via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hanna Czenczek <hreitz@redhat.com> writes:

> On 26.03.25 12:41, Markus Armbruster wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> On 26.03.25 06:38, Markus Armbruster wrote:
>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>
>>>>> FUSE allows creating multiple request queues by "cloning" /dev/fuse F=
Ds
>>>>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>>>>
>>>>> We can use this to implement multi-threading.
>>>>>
>>>>> Note that the interface presented here differs from the multi-queue
>>>>> interface of virtio-blk: The latter maps virtqueues to iothreads, whi=
ch
>>>>> allows processing multiple virtqueues in a single iothread.  The
>>>>> equivalent (processing multiple FDs in a single iothread) would not m=
ake
>>>>> sense for FUSE because those FDs are used in a round-robin fashion by
>>>>> the FUSE kernel driver.  Putting two of them into a single iothread w=
ill
>>>>> just create a bottleneck.
>>>>>
>>>>> Therefore, all we need is an array of iothreads, and we will create o=
ne
>>>>> "queue" (FD) per thread.
>>>>
>>>> [...]
>>>>
>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>> ---
>>>>>  qapi/block-export.json |   8 +-
>>>>>  block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++------=
--
>>>>>  2 files changed, 179 insertions(+), 43 deletions(-)
>>>>>
>>>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>>>> index c783e01a53..0bdd5992eb 100644
>>>>> --- a/qapi/block-export.json
>>>>> +++ b/qapi/block-export.json
>>>>> @@ -179,12 +179,18 @@
>>>>>  #     mount the export with allow_other, and if that fails, try again
>>>>>  #     without.  (since 6.1; default: auto)
>>>>>  #
>>>>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>>>>> +#     given iothreads (instead of the block device's iothread, or the
>>>>> +#     export's "main" iothread).
>>>>
>>>> When does "the block device's iothread" apply, and when "the export's
>>>> main iothread"?
>>>
>>> Depends on where you set the iothread option.
>>
>> Assuming QMP users need to know (see right below), can we trust they
>> understand which one applies when?  If not, can we provide clues?
>
> I don=E2=80=99t understand what exactly you mean, but which one applies w=
hen has nothing to do with this option, but with the @iothread (and @fixed-=
iothread) option(s) on BlockExportOptions, which do document this.

Can you point me to the spot?

>>>> Is this something the QMP user needs to know?
>>>
>>> I think so, because e.g. if you set iothread on the device and the expo=
rt, you=E2=80=99ll get a conflict.=C2=A0 But if you set it there and set th=
is option, you won=E2=80=99t.=C2=A0 This option will just override the devi=
ce/export option.
>>
>> Do we think the doc comment sufficient for QMP users to figure this out?
>
> As for conflict, BlockExportOptions.iothread and BlockExportOptions.fixed=
-iothread do.
>
> As for overriding, I do think so.=C2=A0 Do you not?=C2=A0 I=E2=80=99m alw=
ays open to suggestions.
>
>> If not, can we provide clues?
>>
>> In particular, do we think they can go from an export failure to the
>> setting @iothreads here?  Perhaps the error message will guide them.
>> What is the message?
>
> I don=E2=80=99t understand what failure you mean.

You wrote "you'll get a conflict".  I assume this manifests as failure
of a QMP command (let's ignore CLI to keep things simple here).

Do we think ordinary users running into that failure can figure out they
can avoid it by setting @iothreads?

What's that failure's error message?

>>>>> +#                                 For this, the FUSE FD is duplicate=
d so
>>>>> +#     there is one FD per iothread.  (since 10.1)
>>>>
>>>> Is the file descriptor duplication something the QMP user needs to kno=
w?
>>>
>>> I found this technical detail interesting, i.e. how multiqueue is imple=
mented for FUSE.=C2=A0 Compare virtio devices, for which we make it clear t=
hat virtqueues are mapped to I/O threads (not just in documentation, but ac=
tually in option naming).=C2=A0 Is it something they must not know?
>>
>> Interesting to whom?
>>
>> Users of QMP?  Then explaining it in the doc comment (and thus the QEMU
>> QMP Reference Manual) is proper.
>
> Yes, QEMU users.=C2=A0 I find this information interesting to users becau=
se virtio explains how multiqueue works there (see IOThreadVirtQueueMapping=
 in virtio.json), and this explains that for FUSE exports, there are no vir=
t queues, but requests come from that FD, which explains implicitly why thi=
s doesn=E2=80=99t use the IOThreadVirtQueueMapping type.
>
> In fact, if anything, I would even expand on the explanation to say that =
requests are generally distributed in a round-robin fashion across FUSE FDs=
 regardless of where they originate from, contrasting with virtqueues, whic=
h are generally tied to vCPUs.

Up to you.  I lack context to judge.

Making yourself or your fellow experts understand how this works is not
the same as making users understand how to use it.  Making me understand
is not the same either, but it might be closer.

If this isn't useful to you, let me know, and I'll shut up :)

> Hanna
>
>>
>> Just developers?  Then the doc comment is the wrong spot.
>>
>> The QEMU QMP Reference Manual is for users of QMP.  It's dense reading.
>> Information the users are not expected to need / understand makes that
>> worse.
>>
>>> Hanna
>>>
>>>>> +#
>>>>>    # Since: 6.0
>>>>>    ##
>>>>>    { 'struct': 'BlockExportOptionsFuse',
>>>>>      'data': { 'mountpoint': 'str',
>>>>>                '*growable': 'bool',
>>>>> -            '*allow-other': 'FuseExportAllowOther' },
>>>>> +            '*allow-other': 'FuseExportAllowOther',
>>>>> +            '*iothreads': ['str'] },
>>>>>      'if': 'CONFIG_FUSE' }
>>>>>      ##
>>>> [...]
>>>>

