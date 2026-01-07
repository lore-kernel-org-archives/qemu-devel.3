Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1235BCFD65A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVnz-00057b-KH; Wed, 07 Jan 2026 10:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdVnZ-0004Py-Oy
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdVnW-0007RL-C7
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767801009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+cywoFiepHQh30aLpF/KO7E3qJjIxyeGvea5XTyXjTc=;
 b=BZlsIAz7v+lXixqMA7BIa3gm8wBPfyDDcmjin6y7LTJT/qRcDAYc2BRtBdiFOOVxW8pOrV
 GfuX2wSgqPGY6IBylZ+cDGb51u21YVqtgN/PR3N3S3jJB9w9FigkDLkoFe2kiqdmY0QJoN
 j9vo+Leyk3I94xgcR12EbH2GKtZpdYw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-l9GxaPqEO5mlPs7Sfj2xnQ-1; Wed, 07 Jan 2026 10:50:07 -0500
X-MC-Unique: l9GxaPqEO5mlPs7Sfj2xnQ-1
X-Mimecast-MFC-AGG-ID: l9GxaPqEO5mlPs7Sfj2xnQ_1767801007
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc153d50so1625525f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767801006; x=1768405806; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=+cywoFiepHQh30aLpF/KO7E3qJjIxyeGvea5XTyXjTc=;
 b=HuDEOWfIt+qzufPbGKw3bt9c6SvvTLKqK6ifHyL8UxRuwR+h0SUI2PiD9QkRCCs11K
 aUWv9r8xo7NXaVMr4Tdiw48neo/kkINIOpZrN85cU/KCEw3k/BNnArfwf//6p90t9eSx
 KyzmMswOdHkJyiUDE1Pl7N2sVRf78LiY9Bl0NlYcVj+r1CypXSqmNXIq2TB+EFg4U1ND
 ygOFYy/tpWF8axXb1XqokpmbAEm7iSZSv8VuajoQuy0hp78fVlWGCnz6SoidC2hVqoDA
 0GQr8LELhYcNYVZDJ0k+6JfVylZyHc6k3q5aIYk6+6a64sAQb1+B8tcsdq3hqxE3RNlc
 XABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767801006; x=1768405806;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+cywoFiepHQh30aLpF/KO7E3qJjIxyeGvea5XTyXjTc=;
 b=Q1d4zsZqsqdXOQ1Q/9FQBzDRE4YK1Cye6KTLMcrIFFRV8d54tRUehQAGk8htV2ZIHL
 9h5K8cVqnEFyBzWgprjsgD4tFy8enH8ukWjhl2FS16kFqoG43ZaZ/SW4BNeEUS/B81uY
 gfsmKi89qWUUg0MdkaeH92LGwhO9YGUwNFQ4BcdPZqu3qmXFFWKuarxBsIUQ32ZLOYz7
 c0WFOt70n7+lu95Cnte7/gZmystiCGP0HpYXQPYcZXQuglkQV5wwP4wLKvXJiouhvcC0
 mvVNEUUxEf5sVOrzTyoqhEK7B48jFXZ8hyb7Y3yUeDgaRhxq4vINNvSLvKNWNdKxy/s6
 +9Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9iQMFLQDOBIpUkjCGSuFJBfZUwO52/5dFBnpul6JLBC7jGJ5vjZCsnJKrn1h1gs4Zsihpyaa2pFq2@nongnu.org
X-Gm-Message-State: AOJu0Yyxy+vphCHU6n03UYbSNNJiEiZH+bB0YqbYXMvnixi4Io3oC7Xg
 BQYh7X9GcbEobl/+0Wb+356mIQZHMYksxlOZXPOKY5ZV14h+Fi+wBzdyZUh1qC6bRwIMWpAccPX
 Xcbzz2QcHWr9QMIuSrw7O37i/2dEGvIT2BpOrnrA8O1Ikxfe48KK54ejh
