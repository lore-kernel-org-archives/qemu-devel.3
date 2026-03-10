Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF6CFCC9D3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrRW-0005kS-7q; Tue, 10 Mar 2026 03:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrRT-0005k8-8J
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrRR-0004Pe-Ea
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773127423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQ/DK9I8wwaR1/tl3MlWnqlXr2DL+8ujjmElTR1DkuE=;
 b=IG/12qH7Eyg7tG1XTNioa8KXYCPPN2SznjxIGStZgzZdHanYt+zjQuJixLKcXte8ogqlHA
 XwbrViIR+zT0IuYoVDZx7Pe4usCGqolruoHjums+/55EKDeZDpK2gqT931b/hBlFdikovW
 xG0dHFz6acb49giey2uPq9mTiBAy3QM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-AvZ2Zym3OfGeh0KCpQl2zg-1; Tue,
 10 Mar 2026 03:23:40 -0400
X-MC-Unique: AvZ2Zym3OfGeh0KCpQl2zg-1
X-Mimecast-MFC-AGG-ID: AvZ2Zym3OfGeh0KCpQl2zg_1773127419
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24B1319560B3; Tue, 10 Mar 2026 07:23:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C81F30001A2; Tue, 10 Mar 2026 07:23:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DCBD521E6614; Tue, 10 Mar 2026 08:23:35 +0100 (CET)
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
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC PATCH 8/8] hw/arm/smmuv3-accel: Introduce _AUTO support
 for OAS
In-Reply-To: <20260309192119.870186-9-nathanc@nvidia.com> (Nathan Chen's
 message of "Mon, 9 Mar 2026 12:21:19 -0700")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-9-nathanc@nvidia.com>
Date: Tue, 10 Mar 2026 08:23:35 +0100
Message-ID: <877brkno5k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
> OAS from IDR5.
>
> Set the default oas value to auto. The default Output Address Size used
> to be 44-bit, but we change it to match what the host IOMMU properties
> report so that users do not have to introspect host IDR5 for the OAS.
> This keeps the OAS value advertised by the virtual SMMU compatible with
> the capabilities of the host SMMUv3, so that the intermediate physical
> addresses (IPA) consumed by host SMMU for stage-2 translation do not
> exceed the host's max supported IPA size.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 11 +++++++++--
>  hw/arm/smmuv3.c         | 11 ++++++-----
>  include/hw/arm/smmuv3.h |  2 +-
>  3 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index bd27b0da7c..03950a4cef 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -71,6 +71,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>                                 FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>      }
>  
> +    /* Update OAS if auto from info */
> +    if (s->oas == OAS_MODE_AUTO) {
> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
> +                               FIELD_EX32(info->idr[5], IDR5, OAS));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -898,7 +904,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      }
>  
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
> -    if (s->oas == SMMU_OAS_48BIT) {
> +    if (s->oas == OAS_MODE_48) {
>          s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>      }
>  
> @@ -979,7 +985,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>  
>      if (s->ats == ON_OFF_AUTO_AUTO ||
>          s->ril == ON_OFF_AUTO_AUTO ||
> -        s->ssidsize == SSID_SIZE_MODE_AUTO) {
> +        s->ssidsize == SSID_SIZE_MODE_AUTO ||
> +        s->oas == OAS_MODE_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index bc03353759..4fc4ed2c06 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1982,7 +1982,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> -        if (s->oas != SMMU_OAS_44BIT) {
> +        if (s->oas > OAS_MODE_44) {
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> @@ -2000,8 +2000,9 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> -    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
> -        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +    if (s->oas != OAS_MODE_AUTO && s->oas != OAS_MODE_44 &&
> +        s->oas != OAS_MODE_48) {
> +        error_setg(errp, "OAS can only be set to auto, 44 bits, or 48 bits");
>          return false;
>      }
>  
> @@ -2131,7 +2132,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> -    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),


Is property "oas" accessible via QMP or JSON command line?  If yes, this
is an incompatible change: JSON integer values no longer work.

>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_AUTO),
>  };
> @@ -2168,7 +2169,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "platform has ATS support before enabling this");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=on). Supported values "
> -        "are 44 or 48 bits. Defaults to 44 bits");
> +        "are 44 or 48 bits.");
>      object_class_property_set_description(klass, "ssidsize",
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ae8158a5c3..3bfee63396 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -72,7 +72,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      OnOffAuto ril;
>      OnOffAuto ats;
> -    uint8_t oas;
> +    OasMode oas;
>      SsidSizeMode ssidsize;
>  };


