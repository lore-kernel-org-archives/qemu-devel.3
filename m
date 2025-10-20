Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F9CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 20:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAwHS-0001vd-3p; Mon, 20 Oct 2025 16:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwHQ-0001vL-KF
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:14:56 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAwHK-0002la-GU
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 16:14:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so3110968f8f.0
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 13:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760991289; x=1761596089; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bF3n/GZ4HV9xqrnxBf8IW6Ugl3uxF1S2doAuPBRXPPE=;
 b=oukqtXST3bqfk25ZWwSZrvqdxG+FaPu05uqW4m7qJZmr24fPUATe3xuMzn0KAlm1iv
 +79ACcXZwc8XM/joohQ2hwDhIiJ5dCVIJ2XCLjoRl/4bWB+oruYrvtwn+Mes4PUnMUMD
 x4AqL8/ogMAtTCflwpoRHL2g353OShSyloF0++e1sRw39zGqozlMIL7SiZ+V0w6w1beW
 JLTcwUQN6FcAD+3jd1JBfFn+6uMdYXCrZj/slXe3PU4Clk3wrcFmqn7U37krGAciRxqL
 pqAA4cv6mDGr92KhgIWOobeZqI3FZJRUWNhSLa8llPgts54JyKl7hXfMdEJJHGCPhEY1
 hu/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760991289; x=1761596089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bF3n/GZ4HV9xqrnxBf8IW6Ugl3uxF1S2doAuPBRXPPE=;
 b=lnfEJGl/kyBnxzgHrsvcjI8/tj8hW1MYorWFc8XhcXWyGM5OKdMjTlOK1V7baf1jGc
 Kip0dqnw3AsQ8xPUSkyN9dFirMiaQfpp0rwaMNK2iK9lCFrDLFpZ2uZ7TviHwRxTlPlZ
 BSlS0Mg5zUdgtC/FMHNriuVsAusFpLNMolJN/mLFui+x+jwZF5vfklHorzPP/XZ5jygx
 DdnllHtyrojo4O+13WVMotbuPoXc9ofd1fdh+wlwSfEWO4cxDA8+iSfNAwZjzHSd/OVM
 SOoRK1Ksjf2mDgcNmXiDWb6vQob2lqFPYPL12zh2logOwtTiVx1NKFCxHJKrNjqETY0/
 bJyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebRwutIJ8YwjM22P9JhK2tce+unBhIIoBnW+lJwzbs/zjptYWJTUPcrfuf3WQj+7660tMkL6TbU4/@nongnu.org
X-Gm-Message-State: AOJu0Yxj1iyL3Vs9AthvyUkVb9s0cS1+pRWPslfz5Q4HaYrL9wBWoQfK
 SUlH+5VsjXuv+7l8RI8SoKmYV/hCnZKm/hpOS498z9xRKhnKjSZwUCWHgYMYsd4q/7vPaC8xsRA
 qa8vLI3Y=
X-Gm-Gg: ASbGncuHpcpt/o0QM3zG4R/JokNBSogWKtVcsdF790W6s+RLyEJLbE8WmJEd4pmi2sW
 TLyB2yS7u0WeEH5ZcPmmSnXfg84IK25HgGpTqAm8I8OuqmC573r2woRR7PE6/1uSyyvr3KOT6Er
 OgILiF6cmNzS9IlZab7G+Tc8+lmVbkQ+z/yM+oKglzPIRmFPHcYWB86yBp6nBsGap2htEaNclEA
 OII15lfGyXIPstmfYydhZkb43NJjrmI4KwVAbpiIwRT+tPvM1OjppWa828vq5HO5jLb8xOyf2TF
 nhxA1ZpZGlNPfnFT3VapUK95as+BdMYqIGp2JLSQJlr0pQX5Llt9ARe054Sg9P7n1cKKSrCeoXl
 Xc95Q5l0ep7F4fOzBFr8EIenvuR0nG+lf8Q7AP01mqBeI6QwZhmT1uQNLWC7sbGLOIQIJtqyh1w
 xrGMSGyUMxIkf8DWl4GXHWMs8Cl/cVl/vqiaSfiGGNbNpdUSYfS0JF1b6/bwQ8IpwZ
X-Google-Smtp-Source: AGHT+IGhjYYxSblqi6QSILtnVmOSZzu/yahZA/85t7fpFukQmHr4Jg29HFF6LmUJ1lHI+QZ/0FDiXA==
X-Received: by 2002:a5d:5f93:0:b0:427:7b7:a86d with SMTP id
 ffacd0b85a97d-42707b7aa0bmr9328269f8f.36.1760991288717; 
 Mon, 20 Oct 2025 13:14:48 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce3e2sm16893628f8f.47.2025.10.20.13.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 13:14:48 -0700 (PDT)
Message-ID: <08aa2ac1-5ed2-4886-968a-8e9a082e1d6f@linaro.org>
Date: Mon, 20 Oct 2025 22:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] crypto: validate an error is reported in test
 expected fails
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
References: <20251020141237.2621796-1-berrange@redhat.com>
 <20251020141237.2621796-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251020141237.2621796-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 20/10/25 16:12, Daniel P. Berrangé wrote:
> There was a bug where TLS x509 credentials validation failed
> to fill out the Error object. Validate this in the failure
> scenarios.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/unit/test-crypto-tlscredsx509.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


