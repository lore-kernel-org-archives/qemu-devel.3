Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A70C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 11:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txP93-0002Y0-OT; Wed, 26 Mar 2025 07:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txP8z-0002XY-CR
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1txP8x-0008ES-Kk
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 07:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742989318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RcKOg+VGoeXZ9aVmt5N6fc7J5nsTeiIQAGpdcMEX2FU=;
 b=La/douQ27/79QjJbxINKHSAJ1j8gwN+NSMdpmwOfiSHnALfynl5vmh1ZAbEC4zl++miZ+C
 /CGDUiV6vflvBXERbgNrYE0w8Ps2l3DbHarnE62ZStpAaj6ZXJglo4+NGNabLB7IXfvf/E
 NWUU0ELT0Ddk+q7xXLKwazYF1Q4Pbek=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-85-C-tEOINSO0ykuoGv2CA7_A-1; Wed,
 26 Mar 2025 07:41:55 -0400
X-MC-Unique: C-tEOINSO0ykuoGv2CA7_A-1
X-Mimecast-MFC-AGG-ID: C-tEOINSO0ykuoGv2CA7_A_1742989314
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 159B8180035E; Wed, 26 Mar 2025 11:41:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F205180175A; Wed, 26 Mar 2025 11:41:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ACC9F21E66C7; Wed, 26 Mar 2025 12:41:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
In-Reply-To: <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com> (Hanna
 Czenczek's message of "Wed, 26 Mar 2025 10:55:23 +0100")
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com>
 <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
Date: Wed, 26 Mar 2025 12:41:50 +0100
Message-ID: <874izg81dt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hanna Czenczek <hreitz@redhat.com> writes:

> On 26.03.25 06:38, Markus Armbruster wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>>
>>> We can use this to implement multi-threading.
>>>
>>> Note that the interface presented here differs from the multi-queue
>>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>>> allows processing multiple virtqueues in a single iothread.  The
>>> equivalent (processing multiple FDs in a single iothread) would not make
>>> sense for FUSE because those FDs are used in a round-robin fashion by
>>> the FUSE kernel driver.  Putting two of them into a single iothread will
>>> just create a bottleneck.
>>>
>>> Therefore, all we need is an array of iothreads, and we will create one
>>> "queue" (FD) per thread.
>>
>> [...]
>>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> ---
>>>   qapi/block-export.json |   8 +-
>>>   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>>   2 files changed, 179 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>> index c783e01a53..0bdd5992eb 100644
>>> --- a/qapi/block-export.json
>>> +++ b/qapi/block-export.json
>>> @@ -179,12 +179,18 @@
>>>   #     mount the export with allow_other, and if that fails, try again
>>>   #     without.  (since 6.1; default: auto)
>>>   #
>>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>>> +#     given iothreads (instead of the block device's iothread, or the
>>> +#     export's "main" iothread).
>>
>> When does "the block device's iothread" apply, and when "the export's
>> main iothread"?
>
> Depends on where you set the iothread option.

Assuming QMP users need to know (see right below), can we trust they
understand which one applies when?  If not, can we provide clues?

>> Is this something the QMP user needs to know?
>
> I think so, because e.g. if you set iothread on the device and the export=
, you=E2=80=99ll get a conflict.=C2=A0 But if you set it there and set this=
 option, you won=E2=80=99t.=C2=A0 This option will just override the device=
/export option.

Do we think the doc comment sufficient for QMP users to figure this out?
If not, can we provide clues?

In particular, do we think they can go from an export failure to the
setting @iothreads here?  Perhaps the error message will guide them.
What is the message?

>>> +#                                 For this, the FUSE FD is duplicated =
so
>>> +#     there is one FD per iothread.  (since 10.1)
>>
>> Is the file descriptor duplication something the QMP user needs to know?
>
> I found this technical detail interesting, i.e. how multiqueue is impleme=
nted for FUSE.=C2=A0 Compare virtio devices, for which we make it clear tha=
t virtqueues are mapped to I/O threads (not just in documentation, but actu=
ally in option naming).=C2=A0 Is it something they must not know?

Interesting to whom?

Users of QMP?  Then explaining it in the doc comment (and thus the QEMU
QMP Reference Manual) is proper.

Just developers?  Then the doc comment is the wrong spot.

The QEMU QMP Reference Manual is for users of QMP.  It's dense reading.
Information the users are not expected to need / understand makes that
worse.

> Hanna
>
>>
>>> +#
>>>   # Since: 6.0
>>>   ##
>>>   { 'struct': 'BlockExportOptionsFuse',
>>>     'data': { 'mountpoint': 'str',
>>>               '*growable': 'bool',
>>> -            '*allow-other': 'FuseExportAllowOther' },
>>> +            '*allow-other': 'FuseExportAllowOther',
>>> +            '*iothreads': ['str'] },
>>>     'if': 'CONFIG_FUSE' }
>>>     ##
>> [...]
>>


