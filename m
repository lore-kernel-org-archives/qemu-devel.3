Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50D8ECD6D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 17:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqENc-0004ME-Q4; Wed, 11 Feb 2026 12:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqENY-0004LL-R7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:51:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqENW-0006v0-Te
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 12:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770832313;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qI/qofWfZIRirg8gzjCcuh7D1eweaq0hEpcj1J2zlk4=;
 b=c5TRXIOorlKPmDU3w5yA7Znz5GHOv9ItM0su+zBBrc5T+3r/wU/Pxrc8/mqLk1WEJ1hNK5
 Wg6MaNaPwG8sU7dV+pjAZKTyHmH+oafUMTvoFKzI6J8Zb6YM2OLZXA99iaSFIra9YUcg57
 ZHJhmSagpklGXF16C0frvy0B2rOlLhQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-9KB4mivTNAuPKTGQhgfPHw-1; Wed, 11 Feb 2026 12:51:52 -0500
X-MC-Unique: 9KB4mivTNAuPKTGQhgfPHw-1
X-Mimecast-MFC-AGG-ID: 9KB4mivTNAuPKTGQhgfPHw_1770832311
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-435a11575ecso2472352f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 09:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770832311; x=1771437111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qI/qofWfZIRirg8gzjCcuh7D1eweaq0hEpcj1J2zlk4=;
 b=SEuAAKvQsy/UM3W7M23yy8gC1QozY8tIJlVVwyIcLnMSuUG5gNufhjvpG6kHBOwXz0
 nIg8xm7pb54wKn48YywXYDuS0YhnPNb6cTcuW4TDe6t0MPgg+8sRcSAYZcRLQ5CSpoqG
 lFJSuyT84zx5DsXalrE/+yFsfJ/SV+2F112CWcIbs2zr0xcx8MvEyHWNVC2QfBKdILJK
 borSM6gZ2EhAOPDpile3rbD8qUto+V6p9ZTPEb0V+b/uUMpFqnb5QB8iMoydTv8vr/2S
 4rHhKzo3QQKoILjB16ycQaTBONDB3CYcEavcWQYeauv/Y/80K5gtF2tIHA4CemQVnZjt
 SqEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXtAjUhpD/Gxttzrf4ZeN55mqvuo1u5X1q6PIa6MTRDxNKeyhzZw75QoJOo34mThbw2RBrvRorLtSo@nongnu.org
X-Gm-Message-State: AOJu0Yw99j0KZ55EWrUoGasdeD0ONm8BJEbBG7jjnRzPc23DvxSWSyK0
 ZQ52zGAmBUebMIXJys04+ktsJIx8tVQE/uZG9ah+KE8RsBzRIsgAtNH7gTXsgpt4umqcf1644XM
 OV4Lvo+dYejnyO4K5amm+bgm1CZzovo5JGXbkf9VzrPgNmTHcFXllWkDt
X-Gm-Gg: AZuq6aJsqlWpnmoPt6BKR/3zt8R14+kbqXhMAgNAsHYP2/etsvMkMOR7E0HroHjB1fJ
 1QzfKwS4WyEzI0HW8ZlPAC/MC4ziNa8jTquPIoS3ozTsLhseHitsBwhNr4dLTFq8frOJj6U3Gvy
 uMwySTq3dDM17+z2qcw3rVAwE9d9izemZwtcYYmsM5vhQwwRwSPe4bNKguxi5rPS86w4MWgD8zU
 e3h3L/1AdtvZU424FhGH33O8U/h45oyEd/TMB/8mxZFn2nPdTFz+y9Sn8yCMYfAkImPkXOtBfI9
 1Wg/3oTRqloA93bc0njIfiGq1B8fsgkl6VVPX7vpB7tAAGHIXb7IMhx5U0W+YZZhQQ/dR6rSGQd
 pkJpDET9OwR8UIaf30KJXyYnCU7eraBuoV4R9uaQPxcMd9VrCbhNsI4fJXVzY2d1fKsMSrg==
X-Received: by 2002:a05:6000:25c8:b0:436:3536:f698 with SMTP id
 ffacd0b85a97d-4378ac8417bmr386682f8f.30.1770832310763; 
 Wed, 11 Feb 2026 09:51:50 -0800 (PST)
