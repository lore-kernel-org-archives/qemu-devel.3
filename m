Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE38ECD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX0YA-00049C-4z; Tue, 09 Jun 2026 13:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0Xr-00047G-MH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:47:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX0Xi-0005hY-Pa
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 13:47:16 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0a5354da1so48201715ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 10:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781027233; x=1781632033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=agZAkSr0L1Wd5p4x7rtDTnWFmmXIlCAFx2H6argkI14=;
 b=ejn6rRgRG4XmZiyi5IZIyBlyOvhdsfbwgaqT66OiZp4mI21G8QT8qA7ucrt5lyHwI+
 oyTzU7cSof53Fsd+Mbrhj81Wj8W1KFPTkw/EaU8goUpT2qremxb7LiejUIlkqcJKIwKs
 8NwUl8n73Ru+ua7UaHCciK7EGZznqPWwGE9haCTj4poZhiyAhEzVYvBrmXIyKek82dwf
 HME9oyddaTZ8VUsSm7pFzbTCxZtuJOQ3smH697Ux66psCdCAMsuWsAg3NtWKgEIyDdfk
 Ap34EX4DAe1ZHi19bicT5vk57rC5tR5qVbdj6QsdiOIUC4SZ6VbPY28r18jq5JaCJJ2v
 ORoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781027233; x=1781632033;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=agZAkSr0L1Wd5p4x7rtDTnWFmmXIlCAFx2H6argkI14=;
 b=gvX8yxVY8mIoI1DkbQ3v1QLw2eBlQkeYMVV4Z551oBRVcQhk3iIOX31I0iaS39j1TJ
 J+7bxAgfVoiWr18viuSL5075w0gL/Agq6Tvvau3hVFUab2EYMYpSHhbfFuuSM+bUDeAE
 vKcxYlbldzLIt8SgPoadQi7cMH9SyG8nzFXxLbg6+PpAvzZxgZMwZzlE8shW+18gRpfJ
 SQT/QM00wg+kYwIxqEFvdyk44wHLlHMZ6QgaZ2jAtF+b7cFVaA3yQLSVJPCb5FjVpksC
 Rlpk2OYJq+FScyGzWwmyLWGeUFWfBSEFWhGM0R1OvtXvtflOtMxTrf9/gcmT0Gqf/9RH
 TeEw==
X-Gm-Message-State: AOJu0YzfrSLOadjNDFukFhbRrJXEJdiFP3YDKDme6N3VX4+P2VMWbSdP
 0sNGaGpOlM8ziAmjaLZlTbkrU5Jgr4M0UQ0aE8MlxuEZEPvL8AoXv5AhITZKEMkqVHWoFrpx/KM
 EeCaccfc=
X-Gm-Gg: Acq92OH/v6dFnxV5SFGb7hfzDI6Hkzy2tT1+UN4iqCsh5Lchgy9BWgo7mQyNCuOMYIw
 9NewWBvHXrkPxB5XGAvVMqJTuuBpekNEoVGeLngceeoGF3zLwdef0sycopUzw6Zw186TYLaR70W
 kHRwfzFnMZOLDJju8iHoqQho9X2QzLKqZDFNjhRMIcI/RoC4FCdsHgrh1p2cyK3lO61FRCLt316
 9SrgqWbXLAfbeP1ENBAUeyZg3gR+Hl9QlxAnosi0616fXwsCpfvrODD+EpPaLvvgAx6AhGtJyZR
 RYD6Jrp+oErgjs3tARNoi+/MgkNAu7IFGYv/PcucGqStOYEAgcGUirGM+5OWbWKaQNVTlpqrKxK
 Wg1DtN2n1ydLAsIMTVt6ckRn3IwpBHJlnXwKFl/vZOw6gYdW9jFg+k4onFcW76hbMjNAGslsb4S
 13oxkQAvoBpZBzq2MRxcj/SGalGY6HPqB+MJJtxi6FdBJeUO4=
X-Received: by 2002:a17:902:e750:b0:2ba:838b:bfae with SMTP id
 d9443c01a7336-2c1ec967a5emr172175185ad.18.1781027233161; 
 Tue, 09 Jun 2026 10:47:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f96b3fsm227889095ad.29.2026.06.09.10.47.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 10:47:12 -0700 (PDT)
Message-ID: <0124bead-9f73-4a14-9784-96fa632d5d0d@linaro.org>
Date: Tue, 9 Jun 2026 10:47:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] docs/system: add FEAT_ECV_POFF to the emulation list
To: qemu-devel@nongnu.org
References: <20260609140008.3206970-1-alex.bennee@linaro.org>
 <20260609140008.3206970-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609140008.3206970-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/9/26 07:00, Alex Bennée wrote:
> We already had this implemented since 2808d3b38a5 (target/arm:
> Implement FEAT_ECV CNTPOFF_EL2 handling) but it has its own feature
> name now. Add it to the list.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 18c63559679..3622e3889c7 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -60,6 +60,7 @@ the following architecture extensions:
>   - FEAT_E2H0 (Programming of HCR_EL2.E2H)
>   - FEAT_EBF16 (AArch64 Extended BFloat16 instructions)
>   - FEAT_ECV (Enhanced Counter Virtualization)
> +- FEAT_ECV_POFF (Enhanced Counter Virtualization Physical Offset)
>   - FEAT_EL0 (Support for execution at EL0)
>   - FEAT_EL1 (Support for execution at EL1)
>   - FEAT_EL2 (Support for execution at EL2)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

