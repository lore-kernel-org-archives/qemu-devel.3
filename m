Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CC4C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlOK-0005DM-Io; Mon, 21 Jul 2025 03:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udlNq-0004ue-68
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:56:30 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1udlNg-0004VN-UZ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:56:20 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56L7tv62077725
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 21 Jul 2025 16:55:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=sId88z5v9fsZXpP5tOL1mC3BwIsKh/8uTRsQMShVYjs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753084557; v=1;
 b=f3eILkdgKkCd9rEJJL3zY14tP8IE9pio/GZIUn0+4i7py418VZRI27NC/TbLtlYr
 KVwZ9zOcdSV5uoj7OT4ENqU2KzUSEoZIAudu9OI2jW1tS20eyzTqe7/8JRtlAzEt
 rebtQ6FA+Nyy9URXQHrkIP9+z6IVJ+IpNZZrR7qUz3gb7WuBCZc6AsPzSBCil8kz
 A/Y8QfRLLwQcP2w7h45BasEWz3zA1Ve21TZVMYPEzKK3VabcOAC+YDeIu5NlYtBg
 1SfPSteJ3BG1X7g+ESnRqZGosvAd3KMjuJdi2Ey/1U8DMRFWna/NMSX+92e+NT/T
 1aSQWsAFSPzjsxz2yiygUg==
Message-ID: <3a3ac19e-756e-4bcb-a25c-147c0d8c3f49@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 21 Jul 2025 16:55:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 04/13] virtio: serialize extended features state
To: Paolo Abeni <pabeni@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1752828082.git.pabeni@redhat.com>
 <88978e62d3eb7a58d7d647c7ee29f074ccc99bc0.1752828082.git.pabeni@redhat.com>
 <2e3a7cbd-1055-4888-9577-3344d42ea050@rsg.ci.i.u-tokyo.ac.jp>
 <5ff3f19a-8c01-4df8-a034-5d81184bd225@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5ff3f19a-8c01-4df8-a034-5d81184bd225@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/21 16:51, Paolo Abeni wrote:
>   7/20/25 12:44 PM, Akihiko Odaki wrote:
>> On 2025/07/18 17:52, Paolo Abeni wrote:
>>> @@ -3333,26 +3362,23 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>>>            vdev->device_endian = virtio_default_endian();
>>>        }
>>>    
>>> -    if (virtio_64bit_features_needed(vdev)) {
>>> -        /*
>>> -         * Subsection load filled vdev->guest_features.  Run them
>>> -         * through virtio_set_features to sanity-check them against
>>> -         * host_features.
>>> -         */
>>> -        uint64_t features64 = vdev->guest_features;
>>> -        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
>>> -            error_report("Features 0x%" PRIx64 " unsupported. "
>>> -                         "Allowed features: 0x%" PRIx64,
>>> -                         features64, vdev->host_features);
>>> -            return -1;
>>> -        }
>>> -    } else {
>>> -        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
>>> -            error_report("Features 0x%x unsupported. "
>>> -                         "Allowed features: 0x%" PRIx64,
>>> -                         features, vdev->host_features);
>>> -            return -1;
>>> -        }
>>> +    /*
>>> +     * Avoid silently breaking migration should the feature space increase
>>> +     * even more in the (far away) future
>>> +     */
>>> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
>>
>> This should be moved to around virtio_128bit_features_needed() and
>> vmstate_virtio_128bit_features as they make assumptions on the feature
>> space while virtio_load() doesn't.
> 
> Please allow me the following dumb question to try to avoid more
> iterations for small changes. I guess moving the above inside
> virtio_128bit_features_needed() would suffice?

Thinking more carefully, now I think it should be moved before or after 
vmstate_virtio.

virtio_128bit_features_needed() and vmstate_virtio_128bit_features will 
work fine even if the feature bitmask becomes 196-bit.  But 
vmstate_virtio will need to be updated to contain 
vmstate_virtio_196bit_features. So this assertion should be around 
vmstate_virtio.

Regards,
Akihiko Odaki

