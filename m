Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A91CCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 03:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLCjV-0006GT-Ih; Mon, 17 Nov 2025 22:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vLCjR-0006Fq-TO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:50:18 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vLCjO-0000v1-By
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 22:50:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5957e017378so5843728e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 19:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763437811; x=1764042611; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/YYBa4PpVDAlOdsy90H26Rh9+Rc0h1fgXzQPvbTBnJ8=;
 b=THCDkSX4QzpOShB6zIZ8jMJF6bVn85wZBb6aeOYB9SYo6LNTuILbIYgPUDdZrHGEl3
 d0/WiwdFGz+KUTer3rJD1Akr8WLhK9mg5oXTOfJoKHJEQ6rT1JcOaNS9SA6IyvJm2QQE
 TMfrgOsyIpktDdZZ5aRT9DwprDncjJi/AlLLcUpqjEP+/qQmv39TSvMa1XfojHumgILB
 33EGZbhIBA58dkIQy/wwFUx9SW6Vo3YGp5Os0na9mc3pp7MKOhjhNipHTR5IZ6/kufn1
 GQw/vyZ/I18j9YKl0FKk1AZJe1oevvLM7muZwwGg0w0p7Z9y/1RQzJlFUzjps18UMN94
 5dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763437811; x=1764042611;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YYBa4PpVDAlOdsy90H26Rh9+Rc0h1fgXzQPvbTBnJ8=;
 b=grnqSZ/oSOIaipsamE7qExNJi6TQ5UIWElv4for3pNa4+phYB9GUqQj2J1cMAC3Prz
 GEQzuDzB9vfCDlPjYUwaSyhdE8IaMZFU9AfuE585nKc3HHcxrB8AlDPffdxOeorNuNrT
 yaUNJHJheP+v/20RKkSVpWWerSqeKYS81q++3TNSvQyIqbb8S7XuorydzRIYm/5F3hzt
 krWEbyttBKxhEiEZ5YUxVVJb/+B1bexGEHGPUtr/F1u/9sB6z+vEJGMPwY6KdW+Jfmbm
 LW/QxBE0OM5HiKTdiJaFs9a4/kuR5662bZs3YE5070dSXPusMKpTPiK+qLCZWzg21AVO
 0bgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgjSL3Z0v16gJXA8Ir3S1G7pg0dcvIJn6oKZM+Mhkb0flmS+sCLkn1dDCrjtk/eIKUGrgCVZ23X74N@nongnu.org
X-Gm-Message-State: AOJu0YyBkzHxWMnGomPw1zjCi7AB1g7Uzy2qInrVreVaf9Ea+r7zU7qp
 NbcAz+nXceBqj9DYrkBOFrCLnEIzJ9Po89tDAcW1m/Ooc0l/fE53tIdGTtMa8Gg8jcKSspFPKSH
 fTQHhuB5D3sbRBUzw2QUfjx5qv3bG3u/1qvO8dvMSGQ==
X-Gm-Gg: ASbGncvYc4qaT7tCiWgIyAk/B3qptkr5XiKxIT+OhuzJpVNu0vwpFtxyfXfMPAsdL19
 6PqCNNKgSi6F8uUI2gRgfavb66q5H8U1VK1nSquz/sL1/BatuY5HDZIVIxu5eJhn1HXF8WF/hFe
 ITR6MYx+W9EUujwrZzBA8Sr5zzpvmxeZBiOqnFzPmjCTwIJH0Gxu7epZhcNlovXFJ3RAfrbYEQ9
 iy1U8AEhTct64RndQVmyC3tFggtEBTOiDKwQj4HTrG2yVl7DnbI+oEUGO0=
X-Google-Smtp-Source: AGHT+IFbpIvrRXrMOL+wB0jCx280hL8PUu9I6kYDKZn3cRCZrRyzEhBWqtHGGPllA9/hFh6C1D6eFlbfSN8PF0mGRwI=
X-Received: by 2002:a05:6512:b05:b0:592:f7cf:9f6f with SMTP id
 2adb3069b0e04-595841a287amr5217964e87.14.1763437811224; Mon, 17 Nov 2025
 19:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-15-skolothumtho@nvidia.com>
In-Reply-To: <20251031105005.24618-15-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 18 Nov 2025 11:49:58 +0800
X-Gm-Features: AWmQ_bkuZd8W0hXs1QCRa9eWKcTPjGiBbqevhvrNYrTYQB2fyG4AOlPPGBzdLp0
Message-ID: <CABQgh9Fk2qHkHbpepY0j8MaLe-TkxrVaMi_R3C-oD2HihK-wGA@mail.gmail.com>
Subject: Re: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, yi.l.liu@intel.com, 
 kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x12f.google.com
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

Hi, Shameer

On Fri, 31 Oct 2025 at 18:53, Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>
> When the Guest reboots or updates the GBPA we need to attach a nested HWPT
> based on the GBPA register values.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  8 ++++++++
>  hw/arm/smmuv3.c       |  2 ++
>  3 files changed, 52 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c74e95a0ea..0573ae3772 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -479,6 +479,48 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>  };
>
> +
> +/* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
> +void smmuv3_accel_gbpa_update(SMMUv3State *s)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    Error *local_err = NULL;
> +    SMMUViommu *vsmmu;
> +    uint32_t hwpt_id;
> +
> +    if (!s->accel || !s->s_accel->vsmmu) {
> +        return;
> +    }
> +
> +    vsmmu = s->s_accel->vsmmu;
> +    /*
> +     * The Linux kernel does not allow configuring GBPA MemAttr, MTCFG,
> +     * ALLOCCFG, SHCFG, PRIVCFG, or INSTCFG fields for a vSTE. Host kernel
> +     * has final control over these parameters. Hence, use one of the
> +     * pre-allocated HWPTs depending on GBPA.ABORT value.
> +     */
> +    if (s->gbpa & SMMU_GBPA_ABORT) {
> +        hwpt_id = vsmmu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = vsmmu->bypass_hwpt_id;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &vsmmu->device_list, next) {
v4 has this, while v5 removes it.
             if (!accel_dev->vdev)
                continue;

So I got a warning when accel_dev->vdev = NULL in the beginning.
"Failed to attach GBPA hwpt id xx for dev id xx"

Thanks

