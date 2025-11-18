Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147C9CED24E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIJe-00044Y-KU; Tue, 18 Nov 2025 04:48:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vLIJd-00043x-0K
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:48:01 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vLIJb-00023R-CF
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 04:48:00 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5958931c9c7so3768791e87.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763459277; x=1764064077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aZXa5bmPdeMtAC8UpNVx/NK1W2UYHd744ERGExCRsdM=;
 b=Q0o+ovExuCRw/Vp76Tn/Jb50xyjOhO1znKlZloYJ8EjAedXqcJRGsiwO6mnudSrsL9
 0Z54KhNd4FQNTCALnO2dTZy4do8J7TkiuzSYXKonK3BP2Gm4qI2n31S7i5BKvmbgBqPC
 hm2x7oWi7Ew6pQNj1JTq84T24QK/HjrqlcF8P9ms8Ei7/OOrPj9M0RYP0aE4HRnK/1Yl
 m/VfQXPoZGZnRatTUcuSlJOrtSxB1nkPaVKpm70jDeE8x6w9eh51KvMdugiRW2PkJ2RD
 KRgR83DN6QyQk9+p6BwizmPp+UCgjFMmEXSSgnTNSlcYajnzvouocFkq08lgIW9AfgzB
 RjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763459277; x=1764064077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZXa5bmPdeMtAC8UpNVx/NK1W2UYHd744ERGExCRsdM=;
 b=Cqm3FXTxtR2AEaNTmUGa3kljU/SjGgql7Qo27c2om4G6srIHhYnQYvD2f3fr8Dp8Gt
 dPLG0vwMO2NxkVptwSFcUAdxGHjaIEdrXEKjk7ixinlDo9bto/ayXbECBNV6XPtyMk87
 45p/d2WZOZD/0Vt4azKq1TnccSPzF2ESg1BVaTnIMj7R23vQeHn9/YskZZRuD367ZqMw
 sWiRM3Ip31+aTSO+HCB/M064/+QTBVkQ8jOmaBKIJxeVMpM3sMzn1BEZlN9OTk97v/Ur
 CvRkiZE9BWfrUDWdj4GEC4PHElxA++BTBvAejL5rNt7h7ry3THTKr3t+DW0qf39Fv2q7
 IOiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU976LfQPmJT9I5Cu8BEty5NjCpn9HdJBX1K/pFOfU1bT+3W5WUdm7TrB5iHs+jDGTXhi0KkAqYRLM0@nongnu.org
X-Gm-Message-State: AOJu0YwLSakOxcT+E96FeUpYMvpwM0ksQOS41jQK8ZF9gcATtf8V2hAJ
 gOwWAhHVEhF6OgMfwhOni39tTRCDUq6j5NBBZbTUAoWgMYBH+IHsVIv2x9EiSt5L4mFuZBqouus
 4eaehn9H4hFzweHO+SgzojnSyW0BflmzXy1+qlYjsSg==
X-Gm-Gg: ASbGncstdzJ+oHbAiMf3wlWg9+RaOaBW7GnhXkqOPMTytbEXwN7/WNj9gDTwhGUHbBb
 pvMZVapznG0HwLwPijALhA1OcmOr3DZR3f9yujFBi1K+fFoFD5+OzWcnEQmPun2nAl5GI0t2KrZ
 wCRirOqVENWi1OxmjZEqB+gNmdru18l5cWPkuQ5cjAtIJhTWINacVajeIX8TfH85PI6TUOUQIp8
 jJ/RFskkJJkp28aNL5gSVLaBz0AvzHhqJQGuFPtGdEeEL9Yrijq47Jk7yW8pMSF7It6PNjqzK8N
 uckEt+cxg5I=
X-Google-Smtp-Source: AGHT+IGD8c3XOSzNSAtnbgCPXL5tD58s4Vu3uE6ycBqXZZzYELWWILbqDjXE5LjudjQPrkP6j3ddsItNOIABJyrJRIg=
X-Received: by 2002:a05:6512:6c4:b0:595:7e9c:cdf7 with SMTP id
 2adb3069b0e04-59584220ccamr6117950e87.51.1763459277344; Tue, 18 Nov 2025
 01:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-15-skolothumtho@nvidia.com>
 <CABQgh9Fk2qHkHbpepY0j8MaLe-TkxrVaMi_R3C-oD2HihK-wGA@mail.gmail.com>
 <CH3PR12MB7548AE8D724A8B4D8DABFDD4ABD6A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548AE8D724A8B4D8DABFDD4ABD6A@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 18 Nov 2025 17:47:42 +0800
X-Gm-Features: AWmQ_bk1G4ZN7vSmM8EP37hq4hWbZlZlf7eaN7zRGz2vPept5dLmWT4VzlKWyVE
Message-ID: <CABQgh9FqZDznoQDugR0M_Lw+UPg2r3jyQ8W6mv=OPArYAPQQnQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
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
 Krishnakant Jaju <kjaju@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 18 Nov 2025 at 15:57, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Sent: 18 November 2025 03:50
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>;
> > ddutile@redhat.com; berrange@redhat.com; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>
> > Subject: Re: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA
> > based hwpt
> >
> > External email: Use caution opening links or attachments
> >
>
> [...]
>
> > > +     */
> > > +    if (s->gbpa & SMMU_GBPA_ABORT) {
> > > +        hwpt_id = vsmmu->abort_hwpt_id;
> > > +    } else {
> > > +        hwpt_id = vsmmu->bypass_hwpt_id;
> > > +    }
> > > +
> > > +    QLIST_FOREACH(accel_dev, &vsmmu->device_list, next) {
> > v4 has this, while v5 removes it.
> >              if (!accel_dev->vdev)
> >                 continue;
> >
> > So I got a warning when accel_dev->vdev = NULL in the beginning.
> > "Failed to attach GBPA hwpt id xx for dev id xx"
>
> Could you please check you have this kernel patch applied,
> https://lore.kernel.org/all/20251103172755.2026145-1-nicolinc@nvidia.com/
>
> This relaxes the vdev requirement for GBPA based HWPTs.

Yes, with that patch, the issue disappears.

Thanks

