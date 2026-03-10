Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EB2FCC9D3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrPh-0004qy-JN; Tue, 10 Mar 2026 03:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrPc-0004q6-1C
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrPZ-00047D-VX
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773127308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O02Wyl+0Aft9GaqZwMYgSewXjhEOpofNIUsajqoOdB0=;
 b=Y9McQwnGKMJiJqlhkrJS+kbiO2m49hgm3+0yMRHD907H0HbC/SgKHyQl4AtKGHN1TXK/th
 uQFKIosi1TUbRy8EwZFODMmeYMDMl9K0qA9L/xhe54DAm7EXbm882vGaAqd+f1+87aAFAT
 v4pv5S7QybW2J/MghC5TljohZ+TlP0Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-3UzFFgF-NRSyg_5ruqPGyg-1; Tue,
 10 Mar 2026 03:21:45 -0400
X-MC-Unique: 3UzFFgF-NRSyg_5ruqPGyg-1
X-Mimecast-MFC-AGG-ID: 3UzFFgF-NRSyg_5ruqPGyg_1773127304
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005C71800561; Tue, 10 Mar 2026 07:21:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EC9419560A6; Tue, 10 Mar 2026 07:21:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A2FD521E681B; Tue, 10 Mar 2026 08:21:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Yi Liu
 <yi.l.liu@intel.com>,  Eric Auger <eric.auger@redhat.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 6/8] hw/arm/smmuv3-accel: Introduce _AUTO support
 for SSID size
In-Reply-To: <20260309192119.870186-7-nathanc@nvidia.com> (Nathan Chen's
 message of "Mon, 9 Mar 2026 12:21:17 -0700")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-7-nathanc@nvidia.com>
Date: Tue, 10 Mar 2026 08:21:40 +0100
Message-ID: <87bjgwno8r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Nathan Chen <nathanc@nvidia.com> writes:

> From: Nathan Chen <nathanc@nvidia.com>
>
> Allow accelerated SMMUv3 SSID size property to be derived from host
> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
> retrieving SSID size from IDR1.
>
> Set the default ssidsize value to auto. The default SSID size used
> to be 0, but we change it to match what the host IOMMU properties
> report so that users do not have to introspect host IDR1 for the
> Substream ID support. When the auto SSID size is resolved to a
> non-zero value, PASID capability is advertised to the vIOMMU and
> accelerated use cases such as Shared Virtual Addressing (SVA) are
> supported.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 30 +++++++++++++++++++++++++++---
>  hw/arm/smmuv3.c         | 16 ++++++----------
>  include/hw/arm/smmuv3.h |  3 ++-
>  3 files changed, 35 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 02e3f7a9f3..bd27b0da7c 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -64,6 +64,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>                                 FIELD_EX32(info->idr[3], IDR3, RIL));
>      }
>  
> +    /* Update SSIDSIZE if auto from info */
> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
> +        /* Store for get_viommu_flags() to determine PASID support */
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -839,7 +846,10 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>      SMMUState *bs = opaque;
>      SMMUv3State *s = ARM_SMMUV3(bs);
>  
> -    if (s->ssidsize) {
> +    if ((s->ssidsize != SSID_SIZE_MODE_0 &&
> +         s->ssidsize != SSID_SIZE_MODE_AUTO) ||
> +        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
> +         FIELD_EX32(s->idr[1], IDR1, SSIDSIZE))) {
>          flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>      }
>      return flags;
> @@ -854,6 +864,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>  };
>  
> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
> +{
> +    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
> +    /* SSID_SIZE_MODE_AUTO = 0 */
> +    if (mode == SSID_SIZE_MODE_AUTO) {
> +        return 0;
> +    }
> +    return mode - 1;  /* Enum values are offset by 1 from actual values */

This relies on how the enum values are ordered in the schema, and on how
the QAPI generator encodes enums.  The latter is fine: we document it in
docs/devel/qapi-code-gen.rst section "Enumeration types".  The former is
worth a non-doc comment in the schema, like this:

   { 'enum': 'SsidSizeMode',
     'data': [ 'auto', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
               '10', '11', '12', '13', '14', '15', '16', '17', '18',
               '19', '20' ] } # order matters, see ssid_size_mode_auto()


> +}
> +
>  void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>      if (!s->accel) {
> @@ -886,7 +906,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>       * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
>       * has enabled it.
>       */
> -    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
> +    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
> +                               ssidsize_mode_to_value(s->ssidsize));
> +    }
>  }
>  
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
> @@ -955,7 +978,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>      smmuv3_accel_as_init(s);
>  
>      if (s->ats == ON_OFF_AUTO_AUTO ||
> -        s->ril == ON_OFF_AUTO_AUTO) {
> +        s->ril == ON_OFF_AUTO_AUTO ||
> +        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7791e5294d..bc03353759 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -20,6 +20,7 @@
>  #include "qemu/bitops.h"
>  #include "hw/core/irq.h"
>  #include "hw/core/sysbus.h"
> +#include "hw/core/qdev-properties-system.h"
>  #include "migration/blocker.h"
>  #include "migration/vmstate.h"
>  #include "hw/core/qdev-properties.h"
> @@ -626,7 +627,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>      }
>  
>      /* Multiple context descriptors require SubstreamID support */
> -    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
> +    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
>          qemu_log_mask(LOG_UNIMP,
>                  "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
>                  "Configure ssidsize > 0 (requires accel=on)\n");
> @@ -1985,7 +1986,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> -        if (s->ssidsize) {
> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>              error_setg(errp, "ssidsize can only be set if accel=on");
>              return false;
>          }
> @@ -2003,11 +2004,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "OAS can only be set to 44 or 48 bits");
>          return false;
>      }
> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
> -                   SMMU_SSID_MAX_BITS);
> -        return false;
> -    }
>  
>      return true;
>  }
> @@ -2136,7 +2132,8 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
> +                              SSID_SIZE_MODE_AUTO),

Is property "ssidsize" accessible via QMP or JSON command line?  If yes,
this is an incompatible change: JSON integer values no longer work.

>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> @@ -2176,8 +2173,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>          "Valid range is 0-20, where 0 disables SubstreamID support. "
> -        "Defaults to 0. A value greater than 0 is required to enable "
> -        "PASID support.");
> +        "A value greater than 0 is required to enable PASID support.");
>  }
>  
>  static int smmuv3_notify_flag_changed(IOMMUMemoryRegion *iommu,
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 9124bfe751..ae8158a5c3 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -21,6 +21,7 @@
>  
>  #include "hw/arm/smmu-common.h"
>  #include "qom/object.h"
> +#include "qapi/qapi-types-misc-arm.h"
>  
>  #define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
>  
> @@ -72,7 +73,7 @@ struct SMMUv3State {
>      OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
> -    uint8_t ssidsize;
> +    SsidSizeMode ssidsize;
>  };
>  
>  typedef enum {