X-Received: by 2002:a05:6000:25c8:b0:436:3536:f698 with SMTP id
 ffacd0b85a97d-4378ac8417bmr386650f8f.30.1770832310357; 
 Wed, 11 Feb 2026 09:51:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d325f7sm6196314f8f.8.2026.02.11.09.51.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 09:51:49 -0800 (PST)
Message-ID: <d988581b-b416-4141-9736-51268a3f0c40@redhat.com>
Date: Wed, 11 Feb 2026 18:51:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260211083415.133534-1-skolothumtho@nvidia.com>
 <20260211083415.133534-6-skolothumtho@nvidia.com>
 <275ab451-4c37-4a78-bf5b-a76329bbf873@redhat.com>
 <CH3PR12MB7548E3A22BA52954843F1BC4AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548E3A22BA52954843F1BC4AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 2/11/26 3:58 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 11 February 2026 14:26
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Nicolin Chen <nicolinc@nvidia.com>; Nathan
>> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
>> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
>> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
>> Subject: Re: [PATCH v5 5/5] hw/arm/smmuv3-accel: Read and propagate host
>> vIOMMU events
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 2/11/26 9:34 AM, Shameer Kolothum wrote:
>>> Install an event handler on the vEVENTQ fd to read and propagate host
>>> generated vIOMMU events to the guest.
>>>
>>> The handler runs in QEMU's main loop, using a non-blocking fd registered
>>> via qemu_set_fd_handler().
>>>
>>> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 62
>> +++++++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/smmuv3-accel.h |  2 ++
>>>  2 files changed, 64 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>>> index d92fcb1a89..0d5dcef941 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -390,6 +390,48 @@ bool
>> smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice
>> *sdev,
>>>                     sizeof(Cmd), &entry_num, cmd, errp);
>>>  }
>>>
>>> +static void smmuv3_accel_event_read(void *opaque)
>>> +{
>>> +    SMMUv3State *s = opaque;
>>> +    SMMUv3AccelState *accel = s->s_accel;
>>> +    struct {
>>> +        struct iommufd_vevent_header hdr;
>>> +        struct iommu_vevent_arm_smmuv3 vevent;
>>> +    } buf;
>>> +    uint32_t last_seq = accel->last_event_seq;
>>> +    ssize_t bytes;
>>> +
>>> +    bytes = read(accel->veventq->veventq_fd, &buf, sizeof(buf));
>>> +    if (bytes <= 0) {
>>> +        if (errno == EAGAIN || errno == EINTR) {
>>> +            return;
>>> +        }
>>> +        error_report_once("vEVENTQ: read failed (%m)");
>>> +        return;
>>> +    }
>>> +
>>> +    if (bytes == sizeof(buf.hdr) &&
>>> +        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
>>> +        error_report_once("vEVENTQ has lost events");
>> in case in the future we end up with several vEVENTQs, it may be
>> relevant to log the queue id/type
>>
>> After reading the linux uapi again, this seems to record a queue
>> overflow. I would replace the
>>
>> "vEVENTQ has lost events" trace by "queue <type> <id> has overflowed". This
>> would allow differentiation with the case below.
> Ok. Make sense. <id> is also useful with multiple SMMUv3 instances.
>
>>> +        accel->event_start = false;
>>> +        return;
>>> +    }
>>> +    if (bytes < sizeof(buf)) {
>>> +        error_report_once("vEVENTQ: incomplete read (%zd/%zd bytes)",
>>> +                          bytes, sizeof(buf));
>>> +        return;
>>> +    }
>>> +
>>> +    /* Check sequence in hdr for lost events if any */
>>> +    if (accel->event_start && (buf.hdr.sequence - last_seq != 1)) {
>> wonder if we need to handle any hypothetical wrap-up situation?
> This should not be required. The sequence is __u32 and the delta
>  is computed using unsigned arithmetic, so wrap-around is handled
> naturally.
Ah that's right.

With the 1st comment above taken into account, feel free to add my 

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
>
> Thanks,
> Shameer


