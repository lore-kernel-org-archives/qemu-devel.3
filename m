Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB63BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 22:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEbm5-00039F-Sl; Mon, 12 May 2025 18:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbm3-00035k-U0
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:37:27 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEbm1-000870-WC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 18:37:27 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b239763eeddso3111634a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 15:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747089444; x=1747694244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0wowRMBlLWbgb0U2jIpmdTetg7/6QDEIoZlR+6wzHcY=;
 b=V75fEy6KKybvR+Sjw0cpPNlzS48QitzEipRhvC0p0vo9EZZFTtCvC52GyJ80D/Kijl
 34OHT/Sxhcabf+3CP+elgimdPDiVqGqDKLQIiG9HhwDMpPBOBgMTMBKLREJervUyAONh
 IpxcIZBtZSLRyroh/hSL0RJ0Z8gZMNv9Nd8zLVLmfFTPWu9t2zS05IX8vW2p8s8Tn9cc
 aTwWos3GSapQsQ7AqjXC13fMn/u5+QhxEjpTjHKNcmWXr/gNGpTI9eidp7x5aCbb8b/V
 s2UdnV7u+cKNANIoKxlJ4Ygy64yfn/bz9Xxp4CONB9nGv0xRdhG4Gp69M9utmjn1ce/2
 WWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747089444; x=1747694244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wowRMBlLWbgb0U2jIpmdTetg7/6QDEIoZlR+6wzHcY=;
 b=NvwMgwtl+uar2lkmOHZhbGnFVuSE5I83PkaQO+MAjggpQssH3ea861G/Oz2AlGuhL4
 zjdTH21VUUo6x9DfZIrXCEQHSPvNFtuddD4jSPkw8k/YHRi0tfdyHC05GEZV+OtXjopP
 kUMwVBIO6ZuAHYxjhDQD8QeSDTB3tcSphMj8i6sfh2G2J9g++ntDA1LYql0uzK8fp0u0
 bokzww1mcc2/MpCLjMyH/T5uHZbzGJwl1kVlyhmFSQxw4prH+0hm41lc8soAmxwB5+r7
 A7KKlE+WnAoBKNCyJBoybvzVLWPOJGMRiAGxGj0QHR+j02WBAsb9IeCyzJ9qlxi4L0nL
 gIIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqcVugCDVtHWiv3h51xBIpTzQdOi0AHmWv2/1KS+p/Epgykf3tBUajkumrG/JVjUse17kGOyZ6K1Kd@nongnu.org
X-Gm-Message-State: AOJu0Yxii0ZFwDN9jO1HciFDwIjnsFt8gxl/JEe2Qg9iWyUOG/fugPBx
 gOM8eUHcDrtZzaHZ0bjt8AFE9ab7rTuA62zZos/SOxBrMwdDd/lm5mS8+H7RhUA=
X-Gm-Gg: ASbGncu22XXR9LkqDkTBv/HxtF9IVr2fsXn9glTQMIRHvRxzrS5TewEXlaiCkH5Y2SJ
 9EQDv29DSgAXkh9hJUButOn2BBG9N/dyzer+ANkejz91Kvp5oSFztEnL7KV+us3FBfrOCrzeWCr
 N28pZgeWpAuYWajuTxO5jAAI0SC0NLjy58ZBrrajb6zJWqOT/OWqQ1v3cNuhCPrxRKvRjEHPpcU
 hO3w/NX8YSJtI/StZv/X9jusB08ntC4PuZJpx3f0ln2IWrbr+ttEb+6AR+rb3gu8ydQSPaW7Ops
 aT5ot9gBz1tXGq2lQ8m0myeIIpsrvPAijmYJMW3J5ZkVx2Pt9qE7Bv3+C49GTUHh
X-Google-Smtp-Source: AGHT+IEjxn16G/iPLOfvPFOv5qfYhFM7oOtkhCmk+fHmPeTkuWEKInR3YmytFTDGmAvwNG5sLU5n0w==
X-Received: by 2002:a17:902:fc43:b0:22e:4e41:3ee6 with SMTP id
 d9443c01a7336-22fc8b40d5dmr207843915ad.13.1747089444410; 
 Mon, 12 May 2025 15:37:24 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7742f3csm67813125ad.99.2025.05.12.15.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 15:37:24 -0700 (PDT)
Message-ID: <85ad4e9b-6c46-49ed-aa04-fc497ae7fc9a@linaro.org>
Date: Mon, 12 May 2025 15:37:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/23] plugins: add hooks for new discontinuity related
 callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1746968215.git.neither@nut.email>
 <de35ba0200017bef2126899f918b6be8830851ea.1746968215.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <de35ba0200017bef2126899f918b6be8830851ea.1746968215.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

On 5/11/25 6:13 AM, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition, we
> recently introduced API for registering callbacks for discontinuity
> events, specifically for interrupts, exceptions and host calls.
> 
> This change introduces the corresponding hooks called from target
> specific code inside qemu.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   include/qemu/plugin.h | 12 ++++++++++
>   plugins/core.c        | 53 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


