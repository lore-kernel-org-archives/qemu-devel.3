Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83992C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0ns-0007lj-Ij; Wed, 16 Jul 2025 08:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0hX-0003Sg-Ff
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:53:31 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0hN-0007uX-W0
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 07:53:30 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56GBqwpA031686
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 16 Jul 2025 20:52:58 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GjmQy1NDdPTuVHZ8/I+mITVpluhpLhXagsPnL+0J/Xg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752666778; v=1;
 b=hprgm3PpWQDIea4b3TZFFZvlQqyxDueU0KfvU7e+sDbGB4v/APBXZ8awCFsydQS6
 xGqDrWRfZ/t0cH2KfAIkEs7Hu/ebwYwRKyGbAsxln4h+Do2LMKnrvhoZ446q/Q/f
 MtuXsvEJNrM2JX/QWpNQ4bp89CtBsZs/YhDYYoM3IkT0tuXu+pMNJP58qLQajhsf
 TpbmW2gSNcf40QPPXgIzRVi+gp0q6ldMdi7vY67j8WLB2JrbsvwNzJHWeJRdh2pU
 nGmxBD+PrtlwpIHV4UvMfFB7LrIGk0F4Y5uzolNouSm4ZwGi2UV6899jQQFSkNlV
 7ppPd8PMrkGmHUEYT5BM3g==
Message-ID: <07b09740-9e20-43df-a128-83e62e7a34a2@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 16 Jul 2025 20:52:58 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 04/13] virtio: serialize extended features state
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
 <d0f97a8157c718dcb0799353394e1469153c6b22.1752229731.git.pabeni@redhat.com>
 <08285c9c-f522-4c64-ba3b-4fa533e42962@rsg.ci.i.u-tokyo.ac.jp>
 <efd96b88-284c-4853-93ea-9e1b81b1ffe7@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <efd96b88-284c-4853-93ea-9e1b81b1ffe7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2025/07/16 0:40, Paolo Abeni wrote:
> On 7/15/25 9:24 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> +     */
>>> +    QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_DWORDS != 2);
>>> +    if (virtio_128bit_features_needed(vdev)) {
>>
>> There is no need to distinguish virtio_128bit_features_needed() and
>> virtio_64bit_features_needed() here.
> 
> Double checking I'm reading the above correctly. Are you suggesting to
> replace this chunk with something alike:
> 
>      if (virtio_64bit_features_needed(vdev)) {

This condition is not right as virtio_64bit_features_needed() doesn't 
return true when the some of bits [64, 128) is set while bits [32, 64) 
are cleared. I see two options to fix:

- Check: virtio_64bit_features_needed(vdev) ||
          virtio_128bit_features_needed(vdev)

- Ensure that virtio_64bit_features_needed(vdev) returns true when a bit 
more significant than bit 31 is set.

>          /* The 64 highest bit has been cleared by the previous
>           *  virtio_features_from_u64() and ev.
>           * initialized as needed when loading
>           * "virtio/128bit_features"*/
>          uint64_t *val = vdev->guest_features_array;
> 
>          if (virtio_set_128bit_features_nocheck_maybe_co(vdev, val) < 0)
> // ...> >> For the 32-bit case, it will be simpler to have an array here and use
>> virtio_set_128bit_features_nocheck_maybe_co() instead of having
>> virtio_set_features_nocheck_maybe_co().
> 
> Again double checking I'm parsing the above correctly. You are
> suggesting to dismiss the  virtio_set_features_nocheck_maybe_co() helper
> entirely and use virtio_set_128bit_features_nocheck_maybe_co() even when
> only 32bit features are loaded. Am I correct?

Yes, but now I found it is unnecessary to special-case even the 32-bit case.

Commit 019a3edbb25f ("virtio: make features 64bit wide") had to add a 
conditional to distinguish the 64-bit and 32-bit cases because 
vdev->guest_features was not set before executing this part of code.

However, commit 62cee1a28aad ("virtio: set low features early on load") 
later added preceding code to set vdev->guest_features. In summary, this 
part of code can be simply replaced with:

     if (virtio_set_128bit_features_nocheck_maybe_co(vdev, 
vdev->guest_features_array) < 0) {
         error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
                         "Allowed features: 0x" VIRTIO_FEATURES_FMT,
                         VIRTIO_FEATURES_PR(val),
                         VIRTIO_FEATURES_PR(vdev->host_features_array));
         return -1;
     }

There is no need of virtio_64bit_features_needed(vdev) or 
virtio_128bit_features_needed(vdev) at all.

I have another finding by the way; there are three phrases that refers 
to the new extension: array (e.g., guest_features_array), _ex (e.g., 
virtio_add_feature_ex), 128bit (e.g., virtio_128bit_features_needed).

It makes sense to make "128bit" an exception in the migration code 
because the migration format is fixed and will require e.g., "192bit" 
for a future extension. But two suffixes, _ex and _array, can be unified.

Regards,
Akihiko Odaki

