Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22EFC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 14:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uURME-0003Fq-Dj; Wed, 25 Jun 2025 10:44:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURMB-0003EC-0S
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:44:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uURM4-0003Et-Jy
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 10:44:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so1288689b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750862642; x=1751467442; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aF09XxDTydgNpUnUBRqP8WWtGs11SPj37HfLAJn8wRM=;
 b=wR6K07m/os1tnbQxoP9vcpaaB8E4kpyEdrGNvtNbtPn3IiHyiTO+abG5ybyGZfu471
 gUB6T9eYsw2V2DpkyN0w7VdSEpPdwJek0p0IE5RlOZoDqRW33HMHqioComhgJFY1rTmv
 v6TCooydEP4aeoRjHRZHaXk3rFV/F1fu2rwLh9/1gWbc71JY7jnVfQcFiqDL4+sQLhc6
 gR7yaOGHZKTpoYDB3Y3xNm4/kxHDheBIyTuhrkZKAzJFNM7Dmzr1FZD41u/M/d5sRJ2l
 soj1YO4IXUk/mvy267Xa6X45njqrNNLRgHp48E+cyt1Qz7UodAb5Mvpps2ncRA1BWhuM
 7wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750862642; x=1751467442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aF09XxDTydgNpUnUBRqP8WWtGs11SPj37HfLAJn8wRM=;
 b=oGVwF7s9JsdCn/JjlxiHp2wdHqr4Q3nkYWlU17+Opu+LE7YQJ+MKfUtKDpZI62GYeR
 SEYIWCYfq2HadUg/gOhnihFIxv0X9y364RjoAaS8NlQzvgNd7R2XKs38F/7Xkl4U3gSS
 2Nmo7PfnS9KULVwSWTYyA7E4ReF8iDz7e5wCzjgeA1/JntPAhAG0NrqBgi/iVwb3nrz8
 rMegbCI4RtJZ6eZkOGB899/OxNl3f61snAV6JPJbGutVfvu9j38OeihT+2SQxNPMJ2Jj
 UqRk2i77rCxlx5CenlGysruwsNd82lbJHqWiqjGjS93MhuteI7dPyBEqnfyFLtsiBoAZ
 XWdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO9C2HrZqaiIuCkvi2R5IHDRgElmoNELI7DeqDaxcrZWHxSFtyOJaXAjxSSnozLTLfVoVCFx7Dlkct@nongnu.org
X-Gm-Message-State: AOJu0YycHHkijA0AnsIVpBdGLl4SjDUWy8umKp1o4Pd1R4buVKRRtVeX
 zc9TFfygxYrreTnjuXSiKiVQqxRl6c1tYZXnSFofxbjIBHLhS2WhwXvwfBhEDZn6ucc=
X-Gm-Gg: ASbGncsjH9965c5I3sH+1taN+0Qw7ZWQNNww3aynq4td69H2BMwDI+jz/RXhL0q3dSp
 1fSQA6iOLsdZhsTAflJqxhGwqxHXBGbizm1f6tDa47UOCPs0cpVo5eidvYpE5fpaDn1+1T9+RA3
 5mcGoD1NeKpvIeK7DaqB5PDpysbuA8aULNm+lLbLmglRuDBQtjbWqRzsYMmlxI1OI+8+SBNXzX+
 peJhuqDB+pwyMvAHeM/nW2cU1I4Q41zA32AMV+TRngIo01OI8BAOnYZanH3eg4JFtuaPpLu8KT0
 u89xthoAR2ElL9IrrjX2S0zAPvhAYRFt0+C1g06C5i1lrLiaIwQjruNKIrehuHN8msfCN5NjEJw
 =
X-Google-Smtp-Source: AGHT+IFZDn4aNUkox5yptvU/QxkG+5e7M4ZkOzO4/xU3p0z2O/4Xw+wBC2Zny6B+iYczQV5eAL4B5A==
X-Received: by 2002:a05:6a00:a90:b0:742:a334:466a with SMTP id
 d2e1a72fcca58-74ae317d7f8mr102316b3a.12.1750862642547; 
 Wed, 25 Jun 2025 07:44:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-749c8873652sm4856471b3a.177.2025.06.25.07.44.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 07:44:02 -0700 (PDT)
Message-ID: <43763ed9-1891-4521-8abb-401b1ea8b8d7@linaro.org>
Date: Wed, 25 Jun 2025 07:44:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/27] tcg/optimize: Add one's mask to TempOptInfo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20250603080908.559594-1-richard.henderson@linaro.org>
 <20250603080908.559594-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250603080908.559594-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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
> Add o_mask mirroring z_mask, but for 1's instead of 0's.
> Drop is_const and val fields, which now logically overlap.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 51 ++++++++++++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 16 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


