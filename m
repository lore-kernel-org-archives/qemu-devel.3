Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171BFCFA473
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 05:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMJhr-0007gs-Vr; Fri, 21 Nov 2025 00:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMJhp-0007gD-5Z
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:29:13 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vMJhm-0005kI-BN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 00:29:12 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5AL5SnEU039917
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 21 Nov 2025 14:28:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Bi3+h63lyqOwFhwJlKbv91J1B32RyaJUaUyjJh9qoyc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763702929; v=1;
 b=E7UczQLzIKATS4qVOEy0ohG1I/fn6kKjJY0lpvOjbQwNhgSbVkQsO9bRzrBbUoh1
 saHb3EOHEF2/S5mL4rBhdQX+wyiKk5gV3a5yYKdVKhUilOUAnvjaptHPKWtn5bxv
 2HtCeMYSdev6TpSPCcIMZo2SUbke3eO0ceRYAlmitmN8GUrgLnHrlHC5hepcNiox
 QFcb0Ia8C8sAYAJxuxzimfkD6+xtJSts11cUHY5JICj+xq/TzfwabOroo+7jG5zQ
 ETUhHm7SgSnzJGNTZqxWN9TUzuy26tsVuKTRdn5La7IXdoo6PXHPQG+unWYrisU5
 KzAWXAtteP18ZuLVNOpwww==
Message-ID: <21b94d50-79c4-4942-84f7-f4c96f432dd8@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 21 Nov 2025 14:28:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Honglei Huang <honghuan@amd.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com,
 dmitry.osipenko@collabora.com, alex.bennee@linaro.org
References: <20251121024705.1403042-1-honghuan@amd.com>
 <20251121024705.1403042-2-honghuan@amd.com>
 <b6f4cc26-7ebe-4b07-8e50-257b6f53d309@rsg.ci.i.u-tokyo.ac.jp>
 <db263884-6159-4d25-8c40-44dd78291714@amd.com>
 <ca2e398e-8158-4845-9798-6f444a73b103@rsg.ci.i.u-tokyo.ac.jp>
 <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c33300b0-b4db-44b0-be07-4e4382a0c0fb@amd.com>
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

On 2025/11/21 14:21, Honglei Huang wrote:
> 
> 
> On 2025/11/21 11:39, Akihiko Odaki wrote:
>> On 2025/11/21 12:14, Honglei Huang wrote:
>>>
>>>
>>> On 2025/11/21 10:56, Akihiko Odaki wrote:
>>>> On 2025/11/21 11:47, Honglei Huang wrote:
>>>>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>>>>> user pointer mapping for blob resources. This allows guest 
>>>>> applications
>>>>> to use user-allocated memory for GPU resources more efficiently.
>>>>>
>>>>> Changes include:
>>>>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>>>>> - Enhance blob resource creation to handle userptr flag properly
>>>>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>>>>> - Add conditional handling for userptr vs regular blob mapping
>>>>
>>>> I don't see the added conditional handling.
>>>
>>> Sorry, the additional handing is replaced by the fixing of value check.
>>> I will correct this commit message in the next version.
>>
>> Not just the commit message, but it also questions the utility of 
>> VIRTIO_GPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_F_RESOURCE_USERPTR. 
>> Neither of them adds a new functionality. They should be dropped if 
>> they are also replaced with the fix.
>>
> 
> Yes totally agreed, it is my mistaken, I shouldn't mix the code for 
> fixing and the code for adding new features in one submission.
> 
> Actually this patch set are for another components upstream test, for 
> the sake of convenience, I have added both the fix and feature here,
> that is a bad idea.
> 
> Will split the fix part into previous thread.
> 
> And for the check value fix thread, will send v4 as the final version.

Splitting fixes and features is a good idea, but that's not what I meant.

What I pointed out is that, it seems that one of the "features" you are 
adding, namely VIRTIO_GPU_F_RESOURCE_USERPTR does nothing at at all. So 
I'm wondering if you forgot to add a real implementation or the feature 
is just no longer necessary.

