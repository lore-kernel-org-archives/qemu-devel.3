Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C757C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYBc-0002dY-Nn; Mon, 10 Mar 2025 04:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYBZ-0002cF-BX
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:08:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1trYBW-0001UT-U6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 04:08:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741594103;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pL2ObvzrNSvxyqAwP+KydM2AQVwV9P3+kj9fufE1kXc=;
 b=hnyBN5T8PdO7OHm1CMb/aQVGbf+OaI+P9R7m6wffvl8HyeXJ5z0MjZu4BbxBuJORkkdBXq
 c3V8w3pmE5oH9NPI6GYbcB8JrIZGlfO3WJI11qSqQXktIY32FhDX/v5W8e0zbqa4dD8xQj
 64Cq0lLQpO/8pYoUAvhAAW1hdFVpHLg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-zVjJKSxsNF-cB2GvlUpAng-1; Mon, 10 Mar 2025 04:08:19 -0400
X-MC-Unique: zVjJKSxsNF-cB2GvlUpAng-1
X-Mimecast-MFC-AGG-ID: zVjJKSxsNF-cB2GvlUpAng_1741594099
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf64f1dc5so3257125e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 01:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594098; x=1742198898;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pL2ObvzrNSvxyqAwP+KydM2AQVwV9P3+kj9fufE1kXc=;
 b=aY43VcXaMM/5NDQ1SCEV8rdEfZz5G2LV9gKN3M+NZq1YBnV9d34D3MrVoYHji9hS/V
 yF1qp7WMFiBEa+x21AIPem/3E37M7lttUiKp83XTLFF7/iqMy0/QtWmLHZmvaLYUVRA2
 rznf7fp1LuOzOsBmTm4qZzO5LD6j+CoMxyjlWKWXcL0DBU78r0Yg37pzb9zGVWVk1Jp+
 nVbmaii3QKqzPxDbVyBoLIELoVWDKKLYloaAjc3/a/2e3WvUSmKvddl9S19n5rR2xiOX
 NaW1o+gkkP7HLVx6UExGNSDGY9PHtKmYn+NXdyTRsGEDegvhqM9m3AGeMfSnbc0T1o2m
 ZomQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD22IhcTXQHVuRgj/ssgdnsIjjXl10uD45ritABzklmH61cMABWid9HKTA5RMFxu27SgTlmzkYeyC/@nongnu.org
X-Gm-Message-State: AOJu0YzEgbq481KfXjQSFQkA0J38ykorqcktB9wP3vG/bfg2GDk6g3n8
 PcwegwYMsSwQdiOnuCFAbvG/Sq3+HyJOD1GlYfHvkQDLk9o9qaKgUzsLkngslYS/nAtdfMZjD01
 rzu6eOjlJgznsmIWUFyljSiLBV0FiD300TM/FHyU9I4agM5jY53tg
X-Gm-Gg: ASbGncu5uDrysFjBr+LPNS7ShhVnRu0RZlLchoVhOTG1aZ10epEfHzen8hHPtDKr4YW
 8wtP18olopxOv83t1E5E4LwQBEznpzklQ3T9ZXhE8iQYaGFjCMMggkIVGZX+yn8C+gmOX2OeMg2
 yPLb5TGeO65RU20lLM3MJ0R7PB6PphmzHFyKTDQdpRANZ/QlJ4bVuK/QL2sH0KObxtucyrCJbpE
 eELhb3DqQzVumzIhU/9+ae1bPRP6lnJUlFwkGa6SRyjyBgYyLajfiniEG6FhYdj/TqOxjH9NsQ1
 kvvS62CJmvEtRzOmtjtamTTTYEAt1Lu7OuDjp0dWIKKsWDhiPOMqmHyjup7mNoU=
X-Received: by 2002:a5d:47a2:0:b0:38d:d7a4:d447 with SMTP id
 ffacd0b85a97d-39132da0f2fmr6809691f8f.34.1741594098699; 
 Mon, 10 Mar 2025 01:08:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcuk8O08VAJ1w4B9X3sHWn33Nr3w+1n8EOHcUeysuu3RyyFRhoQg2nYaSRkMkylCw7Z8pRwQ==
X-Received: by 2002:a5d:47a2:0:b0:38d:d7a4:d447 with SMTP id
 ffacd0b85a97d-39132da0f2fmr6809655f8f.34.1741594098301; 
 Mon, 10 Mar 2025 01:08:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cfcbdd0a7sm9338655e9.11.2025.03.10.01.08.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:08:16 -0700 (PDT)
Message-ID: <510b65b4-3b7c-42b7-9108-4fd438055535@redhat.com>
Date: Mon, 10 Mar 2025 09:08:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/21] hw/vfio/common: Include missing 'system/tcg.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-2-philmd@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250308230917.18907-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org




On 3/9/25 12:08 AM, Philippe Mathieu-Daudé wrote:
> Always include necessary headers explicitly, to avoid
> when refactoring unrelated ones:
>
>   hw/vfio/common.c:1176:45: error: implicit declaration of function ‘tcg_enabled’;
>    1176 |                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
>         |                                             ^~~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/vfio/common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7a4010ef4ee..b1596b6bf64 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -42,6 +42,7 @@
>  #include "migration/misc.h"
>  #include "migration/blocker.h"
>  #include "migration/qemu-file.h"
> +#include "system/tcg.h"
>  #include "system/tpm.h"
>  
>  VFIODeviceList vfio_device_list =


