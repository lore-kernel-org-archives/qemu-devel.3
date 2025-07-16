Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793F3C83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 12:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc0tI-00037x-AN; Wed, 16 Jul 2025 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0oy-0008TZ-7D
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:01:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uc0ou-0000yE-82
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 08:01:11 -0400
Received: from [157.82.206.39] ([157.82.206.39]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56GC0iQM034126
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 16 Jul 2025 21:00:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=DUA9zl7P8Tu6TlT+ueMdR11qSW4yTfnVp0swAEHI/jQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1752667245; v=1;
 b=r0QJjZ2zldg5upfbmdV0xlKdIRFSCo46g8rvFdC6ZqbhkIZ4W6f5oixA1Ej1rS4D
 3Pxc3ZU4hugUbGXYOC81Uow6nm85VbUQowSjLl5q/Y/MeiklcviWe58Hb5y2JgkA
 1yG0ZUCUrmeASrQC0cE4pHWssBTHVtVfB0q0kWtJc7EwLQVQDPuOlHkFVpZQ7hMi
 UilgRZ5ZlHLoXMhUdTi0Qxw2sj6eTVao2lg3Vm8/+h3qKekI3wEjNs68fXGxvV+I
 GHHv9BSYbmUuTu/K68sbByjCR7PsUdvy9QljiqiSM2AJ2Bl/YSZpt56OrDHbBx4M
 dFOnnmTxJLGpDEu3b3k96Q==
Message-ID: <c1c64a05-49c3-45b3-bb8a-8fc075e57286@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 16 Jul 2025 21:00:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/13] qmp: update virtio features map to support
 extended features
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
 <5f5a6718fa5ae82d5cd3b73523deea41089ffeb5.1752229731.git.pabeni@redhat.com>
 <aab8c434-364e-4305-9d8b-943eb0c98406@rsg.ci.i.u-tokyo.ac.jp>
 <b0ff2033-b8ab-4cee-833c-83e70951a9d9@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b0ff2033-b8ab-4cee-833c-83e70951a9d9@redhat.com>
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

On 2025/07/16 0:43, Paolo Abeni wrote:
> On 7/15/25 9:59 AM, Akihiko Odaki wrote:
>> On 2025/07/11 22:02, Paolo Abeni wrote:
>>> @@ -785,11 +821,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>>>            status->vhost_dev->nvqs = hdev->nvqs;
>>>            status->vhost_dev->vq_index = hdev->vq_index;
>>>            status->vhost_dev->features =
>>> -            qmp_decode_features(vdev->device_id, hdev->features);
>>> +            qmp_decode_features(vdev->device_id, hdev->features_array);
>>>            status->vhost_dev->acked_features =
>>> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
>>> +            qmp_decode_features(vdev->device_id, hdev->acked_features_array);
>>>            status->vhost_dev->backend_features =
>>> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
>>> +            qmp_decode_features(vdev->device_id, hdev->backend_features_array);
>>> +
>>>            status->vhost_dev->protocol_features =
>>>                qmp_decode_protocols(hdev->protocol_features);
>>>            status->vhost_dev->max_queues = hdev->max_queues;
>>> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
>>> index 245a446a56..e0a1e49035 100644
>>> --- a/hw/virtio/virtio-qmp.h
>>> +++ b/hw/virtio/virtio-qmp.h
>>> @@ -18,6 +18,7 @@
>>>    VirtIODevice *qmp_find_virtio_device(const char *path);
>>>    VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>>>    VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
>>> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
>>> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
>>> +                                          const uint64_t *bitmap);
>>>    
>>>    #endif
>>> diff --git a/qapi/virtio.json b/qapi/virtio.json
>>> index 73df718a26..f0442e144b 100644
>>> --- a/qapi/virtio.json
>>> +++ b/qapi/virtio.json
>>> @@ -488,14 +488,18 @@
>>>    #     unique features)
>>>    #
>>>    # @unknown-dev-features: Virtio device features bitmap that have not
>>> -#     been decoded
>>> +#     been decoded (lower 64 bit)
>>> +#
>>> +# @unknown-dev-features-dword2: Virtio device features bitmap that have not
>>> +#     been decoded (bits 65-128)
>>>    #
>>>    # Since: 7.2
>>>    ##
>>>    { 'struct': 'VirtioDeviceFeatures',
>>>      'data': { 'transports': [ 'str' ],
>>>                '*dev-features': [ 'str' ],
>>> -            '*unknown-dev-features': 'uint64' } }
>>> +            '*unknown-dev-features': 'uint64',
>>> +            '*unknown-dev-features-dword2': 'uint64' } }
>>
>> Let's omit "dword" for consistency with unknown-dev-features, which is
>> also uint64 but don't have the keyword.
> 
> Ok. Can I infer that is actually legit to update a qapi struct
> definition? It's not clear to me it such change violates any qemu
> assumptions.

Adding a property is fine but renaming one is not as it can break 
application that use QAPI such as libvirt. For some guidance, please 
see: docs/devel/qapi-code-gen.rst

