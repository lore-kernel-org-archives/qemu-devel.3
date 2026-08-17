Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD61C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyqv-0001lM-Rh; Mon, 17 Aug 2026 11:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wvyqt-0001hI-0k
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wvyqo-0005ff-NS
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 11:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786978926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OMmE6nfk+YFtcw2BBus6xHm0qac/SEITokoBvt5qRT0=;
 b=KFy0THpRPMympsokFQk0TnSvVnM5bd5iNmdDVDW9P/ttRgkn6smqctDIGABO7MoOGZfVRQ
 xNug6SqrJv7ILiWssFeR+F59R/vXE+hI49iJ2bJ6OYuuOGyJvkzzFb3G3jOIc0MJJJKpOi
 uQTAP/4QQEqqqxfc5LK8O34vY1KGoRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-xLpC4nMhMq-HvGBK9tf0YA-1; Mon, 17 Aug 2026 11:02:05 -0400
X-MC-Unique: xLpC4nMhMq-HvGBK9tf0YA-1
X-Mimecast-MFC-AGG-ID: xLpC4nMhMq-HvGBK9tf0YA_1786978924
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-698b899b53cso2850435a12.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 08:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786978924; x=1787583724; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OMmE6nfk+YFtcw2BBus6xHm0qac/SEITokoBvt5qRT0=;
 b=I7/p3yeXSCABZOkvU75n+KTBNbVDcJxiKcDDQ7eq/wXEUTkNKM/8lcjUWabGL2QgoY
 /Hxp+ZS+makqWW9GIooZFfTdUI0XaQlQ0kBKt2fN1IBoXsnM1vxGXijqNuRa8qSdiX3k
 FUoSP4e0vvAIhqtAaHjAL7KyyjBppeAe+OCIOfPu3JOXyLNM+g81Lc3NRJBpvf/5mvcQ
 ClcWZU41YUbtfa4rPJNCyqKF/qFV4VhN6glYvcvpbQH+3cxXT0KIcc4Sb8OtQ8JparIi
 +HGHKvr+1nFX8sloG/jdDWHoIgywmv3fLXwp9BSHOwo1/s7ISlVFM91dfzWTeLPZvcc1
 Ad+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786978924; x=1787583724;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OMmE6nfk+YFtcw2BBus6xHm0qac/SEITokoBvt5qRT0=;
 b=fC9Ke5ZbNI0lQOuho5Gco0Ywjstf5775hlzGvQkvWLXzlvx02zugP7EQ+XoOOY5GgH
 J5OPeuWoyFu+z5ZL7fEuGpeu5pVYlAD6rhc4fOyUjyeh6Hi1QLq/w878cABRXpUfO7j+
 QD99i3zztKd0++Cm07fibh73y0DtzXmyV0HMK/fi5XtWtBkIbyY4MO2rkqSiR4kNvaR/
 DK6rhrU3Y8RFOgnIMqpCiTg7+dR47EP3ZwCwF4zIW0WZUiE5HS4EBoHzb19X7kQKyBq7
 fzz0+8KEfBvU0fKdthIOHeyHiWLdlPaYIgjkXmtoDyinQTu8ShJJIr2PIqjojlGTpQIO
 SUGA==
X-Gm-Message-State: AOJu0Yy1fVqR3wp+ZEYNwBV3N3MuTpc0acMmHBPf3RjWf5o03SYjDjUU
 ZKjj1TX/ND9VypT4j37kpka9Bufvq8VdAfNZ11Z2XMpaOqyxdzxCZEVoMJYp5NqBzq4DT1qod9u
 MHMGiRtVM5z5ZQ0hzsdJXxX30sUEBulvVGIKugle5oERR+IvEy4l1S38WdkOTmXB3tc38GNBBcf
 ICBmtGznEh9Rw4qRdvPpa9HF3L1V0YkZ/xTr+Xt0CLKVs=
