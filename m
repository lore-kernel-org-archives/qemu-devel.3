Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CE3C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twiUK-0005Gm-UL; Mon, 24 Mar 2025 10:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twiU4-0005E9-Te
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:09:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1twiU0-0005Z7-OH
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742825331;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBJs7Cr9ngAy77vwEXpqh1Y3gpeWITiXtV2Zs3BvqwU=;
 b=Q3dE0awPJ3UPT/UOCqbL8RkKEjiJfRhvRwEAMZB+n1/xbcVMOtm6bCWZTrit2+j+mdXP4Q
 WoTix5S1MzJ7PPArzLAMxCDv8c0c30BRQCWIfbKXiMPzOBY12w2c59U5nUWherok5wthHj
 kFp9T9f6d+ICnK0juaRqB0gS2KB81cc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-sJJEnxLdORK6BqDHBEdxiQ-1; Mon, 24 Mar 2025 10:08:49 -0400
X-MC-Unique: sJJEnxLdORK6BqDHBEdxiQ-1
X-Mimecast-MFC-AGG-ID: sJJEnxLdORK6BqDHBEdxiQ_1742825329
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d51bd9b41so26910695e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 07:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742825329; x=1743430129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MBJs7Cr9ngAy77vwEXpqh1Y3gpeWITiXtV2Zs3BvqwU=;
 b=YGzh3sBkuPGJhx20oVPD3OEcCXhImYhWvt9kHAU0bhp/Vna3GNB62x/JD719Vo3dxt
 14x6OVdTPdNIO6301nTgZh3mvkRwpo23IxMZ7X1syGtm5QNPQB5xMju/pzH6s7KTjJTw
 tlCmfCKT1jDuTav51/VAVxX1p10B506MAATbw56taox77wue0FcDn1hlvvi/2RMpLYnP
 s/p6sMUg6cTABXMoeSlDSfaiWbQBVoYLMfTPiZ9GnIIEpJfU5e8zKbBiISP24rvSKWcV
 rMw8JAnOjPMdBODENeoM0BYxALeZAbg2o8OoRTI+Qw2+8F07qjSD/h5BVFKUY/h99VPS
 gUPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaOu+dwzMGr8LmtDzXzwfCt3z/bSh6xZx8zWFoISoDJLnoq+vuEChsYZX7tv2ktuSg1tW1ZIupXa5I@nongnu.org
X-Gm-Message-State: AOJu0YyOzfA8ehmAqr4OJjqv4FtLHBxi9zjWmkljtQzO1KQOonEgXZX+
 QE5P0AHAQxBCcmm8h+cEeo//Nx9LMhqVdBQ6KjZWP2sPoyH7Q07wDYuQB08hxhS3sa5clnJoRr2
 VLdjwsW0rmrxoSOXv6p+WgA55JcL1MWvigRmxBeES022PMHP/PDt4
X-Gm-Gg: ASbGncs86Vf/22fWJKDFn1us+3N74mwWz9dRIc8ayLGwLfr/y6Wf5ChPiEJIp1dAgXx
 VqVGCEdTu168wnMlcgKvdVzl6mfwiltZAO5yKqs02L8YnLydKNQkPewh2TUH89XimG4BflsRH5l
 XHipFRd2SSyecFDmOSaZ7k/7UxPnf3EC1Kx5ePNgZPigQNOqQ3pSullSf9wAHh18JTPcvtkSsgo
 a7U80PB9OWVtH3N6gBEyG/t63pXibLugVrb4EVJ0sWe6XatUV84dAkJLbLtVfSYAXNJezZlixp1
 QCFaeU0c0O899rQjQJjUaFdX3wSNuDmRDbTQpEo3eqM8DvcVLJGlQvgtvKLlcFs=
X-Received: by 2002:a05:600c:83cf:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43d509ec3famr146578675e9.10.1742825328704; 
 Mon, 24 Mar 2025 07:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi8qY97HbBlvMrWAJruSziuqJW2Cl1ImnF5APBnZUi06YFHNLxs6Tcdqiswnq6A4+ZplVZeQ==
X-Received: by 2002:a05:600c:83cf:b0:43d:22d9:4b8e with SMTP id
 5b1f17b1804b1-43d509ec3famr146578065e9.10.1742825328196; 
 Mon, 24 Mar 2025 07:08:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9a3b83sm11271536f8f.33.2025.03.24.07.08.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 07:08:47 -0700 (PDT)
Message-ID: <efbec6a4-e37a-4fa1-ad4a-7294521ee947@redhat.com>
Date: Mon, 24 Mar 2025 15:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/20] hw/arm/smmuv3-accel: Add initial
 infrastructure for smmuv3-accel device
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-4-shameerali.kolothum.thodi@huawei.com>
 <d75feb00-72d3-4d79-a7ac-2548eadb6a77@redhat.com>
 <Z9hh8MIAQNQcvNlG@Asurada-Nvidia>
 <71b73212-3d8f-4c9d-93a4-bf07c0f169e3@redhat.com>
 <Z9hzmzHfWw18OyGO@Asurada-Nvidia> <20250317192453.GR9311@nvidia.com>
 <Z9iDxSvZVsgtasGj@Asurada-Nvidia>
 <6cb391a4-d150-4692-b62e-a509448a1034@redhat.com>
 <20250319003135.GH9311@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250319003135.GH9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jason,

On 3/19/25 1:31 AM, Jason Gunthorpe wrote:
> On Tue, Mar 18, 2025 at 07:31:36PM +0100, Eric Auger wrote:
>> Nevertheless I don't think anything prevents the acceleration granted
>> device from also working with virtio/vhost devices for instance unless
>> you unplug the existing infra.
> If the accel mode is using something like vcmdq then it is not
> possible to work since the invalidations won't even be trapped.

I acknowledged I was more focused on the case without vcmdq which was
addressed in the past and now I better see the problem.

>
> Even in the case where we trap the invalidations it sure is
> complicated.. invalidation is done by ASID which is not obviously
> related to any specific device. An ASID could be hidden inside a CD
> table that is being HW accessed and also inside a CD table that is SW
> accessed. The VMM has no way to know what is going on so you'd end up
> forced to replicate all the ASID invalidations. :\
Nevertheless I think we shall also support the case without vcmdq
(currently supported in this series). And this one looks more compatible
with emulated devices althout less optimized.

>
> It just doesn't seem worthwhile to try to make it all work.
>
> I'd suggest arranging to share some of the SMMUv3 emulation code,
> maybe with a library/headerfile or something, but I think it does make
> sense they would be different implementations given how completely
> different they should be.
I agree with can do our utmost to separate implementations. I more
concerned about having libvirt guessing what kind of devices it shall use.

on x86 libvirt needs to use -device intel-iommu,caching-mode=on if one
wants to protect a VFIO device. So this looks like similar to adding
accel=on on ARM.

Eric
>
> Jason
>


