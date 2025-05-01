Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF74EC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbn4-00025B-Ql; Thu, 01 May 2025 17:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAbmz-000248-HN
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:49:55 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAbmx-0007eo-Ts
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:49:53 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d812103686so5062435ab.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746136190; x=1746740990; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rr6BFBQrpoBkaUZeh7DoqYwcB8XwJFEp9+Dw7V6RYH4=;
 b=UHS/v1A73tvvnrhRqMPhDDYmWrQmb/W8U/UwJNtN/yYpi6lVeU8xSMqMKP/tgIAW9C
 zCcEIkyuFSH31oMgmA2USBSjsSCA5Qt7HEnBMmLSowOpU6lS9+wFCb+E4R0VvlMY58aC
 jjtQk97JiVjlXKgt6V+TsjdzWvPcctT/oaRV6GhaPlefapCsbEpn1SdYHtZIlJ5RkAxb
 w0qpgqxJXWwwnEBIHZAmM0aQGfF1oeVDUv0Npo2EEMC+VxVNFx2jbodLePZjvEdE66cL
 vUhFuJMuPMDfzufJ1gKqGGG5icQ0NsScKzRoNd1+5QHb5upJ5eCun3O9yr7xYmxLeMt9
 RNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746136190; x=1746740990;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rr6BFBQrpoBkaUZeh7DoqYwcB8XwJFEp9+Dw7V6RYH4=;
 b=jLsjCezZiaYFeTkbdpnCzx1GsEbcJJ7pVbyXKwBir8j5+Dky7J5NrWVQnBpFXquYDz
 hwnHeu33xTdE8j6P2ZUze3ElqWgcSbmFjA6QtcI6EkhQ/V8b7hm+Sntt4lwTDmZq8dVt
 LbO6RabQ/iKcwo6IThtEwG4502N4344WPyiSeV2PGzFCyVv1XeRQV9JZVl/E0Db5J8s7
 jMXJwKii16+TlmJxwFIoAUcJyp09WLjr+DRQS/lfSf0cqkYRp0trRVkKKLdEMTIryK/D
 8uh69ret/jIeLE4q5F9j1NeWC0Qx0QncrcczSYj/MSbVnAdNfUxltX3ZHcnQJdYunDBV
 NIRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo/pkKJETSls0DCW4gQo2u/vDhidENW1dgGCKbD41CkYK56y5fj2d+X6vX2TnOia2mrwcphGometRm@nongnu.org
X-Gm-Message-State: AOJu0YyZVKrkj+QRIhscS/RiegtQ+XDVK8y8FB2OlHFEMdNXzLftPyvd
 9NmS206PO1BgEYRFt4mRp+qPQ0DaBpBMTcUdWOQE0dtsow/TWxmGMuIPjh9dt18=
X-Gm-Gg: ASbGnct0HExA6U65vPZ7fm/LSQguMynw99M6HVffTxUywUKMmG3b97Lqd1Y0G9Tswmp
 TBgLKN4A4JVrNxwPFjdKHBulYziOPrD56aOG7h8Zy1RVpub0eAAS61He9EUQMLy5rY7qjeCB72f
 p6/Jtvuu1vTSokHLEVbjjWVZRmwD+WIYNB94vDokV7G0vuNYPe3snltdOKAP8yYpLVSUzbLTod8
 fZRmAsqxkKySuVlqMPPUPoyj1Y0wnxSapzGl6EX1j1OO7HV+p6uQ1yFufBJNeWEkkBrN0AW1whJ
 /2/DELd/EXe1RDb1ehj77+L6UAquY9Y+3nqD+v/u2QpvQE2PPhNYjoBq/DuTYkjgPWfh8sIhnhN
 z5HSU9nlol4ox7A==
X-Google-Smtp-Source: AGHT+IF+PiU0/Kg2yfNoRftmPiOM41YJkxyELYES2SKx5WZSsMyO+vdbOTfpnPmc4Qdx55zGcq4S/Q==
X-Received: by 2002:a92:c512:0:b0:3d8:17b4:1792 with SMTP id
 e9e14a558f8ab-3d970aa462dmr53305105ab.3.1746136190245; 
 Thu, 01 May 2025 14:49:50 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aa58d6fsm60724173.89.2025.05.01.14.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 14:49:49 -0700 (PDT)
Message-ID: <1528a021-d3ec-495e-a42b-6614d60b0666@linaro.org>
Date: Thu, 1 May 2025 23:49:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC qemu 1/6] hw/pci-bridge/cxl_root_port: Provide x-speed and
 x-width properties.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, mst@redhat.com,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org,
 marcel.apfelbaum@gmail.com, Dave Jiang <dave.jiang@intel.com>,
 Huang Ying <ying.huang@intel.com>, Michael Roth <michael.roth@amd.com>,
 fan.ni@samsung.com, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240712122414.1448284-1-Jonathan.Cameron@huawei.com>
 <20240712122414.1448284-2-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240712122414.1448284-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

Hi Jonathan and Alex.

(This patch is now merged as commit 1478b560902).

On 12/7/24 14:24, Jonathan Cameron via wrote:
> Approach copied from gen_pcie_root_port.c
> Previously the link defaulted to a maximum of 2.5GT/s and 1x.  Enable setting
> it's maximum values.  The actual value after 'training' will depend on the
> downstream device configuration.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/pci-bridge/cxl_root_port.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 2dd10239bd..5e2156d7ba 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -24,6 +24,7 @@
>   #include "hw/pci/pcie_port.h"
>   #include "hw/pci/msi.h"
>   #include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>   #include "hw/sysbus.h"
>   #include "qapi/error.h"
>   #include "hw/cxl/cxl.h"
> @@ -206,6 +207,10 @@ static Property gen_rp_props[] = {
>                        -1),
>       DEFINE_PROP_SIZE("pref64-reserve", CXLRootPort, res_reserve.mem_pref_64,
>                        -1),
> +    DEFINE_PROP_PCIE_LINK_SPEED("x-speed", PCIESlot,
> +                                speed, PCIE_LINK_SPEED_64),
> +    DEFINE_PROP_PCIE_LINK_WIDTH("x-width", PCIESlot,
> +                                width, PCIE_LINK_WIDTH_32),

Per the documentation:

   We commonly use a ``x-`` command name prefix to make lack of
   stability obvious to human users.

Are these properties meant to be stable? You mentioned "Approach
copied from gen_pcie_root_port.c". There they were added because
of:

commit c2a490e344b4e231cf9488c67df7ee46977b1ebe
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Wed Dec 12 12:39:43 2018 -0700

     pcie: Allow generic PCIe root port to specify link speed and width

     Allow users to experimentally specify speed and width values for the
     generic PCIe root port.  Defaults remain at 2.5GT/s & x1 for
     compatiblity with the intent to only support changing defaults via
     machine types for now.

This was 6 years ago, are we still experimenting?

>       DEFINE_PROP_END_OF_LIST()
>   };
>   


