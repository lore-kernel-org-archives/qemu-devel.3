Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D577C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qrG-0000vX-El; Thu, 10 Apr 2025 08:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qrE-0000vK-Ty
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u2qrC-0007VS-RK
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744287487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hae4jyWZXzzi6i60Izn7jrRI/3U4COE1CGPsx0bnijw=;
 b=MTkqEoUk6J6LZK9cG91Mi4DIiaBCPX5H5VcPSMctn4QhHYLvl5Q+qpwmZU1MYNUWEUOJNK
 Ut8pldYaktv0oGO2u8txErligzsZRu7iI4P3a4tBfLZbZjmF99B6yPevYzyGUCmCqrEyyK
 af+TK5vy1WmSfCumIWLChy2/HTEyPqk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-ReVRm6_SNRO8oGxxzpf9ag-1; Thu, 10 Apr 2025 08:18:04 -0400
X-MC-Unique: ReVRm6_SNRO8oGxxzpf9ag-1
X-Mimecast-MFC-AGG-ID: ReVRm6_SNRO8oGxxzpf9ag_1744287484
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ac3dca41591so76020966b.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287483; x=1744892283;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hae4jyWZXzzi6i60Izn7jrRI/3U4COE1CGPsx0bnijw=;
 b=JJ4DimODHvWtLSIbkmEMMikLar/dUHRaxlQyvX7qzUtVSnRVKwma21vvpf4/XeGjTd
 /Ke6GLkrsR3hSlRaROLkUZ7NZs1h2K63EFEB4ae2LLft3UwUgBPxLDduRLEAATAj4wZQ
 MBHh515fnWvXNMcjpXVJcvETDPLVMPW/m595uDMnBJXK8qWGcFuoSd046HANyjEX30FG
 spFCCSXeC/5bWcbNolpyqd8lFmB5ZiDsk7yvM81Y0StdugT9Dfc/SMGFVU9Jv14AGIIG
 fC3PH7wNOSDQNkQL9anJuvf/f8vvwQqhcfnqQpdXfIyGYfXslxO1Hfpabc94WBnwZJ9Q
 Aabw==
X-Gm-Message-State: AOJu0YxQ5liMlnKMWJ3du9t0AJ4C/WNhU9MdCtNmbYLPai5quHMo8uLu
 iy29UKkDos+yfTaaF1yLwMyG7f7ENtQt0j5uoMdDLjtAQrsSOsXku3m4Vhe7wNi+UQz4Q5Rh9A8
 9xx+Ruks0/Fcuz93jcQKBAxRxCM/2170lLk69DgBHmw2Tsij1aNKp
X-Gm-Gg: ASbGncvUR8HsAcidMf4cWylW4DwsRxdhDJYJpeyMZpLhAKaDTKQM950nJlsZijYbiOJ
 9OvCHNMUUc7aevT3zrJgv2DAUOd8wtYvFLGgSRipnF5Dhnd2sXqrTJBfdRQqYcG+OB2XetAp8nD
 3ELTxduXGw6cgAqdGRvk6rF3MhSYguJCk9LoHy4Ywa/qVdJJAMpV//1e7JRq9dvjhRPoSavhKbB
 ltNgGuE10oKEva3B7bbMVj85Ajp4zXv/1nIEvNlyr0Lq5bx01kQGeF4cYqWT7vTcxnQbUUYmzNZ
 +DLQDsqX6qjK0rtjKw==
X-Received: by 2002:a17:907:3d4d:b0:ac7:d7f3:86d7 with SMTP id
 a640c23a62f3a-acabd4cf63fmr277457066b.50.1744287483568; 
 Thu, 10 Apr 2025 05:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdBJ7iH75HGr1fnN4bCfoad/2DkVUrmVT8k5QWfDQEe45oJG2/YOMkCofAwreWdC9hncGmug==
X-Received: by 2002:a17:907:3d4d:b0:ac7:d7f3:86d7 with SMTP id
 a640c23a62f3a-acabd4cf63fmr277454266b.50.1744287483210; 
 Thu, 10 Apr 2025 05:18:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.103.255])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-acaa1ce70ebsm266799266b.178.2025.04.10.05.18.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 05:18:02 -0700 (PDT)
Message-ID: <4f64f6a8-2e4a-4e20-b2c8-8f87b8b7900c@redhat.com>
Date: Thu, 10 Apr 2025 14:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scripts: nixify archive-source.sh
To: Joel Granados <joel.granados@kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250408-jag-sysctl-v1-0-3f4f38b751be@kernel.org>
 <20250408-jag-sysctl-v1-1-3f4f38b751be@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250408-jag-sysctl-v1-1-3f4f38b751be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/8/25 22:14, Joel Granados wrote:
> Use "#!/usr/bin/env bash" instead of "#!/bin/bash". This is necessary
> for nix environments as they only provide /usr/bin/env at the standard
> location.

I am confused, how does this not break everything else?  All the test 
scripts in tests/docker/test-* have "#!/bin/bash", and configure has 
"/bin/sh".  How is the environment that runs scripts/archive-source.sh 
different, and why should it be fixed in scripts/archive-source.sh?

These are genuine questions - it would help if the commit message 
explained those... In fact, what is a nix overlay and why would you use 
scripts/archive-source.sh to prepare one? :)

> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>   scripts/archive-source.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
> index 30677c3ec9032ea01090f74602d839d1c571d012..a469a5e2dec4b05e51474f0a1af190c1ccf23c7e 100755
> --- a/scripts/archive-source.sh
> +++ b/scripts/archive-source.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>   #
>   # Author: Fam Zheng <famz@redhat.com>
>   #
> 


