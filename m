Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F056CD4F47
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 17:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOf9D-0008PC-Md; Sun, 17 May 2026 13:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf92-0008My-FZ
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:19:17 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOf91-00017p-2v
 for qemu-devel@nongnu.org; Sun, 17 May 2026 13:19:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-366087480d8so1206865a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779038353; x=1779643153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=swJS/PRqRUKNQubMwtcKvLt2zQhOsttzMnZXhZCGXHU=;
 b=MzIB1ry3GJtlEL61qgRZ486bHJdQ8c70126IoYzTVyYzuQPgFJDuBZbt1IkY5YXbg9
 vuaSMuyRUDWHBvGNQdcHSPhJhoNqtc4OEd/FmcWzy0hGm1NZz9T3MuggzRurDs9d0HeX
 WWu9+17f7AGYd4s1KXHGL77oPtaQxnP9q9FNCdTr0VklwnGp0fVYaJKunfjAs2hVg0U7
 Sx+W8o/oGjNVB1VvVgyXwsUgAN53EGnX2T6mrJZ8amh5+R2+mYNFVANIVViaLavcqfbi
 mlsp6tMASN7eCuoYrqmunGzRq6wkjBpO4/R+VL8qCnzW1wFMASRDtSjg1PLIPToW4j9K
 lXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779038353; x=1779643153;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swJS/PRqRUKNQubMwtcKvLt2zQhOsttzMnZXhZCGXHU=;
 b=cTdCYNPWggcX53538LivbPhr6dH/hjrk1INmFDV5HPN/LMrbrA4eSxjhgdh8A7mwgb
 MuVUavAEEIfhnxFnPOQjgY+LVudgf2wqUbDKkHmqDHw7E24HrzBp6ZYcdic4nvJeyawc
 BYncolJ4GKFp9amGpc1k8Nwe/rkNXwGAAixIdh/X23DseBrq4oHm0bNLxswCDSvv0QLB
 4C8XZyeQ4RHtJmTbSLRIKeWXc0/pi3Y/SNSd3aMo/sYGRLzlLtp6mvtw86O3ShfKlBZC
 h5WiQ1QU72PZTWu5+zLSmxDMHGO5WUGVbjEJUCPGoy34zx314smDIDkPXAqt9g+gHpGx
 mDSg==
X-Gm-Message-State: AOJu0Yx5ZTNWKzTUR0nrJnhu4HU73IZjCmj8ADww4O2y74nlZD5sogC6
 9TcHcGw9QUjnyrGBxbt/5m9o9WGDzGMr4SasOaTJ0T5QTv/Jx998vz40WTE8Fm2zrVSpvESHXtU
 L3PIz
X-Gm-Gg: Acq92OHMl9Yw0uNNtJhIGHSa50LxI6ivfzllkkVfNASVi62UWYc8TYnZDGG92SWtkxj
 YdaCv/27EtCJVpvFqCeNG04TNmBXD7awisfPjeDA7gGB5D0uTbbtW9BiYczWNhk/fkBIHRksfJY
 db1mLKVGAya6L+MGuUcqY4Wu6hh1AGPB9kIcXBgTR8w6WTeMwHAfG8ewdZggPx4aTMS1H4JkAZu
 P3FOpDmFkng8fVsAcC7fCUDsLS/2PtsmMaSV9EvMUFJLuebtsfrwNOvpidXvAS37uE8MDGAekCA
 +aApDT/MawfLnECDJdQta+wzxXs54IFiwdrTeBbI4s5Q+rfb8O5yXYtUAraR367Tu25o/YpuLnd
 nIDB0sknxdPYbxhoutGx7imy+XtNAIw6EXZ9dj/GxpEwOzSZ5fSKzpRDq25DAh1voTNEAKLht4x
 pEWVIXd/2UmZ8hwzVIeEfpGyRSCztc68pOPPLu
X-Received: by 2002:a17:90b:2248:b0:368:341a:a925 with SMTP id
 98e67ed59e1d1-36951c97685mr12321992a91.23.1779038352559; 
 Sun, 17 May 2026 10:19:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-369517ed182sm8676769a91.15.2026.05.17.10.19.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 May 2026 10:19:12 -0700 (PDT)
Message-ID: <5b9eed93-fa48-4345-bb41-edc028dbaf30@linaro.org>
Date: Sun, 17 May 2026 10:19:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/dma/omap_dma: Drop model argument to
 omap_dma_init()
To: qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260512203414.3633237-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 5/12/26 13:34, Peter Maydell wrote:
> The model argument to omap_dma_init() is always omap_dma_3_1, and all
> we do with it now is assert this; drop the argument and the enum.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        |  2 +-
>   hw/dma/omap_dma.c     |  8 +++-----
>   include/hw/arm/omap.h | 12 +++---------
>   3 files changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

