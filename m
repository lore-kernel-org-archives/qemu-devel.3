Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21050EB7ED0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 11:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxkMW-0001NY-F5; Wed, 04 Mar 2026 06:25:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkMT-0001NB-Ur
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:25:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vxkMP-0001ve-6d
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 06:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772623546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Kg9Li6auaa/cgkLVQT4e1/3Ds48a5/P4KHt0CaSUjo=;
 b=Tm7jvxtFPf2tUwh56Egwcghd5InK12pev41ZrFNgABUVtCaLXnSv21L4jJU/8KngG+D4ao
 3/q4gaU/i1GQTXMBXj6a/Il7n9v4HZv8+S2wkjbDgkWSBZlNLrgK6afSZdvW7zx35lc8OK
 cAWU7sRpySo2LqvS1kIay8/LHMZ+aYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-Un5Kh1LuNNeXYaI8bNviyQ-1; Wed, 04 Mar 2026 06:25:45 -0500
X-MC-Unique: Un5Kh1LuNNeXYaI8bNviyQ-1
X-Mimecast-MFC-AGG-ID: Un5Kh1LuNNeXYaI8bNviyQ_1772623545
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so73190475e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 03:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772623544; x=1773228344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Kg9Li6auaa/cgkLVQT4e1/3Ds48a5/P4KHt0CaSUjo=;
 b=Hw0HRrkFvzhRBACX0gTfJT/Zon8czsLldbxsKjmWJvr5bT2ogOi1OvCZjgjiTPHwNe
 wli3Vq6ejmua6/4QW/uokISKaAzH1wsoqf1e3LaSm7rMHolz/axwzzD+uLKRcKXi/GVF
 veD8FTK4JTSMi9lysiMR4JJl2mEgM7k8n67d4euSewfO15bmOAT2hNNI0eVnbQYZ2evE
 DQ6J69yPrXLip+66RgwBUMF8l2nPpSqdQRrkvpedwe1SQubum5yLF5Z+2uz4ByyVBh3W
 19uYhKy74rpcHadCu8yAAKnbflwiNHCmwg3zfDpkNpulxYhT4Z6RLEKCAWEMA8nKZBRE
 tqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772623544; x=1773228344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Kg9Li6auaa/cgkLVQT4e1/3Ds48a5/P4KHt0CaSUjo=;
 b=Qom/RMOxEaK5920RpuOlC0ZCihpQAsYwLaNBdTopBe54iLrU2TZPxoLeAmq00u2dcc
 VaFuDUJAC2OIQ2h/82XEUb8ulBbcVjtreDecNSRwCtHF/ULQGETHnug2hPexqRV1t99U
 57c4LWB5JTBSibCUvspc747hKRead3rTaqowGpFw/q4CQpNL0qYy3mEaGVnF3cKafNS8
 /M5qnGk6tLhWaLZ7Ero2sFvFwnR5eWa9UHNft3UpWZBCJyWvWL8Q2xLw76X+HkzvyuOW
 RssyKmfsh/Xwb2zyy/AHaTfX0nfOBPURssSvQtQFiEuCQT5tsfL++gutDMC5IyiXZ6pk
 e2oQ==
X-Gm-Message-State: AOJu0Yx+/4fEUUvVorKcsULm5Bh2g5dHZkwxokpD8Qp2RAEBnYSNSdMZ
 iyyEPhKqXfQIhtNnxpnfcfe2fjOEM8mXYnQkwRrVHlnqIlc3lyrBkqaGaTPj+w0HI9MHDEEj2T1
 hqzOLk0YPCfVM+0hIiGvNDR/MBrCzn1lPG+6PZQexm6kl3SkujlaHWWl8
X-Gm-Gg: ATEYQzxSKDAtYsJ8eeySQ7IQNcpG1msQNtuklBEgPpnoR6FixxmJSlKKXDMzMVTAJZ9
 NSOw2iwaLOX4mbikrqQZbgCmOzuUk6gSymnL8X9ly6xRVd8oUnpmPF6EYudDt3IPaUJwr3NoIjS
 TzO6crr5s68t7NLcKvH44Wf0JoEDFDvuApLnuwBXVBtKW54VZKDOtPb0GebtORHz3JembYTEZOR
 1s+sRaghR+yP+YS1Pbb+o8gcFu7A/5qb7tZXVe/ovHXt09Mvwhqy7GpcHnnpj/aEKAimyV+l9uo
 YLlJZsmi1AX+jlWmiJbDSWIxh9qilx6PawQ/Y5FQPE+35f1DtXxBt9lElwgTiaIjt4ovEbzuMqW
 imY/Rgw==
