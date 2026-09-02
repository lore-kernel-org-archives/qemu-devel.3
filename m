Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45239C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1g0v-000897-4a; Wed, 02 Sep 2026 04:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1g0t-00088G-C9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x1g0r-0001TR-Lm
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788336482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+HAC8TkeNDlzaqtdtqRZPPhBj8L+oZ1tyfLSCgdMrzE=;
 b=JUG+i/Civie1eMVbOmxTnxSr49xuBs/rM2YVKkI72p3t3sRAPEqt2E4nKthJ7WHzBobYDF
 AG61HGGAGczOkig+L12d7zxiHUhUC15x58Tyn54SnVx/S3zlPuDJUgpXHJB+x70lAckk71
 yza736Zn6MEjnPCXDTpt5+3VD6mnLd0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-8otHfmuYNKOKs4Fv5gi36w-1; Wed, 02 Sept 2026 04:07:59 -0400
X-MC-Unique: 8otHfmuYNKOKs4Fv5gi36w-1
X-Mimecast-MFC-AGG-ID: 8otHfmuYNKOKs4Fv5gi36w_1788336478
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-482e2541c30so443112f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788336478; x=1788941278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+HAC8TkeNDlzaqtdtqRZPPhBj8L+oZ1tyfLSCgdMrzE=;
 b=ORQcWjh1yw7YhxAmuLtUOSwjvDlrbntHa6HyJmQz3y5zxL1yoNTKC/trQUtYoQw11v
 ot+4Ey6vmbO63vftseku3IUGZYj7V8AampYCRgazLc1eXvvPAdipEUkzpL7v1zBf+BYY
 bGnt1h5NiLezHgFoJ6FjWS7iYl0S7gJNfvx52IWhi93/Ds2g+lVctbkGUplwEkKFwvCz
 ZrEfwAxBSDrw/XYYKkQIBHZctJqZBk0Us7MI89Dexr60DUFNSmotUbIAWBFnSn6NBeRU
 SWY50V5sy94xqbgkN9UYIIChHbS5bJJ/awB6dAAlLEXUgu9z43Y92Q8F1kBdtthWGZbe
 wXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788336478; x=1788941278;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+HAC8TkeNDlzaqtdtqRZPPhBj8L+oZ1tyfLSCgdMrzE=;
 b=fk2FlvEaFZv9KsHse92Gg4qG1MlBJ8hiDLU88isd2kvFA1afK/34fbucPoAGEkAIPh
 XeL7B0xeGF5fnUqKQCeNKq/IHJqynEi6OKPJZyrD/KEY0d3saEBFffh8XskvXPxS138m
 I9XMTuSNSf1Yq6DmBKOdkZXUn3oPHuvfymCIgVZ99xdvbpN3MfLAv6289SiKa0lQDp4e
 /GktTjVGso1TC3DA2bqRWoEv05bygSeZdsfbBeFIpinT+l9Ck6z3dK3uovWb0nRPg83K
 5As5thDHiZ4FfxrDdaDqVtU2jB/Vk44naMzZaTQ8nK3A2ptOe37nNDH7nuGqSRDmv6fL
 rcGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnbUD/cekzA/1t7Ho0kIBxsTtZ1mZb86Bs7euVcjWZ6B7WS9VheP0/r1H7fNS/xNFBDrbUtO6YxKO0@nongnu.org
X-Gm-Message-State: AFuF++mPOtFrnrK8KYMrd1A0FRqmziTa+Yal6OGG3hsC+7F0SH35/CSy
 ON0HIXk2FMO7ZO6XfPn7nHO+KJga9/sCySg8B3evNVmqmf+0JsMcmk2U1HAEXc0OM2h3Ci1Hkxn
 6yypkGrWWO3Ls7XXAulTJdha0iIO3YStYu4PK4xtFHu2M73i/Nb8TUZ5v
X-Gm-Gg: AYBFou24RlZ/Y4pR2HFUIZT6IaZrnh7JnKcunEUmHT3dWwJPumj/NdhAISt//8aTL72
 9Ypnj1x3YaE5+BD+zPXeq3Tk7KoCGIAsXEzF6Gvv4rQgIY7Qkenl1qhZn6teQhbK2NKMv0Omwhn
 qF0QuQQUVFNAZJyFADLz7inTDGoM0abrYIlvZmoKpAE37viEguHghojxmDnP1gnkArYogUMlYKo
 C0Got9MxokD+NLZNm8UMoY17ENFf6kF6FYCoDZDFQ8jQJWORIUCuaWNXtnG/W+0mc6rG+H897YA
 FrJ+eVV628v+lPLmL+Fst714vXJXJn+eIVACv5mtaT5i+tD1UsCY63xUXbJN2R4U4d9LUg/PWLp
 QBK49e0QQCTHCtTIXcP82H8UVUz8MUSdzyeiuGU0=
