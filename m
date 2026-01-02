Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB44FA3741
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 12:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbeFi-00037I-C8; Fri, 02 Jan 2026 07:27:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbeFd-00036h-Ml
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vbeFY-0004Cl-Pv
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 07:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767356843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B/cMNlTBms1m+8SBhOofS8dy/lj0FQaqm8ou280KOfw=;
 b=LjUD5127ve1LqRyGlMvAyhcM2bYQ2vOGNLqiLG93GP3PBGnxDZxQIOKsgY9ociiqDBuG8E
 Qmainv2mPcHj+kb4TnWT82EEuSA9Xab70onP7q4zKcYdcHkG85UfWfDvoJRhSpIzvioOqA
 0bTf3I5aijJKDaMOj5INwdpIv3Lbwh0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-k0PtYB9fPCOZgywL0bl5Sw-1; Fri, 02 Jan 2026 07:27:22 -0500
X-MC-Unique: k0PtYB9fPCOZgywL0bl5Sw-1
X-Mimecast-MFC-AGG-ID: k0PtYB9fPCOZgywL0bl5Sw_1767356841
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so122051455e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 04:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767356841; x=1767961641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B/cMNlTBms1m+8SBhOofS8dy/lj0FQaqm8ou280KOfw=;
 b=jJVORbbH5Ddk6cDanvzlM027Cp30NXi21CCDfFLCUbw0FlIMC+7tUGkz1hjuTbawz/
 ZxoIrFSSSK2hKvQ98ib/7CeX9aH29kRVdvGhspCWhNuqkWLLPZh7aAcq6+yRxtopV3a7
 FqczmIlnhcoEk7jx4ojXK5vDA/qo5u3e3fB0ZG0fpvbV+8vvWAVGqRTlafjxOZpMhGci
 v27PmV0kG6UY3n/ONspWOk093RTEU92NOXiRgyjGj8nH+eVwemrIDYPa/aF3bKT7BkWY
 452waeLfaNBc4JJMOXdlFaX+5PBzWhy/PXxUmSyXWBvK724nUvqhatK+Sxa16SYJrp/Q
 e3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767356841; x=1767961641;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B/cMNlTBms1m+8SBhOofS8dy/lj0FQaqm8ou280KOfw=;
 b=GmOCi0njkHfp2Lz2+dHwn5l3enTdTCl76BJZILzA03WRr7md4yBr/sILCfCGvUad09
 OqO6Xokgs0HDd4rjgtDEPPoQykd4nJ6FjOVpcnmUOUy9lO+lJwa3cGMqKaTeyK+EmW2C
 vvJ6Szf2qwYz8yDH+L8kc3NIu2QXjPzlplPn2VO2oNMDZQhHAyEZUJeC2jPVgd8tiyDc
 M68MKXgMnB2DAm4NR6Geo26vA2APzWkHmfDQbRE7kLGSdISHfSk4drU6Gfq28WF56ICz
 ekiog3SoI9L9J5m32yQm78puKTx5wEEQpr4U/7ZQVw+eUJkLDkFBZp5u1pc+WvahUILZ
 4aJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAt9BEuVFF1sdHnyawQe/Vt0amTk/lGrgJlkvdOVAx4KUKccmk4vAfSauDMMDGeWfp0vuW6F9cJs0f@nongnu.org
X-Gm-Message-State: AOJu0Yyq4Te5+YCEvG1flY9Di3mPB56F9xOarpF7W2c903aDlK5aNbKm
 LMrY+EXdjbGzmsREQbqsHFxRZpfiY26hEFTXnNn/D4U43Qf+AU6qLGhu7hNycb+RM8i/Cj791tj
 iKUBND7cTXRgxn1/6qk6V0a6Homf4LegdHXf+vFmClgLIQQh7DOCO5m7Z
X-Gm-Gg: AY/fxX5fhky0KZ2/pE94cUfrzFgMzPyyVca4Sems4wzlh7yeGcs9g78CW1SSNZJDudW
 z+wpphGyGEmQJNWBl/SjwuffJNedrzSRW5tcKHZccPkzmyCi2UF/ei77eqzwCx9xd4tn73OXbmF
 BlNWcr5mPWHM/UyeK2J+nb5abs635KFa02wcBw2rJ48kqEoMuHyjayhZ6aGG3B39VYX6TLD2nvy
 T7ZwOZ1rTEu2LAPtn6oDhw5f/ix1DNStAsc8sajTsM8LAIxJcU8Ro7yqLv4vI7JVCuXOO51Xxz2
 8qOVRau0iTWTNs7JhP8bVYGD+oJTROGGmut0lz9HUn8TXtjWDyh9qMcB64e3z5o+BMKhNwBz4/v
 VPEGu+1+KR9X6AnOpeAmZBg==
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr506564825e9.28.1767356840851; 
 Fri, 02 Jan 2026 04:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1IBGf0IJGUknL4iflUAKgW8gO0kLcRopHdtsxInj/tN3yfYq34RulnyrGLYacZVur6ad57Q==
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr506564475e9.28.1767356840428; 
 Fri, 02 Jan 2026 04:27:20 -0800 (PST)
Received: from imammedo-mac ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3bbe1c8sm312729115e9.11.2026.01.02.04.27.19
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Fri, 02 Jan 2026 04:27:20 -0800 (PST)
Date: Fri, 2 Jan 2026 13:27:17 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?Q?Berrang?=
 =?UTF-8?Q?=C3=A9?=" <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>, BALATON
 Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, devel@lists.libvirt.org
