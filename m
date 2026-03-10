Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41BCFCC9CF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 07:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzr5S-0007r2-NB; Tue, 10 Mar 2026 03:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzr5Q-0007qh-6d
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:01:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vzr5L-0008MI-Rw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 03:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773126050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LlgN/BS5FvGEHxaqk6DduvK16zZTLoOwg7OzhAnmbgM=;
 b=JvGcx7e8E6rWFjoTgyvLjkuO3ldmBt6yLmeij2EQCwra0jzo3qneXILyK+x906vKIDl8N9
 8eUxbADGIjnXBoiRygAg2ybMSNZLN5zVxZZHYQ3roEH1v1YadsBnaJYFlw/uOEdC9eI6P1
 +EwaP8IN9anXfyskXF1hVmOopDtcx9Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-QQ3DniiLP1ysgPfcqq3pIQ-1; Tue,
 10 Mar 2026 03:00:46 -0400
X-MC-Unique: QQ3DniiLP1ysgPfcqq3pIQ-1
X-Mimecast-MFC-AGG-ID: QQ3DniiLP1ysgPfcqq3pIQ_1773126045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 633221956095; Tue, 10 Mar 2026 07:00:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B6E31800759; Tue, 10 Mar 2026 07:00:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8933921E6614; Tue, 10 Mar 2026 08:00:40 +0100 (CET)
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
 <eblake@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>
Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
In-Reply-To: <20260309192119.870186-2-nathanc@nvidia.com> (Nathan Chen's
 message of "Mon, 9 Mar 2026 12:21:12 -0700")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>
Date: Tue, 10 Mar 2026 08:00:40 +0100
Message-ID: <87tsuonp7r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
> Introduce smmuv3_accel_auto_finalise() to resolve properties
> that are set to 'auto' for accelerated SMMUv3. This helper
> function allows properties such as ATS, RIL, SSIDSIZE, and OAS
> support to be resolved from host IOMMU values, while avoiding
> triggering auto-resolved values for hot-plugged devices.
>
> Auto mode requires at least one cold-plugged device to retrieve
> and finalise these properties, and we fail boot if that is not
> the case.
>
> Subsequent patches will make use of this helper to set the
> values when we convert the values to OnOffAuto. New auto_mode
> and auto_finalised bool members are added to SMMUv3AccelState.
> smmuv3_accel_init() will set auto_mode to true when 'auto' is
> detected for the accel SMMUv3 properties.
> smmuv3_accel_auto_finalise() will set auto_finalised to true
> after all 'auto' properties are resolved, and subsequent
> calls to this function will return early if auto_finalised is
> set to true.
>
> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++-----
>  hw/arm/smmuv3-accel.h |  2 ++
>  2 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 17306cd04b..617629bacd 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
>      return map[oas];
>  }
>  
> +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
> +    SMMUv3AccelState *accel = s->s_accel;
> +
> +    /* Return if no auto for any or finalised already */
> +    if (!accel->auto_mode || accel->auto_finalised) {
> +        return;
> +    }
> +
> +    /* We can't update if device is hotplugged */
> +    if (DEVICE(pdev)->hotplugged) {
> +        warn_report("arm-smmuv3: 'auto' feature property detected, but host "
> +                    "value cannot be applied for hot-plugged device; using "
> +                    "existing value");

Why is this warning useful?

Does @auto's meaning depend on whether the device is cold- or
hot-plugged?

> +        return;
> +    }
> +
> +    accel->auto_finalised = true;
> +}
> +
>  static bool
>  smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>                                   struct iommu_hw_info_arm_smmuv3 *info,
> +                                 PCIDevice *pdev,
>                                   Error **errp)
>  {
> +    smmuv3_accel_auto_finalise(s, pdev, info);
> +
>      /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>      if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>                  FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
> @@ -124,7 +147,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>  
>  static bool
>  smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
> -                           Error **errp)
> +                           PCIDevice *pdev, Error **errp)
>  {
>      struct iommu_hw_info_arm_smmuv3 info;
>      uint32_t data_type;
> @@ -142,7 +165,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          return false;
>      }
>  
> -    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
> +    if (!smmuv3_accel_check_hw_compatible(s, &info, pdev, errp)) {
>          return false;
>      }
>      return true;
> @@ -595,6 +618,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>      SMMUv3State *s = ARM_SMMUV3(bs);
>      SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>      SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>  
>      if (!idev) {
>          return true;
> @@ -613,7 +637,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       * Check the host SMMUv3 associated with the dev is compatible with the
>       * QEMU SMMUv3 accel.
>       */
> -    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
> +    if (!smmuv3_accel_hw_compatible(s, idev, pdev, errp)) {
>          return false;
>      }
>  
> @@ -867,8 +891,12 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp)
>  
>  void smmuv3_accel_reset(SMMUv3State *s)
>  {
> -     /* Attach a HWPT based on GBPA reset value */
> -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
> +    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel->auto_finalised) {
> +        error_report("AUTO mode specified but properties not finalised.");
> +        exit(1);

How can we get here?

> +    }
> +    /* Attach a HWPT based on GBPA reset value */
> +    smmuv3_accel_attach_gbpa_hwpt(s, NULL);
>  }
>  
>  static void smmuv3_accel_as_init(SMMUv3State *s)
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index dba6c71de5..3c1cd55714 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> +    bool auto_mode;
> +    bool auto_finalised;
>  } SMMUv3AccelState;
>  
>  typedef struct SMMUS1Hwpt {


