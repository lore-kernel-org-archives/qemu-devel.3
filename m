Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FC4EC1423
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxN34-0008Qs-KS; Tue, 03 Mar 2026 05:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxN32-0008Q6-At
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:32:16 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vxN30-0001d9-OP
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 05:32:16 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-64c9c8f8783so5710440d50.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 02:32:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772533933; cv=none;
 d=google.com; s=arc-20240605;
 b=ZEHNq6Ht+ggpkb/ZMXf0wML+uVkdlBefX4aXmdGy+/zh2Sqqq0WUuOxYDbrQXQNbzU
 L5JYmU5pseweWFATdiAVQhilM5aLX0zYVTgmL4UFM03oyJ3iXL3DYxktRysmLYSPUheR
 L4mXcZUlNjMIxGzjNc8zpjungQkjM6k5Lt5FFXkD1Q+ci9BdsF3hMtrVAckfLzT+R+gV
 bGOURZ/mnKGfQSP/2cRwX1mXXwaBM8IvUj2paudRalOhFXR62bjXwhYZrCCv2ymmy5dZ
 hIIKELu+mcpsS1nOEwugt9KYfyKy6ESjplCvKejiPLblG0LHPqYkexOPweEpYe2+894M
 lDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4xpMyo2OZSHduvV8IMeijq+cNP1Xb2RRq64vgwLYeYg=;
 fh=8iJ3JgyUyIYNrz8llCeomc0WnXbXu+z8jE+F5B3qzJI=;
 b=eQ67JxgfkpAjZwOsiLjYc/lPxZUK8TijXQQXul1SMAxc+H+bVgnwtPPxwAAmAvXirP
 Jt7EH/o9Xxp40LdisTqf7n5kWxuHT9NMzLo47001bZuJG4W48it5A3uRyMH63JsKbIpM
 1/uCPmDE1H1zuGMtPhKGIsGFrJv3kugzHPTpYyDCjK0HVBbjpRPM+hJVfOj5fJvjoaDA
 Bbxkj7sDMxemCCvPzBuzxLD+9bCp8U1yfPKek9YU8x2LnX213A7A2oYowDV+ulzXR0Nb
 JEVgsPruUutw+decyzLIq4+XLqcA+4MNn1Lj5exZWqyYf4XbjLLUpp3s/8v7rJDpgxHa
 Lcnw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772533933; x=1773138733; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4xpMyo2OZSHduvV8IMeijq+cNP1Xb2RRq64vgwLYeYg=;
 b=WCK/he7ic1VYyLbblVP4ZAWHuQoAtjqY5FzBX5VYrWs8a9w9b5EhvN03mgIKMXwLX3
 HHWY2iXem7A1vBGo0P/p7htIQmrK9Ytl7K/8preECWulFFDJ2k2asv/ZULJNHcoT4/+L
 KVoK0BAzCQFuIAzApsVm/aCKRiV5lt0GNsSo1VhNPvgtAWZsTPyFxJPa5AFGKU9Ixt8D
 +tnVnTNpRTdDRVkQN6yt2kGHafHBz6iijUBxMI5B56RvQCJpA58t/YmRD1I8Y/vxn5qE
 wEUqommJrFsiUSoBRoGm3Fo0D/sT5eCRhcDx2qUb2f9Ky+i4j8tRoauaHcAyupwflnbh
 aNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772533933; x=1773138733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xpMyo2OZSHduvV8IMeijq+cNP1Xb2RRq64vgwLYeYg=;
 b=GP4uUR2Sm5RjEnxHfUN2dWkwaXIyziPgAFnrV05vY/eg1PUCyI2sNOTb3BiHTdNpe2
 pH/qij2SG6hIhLpeE+WDsobcvj7k2D/2XAnLHuszeXSI+PNssKw+7imwBaXr3nlcbK/0
 CZpD0uoQBDhd/R2+YOQVZ5WKsrO+l1YBlcWqEXRF/6PcAZd6pl9PkBnPkjIIvLba1ffZ
 tJ/T2fGp5qY+7sj2GI6xKG1MRul1E2XwxbKZXS/0pbEWPZVpaHN9I0+TMq6U+1qg0lC8
 ac84vcj69LjYs+NKMxIkeBO9PPzvWpTJxjewRzZZ+QukFheWx/SPy5Id7mfHdWv/PBEg
 quLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdMwvVKG3BXyfR6v++u33knYvyVOWAhZYky/UtUttEc6kjfqwxg+EY7TNp5wN90PtK41Gi2BQhYxZM@nongnu.org
