Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCFEC25B4F
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 05:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Iyv-0007OR-TG; Fri, 10 May 2024 01:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IyR-0007CP-7W
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s5IyP-00029y-77
 for qemu-devel@nongnu.org; Fri, 10 May 2024 01:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715319551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MTq84RJdH7rfSVN+hVNfXsbSF8kOSLhnrY03iXIYaDw=;
 b=NC0aanrzxdvgmbGFhBGMqWqtjZOPHpfbu0E17b8Q3n05pgiS+j22NS2hp1ffabIc/04m/W
 IJjSxYX/rFEJM01GbJgY0aidmKEGNeByXSiCZEu+qZ3bW1h8lzXNqiXIooPFoG0HGTEN4C
 8alfM37gDids9q/lx5+fChNUCuHTMfU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-sb5dXKQuM2-BywBQCYv1BQ-1; Fri, 10 May 2024 01:38:01 -0400
X-MC-Unique: sb5dXKQuM2-BywBQCYv1BQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-51f0d924685so1363034e87.0
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 22:38:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715319480; x=1715924280;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MTq84RJdH7rfSVN+hVNfXsbSF8kOSLhnrY03iXIYaDw=;
 b=crrtvc6BYRjRcq7Sfi0KZkZlxH4K3j/4KXQlqh4cr6R1QRx/Kt9RGOQ0FF4wQ3iohy
 EUEh82q7BTpvO567MAch6dLvIzXsryMuBv2o8MR3PGmTzNRPWXsllSf36opdWdhRdekD
 huxHv+598LMnlAgm2hVL5kd5PFCEyQrIRM61LylpsmAn3QDEunfpl/wLws2IsU0f/yv+
 V880UTtNIZ6BFRD8abKYLZNKler3mvLiR2api56T6KJSxrfIwmR67wavCyrHQW+35MRf
 CvOpy6reCix6s8SyplSLmvPN79VFFXLeuDoHMMvhBwd6gjOylg5rMOWrYq9DlnSengi+
 ZO/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSQJmHXQukCOmA/e9XdVzy8uvpvhciumZDwv3aaGbd6Qik4LKO7zdTw4Tyub2KNyrnipC+qxGHEDqouMgpEN1yzuD+lX8=
X-Gm-Message-State: AOJu0YzAwyR0i1Q8H0iH4tYUb/q8NgUz3GL28g96nfz7nbqiG0NOlkWS
 lPMOzNJXaeUoaW5wAvrJw2IjD7yiny8elfu2QsRP+s0CcLqhx4Y+sz1isZj3DGG6OSbGqHglRMP
 3A6eikTUxxcmgsgRYDult7TGytmS555SVrwVVtwYNKKlD1d8z71OX
X-Received: by 2002:ac2:4845:0:b0:51a:f362:ab40 with SMTP id
 2adb3069b0e04-5220fc7cb4emr1098452e87.2.1715319480211; 
 Thu, 09 May 2024 22:38:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHdq7dXAhHgs+nj1ZulMLhU0p9/3mdu9Q5WKPzKaYcPa9Uf3JujeTMXY1YGDkSnyzaQ5tMyg==
X-Received: by 2002:ac2:4845:0:b0:51a:f362:ab40 with SMTP id
 2adb3069b0e04-5220fc7cb4emr1098432e87.2.1715319479752; 
 Thu, 09 May 2024 22:37:59 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-40-241-109.web.vodafone.de.
 [109.40.241.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cdb5sm146430066b.29.2024.05.09.22.37.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 May 2024 22:37:59 -0700 (PDT)
Message-ID: <549e6861-b868-43d3-be7c-d99981fd6aa7@redhat.com>
Date: Fri, 10 May 2024 07:37:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] s390: move css_migration_enabled from machine to
 css.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-4-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240509170044.190795-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/05/2024 19.00, Paolo Bonzini wrote:
