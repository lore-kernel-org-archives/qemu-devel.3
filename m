Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FD2C83F34
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0q7-0000fH-W9; Wed, 16 Jul 2025 08:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0k3-0005Gq-9a
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:56:09 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0jx-0008So-LL
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:56:06 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56GBtiDw032585
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 16 Jul 2025 20:55:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=35L8HRBjOQ1lFYDWVFY8MHeYKn6iTAxwtbU8F1CQFVU=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752666945; v=1;
 b=vAlgwaGObVxhq3ExobDUjZ1guCfThxNZqMTCtOhDSOQL52fGG9XSTEDYIGYrOjD2
 98OrTu/Olzm3Ck62aIG5ninth9+RrutGhpTdF8YLf+JszKUj6PaAZuY56B9NR5Q1
 P5W75EkiVmYB3zjytN0S67QFjAuoc8cs9xkmT+VdHspUvSjIzIv9iDfZpeNUAQyU
 U1JiH6SABEl16MsPy/nTjR56G5dQf60BqQoKhfGkQxlRCX1bsbEoYsCP/2KwKfSn
 GGowJ/Tdh1LQqB++o3fs89g4umSS6qcdm3BqhREheg6qzOOtgFjGA+BH53YEEKT0
 4xhcsQ44W+qKjsXBXmYnlA==
Message-ID: <b4ee5979-c35e-4c50-97c4-dbb0ae1e6d27@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 16 Jul 2025 20:55:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/13] virtio-pci: implement support for extended
 features
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <eb1aa9c8442d9b482b5c84fdca54b92c8a824495.1752229731.git.pabeni@redhat.com>
 <8af39b78-a95d-4093-b68c-20b556860a09@rsg.ci.i.u-tokyo.ac.jp>
 <f1381483-a507-4420-a0c9-52bf8131e6e6@redhat.com>
 <59102a09-1e25-4c14-a681-7170c87df501@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <59102a09-1e25-4c14-a681-7170c87df501@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/07/16 18:14, Paolo Abeni wrote:
> On 7/15/25 6:21 PM, Paolo Abeni wrote:
>> On 7/15/25 9:42 AM, Akihiko Odaki wrote:
>>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>>> @@ -158,7 +159,10 @@ struct VirtIOPCIProxy {
>>>>        uint32_t nvectors;
>>>>        uint32_t dfselect;
>>>>        uint32_t gfselect;
>>>> -    uint32_t guest_features[2];
>>>> +    union {
>>>> +        uint32_t guest_features[2];
>>>> +        uint32_t guest_features128[4];
>>>> +    };
>>>
>>> I don't see anything preventing you from directly extending guest_features.
>>
>> Uhmm... I have a vague memory of some interim revisions doing that and
>> failing miserably (but I have no log of the actual details). I'll try to
>> have another shot at it.
> 
> The VMSTATE_ARRAY() macro has explicit checks on the specified array
> matching exactly the specified array size. Using a single:
> 
> 	uint32_t guest_features[4];
> 
> variable, this statement
> 
> 	 VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
> 
> causes the following build error:
> 
> --
> include/migration/vmstate.h:259:48: error: invalid operands to binary -
> (have ‘uint32_t (*)[2]’ {aka ‘unsigned int (*)[2]’} and ‘uint32_t
> (*)[4]’ {aka ‘unsigned int (*)[4]’})
>    259 | #define type_check_array(t1,t2,n) ((t1(*)[n])0 - (t2*)0)
>        |                                                ^
> include/migration/vmstate.h:282:6: note: in expansion of macro
> ‘type_check_array’
>    282 |      type_check_array(_type, typeof_field(_state, _field), _num))
>        |      ^~~~~~~~~~~~~~~~
> include/migration/vmstate.h:373:19: note: in expansion of macro
> ‘vmstate_offset_array’
>    373 |     .offset     = vmstate_offset_array(_state, _field, _type,
> _num), \
>        |                   ^~~~~~~~~~~~~~~~~~~~
> include/migration/vmstate.h:1090:5: note: in expansion of macro
> ‘VMSTATE_ARRAY’
>   1090 |     VMSTATE_ARRAY(_f, _s, _n, _v, vmstate_info_uint32, uint32_t)
>        |     ^~~~~~~~~~~~~
> include/migration/vmstate.h:1096:5: note: in expansion of macro
> ‘VMSTATE_UINT32_ARRAY_V’
>   1096 |     VMSTATE_UINT32_ARRAY_V(_f, _s, _n, 0)
>        |     ^~~~~~~~~~~~~~~~~~~~~~
> ../hw/virtio/virtio-pci.c:168:9: note: in expansion of macro
> ‘VMSTATE_UINT32_ARRAY’
>    168 |         VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
>        |         ^~~~~~~~~~~~~~~~~~~~
> --
> 
> I'll keep the union here.
I think you can use VMSTATE_UINT32_SUB_ARRAY().

Regards,
Akihiko Odaki

