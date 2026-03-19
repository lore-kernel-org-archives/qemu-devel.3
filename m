Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8ED108E1FA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3CMl-0004BO-CZ; Thu, 19 Mar 2026 08:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CMb-00049l-2E
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:20:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w3CMY-0007Ma-Lv
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 08:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773922822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lPyLzjM04jrJCwQfrtZJHGFRNDMM1tE8bWEPRjxEumQ=;
 b=WCciBZDKJqHh3XzJ2YnLNUXKakew6Bt09qjt96wKfr8woby+5M08GIcBIPn5Q7dCX+EIog
 CPvNguIqnKryGHUv9uwN3eQVQJPUdfz21rT4o5mjOniZk7VYxJ32TpcjLO/vjo3F5i/Z+s
 LWZEDwZIrcHHo51Nf7wdlkLL5nEbPww=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-yysa13RzOkSmDbx_d4MHrA-1; Thu,
 19 Mar 2026 08:20:18 -0400
X-MC-Unique: yysa13RzOkSmDbx_d4MHrA-1
X-Mimecast-MFC-AGG-ID: yysa13RzOkSmDbx_d4MHrA_1773922817
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41C031944F11; Thu, 19 Mar 2026 12:20:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 862431955F21; Thu, 19 Mar 2026 12:20:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27DD221E6937; Thu, 19 Mar 2026 13:20:14 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Nathan Chen <nathanc@nvidia.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Eric Auger
 <eric.auger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Shannon Zhao
 <shannon.zhaosl@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,  Matt Ochs
 <mochs@nvidia.com>,  Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
In-Reply-To: <20260318184907.4060030-8-nathanc@nvidia.com> (Nathan Chen's
 message of "Wed, 18 Mar 2026 11:49:06 -0700")
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-8-nathanc@nvidia.com>
Date: Thu, 19 Mar 2026 13:20:14 +0100
Message-ID: <87pl5080zl.fsf@pond.sub.org>
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
> Change accel SMMUv3 OAS property from uint8_t to OasMode. The

Incompatible change; okay because property "oas" is new in this
release.  Spelling out such things out in the commit message helps
reviewers.  Not worth a respin by itself.

> 'auto' value is not implemented, as this commit is meant to
> set the property to the correct type and avoid breaking JSON/QMP
> when the auto mode is introduced. A future patch will implement
> resolution of 'auto' value to match the host SMMUv3 OAS value.
>
> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c          |  2 +-
>  hw/arm/smmuv3.c                | 16 ++++++++--------
>  include/hw/arm/smmuv3-common.h |  2 --
>  include/hw/arm/smmuv3.h        |  2 +-
>  4 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index bc6cbfebc2..65c2f44880 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      }
>  
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
> -    if (s->oas == SMMU_OAS_48BIT) {
> +    if (s->oas == OAS_MODE_48) {
>          s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>      }
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 79018f8d66..c67819d6f2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "ssidsize auto mode is not supported");
>          return false;
>      }
> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +        return false;
> +    }

So, OasMode values other than 44 and 48 are currently useless.  Correct?

>  
>      if (!s->accel) {
>          if (s->ril == ON_OFF_AUTO_OFF) {
> @@ -1994,7 +1998,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> -        if (s->oas != SMMU_OAS_44BIT) {
> +        if (s->oas > OAS_MODE_44) {
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> @@ -2012,11 +2016,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> -    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
> -        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> -        return false;
> -    }
> -
>      return true;
>  }
>  
> @@ -2143,7 +2142,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_0),
>  };
> @@ -2180,7 +2179,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "supported.");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=on). Supported values "
> -        "are 44 or 48 bits. Defaults to 44 bits");
> +        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
> +        "supported.");
>      object_class_property_set_description(klass, "ssidsize",
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 7f0f992dfd..4609975edf 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -342,8 +342,6 @@ REG32(IDR5,                0x14)
>       FIELD(IDR5, VAX,        10, 2);
>       FIELD(IDR5, STALL_MAX,  16, 16);
>  
> -#define SMMU_OAS_44BIT 44
> -#define SMMU_OAS_48BIT 48
>  #define SMMU_IDR5_OAS_44 4
>  #define SMMU_IDR5_OAS_48 5
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ddf472493d..82f18eb090 100644
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


Acked-by: Markus Armbruster <armbru@redhat.com>


