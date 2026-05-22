Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYXw-0002yS-KO; Fri, 22 May 2026 18:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYXu-0002q7-QP
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:46 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQYXt-0003la-BJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:46 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c802803ac17so3420303a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779489644; x=1780094444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kYpd/LWiIrI+H+PVI/rDALSVpo+bcl6LfFkxhaTeeNE=;
 b=AsLtfRvuUzoyJLjbKsY+8yT67cR1KZE3bi6ZVes8diiih/q6LfCntT6yScNvIinnh6
 hERau2XuPvPOHgW+LiR2za60KpyXnNXss5yjKn2+mr85odhJs6ji0r6PGAFfhsZcqCcn
 FtoCXf0TtAdqn9feDGwgRv477zy0suL/SKwt1BaECYur8ZBjW+3957GsYI8oRK2OiPkQ
 Hjn3oV/s6EK0kfqDXsKZOaULHX2O0V8e36MPPt+tLoLPBKGOB4qrMiNjyvLoIPcqD6oo
 83amP5Fvq4QyP0gJupSfu6oNfDTJYFH+bN5wwwdZ3Lr9zlKW1Q9oG6QrVAU8hH9i2LSw
 nRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489644; x=1780094444;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kYpd/LWiIrI+H+PVI/rDALSVpo+bcl6LfFkxhaTeeNE=;
 b=hm7CFgh0HcHSkqwrt04wULZe3czTIBgWCfTI9Wl55Mybfda1+pmpNv5nlyyCKSVey8
 Q+jH8uuy1ZCffZW5hg2XM6WZiz8iacuqcPbMrfNu/7B+hU4MYsCO02jt29IXj1fZt/Nb
 nsSbYn2qkZbQP6CbU1R4cy7IpwYP0Mly3QGtuIHW8OffOZCVGD64chrcdXQwARvBcRvS
 lsKF4nQrI2HDmE56G+uQuDv7WgztriCmUN3SY5/VQygAImApQYEm6gkDsA6QvyEeOwbA
 52E/F0NeVJI6HowxeXIxqxW6dksJpaVt9w3FXXuaPWj3LzjmwXDj4p/hQIrJRQP6G35e
 AEDw==
X-Gm-Message-State: AOJu0YyNRAzwK1arbFu4Sq0yzLrt2+6BfdJJHiMArYOxoy5telS/1d8t
 yFEs4f4F8hho27kUKO70vv1llgxA2Av9J0ABI/Z1pdJTv7STz2vKKQ1SZfNrGX7en+7W2wxseHl
 JwDYj
X-Gm-Gg: Acq92OE4urQgMsu9kgYAYfiPllCG9UU5E2173RDEB8vGCwzRkDNxnPAXQR0cbYfSBht
 9nVijxpHwqj90/X4OLbG3NwstvZz7pwgGc9KFmU/0Y9rr0k6VKPbHxfAEW2xzvQcEanE0yEf8k7
 367H44bN0W+ZIEqoO+z8ulD796vHOBplCTBTdsJElvWQtO3Ihc3GjaL3zO3OyF0DXojKTauO1w1
 wUPJ6oFlQkgsCqajr///H5oiJTJXfVNtZ5LyGE7tP0Gqq8TGkSfmCfyZT1t+AvT36fCDrIijDYS
 h10NbdgUW5omiqqkhE1wqFAaMBoxB81Lya+m/xU6wy0rmicgAJx25USWJuuW84OujyLTx+neK2e
 w+MMmufQDPcUXKOkoAHx6k8hQNn6GPmMkKcf38v4FTlareNq5RYTPwREcYoQN1Kz+I5NHuF67Ek
 6mdAS4lZMMFCSzNRdJjn7htvCY3D+JqZdxXF37qrNVP0pKnoZY2Rc=
X-Received: by 2002:a05:6300:2109:b0:39b:81bf:15ed with SMTP id
 adf61e73a8af0-3b328fb1b64mr5843996637.52.1779489643706; 
 Fri, 22 May 2026 15:40:43 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852058557bsm2417886a12.30.2026.05.22.15.40.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:40:43 -0700 (PDT)
Message-ID: <00b09bfc-7cd9-411a-8732-4a36ae3b0230@linaro.org>
Date: Fri, 22 May 2026 15:40:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] hw/core: Add riscv[32|64] to "none" machine
To: qemu-devel@nongnu.org
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-4-d1123ea63d9c@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-4-d1123ea63d9c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 5/20/26 06:12, Anton Johansson via qemu development wrote:
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   hw/core/null-machine.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

