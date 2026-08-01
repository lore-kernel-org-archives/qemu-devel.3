Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1270C54FCD
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wq4Er-0004KF-15; Sat, 01 Aug 2026 03:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq4En-0004Jp-LO
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 03:34:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wq4Ei-0001EU-TY
 for qemu-devel@nongnu.org; Sat, 01 Aug 2026 03:34:29 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6717YFpJ045046
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 1 Aug 2026 16:34:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Uredlk/Lh8RFePPbyh2ZPEpQZ+ZkibYcYDsvWnfaNTY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785569656; v=1;
 b=EQvSK8fEYnUXTPIH2RTqLqr7wAma866Xt7nL03TuVje1dcG8FiqH+qHiWza8YTUL
 jsD7NVeVtZslWwv/HCgNL1Nkpgu9ROTEFnT4xfTUS3oGJ5Aq7fQwq0VxdBi7dnRG
 7Djv8GNnImqAgdpzjKV7dIosB9TTUt1IkCNrWtLUTem0TgME/TMUNsW5ft44kyRo
 tCjk/dZffL05oa2kHm+AV8d9xe2X49/GzNupJ0rjHMlsy2e+H1X343KOqZGXFOTp
 StwUOXgTgn3LbkxjrsZOV2X7LZiBKSWiKRRfJrNtnVihOm7u7QSip2IQKhliFUlP
 c9w8hhnA8qSD8Cp9oJGU3Q==
Message-ID: <48bdaf93-70a0-4a0d-bc5d-3aeb1e603806@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 1 Aug 2026 16:34:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: validate blob iov size in
 create_blob
To: Thomas Huth <thuth@redhat.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260724035712.856636-1-marcandre.lureau@redhat.com>
 <bfcab7d8-c7ae-4c2a-be79-6bdc5c8faaf7@rsg.ci.i.u-tokyo.ac.jp>
 <b0733bce-3902-47a1-a617-5f4aeda06fbe@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b0733bce-3902-47a1-a617-5f4aeda06fbe@redhat.com>
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

On 2026/07/30 0:19, Thomas Huth wrote:
> On 24/07/2026 08.26, Akihiko Odaki wrote:
>> On 2026/07/24 12:57, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> virtio_gpu_resource_create_blob() stores the guest-controlled blob_size
>>> without checking it against the total size of the iov backing entries.
>>> Since both values are independently guest-controlled, a malicious guest
>>> can set blob_size much larger than the actual iov backing. Subsequent
>>> SET_SCANOUT_BLOB checks bounds against the inflated blob_size, allowing
>>> a pixman surface to be created over the undersized buffer. Any display
>>> refresh then reads past the actual allocation, potentially crashing
>>> QEMU or leaking host memory contents depending on the backing type.
>>>
>>> Reject the resource early when the iov backing is smaller than the
>>> declared blob_size.
>>
>> The same invariant also needs to be enforced when backing is supplied
>> by VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING and when blob migration state
>> is loaded. Otherwise, newly attached backing or state received from an
>> older source can bypass this fix.
>>
>> The check cannot be unconditional at resource creation, however. The
>> specification permits nr_entries == 0 so that backing can be attached
>> later for swap-in/swap-out. As written, this patch rejects that valid
>> request:
>>
>>  > To facilitate drivers that support swap-in and swap-out, nr_entries
>>  > may be zero and VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING may be
>>  > subsequently used. VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING may be
>>  > used to unassign memory entries.
>>
>> https://docs.oasis-open.org/virtio/virtio/v1.3/virtio- 
>> v1.3.html#x1-4120008
> 
> The patch that is proposed in https://gitlab.com/qemu-project/qemu/-/ 
> work_items/4112 also checks for res->iov_cnt > 0 ... would that fix your 
> concerns?

Yes, it would. Marc-André has since sent v3, which addresses my
concerns.

Regards,
Akihiko Odaki

> 
>   Thomas
> 
> 
> 
>>
>>>
>>> Fixes: CVE-2026-66021
>>> Fixes: e0933d91b1cd ("virtio-gpu: Add virtio_gpu_resource_create_blob")
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3945
>>> Reported-by: "sundayjiang(蒋浩天)" <sundayjiang@tencent.com>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   hw/display/virtio-gpu.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>>> index eac039c3c366..cc6dbd116618 100644
>>> --- a/hw/display/virtio-gpu.c
>>> +++ b/hw/display/virtio-gpu.c
>>> @@ -372,6 +372,16 @@ static void 
>>> virtio_gpu_resource_create_blob(VirtIOGPU *g,
>>>           return;
>>>       }
>>> +    if (iov_size(res->iov, res->iov_cnt) < res->blob_size) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: backing storage smaller than blob size\n",
>>> +                      __func__);
>>> +        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>>> +        virtio_gpu_cleanup_mapping(g, res);
>>> +        g_free(res);
>>> +        return;
>>> +    }
>>> +
>>>       virtio_gpu_init_udmabuf(res);
>>>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>>>   }
>>
>>
> 


