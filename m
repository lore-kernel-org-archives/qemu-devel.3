Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C4EFD8777
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UtK-0002tj-De; Tue, 17 Mar 2026 09:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2UtE-0002sn-Ja
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w2UtC-0006DE-5t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773755716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OU5fMJL3ryHMNghDz7h89NoZ8Z4MnlawYLvi52p2Ir4=;
 b=e9h9KHw9g36ax7Q+r8rYrYR/M3D8rp4yAU/QZLSBX7GY+MopKQfo6hwVknQBkaYe+pauRH
 nWik0DFzLx9PT1NW2YrUWtA3Xqti9E7wFr9GwehMU3WyatgqZ2erb2qRwlH4AcZmULXecd
 is2RZHDATkC0NaJT4a6SjtoaNfSix38=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-mG-JabmdO4W_YPJzSLeSHQ-1; Tue, 17 Mar 2026 09:55:15 -0400
X-MC-Unique: mG-JabmdO4W_YPJzSLeSHQ-1
X-Mimecast-MFC-AGG-ID: mG-JabmdO4W_YPJzSLeSHQ_1773755714
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853ab1cae0so49565065e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 06:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773755714; x=1774360514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=OU5fMJL3ryHMNghDz7h89NoZ8Z4MnlawYLvi52p2Ir4=;
 b=X5v+D5hB03/t3IQMiYQGTxjBAs8Kgglz9otS2cDk1xvPCpbpyeNeTYXsSAzxWgYxaZ
 CmegjYL+gQ1zRvIfYoRMK5iQ1Gs8ZxjiJgriGdeMCULVoGrho18T/Yq33kcvUDtw2Z+P
 8vyitaRhJYnChsTPVrzkFtWyN4GzcGvgRxYn9EVNAWVC+c4xJ3NSVCLG7hf5dS0KZ8KL
 SpkJNe3BOrSsBa8qDAwnxUwKkQWiFMedNL4aAobMa/p3cFL5BJa1HgyvBMKBdHjlGWkj
 RKI3erX0+7D9MskA9uN0i/Tly0qdp+IGCqruH+T1QAWTyYZnD8dnJEshn51H+KyLIDTd
 ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755714; x=1774360514;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OU5fMJL3ryHMNghDz7h89NoZ8Z4MnlawYLvi52p2Ir4=;
 b=sqvcM/sgCO7EK+Q0xuFGtnz+k1J8bpnfb6pb16v5Mltr6SAX5CYLoF2k1CawDp2z3t
 mdVh1pkvJ5kT8A6v2eM/s7MfLgaqkjwRBOYLfluVcmSycHErWuGsOgG8/TQ6TiOJscm9
 mJslxaplaiwrQJc8DpYSGReq97cbKP6cj9pA1SXGd/9kPTc+sgkkMoslOap2y7Rmi3HC
 EMfhHiZj3/2EziDmKvL93wHPDqAlVBjxlre9AHyn1Z2G6yREE94LPxC7+zcjtBPdVTPC
 OA5fHWzvOqV0Qt4Ojnt5blRzMCD8hbQKpoBU8LOJQ6o6ANkPvglpqgMZBIxC8LfdOQbY
 uJKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXwYEjaaG3lDvyUGRGKtI7f34xLeHJ6mHQTUOJjjq0nfhOanvVXb7oUDu/JVeE5mP7xIavEd062RA+@nongnu.org
X-Gm-Message-State: AOJu0Ywi9keZd3eYcvj1jNYvGpH8oPUOUPFaUwkix9yNwPPrfL60WgoC
 0MstH9Ppyp4ePFtcdDHSRuLBbKc3zp2m529R9XYj+6rnC/M0SefS2/7NEhj8Z60UGVMmdrkANko
 CN9V3JyOTaPu80Bi82UYADGeabAj8Dg2VISnPdc+ChIiqCd3Y9bmeYqMg
X-Gm-Gg: ATEYQzzQ2RCwvmwPUmSvokKOde5jiOaP1+U9pKCyI4fIpHhTD9f0FXJavqDW5+UA4LH
 qkYfRnUZDp6BgunmVDroAwogyivHnNBCWIgI1zrf9NyF+CuLXIvNL/ogda+PoEyv3j6bIMelRv0
 Dk+7oedMoG4y6TVY5ll3kddwcx4ZC4AdEUte8iElARshHHwqxUDtRk7tE1UxC1L02m4yaabnHof
 et4/4OhbrzpuVG2B22AHqf5ELW9oXSfjzRoMCx9GOqSzsRICVixTpn8GXa7Mfb5i9OPmPRGadF1
 WORYnPZmX9qfiv6EW+blk8iOczwN70GmFFuOTG1ufdwCv2jE/lnqUT7GN2ZgV4G36CvOIqZShxZ
 4IvDJabk7/EGmRPHvmOuxmtlP4+V+SjKENaNwE5YWkumngH5aHgHdfStvaIQ4
