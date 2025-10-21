Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CC7CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 15:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEMB-0007x0-DP; Tue, 21 Oct 2025 11:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBELu-0007su-Fa
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vBELr-0004Z5-8B
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761060760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPRKWRhRHijNSiAskU+jsWwZTOkqWThsY+fcSLbgjn4=;
 b=ILwzuDQlfjcciUWAaOjPicW0vB4Cb0zfNaagelp0Bna7SwMgY78WT9lU7gmbpCVI1PZvFj
 3eJr1mWoDell4w8fZGe7XUb/5QrgAaE5skFeSFVlhhVuumkxMqnf4Iztxki3TKuB+EAJJn
 pYhAJvsow6Taj6eLSmikFJkLHQ3ejvk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jVvr14ofP8qBl5lHhtnJEg-1; Tue, 21 Oct 2025 11:32:39 -0400
X-MC-Unique: jVvr14ofP8qBl5lHhtnJEg-1
X-Mimecast-MFC-AGG-ID: jVvr14ofP8qBl5lHhtnJEg_1761060758
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4710d174c31so57842775e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761060758; x=1761665558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPRKWRhRHijNSiAskU+jsWwZTOkqWThsY+fcSLbgjn4=;
 b=nDYZ/J1nrxJm9yO8eIXk+YWie4tC/5B1c2/8bxrxP6sdT4CbtWpZ5kF+GGU1qvki9u
 fvtPJgk6dcSLZ0+zpDrFRt1GzYOiWICb1mnAkGta1FFYz6VOoLHe/PwPRXesXfN4NJPl
 R9I5vQPlePFi2xzNUgwAdxZMAZSgRc5DMdXo+7nV+e3JmkT/z5Wapddg2rfOH8/JDtIL
 lPhLSW0E9cjO/DDbj9UHCIS3QqGGqCkPO+o9sEgEfn0DGm/DhBsImB977BP/8GiDZCYF
 O2SIu7soMdidm68fmwNtjRluASMHifGwx8MeohlheWeCmjT0c8sfOTGfrtPItVsKhU4t
 74sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMNWy14Q/WptU72hLS2kAGgZBI1/2/PYa6JJkOxeQa8eZbMWipiIr2DBYVkL149bR1dyxx+mw4j8Kj@nongnu.org
X-Gm-Message-State: AOJu0Yx3iWEmuyI4e+2UlWz5jZjkxNvZg5qTaUrzfqBEo34ODG2Udgqh
 G6XyZzJBjR34rDAP6/JhFg0w0TtT1yBhZRk1zIrkg8Z+Xa/QwBT43shuTpziyl7o+V3fRZHm49/
 Ig9cXzhBtgpt94lrkP8CdmrhdHxR8rZAq0bh2EBqxR9IOlyerCvfklGqX
X-Gm-Gg: ASbGncsLsD0fZZfGboe/DhvgVrqNIaaafRD9ZX9qH6bSY+cVlR78fR4/ZyFqDYT/JNS
 yu7ytTxJ2N27NXXE3WJI5Ym7z0LkpHqD9KHVYk+nSGqxpC3q5nKNN72zmO8iLhC98EgbSMuR4ng
 BRSx/iSX84g901stlkevluUiVCisAWFcICnOgAHV+6xVKM9IjQcKlW+xtA7rN6aSe0E5g+U2KUA
 A1H0/mkj5HIS7eTOuSyfHqrCyEqqES81Ulm8gU8v1HJNzNfyfJPgN/CAHOoTdoln3CIZ2yUdCvh
 t8eGGSVw6Qr0AAS+cImzIihUFKsQ4VstqJZXsMS5z82NF0+TdsriO0XrB6yguoVPoIvEkATi69J
 T2nEZ
X-Received: by 2002:a05:600c:548c:b0:46e:45ff:5bdb with SMTP id
 5b1f17b1804b1-4711787060fmr136309945e9.8.1761060758174; 
 Tue, 21 Oct 2025 08:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLE2tbk2ZakuGbJW7wtGLtfeNm8YbsC4f4yXz/iRHITp2EYi80UEzql2V4ZpuPLNK9CTj2rg==
X-Received: by 2002:a05:600c:548c:b0:46e:45ff:5bdb with SMTP id
 5b1f17b1804b1-4711787060fmr136309515e9.8.1761060757656; 
 Tue, 21 Oct 2025 08:32:37 -0700 (PDT)
Received: from [192.168.43.95] ([78.245.103.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711c487dfesm283338985e9.17.2025.10.21.08.32.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 08:32:36 -0700 (PDT)
Message-ID: <1db52047-9d74-435d-87fb-10fac8b5be73@redhat.com>
Date: Tue, 21 Oct 2025 17:32:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information
 function 0 returned value
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
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
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-16-skolothumtho@nvidia.com>
 <20251001135902.00004abd@huawei.com>
 <CH3PR12MB75487EF7D053F7DBF65D75C8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB75487EF7D053F7DBF65D75C8ABE7A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/2/25 9:39 AM, Shameer Kolothum wrote:
>
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: 01 October 2025 13:59
>> To: Shameer Kolothum <skolothumtho@nvidia.com>
>> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
>> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
>> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
>> zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 15/27] acpi/gpex: Fix PCI Express Slot Information
>> function 0 returned value
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, 29 Sep 2025 14:36:31 +0100
>> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>>
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> At the moment we do not support other function than function 0. So
>> according
>>> to ACPI spec "_DSM (Device Specific Method)" description, bit 0 should
>> rather
>>> be 0, meaning no other function is supported than function 0.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Given description, why not yank this to the front and get it upstreamed
>> quicker.
I agree with Jonathan, Can be sent in a prerequisite patch/series with
potential updates in the ACPI table tests.

Thanks

Eric
>> Also, a fixes tag seems appropriate?
>>
>> Doesn't this show up in some of the tables tests?
> Possibly. I will double check that.
>
>> Please include relevant chunk of AML as well as qemu AML generation code
>> isn't
>> exactly easy to check against the spec.  Probably +CC at least Michael Tsrikin
>> on next version of this patch.
> Ok.
>
> Thanks,
> Shameer
>
>  
>> J
>>
>>> ---
>>>  hw/pci-host/gpex-acpi.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>>> index 952a0ace19..4587baeb78 100644
>>> --- a/hw/pci-host/gpex-acpi.c
>>> +++ b/hw/pci-host/gpex-acpi.c
>>> @@ -64,7 +64,7 @@ static Aml *build_pci_host_bridge_dsm_method(void)
>>>      UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
>>>      ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>>>      ifctx1 = aml_if(aml_equal(aml_arg(2), aml_int(0)));
>>> -    uint8_t byte_list[1] = {1};
>>> +    uint8_t byte_list[1] = {0};
>>>      buf = aml_buffer(1, byte_list);
>>>      aml_append(ifctx1, aml_return(buf));
>>>      aml_append(ifctx, ifctx1);


