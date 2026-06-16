Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ED2CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZPSt-0007O8-7Q; Tue, 16 Jun 2026 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPSr-0007NQ-Cv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:48:09 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZPSp-0008Ie-Vx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 04:48:09 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-660323f7b27so4060116d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 01:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781599687; cv=none;
 d=google.com; s=arc-20240605;
 b=M32ohu5whx2vLV+ymrogjS3UvO9rlSI1vNJnBOiPmvsVHU7bNTHpQ56fVjeRcxAyzO
 ORy0tbuYzqjpV4vyj7KKM3H9zaEA45bpCzequvyP1gQsoM8Dd2mdnNfvSnuA+WzE32EJ
 Ylq2bT2UJRmdZdJDRwIFfgvW/aHkV+mWIdgN4+DZ5CKEMadSfnPSSD4haaXPM4BLf0LC
 51HZRqgK6PSKyd6lZjRcYx5qH1kecUKlXzprVoRhiY7bu4sF0lEFK17qZBcqo76cqiiF
 ScHvQNDGkNF2nQusiEFawwV6KMJ6+AC7JCyCp1LXaQO6zaz0jQ6felJLQHGKHX6xi3wd
 pRtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5r+APlV05BIlIwZRvP7h6ZusidgbpKZ5kC/OOQAO04k=;
 fh=oRJLpn0ZPkt84mVHZYJYzsQzX3CdO9ybC0IiPAD4E08=;
 b=A0eUSYluRoQc5cXLpJWv2Ez9zo/yuvFib2nQmCh47H7JhCq6VOeea2I7T9hDDa1geD
 W/KJ5YmugmuwrSizlJrWDB/RoRA8p4ZDzFPcP7yaCrqOfDAi9v9t3ZO7pe4k2h4FzBs7
 V2S1ui+vWI50kw4NFP7A81Vh7qib7N+qndh44qb2bONEO1aOCQths1RMfUbzRfi0ECiG
 w/8iSOhsOvGVh+VglplxOJGku5sPy1FSXKx5ChVmosYtm6IzSSzOrau3UsJQH83SfTig
 0mp8T2fFl1FGlfihARXHDlQxFA4JaSFd0TgLku1tIzMA+GLnQDp/2Q+XBgCfbqzV5uVz
 cCiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781599687; x=1782204487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5r+APlV05BIlIwZRvP7h6ZusidgbpKZ5kC/OOQAO04k=;
 b=eDZtWLf5UCjpYNA0fBVKK09seXZmt7cWzNEapoarSsjGKLKYhLbjvRhkSz8+52G+lt
 ArZzSpRBxOI+Bd5cOTfmQXoPJAsAAKd20e1dxDSw7qO+vf1tfalqS/H7bQAReMDra2rI
 hLZhIc8yMhG9bmrGribcJaNXV1513Sv0pT0t7/ftZXiiowMIXmFzXzfMSRLx2fztMHyu
 kAiRaeYoU55AHHocxg4ixjl2Bfg8laUbNBcQzj0aQ1xslU3BidktnodRO4UoY2leYF+U
 aOMBWx0FSN1uhLk5QpxvogzLpOiomM0ovGGLtPToFvZPV2AeY7OrxcD5/WC2/Q8TZdax
 ptFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781599687; x=1782204487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r+APlV05BIlIwZRvP7h6ZusidgbpKZ5kC/OOQAO04k=;
 b=IZXSk4s02JThrt9nQrw0pqG+yOoU2zdByebffBSZxlPJ7R4euWnL4qUGxS9eouWkqm
 P+gqzWdZRWkwkXzxy2E8FnSRaTuUGK2FjqYSBsgjyratoU138BiMDPHjxNyeTTKvDM5H
 YmmB+t2BEkIfAiuicl+nh7QDWaPaDzJwVRWQttfjG4LnFY6RpnPgxg7fQuhYI0FyZJQ9
 fz2bZiCwjGSaYuWn7f3q4dc+uaECnUN+H5BHGLRz51BvfrJsD+Ntf+IZCyKg5POcIBtM
 xJT6oeYy+2aRtMFjBImOClbEw8iEkGxzbxXVdhhw3qufjMww8Ukj9mKRce1E77TuTudf
 kLyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SZ5bBWlj9ATTjdOB6+JFouU36LVQnSwCQ635VkQ26t4QyyZ4raxJgS6b6LOaStyv5eSG5JMT3NXqm@nongnu.org
X-Gm-Message-State: AOJu0YyAatGK/CwXsgDbJarJPfHspjXzupmjjC5JY4jqDflAf/Np9oy/
 9G21/RzCjIF0JZoT8GbWT9I0Bj5OpvAAYesgb5dO0f5x42VR2MqKWQpPyo7/59+J44TDj8vLXMK
 XBIkZFYKFzva531AdhdFUDyOkLyBTTNs4SxaKmxRr7A==
X-Gm-Gg: Acq92OGE73O3e6aW7qYJZzGJ8piAryeOG9PTEV1iBme7YODJh1wEGEQ4E7397sX6n4Q
 wn8w86BcfT4XZ7gL3l4Qw6tJBx8fLcB2c2IU1a6IYQWcWZfg79VV9qfk13rZyG0F3T9FjKah17W
 2bh+3yKFHFPW6VFetS7M85nVNiF4qlKguKIE8jLbeXZKcQI84kG01W9fgIzDb+m4dgknyA/1AJH
 ReqOZiE8pZE8rT/VhBA61ufhbLe8rxKvYYivr6qgQ04nfGQT/kc1c+93pIxgAKKNlFNbJmvpIWl
 eaE0+6xA5B0rxrQRLKY/dp9/WHxIv2dckYTvCNJWUDMpAVJ7tOry0u/jbgvB/+IbN9o=
X-Received: by 2002:a05:690e:11c2:b0:660:580f:694 with SMTP id
 956f58d0204a3-66285054f45mr12676095d50.44.1781599686755; Tue, 16 Jun 2026
 01:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260603124415.1120808-1-eric.auger@redhat.com>
In-Reply-To: <20260603124415.1120808-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 09:47:55 +0100
X-Gm-Features: AVVi8CdEmmahopLC05cpDoFPfOC-yIO_sFj3eYajVZVVWvPG76Dco_nZDjDdT0g
Message-ID: <CAFEAcA8djCh2kL71Sa_6tRikiGT7PU=12yqJwrRuWFESSx+Xbw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/pci/pci: Enforce pci_setup_iommu_per_bus() is
 called only once per bus
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 mst@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com, 
 nathanc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 3 Jun 2026 at 13:44, Eric Auger <eric.auger@redhat.com> wrote:
>
> Currently it is possible to attach several arm-smmuv3 devices to the
> same bus although it is a wrong setup.
>
> Change the prototype of pci_setup_iommu_per_bus to pass an error
> handle. This latter is set when iommu_per_bus is already set and
> used by the single caller (smmu_base_realize) to report a useful
> error to the end-user.
>
> While at it document pci_setup_iommu_per_bus callback in the header.
>
> Fixes: 66d2f665e163 ("hw/arm/virt: Allow user-creatable SMMUv3 dev instantiation")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

I'll take this into target-arm.next as it's a fix for a function
that's only used by the arm SMMU.

thanks
-- PMM