X-Gm-Gg: AR+sD124YB5VLspnn3ZjHkNmKdixT7NEgsUMuRAXWgasNFIa80cDWWxkqKLxdPmwtDQ
 oLFvr+Rujc+exNrdZOfmmn+4+G//grzbgZPB14dzwoKHuWktsBtqeLb1yKM0HCQh8cxgDkcnH06
 nR6Oyn7mahqZciSidGtnC2SDLm+9TGDLZS+jhizC+LVxju1kLLrq8n0xvB11Ye2+yn2dR9e2UWJ
 NImJcTDpJiOMpVZEuHrxCjpcIw+9ZXmpd3HDARebckkoeNoOgN7HK5G4Ank5P9MmM9tJ63AXWUX
 6hl0zpgZXMASW3sUq3EIpcMnGt6/E/qGVvMbOAUJgLPvqD/BwD02cbselBAnXfXW3xkPfXlMoJR
 0cv631ZBKLI/ts1VULn1+q7HCkCvnqMZ9/hs1coyW7NAqGX0+3jK6tc1THJIerHFAtghMnvLuM0
 hByizJXAC6OFI=
X-Received: by 2002:a05:6402:1588:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a38a8f9b87mr12358959a12.5.1786978924208; 
 Mon, 17 Aug 2026 08:02:04 -0700 (PDT)
X-Received: by 2002:a05:6402:1588:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6a38a8f9b87mr12358904a12.5.1786978923504; 
 Mon, 17 Aug 2026 08:02:03 -0700 (PDT)
Received: from leonardi-redhat (host-95-247-118-130.retail.telecomitalia.it.
 [95.247.118.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c5dcsm4954627f8f.17.2026.08.17.08.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:02:02 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:01:59 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 0/3] hw/i386/microvm: add uefi-vars-sysbus support via
 platform bus
Message-ID: <aoMiTUf_1v1okEPN@leonardi-redhat>
References: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 01, 2026 at 04:16:16PM +0200, Luigi Leonardi wrote:
>This series adds support for the uefi-vars-sysbus device on the microvm
>machine type, enabling persistent UEFI variable storage.
>
>The uefi-vars-sysbus device is a sysbus device that is attached to the
>platform bus, which microvm does not currently support. To address this,
>the series adds a platform bus to microvm, following the same
>pattern used by the ARM virt machine.
>
>The platform bus is mapped at 0xfec20000 with a 1 MB window, placed
>after the IOAPICs. It is created without IRQ lines since the
>uefi-vars-sysbus device only requires MMIO.
>
>Patch 1 fixes a crash in the platform bus core when num_irqs is zero,
>        which is needed to support an MMIO-only platform bus.
>Patch 2 adds the platform bus to microvm with MMIO mapping and FDT
>        integration.
>Patch 3 allows the uefi-vars-sysbus device to be instantiated on
>        microvm.
>
>Corresponding edk2 changes[1]
>
>[1]https://github.com/tianocore/edk2/pull/12751
>
>To: qemu-devel@nongnu.org
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Richard Henderson <richard.henderson@linaro.org>
>Cc: Sergio Lopez <slp@redhat.com>
>Cc: Gerd Hoffmann <kraxel@redhat.com>
>
>Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Luigi Leonardi (3):
>      hw/core/platform-bus: fix crash when num_irqs is zero
>      hw/i386/microvm: add platform bus support
>      hw/i386/microvm: add uefi-vars-sysbus support
>
> hw/core/platform-bus.c    |  4 ++++
> hw/i386/Kconfig           |  1 +
> hw/i386/microvm-dt.c      |  9 +++++++++
> hw/i386/microvm.c         | 38 ++++++++++++++++++++++++++++++++++++++
> include/hw/i386/microvm.h |  4 ++++
> 5 files changed, 56 insertions(+)
>---
>base-commit: f38d6ae70f100fc8d3f095a842d2f1ca29262218
>change-id: 20260701-microvm_uefi_var-8a434ce7f8b9
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>
>

Gentle ping :)

Thanks,
Luigi