X-Received: by 2002:a05:600c:4e16:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-485198992eemr25921905e9.27.1772623544543; 
 Wed, 04 Mar 2026 03:25:44 -0800 (PST)
X-Received: by 2002:a05:600c:4e16:b0:47e:e946:3a72 with SMTP id
 5b1f17b1804b1-485198992eemr25921515e9.27.1772623544070; 
 Wed, 04 Mar 2026 03:25:44 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a25dsm41394260f8f.21.2026.03.04.03.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 03:25:43 -0800 (PST)
Date: Wed, 4 Mar 2026 12:25:41 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Jason Wang
 <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>, =?UTF-8?B?Q2zDqW1l?=
 =?UTF-8?B?bnQ=?= Mathieu--Drif <clement.mathieu--drif@eviden.com>, Fabiano
 Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 15/16] hw/i386/x86-iommu: Remove
 X86IOMMUState::pt_supported field
Message-ID: <20260304122541.71f4bfec@imammedo>
In-Reply-To: <20260225092024.794595-16-thuth@redhat.com>
References: <20260225092024.794595-1-thuth@redhat.com>
 <20260225092024.794595-16-thuth@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 25 Feb 2026 10:20:23 +0100
Thomas Huth <thuth@redhat.com> wrote:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
> The X86IOMMUState::pt_supported boolean was only set in
> the hw_compat_2_9[] array, via the 'pt=3Doff' property. We
> removed all machines using that array, lets remove that
> property and all the code around it, always setting the
> VTD_ECAP_PT capability.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20250501210456.89071-19-philmd@linaro.org>
> [thuth: Dropped the hunks that were already merged via commit 31753d5a336=
f]
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/x86-iommu.h |  1 -
>  hw/i386/intel_iommu.c       | 13 ++-----------
>  hw/i386/x86-iommu.c         |  1 -
>  3 files changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
> index c526a047ab6..0a1e1ba7257 100644
> --- a/include/hw/i386/x86-iommu.h
> +++ b/include/hw/i386/x86-iommu.h
> @@ -63,7 +63,6 @@ struct X86IOMMUState {
>      SysBusDevice busdev;
>      OnOffAuto intr_supported;   /* Whether vIOMMU supports IR */
>      bool dt_supported;          /* Whether vIOMMU supports DT */
> -    bool pt_supported;          /* Whether vIOMMU supports pass-through =
*/
>      bool dma_translation;       /* Whether vIOMMU supports DMA translati=
on */
>      QLIST_HEAD(, IEC_Notifier) iec_notifiers; /* IEC notify list */
>  };
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 4924aa43750..d24ba989bfc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1072,6 +1072,7 @@ static inline bool vtd_ce_type_check(X86IOMMUState =
*x86_iommu,
>  {
>      switch (vtd_ce_get_type(ce)) {
>      case VTD_CONTEXT_TT_MULTI_LEVEL:
> +    case VTD_CONTEXT_TT_PASS_THROUGH:
>          /* Always supported */
>          break;
>      case VTD_CONTEXT_TT_DEV_IOTLB:
> @@ -1080,12 +1081,6 @@ static inline bool vtd_ce_type_check(X86IOMMUState=
 *x86_iommu,
>              return false;
>          }
>          break;
> -    case VTD_CONTEXT_TT_PASS_THROUGH:
> -        if (!x86_iommu->pt_supported) {
> -            error_report_once("%s: PT specified but not supported", __fu=
nc__);
> -            return false;
> -        }
> -        break;
>      default:
>          /* Unknown type */
>          error_report_once("%s: unknown ce type: %"PRIu32, __func__,
> @@ -5004,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>  {
>      X86IOMMUState *x86_iommu =3D X86_IOMMU_DEVICE(s);
> =20
> -    s->cap =3D VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
> +    s->cap =3D VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
>               VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS |
>               VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
>      if (s->dma_drain) {
> @@ -5032,10 +5027,6 @@ static void vtd_cap_init(IntelIOMMUState *s)
>          s->ecap |=3D VTD_ECAP_DT;
>      }
> =20
> -    if (x86_iommu->pt_supported) {
> -        s->ecap |=3D VTD_ECAP_PT;
> -    }
> -
>      if (s->caching_mode) {
>          s->cap |=3D VTD_CAP_CM;
>      }
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 33ac0bfc97e..a57445404ef 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -129,7 +129,6 @@ static const Property x86_iommu_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("intremap", X86IOMMUState,
>                              intr_supported, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
> -    DEFINE_PROP_BOOL("pt", X86IOMMUState, pt_supported, true),
>      DEFINE_PROP_BOOL("dma-translation", X86IOMMUState, dma_translation, =
true),
>  };
> =20


