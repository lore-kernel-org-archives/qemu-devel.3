Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B6DC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubcCJ-00039q-PC; Tue, 15 Jul 2025 05:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcC5-00033T-On
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:43:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubcC2-0001kN-Ud
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:43:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso16157765e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752572601; x=1753177401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kY/eYN3xaa/LgSoax2gXsEhBQn5eUx9hTap41Cg8HxY=;
 b=kFPH1i+QR06W7GY9f5Fimo6WGqkYkgmchSuHm295YmxRLutJtzvp4u5v9cTWW72VhR
 CMGapKnH7NYavuKEqyPOC5tt4jLN9O2V6n265P01tr1Dc2An7+WBcJfeU+jlhMNNbYmy
 G2waWk3CouLp1yDahNoWES3dG2SRUNYg77n4uCb3ueektitWFfhEx3uOLfNcdN05Ck6D
 CbuB3M6EnAO7zQSa+ScULD+joP7r5hg2rdrcfLD4udaoAknZeOfr9qP7Z1CiY2/2pOAx
 Xzz871Qg4OY5VzSsw1NgLS2Lb4PJ8qbH5hcg9mi4sl26vATYz2wL4GDYYw3nemRTfn9X
 c4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752572601; x=1753177401;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kY/eYN3xaa/LgSoax2gXsEhBQn5eUx9hTap41Cg8HxY=;
 b=SUTKrq2EIr41LaYAfyvbsd1ZnpllQx3kd434rrR9IigqfFMRDgxxNUqS928r/MZnnS
 JgpFj5xIq4tmKRq9L6sUsAyzEq6IgT/1rnZIJVTjhKnuHfyd6NV0ndXFiXSw9tI/5ljV
 SdKOenwpBEhSJCiAFQ2oRcD9F7CWxDIgYdcnphNBJvMtRDkjyAIVZiWsCrtWcPLj6giX
 RlNzExak1B1aexM63vsnZpj2tgiEuzlscFLL6jigqgJ6bs2OBfn3x00wrmqVAdhAEtb3
 Ebpjd8s2/qgCJtXb099mAy3DRRHwyW80Bb7Ntkg+wuYzgyg5aGPY4ubcB3qnOALZSPSM
 2lOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnk9KplfaYbQMFZgVQ/4pSJzOZh2VUbEAY/Y6Q323be9aeP6pQ51606VGX6fVN3g6y3GthGw6apl7j@nongnu.org
X-Gm-Message-State: AOJu0Yyf/ezIY6E+33wWekuMLzLKrgdC81CA5F7YqGd7eAioQ4AofU78
 V6sXNJAeVTDVGn9pm9RAegbk/tkQcWQiK+2dHkWgVcVyIIWinO2tLWV+cxppNPSg1Z8=
X-Gm-Gg: ASbGnctUKLRQqwIQ/wjz7RwC0B4hDYegA/0R7B1gnmTIumG72xF6F66zCsccO0ntbYi
 ZxTqkKdRIFzI0YR/cVMV3djRlXoOXBldrUYkZikLgy0vbQMy7L2fBLkEPw8yQvb1Kq3L76Fw+re
 f9OJ5MIaOxPBbzl9DD/uoZzjf8D6sHHj7k7qEdXCJz2r/i5GffCIcP3FVMbvJGOoNaTsSinaEcF
 TrSVHOOyjuf9VGx10aUvm4qIGzdu9bpTpRakCEd2Y1zr7dgy4DeQ+aLzh8HpKUmew0lU2EgQ2v5
 JEF/3nWL5GtFRnQFKdgXD4pLzCVcIPP2j1tyinOFsOKQncPvNvD6Zal1gB7BkA7yRLW+Tt8WM+Q
 wA9/x+TJn3vcqQovXodl8Jv3YqLlIGZStjoc5luBX9JIebneDhQ/XWJSfetb+WHvr3ZYBsgI=
X-Google-Smtp-Source: AGHT+IGB9AqfJ9+3kraCiu2FqdmUEShiY6i5l9GwPveoBXQEigiAO8BaCtHUIOMGDhIbB1wS3IOV/g==
X-Received: by 2002:a05:600c:4e54:b0:456:43d:118d with SMTP id
 5b1f17b1804b1-456043d13bbmr131201755e9.17.1752572601251; 
 Tue, 15 Jul 2025 02:43:21 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45626c9ac1dsm13171215e9.0.2025.07.15.02.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 02:43:20 -0700 (PDT)
Message-ID: <402eb756-4fc5-417f-839b-0df10fb625c6@linaro.org>
Date: Tue, 15 Jul 2025 11:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/22] vfio-user/pci.c: update VFIOUserPCIDevice
 declaration
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 danielhb413@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
 <20250715093110.107317-12-mark.caveayland@nutanix.com>
 <af69d05d-eb73-4f3c-8d53-89d53fb5375b@linaro.org>
Content-Language: en-US
In-Reply-To: <af69d05d-eb73-4f3c-8d53-89d53fb5375b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/7/25 11:42, Philippe Mathieu-Daudé wrote:
> On 15/7/25 11:25, Mark Cave-Ayland wrote:
>> Update the VFIOUserPCIDevice declaration so that it is closer to our 
>> coding
>> guidelines: add a blank line after the parent object.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   hw/vfio-user/pci.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
>> index be71c77729..da6fe51809 100644
>> --- a/hw/vfio-user/pci.c
>> +++ b/hw/vfio-user/pci.c
>> @@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, 
>> VFIO_USER_PCI)
>>   struct VFIOUserPCIDevice {
>>       VFIOPCIDevice device;
> 
> s/device/parent_obj/?

Patch #13, OK ;)

> 
>> +
>>       SocketAddress *socket;
>>       bool send_queued;   /* all sends are queued */
>>       uint32_t wait_time; /* timeout for message replies */
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