X-Received: by 2002:a5d:5e87:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-485781d9ee8mr2486010f8f.4.1788336477716; 
 Wed, 02 Sep 2026 01:07:57 -0700 (PDT)
X-Received: by 2002:a5d:5e87:0:b0:482:dd86:348 with SMTP id
 ffacd0b85a97d-485781d9ee8mr2485889f8f.4.1788336477139; 
 Wed, 02 Sep 2026 01:07:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4?
 ([2a01:e0a:280:24f0:2cd2:7ace:8238:f7f4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72f02sm4535896f8f.3.2026.09.02.01.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 01:07:56 -0700 (PDT)
Message-ID: <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
Date: Wed, 2 Sep 2026 10:07:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
To: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, armbru@redhat.com,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260831183151.12626-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

+Shameer, who is looking at forwarding AER errors to guest :

   https://lore.kernel.org/qemu-devel/SJ0PR12MB8614DDFEE3A9575564EDEF99ABFF2@SJ0PR12MB8614.namprd12.prod.outlook.com/

On 8/31/26 20:31, Farhan Ali wrote:
> Provide a vfio error handling callback, that can be used by devices to
> handle PCI errors for passthrough devices.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>   hw/vfio/pci.c | 27 +++++++++++++++++++++------
>   hw/vfio/pci.h |  1 +
>   2 files changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 428ab2f069..a2f489b34d 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>   static void vfio_err_notifier_handler(void *opaque)
>   {
>       VFIOPCIDevice *vdev = opaque;
> +    Error *err = NULL;
>   
>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>           return;
>       }
>   
>       /*
> -     * TBD. Retrieve the error details and decide what action
> -     * needs to be taken. One of the actions could be to pass
> -     * the error to the guest and have the guest driver recover
> -     * from the error. This requires that PCIe capabilities be
> -     * exposed to the guest. For now, we just terminate the
> +     * We can retrieve the error details and decide what action
> +     * needs to be taken in err_handler(). One of the actions could
> +     * be to pass the error to the guest and have the guest driver
> +     * recover from the error. This requires that PCIe capabilities be
> +     * exposed to the guest.
> +     *
> +     * If err_handler() is not implemented/fails, we just terminate the
>        * guest to contain the error.
>        */
>   
> -    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
> +    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
> +        return;
> +    }
> +
> +    if (err) {
> +        error_prepend(&err, "Unrecoverable PCIe error detected for device %s",
> +                      vdev->vbasedev.name);
> +        error_report_err(err);
> +    } else {
> +        error_printf("Unrecoverable PCIe error detected for device %s",
> +                     vdev->vbasedev.name);
> +    }
> +    error_printf("Please collect any data possible and then kill the guest");

how about that instead :

   if (err) {
       error_report("Unrecoverable PCIe error detected for device %s: %s",
                    vdev->vbasedev.name, error_get_pretty(err));
       error_free(err);
   } else {
       error_report("Unrecoverable PCIe error detected for device %s",
                    vdev->vbasedev.name);
   }
   error_printf("Please collect any data possible and then kill the guest\n");

>   
>       vm_stop(RUN_STATE_INTERNAL_ERROR);
>   }
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index c9ab949870..c067bbbebc 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -146,6 +146,7 @@ struct VFIOPCIDevice {
>       EventNotifier err_notifier;
>       EventNotifier req_notifier;
>       int (*resetfn)(struct VFIOPCIDevice *);
> +    bool (*err_handler)(struct VFIOPCIDevice *, Error **);

Please add documentation, something like :

   /*
    * Platform-specific error recovery handler.
    *
    * Called when the host reports a PCI error via the VFIO error notifier.
    * The handler should attempt to recover the device and forward the
    * error to the guest if the platform supports it.
    *
    * @vdev: the VFIO PCI device that triggered the error
    * @errp: set with the failure reason on false return
    *
    * Return true on success, the VM continues running.
    * Return false on failure and set @errp, the VM will be stopped.
    */
   bool (*err_handler)(struct VFIOPCIDevice *vdev, Error **errp);


That said, I'd prefer to see AER forwarding first.

Thanks,

C.


>       uint32_t vendor_id;
>       uint32_t device_id;
>       uint32_t sub_vendor_id;


