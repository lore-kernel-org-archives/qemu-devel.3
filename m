Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C1ACA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 14:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEos6-0007iA-U4; Thu, 08 Oct 2026 10:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEorz-0007fy-7E
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 10:13:16 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xEorw-00089U-D6
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 10:13:14 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 698ECkkD057270
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 8 Oct 2026 23:12:46 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=q6F/lyqzZmF5YyK4mEKz5Ifz9iz9NqN/nIx3FJEpqfs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791468766; v=1;
 b=QZUyfcOxcb1mJ0T0uJuhNgjCEF+zFB9Rdm0Jk+BaPahfsjVnRUpTFlilXCL7vNx9
 5R3aufzSdWMCtIMA4I2VKo6a5bTO0OshygnQbu4Ib6QSlwem9Q/nC7zFaMWRLLeb
 Htl/HkfU+q7m1uoqMuj28FwE07QCRlEHMGX+RsvcC+TyELDxy2oiMbdzioUt/xif
 4DuGtc+/pnc1cEwrawawJEkEiaemaYc3TvN3ccRo8W4p2t91lvr3leERnUR043bS
 orJIuO4+YA8L0NDv63ndop0FiY5tQIU8nHGh7ykmS3Xs+x76p27MXeOTcnY46BAx
 pqpLnThZ+mrOmY+Bf8oHew==
Message-ID: <401f2593-6492-4923-a29a-0161108ce1cc@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 8 Oct 2026 23:12:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/22] vhost: release ownership in vhost_dev_cleanup()
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: dwmw2@infradead.org, mst@redhat.com, vsementsov@yandex-team.ru,
 farosas@suse.de, peterx@redhat.com, dongli.zhang@oracle.com,
 den@openvz.org, mark.kanda@oracle.com, sgarzare@redhat.com,
 maciej.szmigiero@oracle.com, philmd@oss.qualcomm.com,
 bchaney@akamai.com, clg@redhat.com
References: <20261007-up-vsock-vhost-v5-v14-0-e16de9962df0@virtuozzo.com>
 <20261007-up-vsock-vhost-v5-v14-15-e16de9962df0@virtuozzo.com>
 <ca73056c-cde7-4835-b62f-48d9b498eb74@rsg.ci.i.u-tokyo.ac.jp>
 <26d93613-15db-468d-9845-9f47d93610ff@virtuozzo.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <26d93613-15db-468d-9845-9f47d93610ff@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/10/08 17:37, Andrey Drobyshev wrote:
