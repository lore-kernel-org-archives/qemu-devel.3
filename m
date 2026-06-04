Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4209BCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6bm-0001Kk-7i; Thu, 04 Jun 2026 07:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6bk-0001KU-7V
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:51:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6bi-0007fM-G9
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 07:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780573889;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdmReCAJNUtqEix/n4fG+YTi+9S85Iwj4f30F/ixVIU=;
 b=T3tjZ+fxUDgyR3dUGULS401f3su8MySv0mCAQClZNhwyqy5YIJhOTvQcihM8Po/Sjq59sq
 NhB0u3hd3Zrhk2a6t5ImzD2QmAV1tCyssX/ssQdtOmyxUkTEnqc6K2j9v8E/w4rsGO7omS
 1Gdv1mb1kuvj805syjL7N6k8ACsk/AU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-BeoQGOhjPs-rw27je5yJ8g-1; Thu, 04 Jun 2026 07:51:26 -0400
X-MC-Unique: BeoQGOhjPs-rw27je5yJ8g-1
X-Mimecast-MFC-AGG-ID: BeoQGOhjPs-rw27je5yJ8g_1780573885
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490afe64f26so2853065e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 04:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573885; x=1781178685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdmReCAJNUtqEix/n4fG+YTi+9S85Iwj4f30F/ixVIU=;
 b=aLOG34mIk6Rwl31aTjG47+liSjy8SSydXov5mxz387vojkmtjV6rvQ2Xd0imekndE1
 UXswsWs/XaB+0secrYKqWY1zeWji0EcN8CAm+ZSDOtYTB41qMGYw26tuUhWGO2euhpef
 kFCrgGbubpJBn2zGIVFg1ZltR2ZE6lFzZLbypFeDXcasqgzEFOeMwYqdyPxSd716LDjv
 o0kDlunfZEyiCprpFAP2K4WxuZjOT3+Ft2pIeU3LN5IgsBKoE0Vy6J8SFaCec6SQ2pmr
 KgbHXoMXnLXg1NUivv+BwbxQKTygMpzsy5eTsplClunn1ZPP1FG8Kj9SHf5GGmz7NQwJ
 7OZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8seorJ1D72mVBpIeB1KkpNJq/jpgJRCj+skRAACufi7UNCe6jF21FRVn3Hc5bpY9U+HZQikK892Qxg@nongnu.org
X-Gm-Message-State: AOJu0YzvX834ZZ7gfVJ365eYj0w6r2wTA5qk9TRXz6hzTJa5VCV6lkPP
 Nx2hdm6zKxdHrdGYjLTaVwurHjiJhgGMdZtE6ENh0TH6/HI59LNihAPrxSE/tUStQTIxvMJ53Eq
 jk2Xa4N/W1b3Z1rcndDUYJWrpIferRlOssM+hCIKkV4MOopQRgJ0u/B1U
X-Gm-Gg: Acq92OH/x8aF+7UN74Uytf7ZtTDqm8dGAXRsu6uu04TPb/msy9AIwLLDCJx1fXTgpmi
 AWYyMRAV4phHAAPc6NU4QqzGzeliE1Nfmq1BIrGdvd7G85SM/35FaMjvDrBHgw+k5cqvDniVyrB
 4VwT/ggQvqYFIqXK9OyZnqNJTcq38eUX0MULrbC3mCKxt5YTuUexyaLbH7rUkviAtH1YcgrJAEJ
 g3R5iKqaKahGjUrOkJILWnuRJ0nmqAY8Bmd8AyPZtXjqXChqy82HLKQ5mp0efRuof3533wIiWpL
 h/waoKjI+DrxFo3VB+vnUPnR+lWOrUZB3Ls7DZLPO5+2x2vrDFSXabdT9Syh7zCunZ2RFsKxz7R
 L9gSWub9nR/QJ02YiElbmqgS68x4ey8ru/VYXlEDuaAxpkpvp7lwr4fUPwyNwbAQt6TycEcw1J3
 RODT+Y
X-Received: by 2002:a05:600c:34d3:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490bc4cf867mr52346405e9.5.1780573884775; 
 Thu, 04 Jun 2026 04:51:24 -0700 (PDT)
X-Received: by 2002:a05:600c:34d3:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490bc4cf867mr52345905e9.5.1780573884409; 
 Thu, 04 Jun 2026 04:51:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7a273e3sm102509065e9.0.2026.06.04.04.51.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 04:51:23 -0700 (PDT)
