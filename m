Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C41E9904A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB73b-0000mH-OE; Fri, 10 Apr 2026 04:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB73V-0000lj-EC
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wB73T-0000oJ-Rt
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775809051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GMFwOeAl9MieDvJ313hoa+QETKVMjWIGtR8ReZvT38k=;
 b=GECh1gns9JLkrjljpEZNRKsgHNZPL8ntURdtqMsIZaTFFvzmM2YgLEBw4ZVyJ9MdHsiBGr
 LUiPvA8uQELGGbHuWiu03NFljpDE8TvCA86ovaHRwG1kU1xMB7WP3904PlOzFeg2wYr/XH
 4NLIuHBOXNCG1Phqzznid8Zx9Pe5Y2M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-TG1R5VfXPqmLa2e8L8O3oA-1; Fri, 10 Apr 2026 04:17:29 -0400
X-MC-Unique: TG1R5VfXPqmLa2e8L8O3oA-1
X-Mimecast-MFC-AGG-ID: TG1R5VfXPqmLa2e8L8O3oA_1775809049
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so14357645e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775809048; x=1776413848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=GMFwOeAl9MieDvJ313hoa+QETKVMjWIGtR8ReZvT38k=;
 b=gLvyRjiEzSse56kIvJYcdI53vl20LEVRQsZnEMwYgix9llkj3W0G77176OR8bb13ZH
 swSjDfRqVwBfvXQA5XczcpzwdZVJQWA3t3z3LWkdMEylpDDpSY+GBNEfRFSXtSOT5j93
 U0Tta3quTY9xDwMy58e76K8V+gdiAMICIqruartRbSobV3Pd4jr1NVIQGVjX5T+Tn3nJ
 d5uqJvVCx2j9lv7sXuAlRQXX+F1qz2ymqsNd5GM0ehggdvskgzHs/y85ArGvADC3pM8P
 M5BjEji+l52wJxiQO9BGKiQTRRuF3irzWnwCE6WLdUyff1xGuFqGLECRhyGBJZpo0Bpn
 3QXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775809048; x=1776413848;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMFwOeAl9MieDvJ313hoa+QETKVMjWIGtR8ReZvT38k=;
 b=jLRQyde/lJ7uUcejrypzr015cUa/+129NhEYOiI1tcW1Vgat6W3IQpHu5aMIJwAiJD
 DGqFbeW3JV1Ov+ubkShKuK8aIaIfHaSuyA03+iv1AicfW/tHEgkZflowcqAMSIuIAOFg
 0tLZMahNLcdo25PnzjCB8aEexLSkYVQeW26dBPVQqFzW5RH8Ys/eQcGHWcdGqk3MbJB9
 7eATzZAimD/YCtLYFKMOvMXqyHCGOdu+5jCIPJSDSOuiOseOlhN5Y8CuGet/QDwhILzP
 R1Rmm08kudTQjhaNHcxHHMo50F1GxEEGyTpFK9oNoNmiDM0eN88IlcXRJEsNViDOVcSr
 ET3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj44cW8hKUgr4LNqAQ7ZNAHrxeJpbS+ofO6N5zEfmdgK7a9QxHHTblzzRKlStKTv281TbqajP5qb9v@nongnu.org
X-Gm-Message-State: AOJu0YxsuJV8w4tsVRR+ZvrjPY/BwpEOXL4bh+jp0k+doKNakLBO8cGJ
 1vaKp+L9j8CCPP8pWayd9vSRHBXKmwCX+GugvHqrpdo+OWvbRQ52MRzr//BjbOyTrgNnnDCO+BA
 4H1EoAvSxC7Y/6Kl7yNqo3SzBR6QdoZhgLKpWHFDSs6LKuATRn+kNfzlt
X-Gm-Gg: AeBDiesNnlu0LWXVbTPLd0XCGOtjRS7NI6VRJ+4rfIevjcQP0+EibNtJAk8cfDTPUEH
 7hi6JuZ2oK8YkruZeekHOiqqfEjcCLIoBrFPWK0+RswGiib4hXhQz3JayiBWcB7RGYYi7VC5/Qp
 +uPxYFmofTfNcvC/cBC+fTM33FmrG0GpqOzpD5fszbz7Mgqpg4odeQoydioArUZWkjQ4rhygGX4
 HLa2P5envfvCIIEky6hbiYUsNaq0l6lErJfbqRar5t0QaBpIiTY8OW5wSoP3hYFxCqHbioruRhQ
 o9kpMafrqo4OCG1wUcBzUP+yn+ypp3/yFHq8JBiiOdGW2NAg5Kpsc6Pc96S/vQWyguN4LgYW9iS
 /uskg5dl+RftzHMXKs4s9onhZqUepjUIUlKfclHVTTEDetRHCJUGh/IOt9Q==
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488d68af17bmr21776495e9.16.1775809048546; 
 Fri, 10 Apr 2026 01:17:28 -0700 (PDT)
X-Received: by 2002:a05:600c:4709:b0:488:caed:5ccf with SMTP id
 5b1f17b1804b1-488d68af17bmr21776065e9.16.1775809048019; 
 Fri, 10 Apr 2026 01:17:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f229sm80790255e9.3.2026.04.10.01.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 01:17:27 -0700 (PDT)
Message-ID: <7bcb67c8-d3c7-4240-a055-a30cb0bb76a2@redhat.com>
Date: Fri, 10 Apr 2026 10:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/vfio/ap: Extend vfio device state description
 to facilitate live migration
To: Anthony Krowiak <akrowiak@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com,
 alex@shazbot.org, cohuck@redhat.com
References: <20260409141352.997844-1-akrowiak@linux.ibm.com>
 <20260409141352.997844-2-akrowiak@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260409141352.997844-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/9/26 16:13, Anthony Krowiak wrote:
> Make the changes needed to the VFIOAPDevice state description to facilitate
> live guest migration.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   hw/vfio/ap.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 5c8f305653..fd68983702 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -41,6 +41,16 @@ struct VFIOAPDevice {
>       EventNotifier req_notifier;
>       EventNotifier cfg_notifier;
>   };
> +OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
> +
> +static const VMStateDescription vmstate_ap_device = {
> +    .name = "vfio-ap-device",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
>   
>   typedef struct APConfigChgEvent {
>       QTAILQ_ENTRY(APConfigChgEvent) next;
> @@ -56,8 +66,6 @@ static void __attribute__((constructor)) vfio_ap_global_init(void)
>       qemu_mutex_init(&cfg_chg_events_lock);
>   }
>   
> -OBJECT_DECLARE_SIMPLE_TYPE(VFIOAPDevice, VFIO_AP_DEVICE)
> -
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>   {
>       vdev->needs_reset = false;
> @@ -297,11 +305,6 @@ static void vfio_ap_reset(DeviceState *dev)
>       }
>   }
>   
> -static const VMStateDescription vfio_ap_vmstate = {
> -    .name = "vfio-ap",
> -    .unmigratable = 1,
> -};
> -
>   static void vfio_ap_instance_init(Object *obj)
>   {
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
> @@ -335,7 +338,7 @@ static void vfio_ap_class_init(ObjectClass *klass, const void *data)
>   #ifdef CONFIG_IOMMUFD
>       object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
>   #endif

You will need to rebase on 'vfio-next' or 'master' when the changes
pending in the vfio queue are merged.


> -    dc->vmsd = &vfio_ap_vmstate;
> +    dc->vmsd = &vmstate_ap_device;
>       dc->desc = "VFIO-based AP device assignment";
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>       dc->realize = vfio_ap_realize;