Subject: Re: [RFC 07/10] hw/core/qdev-properties: Allow to mark qdev
 property as deprecated
Message-ID: <20260102132717.1211737f@imammedo-mac>
In-Reply-To: <20251202170502.3228625-8-zhao1.liu@intel.com>
References: <20251202170502.3228625-1-zhao1.liu@intel.com>
 <20251202170502.3228625-8-zhao1.liu@intel.com>
Organization: imammedo@redhat.com
X-Mailer: Claws Mail 3.11.1-67-g0d58c6-dirty (GTK+ 2.24.21;
 x86_64-apple-darwin14.0.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Dec 2025 01:04:59 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> With deprecation flag, make qdev property interfaces to accept
> ObjectPropertyFlags, and provide the boolean and uint8_t macro variants
> to help on deprecation as examples.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/core/qdev-properties.c    | 24 +++++++++++++-----------
>  include/hw/qdev-properties.h | 18 ++++++++++++++++++
>  2 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 422a486969c8..2cd7de5cec2d 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -1069,11 +1069,12 @@ void qdev_property_add_static(DeviceState *dev, const Property *prop)
>  
>      assert(!prop->info->create);
>  
> -    op = object_property_add(obj, prop->name, prop->info->type,
> -                             field_prop_getter(prop->info),
> -                             field_prop_setter(prop->info),
> -                             prop->info->release,
> -                             (Property *)prop);
> +    op = object_property_try_add_full(obj, prop->name, prop->info->type,
> +                                      field_prop_getter(prop->info),
> +                                      field_prop_setter(prop->info),
> +                                      prop->info->release,
> +                                      prop->flags, (Property *)prop,
> +                                      &error_abort);
>  
>      object_property_set_description(obj, prop->name,
>                                      prop->info->description);
> @@ -1095,12 +1096,13 @@ static void qdev_class_add_property(DeviceClass *klass, const char *name,
>      if (prop->info->create) {
>          op = prop->info->create(oc, name, prop);
>      } else {
> -        op = object_class_property_add(oc,
> -                                       name, prop->info->type,
> -                                       field_prop_getter(prop->info),
> -                                       field_prop_setter(prop->info),
> -                                       prop->info->release,
> -                                       (Property *)prop);
> +        op = object_class_property_add_full(oc,
> +                                            name, prop->info->type,
> +                                            field_prop_getter(prop->info),
> +                                            field_prop_setter(prop->info),
> +                                            prop->info->release,
> +                                            prop->flags,
> +                                            (Property *)prop);
>      }
>      if (prop->set_default) {
>          prop->info->set_default_value(op, prop);
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 60b81330097d..383f3f54f0ab 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -11,6 +11,7 @@
>   *     and the field retains whatever value it was given by instance_init).
>   * @defval: default value for the property. This is used only if @set_default
>   *     is true.
> + * @flags: property flags to control uses.
>   */
>  struct Property {
>      const char   *name;
> @@ -27,6 +28,7 @@ struct Property {
>      int          arrayfieldsize;
>      uint8_t      bitnr;
>      bool         set_default;
> +    uint8_t      flags;
>  };
>  
>  struct PropertyInfo {
> @@ -102,6 +104,13 @@ extern const PropertyInfo qdev_prop_link;
>                  .set_default = true,                                       \
>                  .defval.u  = (_type)_defval)
>  
> +#define DEFINE_PROP_UNSIGNED_DEPRECATED(_name, _state, _field, \
> +                                        _defval, _prop, _type) \
> +    DEFINE_PROP(_name, _state, _field, _prop, _type,           \
> +                .set_default = true,                           \
> +                .defval.u    = (_type)_defval,                 \
> +                .flags       = OBJECT_PROPERTY_DEPRECATED)
> +
>  #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \

adding flags to the end of the names, basicaly spawns a lot of vartions of the same macro,

perhaps it's time to just add flags field and consoladate existing 'flag named' variants,
the one won't need to introduce DEFINE_PROP_UNSIGNED_DEPRECATED at all,
just use appropriate flag(s) when decaring property.

>      DEFINE_PROP(_name, _state, _field, _prop, _type)
>  
> @@ -123,6 +132,12 @@ extern const PropertyInfo qdev_prop_link;
>                  .set_default = true,                         \
>                  .defval.u    = (bool)_defval)
>  
> +#define DEFINE_PROP_BOOL_DEPRECATED(_name, _state, _field, _defval)     \
> +    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool,            \
> +                .set_default = true,                                    \
> +                .defval.u    = (bool)_defval,                           \
> +                .flags       = OBJECT_PROPERTY_DEPRECATED)
> +
>  /**
>   * The DEFINE_PROP_UINT64_CHECKMASK macro checks a user-supplied value
>   * against corresponding bitmask, rejects the value if it violates.
> @@ -189,6 +204,9 @@ extern const PropertyInfo qdev_prop_link;
>  #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
>      DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
>  
> +#define DEFINE_PROP_UINT8_DEPRECATED(_n, _s, _f, _d)                       \
> +    DEFINE_PROP_UNSIGNED_DEPRECATED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
> +
>  /*
>   * Set properties between creation and realization.
>   *


