Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606D6C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LLZ-0001BI-Oi; Tue, 01 Sep 2026 06:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1LLY-0001Am-4m
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:04:04 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x1LLW-0000Pj-KX
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:04:03 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-90e8ef37f5aso1951216d6.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788257041; cv=none;
 d=google.com; s=arc-20260327;
 b=kLvLnfq/Saqr/ZQw2QVbznjdogFQJvcwPUcCO858khlH3FAxED87i7o3XCOcsAPNz6
 +3OtRoobc8l6NqBRGyU+OHVbq2PcTmKee7DTn8/uqyJL2Cmvo8iwRXPaUb0o/zjRexOE
 plGbIcUJxlMIjENpXYF8veEskAEfnZdTvjJEZ1Z5DzelwuDdixlHaGwYz8X7D6fsNKG5
 4XlZkU7je7krn5ut998dw8OpbHZ4W6Wb6ncDrk3Kk5V1+DXIv6mczHQnI7XC4Dz6ewli
 nxzVKufE/8bycGB+vyS4B3jMrTN8ixkUNMLaL+gKBiGONRXdg1WXu0jaGxyZi8me5UWm
 yiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Jbh8sj+NAL+cE56fSlzbbA98tOP4AJb68UPAEoGDolY=;
 fh=yt37pKM0DowbbfzFl7u4tNJ6FQcSugtuUcg6cJnX10I=;
 b=lcE9rktjNs+cUmVMvV6aRf/YPZPeQGrRl3KMH+zdzvP3lLPQTNSVUq7MHdS0gCXg6T
 XAYuVhiHpW05vNPHYLajCda2Bb1xIL40zgibxC76BMpauKOxPD3V09Pxvj9CmQv4oaGs
 vtKYBsKWOO8MpuxgPrOZQnIeH0KQgYNVhM7CiDhLM4A5/5mLl0yZRSvzLLm5HSd0pp8t
 O0GcowfxLxsA8QtcDmwLor+HT/8/yvbbDrFD/V1dIFwBsynO3OnicimB0TFQ7wcw26bU
 IQOVXmwqh3NAgtAG6n0pZRf7yRh7tJvvV+vLmZEnZ0IdyZOi+vpvqgVBF3N8ejF5LWWs
 +uZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788257041; x=1788861841; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Jbh8sj+NAL+cE56fSlzbbA98tOP4AJb68UPAEoGDolY=;
 b=dyz0BGDQyMKQVMLHkClr6Mxw/BV2wCihy4hvJgeM3w7O3JBMgMzuejLGf05OCrjTRE
 23rpYeUhdPMpsIo3JkSZ+PozlzRMdU3PUdVO1cXKSYoYekUUhd4v25VEDjqdz24EPWFc
 j1sgkv3gvWwnZap9MlMeZuGRX0giU1Q4+n3ptcksQPiBQs08zOU5Jobo2kjqK0CILcpB
 M/e3v8dE3dRcgbTUnK9F130HLOcDgELidBuX/CVhAh22FUFeaNawzB0Q2v3zfAFVq4rF
 iJyQeijRC4qRNryJp4n1V3sZEMDtM4awSLOH9Eb0Zn0USXdTfSjfEfU6RhLSBikNIBMd
 Hu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257041; x=1788861841;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Jbh8sj+NAL+cE56fSlzbbA98tOP4AJb68UPAEoGDolY=;
 b=hb33Dh0OAEUHVMnGQzS74QRgPKle5qtEdy1A9/MhD8pSxiWYhx47iydK+JL6XN2xXu
 zoM9Zpd5QUeEbXEw2uPJY307Jx7brBijXXe+4v4hDmT9IFgG2BuhDBTu3l5EXJKpERFG
 TOKR517TvkcmznCEgAUb2jMKXIiGm6lAl4wIWbBHeDly9DWRrtUU8kBTd32hguun7Cg2
 sJY1d3kiF1Gjg1xLj/H2GRbo6Ht6WeoUXQkXURrn9GZeJFXMseW574E+E9cjPHl04pMp
 OIvy2h+dshB1/pg8pPoTPgfGDeyNJ3eKViJXPWxFAkaoRXY6u/UT7iAU/WDDoo9usiTP
 +L8g==
