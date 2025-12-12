Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25CDD49220
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 12:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU2Fj-00080L-Rp; Fri, 12 Dec 2025 07:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU2Fi-0007zb-Md
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vU2Fg-0008SI-FX
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 07:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765542482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGD6DjWKFhr6c+hpng/cFU4bJ8Nu2AKenLwZqiR8yLQ=;
 b=geAULHyEbSBD5v6CauGAYiKE8DdXRf884C4jSyF878w9YaFjI3SOxMOpgu49qCv36TT6DK
 v7BbUkScZXv6eoSAuAW4aeXFnYFOQ/+6GJlYxAHl1DBR+PQdah1XN9SK60ZccO6MYsaKQK
 tw+P0IzdgtKJnFZeOanlL4oBs7sSHMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-YZQ8CcdAPVWqjdyDwmucow-1; Fri, 12 Dec 2025 07:28:01 -0500
X-MC-Unique: YZQ8CcdAPVWqjdyDwmucow-1
X-Mimecast-MFC-AGG-ID: YZQ8CcdAPVWqjdyDwmucow_1765542480
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4788112ec09so7527685e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 04:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765542479; x=1766147279; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NGD6DjWKFhr6c+hpng/cFU4bJ8Nu2AKenLwZqiR8yLQ=;
 b=X1qcRowRXRXpuQMkxEtWaEchrN0mxT4oQEzS6eNU8iPBC5tzFHQopkPjQDktDh9mvI
 I060m8bu8VMMVBcWopq5fba3MYn7fDZM3rHEyPuGNUH0sbvadNonsnvlDHcvTVg+uhsA
 3R2Dw/vRzPHlgCv6hpDsXgUgxMK33NU7DYtLsNuNjy4CqYo8WhTKzGpLa4+Omugd5rBk
 rHE5cZ30wdCQlzrLUg4BVjLphspD1/ndjTzTE2Fci6oCb9esA36UqL54/mjaD7ngh0EX
 4lXfbEV1PhZjcCNeTZ/2fEtKhKgV362KrscCFKNlnRxVMjaKXBq8KwEGJ6ui0eu3YUrf
 K9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765542479; x=1766147279;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGD6DjWKFhr6c+hpng/cFU4bJ8Nu2AKenLwZqiR8yLQ=;
 b=D7qHZpVU/yFV3oYWbVrlCSUGDPhjYC7YX4W6nrZ/XSYCMmvGlXloEB6AJe4BkFvNjg
 ynOtilbnfauPaXBt8+FxG8o1/XN/0ITs/zbNACM+uAwkZTxvyFsRMUwCvT9JqB944a+d
 KDBJrDRZ7mygwVq2BeDcVr40sN4W4dWMXvcaI3WozV6vagrDDZVHkZzd4j4Syz3VM/8P
 v4OY+3hH7/6MKbxzzfUs8ke92HK9/ERjoP0uGuoYGpGjp3N0yU/lqDlv/C0x4+jY2Ws7
 qTJzaeITD1GU72T88ugrFKc9aQYUgyarSWC5amgs/kAbeVJABQJFMmzcND6BitAJsVWq
 cH9A==
X-Gm-Message-State: AOJu0Yx3i+uBf9osQU17NFVwGxDXdfchL2WgayY8ltKWFXGSIaw+AqxW
 nNguCiH/aY7AwLLHwzLRVezJRnye4DJp/TuxrMr1XjdNIZCuW3O6zQexZhI2nvFuR5+EHGkfx21
 ljorw8aHt1Hum5+5Gu7iX2ozI5kyEl6HZ3Xc/NWTG+5awECLghZoeByTEekDeF1PBm2w=
X-Gm-Gg: AY/fxX6r+CCdHInGwAY/ahEF5bxHoS7A26hCLfrdV3ctM82t3KD0Y9P2QSzd6ME0r17
 /We+NhGlvVFtzWZPzLBr5r8xMZ90dRCOgfYTFp0Z7a1yS8zrTd621njNIii1eqR43EZhvIhLzAo
 hlZVFpozzIaZz0tIhsrXThEw+wvqGds69mhxGX0UDVjzf86s85Hu8jg0uu5u6ilQOKznuBWcFAg
 FpVWKV0zFQPQxnXreiakD9TglmdgZWrlwXZtM2vBGi5sG0fWsrvNUVx3qJ2VoL7lbVDdC5yVcFE
 Lld/nXDlsNBvr3vk/jmNvbcpcRxewTsR4K1+APh8V6LCOg66fWt4bkYhbZ2svnq3W01CsnWxvKU
 kqkPjrcpiBUn1HijsKHxO2CKyZGjI0Q+OfFnvIEoA23E4+E5WUevBYFIr3nFxyy2UwqvzTXmMqf
 Q/qE0cX1X6K02UbOXuhSkoahDzYFSQer1Bew==
X-Received: by 2002:a05:600c:6814:b0:479:2a0b:180d with SMTP id
 5b1f17b1804b1-47a8f8c47cdmr17199775e9.11.1765542479444; 
 Fri, 12 Dec 2025 04:27:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsvPyHVrozhDDqAC0txNECiWYMkCgBsm/R1dXh6bs2NzeEiOHvmPF6ykSza5j/ed3ySuMJSw==
X-Received: by 2002:a05:600c:6814:b0:479:2a0b:180d with SMTP id
 5b1f17b1804b1-47a8f8c47cdmr17199615e9.11.1765542479090; 
 Fri, 12 Dec 2025 04:27:59 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1fba:423c:67:1f5d:bd5f?
 (p200300cfd7171fba423c00671f5dbd5f.dip0.t-ipconnect.de.
 [2003:cf:d717:1fba:423c:67:1f5d:bd5f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b8a9b9sm12282766f8f.35.2025.12.12.04.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 04:27:58 -0800 (PST)
Message-ID: <fc0ba727-fa9b-4b5d-98d0-16725533706f@redhat.com>
Date: Fri, 12 Dec 2025 13:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.2] Revert "nvme: Fix coroutine waking"
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
References: <20251212102522.38232-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251212102522.38232-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12.12.25 11:25, Hanna Czenczek wrote:
> This reverts commit 0f142cbd919fcb6cea7aa176f7e4939925806dd9.
>
> Lukáš Doktor reported a simple single-threaded nvme test case hanging
> and bisected it to this commit.  While we are still investigating, it is
> best to revert the commit for now.
>
> (This breaks multiqueue for nvme, but better to have single-queue
> working than neither.)

I’ve tested this on Lukáš’s system, and there is no hang with this 
revert patch applied.

(For what it’s worth, the hang only seems to appear when writing, which 
is why I didn’t see it when testing myself.  I can’t really overwrite 
the only “testing” NVMe SSD I have, so I only tested reads.)

Hanna


