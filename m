Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD68CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFyB0-0003Kb-Kr; Mon, 03 Nov 2025 12:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFyAx-0003Jh-Tn
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFyAo-0002RX-99
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762190208;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DRbf3LoVcfrVOSx1WXqimBeXS/kyXWpNjM1dEr33kmM=;
 b=JyzEkdBFG+iRwymftT1YhBmwobzCLE7aR+3V00Gmje83CCgajQviJWm7psN1P89BLUJXlH
 1VbVPxujNtmR9viI3QIKTxWuSBvTR5FqTyw88ROuIeM1K3yGqYwyo9vpVa/7t7wdEQDRJ4
 6qqAou00Cdxxb0kvGLNfUGMLs5WV9ps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-zXO_PtERP3ySWKiPj2ZHsQ-1; Mon, 03 Nov 2025 12:16:46 -0500
X-MC-Unique: zXO_PtERP3ySWKiPj2ZHsQ-1
X-Mimecast-MFC-AGG-ID: zXO_PtERP3ySWKiPj2ZHsQ_1762190205
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso56148705e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762190205; x=1762795005;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DRbf3LoVcfrVOSx1WXqimBeXS/kyXWpNjM1dEr33kmM=;
 b=wBmI2spHbxN3wRWTgWYMEMY8g+h94TsydkdKmBpzaR3PLisdi8d9ng9bMGjH1k3n2u
 lBh+E1bqK3q7/s3C0WCPQ8GPAoCwsxDdhHtbp2Rx2/13edshw2VbLAwYAtdAX5lrjcOV
 ueWcbpJVjEERqyTU57IowDkZOq+LmWm5tOiFSsCOLlhslE1K39FTSyACgB1CwpgTfp7P
 a2O/ZV80YOKH+NP8DCq0ca8c3sp8/FnF9TQKlFrzDfRe0loux9WXBKXpKJLnOLA15B5Y
 YF+c3LQEbRCCiVcMqNxho+MTu35LBd53F+xFkYNx8LVFmimBpTI4GnIf/hvp4jlNSKLW
 6kLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdIbduhp9Bw8TbbHUpavAlLY0cSLLsk4fI9GG30tEs0RIDAe2lQUU0gsh5jVEOdn38h20g+a+cat7I@nongnu.org
X-Gm-Message-State: AOJu0YzSu4oMf3qFYq0spMZu2tr2b7dHk7mbUFMapPDmZdZinzFrqaSg
 xXA2a7UrDQ3eMfQd6AEKEgdATRp1bEYP8fYbORGApCIlKFLNbGn8smM2OBNlN6e3cxSWVsyhoo3
 dujR6+PQ5e9GNpVPm4ZkQukdU+JmZM5Zn/0EEd0P+pv4KeoY9cpkkxKdi
X-Gm-Gg: ASbGncvZsCP0g4IJMHEkymLwuPTNLOx/9GA0Sdct3s8Q9ys4L+/bcoTA+w8hmEwGyov
 du0qXwZPx2I0+4Zwqs9+4937C5pAJIWs8E781GQeaPXACIRICZe5lJZAkVwU1OLkEsA2fpolO65
 a6dEhfytiW9eTIoK0VVpbiPD1wXc+oa/DxPbbWwWjqa+3o5DrlcSkN08k+zvnWDuHc+PiXyLctq
 2jnjcJHWF2b+jYB1O78EjOLH0yVwCM0wvxJH5KKWnTVkn/LwdFiIgnBXN5oK+NFmn/6KVKhpKlp
 xPZfJUv7FL2OIWDm+WtAWfhxuYImrTUkYqRSSsBMe2MBAfHMCOdu6P0qASrQgv9ANLF9Mk+x5a2
 Xt7AGFR+H5LnNI+P7eznQrVTzp7KVgqdl4j/WESRtJznzPA==
X-Received: by 2002:a05:600c:524f:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-477308b6117mr130054815e9.21.1762190205004; 
 Mon, 03 Nov 2025 09:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeYQoGzAIioi2mvmOveqL+906lm784oVf6qho3/xtwhEyvhdEOKfQHofaM8Eg9TcUfcRfYug==
X-Received: by 2002:a05:600c:524f:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-477308b6117mr130054455e9.21.1762190204532; 
 Mon, 03 Nov 2025 09:16:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c1142e7dsm21585579f8f.17.2025.11.03.09.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 09:16:43 -0800 (PST)
Message-ID: <fd884771-f6ab-4524-92e7-76932469b816@redhat.com>
Date: Mon, 3 Nov 2025 18:16:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-20-skolothumtho@nvidia.com>
 <CABQgh9ENUvSJ5UiPGDbdQ_VPm5PtdFVmEM_27Z9QEb4O29cKwQ@mail.gmail.com>
 <CH3PR12MB7548CA41C51C4B6C01CDBA73ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548CA41C51C4B6C01CDBA73ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/3/25 4:42 PM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Sent: 01 November 2025 14:20
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
>> ddutile@redhat.com; berrange@redhat.com; Nathan Chen
>> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw
>> info and validate
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi, Shameer
>>
>> On Fri, 31 Oct 2025 at 18:54, Shameer Kolothum
>> <skolothumtho@nvidia.com> wrote:
>>> Just before the device gets attached to the SMMUv3, make sure QEMU
>>> SMMUv3 features are compatible with the host SMMUv3.
>>>
>>> Not all fields in the host SMMUv3 IDR registers are meaningful for
>> userspace.
>>> Only the following fields can be used:
>>>
>>>   - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16,
>> TTF
>>>   - IDR1: SIDSIZE, SSIDSIZE
>>>   - IDR3: BBML, RIL
>>>   - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K
>>>
>>> For now, the check is to make sure the features are in sync to enable
>>> basic accelerated SMMUv3 support.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 100
>>> ++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 100 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c index
>>> a2deda3c32..8b9f88dd8e 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -28,6 +28,98 @@ MemoryRegion root;
>>>  MemoryRegion sysmem;
>>>  static AddressSpace *shared_as_sysmem;
>>>
>>> +static bool
>>> +smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>> +                                 struct iommu_hw_info_arm_smmuv3 *info,
>>> +                                 Error **errp) {
>>> +    /* QEMU SMMUv3 supports architecture version 3.1 */
>>> +    if (info->aidr < s->aidr) {
>>> +        error_setg(errp, "Host SMMUv3 architecture version not compatible");
>>> +        return false;
>>> +    }
>> Why has this requirement?
> Right. That was added based on a comment from Eric here,
> https://lore.kernel.org/all/b6105534-4a17-4700-bb0b-e961babd10bb@redhat.com/
>
>> We have SMMUv3 version 3.0 and info->aidr = 0.
>> and qemu fails to boot here.
> Hmm.. It is true that there are hardware out there which implements a cross
> section of features from architecture revisions.
>
> Since we are checking the ID registers that matters here individually anyway,
> I am not sure whether we should restrict those with AIDR mismatch or just
> warn the user.
OK. Just maybe document its is irrelevant to check AIDR in the commit
msg for that reason.

With that commit msg update + removal of AIDR code feel free to take my
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
>
> Thanks,
> Shameer
>
>
>


