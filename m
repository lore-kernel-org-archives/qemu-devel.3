Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583E8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GFO-0000tG-68; Tue, 22 Apr 2025 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GFL-0000iB-Qp
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:13:19 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GFF-00067Y-Rf
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:13:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so49650805e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745338391; x=1745943191; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xv2AhxyDBI7r1MTiCMedeCD2AMiO2XH51dFoPv+xjZQ=;
 b=IoqQzDZT3PrE0SG9+ugDqJOXuGAls6JPYeXFyHi49eaXsCa00rApDCgFMYL1NuFjKW
 CKTsPyR4yyfBVFo3K9Zyj1kReiwZmkguLN/rnVACUDaMBbLQikcJMZgn5f5rDHW+OoXk
 AT9xZmY0TAUXiWedMOybrimvF2VtZf3SyJiRpahLbfMQwXQMwboTplBgZbCJc+pLk4fb
 NKsyczGrcFkc2T0Jhabz46AvaTF85JXFkJGJDAMG+aK2/reOv/MMSB1zcUT073sE/MyB
 x+2egDKygyzrBpYaPcpY0yAhvKo0cF7vHOk5KN7JYoDgFdg5IZFytfI7OEP7woFU8VFn
 GR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745338391; x=1745943191;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xv2AhxyDBI7r1MTiCMedeCD2AMiO2XH51dFoPv+xjZQ=;
 b=tBqcFvmstRTLg5WWfLJfwdbk/oXPE9wmeM0V9NloDXGIA/B0+n4Cw1/BPmSoK9+eal
 iHCKt19ZnZ2VVCNcv6Tvro8diX26blrWbTpXkMtrG4/ZSKY21hatoKYkofUIt1ZjwrjL
 WKWXIQwax70tx4v8y2mG0ngm2dkS86xFH9Zy5RlTfzcEIXF1vh9LxxOyukBHYvN1xsKz
 FWq41XP3+A38+noKMzb0DKpV47pOGOpmFz7Us0lKJZk3MHY32jx11VA1Q184L2DB6W18
 uctH+4oPxOc2FLY96irqsQKuZe+n3TpQmID2CoJ9o2ZSSOjvxMZ9AYY10hcuArXq1Hwo
 Ylpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwJsA9QFCvXUhqaiopBLD0/2u5bFbUfrdbuNxgRThg2AWzhHz4i3N/vyHu0/2Laih2M1Q64yBeJoVS@nongnu.org
X-Gm-Message-State: AOJu0YxhlCpGwD0ATaux9iiP5BVm39zUmvA1Wq+l4t5rKiyuoPeTsjx1
 nMMWN76tmHLc/1FqCjwlheSkoKlvU1LRVEupl5KBRFg3dXCkcP939tRBHGnrvoc=
X-Gm-Gg: ASbGnctwbca2xGcsxLMJK0gkzsaWAOe7ncSqoAV2XWH5/MfBgw73iy7c/jrJfUuJ+q0
 yJm2XVAzjGmINtqAfEXdylwR8qN1BeLJhVYm62gS4j7uRY/sFsJN0eNskKyPicINQXHilhPF9K6
 GrYOnSKB2Jkp4jpqcvhpxU9cGap3C27e1PMlvuqglC05e9gFL/ZP72w0GAlrii9QxQulx/cH5X0
 m7KTlM9eUjG9L7SbMsv8tzFSn0ZBRO4w9Li2/KhfuHqoUm5yoJZl7XQ1i9/PVve8kBGDcC/d3gf
 EkL1xeBOp3Buw5q2ZidEkK4exYrFNLO+cuCHZVypEoIqC9P2Gu24AOeuZMpDGQ7JhyUenjJ8ZI8
 05XtGrLJJ
X-Google-Smtp-Source: AGHT+IHkykMpVHz1NfLa1hsB/fHoe4kmDnhzcDpiT6lCF/H/k5ot55//k/g6Bb2CvxDgfrNNM3SkRg==
X-Received: by 2002:a5d:6d88:0:b0:39a:d20b:5c14 with SMTP id
 ffacd0b85a97d-39efbad3217mr13067399f8f.36.1745338391180; 
 Tue, 22 Apr 2025 09:13:11 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d006sm15936891f8f.56.2025.04.22.09.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:13:10 -0700 (PDT)
Message-ID: <72d591f0-81e9-46bc-90eb-8efc39ea2d12@linaro.org>
Date: Tue, 22 Apr 2025 18:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 121/163] tcg/i386: Remove support for add2/sub2
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-122-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-122-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 15/4/25 21:24, Richard Henderson wrote:

"add2/sub2 are superseded by add/sub carry (see previous 3 commits)." ?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target-con-set.h |  1 -
>   tcg/i386/tcg-target-has.h     |  8 ++++----
>   tcg/i386/tcg-target.c.inc     | 31 -------------------------------
>   3 files changed, 4 insertions(+), 36 deletions(-)


