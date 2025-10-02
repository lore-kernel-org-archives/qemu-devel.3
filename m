Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B12CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 05:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Bnv-00028R-Cu; Thu, 02 Oct 2025 01:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4Bns-00027J-PK
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v4Bnj-00023K-Lq
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 01:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759382656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=J/qcmKKgolDZCaW0kiseKl4jT7F/wlD2ryEHI8exb7k=;
 b=G5O7PlcvE+G4VRlFBM+OKaUQr1ksxrWAA8U3ZriWC66/XUBvj+QcZZCD2/Yz2mdZdkDD9H
 QVuZ53jqjRj5t5hgRt44qRMvoFgjHBUiyYcVmOpsseTI/+EYLFJLCgdjtqRJKwDv9jnPLP
 GWQfXUhVJY69a1bm1h+AuJ+c8D14LCk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-T89GiAJjNyqPXD6_1TOQSw-1; Thu, 02 Oct 2025 01:24:15 -0400
X-MC-Unique: T89GiAJjNyqPXD6_1TOQSw-1
X-Mimecast-MFC-AGG-ID: T89GiAJjNyqPXD6_1TOQSw_1759382654
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso2728025e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 22:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759382654; x=1759987454;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J/qcmKKgolDZCaW0kiseKl4jT7F/wlD2ryEHI8exb7k=;
 b=xRIIDVex2fXJrEZ/Y3G1nUDAISQxcJfSXCnBwtc1rqZ4FXTmUCaZZ8gTzaRAPMXmiA
 qseBIqvDR0Tp4HJb7fvZga3iGWK8v3Pjk0e5YrCqhH+lZihhi1uopQ5o5egJAeFOOpdz
 ex20VxFfY0hT5XDj3J3+JugkS5Th4CNG2M/7h3oKwlqABSQGklq0GJVf8wQ1SiF/iBjv
 FxoAmwT9eYzocce29ksZmCmYDBp1Rb/FTjexWzX2yAjfEdFAeCfq0J3P0EIa4vBlsvUD
 VwyvbCAhFwMCBiCrD3LcfDxOrYlPI9Edbk5lh7YJCMxxQoVy7L8zSIcByYhXGgwUgRWL
 HieQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9OPJ+5zSh0S4e/PljlKJlubc0/fPNGz+NgaTEPhi16E6eoHCg2ahVDJa4OQG5f3EAkXVIkz2mTXy5@nongnu.org
X-Gm-Message-State: AOJu0YxwCemhTd0z/vqgi/qh7ykqQAP4sQ+Yw6ZlQSO/C486guMdMeEb
 9G3DeE44ru6RGbke6Ynk7VyScNaR1vV5Hz+C/PQdjQpBj/1h2oBcp8R02DitdqZ3slkluPzDddq
 QsPwnGQ23/PVmDAsYYzlWnAQFUUFkPzAiXw/MfBdU9LKrFpsahtBPgxBl
X-Gm-Gg: ASbGncuLpmZvrB0WXufbq35nND3Y7InSu9QWtlviQGD61C4Dhbb++6r7EWGP02+g9rG
 5aVI9mR6KeilA88dudotonsPkqHKNDmDOyhyh0tFjIWHj5E4eBCq9xaLSezrgfkYSqSu7PIbRt2
 Im7vkgTZWzdXF5uYyL9jDYGz7BD+Gae7dMFR8dwgw8DenLLreLNJSVFPWkXX1IArXu+LbH/r0B/
 12rdVMa1qTMtO0gBKUFuJ6FOA1sPLZAjY05+Duz7RZAreWehM3n3RjTaVUHZP2wgFLBOIRBUkVe
 xJqzfuYPKeOQbD1MqI0SXj+597WuVVnEEPQ6g4rpsIHGJtr8ydNbQN6Hv0eNMcJqQlQCeK8A6w7
 81zvDD9Cu0g==
X-Received: by 2002:a05:600c:4e48:b0:46e:36f9:c574 with SMTP id
 5b1f17b1804b1-46e61269e21mr43320275e9.23.1759382653977; 
 Wed, 01 Oct 2025 22:24:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM5e4GyRIUwVOE99XY6ZBlGLDWiXSwf8pRJuUM09eJdWgH/TU4OdkNMZraasehYqKeDlEv3w==
X-Received: by 2002:a05:600c:4e48:b0:46e:36f9:c574 with SMTP id
 5b1f17b1804b1-46e61269e21mr43320125e9.23.1759382653594; 
 Wed, 01 Oct 2025 22:24:13 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bb2sm1989410f8f.10.2025.10.01.22.24.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 22:24:13 -0700 (PDT)
Message-ID: <186fec6d-9607-4a9b-8535-52b5202b6e8e@redhat.com>
Date: Thu, 2 Oct 2025 07:24:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] gitlab: move custom runners to Ubuntu 24.04
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-arm@nongnu.org
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
 <20251001170947.2769296-7-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251001170947.2769296-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 01/10/2025 19.09, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/custom-runners.yml               |  6 ++--
>   ...4-aarch32.yml => ubuntu-24.04-aarch32.yml} |  8 ++---
>   ...4-aarch64.yml => ubuntu-24.04-aarch64.yml} | 32 +++++++++----------
>   ...22.04-s390x.yml => ubuntu-24.04-s390x.yml} | 28 ++++++++--------
>   4 files changed, 37 insertions(+), 37 deletions(-)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch32.yml => ubuntu-24.04-aarch32.yml} (78%)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-aarch64.yml => ubuntu-24.04-aarch64.yml} (89%)
>   rename .gitlab-ci.d/custom-runners/{ubuntu-22.04-s390x.yml => ubuntu-24.04-s390x.yml} (88%)

Reviewed-by: Thomas Huth <thuth@redhat.com>


