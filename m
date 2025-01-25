Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74027C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbip6-00031F-Eo; Sat, 25 Jan 2025 11:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbiov-00030S-HU
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:15:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbiot-0001xt-Iv
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:15:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so19771425e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821737; x=1738426537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zPV/1MTxvKrqHYCPQM5Blkhas6DcmImnV1DJnkvwPMw=;
 b=QmjWqtCfiQ+yUYxBJDvJMNZrgpX82/+e1wRclS81hR0MHVUagnh6kXSKQPGFS4C2l1
 FtqRzzmuWIcN4XLb7lLhzfEe21JxHMPvdyDCE0FWGOiN//a6kTEiwhgw5GBzVkFhH55g
 xZYcY1hpqVQQOrLUnbT5HWToe5sBnyztOJMyVYiDnMB3JxsFPnmiGHgqMPt7p0ghD6wa
 UtmCvBwWBN1Z8FwtkFN5EGTCgw5GRzMaKmdDfGh+IfBvsGwAyabsfDlbibxQk/IfZxL/
 vMkDgptZbSBahBenrHmiobNlU0OUpkofoVNKn7Vc0opfL3v0WPyshb6/EPJK+9h8sazI
 HXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821737; x=1738426537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zPV/1MTxvKrqHYCPQM5Blkhas6DcmImnV1DJnkvwPMw=;
 b=hLPIS81a3OdlmiLbyh+DLhgysyh9I8SXAk6QSozOVirfEjyCEzHV8jEUIWWGvDgKRT
 fCW+gf6mxyLettOyyDUI9UpJgZkDBNsnLceChP3pPWEzZc8vhRNZ3Z01VmusrRGof7q6
 vKZmt8PRNq7xn9I4EID12XsmS/U9JG9TZlYSl+kYFNXGBjonF+3PAqYWaMLhyO6RoFRg
 3RxmJ+xghUc/3PlC9g9pfdDKvMWwjltRqDE1gaX2unO73beSQ86yqJJrgrHaYN5NzNph
 46j2Gxj7Yj6ffnJP4o55wfz0waC5SS1JCn5BAtHM91a26h/yxy95iljwUYayQ6jB1T+Y
 ZBKw==
X-Gm-Message-State: AOJu0Yz63JCdiGSdacTtEdhw3+n4pFOpQuWI+vxY51Adj5++QtKw8qV1
 fA7iOvCt1XJBLbzlEikP2BGgPXd5IkxJwRhisc7mgox8rfhNowR84rS6gAucCgfxg9NqLbbeRpy
 dnBI=
X-Gm-Gg: ASbGnctfPVkSTMyLRCQlCFTMz4KmLG6KRgFC/xw9Vt+wxG9n5wOn18Zr7SrXXsoVDOV
 arq2oEZHzwANNCYk1O4Xja+Upuhl+bGxUiLmq2M/O7dp8pygaf2ThQlIryUi3wfyAAFwB82zOoO
 0KypPF58xJypl6hnQ3p5hfSQSGFUxhuG8BB5fsyEiL0P7u7YmqC3EN0Ip6ln0iZZk5EBj6ZXna9
 ns2wKt2nQWNJCDZnjTeRB7l2lIxgT7FfQ30M1X1jaJXZHfUty4QnIRHBR4rmeg5tBFdsyJWknw/
 bwo7IUhZ6ucSVz/hRnhfJbkJf+9cYOYcpoe4CiWIRPnXZns5aiK8rw==
X-Google-Smtp-Source: AGHT+IH9Win7vTevQurUVamTVP4Jj9O8CA19mMg7csQXHG4Vq/mbUobe3P0hOY0W50fLe/LtFyU2sQ==
X-Received: by 2002:a05:600c:4e08:b0:434:a4a6:51f8 with SMTP id
 5b1f17b1804b1-438912d4a3bmr349472675e9.0.1737821736819; 
 Sat, 25 Jan 2025 08:15:36 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd507d60sm65425195e9.18.2025.01.25.08.15.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 08:15:36 -0800 (PST)
Message-ID: <7b609068-cb64-457d-b3a0-2e1b5a3d7907@linaro.org>
Date: Sat, 25 Jan 2025 17:15:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/24] cpus: Remove CPUClass::has_work() handler
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
 <20250125160552.20546-25-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250125160552.20546-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 25/1/25 17:05, Philippe Mathieu-Daudé wrote:
> All handlers have been converted to SysemuCPUOps::has_work().
> Remove CPUClass::has_work along with cpu_common_has_work()
> and simplify cpu_has_work(), making SysemuCPUOps::has_work
> handler mandatory.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/cpu.h            | 2 --
>   include/hw/core/sysemu-cpu-ops.h | 2 +-
>   cpu-target.c                     | 4 ++++
>   hw/core/cpu-common.c             | 6 ------
>   hw/core/cpu-system.c             | 7 +------
>   5 files changed, 6 insertions(+), 15 deletions(-)


> diff --git a/cpu-target.c b/cpu-target.c
> index 98e9e7cc4a1..15aa8afef55 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -217,6 +217,10 @@ void cpu_class_init_props(DeviceClass *dc)
>   {
>   #ifndef CONFIG_USER_ONLY
>       ObjectClass *oc = OBJECT_CLASS(dc);
> +    const CPUClass *cc = CPU_CLASS(OBJECT_CLASS(oc));
> +
> +    /* Check mandatory SysemuCPUOps handlers */
> +    g_assert(cc->sysemu_ops->has_work);

Thinking about it again, this function is about properties, thus
this isn't the correct place to do that check. I'll revisit.

>   
>       /*
>        * We can't use DEFINE_PROP_BOOL in the Property array for this

