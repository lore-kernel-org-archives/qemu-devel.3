Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9ADC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUcp-0002YG-UP; Mon, 10 Feb 2025 09:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUci-0002Ub-ST
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:18:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thUcf-00068A-8v
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 09:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739197131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mt519XCXvXRZv7C4cviRwClcbA5MJY9X+DjkeSxm6PQ=;
 b=FVHbfua70QaYRrGXMZco5J5uqYbKzuP8/g71qJsXMmvO62myu1/1+JiGEAgwfDHGyUsAMx
 0haez0Bk0zjnOkIP/qYCFPA7LJZMICAcvcHo188Y+HMlTpmN90YhwIGGjw+rF7iGuV3Hvm
 smJvcxQzOhM3cT3DFni9HP98BmxaVL0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-WuwltJwUMWWMh2WRopffJQ-1; Mon, 10 Feb 2025 09:18:48 -0500
X-MC-Unique: WuwltJwUMWWMh2WRopffJQ-1
X-Mimecast-MFC-AGG-ID: WuwltJwUMWWMh2WRopffJQ
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-468f6f2f57aso46879121cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 06:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739197128; x=1739801928;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mt519XCXvXRZv7C4cviRwClcbA5MJY9X+DjkeSxm6PQ=;
 b=TREw3SzFI3ABwFVPjFzMBnFp/IwqZBeHQH7JRXpoij9jjeJPAGwVtTUVPVuQIFIrMv
 CtphlwaD+L4I9Is4m0d/wkkC/8zFrVhdR7lo9cZaNHeoFDDeB1uJPrgIhV9g9uGiULBh
 qGhy/TIrbqHVri8XCuj84clY7RygV4AKQftR3vzMi+or5PwIvxsMF2Q3n/DcijOTrDaG
 nqTOTj5f3cE88C78lHo7oVwbYc/GgOEOIp9pHzsG65wdNdrM/yFSqZH3Y/ApnkwDk2Cf
 4LF4qDGCU8/aQ1CNLpWQLaK+ZlUC1PgkYg1WvkGEchc/q8SP/QBRiUiaVKX+e8xqMnnb
 EcXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXhGFI1M9SegzOXeXqHsuDyVUn5WkKYBLlme2t8msBu2uTLMJC0jg+2WCplgLv8aSK3QoSNnM3kwbQ@nongnu.org
X-Gm-Message-State: AOJu0YzWLdOsqu0sG8LoB0pyczNWOaH2+euv3om1GwPZATEgm0PVUHtY
 mkHtoN5KyVTVRwoPNfEXElu+3dlPAmlDyFKIuaY8o8S7mAQtdSLl1igrlt+MC7GBiGjAK0T4mhA
 RjexHCAqtadWMa8m+5pxxF7WaORcVWwMT4Edz1xDAYzFL8BuPkvEu
X-Gm-Gg: ASbGncsSN5QKaa8jGYUtuzUnuEgNXWIFapUGHFaavtB5jR6UzS+yUcZDAVQxSJ1qS25
 ZrnPQ0ROHS+Lb+76A0ltUuuSssOnm91B0ZHJaQhneIwKZi85k6e8NUvNfI/fGvSvH2TGZ7gesaW
 hVWcUYyVsWEvfLPiAk8ciAWItXV+0KehkULb9rI0PMHnzdUAYbFKaMrfSOYxS1fvNF0/o5stqFK
 Vn4edS3/8oFEH+D+IC+6YPuH6UqywJ8Tzb/lMRt3htjgEVN8FPIMqX85ZM=
X-Received: by 2002:ac8:5895:0:b0:45d:9357:1cca with SMTP id
 d75a77b69052e-47167a156d4mr174918061cf.14.1739197127936; 
 Mon, 10 Feb 2025 06:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY/fbCwwra1vkHggPLxoK9RJTVFeyEuM7+B9qBUFisEpM61ZUcP9+Lp9cj2VRynjXGld2ebQ==
X-Received: by 2002:ac8:5895:0:b0:45d:9357:1cca with SMTP id
 d75a77b69052e-47167a156d4mr174917751cf.14.1739197127574; 
 Mon, 10 Feb 2025 06:18:47 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e44f7dcdf0sm29929926d6.39.2025.02.10.06.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 06:18:46 -0800 (PST)
Date: Mon, 10 Feb 2025 09:18:43 -0500
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jasowang@redhat.com, imammedo@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
Subject: Re: [PATCH 4/5] hw/arm/smmuv3: Move reset to exit phase
Message-ID: <Z6oKw8I3oijXMnCf@x1.local>
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <20250206142307.921070-5-eric.auger@redhat.com>
 <CAFEAcA_LgrBRbafVQ0vLGPd8xG=wsLjWnKTJ2JSEREYUqgRQBQ@mail.gmail.com>
 <7102d470-ac72-4c02-b8bc-20f1379a4843@redhat.com>
 <CAFEAcA-XK5GwT0b_Ff-8fYnWcDgzaE-0Ei-YqDoXv-aXFGNXUQ@mail.gmail.com>
 <Z6ZHTStx_S9ALdxt@x1.local>
 <3db2e0a7-0f38-4c6a-a9a4-d44e0c6af436@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3db2e0a7-0f38-4c6a-a9a4-d44e0c6af436@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Feb 10, 2025 at 09:35:53AM +0100, Eric Auger wrote:
> Hi Peter,

Eric,

> 
> 
> On 2/7/25 6:47 PM, Peter Xu wrote:
> > On Fri, Feb 07, 2025 at 04:58:39PM +0000, Peter Maydell wrote:
> >> (I wonder if we ought to suggest quiescing outstanding
> >> DMA in the enter phase? But it's probably easier to fix
> >> the iommus like this series does than try to get every
> >> dma-capable pci device to do something different.)
> > I wonder if we should provide some generic helper to register vIOMMU reset
> > callbacks, so that we'll be sure any vIOMMU model impl that will register
> > at exit() phase only, and do nothing during the initial two phases.  Then
> > we can put some rich comment on that helper on why.
> As discussed with Cédric, I think it shall think about having eventually
> a base class for vIOMMU. Maybe this is something we can handle
> afterwards though.

Yes agreed.

> >
> > Looks like it means the qemu reset model in the future can be a combination
> > of device tree (which resets depth-first) and the three phases model.  We
> > will start to use different approach to solve different problems.
> >
> > Maybe after we settle our mind, we should update the reset document,
> > e.g. for device emulation developers, we need to be clear on where to
> > quiesce the DMAs, and it must not happen at exit().  Both all devices and
> > all iommu impls need to follow the rules to make it work like the plan.
> The 3 phase documentation already states that you shouldn't do anything
> in enter phase that can have side-effect on other devices. However I
> agree we can add another example besides the qemu_irq line one.

The document will be relevant to two sides of things (so far not relevant
to enter() phase, but more on what we should put into the last two phases
either for vIOMMU impl or a PCIe device impl), that I commented in the
other reply to Peter.  I am not sure whether we need such fine granule
document, but in all cases I agree this can definitely be done later. :)

Thanks!

-- 
Peter Xu


