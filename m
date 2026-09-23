Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D915C9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9SqN-0004hR-Bk; Wed, 23 Sep 2026 15:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SqL-0004gv-Nz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:41:25 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9SqK-00084z-1x
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:41:25 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 d2e1a72fcca58-87c90648f99so1013767b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790192482; x=1790797282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+miv+ox5jZmztK0PfoVxdCMhgrBMuhhL9IbukJyafUM=;
 b=fF2PcJ6NfT0HI3EImN/VP3hMldom+D73Qbug8GaE+kZaLBCHrG0X3KLKvKS3mWhKGg
 krC5gDHtGg+fEPsWrIdNZZDrczLqNLEcijYy1BwXJms2RZOn45ZbgYwgetKcrIDjzjwb
 V8vD12zD8qFpR/x36PFMOphWcd22dwvLu/R/e5AwpJd6gImVj92UcK/4wUAtTSfnczlZ
 FSVNxyablZrmANdQx3VWpk/QU646PhYgk8Y1UCab6jgZ3XsCNsMN+kAtZo4YwE++CFN4
 WbC2Rys0vCHeo1BCPgIeoYToAY1qzHhGT85ZdkaMNiLhhdNU6Eq1Nmkb5gsH57uKLqdR
 hYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790192482; x=1790797282;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+miv+ox5jZmztK0PfoVxdCMhgrBMuhhL9IbukJyafUM=;
 b=GkTnf3myBT0oFzrU36m9agU7u7oMDYIVe/riVbi70u0ngdM85k0vCJt5mu2OYezq4T
 QDDTmOk10HoJQ+Zfipj4sZuaBGLvM60eCULaXfl79HopbPbKSgQh+TPW2nBRqVX4vlMR
 Y+/Pz6AAMtCAG6PXNo6CsTcb+texx+GRzxLLDqo+6Aa7WQV7bHNGbE8rQXbc4H1TGlIa
 JpbsI1x1bT/aOUov0VLkYVaLGT92g7+plfUtkndvDh2YrNAb3Cs3ucbq5uOQgTSX4GIr
 qoV0sDN4lxoC99jWRFVTJSqb+2VBGbygpEcWtSHLhw59s+IF7Z9GHPmwuEUTBtcpTdgV
 aFdQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoVmd5WyUZXaKJosR6kjmVE/yWi+YGCCs0mqfNyBH+BouYTDBvXdb9lgU+3pUQMyS6qjONeSL1J4HP@nongnu.org
X-Gm-Message-State: AFuF++nF2pL1boLYAWImm+XmnZmSeDrqRkpdT6RnI2QElFrII4qCzQuD
 yoln8ceAZLR6Up4yrnrVpuPALZOlKjRjSLA0Nd7co4qjLllrGbmVLs+2Ocodxn55Yh0=
X-Gm-Gg: AYBFou1z29AdRiErSqthgbd+3Ogts4Py8kY0/PWmFMFZpqYur/5dRBoFHobDEEP21Ih
 ftixNfE0ZWM6EIO0x5NIwIzaMC+5XFE+LBrM3EmoG00PVht4Mf3BMOupqbtTo+dtxsc69IZ10fF
 uiIhKijEpvpJw0cuVL/ZrMxgQMbE2YiOO1RB663KqKeBdKlJq89ejEpOdfpKWLxv5CTl54Ykkf8
 sflHB/vtWxdMash7sGx0aD6JR+S6ryz1Ba+36ZH0CDn/MQqlVoWtT5272cPDkl7+/nHZzAn3LJD
 jX5M3JKNlwjX8OrguCoXq/OXrVFm7n5tpxn9UZVhTkCqPNbNN0Pg5W3AnM8ftqB3t5VRnbgoImo
 RaXq4o3M1NgjbIOqb+IKyLPYArM5HM824R7gMOYxwJmR43MiJQjr2jvDWUSk65Lb96/OOjunyhp
 LqfWByJRx6Y/9pGmQrqhvgUj7ZnLXOhWUjN7oR3nzE/7CykdAyfu6s0QRpftx50+dJ/qZDE7UTE
 K5txjwqkyrxhnxiD/J1nOHmj8OqBLsraIAdQKTse1yKaiHOmhg=
X-Received: by 2002:a05:6a00:981:b0:87d:d4e5:c56b with SMTP id
 d2e1a72fcca58-87e9f631f8cmr123869b3a.55.1790192481700; 
 Wed, 23 Sep 2026 12:41:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1cfbfd11sm1860778b3a.11.2026.09.23.12.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 12:41:21 -0700 (PDT)
Message-ID: <4d152653-1ddf-44b1-9bf5-e49469492f94@linaro.org>
Date: Wed, 23 Sep 2026 12:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/17] target/i386/tcg: add definition for REX2 prefix
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 3cdc458f95b..b8e8991163f 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -50,6 +50,7 @@
>   #define PREFIX_ADR    0x10
>   #define PREFIX_VEX    0x20
>   #define PREFIX_REX    0x40
> +#define PREFIX_REX2   0x80
>   
>   #ifdef TARGET_X86_64
>   # define ctztl  ctz64
> @@ -208,7 +209,7 @@ typedef struct DisasContext {
>   #endif
>   
>   #ifdef TARGET_X86_64
> -#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_VEX)) != 0)
> +#define REX_PREFIX(S)  (((S)->prefix & (PREFIX_REX | PREFIX_REX2 | PREFIX_VEX)) != 0)
>   #define REX_W(S)       ((S)->vex_w)
>   #define REX_R(S)       ((S)->rex_r + 0)
>   #define REX_X(S)       ((S)->rex_x + 0)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