> On 10/7/26 6:37 PM, Akihiko Odaki wrote:
>> On 2026/10/07 17:40, Andrey Drobyshev wrote:
>>> vhost_dev_cleanup() closes the backend FD, but that doesn't release the
>>> device ownership taken with VHOST_SET_OWNER if the same file is open
>>> elsewhere.  That's the case on a CPR target: the source keeps the FD,
>>> so if the target fails after SET_OWNER, either inside vhost_dev_init()
>>> or later in its caller, the ownership stays with the target.  Once the
>>> source is resumed it can't take the device back, SET_OWNER fails with
>>> EBUSY.
>>>
>>> Track the ownership with a new 'owner' flag in struct vhost_dev, set and
>>> cleared by vhost_dev_set_owner() and vhost_dev_reset_owner(), and issue
>>> VHOST_RESET_OWNER in vhost_dev_cleanup() if it's set, as the common
>>> teardown for all those paths.  That should be safe in any case: the kernel
>>> refuses it from a non-owner, and an owner is about to close the FD anyway.
>>>
>>> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>    hw/virtio/vhost.c         | 24 ++++++++++++++++++++++--
>>>    include/hw/virtio/vhost.h |  5 +++++
>>>    2 files changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>>> index c01ccc800cb..3432b9a43c8 100644
>>> --- a/hw/virtio/vhost.c
>>> +++ b/hw/virtio/vhost.c
>>> @@ -1705,20 +1705,32 @@ int vhost_dev_init_backend(struct vhost_dev *hdev, void *opaque,
>>>    
>>>    int vhost_dev_set_owner(struct vhost_dev *hdev)
>>>    {
>>> +    int r;
>>> +
>>>        assert(hdev->vhost_ops);
>>>        if (!hdev->vhost_ops->vhost_set_owner) {
>>>            return -ENOSYS;
>>>        }
>>> -    return hdev->vhost_ops->vhost_set_owner(hdev);
>>> +    r = hdev->vhost_ops->vhost_set_owner(hdev);
>>> +    if (!r) {
>>> +        hdev->owner = true;
>>> +    }
>>> +    return r;
>>>    }
>>>    
>>>    int vhost_dev_reset_owner(struct vhost_dev *hdev)
>>>    {
>>> +    int r;
>>> +
>>>        assert(hdev->vhost_ops);
>>>        if (!hdev->vhost_ops->vhost_reset_owner) {
>>>            return -ENOSYS;
>>>        }
>>> -    return hdev->vhost_ops->vhost_reset_owner(hdev);
>>> +    r = hdev->vhost_ops->vhost_reset_owner(hdev);
>>> +    if (!r) {
>>> +        hdev->owner = false;
>>> +    }
>>> +    return r;
>>>    }
>>>    
>>>    int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>>> @@ -1864,6 +1876,14 @@ void vhost_dev_cleanup(struct vhost_dev *hdev)
>>>        g_free(hdev->mem);
>>>        g_free(hdev->mem_sections);
>>>        if (hdev->vhost_ops) {
>>> +        /*
>>> +         * Release the device ownership if we hold it.  Needed e.g. for
>>> +         * failing CPR target, so the source can re-acquire it.
>>> +         */
>>> +        if (hdev->owner && vhost_dev_reset_owner(hdev) < 0) {
>>> +            error_report("vhost: cannot release device ownership on "
>>> +                         "cleanup");
>>
>> Normal teardown produces a misleading ownership error. vhost-user and
>> vDPA set owner=true but do not implement vhost_reset_owner, so the
>> helper returns -ENOSYS. The new cleanup diagnostic therefore reports
>> ordinary cleanup as a failure. I reproduced the message with the
>> following test command even though it passes:
>>
>> meson test -C build --no-rebuild -v \
>>     --suite qtest-x86_64 '*qos-test*' \
>>     --test-args '-p
>> /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-net-pci/virtio-net/virtio-net-tests/vhost-user/read-guest-mem/memfd'
>>
>> Regards,
>> Akihiko Odaki
> Ah, looks you're right again.  I just noticed that the error goes silent
> here and we better somehow flag it, even though we can't do anything
> about it at this point.  I guess we can just ignore the cases where
> either the backend doesn't have the reset_owner() callback (in this case
> we get -ENOSYS) and when the kernel driver itself doesn't support
> RESET_OWNER operation (in this case we get -ENOTTY).  So smth like:
> 
>      r = vhost_dev_reset_owner(hdev);
>      if (r < 0 && r != -ENOSYS && r != -ENOTTY) {
>          error_report(...);
>      }
> 
> I'll post this if you don't have any objections.

The -ENOSYS filtering fixes what I reported, but this check misses a 
kernel quirk: unsupported VHOST_RESET_OWNER can return -EFAULT.

For example, Linux v6.12’s vhost-vsock forwards unknown requests through
vhost_dev_ioctl() to vhost_vring_ioctl(). The latter reads a queue
index from the argument before checking the command. QEMU passes NULL,
so that read fails with -EFAULT. QEMU already documents this quirk in 
vhost_kernel_set_features().

I'm a bit concerned that this check may not be reliable enough and 
result in false-positives/negatives or a behavioral change in the 
future. Perhaps having a flag to tell that devices need explicit 
ownership release for CPR may be an option. The source must have 
successfully reset ownership on the same FD before the target acquires 
it. A reset failure on the target therefore deserves reporting, 
regardless of errno.

Regards,
Akihiko Odaki

