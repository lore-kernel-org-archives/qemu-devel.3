Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C508CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 09:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQSj-0001Mu-Fw; Tue, 16 Jun 2026 05:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZQSi-0001MZ-2l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wZQSg-0007RD-M9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 05:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781603521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l+uUuDWK56fj81QKZqXUTI40UshF+we+uBmMzzqVVw4=;
 b=QoQQQesjTJ/GJrDXMAjOp7VTpLDhF+OoSxfCnXT8URBzVPnlWd0yKDn8VAg5bOmE8x/DKq
 hSF0hU5ggtqf44RHjkVg2fLg7ZcNVFbqO8fwQqTwbWCJx4ChtGyUiKqfY+YGILpjvDG6RP
 9MxvDQ0mKIO/xsx1BlZGuSlY9XnbGlc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-rVFcQlYoON2OMQjWwDG4MA-1; Tue, 16 Jun 2026 05:52:00 -0400
X-MC-Unique: rVFcQlYoON2OMQjWwDG4MA-1
X-Mimecast-MFC-AGG-ID: rVFcQlYoON2OMQjWwDG4MA_1781603519
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490ace40f13so18604585e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 02:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781603519; x=1782208319; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l+uUuDWK56fj81QKZqXUTI40UshF+we+uBmMzzqVVw4=;
 b=EsV2ckU+F/mZoCWdTWj0/G62Najg3HSWbXMSHQvXaz9pWX1oas55DFgM9u1xnk/iVJ
 NfFUR2OC/9cHJQmXeSrce38iRrhJR5Drhrme+MOCTyPAjGg1Dzjsg/Xe0Fs0XUVmEHTu
 M5WkVxvd0Gswdf+n+1sC18u2cBpKfLj44HSnL/ESzp2U4Bbme9+iSx/Q/BSxvHeh5Kb/
 proPc3EH2KFXNMbe94LdpfDQrRrqzSacPFbsi4rOjVtfyW5sOycTPaoIeo0kGZFBX7zp
 Z8ynQ6Rzd2l3Ns4dOuaO5n5GK0YkpkHFe71EjDhrAQqq067sJyDsLmL17ZrmlPe/GZ+C
 kZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781603519; x=1782208319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l+uUuDWK56fj81QKZqXUTI40UshF+we+uBmMzzqVVw4=;
 b=Ru2aPCGWFD+bjAIhGXFvdzZVV2wCV+ZcvaDT/RIIX6gzXbHtFVWVa8gvtM8EUMtffP
 wgiH7m8BzgfojrFOBySrpSO3byZKASBoAN6xcSBC3F3D00tZr91dsVYUekBRT6bAS00c
 WbypP2U9YrGrtoz8UXRA0dfO+VC+qXp9aVsGt/ha0hiKPJKYQCXfz90eQMBK9vU2ke4q
 Gd8nfe7ZW+xD2Z0FdP4uJhOSdi01m1Aait7RsEVZOily70VKAzi8hoOdR0AZ3s4mga3l
 WbQdm0F2vDs/2Y4wka1lQ/GNg2l9I+2khsjfXPSC/asn4dyIf6EsoodnME8N3w+4yO9i
 9jMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+skvqxPUc0qiKuU0a15uGkc/X/ZyF/YOo0VLSCJvSoQmYGV9kO6Vrz2oWTJV9fhKF8R+snnfOU5SdZ@nongnu.org
X-Gm-Message-State: AOJu0Yy3xvpDwqSp/LYaMQWEb22QzEHBN8EMlOjVlRwviSr9BbMe2/nE
 yRJagnBlD23oFhKInZ1W5nfqRuDB486FTMyvZNnoC+3nAwe6gJyJ7u9Na3HJkUqgI/kswULr6CK
 4FNJ2Ml6X+Hi5PlRgdbmR88nJKiLzJiCrHI2uHbDz5IFobp0LymkOFi/u
X-Gm-Gg: Acq92OGpnFWRvR9t54wOt3KpuQUE5vM8JU84/SUw3w0SVSsG+sPazY3jkM+H+9ZhV9S
 +1VJ4Sh2dSVzKanMmxkUltuWNFBl9/vqLRqs10ZtGsxB/QmhI80rxlq1i3cgYaZ8mWk2y0WKa9G
 yn8+tc8SS/i3zU1sijGqVbhItz+r7inmikkfjeFgzmtLErENfLhRu/JXON1p4xqJv1bU9yRmaXO
 tEFU+2YK/Zytb/a6vnIH6rZHainxX4sxm7aVS1MUp5hM/EJsHvByPlPmzEOTqXQs/V454SpHgd4
 0PpKQPWwLdvJ0y0/ncGF49+Y87z6SwKnKFEFOxe0XWnn9evYiUngmh1eOy/p5+kjivlRm++JZKJ
 iHE5YXkcrTgikQ/X3ccigc1xeOREwoGwO9M6Ga8qYFTQ=
X-Received: by 2002:a05:600c:220d:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-492200c06e7mr142448385e9.22.1781603518571; 
 Tue, 16 Jun 2026 02:51:58 -0700 (PDT)
X-Received: by 2002:a05:600c:220d:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-492200c06e7mr142448005e9.22.1781603518066; 
 Tue, 16 Jun 2026 02:51:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa890d8sm73585125e9.10.2026.06.16.02.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:51:57 -0700 (PDT)
Date: Tue, 16 Jun 2026 05:51:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, skolothumtho@nvidia.com,
 nicolinc@nvidia.com, nathanc@nvidia.com
Subject: Re: [PATCH v2] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is
 called only once per bus
Message-ID: <20260616055142-mutt-send-email-mst@kernel.org>
References: <20260603124415.1120808-1-eric.auger@redhat.com>
 <CAFEAcA8djCh2kL71Sa_6tRikiGT7PU=12yqJwrRuWFESSx+Xbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8djCh2kL71Sa_6tRikiGT7PU=12yqJwrRuWFESSx+Xbw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 16, 2026 at 09:47:55AM +0100, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 13:44, Eric Auger <eric.auger@redhat.com> wrote:
> >
> > Currently it is possible to attach several arm-smmuv3 devices to the
> > same bus although it is a wrong setup.
> >
> > Change the prototype of pci_setup_iommu_per_bus to pass an error
> > handle. This latter is set when iommu_per_bus is already set and
> > used by the single caller (smmu_base_realize) to report a useful
> > error to the end-user.
> >
> > While at it document pci_setup_iommu_per_bus callback in the header.
> >
> > Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Tested-by: Nathan Chen <nathanc@nvidia.com>
> > Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> I'll take this into target-arm.next as it's a fix for a function
> that's only used by the arm SMMU.
> 
> thanks
> -- PMM

Pls do.
Acked-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST


