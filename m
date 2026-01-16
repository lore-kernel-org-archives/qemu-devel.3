Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBE4D4A5F6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaOy-0003lC-Ri; Thu, 15 Jan 2026 22:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaOt-0003iJ-SD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:21:29 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaOs-0008Qb-AZ
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:21:27 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0833b5aeeso15171935ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768533684; x=1769138484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hA7UV9CQj+fQ08/cXzjdN2H66ZNHFtzuDArAyFz6DdM=;
 b=MQG4nzki798KH8XRgcg2K6SFrI3ZZcBfekH1CjlIV/nGLhC6EzNvYELUwZWKvShRt9
 vKGxe7/OhrQgSwbvwuBZz7kJuumHf5tgVlveytlezvAUqfBYPh1vMXx8eatEIuKs8lFH
 3+k55MB7JimlYlFSLQikL+2PgsqsZy4VasPUsMU9E9VRYFnlr5nRV9nNLrrb5nZeiGIk
 /zKAM+UckhR0L+rgTFvV0e8Tz/4bqnYQFfuQYcToIBH1ztusqikblLubJS8F874miBS+
 R9cYtzIo/JaziM5SfFrxhnRgucBUeTCDRtx1LLzF5KsB4j/6nAOgATMUjve81sjEZNyI
 CJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768533684; x=1769138484;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hA7UV9CQj+fQ08/cXzjdN2H66ZNHFtzuDArAyFz6DdM=;
 b=d/ZvA2rzwBAGJO3Ybv8s21M8JBtHxRE7yiV/dAZPh/983QogZbc0ZskwROJUEdACYm
 O37RARPSarWyhhlaJv0BEvUTFpOHIvpk/qZVnteze8QisZBwHAWJGej8mOwap/IEOQmq
 PNkL9URd/GSB69ikqFFoQj94ShyShI6uBR3e+Dv5dCO05NsxlPwOdifkJ5anwg+rRpfW
 5HFG++HuYc7Z29e9C7AkuTUGfPZDBOhGui2gGpVPF1eEXGNnzBGt7eIHKEXJoQ1wWCXP
 hbWAG+VjWfkEgIDB3DfF904JzGD8gZd0YTAdVgYARqtBgo/qfAuRy09PqDHHu57L5OpX
 2ZOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ8affSuI7w1Fh/jWmvmnpsDqTLdWQU8Vx29Zda/WhvfFwKDcDk8C2YpJmS6+427ifC+A8yGzkjtk+@nongnu.org
X-Gm-Message-State: AOJu0YwHqig82MX5jQLFbkCYA6QyUI8fU9Ew0lTgAbgBwxt7XhWjNcw1
 hcs07ebogw+BeQ4B3GLL2bBWnpuGUNTYZmczP1lmCYC+Sii313LWQeh+JWwl6YdvAfQ=
X-Gm-Gg: AY/fxX6zes3VvnMFRuYuF6KmiiHyB/nbFSmzHWo14cuMNAnpoazQKOGELvB0d3v9E4e
 BfOIh79/7SUC6abK+l/1W7TmaQj5ZQtv2SxQuSugkYLZaP4QDBT8wjCEjuhPWRrbOgrKhiseODm
 VuyQW6g6QWXfoU7i4in+9oUVodx+VPcm4dYPas1yXqIPwPZxhfIIixhmTisuV/ebRmhcm+ATQK9
 bLAh6RTslFoagajCuAMOGQ22jWQKJ/H3/9SdgKO/Tm+ttu7zSwxMvkk5fbtCpuLuwsyZEkhxbyN
 ncwN6yHvj7MO5AFQXoQNMFy5fYXVxwH6gGYOSrWU5XEfMXgKKCgC5PbUw95Rz59vJj1l6DNErg5
 vgBAxDmRgAPnt6iy9BM2nEfkRvnE20nTTUep6TMK+3ne2N/hu6Nu82hZ+/pYI69KQFN1YTrxn/I
 pHbH2BFjr6M5nLdEmPXpK5HACrWsvEuQ==
X-Received: by 2002:a17:903:2445:b0:2a0:d6d5:b342 with SMTP id
 d9443c01a7336-2a7188f9521mr12387155ad.37.1768533684291; 
 Thu, 15 Jan 2026 19:21:24 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7194164dfsm6101445ad.88.2026.01.15.19.21.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 19:21:23 -0800 (PST)
Message-ID: <09691b62-5d11-4f90-9da3-cab48d075c2b@linaro.org>
Date: Fri, 16 Jan 2026 14:21:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] loongarch queue
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org
References: <20260115064840.219920-1-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115064840.219920-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 1/15/26 17:48, Bibo Mao wrote:
> The following changes since commit d03c3e522eb0696dcfc9c2cf643431eaaf51ca0f:
> 
>    Merge tag 'pull-vfio-20260113' ofhttps://github.com/legoater/qemu into staging (2026-01-14 02:37:13 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20260115
> 
> for you to fetch changes up to 49ee001a5b8378e9a9b3db8cbf61e7eda970ecd2:
> 
>    hw/loongarch/virt: Don't abort on access to unimplemented IOCSR (2026-01-15 14:36:11 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20260115 queue

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~

