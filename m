Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352B8C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tunvo-0004wz-VK; Wed, 19 Mar 2025 03:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunvV-0004tx-OM
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:33:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tunvS-00008s-Le
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:33:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so26495875e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742369595; x=1742974395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jv4XS6tF1yc4+XNcQOQTnGjMyCrjcIFdra27Mvgizbw=;
 b=sLEttq3CZmAMST5O8qp7VZXkYvHTw+ich5OUHqtjU8UP4RR0YeeumTaIjCizN06vgE
 d2yU7xeyxlGs5lWzY9anHSvXLhNfi8jJZodMhpeDusUDLKJzir6sWqTGKWgAcagsLa6/
 7jlSZv0fG36b6aJSDXTQynCsoe5wTFwPyeoqL9fPkssh7IoYryur4liccqN7PjSW8fvy
 t8Ysr9KehVoGVv9eWZFq+LN1OuvKWqKwOV5I+GLPCcw+97YZIPvASJUP4MKFxvcO5c9C
 Vcc/YnUrm9Zrp4Vtg8f73kBkWtYrwQkrvE6riY5THJrE1fwGsLc2HetY1Sg0ET8RSX/z
 cZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742369595; x=1742974395;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jv4XS6tF1yc4+XNcQOQTnGjMyCrjcIFdra27Mvgizbw=;
 b=dbD/L5oJAnrn8wl9nWuGLHiSSivLNC6m6MvuPS0KehjfSgFAtSPmnO690JV0fAYoW3
 /kbU1kzVq0Ahdkvq0O2aoIc9t3bnHqg9auRJWp4GWDukRJp4NASA+j+2IO9moQXtKFtq
 2MTQhstHGXeFMKQQ8uFPy2wa5FRZUT7bgbZOqPw5026eY8n9L6hCo9rVeXYnOQz4rPLt
 zZbKoFo4n19Ug/dN8frLuuwoWaLePOPtIrsQYc0r4CYyWF5jm2Rg5fdKssYyAeTcb6uN
 qjN6G256LcGmE0ietmbkMwzquPvOOi0DF4rlVh4Z/Ii1K8KScOeILiYL57Bt4O+RZoG1
 gRQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIe/pbVrQNu9Gjmsy7GLFt1/mBQdpMiMPx+yvpwkT07F0tW228lwSO7BSC+v0Csp0PdjBTr3OKBydY@nongnu.org
X-Gm-Message-State: AOJu0YzBGs1/grv74GcYAab45utC5m+I2ufmGREATfli+ExY1C/lk0xe
 Zd8lcjBYerEZ8deY8ls3m2d65GZMUdItVyyE3808aWCP2oomdiwtH0Pf2DWYZSE=
X-Gm-Gg: ASbGncsIcNw6GzLGZO8o5oGzZpGIr6lTUNRomQVijvFE20EO763up42sGt8665NfPm8
 rRNyk4HZ1duIxN18WW5m9f+LvfCA9efFZ+0cZV2IRP7TVVwHnFkdGI37xWel0hBfAAf0/lXLrqj
 4BM7gu1IM4jGDOFNGqwC+6D3Oj+HKu4w/T+g2JMi6PckLfPTR4MF3OXISK4U8kNI1H4YTjQdeBD
 wIKKJGT4OTQPssFaHs/ESv0ocbIBPF06Lp77yFYp5o5hf1Kahf8SbwQdnKzbqN91DAwc6gQRvbq
 rAg0uYdM4R6+cHi2g2SIIT5zjWFrEcP3pbD6pRYjaVbUbGkPoAa2Pu7VYXMpPnxC7LYYbwiNyrp
 0KEWT2iDrJZD4
X-Google-Smtp-Source: AGHT+IHX3aLrAT5oRL0MrR4G8Z4AbOrj4Vf3kBB/LA70RnWpOhbcFuLvG0lQLn7xq+PoMjxNyrKRBA==
X-Received: by 2002:a05:600c:4252:b0:43c:fe90:1282 with SMTP id
 5b1f17b1804b1-43d4454adc7mr7300775e9.7.1742369594866; 
 Wed, 19 Mar 2025 00:33:14 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556a4sm10321875e9.22.2025.03.19.00.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:33:14 -0700 (PDT)
Message-ID: <0b77231d-19bd-4cc5-adef-e7677a94b874@linaro.org>
Date: Wed, 19 Mar 2025 08:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.1 02/32] vfio: Rename vfio_reset_bytes_transferred()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-3-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250318095415.670319-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 18/3/25 10:53, Cédric Le Goater wrote:
> Enforce a 'vfio_mig_' prefix for the VFIO migration API to better
> reflect the namespace these routines belong to.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h | 2 +-
>   hw/vfio/migration.c           | 2 +-
>   migration/target.c            | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


