Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4472CD484C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 03:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMzsA-0003gY-Ml; Tue, 12 May 2026 23:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMzs8-0003g7-Iq
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMzs3-00021n-T2
 for qemu-devel@nongnu.org; Tue, 12 May 2026 23:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778641367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1SSPJB8aWuPLVkgM6Su2a05vXFFvt2HJZPfP0IGeaU=;
 b=d9OFSTIjjpqOQN+hxY9d0mOHPmWDJuNHpc3DaxMvGJGK+0q3jPFuSbLVvynCJociTlSXIn
 ICdhV6UUNt0hLo37JKVx6YF5UWplaE0LMZfz0Gh7ixWUXA/xOKu7WGnF4VGuXs87RAa8g5
 NhBgqGxGRAtac3M4jqz/fllTBNQ3IC0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-wCPUp7g5MOSSbvbmIijDpg-1; Tue, 12 May 2026 23:02:45 -0400
X-MC-Unique: wCPUp7g5MOSSbvbmIijDpg-1
X-Mimecast-MFC-AGG-ID: wCPUp7g5MOSSbvbmIijDpg_1778641365
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48d035e8593so43460005e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 20:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778641364; x=1779246164; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I1SSPJB8aWuPLVkgM6Su2a05vXFFvt2HJZPfP0IGeaU=;
 b=PUqNYkWHeVHr9qphIoiodUxS7QlZHT47h37fXDSlqzqkIhXlRgS5v1cZgSSM55Xzy8
 XzOWaK0h+XHGtTeajXaCbc445iBAL/3HiliM9f3I8jcRTDFS2SD6JWAL9xjaS0Q9AX1s
 wQZxRRR4BpZ+FoeBEO98j2DP+gGyBLCLoZxImgwbI5EKn3bjJgTYnxnmhmktcJ8H0IAD
 NCVczEyo+6Y2uXZZsPdHzSGI7pY4876XSmnlJ0rxHUhVe5Cg13SSNGH3mDAG7tuXxore
 +4CIGnIT476I1TFOB1fQM6w0rcyXlevVz3iO5gGydlR5YeTZH6oIbHhoIrNXIWQ/djxM
 muoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778641364; x=1779246164;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1SSPJB8aWuPLVkgM6Su2a05vXFFvt2HJZPfP0IGeaU=;
 b=LzueZHc2LCrEynu8NdMt3mpdl3EagG+xnUHEpZy0D7OSstRqOfbj3khOqp/MeM4D0H
 zJmGdrUc5SGDQQ0P6+3fE0sjHLRaa8+qgdML8vNl0Ux7YV4AdTskJjxDSsuLtqnkyrqe
 pZTIFlVg5OOfwiRgQzt1SwU5vYCZLQGr0ZeClwcQLldHAjwQtNdS+TpveDCWhqS+1Zc6
 Y5GHLqxLp2ivE2dVPoN2vO5cvIYz6dgzwAa9LHN79hnBNQ66HWELQWH4JA0ZDun3FPon
 Azye5I2OwpCpZDHmHR2gYqhG8l9HbsV2Kif7XfxtQRx5SSyYTVBN5b1mDEY6xPRXStUH
 7aqw==
X-Gm-Message-State: AOJu0YyH11qbl1SItHIc02SWJN7TSRFx6IzZbxpCCCa3x2t+pOUuB3O9
 LrWitD/i/3SnY++sLRFP9U/yiH7Z3d7XFX9fCWzVALulLiEVYIzquh6lbBTtVVWnS1q85p7WQp/
 dzHj3wXr1GL9/oMe8UWXOrcHyr37TUFM9EITmHFl1F8tkrEvT82Y+UpS3
X-Gm-Gg: Acq92OFr5NpScCRl24QVYjVkv0lcC1l3XpChEIPZKcxpK+32ovAAv9jQIuO0JXYqR16
 oRWQ1OpCDaQ0rzdShvxiaGtHOUYf3ViaHPtbhwnH6j6pCxf9e/hxRpSF0GKNeW2LqW//s39MCce
 iWXnmNBcLp8Jex2gIOldlm6iTVn62mP9Mkqs6IriIJ0g97CPmXmVLGy/N1KX6lF2eCpqKXX4OPF
 rI6aIG3H7eVtlTjClYxxR6W7IEaxKPyHYPLQ0yXgTevp/o+8qNZK7462H6gylHUPDXOp9FUvIFe
 JxsdXK5o2FoRZs3+d5hYtg+UeiAl+6GzPr9l28rji7Wz5r5ygqW5Gf7wCkg1f7GvBwTwyEMIuWs
 oR58Y/oULQNdy78a454aRYJkF6BWFLtks4INCwjEO
X-Received: by 2002:a05:600c:6096:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48fc9a30d10mr16363575e9.14.1778641364584; 
 Tue, 12 May 2026 20:02:44 -0700 (PDT)
X-Received: by 2002:a05:600c:6096:b0:48a:592c:e63d with SMTP id
 5b1f17b1804b1-48fc9a30d10mr16363275e9.14.1778641364110; 
 Tue, 12 May 2026 20:02:44 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm35889765f8f.19.2026.05.12.20.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 20:02:43 -0700 (PDT)
Date: Tue, 12 May 2026 23:02:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 0/2] Update properties naming for 'x-scalable-mode'
 and 'x-flts'
Message-ID: <20260512230231-mutt-send-email-mst@kernel.org>
References: <20260311092320.212849-1-zhenzhong.duan@intel.com>
 <IA3PR11MB91364B85D3940A668D740CB992062@IA3PR11MB9136.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA3PR11MB91364B85D3940A668D740CB992062@IA3PR11MB9136.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 13, 2026 at 02:32:00AM +0000, Duan, Zhenzhong wrote:
> Hi All,
> 
> Kindly ping😊
> This series needs a rebase as there are conflicts with newest code.
> Any comments or objections before I do that?
> 
> Thanks
> Zhenzhong
> 
> >-----Original Message-----
> >From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> >Subject: [PATCH v2 0/2] Update properties naming for 'x-scalable-mode' and 'x-
> >flts'
> >
> >Hi,
> >
> >This series dropped 'x-' prefix for properties 'x-scalable-mode' and 'x-flts',
> >by this chance also renamed 'flts' to 'fsts' to align with newer spec.
> >
> >After that, we can add scalable mode and first stage translation support to
> >libvirt.
> >
> >Thanks
> >Zhenzhong
> >
> >Zhenzhong Duan (2):
> >  intel_iommu: Remove 'x-' prefix from 'x-scalable-mode' and 'x-flts'
> >    properties
> >  intel_iommu: Change 'flts' property naming to 'fsts'
> >
> > docs/devel/vfio-iommufd.rst    | 10 +++++-----
> > hw/i386/intel_iommu.c          | 12 ++++++------
> > hw/i386/intel_iommu_accel.c    |  6 +++---
> > tests/qtest/intel-iommu-test.c |  2 +-
> > 4 files changed, 15 insertions(+), 15 deletions(-)
> >
> >--
> >2.47.3
> 


Pls go ahead.


