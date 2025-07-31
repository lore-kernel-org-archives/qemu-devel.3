Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388E6C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZsN-0007j1-OW; Thu, 31 Jul 2025 16:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYQ7-0001Bt-1e
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:54:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYQ4-0007yS-0p
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:54:26 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2405c0c431cso13736425ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753988062; x=1754592862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I/nTx0c11XoOaBKrEg6Ec/ust6P1Sij7FdQJOma9cTI=;
 b=Pims3vZmh0rch9cDawOXZb7WL/CJVJNk9mKXcPLs1Ng/XeORhj/F/qnV8LeKoWzZqA
 kWPEbVZlYwpBWS88PMlVmX/pj0Y22xMRRfDy/j7KaUbduyThaIg1yFm5ja16BdfimQU5
 EuscB5UQaM69dV72IJxlP2xEYUb/pLNGzCNkR7HffB3wxy5QGzzYgDY/TH4DVbJMr9d5
 ghZIiL0rrpA1Nv4ygatwAlBJqqc56SpUUr943mI2MWNfIw1GXrq085A4UNE8QBzNHxPx
 5XagIKZ3vwtyA8rVIkmlKIaOLEXmwzqgdX+sxQZJPYtMnGgamONrGRCP+wgKtmGQrSkH
 r7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753988062; x=1754592862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I/nTx0c11XoOaBKrEg6Ec/ust6P1Sij7FdQJOma9cTI=;
 b=XINSFcW7+2S+dhBARiSHomV9soTASM3PUH0ERrX5l2/g+DV2H/uHyzIT6d7O8Oo3Bh
 +ux6t6bWFqfTRxy53MVxdG7L8y1BYq74uOfHh49QdW+WfjHh3WLcWj/CvCtrSElJZTs4
 FWU3On8wf9NUdc/oYtzCWUEeuCjKlq/1ZYzMSKww1C9XiP7Er8mqq+ts9bdpWGJPVNNw
 IfRDLXaKX/yh5eF6UiNlCpVJ598x/EkJXfb43WcKOoLkStGln97nsOEjd42UinXfkx6q
 mMAjaKacHQVS29Ej3eAPLhE47kNRFS46XB+Tck78EspdaR+FDVo2Be05IrOjlZbOEeUe
 7ZcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW04q6WCmbwCN+6evUfdAUmC7ECcSB4AXlqd8Hr0nessXXepXMYEsCYWfKMim285DCTPwhnZ+rF4i7C@nongnu.org
X-Gm-Message-State: AOJu0YwWtAkf/sZ8VQV8DuzahZywLyMgiicJqLkaQcWshWxd+snSDpMF
 V/Fz6rKfuBoXSG3PsiDghWGargZeVNfOXFIQCgR69Uq2RSRI6TWJlvM+qWgjEfFAAt8=
X-Gm-Gg: ASbGncvhb3Xh7H3ZlJDKMlZ7nj4ogV1bULrUqErlat3WMAr5pFI6z2qL8z/jQY2EnHB
 lkeFVlusTf5Qfv03TCZlDphgkFNAtuHT1avqgOzQeq41myPiC2IgOAiSGOOQmEO0a7IYutl4bEg
 6w4IjI3LgHH5D/yBENNhK65zykKRTGX68okeH8stbP75APl53PJw2z6+iKNT/h63m6a6rP76qp1
 RZu/XEIiG3n576DtEq/RhIonp5i5NbH5DKFyXig4VpykH/N8pZISzYBdac+ukqYoNdboS39w9zN
 asTSqacIhbPl91ceISSoFlqSnrAZlBVdoArq8Fa4OGRs9gpAXPLAY2PDiivZ4gfk3FJi0YGXENl
 6/VQVw7fipn4Kig0J+UKo/aMY/74Wgx/m82k=
X-Google-Smtp-Source: AGHT+IHgka58hgE1c1LGTqzw0I/1dMHDGOdUgeJehDYlF5KLRSXUCYqb46re16YxlFpsfhkCoJv0pA==
X-Received: by 2002:a17:902:e848:b0:234:9656:7db9 with SMTP id
 d9443c01a7336-24096b03cf4mr126295225ad.32.1753988061743; 
 Thu, 31 Jul 2025 11:54:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8976faesm24013995ad.90.2025.07.31.11.54.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:54:21 -0700 (PDT)
Message-ID: <ae475477-9c21-45e3-936b-962e805eb4ef@linaro.org>
Date: Thu, 31 Jul 2025 11:54:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/82] target/arm: Add GCS enable and trap levels to
 DisasContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-46-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Pipe GCSEnabled, GCSReturnValueCheckEnabled, and CheckGCSSTREnabled
> through hflags to the translator.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h               |  3 +++
>   target/arm/tcg/translate.h     |  6 ++++++
>   target/arm/tcg/hflags.c        | 38 ++++++++++++++++++++++++++++++++++
>   target/arm/tcg/translate-a64.c |  3 +++
>   4 files changed, 50 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


