Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05A8EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXy8-0001TZ-OA; Thu, 12 Feb 2026 09:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqXy2-0001DD-Ip
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:46:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vqXxk-0007ad-3f
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/R6tb149s2l7xGGa+oOLe18sITBXQfTR4Ufb7OLpAFk=;
 b=HyocsixJrQ+R9KSzhu/f/+9626su+hZaxVPXVPuPu5234P4HikAlI4TYXJy8DN2aht+/uo
 MCKkAKZSxL5V6c8DSqvaqpbqfNL/d79Sc9SEfTMKPzrxoN5V9AahSaMZGcg3fUhqBXqChL
 dU7AiY0FB5ByKGl4sHqK36XTEhgWegw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-EoYZ8zvvMNe6gjEdWxc-kA-1; Thu, 12 Feb 2026 09:46:34 -0500
X-MC-Unique: EoYZ8zvvMNe6gjEdWxc-kA-1
X-Mimecast-MFC-AGG-ID: EoYZ8zvvMNe6gjEdWxc-kA_1770907593
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836abfc742so4302175e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907593; x=1771512393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/R6tb149s2l7xGGa+oOLe18sITBXQfTR4Ufb7OLpAFk=;
 b=vxWkrFKSL9W8cv6xQR70ahCySrrEKqrWtOPPCfxUvLlwAzBtBeXLNFiJngkkhm8FLj
 wXXBWWMSMQShI2uxCspcFNIZDx3IciWOm9i7jngZmeCLFafUeaUUv1YT/IdrwuPt7sVZ
 0/O302vHHbb37knGoPuWvg2y7/yLf9zR/PCaFgBTfLHDVPEjZWVBF+MK3LGREhL7roBE
 URkanennEyAv6LovNM6jBBP/tgkOjuFcH9NlVrw3UxRi5dcVd3jbPAgrM08eJairU41D
 dd1r7HKB2AczRyiLnxBakGQ4UbPUeSl9OM9B65On38R03vLOkGTbA4h1kT3Gaxqj65I/
 76Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWynP45NwMQ7mK5MEsaUlPntvONQ5ie156OuhPVMg/0M9yR8LZzWP+ytz0IfIqgesdNbMdNz6kVxXis@nongnu.org
X-Gm-Message-State: AOJu0YxTFsFPgiQUylfInYG5JWGXImQwmSeC4eXtjw3Szqzjb3xgZNfi
 BNRY4hMBsg3UKbNEBeP3Q6BP7iC48W+y12rbpqybTkjRjY9XGKIBMZnHzhiXyo7FuncnodlgFuV
 S9ZjFdAXJghA1zvKh6zp5mfga0HC9c7LUltT0DBbKu3XhiNGrASudEcJS
X-Gm-Gg: AZuq6aJyBedQEs85QS7qUNV+xVtjLFNGqcwZ2opPFzcQIWF03SKrl/+iQ9ApBgKQSEg
 /nVJ5bA6ry+HVTHW40axjT2qTq6/90Hq8TFxkDNQfplsszSp/0m5ecSINBC7FV29iQef8ygfFAN
 cgiIks3oy1COZ3fL81TLs69lIuMbDFrFxdGdeCe/z1VHkNH03ZiJAqODeyxlqRUJVm4ulcK/VJy
 ea0X+OfQCy87Be1sVqwBFEJoKmgeZzHF584tHd06mC+NbVddz/ztSUkyMH8AL/uajcTCpAyrQam
 ixhjrqm+Ju2BzStwK1ha80yZ8UKppGqN4eGea2tCA0VDSRjdx6MbcWimYsd9xHpNK22HS5+qN/m
 YTonK3vd6ab/U8i6r5hi+EBnsN/xX9m3bQUp23MtOcxcVAJifzDZJWjHQp/rOKU+OBIVGWA==
X-Received: by 2002:a05:600c:348f:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-483656c571fmr48741615e9.13.1770907592840; 
 Thu, 12 Feb 2026 06:46:32 -0800 (PST)
X-Received: by 2002:a05:600c:348f:b0:480:1dc6:2686 with SMTP id
 5b1f17b1804b1-483656c571fmr48741155e9.13.1770907592352; 
 Thu, 12 Feb 2026 06:46:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e5c635sm13350787f8f.37.2026.02.12.06.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 06:46:31 -0800 (PST)
Message-ID: <7ddafa8d-5510-4202-827e-9c0dc186c5e2@redhat.com>
Date: Thu, 12 Feb 2026 15:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/24] hw/arm/smmuv3-accel: Introduce CMDQV ops
 interface
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-6-skolothumtho@nvidia.com>
 <aYo4n4N3dW1OLzTk@Asurada-Nvidia>
 <CH3PR12MB75483C2BA4EDC24CA0F78A4CAB62A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYtozzSV4UYOjJcK@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aYtozzSV4UYOjJcK@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 2/10/26 6:20 PM, Nicolin Chen wrote:
> On Tue, Feb 10, 2026 at 12:46:01AM -0800, Shameer Kolothum Thodi wrote:
>>> On Fri, Feb 06, 2026 at 02:48:04PM +0000, Shameer Kolothum wrote:
>>>> CMDQ-Virtualization (CMDQV) is a hardware extension to SMMUv3 that
>>> enables
>>>> virtualization of multiple command queues (VCMDQs).
>>> Let's mention "NVIDIA", noting it's a non-standard extension.
>> The idea of this ops based callback is to make it more generic and not
>> NVIDIA specific to start with. This leaves room in case ARM introduces
>> a standardised version of something similar in the future, or if another
>> vendor provides a similar extension.
> That might be a different naming which we have no idea about yet :-/
>
>>>> +    void (*reset)(SMMUv3State *s);
>>>> +} SMMUv3AccelCmdqvOps;
>>> Overall, an ops structure feels unnecessary to me. Maybe init and
>>> reset are somewhat plausible. But nobody else would reuse this ops
>>> structure that is exclusive to Tegra241CMDQV?
>> That's true for now, as there is only one implementation today. If this
>> abstraction feels over engineered at this stage, we can simplify or defer
>> it (and fall back to calling the tegra241-specific functions directly, as in
>> the RFC) and revisit once there is a clearer need.
>>
>> I'm open to suggestions, and let's wait to hear from others as well.
> Well, I'll vote for adding that when someday there is second CMDQV.
> There are only a couple of CMDQ-V functions required to export for
> SMMUv3 code to call at this moment, which isn't so bad.
>
> Having and naming a structure exclusively for NVIDIA CMDQ-V doesn't
> make a lot of sense to me. And if we really want an abstraction ops
> maybe "secondary_cmdq" in the kernel driver could be a good choice?
As mentionned earlier mu syggestion was mainly to address specialization
with known implementations: accel smmu with vcmdq versus without. And i
think we already have some implementation override in that matter.

Eric
>
> Nicolin
>


