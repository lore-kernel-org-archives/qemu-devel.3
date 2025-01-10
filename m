Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FC4E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 06:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW8tb-0005B2-NH; Fri, 10 Jan 2025 01:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW8tZ-0005AK-VF
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 01:53:25 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tW8tY-0004MJ-G8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 01:53:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361f796586so18051955e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 22:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736492002; x=1737096802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NysGpnhz+JRhaaLwqNVketbtskncAzhW/+7oJdgz4r4=;
 b=aB+bZH3AYFv5u/2XMSSRnv5Sx766xfgz2m1CNU92SI+FE7YSN5fbyehN3aFPaUzd8T
 XXRuMIVw6DcVHWQHVXaQpoLv7fxrrAo3vsRHk3ePcMG1p5Rl7V0/O8MVMAWtRKtWcSwe
 /197DiN/MKW7JQz3Tgz2u53LhN+QWKuaIRHzef8XPAmC51XDuLtxDPz8UCm7Y48vdyNa
 TNZgcUcmU4S9UcDNrRWbpbGu4WTZVocsKVXhXZE9P2Ds+WJVwSvxI6blC5eFRVRAwTN6
 otV6DpPdGVHQgaNa3ssQhEWwvEFQYf6tS7MQ/8IZYtiShBe5yXJ6EMfFFO23l4iRtHnh
 uIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736492002; x=1737096802;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NysGpnhz+JRhaaLwqNVketbtskncAzhW/+7oJdgz4r4=;
 b=H5sgnbTQ+tC6fuYLt3+1k3xVSISV37b6cjXwttR2HWEr4yWufeHnbnyr8Dx3Qp+2Q6
 E1NZEItKaMAnI414gTFOXlMMsjwNbYzDX26M1o8TnvXV3m/l+nxGd/UwphxzzUX23zP3
 4su3RDgmYOjE6mdwzsReszNXF705Bt9Nbxr+zAV6q3vFDajQ50mAT483nFD1uIjWs7Vs
 pAWA9vLGyMGC+1IbDSdTnGH1mSM0+FJMDUXZCkGt55ACVXytwoetSM1cEv4qka+Z4IcG
 1CnocJEnMlOnUT4gEC/6/qDsPFYAOPrAkamlajdn/JBIgYViLpOFzk+KCjo0xIC2fydu
 yDhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp9LhZSN21tDvqsA0RVCZXUrGJ8mtJbi6KGjluyXczNl5XjmOefzt93FRFetJZQRxhFHgalosVcPGz@nongnu.org
X-Gm-Message-State: AOJu0YwxxfJ6IzuJiEBonhHvodPyOGGG6fQ7pKUL4JlWsoEVLmrAK5/S
 3Xx/rVbx+r8Mbx7hZbkVX95aMMdYRY3kSLqFmP7dJpxO2VR6Fw3FATXl/SWxeE0=
X-Gm-Gg: ASbGnctJp4U7rBKho/NXgl38UBwnJ3kbuJ4eZeDyuzlGtne9ggZZf0sNKM1dPCt5+Hp
 9g+vJ91W8/0itI2n+R/4vdAy9UQaW7+iX/AM7EMwTinM/qhJ4P2AY0d3jMxyFT6zwylOdgq0nas
 DhJ223WdyKLJbc/Yl6ka0zrcR/b2zAYAPBq1OWWCl5o3DZdqBzSK0fWq6zr6Cg0OrtCunx+2XSp
 UIBExp7Tf4QIfVgpfKvSfJ80WZAC7smbhckqzooJXzeQ8+tjwayKwo/DSVpTBSVIESKs+NOhTeO
 xL4xrrbvbpH+3gXJTf5DLk4zGaM=
X-Google-Smtp-Source: AGHT+IFjkW/LHk5V3Ii4A5kY2kxRjWTF5f6MfDNWIRjZLL1uP8uQRGhhqKrl2W9Bzj3Cm/HzBIfHUw==
X-Received: by 2002:a05:600c:46c3:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-436e26e1d21mr27193915e9.23.1736492002171; 
 Thu, 09 Jan 2025 22:53:22 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37e36asm3631044f8f.5.2025.01.09.22.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 22:53:21 -0800 (PST)
Message-ID: <debbd5de-718f-4940-b428-91ce6f0d5ee5@linaro.org>
Date: Fri, 10 Jan 2025 07:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qmp: update vhost-user protocol feature maps
To: Jonah Palmer <jonah.palmer@oracle.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, aesteve@redhat.com, hreitz@redhat.com
References: <20241216170914.1346403-1-lvivier@redhat.com>
 <c9341f03-ecc2-4a62-860a-35ff2b660651@oracle.com>
 <6f1dcbe9-3a7e-475b-92ef-14f1d04ffc2e@tls.msk.ru>
 <511cf8f8-03ea-4375-abe0-317ac3131b1d@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <511cf8f8-03ea-4375-abe0-317ac3131b1d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/1/25 14:25, Jonah Palmer wrote:
> 
> 
> On 12/22/24 4:13 AM, Michael Tokarev wrote:
>> 16.12.2024 20:30, Jonah Palmer wrote:
>> ...
>>
>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> Should this be a Reviewed-by instead?
>>
>> Thanks,
>>
>> /mjt
> 
> Oof, yes, it should've been. My apologies, I was on vacation and only 
> saw this just now.

Already merged as commit 1e3d4d9a1a32ac6835f0d295a5117851c421fb5d.