X-Gm-Message-State: AOJu0YwGGIlGy0rc3VXuOOiri4QftUmeCZWB8yMQktUPdid0y/p4nQVn
 DaYH9l80gGJGbMWHvjzmpzC0gjQYksiVsgFtbkZxKFoRZXo2UtHw1YKYbZT6PP103zenJr4dXPH
 9edeBkFko9aUXyN3P/X1XRIeJQtdmPwSQSlGJSduK3w==
X-Gm-Gg: ATEYQzx1uOIGQToIo5xKbVZgTP109Xlcu4NGI8KCV90Vkv9xP3CNlijLwUGvJjd6rSM
 YSaduLLc4Fqb1cGbH5LfIzqCvlY0jNH7Ca1wDrmbzbXLhNTei/U/WYvtZxH/MWptG5p9iXYhYmc
 1GZMJ+iCm0CnnYTaov0clHn/dWnh1AViHcGPrLJAvh3ATAYwLH/e+ukhhB09aU3NRtNggAYi9gC
 CgWPxN94cre7Vtq/eWiW4bDsDlRDnKfYKWoRZwVuVxlClgqe/OdZL4laWC3t8oiKsGqYg1zC4DK
 EIF3MFs9vUAQtkOg33J8TVa6d5JwKKY4mucAAHmdPgUNxqi+vra0k/awZfMgVpfvT04=
X-Received: by 2002:a05:690e:1510:b0:649:e9f1:bb9d with SMTP id
 956f58d0204a3-64cedcf1569mr963659d50.36.1772533933509; Tue, 03 Mar 2026
 02:32:13 -0800 (PST)
MIME-Version: 1.0
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <CH3PR12MB7548985B33D65D626DFD840BAB7FA@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548985B33D65D626DFD840BAB7FA@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Mar 2026 10:32:01 +0000
X-Gm-Features: AaiRm50cFYSLpLtxOTOiEI4FK-02CfPFKipUSM641kCisiJYAxAWFdtEbyF2vuM
Message-ID: <CAFEAcA8t5ZL_8YgpnWN+C8HvX0auXEsyGfXCqSRtaR=wXEMsCA@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Nicolin Chen <nicolinc@nvidia.com>, 
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 Krishnakant Jaju <kjaju@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 3 Mar 2026 at 08:22, Shameer Kolothum Thodi
<skolothumtho@nvidia.com> wrote:
>
>
> Hi Peter,
>
> > -----Original Message-----
> > From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> > Sent: 26 February 2026 08:45
> > To: qemu-arm@nongnu.org; qemu-devel@nongnu.org
> > Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> > <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> > <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> > zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; philmd@linaro.org;
> > Krishnakant Jaju <kjaju@nvidia.com>; Shameer Kolothum Thodi
> > <skolothumtho@nvidia.com>
> > Subject: [PATCH v8 0/5] vEVENTQ support for accelerated SMMUv3 devices
> >
> > Hi,
> >
> > Changes from v7:
> >  https://lore.kernel.org/qemu-devel/20260219090103.33697-1-
> > skolothumtho@nvidia.com/
> >
> >  -Picked up R-by/T-by tags. Thanks!
> >  -No code changes. Commit messages updated to improve descriptions
> >  (Patch #3)
> >
> > I think this is now ready for 11.0. Please consider.
>
> Just a gentle ping on this.
>
> If there are no further comments, please consider this for 11.0.



Applied to target-arm.next, thanks.

-- PMM

