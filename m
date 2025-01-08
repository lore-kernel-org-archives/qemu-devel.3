Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB37E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 22:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVeOK-0004ha-WC; Wed, 08 Jan 2025 17:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeOH-0004hG-AX
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:19:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVeOD-0002j1-L3
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 17:19:04 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385e3621518so151650f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736374738; x=1736979538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TEWnj6xmE/R3GsPrZkTji2fs5RspPBA4LfIooh405Zk=;
 b=GTpZjvzMPk15mxCP7A+wsuODaWdQeFQDvPD7BhThyJTN3E/eizyXOIKm+wNEy3cRuq
 4MwBKpc6oFa9EA+kUsHU6ECkXtufQLR+sLxmONwnWQyP/f/V2SULDZqcqR8RdxyMsi4r
 HOnn5/5NJWW/Eqm+2V3fps3aBFPCWyfEx09YFgi1qpUM7MLZfvgrRRyoVZYPL05g7C91
 CWHGD+pafxgUZmWKclO3seQ5ASkErzPXLCqpzzfP53buEQ187ogSW8E9abKaDsolQk/l
 6KPbGVseP3fgs4KyIr++AsZjAI78X74oRYXdKSyvtQIDJRolKfNKwhe0pKSrQcUWMuYy
 V+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736374738; x=1736979538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TEWnj6xmE/R3GsPrZkTji2fs5RspPBA4LfIooh405Zk=;
 b=FKm2smCTXP8eZHTas4e2zUmzbVssg4OOmX2L45GXuFCTJGN02Y89gjNFDt0vTD4y/c
 ygONaiQkYhAAuW+/8sS/yJTXGDVAzO8Lme8qT+ga3CBLKzyKTtKeItcTU3fSwDl4ROX9
 qAxJ3jwOhOIFC0+l3RJ6wnkN7DV2/EUiP8eJIU3AM5gMhD34Esbb1YkDBV8P0c793cf4
 4Fx+F41kvgEahCLWqgs1MGFr7O7SL2DXPxHMg0FUN1jiWiUwq+k9fv5zLpYsazkWNP0b
 p4PGQFr5UrZdvmBZwGDbF0elEuaBgettzcSfQQbgNJpoZxFrMh9vOCR0L3DHJRCylBsH
 AZPQ==
X-Gm-Message-State: AOJu0YzUpUc41lEApht/iQBm/LVPp+jz3eEZe7RnG73aU64//4LA7yv+
 W+xuCSzedCoROyaJf7oTrmdzXC16RFlWcQ0tt1lguh7ohAmi1pa79GwOf2XV7MVwPiMpLCSgWHV
 ugmI=
X-Gm-Gg: ASbGncsyJrPoH5+FWYy0v4KV+t/V2njf4m1yvmha0u8L+wxjvIicb70+re2fmYWQvcu
 jPzDKuxX5ZNW39UtjQ7fpYRgMTEMRX/fZQT5YWwTx1LyyoVeOzJlC0KDH7qoR/yNs4uDKZvy7Rz
 qfSkE3zuVuxqQPSQPs6CVoM896FDnP3bzxkWWJM+pBbrapaL0PinrFCio652kVa9Cf9NXRNRJVF
 MT7rHbtdkuTv+0QVKUjI565kIfYmlHB+pSH2OXEdN3GlepGk+lIZuJ2r+3+1jBm3dHCk8SMY7cc
 v7d5X9tuFByJedMxT762tLur
X-Google-Smtp-Source: AGHT+IG8YCAu4w5/cdqQFKLzonc2Pxk29cYXBCntbwHwcaPsS0FLYLtNKgASyQXQFyyq2O5lKKbcsw==
X-Received: by 2002:adf:9787:0:b0:386:3e48:f732 with SMTP id
 ffacd0b85a97d-38a87303f5dmr2958553f8f.16.1736374738638; 
 Wed, 08 Jan 2025 14:18:58 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89de4sm34033455e9.34.2025.01.08.14.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 14:18:58 -0800 (PST)
Message-ID: <65f5024d-7c28-495c-8a0d-960d90130bbe@linaro.org>
Date: Wed, 8 Jan 2025 23:18:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] hppa CPU reset and speedup
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20241231190620.24442-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 31/12/24 20:06, Philippe Mathieu-Daudé wrote:
> Respin of:
> https://lore.kernel.org/qemu-devel/20241229234154.32250-1-deller@kernel.org/
> "Add CPU reset function and speed up runtime and translation."
> 
> Since v3:
> - Added tests, dropped R-b tags
> 
> Helge Deller (4):
>    target/hppa: Convert hppa_cpu_init() to ResetHold handler
>    hw/hppa: Reset vCPUs calling resettable_reset()
>    target/hppa: Set PC on vCPU reset
>    target/hppa: Speed up hppa_is_pa20()
> 
> Philippe Mathieu-Daudé (2):
>    tests: Add functional tests for HPPA machines
>    target/hppa: Only set PSW 'M' bit on reset

Helge, I'm queuing this series via my hw-misc tree, thanks!

