Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D40DC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvTA-0004yx-5k; Thu, 08 May 2025 03:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvT8-0004yZ-Kj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:14:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvT6-000775-Tj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:14:58 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso615091a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746688495; x=1747293295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DY2BsFM/3DBKgU4gKEpYF7v/eZG1r/5Fy8FJcoo0eTI=;
 b=QAAWj+cRbSP5NPDyEjYqyJM4TVkVTH30lTuhVPVsNaIYFhIFK/IKP8LlhlbZsAzZcn
 BNrzYdFwJ6NhK4SeQkwpXsOv9U806EHLviG3guVISpTkojoeSu+NAwlAdJEn4oUxrzfq
 3G5T2uZZypVj7wK5+WVU4f6c/G0yfkTGYCUWezIeaYGHxb207xuF9FJjSAEOPbTjuYCT
 ATgVsswrKrqC4XW0WHjI5RkCl+TY2uqjVPusEJO4h44ZcumI8K2oFXkgcnPcn4b3l7fs
 Ao+eebpllIzs/aAW+g5ZO4uB/kbOlEe/Zxq+12LPYBlDHSen8DD6zj1MWrBtcARBjRin
 b4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746688495; x=1747293295;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DY2BsFM/3DBKgU4gKEpYF7v/eZG1r/5Fy8FJcoo0eTI=;
 b=L1rqE9iU/MwqdQL7XnLv2hmC0eWARKu/nRnjS5x66Gn8IUprDmmoGB/Oz93SDzl8BT
 ZPeG4b2HdxIzKlkvW7PaLHnaX7PcLzBOAoRn4VO1KWzl4yXSWBcOpSHRE3NqMMoACVjU
 VmxlPs2mbpY6DKHedM2v7tn2IuJhmdrx8L1PMw4AUgGhBX2UF8pTRlJk2KkfwN8B03DW
 KJW4kEEzyxxqGExVIvBY7zxiHawAB9evW+mfSmqo1dAgndExi+/83u2PBfr08hrZd31m
 YYy/b+yQm3Q73tUQ97bPPt3TfWZTq2QjR4W/D85z4bBXkDbtLmg4YTsFuJj1Nwi9lIR+
 87JQ==
X-Gm-Message-State: AOJu0Yz4Tyw1OlVMLmMKs8vNGelJswFSMobVo/Y9dSB5EBmo+cSEF+04
 BipBDkN3iDGCRt4XBzI+YVm5UUVlN7GVVElxMJQ08hu+di/mZRcyi3y5CfhcBO8=
X-Gm-Gg: ASbGnct4vRa0p97F4HJOaIhyQ/g9CG4EqBlAfZ8yRqfOEtx0fxTqFxSyh1qKqSXUSmH
 ly8+f4mEgQlWq+3vgHQUWc0nf09DnExg7NBB8kCvalNnnh6Y2sKIkgJ6NcfxfUtWrZZ8hbPAQuC
 oyUZkMXr069sSWZtvRGDdd543MM47E04GgqsW9seTxRWCafSlOYM03k1fIhKkLz+20l0FTWKcpf
 cbgedK4UB7T+QfrviUPWnxhCViCbzmwlj3TqbdfPC7LCXd/235s6l6ezXsGXCtGMabGy7RYXG6H
 kB+Mh9mK4wLTaJIN10BRehFwRAqKo0LAQHxP2cxZvqJM5bFDgQrH8IX6YlsSmMuvtoewpiZ4WIX
 ez9oF1vQZ
X-Google-Smtp-Source: AGHT+IGahL3bm8njn4Lt4XjFAW6J/avn+OmOD3+emwdkL6OOJc+gdeC824Nq0dcYKQV+qXb30IexXw==
X-Received: by 2002:a17:90b:2b4d:b0:2fa:2268:1af4 with SMTP id
 98e67ed59e1d1-30adbf1163emr3634786a91.7.1746688494934; 
 Thu, 08 May 2025 00:14:54 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad39d66b8sm1487673a91.0.2025.05.08.00.14.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:14:54 -0700 (PDT)
Message-ID: <8a5893be-7217-4c58-838c-01370db5d6bf@linaro.org>
Date: Thu, 8 May 2025 09:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/imx_i2c: Always set interrupt status bit if
 interrupt condition occurs
To: corey@minyard.net, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250507124040.425773-1-shentey@gmail.com>
 <aBtavpDt1yfoavj7@mail.minyard.net>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aBtavpDt1yfoavj7@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x531.google.com
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

On 7/5/25 15:06, Corey Minyard wrote:
> On Wed, May 07, 2025 at 02:40:40PM +0200, Bernhard Beschow wrote:
>> According to the i.MX 8M Plus reference manual, the status flag I2C_I2SR[IIF]
>> continues to be set when an interrupt condition occurs even when I2C interrupts
>> are disabled (I2C_I2CR[IIEN] is clear). However, the device model only sets the
>> flag when I2C interrupts are enabled which causes U-Boot to loop forever. Fix
>> the device model by always setting the flag and let I2C_I2CR[IIEN] guard I2C
>> interrupts only.
>>
>> Also remove the comment in the code since it merely stated the obvious and would
>> be outdated now.
> 
> This looks good to me.  I can give you an:
> 
> Acked-by: Corey Minyard <cminyard@mvista.com>
> 
> or I can take it into my tree.

I have to respin my hw-misc PR so I'll squeeze this.

Thanks!

Phil.

