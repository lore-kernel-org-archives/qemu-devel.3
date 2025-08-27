Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6EDCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 02:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur61L-0007C7-Ft; Tue, 26 Aug 2025 22:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur61J-0007BD-Tp
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 22:36:17 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur61F-0004iM-Li
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 22:36:17 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-32326e202e0so5578444a91.2
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 19:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756262168; x=1756866968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=78+kLvkuIIKpTyQsSDXNftsAeHo+F+DRkn7XFFPHJ7Q=;
 b=UjHlmQ3cWIvN/rVpi+pSd5gG6lTWKMpe6OqwydxjgyPx+raU9RxrZi9EUjGX5vLpCT
 lOelpPK4v9h3BRlScoHeGoNMNaP5Gp/qRdr4YWRUCN5RbMcq7jvzU1SEq9Yfw4S1PMu3
 zVjM5UwZWzhV989EJnapfUJkgmHWq3vWtoVzcLp/Z3ymdltzyOI4XzObcmCmAo9GFlt2
 BhDq6sqx/r4s2iLc464UQibJS4/IQvmj+qc79ahX+QzSsRo8ui0f2O20ljf4Qdg2pRCA
 YBm/YLExSFGlCr8sfdnrfEOvC5UTElC5rBLnZwGhHBB5L/5xMBBcwN7c5IADX+SMvXKj
 aN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756262168; x=1756866968;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=78+kLvkuIIKpTyQsSDXNftsAeHo+F+DRkn7XFFPHJ7Q=;
 b=N8VOfwpEtBgtofOD1it688v3nMS958IAZdQ17otl/5QWCRQsm4EZfZ5SRGphgU01pL
 JNRESyANppL1vCqS9UYT901WV2OhISK8krWqsk1qxY/B4QuG4G2U4G2OLzua8LP/zFNA
 nvnTyvQ+TeGFgIPNbV17+33gQnhfoG+eSHgh8pMXhLulG9MBYzg4ajBjf1fwH3+25obV
 yPZhemFHeRKoMWSFoNfPIOFrYNWzWu9DNUkKbzeBA2RkWziuZgMLOqaxg/0AgEybrtmW
 eGSDUh3bMLjRkNb8JTc8hDbCmhdF4bm85SQDV/phtNme05F4wliiqPJKV72PVq3vwHUM
 qQFQ==
X-Gm-Message-State: AOJu0YxJKQ9zGHDZOI/IJE1JspZHnStMZ5t6NayerXjvv+RYZfi5sDMn
 WYUIUEvnSPWMKzuyXVWh4A7aPZT595PFZtXZb91PC7DDe6tBjlsMYEkjTrJtYJ1QLVBWNb7UtnP
 z5Es1vnE=
X-Gm-Gg: ASbGncsEWpfYGAVtkGYQMeuqhSjvrxLr7MCLKP4e9RLY+9i9lCGd/ngWMKriBAroQEO
 zIcW1X4defecI0BskuxgX46rRMc9MW0Ro/iyxoMhSTub8jiKL8dDLk2WsvMUGQXHyjcRgu7mYua
 LNpO9EwYTCmfI33+xPgN1o6/jVJU40nTat3DJEE41QMVXtQ2oMIhcOQ+x+pqSmb065PlTwKRIzN
 LwHGPuL8oOpYOmqSo59nztAtzXX5K55RZ5z2D3fITOnOWtUOJoT4S8hM6Av538U6aPeXCRQEVL5
 w0C2wmBs1CebEeoteL2wOEKcGqN6wqxl2UcLnUqZ6Ha5j8fZlze9X66nrTrei29v7hNlfvgoofA
 BofWwraFA13AWCD/LcLkcytTxMJrttGEv1GGTwRFzVK0Bslk=
X-Google-Smtp-Source: AGHT+IEMH/6k9iUkQUJjPhFTo5HTTYHkTDuuh40+cUuzEqNePBeDm/g/uSjbXDaqN+X6LoGEfKQVCQ==
X-Received: by 2002:a17:90b:2f87:b0:321:b953:85ad with SMTP id
 98e67ed59e1d1-325177447c5mr22388273a91.30.1756262167429; 
 Tue, 26 Aug 2025 19:36:07 -0700 (PDT)
Received: from [192.168.0.195] ([144.6.121.55])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4c2fc5f9ccsm3024279a12.45.2025.08.26.19.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 19:36:06 -0700 (PDT)
Message-ID: <6b8e94c6-f651-474d-a12d-ae9a1033fe9e@linaro.org>
Date: Wed, 27 Aug 2025 12:36:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/61] target/arm: Implement FEAT_SYSREG128
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 8/27/25 11:03, Richard Henderson wrote:
> Requesting feedback on the implementation of 128-bit registers.

... and of course I also failed to empty out my temp directory,
so there's 4 stale patches that got included.  At least they're
obvious in being N/M instead of NN/MM.


r~

