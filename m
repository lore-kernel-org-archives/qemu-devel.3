Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03768CDE03C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 08:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJpRS-0003lW-UH; Fri, 14 Nov 2025 03:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vJpRC-00035G-Vi
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:45:53 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vJpR8-0008B0-Nr
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 03:45:44 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5957db5bdedso1678824e87.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763109939; x=1763714739; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSZgTDfVYlYzcaesvXH7Usk9xJWzM+icnOyNSLsUgGw=;
 b=EpwnlRvpHjm6EyZFCauKmv5kq+5EZo6MAQOIe2kSO13d0XAQAapQGJ3ZU1qi9dTnvW
 FGOmH8b9/vQ7KZldsWXvJG6nsH4TWi4AqoptolcIpGRBg2gSEPUmVQA4UKFVZYGSMDjr
 4ChPcg4RRP1iDilF06TX9PwP9FJorlZVHfjZt/cEPpTeUK1qx3eXdUdDETQfZL85o+yK
 xiBhFY8q6YCR3ad9c/K0WfNtQLPnGg7l9olnbgGgh/xQIHkOkkliBtNvQ23AsPb+dMVD
 00Rqd7jli2ZcvGozo8UOzVtc4uXF9SV64Fs49waV8Itexo2IPoysBeQTqPfqQW0X7pY4
 NtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763109939; x=1763714739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pSZgTDfVYlYzcaesvXH7Usk9xJWzM+icnOyNSLsUgGw=;
 b=LzW0bWG+ZyU2XY3V7qaORZKaNEWKbd3eKpuo9qArd9plLjPdxUi4PIaUYi+dVJTLZQ
 7ZhpRynzAUTl1jS3xkmkfNleCzw5I3tjdjyg2Vywj77ifS2xBM1kz42ikQvMeJcUdfFy
 vAsXPR0YWSkh94hUzyust7j6ShF8jYf95/j8Iy1s2RGzIuyJLZKulGGetmAEwreMueEy
 iQklSt9bdOSM6pwMO1QJHtrhpeqmuquPfjNUS6KsIe6DUXLGVbRDHWrxrWUUKpt9XYkB
 sQOQu6E4IG3ZmdymFktmiExWXA6abSARFJpBmmOQc8GhX6khUcSvvc8akcSBTzDU7GZN
 Pnxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtzeWGp7OUmmizgy/Z4syK1wCDNjNmvNJjIOB0XznptHGDs2jRYPr/2lwb80+zCtr/ejKxjEOc1fl5@nongnu.org
X-Gm-Message-State: AOJu0YyU9dExFT8aYBvmCo7stv8v/9zRncEdeE7nzx4v3G0fHuAjRzTz
 r/v4Hh7Hcy/eNezgmE4qwXibK6FRESGJe9g7Ff4/HmJk6sCeFiOwXS34/r0aSTEXKYO5jSi9MpL
 Lo/32hOIYHatNS1y+2riMBUaDQUBT/ocyuHkWRsftCg==
X-Gm-Gg: ASbGncvHKurkmrv75boPVNA8DXltRpgVNyVJGkcacqTkx2bydGFt4OWqYZ/DplgLO1m
 8swBntQF73tdH62lDVOenNmVAvAEhPaFzTdjuR5g7Nui6m4FOLK22noSZfe2u8JHrCBVE/hoMaz
 woorne2z/GDrR5n2ebcr2Z020OZ+oMLkjIan7+I3VkPFePb+cQJKWjkF7654XoX1aM6fjoTBjky
 9iJWYOkOHNoi6UXfildZhxGmKfrEAvF/5XwQke3OLXf8noliZmSrHD68Rqvf2YCOw==
