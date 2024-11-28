Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C00D70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 17:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGihd-0000Kj-DX; Thu, 28 Nov 2024 12:53:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGihb-0000KN-W4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:53:20 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGiha-0004ui-GF
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 12:53:19 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b67a94ae87so66059285a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 09:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732816397; x=1733421197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t2702aXccmffyRMuUdsPBUdEV0EqbbfQETz5CYsJmMw=;
 b=QIcRuJRUq1O0zkZye/iFdKM8G2WCCFp3+tsnYdBUdQLRk44fqThjtgNxfnCwg7GDIv
 u9rYMH5jlrGYCZoPNwSdH05rPRNT8DAk8ecRs2CH4a0elrs6xg4KOcXXt9xCrO6r6H/c
 4BkiWUnZ4UHOSSDSAa7d49jDBMvBcm79snRpnxHB4JL5ymCtj8K5M0C6o7PYlvzTceYa
 1MX5b/LRvQmlnBuH6HBHE0En9A9S04js1w0iUWCztQVzGDG7sUw/P+hdcj6P/p1xSf/S
 bWgp0ptsvx6bJt22fT9JLh0B+Rsg4XpNVGKzlzj6K1AgEWnXQ6IKH/0N6e/VEqQSuwX/
 S4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732816397; x=1733421197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t2702aXccmffyRMuUdsPBUdEV0EqbbfQETz5CYsJmMw=;
 b=gHoATcLi+hOBEfHzoKFaS2amXMuyRAcaKO/Jy9R/ILFm24dGsIITXLLVOwgXR+GtFJ
 5uq5/wUVvphxpfy9DcsQTPfGxM4bZ4bLmDaxT9AI+bzTUYIpy1N9LseiwOhxKNPq6XZo
 Lz46FDotl+Mx3YAOlFs2qy6Jpbym3q6Hauc0u0LzYWQhqwd7yOcBscnQRNKWPjA4550R
 GJx6bee1Q27vXEQCHZ0u5P/9gBH2I107dH2ikV3gJ1pTyMy3tqnUh+eXzn2HcfT7v7aY
 3HVV2eUmij9PMdtUTFoDySloA4/pO4ApgzDqVbOKE9p4x9udVSSYQmbrPSNuKmnEkNR9
 Js1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSKdOfdgeL0/X7eQj41DA3D4pOljP1ZvDabPm+/M8KBCgsk4ln15Hd01or9fmC2JOv4Vac+M/MatoF@nongnu.org
X-Gm-Message-State: AOJu0YzphKRe5SuwPRuzgxPT4EDpv4JwpUQ1iIJg65GBWHUJowW5LbQ/
 e6XomO41HqujJWrvBFJ2qD68+ZjCtrg8JM8iseGmrrN05s8rDToUwKJOJJYJKVPWLO1T08BUx2e
 pHQo=
X-Gm-Gg: ASbGncubc6ci2r1P5Bh7uxUEGeSQLiKk17BdebJPMhTZMm7rgux9E7/Du0aGBoKGneg
 LVwI/c+3IHsOT4+JZRDBoPM52oVZCenWOCS9/v9YRLHEDLIdFmBHxfHXg8kpegzbiS5pU7LgCXO
 Q5SlF7yKyOj1zIKCoe5THyp1Da09OeYqdmUuVpMzfk7m1Zb7DRAT92AQPFu81JXJWvVc6U8Ouce
 DOxPp47a02Ads5LVUnjIDQrOOfE+8BpsPPzqmmMKXxEGiYRnvM/pMfl7PfqCI6dNCY=
X-Google-Smtp-Source: AGHT+IHI2NoGskm4Stu5mdR90wYdK5oPLAeiqyJll89moVEkv+gH27cViNWI2I/wntpnUdz6+n9Mfw==
X-Received: by 2002:a05:620a:1a93:b0:7b6:6e7c:8f00 with SMTP id
 af79cd13be357-7b67c2ed218mr1210662985a.36.1732816396013; 
 Thu, 28 Nov 2024 09:53:16 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849220fasm75798285a.24.2024.11.28.09.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 09:53:15 -0800 (PST)
Message-ID: <be475318-1870-4924-aece-849370d6396b@linaro.org>
Date: Thu, 28 Nov 2024 11:53:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 18/25] target/ppc: Set Float3NaNPropRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-19-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:43, Peter Maydell wrote:
> Set the Float3NaNPropRule explicitly for PPC, and remove the
> ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/ppc/cpu_init.c          | 8 ++++++++
>   fpu/softfloat-specialize.c.inc | 6 ------
>   2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

