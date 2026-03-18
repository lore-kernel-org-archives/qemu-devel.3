Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CE810775FC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 17:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2v0F-0002EQ-AD; Wed, 18 Mar 2026 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2v0B-0002BQ-O5
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:48:15 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w2v08-0005tP-O6
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 13:48:15 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35ba2ae4df3so137536a91.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773856088; x=1774460888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gzM98ZpdKYV6I0FC+I9SAtX8rZ0C+wqkOwS7Hr5bJHs=;
 b=xx5aSl2XZHl/9Tv4i2G7xxLha+aJiHnoyIbRjAcuuwP6pngLoHVEoDzOi44TVT63aW
 eEJexLU/hLcHAM1NnNKVqH8PvBnGNxBtxeBEnKWndknQ/6E+ZegGR8y9upoFd8g84STZ
 e0RHuXHtY7UBePz1/UWjXQMvyXPwGhg6wnotZUmLonFuwt3XGmc1jD/P/INXceZ8l9Js
 2NNdl/ckgtUnmARbHEZnl+/KC1zlnKYhCY9i2I7iJx2J+HUMTRW1nYJxa4H53L1xQ9J4
 oXcnVa7MMY/R2JIUvDuyvwx++JN36GubOOx+Gs6Ro/mHUv8pKjRIzKYKWHc83JDU8As4
 Us9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773856088; x=1774460888;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzM98ZpdKYV6I0FC+I9SAtX8rZ0C+wqkOwS7Hr5bJHs=;
 b=c60hLQjmmmNY7Urhi+umkip3j8zfJxY+wjyllj4gy2gYb9U+rrSUBupAmlZr1FAqb5
 vEzt68y1fL53+33MQyoQ0XM9/6bm7nkL4L6ZkAW2zqnPB09pC2oxQtLgQFPtQHYmCI4d
 TRJmQJuBZe4z/enAUKqYBaageoiPwx+wMdKogmUuTOSnmiOo2ofR+INls/deLFQ+Ujuv
 aQBI/fLDTHMKQCuBwm1PWNJcfvUESErM21a/TLmScU60SAoC7qxTV31J6ZM7oRQDl0wt
 bPtImM+cxSg6T4Myi4Tz2SJKA0RqsY9CsrS/yFa49e7cbCL3wiKK9N1OwHo0Dj06Ju9M
 syIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoTKYyb90ONbkClZ2wHvttsCHHQjGz9LIIT+AIFAdM5gkx47lOfXhSDktSuqDrWFl45Ff4Km7XsXcv@nongnu.org
X-Gm-Message-State: AOJu0YzXFjOizKsuXQxSdaqCrVY2SO8VzXNN4VpQVmAfvjL1d1xyRU2m
 BKaN1oSlq8WZcdaYGG1/HT+JS+BZDWqDGh8BCYuGdqWHnytJHDoahUh2Cmq8J+obf8M=
X-Gm-Gg: ATEYQzw05bsQ+0ohrhtgsnCAeHw3ttXrnFtJBHnRC/3koIfjPGsVIeFXdbf4Je2AkmT
 tXttJk7gxoRnkgJuVMz6cbAgBVqkAG76NXtnhrJrjzH5K2Lvqk/kBAoHZpM319kWXwkEsGb+tpw
 hPQTS297/aC1RyHfCuxn7OW6gQrZTP6B9MzCX9MYGcih1366IsaE9tqEmknie9N7kdkcTazO184
 N20QDz8kkhYsc4uwQWlNQOCLx0YkZGXmSDbrskr84SO6bISWFBFYVEYxEJKj1/za7iI+JstsDxl
 qBEWPyuEaXyw04FGRPvzo2UKXh+cBPA55EELTrHAvKBOqWpmlv1hH2ifa/7YCH2NG+GsZVuXSq7
 egzyOz3akkAfKMJ4QhEy8WKJ2QNz3GdSokYDshp242SGHkZazRTnO++6kppEn0TTl+wfzwrLHBA
 mpCeih4plueFs3cfKaCOGox2mF5shAv1ksS/EMDw7Eh9dNnpx3gz1XLOM22rlVvG4XfoqA
X-Received: by 2002:a17:90b:3f47:b0:354:c602:a573 with SMTP id
 98e67ed59e1d1-35bb9f17c79mr3937720a91.27.1773856088103; 
 Wed, 18 Mar 2026 10:48:08 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bc62e44ccsm212885a91.5.2026.03.18.10.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 10:48:07 -0700 (PDT)
Message-ID: <5718eb21-ab32-49e1-82ce-beabb33983ea@linaro.org>
Date: Wed, 18 Mar 2026 10:48:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] hw/vfio: single-binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20260317194241.869568-1-pierrick.bouvier@linaro.org>
 <517be5bb-d6c8-4220-b585-3adbe4826056@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <517be5bb-d6c8-4220-b585-3adbe4826056@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/17/26 10:57 PM, Philippe Mathieu-Daudé wrote:
> On 17/3/26 20:42, Pierrick Bouvier wrote:
> 
>> Pierrick Bouvier (8):
>>     hw/vfio/listener.c: remove CONFIG_KVM
>>     hw/vfio/helpers.c: extract kvm helpers in kvm-helpers.c
>>     hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD
>>     hw/vfio: eradicate CONFIG_IOMMU from sources
>>     hw/vfio/pci.c: eradicate CONFIG_KVM
>>     hw/vfio/ap.c: use full path for target specific header
>>     hw/vfio/spapr.c: extract vfio_spapr_kvm_attach_tce to
>>       hw/vfio/kvm-spapr.c
>>     hw/vfio: all vfio files can now be common files
> 
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

For some reason, b4 trailers does not apply this. I added it manually on 
latest patch of series.

Regards,
Pierrick

