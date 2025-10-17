Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11EBCCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 14:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9l5R-0002Hw-O6; Fri, 17 Oct 2025 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9l5O-0002Gs-4d
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:05:38 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1v9l5G-0004qn-DD
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 10:05:37 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-362e291924aso15256051fa.1
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 07:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760709919; x=1761314719; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4XsV3sKmq567MOeW9w6wMFQYDTPVNp1B+2NNjt9g2uU=;
 b=Fw32CvgXotSv1oEx/fE5aFt0ldw3gRFJN/XRZD3uhsozDUNzQsS5JOqs7dU0VzZPeb
 E95CwEctDJYXBd8uJMI17R2ORaPvzGAkvhpEbC3gKfzDoG70WfQdKBauX6KT5dlhNm04
 DDaVzwDvA9mkMg4rjevWV1n9uJl9x8gB2uY1frunD+HB/lAqLRbHvD61C+TAdR+TtrBP
 6UR52X1YxQc0hbQpkyCmtMMKZh/9h9z8fI3X4le3O1w/xIWSyna3vSBCh6hAbOMdqiss
 aoadSHRYq8TFaiQ387ajSEv29tyLD5qR5MT7wo+uKe33s04tlUMSIzv2QeqWnEcug3DH
 PhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709919; x=1761314719;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XsV3sKmq567MOeW9w6wMFQYDTPVNp1B+2NNjt9g2uU=;
 b=NQ8gN0ph2acqL9RLAEBBh8eH4IlAjMTj+eQzIjGVVU4DLF5+1pguOM3QYJhy6vaz7h
 GaDLG7mcKtk88vCyQj8g1IBX6Vtg4if//nL6Dmxg4hfwM664x41JB3lQrlCdbn0jaAxK
 NgB7bnPogtwINmJa1ApzcCSRIvjJHEya+no7fuogqkS43Ju/PYtjUIo2b1q50jH4mcw5
 BiDSIh1Re8elMObNUaylYuyz58sA3qghKkABu1jlbmLGCD2lu3Or/DsArAGyqL/IBHBs
 wJbGC3XdOABOcHsp0uLTzJrQB1BbOw1Gh7hf83SvQmx/HsjiW2mUHvVeJXC65S8KwVIR
 dA0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDiHSIcydOTqsvv8DR+a9DLzcahSVznPxa/umcjp14cY6+xp74AWSx6V4FE8ZCTANR3HhcXltV/+e0@nongnu.org
X-Gm-Message-State: AOJu0YyZFLyANcuFN7z/uU3xo7aEY1BDWkyH0DZdbC1UznOaspCnWb/d
 Csw7wf9LnuwbGPkEkf9HFuAok6dIaex1H5dANUnOPgYAzRdmUhTIEqbckkdo/hWhErMMQ7qqeOf
 Tl3elCCKQD6urwJi1JQaKMkr3/DH4UbRdd6QODkwAuQ==
X-Gm-Gg: ASbGncubgFfPOcpOjyPzXLF0gIuWUMJywrG4dcfoP8jZseJsb+a8pkKW24jveDYs8Qq
 JagzurVqf1NEPawzxPRH+aiGQ8XEmrzxJBjWI/peGBGaP2iFMVKp0gktm4AG4eYQdfW4kwn48Op
 YeUjhwCgNwf90vHGoUtG0iJ4rWwkVMjwpyEXozxs8+4ADBfh5sIR5BnutV9ZEy+jeB5jtdcCFGB
 EhH83QOU9m1LQuF8ZU/Rvmyc1RoQJ3i8VZkHJAcDXrYHjYPQVKC2f07eiZNubpXYSMpUDa3qT9G
 yAC9Jg==
X-Google-Smtp-Source: AGHT+IGtdZZBF6Qavohm0HFa/zrvh9uWEWPeZNaXBsZLLYa64bOTN8A4qzuH0j2MKhu9F0CHCONcn3J3YDLe0wdvvM8=
X-Received: by 2002:a05:651c:982:b0:36d:86b8:c57d with SMTP id
 38308e7fff4ca-3779772ac96mr14928921fa.1.1760709918693; Fri, 17 Oct 2025
 07:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-22-skolothumtho@nvidia.com>
 <CABQgh9EJMuVNHoi3iCW73mrC=y07djR8QoPAn8wN6+rL30iadw@mail.gmail.com>
 <CH3PR12MB75481CD97D4F253489F38B38ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75481CD97D4F253489F38B38ABF6A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 17 Oct 2025 22:05:07 +0800
X-Gm-Features: AS18NWATsy0NpobANvbYh62gaAcR1gHpHf02fkBWHan0G8ItegFQCtKsiR9MEa8
Message-ID: <CABQgh9F7=DQ09ment0WDa-T_QTPb2+8WDqou6N+QvfbMq3VN8Q@mail.gmail.com>
Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to specify
 RIL support
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>, 
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen <nathanc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, 
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, 
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 17 Oct 2025 at 17:40, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: 17 October 2025 09:49
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> > berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> > shameerkolothum@gmail.com
> > Subject: Re: [PATCH v4 21/27] hw/arm/smmuv3-accel: Add a property to
> > specify RIL support
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 29 Sept 2025 at 21:40, Shameer Kolothum
> > <skolothumtho@nvidia.com> wrote:
> > >
> > > Currently QEMU SMMUv3 has RIL support by default. But if accelerated
> > > mode is enabled, RIL has to be compatible with host SMMUv3 support.
> > >
> > > Add a property so that the user can specify this.
> > >
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> >
> > If ril=off is not specified, the guest kernel will not boot up, is this expected?
> >
> > Fail with log:
> > qemu-system-aarch64: -device
> > vfio-pci,host=0000:75:00.1,bus=pcie.0,iommufd=iommufd0:
> >  vfio 0000:75:00.1: Failed to set vIOMMU: Host SUMMUv3 differs in Range
> > Invalidation support
>
> It will, if the host SMMUv3 doesn't have RIL. Please check that.

Yes, the host SMMUv3 doesn't have RIL in my case.

> This is because when a device is attached to vSMMU , a compatibility check
> is performed to ensure that the SMUUv3 features visible to guest are compatible
> with host SMMUv3 it is tied to. By default, QEMU SMMUV3 reports RIL to Guest.

OK, got it, using ioctl to get host info and check the compatibility.
>
> The "ril" option is provided so that user can specify this in case incompatibility.

OK, Thanks

