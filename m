Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84109C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lKT-0002I1-Hk; Thu, 24 Sep 2026 11:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9lJh-0001tU-56
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:25:03 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9lJe-0000FF-I8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:24:56 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4aa0f1a94so972183a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790263492; x=1790868292; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=isoanjkjZm6L3AdaCiRWbGH6sJhDKRSkAoL7Vyzq7WU=;
 b=jGFgFq+0R9t6M26hVcLM7tcs5H6X2J2ypS0KrT5vNVv149T8BYrEhJX9XL9w4bXrIi
 NDen/WP6OoQtDhyL/yjoOF4iHknOsq6M2Z58gddGFbOapc1FIzpw9/qqadx7o8jTPHQC
 Hi3zFMLW30EokJHJKQHQ8o+lY6Y23Oxk9U+kLiK7sP5nmvUCpJ+O6QU+RzohvMGGRgej
 IzzuxXLK6KPMTzsl7QiY4vvdgHpkU4dEeUxjIKHVygV08xEPmSMyTSK67pOZ9srqihQR
 qcDvqwticzDCKNosyUIUWVI0SF0OlaiPttSIw/qsaxN90epidQ9BGvRXHX2Dlj4/bwBG
 yj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263492; x=1790868292;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=isoanjkjZm6L3AdaCiRWbGH6sJhDKRSkAoL7Vyzq7WU=;
 b=nTlm7cOJkR0fDYeW6ABNvnEREDQGvFh9kkwga861yUaKWlFRhj8foaOkoUxatcsoC8
 9nKmR7xOfwsXyHio/Ct83JgeBwKwQtgWEMVQNYfepAZb8ulZnDXzoa8Gq8nxICjvFxqx
 mT+crWALzSZFJcmqj3r3DUULiHY/kgWTBXLiFMN1+vj032NXcEl6xXIWWeQTNSZgD8S7
 XBNze34du521tzO2roziRu6txEgEbFI113TVGIurFJn+erL4YRhbooXhDfpCmLg2bXbJ
 +lp1uAboHrrwsYYe0btYyagMWBArpeZyzTeNTdwIrP2vEQjIITRu3QK3ELaJ9SAdgLDu
 PwLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpJZU54hWWbeUBo8IjDY9JLcXUGAu4SsAUBvefMx/EvgEG1x5KbqLvjBNZSVtEbHQn/SAnI1PvNoRX@nongnu.org
X-Gm-Message-State: AFuF++mEBa0o89F2vl2xPvREJIQiK/tSOoKO5zh9OAcikOsBHtWwbDXM
 SQR7FyuypeWCkMiBu/gSboy3cUi7xAPPHqBf9F2l4XxBzi0Er0kZBcSlL2Fkkb59mq8=
X-Gm-Gg: AYBFou0yUptrMswn3FRunX+FDbXQVMKAS+GVWLliNpUHNZvheMckr8YWTqm34EWqwop
 gGY1hGklIC7JYA3YNdS18aSDviDIQsTnkzY91TgsX0WKfgGxGFXDVmB95d/E8/xlWqJXIjHCxon
 uP0wdmpwlB1z+22P4xchv879HwVrthfVIL2WVXygHcc3F274pv8pL1EWWYm+EvWRpWxHg5NV+m0
 BgR+cp6Wz68ldqpsH7wxBe3bH4VihPL9TvN4G2fKLLrcPf8D2hzBZ8R68aWE8WDPyOnWM8rjfa4
 mOOHWh3lYzElo7/bEiaVpPIGeAg04tIQrrvV5CXib5rs9GMuGLfGOMIkhAx37rkcnIQoyxBuaL7
 qp3+Nc7X0fcrc9kgqfAHq9K5a4d6DUKlTahoGjYx4zKK0n3UQa4DWmP07RBtp5I8l0hynVgXbB9
 r3VAJkY5zXXAYVMb2h0FTaf/HnTz6LGyzW2XKulWT3YiJtqr1V72KFxYvrrxItvdCRjLSZto947
 pWvIbF0efGa3mt9MZmCFdgXBWfz4kMZKQSpQ9eT
X-Received: by 2002:a05:6a21:1398:b0:3dd:a196:9077 with SMTP id
 adf61e73a8af0-3de0e954e46mr2845667637.65.1790263491976; 
 Thu, 24 Sep 2026 08:24:51 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc75f40839csm2910722a12.30.2026.09.24.08.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 08:24:51 -0700 (PDT)
Message-ID: <6072eeb3-42cf-409c-bf9c-50fe21c51021@linaro.org>
Date: Thu, 24 Sep 2026 08:24:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] XHCI fixes and drop Haiku VM
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20260924090558.801845-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260924090558.801845-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/24/26 02:05, Thomas Huth wrote:
>   Hi Richard!
> 
> The following changes since commit 7074591d7954876951f84c15b994a43251d5a3c1:
> 
>    Merge tag 'qom-qdev-20260922' ofhttps://gitlab.com/mcayland-ntx/qemu into staging (2026-09-22 07:56:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2026-09-24
> 
> for you to fetch changes up to 1288b0869c082690c04c81ac940c126fb399592b:
> 
>    tests/qtest/usb-hcd-xhci: test isoch endpoint type mismatch (2026-09-23 15:49:32 +0200)
> 
> ----------------------------------------------------------------
> * Some fixes for the USB XHCI controller emulation
> * Drop the broken Haiku VM image

Applied, thanks.

r~