> The CSS subsystem uses global variables, just face the truth and use
> a variable also for whether the CSS vmstate is in use; remove the
> indirection of fetching it from the machine type, which makes the
> TCG code depend unnecessarily on the virtio-ccw machine.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/s390x/css.h             |  6 ++++++
>   include/hw/s390x/s390-virtio-ccw.h |  7 -------
>   hw/s390x/css.c                     | 10 +++++++---
>   hw/s390x/s390-virtio-ccw.c         | 15 +++------------
>   4 files changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index ba72ee3dd20..8289e458370 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -333,4 +333,10 @@ static inline int ccw_dstream_read_buf(CcwDataStream *cds, void *buff, int len)
>   #define ccw_dstream_read(cds, v) ccw_dstream_read_buf((cds), &(v), sizeof(v))
>   #define ccw_dstream_write(cds, v) ccw_dstream_write_buf((cds), &(v), sizeof(v))
>   
> +/**
> + * true if (vmstate based) migration of the channel subsystem
> + * is enabled, false if it is disabled.
> + */
> +extern bool css_migration_enabled;
> +
>   #endif
> diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
> index c1d46e78af8..c0494e511cb 100644
> --- a/include/hw/s390x/s390-virtio-ccw.h
> +++ b/include/hw/s390x/s390-virtio-ccw.h
> @@ -43,7 +43,6 @@ struct S390CcwMachineClass {
>       /*< public >*/
>       bool ri_allowed;
>       bool cpu_model_allowed;
> -    bool css_migration_enabled;
>       bool hpage_1m_allowed;
>       int max_threads;
>   };
> @@ -55,10 +54,4 @@ bool cpu_model_allowed(void);
>   /* 1M huge page mappings allowed by the machine */
>   bool hpage_1m_allowed(void);
>   
> -/**
> - * Returns true if (vmstate based) migration of the channel subsystem
> - * is enabled, false if it is disabled.
> - */
> -bool css_migration_enabled(void);
> -
>   #endif
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 295530963a6..b2d5327dbf4 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -23,6 +23,8 @@
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/s390-ccw.h"
>   
> +bool css_migration_enabled = true;
> +
>   typedef struct CrwContainer {
>       CRW crw;
>       QTAILQ_ENTRY(CrwContainer) sibling;
> @@ -180,7 +182,7 @@ static const VMStateDescription vmstate_orb = {
>   
>   static bool vmstate_schdev_orb_needed(void *opaque)
>   {
> -    return css_migration_enabled();
> +    return css_migration_enabled;
>   }
>   
>   static const VMStateDescription vmstate_schdev_orb = {
> @@ -388,7 +390,7 @@ static int subch_dev_post_load(void *opaque, int version_id)
>           css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
>       }
>   
> -    if (css_migration_enabled()) {
> +    if (css_migration_enabled) {
>           /* No compat voodoo to do ;) */
>           return 0;
>       }
> @@ -412,7 +414,9 @@ static int subch_dev_post_load(void *opaque, int version_id)
>   
>   void css_register_vmstate(void)
>   {
> -    vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
> +    if (css_migration_enabled) {
> +        vmstate_register(NULL, 0, &vmstate_css, &channel_subsys);
> +    }
>   }
>   
>   IndAddr *get_indicator(hwaddr ind_addr, int len)
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 1383e47eeb5..aa90703d518 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -275,11 +275,9 @@ static void ccw_init(MachineState *machine)
>       s390_enable_css_support(s390_cpu_addr2state(0));
>   
>       ret = css_create_css_image(VIRTUAL_CSSID, true);
> -
>       assert(ret == 0);
> -    if (css_migration_enabled()) {
> -        css_register_vmstate();
> -    }
> +
> +    css_register_vmstate();
>   
>       /* Create VirtIO network adapters */
>       s390_create_virtio_net(BUS(css_bus), mc->default_nic);
> @@ -741,7 +739,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
>   
>       s390mc->ri_allowed = true;
>       s390mc->cpu_model_allowed = true;
> -    s390mc->css_migration_enabled = true;
>       s390mc->hpage_1m_allowed = true;
>       s390mc->max_threads = 1;
>       mc->init = ccw_init;
> @@ -811,11 +808,6 @@ static const TypeInfo ccw_machine_info = {
>       },
>   };
>   
> -bool css_migration_enabled(void)
> -{
> -    return get_machine_class()->css_migration_enabled;
> -}
> -
>   #define DEFINE_CCW_MACHINE(suffix, verstr, latest)                            \
>       static void ccw_machine_##suffix##_class_init(ObjectClass *oc,            \
>                                                     void *data)                 \
> @@ -1171,7 +1163,6 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)
>   
>   static void ccw_machine_2_9_class_options(MachineClass *mc)
>   {
> -    S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
>       static GlobalProperty compat[] = {
>           { TYPE_S390_STATTRIB, "migration-enabled", "off", },
>           { TYPE_S390_FLIC_COMMON, "migration-enabled", "off", },
> @@ -1180,7 +1171,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
>       ccw_machine_2_10_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
>       compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
> -    s390mc->css_migration_enabled = false;
> +    css_migration_enabled = false;
>   }
>   DEFINE_CCW_MACHINE(2_9, "2.9", false);

I think this is wrong: By adding this to ccw_machine_2_9_class_options the 
variable now always gets set to false, even for newer machines, since the 
*class_options functions are part of the "class_init" which is always done.
You have to add it to ccw_machine_2_9_instance_options() instead to make it 
work as expected.

  Thomas