X-Received: by 2002:a05:600c:1550:b0:485:38fc:7069 with SMTP id
 5b1f17b1804b1-48556704780mr287640055e9.23.1773755713619; 
 Tue, 17 Mar 2026 06:55:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1550:b0:485:38fc:7069 with SMTP id
 5b1f17b1804b1-48556704780mr287639445e9.23.1773755712934; 
 Tue, 17 Mar 2026 06:55:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea8e3cdsm70323845e9.2.2026.03.17.06.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 06:55:11 -0700 (PDT)
Message-ID: <e8254fe0-4c23-4b92-9549-a15ce2627bfb@redhat.com>
Date: Tue, 17 Mar 2026 14:55:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] hw/vfio: eradicate CONFIG_IOMMU from sources
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org,
 eric.auger@redhat.com
References: <20260315070834.198331-1-pierrick.bouvier@linaro.org>
 <20260315070834.198331-5-pierrick.bouvier@linaro.org>
 <8bcc2cb9-6562-4ba2-be95-04f8b23e40f2@redhat.com>
 <0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <0cc139d6-9289-44a0-9122-d701426dae0c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>> Let's come back to the proposal. Currently, when the QEMU platform
>> doesn't support IOMMUFD (i.e no support for the backend), QEMU reports
>> at runtime :
>>
>>     qemu-XYZ...: invalid object type: iommufd
>>
>> As a consequence, the vfio-pci device doesn't expose the "iommufd"
>> property when the backend IOMMUFD is not available.
>>
>> However, the additional filtering on the vfio-pci properties based
>> on CONFIG_IOMMUFD seems unnecessary. Instead the "iommufd" property
>> could always be exposed, whether or not the QEMU build includes IOMMUFD
>> support (kernel support is another topic). If the property is used
>> in an environment where IOMMUFD is unsupported, QEMU will simply
>> fail to create the IOMMUFD object.
>>
>> Could you please rephrase the commit log with some of this information ?
>>
> 
> Sure, how about:
> 
> {{{
> hw/vfio: eradicate CONFIG_IOMMU from sources
> 
> This commit removes usage of CONFIG_IOMMU in hw/vfio sources, exposing inconditionally iommufd related properties, which are declared statically (in const arrays). The alternative to expose them dynamically is more complex and requires boilerplate to set properties at runtime, with set_* callbacks and added logic to check if iommufd backend is available, with no obvious benefit.
> 
> One difference is that user will have a different error message when trying to attach a vfio device on a platform not supporting iommufd.
  
> Instead of:
> ```
> $ qemu-system-* -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0

This should be

   # ... -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
   qemu-system-*: -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0: Property 'vfio-pci.iommufd' not found

but, since we need to specify '-object iommufd,id=iommufd0' anyway,
the error is :

   # ... -object iommufd,id=iommufd0  -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
   qemu-system-*: invalid object type: iommufd

and it stays the same with your proposal :

   # ... -object iommufd,id=iommufd0  -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0
   qemu-system-*: invalid object type: iommufd


> invalid object type: iommufd
> ```
> 
> QEMU will try to attach device and error will be reported as:
> ```
> -device vfio-pci,host=0000:01:00.0,iommufd=iommufd0:
> vfio 0000:01:00.0: vfio/sys/bus/pci/devices/0000:01:00.0/vfio-dev: failed to load "/sys/bus/pci/devices/0000:01:00.0/vfio-dev/vfio0/dev
> ```

This error only occurs when the kernel doesn't have proper IOMMUFD support.
I don't think it is worth mentioning for this change.


> Note: This second error can already happen if user's kernel does not have CONFIG_IOMMUFD or CONFIG_VFIO_DEVICE_CDEV support, but QEMU has it.
> }}}
> 
> Anything you would like to add?
> 
>> Thanks,
>>
>> C.
>>
> Writing my answer and seeing current behavior, I wonder if we could not have better error messages simply by checking if /dev/iommu exists when setting the iommufd property of vfio-pci device or when realizing the iommufd object (-object iommufd,id=iommufd0). For the latter, I need to double check order or initialization/realization as it might be tricky to catch before setting accessing vfio-dev/vfio0/dev.

yes. as said before, QEMU attaches to the device before connecting it
to the IOMMU backend. So the iommufd object is unused until we reach
this step of the device initialization.

> $ qemu-system-* -object iommufd,id=iommufd0
> can't create iommufd object: /dev/iommu not found
> Is your kernel config missing CONFIG_IOMMUFD?

Why not. Would you have time for it ?
  
> As well, we could report "Is your kernel config missing CONFIG_VFIO_DEVICE_CDEV?" on the error mentioned in commit message.

This could added in one of the error messages of iommufd_cdev_getfd().

> And while we're at it, in case we report one of those errors, we could check target_arch(), and if it's not one supporting actively support iommufd, say to the user "Linux does not support iommufd on this platform" instead of "Is your kernel missing X or Y?".

The Kconfig file of the machines have 'imply IOMMUFD' so that the object
iommufd is only built on systems where it makes sense: i386, arm, s390x,
as of today. We should be fine.

Thanks,

C.



