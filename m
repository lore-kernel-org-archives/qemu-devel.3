Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C7EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 13:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYQmk-0002zl-KC; Mon, 29 Jul 2024 09:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sYQmi-0002wc-9f; Mon, 29 Jul 2024 09:51:32 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sYQme-0007d5-Vh; Mon, 29 Jul 2024 09:51:32 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 03E5241ECB;
 Mon, 29 Jul 2024 15:51:18 +0200 (CEST)
Message-ID: <777b4151-116b-4d3d-8b60-4b17ede51dea@proxmox.com>
Date: Mon, 29 Jul 2024 15:51:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: query dirty areas according to bitmap via QMP or qemu-nbd
To: Eric Blake <eblake@redhat.com>
Cc: "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <a8ceec92-4b4a-4ee6-b7f7-b6b9d804a5e9@proxmox.com>
 <spi5wsadgvijq6venwx74c5exat6635h4xf5v6aaf2t3bzvijq@dkfqlhzhcvl3>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <spi5wsadgvijq6venwx74c5exat6635h4xf5v6aaf2t3bzvijq@dkfqlhzhcvl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 26.07.24 um 17:38 schrieb Eric Blake:
> On Fri, Jul 26, 2024 at 04:16:41PM GMT, Fiona Ebner wrote:
>> Hi,
>>
>> sorry if I'm missing the obvious, but is there a way to get the dirty
>> areas according to a dirty bitmap via QMP? I mean as something like
>> offset + size + dirty-flag triples. In my case, the bitmap is also
>> exported via NBD, so same question for qemu-nbd being the client.
> 
> Over QMP, no - that can produce a potentially large response and
> possible long time in computing the data, so we have never felt the
> need to introduce a new QMP command for that purpose.  So over NBD is
> the preferred solution.
> 
>>
>> I can get the info with "nbdinfo --map", but would like to avoid
>> requiring a tool outside QEMU.
> 
> By default, QEMU as an NBD client only reads the "base:allocation" NBD
> metacontext, and is not wired to read more than one NBD metacontext at
> once (weaker than nbdinfo's capabilities).  But I have intentionally
> left in a hack (accessible through QMP as well as from the command
> line) for connecting a qemu NBD client to an alternative NBD
> metacontext that feeds the block status, at which point 2 bits of
> information from the alternative context are observable through the
> result of block status calls.  Note that using such an NBD connection
> for anything OTHER than block status calls is inadvisable (qemu might
> incorrectly optimize reads based on its misinterpretation of those
> block status bits); but as long as you limit the client to block
> status calls, it's a great way to read out a "qemu:dirty-bitmap:..."
> metacontext using only a qemu NBD client connection.
> 
> git grep -l x-dirty-bitmap tests/qemu-iotests
> 
> shows several of the iotests using the backdoor in just that manner.
> In particular, tests/qemu-img-bitmaps gives the magic decoder ring:
> 
> | # x-dirty-bitmap is a hack for reading bitmaps; it abuses block status to
> | # report "data":false for portions of the bitmap which are set
> | IMG="driver=nbd,server.type=unix,server.path=$nbd_unix_socket"
> | nbd_server_start_unix_socket -r -f qcow2 \
> |     -B b0 -B b1 -B b2 -B b3 "$TEST_IMG"
> | $QEMU_IMG map --output=json --image-opts \
> |     "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
> 
> meaning the map output includes "data":false for the dirty portions
> and "data":true for the unchanged portions recorded in bitmap b0 as
> read from the JSON map output.
> 

Oh, I didn't think about checking the NBD block driver for such an
option :) And thank you for all the explanations!

>>
>> If it is not currently possible, would upstream be interested too in the
>> feature, either for QMP or qemu-nbd?
> 
> Improving qemu-img to get at the information without quite the hacky
> post-processing deciphering would indeed be a useful patch, but it has
> never risen to the level of enough of an itch for me to write it
> myself (especially since 'nbdinfo --map's output works just as well).
> 

I might just go with the above for now, but who knows if I'll get around
to this some day. Three approaches that come to mind are:

1. qemu-img bitmap --dump

Other bitmap actions won't be supported in combination with NBD.

2. qemu-img map --bitmap NAME

Should it use a dedicated output format compared to the usual "map"
output (both human and json) with just "start/offset + length + dirty
bit" triples?

3. qemu-nbd --map CONTEXT

With only supporting one context at a time? Would be limited to NBD of
course which the other two won't be.


All would require connecting to the NBD export with the correct meta
context, which currently means using x_dirty_bitmap internally. So would
that even be okay as part of a non-experimental command, or would it
require to teach the NBD client code to deal with multiple meta contexts
first?

Best Regards,
Fiona


