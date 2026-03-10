Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCF7FCC9CF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzrBG-0001pd-1e; Tue, 10 Mar 2026 03:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrBE-0001oz-3E
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:07:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzrBB-0001FB-KR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773126416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K71luOn2wKaYkqvOibD8RcVwEiYVYuDg9flxuFRt1+c=;
 b=JYBebZUEZXE4xgwZY+qIxpvv+JiJKohRSF+RPnA3USWxO1lJ3VLTaBdJPZW681gtJo/8M7
 hgovb/0LvLb4+xQbac++dOPF4eQ4fWf8G33VCNuI6eklJiwvLMhi4eLiDSp74Y/IHA8XzU
 oVwVtnyNii7hc8TCSdfkNXUY5CsjgAI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-mf0IAocWMLOVFzsDu1HtJA-1; Tue,
 10 Mar 2026 03:06:53 -0400
X-MC-Unique: mf0IAocWMLOVFzsDu1HtJA-1
X-Mimecast-MFC-AGG-ID: mf0IAocWMLOVFzsDu1HtJA_1773126412
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C01D81956052; Tue, 10 Mar 2026 07:06:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 165971800759; Tue, 10 Mar 2026 07:06:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5ACD021E681B; Tue, 10 Mar 2026 08:06:48 +0100 (CET)
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
Subject: Re: [RFC PATCH 4/8] hw/arm/smmuv3-accel: Introduce _AUTO support
 for RIL
In-Reply-To: <20260309192119.870186-5-nathanc@nvidia.com> (Nathan Chen's
 message of "Mon, 9 Mar 2026 12:21:15 -0700")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-5-nathanc@nvidia.com>
Date: Tue, 10 Mar 2026 08:06:48 +0100
Message-ID: <87ldg0noxj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
> Allow accelerated SMMUv3 Range Invalidation support property to be
> derived from host IOMMU capabilities. Derive host values using
> IOMMU_GET_HW_INFO, retrieving RIL capability from IDR3.
>
> Set the default value of RIL to auto. The default for RIL support used
> to be set to on, but we change it to match what the host IOMMU
> properties report so that users do not have to introspect host IDR3 for
> Range Invalidation support. The RIL support needs to be compatible with
> host SMMUv3 if accelerated mode is enabled.
>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 20 +++++++++++++++++---
>  hw/arm/smmuv3.c         |  4 ++--
>  include/hw/arm/smmuv3.h |  2 +-
>  3 files changed, 20 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 8fec335557..02e3f7a9f3 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -58,6 +58,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>                                 FIELD_EX32(info->idr[0], IDR0, ATS));
>      }
>  
> +    /* Update RIL if auto from info */
> +    if (s->ril == ON_OFF_AUTO_AUTO) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL,
> +                               FIELD_EX32(info->idr[3], IDR3, RIL));
> +    }
> +
>      accel->auto_finalised = true;
>  }
>  
> @@ -854,8 +860,15 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>          return;
>      }
>  
> -    /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
> -    s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +    /*
> +     * Only override RIL if user explicitly set ON or OFF.
> +     * AUTO will be resolved later when host info is available.
> +     */
> +    if (s->ril == ON_OFF_AUTO_ON) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
> +    } else if (s->ril == ON_OFF_AUTO_OFF) {
> +        s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 0);
> +    }
>  
>      /* Only override ATS if user explicitly set ON or OFF */
>      if (s->ats == ON_OFF_AUTO_ON) {
> @@ -941,7 +954,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>      bs->iommu_ops = &smmuv3_accel_ops;
>      smmuv3_accel_as_init(s);
>  
> -    if (s->ats == ON_OFF_AUTO_AUTO) {
> +    if (s->ats == ON_OFF_AUTO_AUTO ||
> +        s->ril == ON_OFF_AUTO_AUTO) {
>          s->s_accel->auto_mode = true;
>      }
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 197ba7c77b..7791e5294d 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1973,7 +1973,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>  #endif
>  
>      if (!s->accel) {
> -        if (!s->ril) {
> +        if (s->ril == ON_OFF_AUTO_OFF) {
>              error_setg(errp, "ril can only be disabled if accel=on");
>              return false;
>          }
> @@ -2133,7 +2133,7 @@ static const Property smmuv3_properties[] = {
>      /* GPA of MSI doorbell, for SMMUv3 accel use. */
>      DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>      /* RIL can be turned off for accel cases */
> -    DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),

Is property "ril" accessible via QMP or JSON command line?  If yes, this
is an incompatible change: JSON values false and true no longer work.

>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>      DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>      DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 2ca49ded36..9124bfe751 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -69,7 +69,7 @@ struct SMMUv3State {
>      struct SMMUv3AccelState *s_accel;
>      uint64_t msi_gpa;
>      Error *migration_blocker;
> -    bool ril;
> +    OnOffAuto ril;
>      OnOffAuto ats;
>      uint8_t oas;
>      uint8_t ssidsize;


