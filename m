Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC359C369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E8E-0007d8-QE; Tue, 08 Apr 2025 14:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E8A-0007MW-Vm
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:57:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E88-0004Kt-70
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:57:06 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso20965e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138619; x=1744743419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wv16gETVFYlygxg6+XjhV5in2COR30c5TE+9f9cYrcc=;
 b=T9lxN12dMTaVA17bmtAGY/FB36v7eGBxaZxlSKgIgtEe1AMuVQWE6ch6jxux6GC5Wd
 rd5yHqkAsHtACq0DCcBd+4pWtV+Tr2g6NgJp7kE0wOL3Cv7OEm2n3eNyNhq3ELgHmu9x
 Fux5KupkcNqzhcRf3Jo47VJvsmxOifSfdkG8VjFgJ0K7wR5bSc13ee16qjm38l0VtjnW
 7U8jci65G97tBtmfL3C7KGU+euQfpAd/S0v92Bssq7CRKA9PXGWD53SOl3gURDJV37xU
 fEun0fzkajv8Tz8qjGc9F2PpRXe98FF3dmIG0dRMsNb0aGcmPEbqFjrTJiBP832ciIW4
 7SgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138619; x=1744743419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv16gETVFYlygxg6+XjhV5in2COR30c5TE+9f9cYrcc=;
 b=JGySWdfewvFWQ9b30F4T+HJNiqfL273rFylyQ9i451258Ntn6/TgGC5PpMbf3CUC1/
 KsjKdREOQtGlZuUxe95jNjCyFFClEn6n1HQSK7nDSnGvXashB5/xk7aztrT0SK2Y1QTE
 YlkVn3yn30cTARguSE2iD+jP1OspLUvuCIXZxFhAmVwnI2QXpxFeKQ9lNZ5guOi2TfU4
 jNQamzpgAyv0B9mmJM3tcP0BrGhy980zqbk7T1yxu94DFpFs8RO0iismo/9hZbm2tFs1
 cTjq06Q3ApDKS8eLvMrYveZmFLezhixZEGJprgeUH7oyYuCHB5cUpUM82S1hCJJiPbEa
 oE2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhq15VX7GSLa5ZuenNT8XGTBpwhRWzTWv46APHcuIiEVZY9vxLnUUT0wcgmGRUIdUq/pCdYKlTr+4H@nongnu.org
X-Gm-Message-State: AOJu0Yzg1T7ypSrTAeS5M02eqFQDUruGPbBiY9meUXFb+YX01YyEhUT6
 ELeqt1uHnl30qb3+pVwiRSxrZGu9YWEEGarqfBpZP6MNV+3gs3NyYh1H5GNG+VrZEPUKOfOXo7g
 n0xk=
X-Gm-Gg: ASbGncvy1aIEjLIMF+fbbQndMh2Uq9/N2CAhBAjPtoF1t7fb0EzLuxesCGSQdblj2Ia
 wVJGoj9LT8a92/ifYP71izeWxonB4uDEtgt7q7Z+0Lx900PoU9BcBZBEErPrqCy4p0tBPebTcYR
 +c5/F7IU7I/1XGKz6esriWuwSXLi/CUbwVJtmj8HiGKvTx0K1yv0Jn4TFeeaTS1cvOPElbzx/5U
 tsHxnlEgDQVA57Awsc1yVvdS8IEUBIgnT3hQac1fG9EenaRM1/+uCcYsZTWhF9s6F/as1/MtTc4
 XrHJx1sFXikaoSEXbsHVimGgn38yqzHVNx1TjdZfA/Mpg1tIweKCuxizeDJc83L0R8ouo+Y8TAA
 79oFXtGseugHj
X-Google-Smtp-Source: AGHT+IFMjQYWczkWNk5M5530/DL93Bkbd4KyDU9MZM+C6UPu6ps8U2eSYID/hehN8xwvf4nNV7On8Q==
X-Received: by 2002:a05:600c:3d8e:b0:43d:fa5f:7d30 with SMTP id
 5b1f17b1804b1-43f1f086ba3mr1207935e9.16.1744138618820; 
 Tue, 08 Apr 2025 11:56:58 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm169482035e9.27.2025.04.08.11.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 11:56:58 -0700 (PDT)
Message-ID: <f9c9c189-bbca-4cea-8aba-29410b85d0e5@linaro.org>
Date: Tue, 8 Apr 2025 20:56:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/nvme: fix attachment of private namespaces
To: Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, Alan Adamson <alan.adamson@oracle.com>
References: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/4/25 12:20, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Fix regression when attaching private namespaces that gets attached to
> the wrong controller.
> 
> Keep track of the original controller "owner" of private namespaces, and
> only attach if this matches on controller enablement.
> 
> Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
> Reported-by: Alan Adamson <alan.adamson@oracle.com>
> Suggested-by: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/nvme/ctrl.c   | 7 ++++++-
>   hw/nvme/ns.c     | 4 ++++
>   hw/nvme/nvme.h   | 3 +++
>   hw/nvme/subsys.c | 9 +--------
>   4 files changed, 14 insertions(+), 9 deletions(-)


Patch queued, thanks!

