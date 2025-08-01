Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45EAC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:11:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqSd-0000ph-SO; Fri, 01 Aug 2025 10:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhqRD-0006lk-1e
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:08:48 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhqR9-0007kJ-Pa
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:08:46 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso11090345e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754057322; x=1754662122; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxoScrTah+Lj1IfF6qFxbKzl33SslUfaS4aRw5LGTWs=;
 b=pVqcvourAHDPiYDCjZqM/jf1VxEK56pp132hWwsCSdywVxvI7frpByQvhtLTIOGN4F
 RWsViiOqPDlDfSjM17Rnb0sMCOIxArES6cHUKVaQil7k4DwX3Q0HejRPPQyB4yExl/0q
 XAzKwkN/Z9UTUgirD4PIargKzNkE6yTNKFSIUFl7WRB/yHCmMQ2njhrSw7DwnSo+OJd+
 P1j2+kjTAOPd5TvyJ89r+rxifCbqHc0RXERELVNYAVVExryLthufYECjvOhIf6JI34xZ
 ungycycaPFYIlfVLRdE/QzlCm15EGfHigeB3VeUuE0ri2kGiuaf8ZIXxaS61KzfcYvWG
 pauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754057322; x=1754662122;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxoScrTah+Lj1IfF6qFxbKzl33SslUfaS4aRw5LGTWs=;
 b=ICQ80tthtMuZcaOcUx/NiePcZ2wD/UKttlMnLeu9zSS+LPM7F//f3svfa2yVaKbD1h
 lUhQrQA2N8fzIVXgxesxpZIQoHw8w0pfEd16yMinlTSzWJDoz71wH6e1pAMtc7d8mmQe
 6jq0fZNRpcLtxKV8dCc9PJiVh13wlzqrHWxKqVISjXEcbGmgAueynijM6E7umvIZ5Hmu
 HVh82KKSlcUhhi95iK0Hy8uUuNBvB3cRkWX2ebBj9Q003EUmONdqdYqx/lgoDRsPo3l8
 BmNab0v6dQAcZyTdb28aQSIF6VVpWFyELeBLPx7eEbu8Fqd2d12wEKncWrffldfpqUMP
 Azyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNbLcBL+4wfm1X0QV6YVKw+aIVNdgcun7/SKots46yEGsaXeulc9VAsi8V7iXYhdP97xsXypyPE8FD@nongnu.org
X-Gm-Message-State: AOJu0YyNtJZA1emfkierDCQRqoRBrg1njrdv2lm3K0tZS2IbD++w4zgJ
 t0uiEzozEB1hJcpg3eYMyU3qFciokbo3LdvTYdKzbfXVn7RMgvTaqQA6LqgWImS2ucY=
X-Gm-Gg: ASbGncsbnmPEzHP5WKHr3yTzizG4dLTcLq25GI9cwf8d4uRw3+cwEL5OjosbuFyuVLJ
 PxxBywJDneidh7oUTHoOCObElQ1sICQwD71VPhaE56IPotDKfcwMyhamkSEmqh9r4HqBzjiO4db
 mO6BGxOpd/eF03UBkoSCX+w5aHh3qtth/P20Gwb3JDKjH/zKB/AISUeFstiQ6qJ03VTOWCX4fRa
 qGP+ldJWiJYKnKd0LAyCUsUtyP1iC7SFQxS/w9gUq8YOtFasc+eBI5uKBn3XdqecpwiayMmhRAQ
 e8W1ttmV2GiFneEqZ7fr+D5d2qls3GsuSWN7tHULUdig77wSFnXDetP0UdSAdQEK7C1hBfbqFtG
 vkGx8ZpYGo+LvfQjXdfYT3PiSxHTqBTNyEy9Tg4gn+OtnBTjiERNdDPzBWthYNw2SJQ==
X-Google-Smtp-Source: AGHT+IFPM8XXaZcwI6KHj2CYVlsXOxCG0J9XdceKrwBqmRP+K4bjMcPKR20kmeFbpm2ecUdYXqctbg==
X-Received: by 2002:a05:600d:108:20b0:456:1560:7c63 with SMTP id
 5b1f17b1804b1-458939439ecmr76865765e9.3.1754057321802; 
 Fri, 01 Aug 2025 07:08:41 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfe56sm111554145e9.20.2025.08.01.07.08.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 07:08:41 -0700 (PDT)
Message-ID: <948a6ac3-ded9-475b-8c45-9d36220b442b@linaro.org>
Date: Fri, 1 Aug 2025 16:08:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 eduardo@habkost.net, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com, vasant.hegde@amd.com,
 Suravee.Suthikulpanit@amd.com
References: <20250801060507.3382-1-sarunkod@amd.com>
 <20250801060507.3382-3-sarunkod@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801060507.3382-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 1/8/25 08:05, Sairaj Kodilkar wrote:
> The ats_enabled field is set using HTTUNEN, which is wrong.
> Fix this by removing the field as it is never used.
> 
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>   hw/i386/amd_iommu.c | 5 ++---
>   hw/i386/amd_iommu.h | 1 -
>   2 files changed, 2 insertions(+), 4 deletions(-)


> @@ -1626,7 +1624,8 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
>         /* Updated in  amdvi_handle_control_write() */
>         VMSTATE_BOOL(enabled, AMDVIState),
>         VMSTATE_BOOL(ga_enabled, AMDVIState),
> -      VMSTATE_BOOL(ats_enabled, AMDVIState),
> +      /* bool ats_enabled is obsolete */
> +      VMSTATE_UNUSED(1),

          VMSTATE_UNUSED(1), /* was ats_enabled */

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


