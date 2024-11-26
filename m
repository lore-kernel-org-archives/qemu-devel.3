Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E836D6552F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzFn-0005My-CG; Tue, 26 Nov 2024 12:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFzFm-0005Mi-2B
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:21:34 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFzFk-0005jk-EJ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:21:33 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349e4e252dso23242015e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732641691; x=1733246491; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+YmXYa6M/2mv3GlzO6CQ61A8CDisrf5NEnTnbbO9oM=;
 b=RlUXttGBbGjGF4J+Fm9e+1lMoEEtOWcGeIbqYjl3qp+TAGKVX63NOD21C2IaLSSYvK
 D5caQhHYZ7HYGH9kPEosCNRIrK7+ImR421gaQIZA8V3klp3+lDdKdX8VD8lxLCGCZMal
 HR7uJx3L2rmW+FApJwBHxPhvHYiLnxvffmPc+zDBzTugrF0InMasZs320BMPh4weuhlO
 aO0Bq4g2llI0sw4zGdEYgdU0FXi46C7zPuCsJ62I94ZRHRUmJ5SgqMArfMgmXL/6/9qK
 kTtxurANcZHIcYRBX8A9cG+aeUh43Rk9jgU/A6iy9YPJGtt1/sL47J3pxfS2tNApPW9g
 l53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732641691; x=1733246491;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+YmXYa6M/2mv3GlzO6CQ61A8CDisrf5NEnTnbbO9oM=;
 b=n0nEUKqQWGTkEr+8Zi0tkR1ycEFEap7ehxZrjSnlVUr8MTjy4O+Bi8PIwOm38bVXdq
 m9HtPlQS8YA7AaDMw8z3sOUWc4AAuqECM/YW4Ikn+5k3H5EkTtelnpE0ZlG8gwewA9vk
 cs9cBxuEEShyqmqOVar981LmqxrGDk4WYZ8BwYMLxlJiP//+D05XDjgShqZYgrGchAMk
 bwTTtp+iygAXIrN7I+1SA+mDtYXMMFZP3Ro378S9zO48Xr+GEAeUxPHJqUKkpAqtErRK
 uEkCHMH3LP3nAtPh9CwxY8j++n6DmRidDZP6Hjd3Pj9eDEq8+d0Oomr+QPLuWI5ZLVsv
 4XMg==
X-Gm-Message-State: AOJu0YxdZUzSR8cKjLdJq2RkVk0elMwdYXtN4VHhgu8NhfaKP/AkDsJh
 6mKiezlpw9sPTacP42pTNbviXDN//OUNXisFJiqy1D2XICHpjwp/OEF8bFRr+D4=
X-Gm-Gg: ASbGncs6bzEhzaZ4PstSjhjDHO3GDs6rikmcA4dr9zQPhAUgQpR46qgjhuf3rQDhbfH
 FxaLqNxVS0Li3hG5fyKNuKFIDaIq+W3cH/UF7g3PhVQsZlnWzD2Y72gwyDv/OGKsM7leA3G6ixU
 SlOzOYgWd2NfwIdTrpH7RPpOwlned9ba51NYRX9b58hROIv5IDbiODQwtioEeLfO/XSA8LwVJqe
 NjS5dPSqhASFyA6lqDMyNiteFSsm3KEpXkxJqAAWZvi/ib/kbKWjPfMpfHKFuhwjQ==
X-Google-Smtp-Source: AGHT+IHtga1Lwt5aO0gGPLwE0I3v/2SP0Yr+j2NTOIO7KZe6inUzwNwORG+mm9e4+F3H+ZXgBTOdZQ==
X-Received: by 2002:a05:600c:3d86:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-434a9de3d10mr759605e9.23.1732641690909; 
 Tue, 26 Nov 2024 09:21:30 -0800 (PST)
Received: from [192.168.69.146] ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad627bsm13833987f8f.12.2024.11.26.09.21.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 09:21:30 -0800 (PST)
Message-ID: <815aabd4-b423-4fb9-a370-7c6fd12b847d@linaro.org>
Date: Tue, 26 Nov 2024 18:21:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/timer/hpet: Drop the unused macro
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20241126163046.3344931-1-zhao1.liu@intel.com>
 <20241126163046.3344931-3-zhao1.liu@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241126163046.3344931-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 26/11/24 17:30, Zhao Liu wrote:
> HPET_TN_CFG_BITS_READONLY_OR_RESERVED is not used in any place since
> HPET_TN_CFG_WRITE_MASK has been already used to check and fix the
> writable bits in hpet_ram_write().
> 
> Drop this unused macro.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   include/hw/timer/hpet.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/timer/hpet.h b/include/hw/timer/hpet.h
> index d17a8d43199e..71e8c62453d1 100644
> --- a/include/hw/timer/hpet.h
> +++ b/include/hw/timer/hpet.h
> @@ -58,7 +58,6 @@
>   #define HPET_TN_CFG_WRITE_MASK  0x7f4e
>   #define HPET_TN_INT_ROUTE_SHIFT      9
>   #define HPET_TN_INT_ROUTE_CAP_SHIFT 32
> -#define HPET_TN_CFG_BITS_READONLY_OR_RESERVED 0xffff80b1U

Never used AFAICT.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



