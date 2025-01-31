Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA48FC02190
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduIU-0000BX-1m; Fri, 31 Jan 2025 11:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tduIN-000081-EP
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:55:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tduIL-0002mI-R2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:55:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738342503;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIfRarS1wPOBfQNP8FB1B01Y/eiHGZOK3fB01qQjEp0=;
 b=LZ3da6tcHSyPEaBrr9nO+TSZnMxpgih/lOl1TOWAiBauJi9s7OmJMFS1iGEEpDXloMUPHo
 nJVnriZrlUt1R+9+5sDr5v5J0GhLwBEqKQD/dqPvFHSkLCP4QdAKFGMJQRZX4hDdbBmthF
 OjDAVNOL/Cz6jZ77Ip4EV2by2o/QAGg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-u9oALbY0O6iuMxYn1IiNkQ-1; Fri, 31 Jan 2025 11:55:01 -0500
X-MC-Unique: u9oALbY0O6iuMxYn1IiNkQ-1
X-Mimecast-MFC-AGG-ID: u9oALbY0O6iuMxYn1IiNkQ
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7bb849aa5fbso436052685a.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738342501; x=1738947301;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NIfRarS1wPOBfQNP8FB1B01Y/eiHGZOK3fB01qQjEp0=;
 b=lGbjhNmK041Fpb/GVVoV3pqvMR75tP/9x5xe6vMasUW9OIToeIh3awy4Zjs4Drd3bu
 qEzh/Hdikqhqi80GlOqVN+87ibi9r+p7zrU4jR1ZTIC4ku7sQNdD3avZ4Lme7sNmgTJ1
 nYySWdQJzpXpSUm67vnxOr+IrHddbGk/Hjl06Av1SMWn6EWt12Kw8WF+qFBe7zqKWc5l
 nPr89XopERQ6yuxRR4cILatKM9Y97zWFyE4NWma5+ChMlq3pvRK3n0ayWcwNWoRfxrr8
 7s7NMhJr4mR5l489gSrmnpR4K7e9mU2KzBi5z2G+9uF5ZwOBkikbg/vAcyP86XnTGRvP
 GFAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU02qsH0I8WKUnRXGDuWsJK2pjn+7rTctZ6xYX4lkp2QsRdm+S16LHLjxskq8ngMwYhomotJorkl5u5@nongnu.org
X-Gm-Message-State: AOJu0YzqWI/WnuT9RFQk0MZb6klittL/2Xk8g/N660WDkntFt3kHp0JB
 2HX3Wzl5RvLQrVjXXUmalcSvaA9eVL8ScKyrQ+v0AHHlWrPxLQJ5Q9msSTTYLlFsj7wWMAdckxP
 mi3+tLYMQCr9krBxS5F0yfOo/CenTTcSaW1bxJRWm0URnoEtQ9DQ8
X-Gm-Gg: ASbGncurt71TaQO8Or9BjWfyfBNyo6aheC2LTdnmYNORrspdWHmlzYeEIMEBw4X8mEb
 lrQn9fuT9XZ7A97By5EXZEoXTWS8i9YcRariXzNczUVVgcPfEWZfP2KwQIsGnkgQrIcSCHtRAvS
 wJjWqD24JY05zcxBuoZs+LXWKELfwzrS7xUs9RJs0aSvDOOuiKGh7ymZisPiIX5qXSeCl7lHFFU
 wL2Vq6hpHxFef4uTmX+0mrSRXgALoQP9BwVF5zGjplfiQxScOnDoWt57+OtrvMI5tFzX9Ek/GWL
 QS+ngWS9Wi7Jox5IHZusoUHtqjCFFPdydOweyvlyOmZ3MgzdjDFa
X-Received: by 2002:a05:620a:371b:b0:7b6:d237:abe5 with SMTP id
 af79cd13be357-7bffcce5880mr1694512385a.20.1738342501141; 
 Fri, 31 Jan 2025 08:55:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGblRzfGn4AfzFDMtKUAptTM3/Hj1CwULqrQzBh7Ng49Emie+/8xEHk6BffezqerzitZjRb6w==
X-Received: by 2002:a05:620a:371b:b0:7b6:d237:abe5 with SMTP id
 af79cd13be357-7bffcce5880mr1694510485a.20.1738342500867; 
 Fri, 31 Jan 2025 08:55:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90d3c4sm211636985a.111.2025.01.31.08.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 08:54:59 -0800 (PST)
Message-ID: <f4e64a3a-5c1d-49f2-ac72-b84ecd353c9d@redhat.com>
Date: Fri, 31 Jan 2025 17:54:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Nicolin,


On 1/9/25 5:45 AM, Nicolin Chen wrote:
> On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi wrote:
>> And patches prior to this commit adds that support: 
>> 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for arm
>> SMMUv3")
>>
>> Nicolin is soon going to send out those for review. Or I can include
>> those in this series so that it gives a complete picture. Nicolin?
> Just found that I forgot to reply this one...sorry
>
> I asked Don/Eric to take over that vSMMU series:
> https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
> (The majority of my effort has been still on the kernel side:
>  previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
>
> Don/Eric, is there any update from your side?
To be honest we have not much progressed so far. On my end I can
dedicate some cycles now. I currently try to understand how and what
subset I can respin and which test setup can be used. I will come back
to you next week.

Eric

>
> I think it's also a good time to align with each other so we
> can take our next step in the new year :)
>
> Thanks
> Nicolin
>


