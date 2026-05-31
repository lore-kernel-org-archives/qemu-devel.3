Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5504CD6E55
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 21:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTnZE-0004XN-C1; Sun, 31 May 2026 17:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnZD-0004X2-6Z
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:19:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTnZB-0006XR-Q8
 for qemu-devel@nongnu.org; Sun, 31 May 2026 17:19:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490686877a1so52806195e9.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780262368; x=1780867168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZOmWwFfDSQnQwK/dDtYQLwzrYOqycP0SpXw9w09dvg=;
 b=Qk49x6QQmxrhjPcRKsZ8BYYSRDwGJ+dlOSTO1VkSc44DcB2L/ydDFiCrzb0pWXBWKE
 kRzlGR1fILUnwa+pvhfxpKF5EHWqGCml5d/9/nzs8wuwPSUAZm2g7zwOCxo3HKwuCPR7
 ttwuIxMnovYtUqSvROZ+qs+3StsZymabqBcnasvXBWGbvSxGKFklJsXPC40RtFeHLrVp
 9REZsBkUfVI2vgF+z1+GDAHbkoQERrtrZpqR2Ohx/x6Cdmq0v3Xpk7XtFvI0Sy+RqHWD
 mp+pdsRWP2Y8u+ZFYUToAXeVLYik1ha8jV2iZ6HGOYixzb42RkCiWYSLllvZy5KKXhkE
 ChUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780262368; x=1780867168;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZOmWwFfDSQnQwK/dDtYQLwzrYOqycP0SpXw9w09dvg=;
 b=mGumTQO/wS2KJ+b8UuRSbzswKl8Lc7fBUwf17cHQFQdnSXBX/kfESB9B9En0R2EZFu
 AUgt+jVj2Y3ixnqr10bubGSlTSpzDQ1NEYJM/IQRgXcg2qHKBTf7ykti9XHAYqLvMVgV
 3Yo2I6jKKe7YTom71UpWmNVZcs12i305aZQAnyFF6kiWKdkSwjPuBExVpY/hmvBcG6S9
 bUNEA9pM9tf32gXlI5ncGGgHAq7rfwwiL2xIppTl1/MVNkefHv8xuWofX3gdd5drnlL0
 hdlhJS3ddgD8Pt/sh3I3j+lK9IVO40w1qw4NSv0vwGV0WxGhlI6W0tvzLOXX3oAJK7R/
 ALvw==
X-Forwarded-Encrypted: i=1;
 AFNElJ86ytG26mRC5rdFeFXmVLj6O1Ma9oXcRgdYBt39qfeOnwtFVpI7DJ4j74L4gdhHvLyMM/ylTowk42bl@nongnu.org
X-Gm-Message-State: AOJu0YyoCC6n3G85RMoMUdsGx4kel35FmG7px+VaNDVMmTvsmZ7yiFHN
 vrvbS3JNJbamg2fwIffywn/CQyOpHJodVUL3ibjJrW0IiFhCx1pkm8TvmI+5jbrmOGU=
X-Gm-Gg: Acq92OE2E+HpryrTTNBej8yNHgfdns6M8j5CXAAFCMphyWFvzQlgOyBK4+udDZilD1J
 /X5AysfyZyeBJtPaE0lwLh4w44+5uOkKFUnv/DjIuLF4RZtCuL1hVOX0PUybPUVqTVPOM4VaXCm
 lp0k+a2jfRbN9SFnbxNjfBI9WIqOIpbHa+VQR/TmnhEAuxJcmw3xT51eRnlDpWL9YfsdfioZOBh
 bkgHUFG57MN1NsgQ80/kIz4T4cDqexm3DQBzbmYCXKSwXvymEw8dFyVT7Xcpy2ThzIE9rUjhNdN
 fh6OvpipJICYksVVXsQ0VHgD43bpRujn1b9fqPtJClO2QPtQaTKppgOze53NG6gXlsMRx5UE+jq
 t6LMgqg5waKDuX3KLg1GvVh5aBhgZGev3W/zkCAI0OsA3O27jqKJYlDc/agytVrZ4do6BL9pQ6m
 uiD5WF8h5u+SBwXQsuvY7hZDdvpjVlIiEY0vgFHa+n4hAA3oFPO1D3F9sbBB7ry1FThswteWa3d
 znd
X-Received: by 2002:a05:600c:a08b:b0:48f:d620:c27f with SMTP id
 5b1f17b1804b1-490a2a7c401mr117417945e9.4.1780262368231; 
 Sun, 31 May 2026 14:19:28 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cab7b00sm211771675e9.14.2026.05.31.14.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:19:27 -0700 (PDT)
Message-ID: <e1200733-23fa-442c-a364-e7a3c01193c4@linaro.org>
Date: Sun, 31 May 2026 23:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/38] target/hexagon: Add a placeholder fp exception
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, Brian Cain <bcain@quicinc.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-11-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260529215554.606133-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/5/26 23:55, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/arch.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

