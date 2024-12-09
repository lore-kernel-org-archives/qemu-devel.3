Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF8AE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:08:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgJC-0004VC-Ko; Mon, 09 Dec 2024 11:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgIo-0004T0-RY
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:08:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgIm-00019X-U2
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:08:06 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434fef8203fso3949075e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760483; x=1734365283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hERu+cSTx3+deDW6kLs8I6zsVPJQDgKG33hAFlMSxIM=;
 b=bljPjiBBrqS2wqtDejeMN3jNlt1fRYeSTBfiyP0YI7XKDRD3Qs8u0/EZ8owS7XuyBD
 pjPsk8WzGF9WRCpLXrCJiUF3mxBsZAL0wq+RWB7si8tXrnCvPB04hww9bKNjTHNhDLLt
 md8V+ECcOL0+BvhIerwgG2RSkflKIRPDcRCZzF11hQfSS4So6/za7MTDFgiTe9IcqNe4
 LBZXPTtCi35zcHnkimWagk+PJWl0IBQ/UVfrdItjtSoXTQY1bNu6O4lMlSIuDjKEOWpd
 02A3SDE8wGUdg2M8iVL5xj4AmHiOz54TO1DrjdGhalzg4J9+YWlmZdDC5uZffrUxOa3i
 JzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760483; x=1734365283;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hERu+cSTx3+deDW6kLs8I6zsVPJQDgKG33hAFlMSxIM=;
 b=LwLNwB7cRAkqPKmmwvUGgVW3jxPcOGrmrlSdx6xoGYcpHQxd41RgDQfAN4cgFtOvfG
 Urauair/3rqwLxtJpU36Fsv/MQ7mPIAek3w96nlXRldLwaFVX1r21K2Yd3CDkBv/xY3u
 XUCcLL3cHh3t2Sf108OH8bqjTWRVN+wzbAxCVwQZ73LuXevt8ymMC4KkIYbfO9r/gZTF
 MzhoJpo1X4ap8jcCK7OJpGyLUHdsaP8M1hWR9Y8blmj1aoIGsTF56Af6bGuyMdWdau/m
 iTJ/RbWXA/23aCVZ3PC8Lskbhlr9efjeuHoLlRKGW/+5gjs/Ju5647EUg9ZCAGsXtOoN
 Cl/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLzZJWYigwD5i+7nQXCPX04/IF7Ah6Y0oWnHYBhcplv+BidX0lA7/fRzQ44BDrT2vGmWdO93H2WDrz@nongnu.org
X-Gm-Message-State: AOJu0YyTrvq+ByNv3ig/SjfnqnYIlTiWfu+ezikat+wMZZ/ffSze40fw
 Ec+EsrSQ18S7QLmnZaeQUEBPp7WzuupA5jIPMDeWJX6oh8a5v82e/Ckcikv7Zpg=
X-Gm-Gg: ASbGncvZBQAuMlRO2CdznM2ZPzZHiPo39bhPRPt5mDWiLKTbnhIjw7Ru94ala4ehM5/
 bRZ5r2wR9JmKqraKn5Ga1uYqsumNsuekObAAh/ZDQRMFpyuYnlCG0lho59XxaGCYbpDp/d0+IDT
 lvU7UulfZmsCtBqZWC3CwQXmta5iFAJcvwAOPa5RXddrKK/rTvgELeO5QgLVBYzaf1ljwNS9xgV
 006vieMx5vgguB8xIvKO8AajN0bAP8CUdXyeRxEsu01wLmMVA+Ji1rTBtDf0/YHHOZ/uLAPdfE+
 WPE+n7hS0UXWpQ7tAYIM84B6KdAd/hbS
X-Google-Smtp-Source: AGHT+IHmtenEIhsOKN4etPQIsF4fprsUZKIA2Ec/a89qUjVshLg28keYv4sgr35NHF7EeqgYNv+a0A==
X-Received: by 2002:a05:6000:154d:b0:385:cf9d:2720 with SMTP id
 ffacd0b85a97d-386453dd543mr702838f8f.23.1733760482904; 
 Mon, 09 Dec 2024 08:08:02 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0be4sm197680455e9.28.2024.12.09.08.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:08:02 -0800 (PST)
Message-ID: <27ec9b5c-f1c5-46f4-90c0-c024383a8053@linaro.org>
Date: Mon, 9 Dec 2024 17:08:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] target/arm: Use float*_muladd_scalbn
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241208224844.570491-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 8/12/24 23:48, Richard Henderson wrote:
> Use the scalbn interface instead of float_muladd_halve_result.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