X-Forwarded-Encrypted: i=1;
 AKwUvByhchWD9Hr9YqHQgf/nENOdW0MvM6JbLpj87xIuYhApria3rXd/kO7+VcINYPnd/4FPSsGj1mA95shH@nongnu.org
X-Gm-Message-State: AFuF++m8ro7GITR9xRAvXa7E+DQVpwdpYnjYAbINRUAUv2cn/XNlrJvO
 IeOzawfhKr42AZ7/8a2JBOqfX42Jrks9VQ0m4jZrqMm8KAgLb7tcmXsR5jhfVLulOCp4G0Ljkz3
 sxOPgn/1hDrnvRfbubZRFUntY/F8dhhk=
X-Gm-Gg: AYBFou0l3N+Zdcai3PN2bZCWtSMoD7XIMtCTnH5zaAzgvsUwJvCxpTSV9lrMmFONoLd
 UaFl045X0Cq51oYq21/qSjYKaz7ro1oaNCb4Hnyv3d5mvkbHLTw1bxHkGXTz2KbC/VvkT30CXPB
 m97POg0/1mxOhvWPQ4bt6AfiDgqdRRT3qVXRow2mTqZnO8U6ZLDgNq0klWuBttcr/RS7+lm27Xc
 DadK9sZ0uAwRkgHCSNy6QVKWMa2vMXp8BDXFiNsVq7wKAWHPrfHCm2uZqDJBPTBNKj/RVHv6o/u
 NDNO+U7r8yeVszF98HWNJzC55xPsckfKfU+rkj88W43F
X-Received: by 2002:a05:6214:5f0e:b0:907:c6bb:5d0f with SMTP id
 6a1803df08f44-90ce0e75b55mr229620336d6.1.1788257040739; Tue, 01 Sep 2026
 03:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
In-Reply-To: <20260805124519.30054-1-danielpaziyski@gmail.com>
From: Daniel Paziyski <danielpaziyski@gmail.com>
Date: Tue, 1 Sep 2026 12:03:49 +0200
X-Gm-Features: AcwNN1X354orKanPltzmL4PG5QrxDmkO4Z3TgjpimMA6mLRtCbFWD34gvCkzMx8
Message-ID: <CANukVxvZS-zo=SMpj6Fpe3i92v_YFOgmk6mwXnLnJ-n+KNqEQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] NVMe hotunplug and PCI SR-IOV fixes
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-stable@nongnu.org, Jesper Devantier <foss@defmacro.it>, 
 "open list:nvme" <qemu-block@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=danielpaziyski@gmail.com; helo=mail-qv1-xf2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Ping! https://patchew.org/QEMU/20260805124519.30054-1-danielpaziyski@gmail.com/

On Wed, 5 Aug 2026 at 14:45, Daniel Paziyski <danielpaziyski@gmail.com> wrote:
>
> In this series, an assertion failure and a memory leak are fixed when unplugging
> SR-IOV capable NVMe controllers.
>
> The third patch fixes a null pointer dereference that occurs due to a mistake
> in the SR-IOV capable device realization logic. I discovered it while testing
> the code for these patches, so that's why I am including it in this series.
>
> Cc: qemu-stable@nongnu.org
>
> Daniel Paziyski (3):
>   hw/nvme: fix assertion failure on sr-iov capable nvme controller
>     removal
>   hw/nvme: fix memory leak on sr-iov capable nvme controller removal
>   pcie_sriov: register user created virtual function before realizing it
>
>  hw/nvme/ctrl.c      | 12 ++++++++----
>  hw/pci/pci.c        | 11 ++++++-----
>  hw/pci/pcie_sriov.c |  6 ------
>  3 files changed, 14 insertions(+), 15 deletions(-)
>
> --
> 2.55.0
>

