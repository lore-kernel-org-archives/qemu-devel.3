Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8839C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 09:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWYKZ-0007J7-Qp; Wed, 24 Jul 2024 05:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sWYKV-0007G8-LG
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:30:40 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1sWYKT-0006KR-FH
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 05:30:39 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1sWYKE-0004IR-GS; Wed, 24 Jul 2024 11:30:22 +0200
Message-ID: <3036aa95-8a5a-4d76-9cdd-ab3439cad287@maciej.szmigiero.name>
Date: Wed, 24 Jul 2024 11:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/9] migration/multifd: Isolate ram pages packet
 data
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
References: <20240722175914.24022-1-farosas@suse.de>
 <20240722175914.24022-8-farosas@suse.de> <Zp6089I1ozCg1Eaq@x1n>
 <87h6chyxln.fsf@suse.de> <Zp7Jz9I3jVlrg8uK@x1n>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <Zp7Jz9I3jVlrg8uK@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
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

On 22.07.2024 23:06, Peter Xu wrote:
> On Mon, Jul 22, 2024 at 05:34:44PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Mon, Jul 22, 2024 at 02:59:12PM -0300, Fabiano Rosas wrote:
>>>> While we cannot yet disentangle the multifd packet from page data, we
>>>> can make the code a bit cleaner by setting the page-related fields in
>>>> a separate function.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>>   migration/multifd.c | 97 ++++++++++++++++++++++++++++-----------------
>>>>   1 file changed, 61 insertions(+), 36 deletions(-)
>>>>
>>>> diff --git a/migration/multifd.c b/migration/multifd.c
>>>> index fcdb12e04f..d25b8658b2 100644
>>>> --- a/migration/multifd.c
>>>> +++ b/migration/multifd.c
>>>> @@ -409,65 +409,62 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>>>>       return msg.id;
>>>>   }
>>>>   
>>>> -void multifd_send_fill_packet(MultiFDSendParams *p)
>>>> +static void multifd_ram_fill_packet(MultiFDSendParams *p)
>>>>   {
>>>>       MultiFDPacket_t *packet = p->packet;
>>>>       MultiFDPages_t *pages = &p->data->u.ram;
>>>> -    uint64_t packet_num;
>>>>       uint32_t zero_num = pages->num - pages->normal_num;
>>>> -    int i;
>>>>   
>>>> -    packet->flags = cpu_to_be32(p->flags);
>>>>       packet->pages_alloc = cpu_to_be32(pages->allocated);
>>>>       packet->normal_pages = cpu_to_be32(pages->normal_num);
>>>>       packet->zero_pages = cpu_to_be32(zero_num);
>>>> -    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>>>
>>> Definitely good intention, but I had a feeling that this will need to be
>>> reorganized again when Maciej reworks on top, due to the fact that
>>> next_packet_size will be ram-private field, simply because it's defined
>>> after pages_alloc and normal_pages...
>>>
>>> E.g., see:
>>>
>>> https://lore.kernel.org/r/41dedaf2c9abebb5e45f88c052daa26320715a92.1718717584.git.maciej.szmigiero@oracle.com
>>>
>>> Where the new MultiFDPacketHdr_t cannot include next_packet_size (even if
>>> VFIO will need that too..).
>>
>> Isn't it just a matter of setting next_packet_size in the other path as
>> well?
>>
>> @Maciej, can you comment?
>>
>>>
>>> typedef struct {
>>>      uint32_t magic;
>>>      uint32_t version;
>>>      uint32_t flags;
>>> } __attribute__((packed)) MultiFDPacketHdr_t;
>>>
>>> So _maybe_ it's easier we drop this patch and leave that part to Maciej to
>>> identify which is common and which is arm/vfio specific.  No strong
>>> opinions here.
>>>
>>
>> I could drop it if that's preferrable. However, patch 8/9 is absolutely
>> necessary so we can remove this madness of having to clear
>> MultiFDPages_t fields at the multifd_send_thread() top level. It took me
>> a whole day to figure that one out and that bug has been manifesting
>> ever since I started working on multifd.
>>
>> I'm not sure how we'll do that without this patch. Maybe it's better I
>> fix in this one whatever you guys think needs fixing.
> 
> You can set next_packet_size only in ram path, or you can keep this patch
> as is and let Maciej rework it on top.
> 
> I'm fine either way.
> 

I need to split out the packet header parsing ("unfilling") anyway from
RAM / device state parsing (to detect the packet type before reading the
rest of it to the appropriate data structure) so either way is fine with
me too.

I think if it's easier for Fabiano to work on top of this patch then he
should just keep it.

Thanks,
Maciej


