Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDE8C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 19:11:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqyh-0004k5-Rf; Tue, 28 Jan 2025 14:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqyf-0004jm-Vw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:10:26 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqye-0002Hr-20
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 14:10:25 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166022c5caso96523625ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 11:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738091421; x=1738696221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Kcgv2eXaFHv5SGUG/wPANzI5CwN2KvJHTaV7LE75ktk=;
 b=n1axMNpKuu0mBXYKeJ+OA39PpQPUkH7oD3422S7SZAUMeJBb7GTo4Q+sDAtWbYzc8a
 /AyA/DUvvCggJ7GEo+PWobght/tWGCG/KUTqZr1YIRxtdNteBKdw8s5j0w3TT4sqV/Bm
 1cMH/xYYhht4kf4ff2ck2LzFcsf/hNuHpwYwrn4GMWlkNeSqcm7Jgv/2ign8QgbA2F7i
 GiJ8wLGXUi/DZrDwV+r7I17qx4DTR0loJ0j9TtvSsVR4u17/ap2dp2qlzc/RFlICbH0W
 pGuF5zCcr2UyzkaEMR49//5RdgorRq/ZtbUcvLSxuwVc78XUDDaz238FyIK4r+7yt0ip
 cXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738091421; x=1738696221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kcgv2eXaFHv5SGUG/wPANzI5CwN2KvJHTaV7LE75ktk=;
 b=uQ2S2RxBvihy2nLN3s/Dg4g3nLSkvofsINVccIF+7GRPC+C1G5kLdmj0Uxvuje7fS6
 YzF/a9OlOZ5d3PPthIiMHsCkfH20xjH2KIcXIM6OMgnHc6GBiigHuUI4ri+qwBTICdtQ
 WKIiVBTU6fisej2HzsGqk+Ewrkrk4QHWPYxR66Dl3Srtb/WjHTZmUbaGBVoMvYR37kyU
 n4HsomXP8DMzVfhTYAMOcIp2AbATvHT+EyQ2LT4myUaHM6oAhtrXQEyO5iSIjSLSOOSd
 VYtDsLGf7I8K/Wek+GeDOPupQGrUMs1EOHVmjeEfBAplL6jZ3HRoY0xa16T+C9Qs3Xmf
 DASA==
X-Gm-Message-State: AOJu0YzRGxqTScmWK4Ien1cgZF5OyBZjovltKv9MvRqU96qJR8wVznNF
 TsQtK0ZO9LgU3pp+xZvOcU0bTT4GYxfqkwDUOuXTCuuUkvojju6lRzVHH9Dd1b2lMCBw9vvv1aq
 b
X-Gm-Gg: ASbGncvV4CsqpDMmBKYB7wQl3kYNs08J2C+VAyo3fP4Cl4fAD9SQGktC8LUVVWAVXfy
 +YydXNBUl73sqW8yNmaF8ksxQIvvlpgftmuSscrS0xbinwFiA5ZmgjVRqGwmacTFqF7wjfWGR/n
 4O4MtIoKTgB7Fhox8RTNERIa+Bh3/qow1/YpimhORpm3vyLEXcBx/3cpAkTcJWbKbhUVv2ghe8R
 6yKluX3lMIGdcFqJAKJBCiuFrU+idEimR39DOBkpblT3mkzoRYmMtEo4KY3yyB7kvNYpj4+2Tft
 oVq2vnVMdLkveGJd1Y+glDMW/gq7RjPSI+ka1TyZQgcgo/rOH0Onu3eOPw==
X-Google-Smtp-Source: AGHT+IH/YUWRTC8EalZSql2W6wuA7pd9/bA9UwrlwSJHASkwFJgyYmqF6p7gM4uoacOeO2jUI+Vjig==
X-Received: by 2002:a17:903:184:b0:216:6d48:9177 with SMTP id
 d9443c01a7336-21dd7c354d3mr3934565ad.11.1738091421154; 
 Tue, 28 Jan 2025 11:10:21 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48f897f33sm8824288a12.23.2025.01.28.11.10.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 11:10:20 -0800 (PST)
Message-ID: <2048868b-7954-46f6-a9fb-4a3020342023@linaro.org>
Date: Tue, 28 Jan 2025 11:10:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] hw/sd: Remove unused legacy functions, stop killing
 mammoths
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/28/25 02:45, Peter Maydell wrote:
> The sdcard_legacy.h header defines function prototypes for the "legacy"
> SD card API, which was used by non-qdevified SD controller models.
> We've now converted the only remaining non-qdev SD controller, so
> we can drop the legacy API.
> 
> Entirely unused functions:
>    sd_init(), sd_set_cb(), sd_enable()
> 
> Functions which now become static inside sd.c (they are the
> underlying implementations of methods on SDCardClass):
>    sd_do_command(), sd_write_byte(), sd_read_byte()
> 
> Removal of sd_init() means that we can also remove the
> me_no_qdev_me_kill_mammoth_with_rocks flag, the codepaths that were
> only reachable when it was set, and the inserted_cb and readonly_cb
> qemu_irq lines that went with that.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   include/hw/sd/sdcard_legacy.h | 50 -----------------------
>   hw/sd/omap_mmc.c              |  2 +-
>   hw/sd/sd.c                    | 77 ++++-------------------------------
>   3 files changed, 9 insertions(+), 120 deletions(-)
>   delete mode 100644 include/hw/sd/sdcard_legacy.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

