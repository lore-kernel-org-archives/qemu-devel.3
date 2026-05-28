Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DB2CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 16:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSdmW-0006g4-QB; Thu, 28 May 2026 12:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSdmV-0006fr-GW
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:40:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSdmU-0004rk-3R
 for qemu-devel@nongnu.org; Thu, 28 May 2026 12:40:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49041e84237so55815605e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779986424; x=1780591224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TJKHFtKMeinB52gHheXhJUVYoO9sjFC5TjnUHTgVnv0=;
 b=yhj5URCBclkKe1Zuh3RbO/1jdWzlnYeRNHU6ByoJ2ZuzjnQi73DdRf28Btzr56Ub50
 rTqJg2t1P0kyFg4Gm1YgcYarysU3O9ZjkCldJRTHJAmv3ugl9cyGzRkfpllL6O/8VFwM
 qvjYS3k04PPnyqVAJVLrJqUcOjgYQKt3eF//rRDmx2GHFsBJLoQoDYMxgTS+XZv1foAK
 fh+TGk39PV1syaFyP2/4MzsA8ClxtCMwzI9P2zjJXAinu/MCOS3igoyPUiyNQnHzVC0a
 5+CcJmQnEWytTWAqIB0MxTGfd2Haozjb3nzQYJs4BOU0m3zgWHQTYYuFAnuv1MQcJrpI
 ZqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779986424; x=1780591224;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TJKHFtKMeinB52gHheXhJUVYoO9sjFC5TjnUHTgVnv0=;
 b=atc5/44OgEqfx4nJrKfKsazKUXpch5zncc7zql9khLubz9Ra6v88zAF1ZyNDR7sHwL
 mTP1sG8Rgqc5jt35X54pysT6UlqZ+0RfM6mPzZ8I0116Qb95EO0xijYqJ6607pYS7lpT
 KPtcbINyEVhmwRIfXZMFZJBrx4BKwSOyOS6HV3uoaH14aNKb/uoR3faLIsuzAIDPaj04
 FKwG3Lb0lSiU++JtrGq9+VlM7xsaeuynrPRAjX81jzddegHOqGzaFXKGb4wBmDYap250
 /Gcy7Ql+gUYLf+I3CIYAD8oY3zEkx4EBwl5MupXC2X6CwqeBIKxOiuoC4YUQMwOfm1Gs
 Jq1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+nraiGhtNYvSkSheqro8FxOljF6595Z+Tgc7mQG3A6MEorVFiJs5UhpJLoQYRpHmuM/49BS+o45Ub@nongnu.org
X-Gm-Message-State: AOJu0Ywbgw8bn6+NNTaYFPhLikxdNFH+epBtfvCANe1c0yblX8a+I4Ta
 7Vu9+tUoMeAcqVSGm0wueWv0zY2k2ZQspz1zYCy9ElkSboopL+WBlyWQI2QGhZbkDB8=
X-Gm-Gg: Acq92OGBVULNeYD8WnN6bXuERpx7HGmdSdymki0OdpYRRrk20vHIpFReq0C+r23tXad
 CYOGEBHTZZoWlfkl+teX4AyQ9gLaJI3X/SedIMjwSotVzhYSo0+hwmJEibu/I9Bxc14s2cKIzYJ
 MKOa0c21NvzVoOp2qnOXKkCgyCoLBJY4iPWmWqfqvqtyJIB2n4dbgJMmpv9W7L1WahkeNcnA7Up
 M0+AunJf1PJtQfjd73skeR/VlfhQfr+KXGyv7P4rOsGcyQPvpQ3cSTZSSb5LiwUXnlEUG+iqUoR
 W0y8Iha0SdhWrcsPaFhA+XUgeYHIEda1WAtFtN6WmT05zr88NBVPlJ2nXkdseH0B5b9uZ7+7EJw
 i8EWqra6K9/Xbj4v20ZUFaB0qx0vCLs2TvicFrgJVJq76rsT+OnMFGA6hDrY92C4fp7+v9kypJj
 h8dD0ocTw0VrYEAS8c2LJGJSt6eIfDbzja9BV+nw1LkgVg/4gPOaWc85diubJl7x8DjlRscF/gd
 8yU
X-Received: by 2002:a05:600c:6099:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-4909477683amr44950055e9.1.1779986424229; 
 Thu, 28 May 2026 09:40:24 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eed496112sm2708919f8f.15.2026.05.28.09.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 09:40:23 -0700 (PDT)
Message-ID: <91ad32de-50e0-46a3-969a-3bb63ee9dabf@linaro.org>
Date: Thu, 28 May 2026 18:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/microblaze: Convert to translate_for_debug
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260528161450.3564396-1-peter.maydell@linaro.org>
 <20260528161450.3564396-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528161450.3564396-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 28/5/26 18:14, Peter Maydell wrote:
> The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
> x86 and microblaze.  Convert microblaze to the newer
> translate_for_debug method, as a step towards being able to remove
> get_phys_addr_attrs_debug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c    |  2 +-
>   target/microblaze/cpu.h    |  4 ++--
>   target/microblaze/helper.c | 16 +++++++++-------
>   3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

