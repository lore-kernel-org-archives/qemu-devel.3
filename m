Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342F5C48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoPq-0006Zu-Cr; Wed, 21 Feb 2024 10:21:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rcoM9-0001XF-57
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:17:57 -0500
Received: from out28-5.mail.aliyun.com ([115.124.28.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenh@yusur.tech>) id 1rcilB-0001oa-Gr
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 04:19:30 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437272|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00380713-0.000468668-0.995724;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047205; MF=chenh@yusur.tech; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.WWE4HjU_1708507155; 
Received: from 10.2.26.57(mailfrom:chenh@yusur.tech
 fp:SMTPD_---.WWE4HjU_1708507155) by smtp.aliyun-inc.com;
 Wed, 21 Feb 2024 17:19:16 +0800
Message-ID: <2a4862f8-e4f5-4ae3-be99-a7b3635da182@yusur.tech>
Date: Wed, 21 Feb 2024 17:19:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost-user: fix the issue of vhost deadlock in nested
 virtualization
To: Maxime Coquelin <maxime.coquelin@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 huangml@yusur.tech, zy@yusur.tech
References: <20240126100737.2509847-1-chenh@yusur.tech>
 <20240213050258-mutt-send-email-mst@kernel.org>
 <5176a8e4-dbdc-45e0-a1f2-d9cb3b71a6b1@redhat.com>
 <20240220064027-mutt-send-email-mst@kernel.org>
 <f9111e6b-4094-4731-b2de-e442b1a4fa5f@redhat.com>
From: Hao Chen <chenh@yusur.tech>
In-Reply-To: <f9111e6b-4094-4731-b2de-e442b1a4fa5f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.5; envelope-from=chenh@yusur.tech;
 helo=out28-5.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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



在 2024/2/21 17:02, Maxime Coquelin 写道:
> 
> 
> On 2/20/24 12:43, Michael S. Tsirkin wrote:
>> On Tue, Feb 20, 2024 at 12:26:49PM +0100, Maxime Coquelin wrote:
>>>
>>>
>>> On 2/13/24 11:05, Michael S. Tsirkin wrote:
>>>> On Fri, Jan 26, 2024 at 06:07:37PM +0800, Hao Chen wrote:
>>>>> I run "dpdk-vdpa" and "qemur-L2" in "qemu-L1".
>>>>>
>>>>> In a nested virtualization environment, "qemu-L2" vhost-user socket 
>>>>> sends
>>>>> a "VHOST_USER_IOTLB_MSG" message to "dpdk-vdpa" and blocks waiting for
>>>>> "dpdk-vdpa" to process the message.
>>>>> If "dpdk-vdpa" doesn't complete the processing of the 
>>>>> "VHOST_USER_IOTLB_MSG"
>>>>> message and sends a message that needs to be replied in another 
>>>>> thread,
>>>>> such as "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", "dpdk-vdpa" 
>>>>> will also
>>>>> block and wait for "qemu-L2" to process this message. However, 
>>>>> "qemu-L2"
>>>>> vhost-user's socket is blocking while waiting for a reply from 
>>>>> "dpdk-vdpa"
>>>>> after processing the message "VHOSTr_USER_IOTLB_MSG", and
>>>>> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" will not be processed.
>>>>> In this case, both "dpdk-vdpa" and "qemu-L2" are blocked on the
>>>>> vhost read, resulting in a deadlock.
>>>>>
>>>>> You can modify "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG" or
>>>>> "VHOST_USER_IOTLB_MSG" to "no need reply" to fix this issue.
>>>>> There are too many messages in dpdk that are similar to
>>>>> "VHOST_USER_SLAVE_VRING_HOST_NOTIFIER_MSG", and I would prefer the 
>>>>> latter.
>>>>>
>>>>> Fixes: 24e34754eb78 ("vhost-user: factor out msg head and payload")
>>>>>
>>>>> Signed-off-by: Hao Chen <chenh@yusur.tech>
>>>>
>>>> I would be very worried that IOTLB becomes stale and
>>>> guest memory is corrupted if we just proceed without waiting.
>>>>
>>>> Maxime what do you think? How would you address the issue?
>>>
>>> I agree with you, this is not possible.
>>> For example, in case of IOTLB invalidate, the frontend relies on the
>>> backend reply to ensure it is no more accessing the memory before
>>> proceeding.
>>>
>>> The reply-ack for VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG request is
>>> less important, if it fails the host notifications won't work but would
>>> not risk corruption. Maybe on Qemu side we could fail init if processing
>>> the request fails, as I think that if negotiated, we can expect it to
>>> succeed.
>>>
>>> What do you think about this proposal?
>>>
>>> Regards,
>>> Maxime
>>
>> Fundamentally, I think that if qemu blocks guest waiting for a rely
>> that is ok but it really has to process incoming messages meanwhile.
>> Same should apply to backend I think ...
> 
> I understand your point.
> For DPDK Vhost library, it will likely imply ABI breakage as it would
> require to asynchronous handling of Vhost-user requests. We would only
> be able to do it at next LTS release.
> 
> Hao, as your driver is not available upstream it will be difficult to
> assist you more. But if you look at other DPDK vDPA driver like SFC for
> instance, the way they implemented host notification control should be
> safe against this kind of deadlocks.
Okay, I can also avoid this issue by sending the 
"VHOST_USER_SLAVE_VRING_HOSTNOTIFIER_MSG" message as late as possible to 
avoid conflicts with the "VHOST-USER-IOTLB-MSG" message. In summary, 
thank you.
> 
> 
>>
>>>>
>>>>
>>>>> ---
>>>>>    hw/virtio/vhost-user.c | 10 ++--------
>>>>>    1 file changed, 2 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>>> index f214df804b..02caa94b6c 100644
>>>>> --- a/hw/virtio/vhost-user.c
>>>>> +++ b/hw/virtio/vhost-user.c
>>>>> @@ -2371,20 +2371,14 @@ static int vhost_user_net_set_mtu(struct 
>>>>> vhost_dev *dev, uint16_t mtu)
>>>>>    static int vhost_user_send_device_iotlb_msg(struct vhost_dev *dev,
>>>>>                                                struct 
>>>>> vhost_iotlb_msg *imsg)
>>>>>    {
>>>>> -    int ret;
>>>>>        VhostUserMsg msg = {
>>>>>            .hdr.request = VHOST_USER_IOTLB_MSG,
>>>>>            .hdr.size = sizeof(msg.payload.iotlb),
>>>>> -        .hdr.flags = VHOST_USER_VERSION | VHOST_USER_NEED_REPLY_MASK,
>>>>> +        .hdr.flags = VHOST_USER_VERSION,
>>>>>            .payload.iotlb = *imsg,
>>>>>        };
>>>>> -    ret = vhost_user_write(dev, &msg, NULL, 0);
>>>>> -    if (ret < 0) {
>>>>> -        return ret;
>>>>> -    }
>>>>> -
>>>>> -    return process_message_reply(dev, &msg);
>>>>> +    return vhost_user_write(dev, &msg, NULL, 0);
>>>>>    }
>>>>> -- 
>>>>> 2.27.0
>>>>
>>
> 

