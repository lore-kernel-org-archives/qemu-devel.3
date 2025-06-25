Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E1DC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURVu-00044W-IF; Wed, 25 Jun 2025 10:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURVr-00043M-ME
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:11 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURVo-0006Ka-UC
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:54:10 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b31f0ef5f7aso3564669a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750863247; x=1751468047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4Hwk2Kq1/B29iKCUBUGkLkdbTkbuxLnbyNX2jZ6AoKE=;
 b=fRSU0LYUo209apcPx2rHoEbNoehqB2cmYknxzImogwKSIC4czrKSVy0BO6IAyZ21fH
 ghXHIWSzPYnuCmji/xz9023F0qhplcTdALSXX25X6ENxy7Oeonqi8J4zMnrOXYv2xM8x
 WdfPw2BvGdb3w3MvNFqno/bt8TmyGBrCHqPQsrWZGMXl3db7pbo/WamG/FUL91GhbDL/
 udmM6trK/o8yJvEuGruryndHy9u7c5gtpI2fQqO7PKiHv4S2WwW2aO45yccXG4tZpYPu
 iF6Cb/siK21xwD97cxWheYiaU4X7vVZlX3iI/2SC27S4Yl2Ly9bdQsszYULoIWjKshm9
 Yg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750863247; x=1751468047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4Hwk2Kq1/B29iKCUBUGkLkdbTkbuxLnbyNX2jZ6AoKE=;
 b=uTa7jgKltDZ1JhmG6OV0XBazf2UhHJLNmAWH5JzNVhxdnKvcvI2EPvO+TaKaKUbSWd
 Cv9Y0Pvo4jT1O+nrC9rZ32xWmr+VRQc+9JwJi65gmptfNu8usYont8ggVpqjLbuF374K
 IJ1wX02KXeUhabuYt278Hgs16Pq83hBzX4hAJggT1v6Y+GQ4ZXXAdwIGlTyojVF1zYBf
 kRG/pgc7r4DBwiAMGW9s+7CsfVVJLU7m+C/62EbVwqQFIzb+7WVY6AYWCULo601Zw5+o
 bUGvg4UO+nYIm6L3WRMdeFq1DzTtcUKVzSYrPmT3yQf7cssgGxJAOL3AXxGcti3qGZmv
 mk2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEnU4nKg9ogHvT2PbR+UTtc/XGMVdvaWky1iWmpwRbePaBgAVVWj7+9CNngYz43RKCKgpnTe8Gb4Ul@nongnu.org
X-Gm-Message-State: AOJu0YyYk9O0hsdrBG3JUUP1d8PmhU8odaP5E+f3YSoMwT5uoHrGkflu
 3mEKyHac0HOhTx5k9PE8Fu769NwFTxpEPzWt8MW902YJEHm/HYeN763oPkipu8yYjCQ=
X-Gm-Gg: ASbGncuDj2mFQ9FzmrWrUmst+sTGGc1DnJT/Emv6DxpsV7OBBRgMI8AoXTo8IJayM89
 NX2b3/WVKWvxe0+Pmn8gn3cNT4H8x5bnAW5Q6/N3W5tvCTGtMdiJ22JTyQRZGYVB/oWsU8QEVHn
 gJsrrh/DYx8D6XoQqG9K+OEJz5aRmizkDSiBAOO3rBQrz7c6Jye5Vih2U/bdaj58JnpU6qFPXnP
 n0+5/KmBElo+YG5jgVLFBIqXUHGwlrEfhJg3HYpQXgwEAxQrnZw4f/ABvRZgKdvcJXJ3Gf5dvTS
 ASFb6Xg1z8SsQJoXmveyCLf/ms68EYlZCWSGM/ckBt3G4H1KWuk0obnzg4Aizt9ZyjXEclOnn13
 No3kiHH1+Fw==
X-Google-Smtp-Source: AGHT+IEAP7SiaE+bGxbdrK1J7cYZWfuzOEgfLE8f8S7Oj19icuWrt+o7myR2z5r/Xtj3t5gqFNFSjA==
X-Received: by 2002:a05:6a20:438e:b0:21a:de8e:44a9 with SMTP id
 adf61e73a8af0-2207f31a3a8mr5392472637.37.1750863246952; 
 Wed, 25 Jun 2025 07:54:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f118eebdsm11271306a12.6.2025.06.25.07.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:54:06 -0700 (PDT)
Message-ID: <e977cf6f-f359-4e0d-982f-bf1fb3e92e7d@linaro.org>
Date: Wed, 25 Jun 2025 07:54:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/27] tcg/optimize: Build and use o_bits in
 fold_extract
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-16-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/3/25 1:08 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


