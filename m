Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAFEC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5d1-0003DO-Mh; Mon, 19 Feb 2024 10:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5d0-0003DD-Hf
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5cy-00077w-If
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708356739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vptDjKKQqPgiEb0U2Y5ZtyPVg1x2WDj+3puEjyg6zrU=;
 b=ifd/IvA238/fNYa1Fk71kZP3SO6LV9lK8aFwumu2/7/vU5sI6K8RCsqDenkbuIbodeFiD6
 yxqoae7GqXt37InzCOSrKvnD0mJZBtMvDjAjqz81wM5TcnpxF6toFuXfAhCkPoZY//adf8
 8XgW8r4IKFC4jP2brJe0h5KIWlLT0xc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-sWavcIZJN-uoLEVqeymh0A-1; Mon, 19 Feb 2024 10:32:17 -0500
X-MC-Unique: sWavcIZJN-uoLEVqeymh0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C818892D02;
 Mon, 19 Feb 2024 15:32:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55F1940149AA;
 Mon, 19 Feb 2024 15:32:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3405921E6767; Mon, 19 Feb 2024 16:32:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 1/3] qmp: Switch x-query-virtio-status back to
 numeric encoding
In-Reply-To: <CAK9dgmYu04F37==Ye4VgtmZjzh8-YXQ61FygtG5o_f0E=e6cmg@mail.gmail.com>
 (Yong Huang's message of "Thu, 15 Feb 2024 20:49:41 +0800")
References: <cover.1706883915.git.yong.huang@smartx.com>
 <cde5e47e38e5e26390a6b0379092c197aaff9521.1706883915.git.yong.huang@smartx.com>
 <20240213052542-mutt-send-email-mst@kernel.org>
 <CAK9dgmYu04F37==Ye4VgtmZjzh8-YXQ61FygtG5o_f0E=e6cmg@mail.gmail.com>
Date: Mon, 19 Feb 2024 16:32:12 +0100
Message-ID: <87le7gii6b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Tue, Feb 13, 2024 at 6:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
>
>> On Fri, Feb 02, 2024 at 10:32:15PM +0800, Hyman Huang wrote:
>> > x-query-virtio-status returns several sets of virtio feature and
>> > status flags.  It goes back to v7.2.0.
>> >
>> > In the initial commit 90c066cd682 (qmp: add QMP command
>> > x-query-virtio-status), we returned them as numbers, using virtio's
>> > well-known binary encoding.
>> >
>> > The next commit f3034ad71fc (qmp: decode feature & status bits in
>> > virtio-status) replaced the numbers by objects.  The objects represent
>> > bits QEMU knows symbolically, and any unknown bits numerically just li=
ke
>> > before.
>> >
>> > Commit 8a8287981d1 (hmp: add virtio commands) the matching HMP command
>> > "info virtio" (and a few more, which aren't relevant here).
>> >
>> > The symbolic representation uses lists of strings.  The string format =
is
>> > undocumented.  The strings look like "WELL_KNOWN_SYMBOL: human readable
>> > explanation".
>> >
>> > This symbolic representation is nice for humans.  Machines it can save
>> > the trouble of decoding virtio's well-known binary encoding.
>> >
>> > However, we sometimes want to compare features and status bits without
>> > caring for their exact meaning.  Say we want to verify the correctness
>> > of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can u=
se
>> > QMP command x-query-virtio-status to retrieve vhost-user net device
>> > features, and the "ovs-vsctl list interface" command to retrieve
>> > interface features.  Without commit f3034ad71fc, we could then simply
>> > compare the numbers.  With this commit, we first have to map from the
>> > strings back to the numeric encoding.
>> >
>> > Revert the decoding for QMP, but keep it for HMP.
>>
>> Is there a way to maybe have both decoded and numerical one?
>
> What if the next patch went back to this implementation in the following
> patch? All you need to do is add a matching xxx_bits entry for each featu=
re
> and status.
>
> https://patchew.org/QEMU/cover.1700319559.git.yong.huang@smartx.com/3c716=
1a47b141af04b1f8272e8e24c5faa46ddb2.1700319559.git.yong.huang@smartx.com/
>
>
> E.g. I mostly use QMP even when I read it myself.
>>
>
> Thus, it is recommended that both numerical and decoded types be kept for
> QMP; this approach can be at odds with what was previously discussed.
> What do you think about this, Markus?

QMP is for machines.

That said, I won't object to adding development & debugging aids meant
for humans as long as

1. they're marked unstable, and

2. they either add only a modest amount of output, or the additional
   output is off by default.

What exactly is a "modest amount" depends on how machines use the
command.  If they use it all the time, even going from 8KiB to 64KiB
could be too much.  If they use it just once per guest, we can afford
more waste.

In this particular case, we could add an unstable member of type ['str']
next to the int-valued bits.  For each set bit in the int, add a string
to the list.  If QEMU knows the bit, use the well-known name.  I'd omit
the common prefix, though: use "GUEST_ANNOUNCE" or "guest-announce"
instead of "VIRTIO_NET_F_GUEST_ANNOUNCE".  If QEMU doesn't know the bit,
you could use the bit's numeric value.

Recommend a separate patch, to avoid delaying this series.

Makes sense?


