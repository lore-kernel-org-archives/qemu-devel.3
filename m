Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F5F10F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXqL-0003DL-90; Wed, 08 Apr 2026 14:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAXqG-0002gM-V9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:41:33 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOQz-0001sL-Ij
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:38:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so3556209f8f.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637528; x=1776242328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dq2G00SM6iGePfW9OD0aKM17LpzuxFktp+AXv2CFTWw=;
 b=jwj83cu4VQ8eVKrWunG+isCnL9NiIErsiMorns7ohEe81C7VwSl3Zb8f8WFjo/hIp0
 VDSR2T9qHEoMddyCUxdsNIk6EBdPNVcX7yobdWxyMzL+qnR8QbNpfQz9x8SlzmdvCUjg
 UpZW7RYQPT8lnmT52gtnG9YJ1M1Am8X1ckeU3BccFPeLNxuN36x4A+WCuNm480j+go6V
 4hQ/vl8pbHgEsqh/Vg7kxSAuIx+6cZF8rlu+prVa9nKuzIj95Gz5iGSMs3OFSuZOE228
 EHn93XyB442ZrUHLIDRalofPEY2TCsd2BFRfkkaKEcr/MGxazEb/HxVpSPVzGxc7el0b
 AGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637528; x=1776242328;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dq2G00SM6iGePfW9OD0aKM17LpzuxFktp+AXv2CFTWw=;
 b=D+8Voq2jvE9hetAXYVpnvPmCNYmr1giksoA0JDkmq21X92cAQRg1LQymbxb05KVEs6
 DbWUdjYbouilm1NJ3h9Ik8oOO2PjZJdcd6vKDVJGMViksgVPnokZch38ZdEKOnHiopt6
 IZ+7VCylnJCF6Lgisqlb6MciDsgpOPYQIU8P46nfgEbsHANl3VqQ1iJDfrYFmji+Pb+m
 NEEoXI1dvsigXOPUw6I3HA4oMCNdkeo5E6QQBNreQaAUjY9ph/kGKUT3fZYbQpmBgTC8
 x1chaiV5E3LpGKQFoaRewlZJmSJKFhNVIYQJq4jY6CuNAx078j0eV+TW7bJ2AdW95I5N
 iEvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgcER+SwXPFKzSfmG2IdUUmO0Zf0e6fXWPKuyWkM+aCbtn8fy4lcDP6JabK+GwrL/viYfk1Wdz+Nb9@nongnu.org
X-Gm-Message-State: AOJu0YyJVADUbXwfZbTXsmaGw4LP5T9Gq2PIIqufGiyYqBZELXSejTfo
 fLAIMhnvzm65oZVOmJHMrASEWxMHWy0xHk9k5DMzmlv4gMhBKFmFNcfzTlZTljEswtk=
X-Gm-Gg: AeBDieuXF2y/dlcQMqEIvwYv+SA++1AHpujJUmYggDHoq++Fc1WL0e6yrX4ybG1mj8Q
 o25ZA1PRhTwtdYCP6V10xnl6FyIZjCjAmB4RxB5pcHuXieZYWsTsjo/WZcbojsXLIOuc9N5FVrR
 P2W8CylPrDl+pUW8nLoyatialwjsCp/3cNimmGSOvtcbKD0xiFc5MDN2FT71MD8Xg/5y6HGNmea
 b3V1A8eNGyFl8j/i2kUF6PwzycUaq+K+YbZOc0/A4Ko8tnEa+NS1P5iJCSyP74uG70F71QNgrRr
 htTHnoatTHNdWMoLimudSsAj8sUUqj3kdzJLK7932RiVjRcL2xuOgYll352XeZqO9ZLbBK+IRGu
 41YNWKc8DJ6UHfKYCTAj/NdoJup75I6DVyu1z15bZAmXPeNCDhovqPpbLsIsHPmfkMBvXbEBP6E
 Uwf/He3a0/KG0zX9r5GaUH8jsMsGPuET/HXp2hyHchbodbHpncERTzTaukrEh/FkFYFw==
X-Received: by 2002:a05:6000:40ca:b0:43d:a58:b076 with SMTP id
 ffacd0b85a97d-43d292e89a7mr27472098f8f.44.1775637527770; 
 Wed, 08 Apr 2026 01:38:47 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm60101310f8f.32.2026.04.08.01.38.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:38:47 -0700 (PDT)
Message-ID: <6aeed0d1-4baf-4e7f-9521-dd5518ac9022@linaro.org>
Date: Wed, 8 Apr 2026 10:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/timer: ibex_timer: Update IRQs after writing CTRL
Content-Language: en-US
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-5-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407043614.372871-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 7/4/26 06:36, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> When writing to rv_timer.CTRL after setting the compare values the timer
> doesn't fire as we don't update the interrupts. Ensure we update the
> interrupts after a write to the rv_timer.CTRL register.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2796
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/timer/ibex_timer.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

