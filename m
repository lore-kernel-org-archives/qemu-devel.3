Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F2ACF58C9
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 19:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLnfI-00076C-N9; Wed, 19 Nov 2025 14:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLnfG-00075y-4O
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:16:26 -0500
Received: from sender3-pp-f112.zoho.com ([136.143.184.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vLnfD-0003yQ-7E
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 14:16:25 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1763579769; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nLIGkIkw91hgLo244drdetzl2JWV4JjRehv2dv0XSQkozGWSObjEO4hxtBLR+6XkjlsCmNdzmin+aHnsXfbU3cL4Cfg75Q/tA/ec/PpU09Z0F+kE6TEIqeGx1sa/5HBJNHDDcpWstyzaYNZuyACohzSpT6h2elmXTt/6fcMKhBc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763579769;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=WtpwqJhxs/OAOy+zLcxQX3VGTnfSFwgKJxiwjQWTpFo=; 
 b=bo0nleO45/r3GWQygEHpQKLWzGe9gWUoBlUohK+BtlIApM2o6izSHnc5Oa/Vzk/mzcaibT0KGjrSxAbN2U3srxjveUTEE4VMs+XdeE+WBBneO2HlFuihj0fMxU72/b2RQMq8NgROFsb/Q95IslymrWr12Ry4/xhvfK4XtAMGPOw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763579769; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=WtpwqJhxs/OAOy+zLcxQX3VGTnfSFwgKJxiwjQWTpFo=;
 b=Vj6mqfUbQlGBX7z3VxlJsUNOn4qAK36vXkuC0OrVi4tGkyjHIyh7Fh0eqJ01qbKW
 dRGaxjBm05/y/PLcPPUwJArVunJ+vzgPcd+iEM5oHmu0N0EMnz9OBtqMH4gygJKVhx8
 Bi5MuhzrvYKVMo0FmiMEfI7YzEC8C86sSqxV4o3w=
Received: by mx.zohomail.com with SMTPS id 1763579767683472.1310045741768;
 Wed, 19 Nov 2025 11:16:07 -0800 (PST)
Message-ID: <cc80a97c-ca8c-4da6-bbd9-77f1c90a299d@collabora.com>
Date: Wed, 19 Nov 2025 22:16:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4] virtio-gpu: use consistent error checking style for
 virtio_gpu_create_mapping_iov
To: Honglei Huang <honghuan@amd.com>, Markus Armbruster <armbru@redhat.com>
Cc: alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp, mst@redhat.com,
 cohuck@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 Ray.Huang@amd.com
References: <20251117105104.258513-1-honghuan@amd.com>
 <9f547fbe-ea57-4784-9e37-f79b52b551a9@collabora.com>
 <87bjl0pzeq.fsf@pond.sub.org>
 <ed8fd731-8e47-4282-9439-00e6c367b672@collabora.com>
 <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <e04a19fb-73bb-471f-94d9-df9b1d08d6d4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.184.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender3-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/18/25 15:32, Honglei Huang wrote:
> 
> 
> On 2025/11/18 09:48, Dmitry Osipenko wrote:
>> On 11/17/25 16:22, Markus Armbruster wrote:
>>> Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:
>>>
>>>> On 11/17/25 13:51, Honglei Huang wrote:
>>>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-
>>>>> gpu-rutabaga.c
>>>>> index ed5ae52acb..ea2928b706 100644
>>>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>>>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g,
>>>>> struct virtio_gpu_ctrl_command *cmd)
>>>>>         ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries,
>>>>> sizeof(att_rb),
>>>>>                                           cmd, NULL, &res->iov,
>>>>> &res->iov_cnt);
>>>>> -    CHECK(!ret, cmd);
>>>>> +    CHECK(ret >= 0, cmd);
>>>>
>>>> virtio_gpu_create_mapping_iov() doesn't return positive values, don't
>>>> see how this change improves anything. You now saying that ret > 0 is
>>>> okay, while it shall never happen.
>>>
>>> Please see
>>>
>>>      Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
>>> virgl_cmd_resource_create_blob
>>>      Date: Mon, 17 Nov 2025 08:49:42 +0100
>>>      Message-ID: <87ms4lrtd5.fsf@pond.sub.org>
>>>      https://lore.kernel.org/qemu-devel/87ms4lrtd5.fsf@pond.sub.org/
>>
>> It's a rather common bug when errno isn't negated by mistake and a
>> positive error code is returned. Ignoring positive values when they
>> aren't expected opens door to unnecessary problems, IMO.
>>
> 
> How about apply the v2 or v3 firstly to fix the
> virtio_gpu_create_mapping_iov() block issue in virtio-gpu?
> 
> I will create another thread for the `CHECK(!ret, cmd);` thing in rutabaga.

There was a precedent of virtio-gpu not handling positive error codes
properly [1]. To me there is no problem that needs to be fixed when
virtio_gpu_create_mapping_iov() is never expected to return positive
values and doesn't return them.

[1]
https://lore.kernel.org/qemu-devel/20240129073921.446869-1-dmitry.osipenko@collabora.com/

It's a common expectation that errors are negative. But in practice it's
not always true, especially when interacting with external code.

Functionally this patch doesn't change anything. Will leave to Alex and
Akihiko to decide on it.

-- 
Best regards,
Dmitry

