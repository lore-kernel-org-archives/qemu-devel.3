Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D30BCC6B24
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGsMq-0005wV-Om; Wed, 14 Oct 2026 02:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsMp-0005wB-Vv
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:21:36 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsMo-0006y0-B7
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:21:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so2375374f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791958893; x=1792563693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=28lfvFBPfsWPL2u/keKxvsqU2LOJMsUMJ/4qE40SHkI=;
 b=V1g8s2Cr8C6lqqBtCDOZb1Q4viXCESI03re0hK63Njpp2UzJ6Wd16Iccs8WUaHRVFJ
 3TM0bdGa9ub33suzKX1gV6rM6fYJrRDuUnZuFuCuN0ixfHL2W0LwTJ/5983/QbLKaSfU
 HG1X6WaQ90vrLqiTw2MdeTyMtkzEo2xx4/g4SyJWdAXcXxaPtIN8CGDkzRN0DNmu4e82
 XGWLnm0dDoBNriCPfd0bRCTeZCgDzgeENpYCt9t7Hp/WemNnUs9LeNhwQrTIl/Q3wsok
 QeXiRgDGJauFaXtHrMlFgt+lwDuXp4EPRtUtvo+y7tjXEBJVPAuIHq8ssEWIqJlDG/3/
 Xxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791958893; x=1792563693;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=28lfvFBPfsWPL2u/keKxvsqU2LOJMsUMJ/4qE40SHkI=;
 b=REjl/v5JU9jwn7LcLUb+M1IljNZW7KfjCekquoyNub4LsiOvDig/wyGHp6AOU6wDXC
 IwKNlZVseIsN1ovsEloVCietAn3L0HYM6D0WMz7WvXuTK+Xrmhei7fYG4iYPPJMOGW5p
 F0unlbERKULTHXmbINThiIvCo8H8QZW0qYHeHk2k4R02HmdKacRib7Ti58r+X2ZQthcx
 Nc4XtkQR8X7Eaaz9wGEgYaOJNEoxgVK++eT05PM9e+UUskjOFKFVhiH2oGz25MBU7df1
 TWWuzklhX6DajeQunhCUx20vy/BvNq4u3dkxYvCGhgd1qPKRYhw42xKEhbKZq8RHSdGJ
 IN9g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYAWjz6JDQiyXPnqf2HrRb1CLIDrkp/ntb97FkszbOOdp8OwrFfPAWgzqpg2FhL3+oT0XhQfIttJH3@nongnu.org
X-Gm-Message-State: AFq9FYI55VULhbohE607V1j3Q12EE8kVu4ATehVtW27XOavapG6kpgYV
 wyPuxqO2oBgBgfrWLrtfJQHD+CCjB+J+QNLnwv5Dn5eJBNvNSQlmRb54SZGxIj/ceaA=
X-Gm-Gg: AYBFou00N9beb35Uss8RwJzDg9j/l61Iw2+doOXhU3uKsQfx6V1BI7aF0l8cNAGbaqL
 s63WSNzvZoh/2Ekr+Q4HE8iW1NHPDOMELQhgRgko+UI/dD8Wsvb+NfC5C6eFmYU3kZqSFxyfOzp
 aDaNNbx04fvsb8IBk3Z/abdstaqq4UzgLO1/CFIAMUTbjTS6AmD60ZvFgykYFc5QbA0B5/3LcMq
 BSHK5s5dR4Cn5MEU/lNzuj2EWSTx4VG5mg/IZ3qgHm6AhZydsH4acgUaHomMRp/4g0IvPrRM/R9
 L7Ya5/av5bjvGtUNOSDEiNE3NF6jhG0OmxJnlp49h5PYXr9UOEv8V7CHuiq/ISmnwrJa5Iso+68
 /hwHDvOaeOr2AOFF8hfBC479Bxw3W4BvhUy+jnFFCzpWcKqrUsefB0MHpluzNs/+LZhTBHI5Nuz
 hLnq63/rt6VK8T91+n/NWw02PEY3rc/UknYhzej9OJ3k13M7A0qqMeceRnvpV7MFPcRk26YyWZI
 xVq34PLz8VMlJa112fQYCCJPlZYLy/wrmOy8Dj4srvByp946JYvyzY3OzqKBFOQ+5M=
X-Received: by 2002:a05:6000:29d3:b0:48c:6616:8f32 with SMTP id
 ffacd0b85a97d-48dbacfa174mr18660165f8f.53.1791958892856; 
 Tue, 13 Oct 2026 23:21:32 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967affsm8646212f8f.1.2026.10.13.23.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:21:32 -0700 (PDT)
Message-ID: <39a2941f-1106-464c-8041-147c91dc037a@linaro.org>
Date: Wed, 14 Oct 2026 08:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm/tcg/gicv5-cpuif: Fix typo in
 ICC_PPI_SPENDR1_EL1 name
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261013105704.1071427-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013105704.1071427-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 10/13/26 12:57, Peter Maydell wrote:
> A cut-and-paste error meant that the cpreg for ICC_PPI_SPENDR1_EL1
> incorrectly named it SPENDR0; as these regs aren't exposed to gdb the
> string here is for debug only, so this has no visible consquences,
> but it's confusing.  Fix the error.
> 
> Fixes: 585dad9e79e1 ("target/arm: GICv5 cpuif: Implement PPI pending status registers")
> Reported-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/gicv5-cpuif.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

