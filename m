Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5203DC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcrV-0003XJ-BK; Mon, 09 Jun 2025 09:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOcrD-0003Pc-V6
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:48:13 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOcrB-00028G-SI
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 09:48:11 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so35758947b3.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749476887; x=1750081687; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lOSZrvfgJd9riTfUFV+Ro6aNaGSy/IkCeAcZS0qVoa0=;
 b=g9/0sgLOQRNcdslC+55G5EXEONgDs7NCTQvkWPxsdtd4PcQiPVADCkxyWapWXg97b5
 0dMuEt9ZbUdPLOSCeMHAllreR2xsg4Ux/9eLK1ldFB2vTrRDwgt/i0Mx1ubnFdfAFNRr
 64bp33EbUMMYcdh/xxRvirnJkEVTJ1dVlERLxaeCW3BoJm3Ypw7LJy1XFeaZ0R4k7PWL
 pUEsdTH3Y2wUuuoJmVSqP3cFBm+9TLnOwtsGb9/AZ+6Bj2YhJoJt/4i72wB9xVHByFYT
 ZdhAc/JO+dxLd/S1wSzvu8c6DJMNeWSGpjPEqKgJQUN90G+cBZ3xJZch8ujodVxPpFWg
 LoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749476887; x=1750081687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOSZrvfgJd9riTfUFV+Ro6aNaGSy/IkCeAcZS0qVoa0=;
 b=TArDHAxk4GeaQyZpRRBpFG4p5M5zT7k75gjKlAiQPSws7WrnrRhvYDY6Etksq/B4Wl
 5POSaGIvuAhUowjPr1TpfxbVvKs2ks7Nj70o6HTbuOMigVxx0Y8OLMdqp+WMsjo1PfRy
 a6AsTA/DZdcYKGNsvDA3/bAOWPjV/08vuh/P9NmWqktqrdZJpFmeqqCHxNte4bJqAAq7
 mxMhV0kDyuuxlUMvFPeB5eJzYXJ6/vxp+9C91/aRs9PFVkyRxozmHmFthGV9+v++QCbF
 NNtVjUrGLjNu47cShOIW8pJeP2bLmVK4icFe3g8GEer5I2REifQymLDrNxjZCpAyUUcX
 C+FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj1oEZglGIGhLLmlmZkKESR0rj43xciWsH8xJaEPRWIQfa+6oe+OrDoInHVFXaoj6/5UYhj728wU4X@nongnu.org
X-Gm-Message-State: AOJu0YyYnk0+trSWwnAJx+RlTraWnuyPur1vCQzzes1hp28dcLdxSwAH
 guAZ4NLdUPDytm29XuyoR2Kqj4RhdLI3cH/dt63YbBsBBM3Ve8xLSXaGbycYS8hSPzIvF5MwWhd
 PBjFj8H7rpXPUKz7Jjhe/WS1LXFhwViUR2NitSqlObg==
X-Gm-Gg: ASbGnct4T77QX4GW9dKRyueokCwqSuKU5Kn+6xpnFDtnRfdaSaUhZC+Ot8OLZ0dr7jb
 NDtJxPvRDOJ7LAPMn2FORHbgwY6+wA+OF0G6JyXyzbbhtpcRTgazDZ/fNpBPXm7vaKMrYMhwRyF
 q3H53+s4DY6iKEFnIf3uB8Pj0+jvwYe8yWIA==
X-Google-Smtp-Source: AGHT+IG3llqunLEfhPG1F0/5WyxW4xvROpJQLP/9yzaX6FFX8ckA7A/A65Sui65P5/DV7N5mnoE5Z95d0QpoPObxBT8=
X-Received: by 2002:a05:690c:6904:b0:70d:f237:6a6a with SMTP id
 00721157ae682-710f76e77demr198382917b3.11.1749476887503; Mon, 09 Jun 2025
 06:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250602114655.42920-1-shameerali.kolothum.thodi@huawei.com>
 <ba4ac9e4-f8ca-4885-b2ab-6acdca51175b@redhat.com>
In-Reply-To: <ba4ac9e4-f8ca-4885-b2ab-6acdca51175b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jun 2025 14:47:55 +0100
X-Gm-Features: AX0GCFsKl-Lx1CJCKQBEEGz54q1AHFyL_tfCaXG8LI3cVh7LD1JwGu1ji1pKT-o
Message-ID: <CAFEAcA_PLOkpk4zVJ7YFgturG1ToxR4k=uRhOeQxA_NQu+TFCw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Check bypass iommu is not set for iommu-map
 DT property
To: eric.auger@redhat.com
Cc: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, nicolinc@nvidia.com, ddutile@redhat.com, 
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Tue, 3 Jun 2025 at 10:50, Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Shameer,
>
> On 6/2/25 1:46 PM, Shameer Kolothum wrote:
> > default_bus_bypass_iommu tells us whether the bypass_iommu is set
> > for the default PCIe root bus. Make sure we check that before adding
> > the "iommu-map" DT property.
> >
> > Fixes: 6d7a85483a06 ("hw/arm/virt: Add default_bus_bypass_iommu machine option")
> > Suggested-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>

I guess we should cc stable as a bugfix?

Applied to target-arm.next, thanks.

-- PMM

