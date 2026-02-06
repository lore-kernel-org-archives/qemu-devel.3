Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7B3EE20AA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voMqJ-0003c6-OB; Fri, 06 Feb 2026 09:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMq9-0003Yq-99
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voMq5-00032j-5T
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 09:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770388180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ovnSCrq5WWYg9tcLaZdhgLOhDRwm4kockAzTs0MrQms=;
 b=dTF3N8NDt29VNwF3RD0LdjlXHgA6M9pbOL7XhLUC4dNGGq0NJ5HZfSm3iQP2vTtRw4AL1H
 UCaZdSaClIaEDr9QT53WEI9syQmwFsHWTKlySLdjMmQ7JjOxCePh/3mPXdzedyCKnegNko
 ixgUoX+4mw5Gy+bPxTtWCX3O7HQOfhs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-JYSFEjcKOUu4Eesq5RQldA-1; Fri, 06 Feb 2026 09:29:38 -0500
X-MC-Unique: JYSFEjcKOUu4Eesq5RQldA-1
X-Mimecast-MFC-AGG-ID: JYSFEjcKOUu4Eesq5RQldA_1770388177
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4804157a3c9so6881635e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 06:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770388177; x=1770992977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ovnSCrq5WWYg9tcLaZdhgLOhDRwm4kockAzTs0MrQms=;
 b=i0Q4aAPoMknCFkNIBp44OFkVKqpHD0CpfofmKGBRiS9yQdd5seOIFdiuDA0a9BUnin
 mzTEmoVpjtKNt15DviXp5PdylWgKMyMyv3pHpumFysHDcdEW9B2sbCrLM4dchp4F2Sc2
 Psoo1QBO71iobE6kv1NWSriSF7Z0QgjcpxQS4ZgH5yQAZtRIyqlTyHWuaRGx3oxTrK41
 VEyghX0ZfD8XZOdpznjpT6ZCmZPHxDseGEuAKRt2BrpGm7mGXeQRPYCkzdEZ96QBujv1
 FOqyc3gynO+wT6EE42GM7xGT6pf2xWuSpwHUt4DgFTSpQsd4t3yeeE+kIwHRWB0U5IkK
 G2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770388177; x=1770992977;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovnSCrq5WWYg9tcLaZdhgLOhDRwm4kockAzTs0MrQms=;
 b=kWEtDuYRqOTjw6ZgFGpkJdfxQu0alfGiDRjN1JhE1Cp9Vo0oTtxOtQjHmG0tqMwIQ8
 Gk5HV9T/pgPYmoZ/pZqid1wjzTUynGnMQ4iXrDcRs0AJI87ooXY0XyTN4SLmLdhiGCD3
 uSzN5RcmBhwEGVhCIa+K3cYtbe0fsTEqROGYokon+jxs4u0PXCA1pJuhPzi0G7TVow2G
 Vtf1Larn7E/IG+qPx5JcJyt3a39bc18RoMwLk19NrExSAPEk3n8ojIgRss/vxl7Arqxe
 fXNv4WA3L8G7dCOYqK07BrwlK2mFjPAzOhewn1/JP6xF8OlQ2hNtJGn7LtDv3x6fEWAj
 EnZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAOQrgjFKe0H/TVO7Yje4JRQXi3LRYM1YqjnqdzQfmWBTKCNKsrMqWDJzmD6H8FRqSxEosBFp12bcS@nongnu.org
X-Gm-Message-State: AOJu0YyqcOIlSXUdTGMkEGzRuwnKZxNWZsywSPDBMCHGgZ/9Z+fugb2W
 8quWiq1aj+Uk9ZeJ2agUNc0dksC9+3F9UNcC2i6PLR/6JS0LJQ/KauUVwzw/uOFXk3Hn/5PpNI0
 VaSlO/pWHzhbguOTIOPRdRSHxgKUsaaoYhY32B2PSePSqKpVfgB66bX1W
X-Gm-Gg: AZuq6aKg0Ar7KC28RFhHLZ9JM9zLAE9+lpFwHKecwOVYcI1/84qnh2vGw7I2ccfgSfs
 gk+VwIH+7q5tdEciz536vntPYkC/JhB9b1uWBH8YwGHu4/w13p70Odhd4yYv2HtubYaonTA2e91
 NMgy6wgPJ8U5zHBGr3QQONz+wSSuA6+uV2cps3Wo2EFSF692w1c3gdBnxNO57ACv/KlBqWb037G
 b7YxX1GSpcY7//6Gywd6wx1Xux6HJ0wopW1OnjLwZz21OKYRGgRiDGZaTbDTmGXbrbIM7JSq8Cm
 Iv5rnjJx7KKT0CoGGKyX7hGXYvTA4xhbn+RWpdCla5dOcXL1LpfD7WSJ4QmZ2H0Ol7Rx0qadIUb
 g7ksp+oc=
X-Received: by 2002:a05:600c:4748:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483201e46c9mr37668345e9.11.1770388177395; 
 Fri, 06 Feb 2026 06:29:37 -0800 (PST)
X-Received: by 2002:a05:600c:4748:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483201e46c9mr37668025e9.11.1770388177037; 
 Fri, 06 Feb 2026 06:29:37 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320638ff7sm62844695e9.0.2026.02.06.06.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 06:29:36 -0800 (PST)
Message-ID: <9e553835-8821-4b7f-b29a-c785bd8e837c@redhat.com>
Date: Fri, 6 Feb 2026 15:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/14] s390x: Build IPLB for virtio-pci devices
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20260127161547.459443-1-jrossi@linux.ibm.com>
 <20260127161547.459443-13-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260127161547.459443-13-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/01/2026 17.15, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Search for a corresponding S390PCIBusDevice and build an IPLB if a device has
> been indexed for boot but does not identify as a CCW device,
> 
> PCI devices are not yet included in boot probing (they must have a boot index).
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   hw/s390x/ipl.c                  | 56 ++++++++++++++++++++++++++++++---
>   hw/s390x/ipl.h                  |  3 ++
>   hw/s390x/s390-pci-bus.c         |  3 +-
>   include/hw/s390x/s390-pci-bus.h |  2 ++
>   4 files changed, 57 insertions(+), 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


