Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA34CFA477
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:36:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLgM-0005Ff-52; Fri, 21 Nov 2025 02:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLgK-0005Er-9j
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:35:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLgI-0002Lc-93
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:35:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso999936f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763710544; x=1764315344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7Da7BxlN32zW8JJ8ncfQlt/aqJvBs3GD0nYjclpg5w=;
 b=P6uRoppSOHdNmyPo7tcA26ZnTJeZuL3l+l8/zKaxCkihiLFAiIZvIUHVol3owSXvwg
 EzlkcykJs+Rwimw4m2eM3scxj2gLS1ykitGMfwxKiRIpWW0/m/umqFJcsRxg55J9g0Fy
 NP5DTeXHdMlbiJbNPpDrvETguT+PQfivgwqft8Wx2gPiQH8uwSdQdY+SOswWoEVP33PW
 S9wlSSR3fzNr+yMqVrHs4TYY1dpaOaxSheuOjjLVtbWQMH2y1dVrlmil6V50u3W+t7iZ
 JwJAr4MQdyXaFmtl2JTLgTeuz40ajLEg0Q33W7zadytQ76JRUtxCP4vjfwve1eQ7b5+P
 uogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763710544; x=1764315344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7Da7BxlN32zW8JJ8ncfQlt/aqJvBs3GD0nYjclpg5w=;
 b=sb0kDUVlySSG7aPKCpNCMqoSsGNPIi5Rw1kIJJha7dnvi6q8LdJxQDP3gUpxlmp+qw
 Ukt45jseYCjnjZwLgvqAUxIZf6U9khv/yuhtzzBHlrRSr52ZlD8NPmNisNuupy7mkoWB
 FAojkLNX7DAmkw0UBfYc8QsXVF4G3px61FG5trNCPrzfV5YHE4jcCezmL736LlLzfw88
 ba0LXmqfe1gb/GSSCZr9Fn4nGBy085yXuqGBOVikeR7nxO0xOKTqxlGJJIimyCZJWEgf
 p6E3NE4kpnZx2hDvRbeS1wkYCqukQrfI+9GmOzRqBlDYXgBFNlEV0encte4TyqHLlokL
 nWsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9KXjd3LPMgQ3Ao7jPOqek3/34n62SKfiopiSexYTF0E8bExILBsUnHxh6F0Mj3oHP9ljMgtOXNlHg@nongnu.org
X-Gm-Message-State: AOJu0YxvDt0iEkyLCMNTmPhJN9f1vZ2Gj+WMCpImCNi6kXHk+8qakES+
 OZuX/Xt6dTD0Pb0TBQsyM2yY4WWt9DIp9P3p7T5LRQv2Rh8qnoEN8yTamFakYQI2K+I=
X-Gm-Gg: ASbGncuhvlsXUGytPGMNnQKW4XaVAiZWPwx/o69gm/Bw6otW9wkyXTXZpoMeeOQIvXG
 svUqrVj1FgqW4lEH7oU7yaOxlfbvo3ovONURCLtOiqoemrp3NkUbqEW5Glhhe5EVQEXL5EIquJ4
 EanKHJyqDlEYJxFptsWRNY4WDknInKK7R3UtBHbmGdw9b+NMCoiqb4FJ1NzePwlOmjJzmAMF0af
 6B6s9ule8AnfwWKSVIHGAXLKHw9yUM2KAFUbdMDSo96rMkpE99W1DCs3LcN9JfOnOviZR6/ZQAP
 rCDx2gstPZ1cJjJhDQ4IAHDusgHqv/uALmB07Q/z4ba+rnu8XlDSjtLBUAhMHK5ET9JBxZe9xkL
 AUgLJlXEPa67Nqw69W/zZkPDGGKzWJhSEuAVpXUJk+nfQpk1ihVpPl6WYhEfIVVsmpfXTeetmMl
 wsMXMIbXzk7pQaO0PizGw55wRb+1bcjQsl88Si0cOu863tulZmUbfj3B2pcTbl0O9/qxa53J/9s
 vM=
X-Google-Smtp-Source: AGHT+IF50liua486BgcNzIBKTAfeoZ9UTL+EOb+/v9Epcs17RcLBuXnqzlnGA6PlE64ihsBAfBYSzA==
X-Received: by 2002:a05:6000:230b:b0:42b:39ee:288e with SMTP id
 ffacd0b85a97d-42cc1cee3bfmr1070312f8f.13.1763710544502; 
 Thu, 20 Nov 2025 23:35:44 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9022sm9367535f8f.36.2025.11.20.23.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:35:43 -0800 (PST)
Message-ID: <f642dcc0-b574-41f0-be96-9d4f07ca282a@linaro.org>
Date: Fri, 21 Nov 2025 08:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/exynos4210_fimd: Account for zero length in
 fimd_update_memory_section()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
References: <20251107143913.1341358-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251107143913.1341358-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x442.google.com
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

On 7/11/25 15:39, Peter Maydell wrote:
> In fimd_update_memory_section() we attempt ot find and map part of
> the RAM MR which backs the framebuffer, based on guest-configurable
> size and start address.
> 
> If the guest configures framebuffer settings which result in a
> zero-sized framebuffer, we hit an assertion(), because
> memory_region_find() will return a NULL mem_section.mr.

The datasheet is not clear about what to do here...

   41.3.10 Virtual Display

     The size of video buffer in which you store the image should
     be larger than the LCD panel screen size.

     OFFSIZE_F should have value that is multiple of 4byte size or 0.

     PAGEWIDTH should have bigger value than the burst size and you
     should align the size word boundary.

(virtpage_offsize is OFFSIZE_F and virtpage_width is PAGEWIDTH).

I couldn't find any info more useful, and your patch is safe, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Explicitly check for the zero-size case and treat this as a
> guest error.
> 
> Because we now have a code path which can reach error_return without
> calling memory_region_find to set w->mem_section, we must NULL out
> w->mem_section.mr after the unref of the old MR, so that error_return
> does not incorrectly double-unref the old MR.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1407
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/display/exynos4210_fimd.c | 7 +++++++
>   1 file changed, 7 insertions(+)


