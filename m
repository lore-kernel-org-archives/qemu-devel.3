Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89278C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2HB-0004zV-PM; Sun, 26 Jan 2025 08:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Gr-0004ps-7C
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:01:55 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2Gp-0000sE-S2
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:01:48 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb95317so61653915ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896506; x=1738501306; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OEdVUY+J/xonC1evu6RVgFB9GnZeMjCRAQK0ChlOSXY=;
 b=jLu7b8kd89DAWIGsb4aEw3Y+w6JPJfb+BRKXAtnWKOwt1m3zku1j1778QyIjGRyu8H
 8rha/DWit5s6CH7cTK3uVZjN5pzIn2nZ7nYZS9oNkBPJu8CsjhSvV2Ea8YleymHhEhPr
 CK1CyX980/XZv9v/u1lVKLytwfjlgWBz+9WwKIyIhwNX2QUFodtCMKvCijX/QrKC6+U5
 Lw5ZtIIn7FYPljollaMcx7Kq/JHJ1rlQjHSuM6R0RKokv7VFJ1YvtzlFVHRRnHJhZ2RR
 jhztgwciMh0HXeWyO9NwK8N2MKPaH/qWXdgL50w/a/nA5GcxMF+6kw2j6wXqgVlp6gs+
 S3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896506; x=1738501306;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OEdVUY+J/xonC1evu6RVgFB9GnZeMjCRAQK0ChlOSXY=;
 b=Dxm35qCbjTq8BeKLUrA46UFMyBECCoTSGBXI0HijzH7sFcDAPO4oTwW+rlqGsmLuXI
 tUhjnSXFbnXd5vvZ2m0MkvFCfm47D9Q5YhxAyGNH7xAhwssCBdIX8yhI2Zm/8o3Uxhbp
 hGBtCWHrnVyEEUg6tYVyDpZd+TGJFYzT79KJ5wanvpT9qio25VHhSc9PBuxvFARcDz9n
 tAQIF73bXLWtN2nlwAac3falm0Jb32KfHSwZYpVRDlEwPigZw+HflUXl+phgMsCB/fav
 KqSNEwnLxSstwZeDsGT6DzcAf1gNjlHOdKQeIeeYpH/q1AsqZ0CYgrzDa5u/F4Eb4nRx
 dCpg==
X-Gm-Message-State: AOJu0YxYqu8fXxXUaCcdWDEbwVfl5Uu/2bJoSKo9TNqqvpoA2IGYwbHr
 RtzFB3w/XMQRguzeD/bhFwtNUjZtcp42HXjpxj2V24PP6l/4xpBbxI1x+AWcms4bWFUfK3p6j/Z
 d
X-Gm-Gg: ASbGncspO19SkEe2PyEOVdW6biGHi8nKkYQG6jIXza44FREfHiJEjLxKaIMseX6w25Z
 DVMJeMzKh7I+sOtF9OflYqeXfu6x5xzjZoBsDX+U6CN5olOtjgkcx1RdMgXo1sMX0qTX2zqCVkV
 7sHv81MvOcG5q+s5S55SviLZjN4VRC5ft2Yh0/otfOFvmA5RizAfq6koJFKVZFFKQWdtTxXdAnE
 SSUg8/orYuGqE5OKHp/ny1dGk1zsXye2wS7AwmdZX7YsIZYOtxkt1i6aHzFV7Zl+J/Uefh1/KGQ
 S1M38xGrPQZqQBfJgd1cyQA=
X-Google-Smtp-Source: AGHT+IG4OLJ1ta6Jj2dO8gqhhBxs5QTyoVDThU71lTeG0uvGO33r8x3SJowe1v/5+38ABcZFQ1ryHw==
X-Received: by 2002:a05:6a00:1741:b0:71e:16b3:e5dc with SMTP id
 d2e1a72fcca58-72dafa9d375mr55236825b3a.19.1737896506310; 
 Sun, 26 Jan 2025 05:01:46 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a798dbcsm5102647b3a.163.2025.01.26.05.01.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:01:45 -0800 (PST)
Message-ID: <4d5d2406-270d-4fd8-a11d-d04ee7ee84b5@linaro.org>
Date: Sun, 26 Jan 2025 05:01:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 53/76] target/arm: Implement FPCR.AH handling for scalar
 FABS and FABD
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-54-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-54-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> FPCR.AH == 1 mandates that taking the absolute value of a NaN should
> not change its sign bit.  This means we can no longer use
> gen_vfp_abs*() everywhere but must instead generate slightly more
> complex code when FPCR.AH is set.
> 
> Implement these semantics for scalar FABS and FABD.  This change also
> affects all other instructions whose psuedocode calls FPAbs(); we
> will extend the change to those instructions in following commits.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 69 +++++++++++++++++++++++++++++++++-
>   1 file changed, 67 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