X-Gm-Gg: AY/fxX4RWraOk04TnCTBenNWeDupchHyT2AbsPrha/u2aseDn3nmK9bQ40Ba7PZQGB5
 +5UbkYGujq2Z6SjgieU73v0ugf60HW5DNuZqgrUIppLvy5Msn1SLu+5BJcszcVLyGRyX6dZF1yN
 l3Z/WnBtmzVO5sYBvUxoprtDrIWs4Yf+b6K+54vFmu8Pdmrj/OhUo6QWy+Rbw0C7KZaZdFYSG5J
 prgLGsTlkKjfogw64W9Ecgg/qSMwYOKjzxWuUbidlWTVHfJKe3PgqUYioFerJ2+lyN0p7LLIIgo
 tMMrKZxu7hHONA699J6craDp3R7hmiSc+3VziiCIKBCxpsASqU90bqVU60sHjBwLSrhF2cmP/Qp
 UK2J2/AN24OWd3Mc1G3W7/fxdniz6iEQLiTI=
X-Received: by 2002:a05:6000:2287:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-432c3790b85mr3837881f8f.14.1767801006616; 
 Wed, 07 Jan 2026 07:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC/5Bd0CG8tzivG7PtkXnZQDa80iJM2UM6l+X6SRNmXaFosCThgwJD5ImmfmGJzBstG0oFKA==
X-Received: by 2002:a05:6000:2287:b0:427:23a:c339 with SMTP id
 ffacd0b85a97d-432c3790b85mr3837846f8f.14.1767801006164; 
 Wed, 07 Jan 2026 07:50:06 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm11179256f8f.22.2026.01.07.07.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 07:50:05 -0800 (PST)
Message-ID: <5e764e58-022c-4d0b-81d3-0564a15dea41@redhat.com>
Date: Wed, 7 Jan 2026 16:50:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hw: Add "loadparm" property to PCI devices for
 booting on s390x
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251210205449.2783111-1-jrossi@linux.ibm.com>
 <20251210205449.2783111-10-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251210205449.2783111-10-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 10/12/2025 21.54, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> The loadparm is required on s390x to pass the information to the boot loader
> such as which kernel should be started or whether the boot menu should be shown.
> 
> Because PCI devices do not naturally allocate space for this, the property is
> added on an architecture specific basis.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   include/hw/pci/pci_device.h |  3 +++
>   hw/pci/pci.c                | 39 +++++++++++++++++++++++++++++++++++++
>   hw/s390x/ipl.c              | 11 +++++++++--
>   3 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
> index 88ccea5011..5cac6e1688 100644
> --- a/include/hw/pci/pci_device.h
> +++ b/include/hw/pci/pci_device.h
> @@ -62,6 +62,9 @@ struct PCIDevice {
>       bool partially_hotplugged;
>       bool enabled;
>   
> +    /* only for s390x */
> +    char *loadparm;
> +
>       /* PCI config space */
>       uint8_t *config;
>   
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b1eba348e0..1ea0d7c54c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -36,6 +36,7 @@
>   #include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   #include "net/net.h"
> +#include "system/arch_init.h"
>   #include "system/numa.h"
>   #include "system/runstate.h"
>   #include "system/system.h"
> @@ -2825,6 +2826,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
>       return rc;
>   }
>   
> +static char *pci_qdev_property_get_loadparm(Object *obj, Error **errp)
> +{
> +    return g_strdup(PCI_DEVICE(obj)->loadparm);
> +}
> +
> +static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    void *lp_str;
> +
> +    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
> +        error_setg(errp, "'loadparm' is only valid for boot devices");
> +        return;
> +    }
> +
> +    lp_str = g_malloc0(strlen(value) + 1);
> +    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
> +        g_free(lp_str);
> +        return;
> +    }
> +    PCI_DEVICE(obj)->loadparm = lp_str;
> +}
> +
> +static void pci_qdev_property_add_specifics(DeviceClass *dc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(dc);
> +
> +    /* The loadparm property is only supported on s390x */
> +    if (qemu_arch_available(QEMU_ARCH_S390X)) {
> +        object_class_property_add_str(oc, "loadparm",
> +                                      pci_qdev_property_get_loadparm,
> +                                      pci_qdev_property_set_loadparm);
> +        object_class_property_set_description(oc, "loadparm",
> +                                              "load parameter (s390x only)");
> +    }
> +}

Adding this unconditionally to each and every PCI device is a little bit 
ugly ... could we please limit this to virtio-blk-pci devices for now?
(or maybe check if there is a bootindex property, and only add it for 
devices with a bootindex property?)

  Thomas


