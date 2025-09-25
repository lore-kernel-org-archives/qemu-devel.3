Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DC3CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:46:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kPC-000752-A6; Thu, 25 Sep 2025 07:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kOg-0006pH-GA
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:44:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kOW-0001jx-7e
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:44:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so3949555e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758800649; x=1759405449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2orVD44kB2xGSiX28/G+lzXgOkwDvUyvpDl+HsGHBtY=;
 b=kg5y7dj5tU74q78oufM8Z4m1zZi2DSxKvcqbgxwSPg0QmAf/NAmc1CdMO7nnXs4OvQ
 MYAnJeY/Nh2x6hp8WpSMPW8170q9u/QvnHEGcEBwfz1DnSd7iOLTCdqm/52uWPw5v8Y9
 RVcIfBdWFyMyRv4ePJs7CmVINGOhHdZdPoWBGnPSA/iHMpGfLCrXwnAAWOVStivYhF7F
 D8B+ORSgMQx2uEtLfsUwpfaf2MIUSx8StGiFzmMAsGiJWOKu9gcFdCjEgjK3qprk+OsA
 WCtyEiJhNyEnzrvAv0MCmaaYSLl1B8LZy3SfkzCOVnQIj7G6H/0WGYjOCi6YhYNzK0gh
 vKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758800649; x=1759405449;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2orVD44kB2xGSiX28/G+lzXgOkwDvUyvpDl+HsGHBtY=;
 b=uSBYOcd6Hq10UM55YSOcUz1u++5fLK+LWlRRSI6psBMvScywVS4mVq3DCOwaXgkGgA
 tXGCgyt+U319UvGUnq4sLdKtR5KTItYQg5h9guZE3I2Hn6hKvV8pw0APXIPBmIMygKJN
 Z0rUJY4hI/fRsL/+VVm2Su5wir6pexF2WBAFt1nVXr5JuV4DCq8ZRHqddLvsRucrjGsk
 ehYiYAbGYp4L3r6gsKzAUIlRrL7fArtM8VLTW0UE3wYXAHyF+WzrB5Nuetb2eCqa3yry
 HewgXogO+TU8738p4K9m4UocLbDFuGKHy1vxUpgGwR+qjEvkmTVrXFffcWL0DbJHTdEB
 VArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWkBzP2w5bGPF4I0t3TQ+nPF2Jdnu3ZMzHoc1zGeNqzTdoIdRI8qzJ3kXIZSlJwZXOCjNItuJiyzP6@nongnu.org
X-Gm-Message-State: AOJu0YwR+olCgnzVxIG1qNlnOxcVdbrFVo+QJtu8bw2AUZsO/jP+aT7L
 fbbPpxxx59vfF0aR5QsppEVF7wN0snFfIZoB7pU0opgjlo5RPM7BRlxDb/Xf+ua0sCA=
X-Gm-Gg: ASbGnctefU9SyncP+Sk1ENu4fz7zagmyrBqkFHznOX46c3AnV4xxp0u7Oxk16fy8eI6
 AuSo1GYDLxkuk0MC/3Z3wAHvAoNRWJtakaBPeTERIAUeulbWoRL194VrBQjfLF3Hm9EOFbkIxtM
 DEYkhRVA06HmehkI8mrlgbV81d0TBg/1YyNg1zvDGi1pZ+smdu28pTrwRVgoj/RAkzCTInvZNMi
 +QJsOQhX/7D/5QoJMS3oJrUXMSNpZg656i2qItN9G9Pu+wSkFNRqIG/75HMNSfn00pDT3o3Hexh
 RrlHfKqXIAm337jFNAeWJVDHKfKSvflfcHdXvRGw1HmISjBvsWAm7/vE/CZHrotQ6DioGUONjX+
 18VHEKHqcnANrVddA/A/cqXrJ0O4+XxAmE19zuitBzve543DTxHMJp1ykYOPcXpt0p/9KmxB6Yn
 f7
X-Google-Smtp-Source: AGHT+IH+NeRFAtcbYAOtE2RuOq7jB6Lz8cZTcR3DVcW44qKxV2Hqge38HGF5lEIWOTPaSUmVIgqRWQ==
X-Received: by 2002:a05:6000:2002:b0:3ea:f4a1:f063 with SMTP id
 ffacd0b85a97d-40e4dabef59mr3066727f8f.55.1758800648789; 
 Thu, 25 Sep 2025 04:44:08 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602dc2sm2695491f8f.32.2025.09.25.04.44.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:44:08 -0700 (PDT)
Message-ID: <a8f5069d-95f6-477b-a16d-7d37556ba419@linaro.org>
Date: Thu, 25 Sep 2025 13:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/28] include/hw/vfio/vfio-device.h: fix include
 header guard name
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com, clg@redhat.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
 <20250925113159.1760317-29-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250925113159.1760317-29-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 25/9/25 13:31, Mark Cave-Ayland wrote:
> The header guard was incorrectly called HW_VFIO_VFIO_COMMON_H instead of
> HW_VFIO_VFIO_DEVICE_H.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   include/hw/vfio/vfio-device.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