Message-ID: <379a6953-e0a6-4c82-8446-ecdd24e19401@redhat.com>
Date: Thu, 4 Jun 2026 13:51:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 23/31] hw/arm/tegra241-cmdqv: Read and propagate
 Tegra241 CMDQV errors
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-24-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-24-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> Install an event handler on the CMDQV vEVENTQ fd to read and propagate
> host received CMDQV errors to the guest.
>
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/tegra241-cmdqv.c | 63 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events     |  1 +
>  2 files changed, 64 insertions(+)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index cdd4fa4f1a..d8b36164a1 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -14,6 +14,7 @@
>  
>  #include "hw/arm/smmuv3.h"
>  #include "hw/arm/smmuv3-common.h"
> +#include "hw/core/irq.h"
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  #include "trace.h"
> @@ -751,6 +752,51 @@ out:
>      trace_tegra241_cmdqv_write_mmio(offset, value, size);
>  }
>  
> +static void tegra241_cmdqv_event_read(void *opaque)
> +{
> +    Tegra241CMDQV *cmdqv = opaque;
> +    IOMMUFDVeventq *veventq = cmdqv->veventq;
> +    struct {
> +        struct iommufd_vevent_header hdr;
> +        struct iommu_vevent_tegra241_cmdqv vevent;
> +    } buf;
> +    Error *local_err = NULL;
> +
> +    if (!smmuv3_accel_event_read_validate(veventq,
> +                                          IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
> +                                          &buf, sizeof(buf), &local_err)) {
> +        warn_report_err_once(local_err);
> +        return;
> +    }
> +
> +    if (buf.vevent.lvcmdq_err_map[0] || buf.vevent.lvcmdq_err_map[1]) {
> +        cmdqv->vintf_cmdq_err_map[0] =
> +            extract64(buf.vevent.lvcmdq_err_map[0], 0, 32);
> +        cmdqv->vintf_cmdq_err_map[1] =
> +            extract64(buf.vevent.lvcmdq_err_map[0], 32, 32);
> +        cmdqv->vintf_cmdq_err_map[2] =
> +            extract64(buf.vevent.lvcmdq_err_map[1], 0, 32);
> +        cmdqv->vintf_cmdq_err_map[3] =
> +            extract64(buf.vevent.lvcmdq_err_map[1], 32, 32);
> +        /*
> +         * CMDQV_CMDQ_ERR_MAP and VINTF0_LVCMDQ_ERR_MAP are distinct
> +         * registers (different MMIO offsets). With only VINTF0 exposed
> +         * they carry the same data, so mirror.
> +         */
> +        for (int i = 0; i < 4; i++) {
> +            cmdqv->cmdq_err_map[i] = cmdqv->vintf_cmdq_err_map[i];
> +        }
> +        /* Set the VINTF0 bit in VI_ERR_MAP_0 (only VINTF0 is exposed). */
> +        cmdqv->vi_err_map[0] |= BIT(0);
> +        if (!(cmdqv->vi_int_mask[0] & BIT(0))) {
> +            qemu_irq_pulse(cmdqv->irq);
> +        }
> +        trace_tegra241_cmdqv_err_map(
> +            cmdqv->vintf_cmdq_err_map[3], cmdqv->vintf_cmdq_err_map[2],
> +            cmdqv->vintf_cmdq_err_map[1], cmdqv->vintf_cmdq_err_map[0]);
> +    }
> +}
> +
>  static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>  {
>      SMMUv3AccelState *accel = s->s_accel;
> @@ -762,6 +808,7 @@ static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
>          return;
>      }
>      if (veventq) {
> +        qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>          close(veventq->veventq_fd);
>          iommufd_backend_free_id(viommu->iommufd, veventq->veventq_id);
>          g_free(veventq);
> @@ -777,6 +824,7 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>      Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
>      uint32_t viommu_id, veventq_id, veventq_fd;
>      IOMMUFDVeventq *veventq;
> +    int flags;
>  
>      if (!iommufd_backend_alloc_viommu(idev->iommufd, idev->devid,
>                                        IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV,
> @@ -795,14 +843,29 @@ tegra241_cmdqv_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          goto free_viommu;
>      }
>  
> +    flags = fcntl(veventq_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg(errp, "Failed to get flags for vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +    if (fcntl(veventq_fd, F_SETFL, O_NONBLOCK | flags) < 0) {
> +        error_setg(errp, "Failed to set O_NONBLOCK on vEVENTQ fd");
> +        goto free_veventq;
> +    }
> +
>      veventq = g_new(IOMMUFDVeventq, 1);
>      veventq->veventq_id = veventq_id;
>      veventq->veventq_fd = veventq_fd;
>      cmdqv->veventq = veventq;
>  
> +    /* Set up event handler for veventq fd */
> +    qemu_set_fd_handler(veventq_fd, tegra241_cmdqv_event_read, NULL, cmdqv);
>      *out_viommu_id = viommu_id;
>      return true;
>  
> +free_veventq:
> +    close(veventq_fd);
> +    iommufd_backend_free_id(idev->iommufd, veventq_id);
>  free_viommu:
>      iommufd_backend_free_id(idev->iommufd, viommu_id);
>      return false;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index d76f408d8a..115f1add9d 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -75,6 +75,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
>  # tegra241-cmdqv
>  tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
>  tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
> +tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
>  tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64
>  tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page1 offset0: 0x%"PRIx64" val: 0x%"PRIx64
>  tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s page0 offset0: 0x%"PRIx64" val: 0x%"PRIx64


