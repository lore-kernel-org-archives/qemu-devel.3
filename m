Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A0CC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 11:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tus3p-0003vX-Jm; Wed, 19 Mar 2025 07:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus3n-0003uq-UC
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:58:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tus3m-0001jP-Ba
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 07:58:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so4124543f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742385489; x=1742990289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QjpYJsP/aHvMAbljnCvAw3lrEDNRUTatZmjrRo16Wlo=;
 b=AbP0JRGyG0xlrS86EJG3ac+bZchOn6bEIXADtbgeLlRdMOP9pJgRW17fMc1C78VQFo
 ankyImQARJmml8mbm9IXqEOxlBmXquVyeNVo/j8xB253kjRCL5EAjBOCyBiwqVjuEwXg
 x1rt/V5NTQutMU3H6euXfDGnDQVFqvUniCAMneTtxv5ol0jD1C24WOhGw1Behue2rXQI
 IC9ro8tVT7DLjG2vseTDOPM4LoHx0FPNjnjan17QJ+HolP1cXHvne1riuOY962XZ/joM
 zUM9yYlLFcOjtfjPINQ3vikDYBZYfuAJ8mU1UEG5hOd8MelyZRaOvssZAv82W8ei2EfS
 gzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385489; x=1742990289;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjpYJsP/aHvMAbljnCvAw3lrEDNRUTatZmjrRo16Wlo=;
 b=A/btgiBGksTJRfYA9f3MzZM6axJfcTux9M4/UINhgWY6LOa13b3sTrhv3Hd3xs+cPH
 h7hawYFc4GFXlA9YXtDXB+oqD5eymd+41bbpJERmrnd4otEaLWCRI6MgewvBl+BDgvMk
 SZXlOxHWfn1zgA9J7Vt8fs1l1VJ8iJOi++TGTzsAr4ld9MLPp1r+xu2gYI7Zs3OcZHjQ
 MC+vQ5wyi0s8TBUBvDwcz+39Nm3xgrE2VLclZ5tN3QDlMtKqh6AJAbfPrHnnvXAzRP9P
 UipSiDmi1ejfKbqt0yU1en9zJugK+kQQKavpGtKQqP4DbXNDhpynIfZXIbmC28uq1qKC
 zfpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOB3NExw2K4yxoHSbuJWFj3p626RXfxnpZNarnlu9Nt2Bay+UHWS+BUjVCitZHC0JwoUCgA+DLDHHh@nongnu.org
X-Gm-Message-State: AOJu0YxUpB0hqoVDCfKTfbZIy+tlykOWdAgdB6oXyZrlMTwXxn/LGTEq
 IZS0SRMb8Cuv01uu/70A9LLm/VlJQOYsQ9IxGhfy+CVIgmbUhUqsKXvFaImvfVIK15dfzcPWbph
 Z
X-Gm-Gg: ASbGncvBEcsXBdtQ7eyqNp3GC6kEZSomBdL6uPBN8fEQ6oQa9a38E0BblIY2KLOYM/M
 lifhNAn5SdcRAWWUTE679fn8mmnnHiGK1A8MHVcfqJC0ACnmfddDuwOqhsbyb6fEcMLTtbgFEg1
 S3snBpKm49+0WH6730OIGROr5760p4b7J6vFazM9JXbrJ8mjmlCVPef4urb9bxakluah2j9I6uG
 fZY7e/1njr2PrcjfHpK3FOfgmV7n+K7DNOCJio9PriP3zo4RNuTeUnqRE4/8MYgcylX+tgjUhXR
 P5/nrvccmSVJ/Z+22pA9eVuLYqQBaA71EwY923n4E3ehM5PkCepmWgVwVwymJQtkYsEoxqUtnJo
 6HdoJXL/OioTUyi2PcaFOq6Y=
X-Google-Smtp-Source: AGHT+IG34lnzihDx96mdnW8tD4pxYzvAJvrCiJsJEt19SAI44VU97bvc9jw3UvZSvTBRFdOARrCFBg==
X-Received: by 2002:adf:9786:0:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-39973b32852mr1307993f8f.36.1742385488612; 
 Wed, 19 Mar 2025 04:58:08 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df402esm20470958f8f.1.2025.03.19.04.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 04:58:08 -0700 (PDT)
Message-ID: <30d04cc1-acce-4a8c-84f4-683ac199f9ef@linaro.org>
Date: Wed, 19 Mar 2025 12:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/uefi: fix error handling in uefi_vars_json_save
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
References: <20250319110152.1309969-1-kraxel@redhat.com>
 <20250319110152.1309969-3-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319110152.1309969-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 19/3/25 12:01, Gerd Hoffmann wrote:
> Catch lseek errors.  Return on errors.
> Use autoptr for the GString to simplify cleanup.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-json.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