X-Google-Smtp-Source: AGHT+IE1ENK/8zyQrs2bYplJ6X5ZU6UqHbQUAkaeq1/0Ev4+Mkoox49MJRES5T8aNqBwBGOMCQXOl83pBs+tMXM33+E=
X-Received: by 2002:a05:6512:2216:b0:594:522b:c6a4 with SMTP id
 2adb3069b0e04-595841c0afemr783032e87.23.1763109938625; Fri, 14 Nov 2025
 00:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20251105154657.37386-1-skolothumtho@nvidia.com>
 <20251105154657.37386-5-skolothumtho@nvidia.com>
 <CABQgh9HzB9yCD_rYjGFX5ZC7RX2e2iVu_FZPU2Vm-kuf3jfm+w@mail.gmail.com>
 <CH3PR12MB75481A1E302DD0C6F5FC195EABCDA@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aRYY5eBnlw46nt2f@Asurada-Nvidia>
In-Reply-To: <aRYY5eBnlw46nt2f@Asurada-Nvidia>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Nov 2025 16:45:26 +0800
X-Gm-Features: AWmQ_bnsvrFWbogDzWDZ-TG7QQSX7YlDucAbK35a8B_SsciMeTJ-1ywwO4X9m38
Message-ID: <CABQgh9FYE6Jfm2iV7xGrydS5Yyk7L-VgArL4jOz=bCSdy5+HiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x129.google.com
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

On Fri, 14 Nov 2025 at 01:44, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> On Thu, Nov 13, 2025 at 05:07:50AM -0800, Shameer Kolothum wrote:
> > > On Wed, 5 Nov 2025 at 23:49, Shameer Kolothum
> > > <skolothumtho@nvidia.com> wrote:
> > > >
> > > > Install an event handler on the vEVENTQ fd to read and propagate ho=
st
> > > > generated vIOMMU events to the guest.
> > > >
> > > > The handler runs in QEMU=E2=80=99s main loop, using a non-blocking =
fd registered
> > > > via qemu_set_fd_handler().
> > > >
> > > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > >
> > > Still don't understand how to use this vevent.
> > > Is it to replace the fault queue (IOMMU_FAULT_QUEUE_ALLOC)?
> >
> > No. IIUC, IOMMU_FAULT_QUEUE_ALLOC is to handle I/O page faults
> > for any HWPT capable of handling page faults/response. The QEMU
> > SMMUv3 still don't support page fault handling.
> >
> > The VEVENTQ, on the other hand, provides a way to report any
> > other s1 events to Guest.
> >
> > See how events are reported in  arm_smmu_handle_event():
> >
> > if (event->stall)
> >     ret =3D iommu_report_device_fault(master->dev, &fault_evt); //Page =
faults
> > else if (master->vmaster && !event->s2)
> >     ret =3D arm_vmaster_report_event(master->vmaster, evt); //This seri=
es handles this case.
> > else
> >     ret =3D -EOPNOTSUPP;
>
> Yes. We can say that FAULT_QUEUE is exclusively for PRI while the
> vEVENTQ is for other types of HW events (or IRQs) related to the
> guest stage-1. They can be used together.
>
> > > And only find read, no write, only receive events but no response
> > > (from guest kernel)?
> >
> > Yes. And I am not sure what the long term plan is. We can still use
> > IOMMU_FAULT_QUEUE_ALLOC for page fault handling or extend this
> > VEVENTQ  to have write() support for responses
> >
> > To me, from an implementation perspective, both this FAULT and
> > VEVENTQ look almost similar.
> >
> > @Nicolin, any idea what's plan for page fault handling?
>
> No. I think PRI should be done via FAULT_QUEUE.

Does that mean FAULT_QUEUE needs a response, so read + write
VEVENTQ only notify, no need response, only read.

page faults need FAULT_QUEUE to resume.
dirty page record in userspace for live-migration etc, just use VEVENTQ?

>
> > > By the way, can we use vevent in user space application? not in qemu
> > > environment.
> >
> > I didn't get that. Qemu is userspace. Or you meant just to receive any =
events
> > from host SMMUv3 in user spacel?
>
> If user space application follows the iommufd uAPI like QEMU does,
> it can. I am not sure about the use case though.

Thanks Nico.

>
> Nicolin

