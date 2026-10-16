Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2AACC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHhsk-000265-9C; Fri, 16 Oct 2026 09:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhsg-00025P-Pc
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xHhse-0007mS-Ef
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 09:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792156910;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nvNMJKy5hEsNmX3h2yw6AJYeXfgIvjlosnD74UtrqYM=;
 b=BrYRlfG7yJWVI5E0AdZYF550nXh/arP88upDLRpoRC4iunxcw+wtFHbPGqQoW3D1qWqKM7
 gFEWjm2zpJog2LAU5YLEgb7ETQTv2zF7P97dbqbIVqvBf4MPblumu77pI8W5ELM8m3aQEb
 L1AU/XYxHCrDJ69mGQ4A+UCJqvTgZVc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-jFkG6yp2PT-tnB862yAp3w-1; Fri, 16 Oct 2026 13:21:48 +0000
X-MC-Unique: jFkG6yp2PT-tnB862yAp3w-1
X-Mimecast-MFC-AGG-ID: jFkG6yp2PT-tnB862yAp3w_1792156908
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48dfdc0f491so364873f8f.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 06:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792156907; x=1792761707;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nvNMJKy5hEsNmX3h2yw6AJYeXfgIvjlosnD74UtrqYM=;
 b=san3YykmE2w/GMA1tXaW4JtD9pAcE8sXZU/H0GBz87XLhIO2+r8RDchtORuVNYYcSn
 s19LK/d3PDdU6wuKKW+6LaPcVVvMWRSWuOh3rdNK/thpuSuBpjwpYGRfZRmg/YIJwFPs
 COxVy7A/KsTspzTLg3uesdsdAbE+gd5VQ62F5GiN9cktqpzI8fFAwhCc8awfLc2/N6mM
 ORCFGF0/PuOJcx3cBK8iWVVzWnPnMa4bvxxBnGoc9jpP2sSyQbsH7xJe588JnNHyefWw
 XGeIa0cujNAuE7eESnel7JI/C1W0/ACPUYXAdtsusOCMnk/CuKi2nmTyeS46Ty5iGB7C
 P5pg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQxxXmRm87ldljtG+hXWPixACyqg0ipQHtAGotiuGu7tLnBoDzL9homPx0/o45Mu01ADfoi2TJ/UgT@nongnu.org
X-Gm-Message-State: AFq9FYLXQtcqgeZ9nVQHBACSgkcqb3drgABrqV6Ww1Hn3H++tKNWRr5U
 aY+CtTSRP0VnZUAff6l/1RTake9zZZXYvauDGvxvECrEQw/zV2kcX7FqjWVn+OjWZR+LdCmLzvV
 ATh7wQK/0FoD6M8r9pjGxTc3GSemWTzE7WWaOBPZEVWDHHsXbGq2KyqF4
X-Gm-Gg: AYBFou3zf6OmvU4l4Q7bboYEQu1Zrsf2p2rL9X979wxK6SUF4ynGz+UnHFHXT0PeuY3
 SsTn66InK+j1nwwrv0XaMhO/eKTMfwQaE9cjc0k8I2qNduSkyN8+mEcPbuSXmNwxrw+OGmsFFlY
 kVYo2OdR/ilFchR1datBV8Fc6mi2p0W5jrOFAG8fnq+p09+hLyhZ7vYoDDH80f7xEcGgEyYwAs5
 XslnAWnIdbQ9Ak0ueIfQCWLT6BWXJdQrWfdyJ7jP9OgmljDs9kzh9iv2LzbgsKjaU9N8LypnPtE
 5k1QNucgjfOXl1McT17sfNswYI6AmVA8unKr8/J3F/zazLl5FKy4ULQyy2XVQ1hZsG3ZDtyGsWi
 eagwrR59ckkmRUnpto8/nveGayvfRq1AQPpXSrZbxY7o1sxDX
X-Received: by 2002:a05:6000:4b15:b0:48d:fbee:3dec with SMTP id
 ffacd0b85a97d-48dfbee3fa9mr5402019f8f.29.1792156907527; 
 Fri, 16 Oct 2026 06:21:47 -0700 (PDT)
X-Received: by 2002:a05:6000:4b15:b0:48d:fbee:3dec with SMTP id
 ffacd0b85a97d-48dfbee3fa9mr5401985f8f.29.1792156907098; 
 Fri, 16 Oct 2026 06:21:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfe4d2321sm5067555f8f.19.2026.10.16.06.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 06:21:46 -0700 (PDT)
