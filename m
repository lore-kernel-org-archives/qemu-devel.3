Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE7C71143
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 19:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPQfr-0007JB-1a; Wed, 11 Jun 2025 14:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQfc-0007II-Lw
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:59:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uPQfN-0005wl-3K
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 14:59:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-235d6de331fso1822965ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749668342; x=1750273142; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2HRxXWhpiKYcCKDs/IOF+TQRq/6M77Volig84nkwt8=;
 b=PELnB7gW8CO0wl+f6Xf39vFDO6cXW4EVqJ1KqK963OgzkW9M3C8vKt1P0O39szVIkv
 RW+i6nHHruvgoljpwV30/45ZRpWg62odKBLl3x59feiwzKRsseDOtmKDWhIixPrvxoSs
 0da9llN610ttBJAphuPmjFRnBndBG1sgvTfdaVIL2d+Kiy1YgP8o6rkdmjoZGkvoXp/Z
 QzhS4FAwV2iF3HmiT6Ii+zg596QkkOA/UmiUxZvvMeIcVazDGCnsqcDKDnTOBUADCmrj
 2+u8dnQPvwR7iNGxNOab+4nwPqSVTW+06p8LuUBcdWQnJm+pHK1kyAkYekcgvHkaBTgF
 Zy0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749668342; x=1750273142;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2HRxXWhpiKYcCKDs/IOF+TQRq/6M77Volig84nkwt8=;
 b=FniGE/ppmDPe2TRCBIdO6MEZIikVnEnAnDLWujikz8VvxWMkHdD1r1S69giyXnLbUI
 i86gDR0jfylMkDc8oSRVKg5O6qlA8iVFHHXzlwcCIoM/oiN7ECRYuYVpRSCUAlEQh4Db
 HbiAIjjpvIdKe9DdVWi7n7esKTqzdmWTeoKrLCt/mE8R8uFvM8nc6zyXneddvcQWhuXH
 9hQCm20UE0MLoR5LGAm4Khq5rHIuPklvh35PrTL5rimyidcBozggcQ43wf9ZblGPWwnD
 Gm3n+WFkRVv8S4nDGCxNlnlK+aHYcCwVNn0vhJyhSdgRpXw1NwU0e5YLF0dWmTiTbfvx
 PyMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzIlocTRs8BhpGBw6QJDXjTUegr58C6woC/vMtRIRbxCAiCvjBwarbneLYAfjXcjarRBCGe3SrMNBt@nongnu.org
X-Gm-Message-State: AOJu0YzG2ivZz7tMJMsxYvC5JcK9GnZyiYduqCjjZL9PHTq6tVSO391U
 Gcb9hJiZfxyx7bOSt1KTMtEBKsPSCRfdyCcH3TSjfAjrdpSz7ym8YtUqVgLK4E9h2UI=
X-Gm-Gg: ASbGncsWp/nuMpDKOC/oPv4NjY8LE7iWM8CpIaB/mBfLynBVU50YsgQ76to0jDu/BR7
 TiVwLVU0GXltYkmlbXflvPII8njBYXfmaRsKqG7shH3CO3ZCx9BBmnU63CTVGlf+j3wqwSDRTLQ
 4y4+IFgUcbU6U+ESFLeovnqSWQWI/zeAzmJzh/IYsBy+SIsTA/TLIwiMAuDnW1+ahypqJXZJdUx
 Ec5Bgq+YKWHcCDqyInF9oCSJilpmHymiNlHaVEwv3q1QJFdDd0RgDs76pSpOj6hJi89kx3OLfmy
 iJw1UZtHAmVzvO/wua/D5mtGlsfxyg4TGxWe2CnblP1Lfb0Ahc4s+So71pBoOd8SYGUshmCFbqs
 7rTfwlLTxxQ==
X-Google-Smtp-Source: AGHT+IFXCOPEAfm0L+t3fBj2Lxdj7vW9QRGz6niFFLZbbebHg/OHdM9xUiNbAF5kYMNMPJ/LYCws0A==
X-Received: by 2002:a17:902:d543:b0:235:e942:cb9c with SMTP id
 d9443c01a7336-2364c8b4d38mr9896385ad.5.1749668342420; 
 Wed, 11 Jun 2025 11:59:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-236032fcd58sm92049195ad.122.2025.06.11.11.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 11:59:02 -0700 (PDT)
Message-ID: <c6882c95-d1c8-436d-b4be-889f399f4867@linaro.org>
Date: Wed, 11 Jun 2025 11:59:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/8] plugins: Add enforcement of QEMU_PLUGIN_CB flags
 in register R/W callbacks
Content-Language: en-US
To: Rowan Hart <rowanbhart@gmail.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>
References: <20250609193841.348076-1-rowanbhart@gmail.com>
 <20250609193841.348076-4-rowanbhart@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250609193841.348076-4-rowanbhart@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/9/25 12:38 PM, Rowan Hart wrote:
> This patch adds functionality to enforce the requested QEMU_PLUGIN_CB_
> flags level passed when registering a callback function using the
> plugins API. Each time a callback is about to be invoked, a thread-local
> variable will be updated with the level that callback requested. Then,
> called API functions (in particular, the register read and write API)
> will call qemu_plugin_get_cb_flags() to check the level is at least the
> level they require.
> 
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>   accel/tcg/plugin-gen.c     | 30 ++++++++++++++++++++++++++++++
>   include/hw/core/cpu.h      |  1 +
>   include/qemu/plugin.h      | 15 +++++++++++++++
>   include/qemu/qemu-plugin.h | 19 +++++++++++++------
>   plugins/api.c              |  4 ++++
>   plugins/core.c             | 33 +++++++++++++++++++++++++++++++++
>   6 files changed, 96 insertions(+), 6 deletions(-)

Looks good now,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


