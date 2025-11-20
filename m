Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA81CF58D1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 01:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLtUk-0002WY-JA; Wed, 19 Nov 2025 20:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLtUh-0002Vy-5A
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:29:55 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vLtUd-0001ra-Ql
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 20:29:54 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AK1TQ8Y040616
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Nov 2025 10:29:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CDRSOb2cz+/Jmuj7EmtJdK72nPeehFqaU+MTNgPADwQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763602166; v=1;
 b=Ht7V9ZNHKs6pmwdaqNrG1srUcgs4MiJ+IFA5hH8riRqjeffqF26xRLKDjKlQ//dQ
 A3fCeTMFIgwTnAYnCufglTQX5OaMu33N/aAmq4zBH+n4fiv7szQastyYW/eAvsPv
 GsbW1Iv9EMgrS1G62NU+1G8ndNRKITm/7NeOW97CsX30F2km3yfSonr9OIWxZkSg
 DU3HEMJ5+3aqfl84rac6ABqKXSObGTXZg2W1O9IXYG1E1+DC7c0edWjY6mw/b04k
 W1iygdRdSeZ9AHvjXisxsDFEzMnod598Ypz1Vvlw8W9V9zL/d/coMj91S7x39d96
 +Yn5G5xZsG7hci1Ta+InTQ==
Message-ID: <d0005fdb-29ac-471f-b2dd-9eddebb6bd83@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 20 Nov 2025 10:29:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Honglei Huang <honghuan@amd.com>, Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
 <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
 <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2025/11/20 4:16, Dmitry Osipenko wrote:
> On 11/18/25 15:32, Honglei Huang wrote:
>>
>>
>> On 2025/11/18 09:48, Dmitry Osipenko wrote:
>>> On 11/17/25 16:22, Markus Armbruster wrote:
>>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>>
>>>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-
>>>>>> gpu-rutabaga.c
>>>>>> index ed5ae52acb..ea2928b706 100644
>>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g,
>>>>>> struct virtio_gpu_ctrl_command *cmd)
>>>>>>          ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>>>>> sizeof(att_rb),
>>>>>>                                            cmd, NULL, &res->iov,
>>>>>> &res->iov_cnt);
>>>>>> -    CHECK(!ret, cmd);
>>>>>> +    CHECK(ret >= 0, cmd);
>>>>>
>>>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>>>> see how this change improves anything. You now saying that ret > 0 is
>>>>> okay, while it shall never happen.
>>>>
>>>> Please see
>>>>
>>>>       Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
>>>> virgl_cmd_resource_create_blob
>>>>       Date: Mon, 17 Nov 2025 08:49:42 +0100
>>>>       Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>>>       https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>>>
>>> It's a rather common bug when errno isn't negated by mistake and a
>>> positive error code is returned. Ignoring positive values when they
>>> aren't expected opens door to unnecessary problems, IMO.
>>>
>>
>> How about apply the v2 or v3 firstly to fix the
>> virtio_gpu_create_mapping_iov() block issue in virtio-gpu?
>>
>> I will create another thread for the `CHECK(!ret, cmd);` thing in rutabaga.
> 
> There was a precedent of virtio-gpu not handling positive error codes
> properly [1]. To me there is no problem that needs to be fixed when
> virtio_gpu_create_mapping_iov() is never expected to return positive
> values and doesn't return them.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20240129073921.446869-1-dmitry.osipenko@collabora.com/
> 
> It's a common expectation that errors are negative. But in practice it's
> not always true, especially when interacting with external code.
> 
> Functionally this patch doesn't change anything. Will leave to Alex and
> Akihiko to decide on it.

I'm fine either way.

This is a "trade-off" scenario where both two options have upsides and 
downsides. I often avoid making an argument in that case because it 
tends to be subjective and cannot be confirmed, leading to bikeshedding.

In my opinion, such a function should not return int in the first place, 
but should return bool. The wide range of values int can take causes 
problems; bool allows compilers to enforce that it only returns two values.

Sign is one of those problems. int leads to a mistake like returning 
errno instead of -errno.

Functions may have completely different ideas for integer return values. 
In case of virtio-gpu, virtio_gpu_create_mapping_iov() returns -1 but 
virtio_gpu_update_dmabuf() returns -EINVAL. This is confusing.

Sometimes it is still preferred to keep functions returning int for 
consistency, but looking at include/hw/virtio/virtio-gpu.h, three return 
bool and three return int, so returning int here does not improve 
consistency.

That all said, this is a bug fix, not refactoring. This patch does fix a 
bug and avoids polluting the codebase, so it is fine for me. Perhaps it 
may be nice to have a patch to convert all functions returning int to 
bool to avoid pitfalls and improve consistency, but that can be done later.

Regards,
Akihiko Odaki