Message-ID: <4c9d85b0-4dac-40f8-8541-d79bb3670f12@redhat.com>
Date: Fri, 16 Oct 2026 15:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 24/25] target/arm/qmp: implement
 query-cpu-props-info for KVM
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev
Cc: cohuck@redhat.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 gshan@redhat.com, skolothumtho@nvidia.com, sebott@redhat.com,
 armbru@redhat.com, philmd@linaro.org, yangjinqian1@huawei.com,
 shaju.abraham@nutanix.com, mark.caveayland@nutanix.com,
 ping@khushitshah.com, sandesh.patel@nutanix.com
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-25-khushit.shah@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260921123249.1708067-25-khushit.shah@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Khushit,

On 9/21/26 2:32 PM, Khushit Shah wrote:
> Implement query-cpu-props-info for ARM64/KVM by creating and finalizing
> a temporary "host" CPU object and then walking its QOM properties.
>
> For numeric SYSREG_ properties, report the host-supported value ranges
> computed by kvm_arm_field_get_supported_values(). For boolean
> properties, report false as always supported and true as supported when
I am not sure false shall be always permitted. for instance iirc
aarch64=off requires a special KVM capability which is not tested here.

it is worth to emphasize those are the theoretical values that can be
easily guessed, this does not check cross feature consistency which can
only be tested when applying the values at KVM level I guess. So let's
do not pretend that this is fully reliable. I think the only way to
double check the chosen values is to do a full expansion for this models
featuring the new values
> the QOM property value is true.
>
> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
> ---
>  target/arm/arm-qmp-cmds.c | 84 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 84 insertions(+)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 0940285af1..ba488d5c01 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -84,6 +84,90 @@ static const char *cpu_model_advertised_features[] = {
>      NULL
>  };
>  
> +CpuPropertyInfoList *qmp_query_cpu_props_info(Error **errp)
> +{
> +    CpuPropertyInfoList *head = NULL;
> +    const ARMISARegisters *host_isar;
> +    ObjectPropertyIterator iter;
> +    ObjectProperty *prop;
> +    Error *err = NULL;
> +    ObjectClass *oc;
> +    Object *obj;
> +
> +    if (!kvm_enabled()) {
> +        error_setg(errp, "query-cpu-props-info requires KVM");
> +        return NULL;
> +    }
> +
> +    oc = cpu_class_by_name(TYPE_ARM_CPU, "host");
> +    if (!oc) {
> +        error_setg(errp, "The 'host' CPU type is not available");
> +        return NULL;
> +    }
> +
> +    host_isar = kvm_arm_get_host_isar();
> +
> +    /* Spin up a scratch "host" vCPU object and walk its QOM properties. */
> +    obj = object_new_with_class(oc);
> +    arm_cpu_finalize_features(ARM_CPU(obj), &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        object_unref(obj);
> +        return NULL;
> +    }
> +
> +    object_property_iter_init(&iter, obj);
> +    while ((prop = object_property_iter_next(&iter))) {
> +        CpuPropertyInfo *info;
> +
> +        if (g_str_has_prefix(prop->name, "SYSREG_")) {
> +            const ARM64SysRegField *field = prop->opaque;
> +            CpuPropertyValueRangeList *ranges = NULL;
> +            ArmFieldValueSet *vs = NULL;
> +
> +            info = g_new0(CpuPropertyInfo, 1);
> +            info->name = g_strdup(prop->name);
> +            info->type = CPU_PROPERTY_TYPE_NUMBER;
> +
> +            kvm_arm_field_get_supported_values(field, host_isar, &vs);
> +            for (size_t k = 0; k < vs->n_ranges; k++) {
> +                CpuPropertyValueRange *r = g_new0(CpuPropertyValueRange, 1);
> +                r->min = vs->ranges[k].min;
> +                r->max = vs->ranges[k].max;
> +                QAPI_LIST_PREPEND(ranges, r);
> +            }
> +            info->u.number.supported_values = ranges;
> +
> +            g_free(vs->ranges);
> +            g_free(vs);
> +        } else if (g_strv_contains(cpu_model_advertised_features, prop->name)) {
> +            bool cur = object_property_get_bool(obj, prop->name, &error_abort);
> +            boolList *values = NULL;
> +
> +            info = g_new0(CpuPropertyInfo, 1);
> +            info->name = g_strdup(prop->name);
> +            info->type = CPU_PROPERTY_TYPE_BOOLEAN;
> +
> +            /*
> +             * "off" is always supported. "on" is only supported when the
> +             * host already has the feature enabled.
> +             */
> +            QAPI_LIST_PREPEND(values, false);
> +            if (cur) {
> +                QAPI_LIST_PREPEND(values, true);
> +            }
> +            info->u.boolean.supported_values = values;
> +        } else {
> +            continue;
> +        }
> +
> +        QAPI_LIST_PREPEND(head, info);
> +    }
> +
> +    object_unref(obj);
> +    return head;
> +}
> +
>  CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>                                                       CpuModelInfo *model,
>                                                       Error **errp)
Thanks

Eric


