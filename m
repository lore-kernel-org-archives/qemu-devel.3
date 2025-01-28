Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926DAC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqn6-0008Pa-Up; Tue, 28 Jan 2025 13:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqn4-0008PQ-W8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:58:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqn3-0000nt-I6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:58:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163b0c09afso110302865ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738090704; x=1738695504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VWkdfHACvdl+KbSNIE6ymng3iIndWpluAohbgoCgy3w=;
 b=WLJlLCr/Vi5z3q3tM0GGv/q90O5lgDGuTsF3/yzliMbSZivmvIAq8Z+Wjo6S/3mAhp
 fPAvVtz6+NnM68te1qMSGhxOSvWTe3ySpzPTNhBGzPih9GOBvnLlWX/f2258Xf97450w
 Pp5zKLWqohh+25K3JuSDMFOLWae0pXR8agvrtyFZphMI1+ll+8MwiUd6Zk5GyWWjIpik
 pZhLB2ltKFhrRianOjK5Ku0+E9dI/gGmtUh75Z62o7RjembAWV02XmB4Vb4EYhuwSLG/
 HA6uUVPF4V95VQQUPhO7zpWJZcbc9RbuhhWH9Sd1zVnw++LOQiQcsfGH1+FuoCYp7BeY
 Ep+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738090704; x=1738695504;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VWkdfHACvdl+KbSNIE6ymng3iIndWpluAohbgoCgy3w=;
 b=kJTgIW1XLgQfpMVl/uiM2x+2b1jQFDCjnbUyRmV+R6mL3XfXgn6U/zffSlCkDkM5EY
 WwqfvqTbaGcx7ctglcwK+2pOwaNpNR9UycWmpKe9cCAfPGww8Q6GxEN6sdlspIPnKXX4
 qVgXxjfmZEgGLLXd8/Ux8RaWQT8VpZ/6PdBI14wPsOulaQouPJTpPcsk8Nz9Zv6ND66f
 cP5xXGercM+bX79pnFxS/KBpV/giEQqdStYCpVIatdsxFuxCeQX7apr/v5bzCeZkP6sC
 wKMWJjcDjn1lz4L1hv2NbB9h1wKOevwyBy790AL8WHs581svrE6gr/ScegMdCCYlAtPi
 8xbQ==
X-Gm-Message-State: AOJu0YyYcaHy4Se/QJY/Gep1MFlnfZxlMGhFr0YtMBCc9rCSRV+feOha
 VdpFgzojmBJkRtDwqqK+fQykjrPTPIZM6ERUhyQiMNwwo4y+Leggh3grJj8Serbh0vrFsl/1Ezc
 L
X-Gm-Gg: ASbGncui8dX1fONgfTPDyPFoibmVkMNJBckJcrpBNVl2jX4jlBMAf3FgvyCUOVLUPiQ
 O012t2HeN9D8X1br4rOuSdUtAeSFe2oEfml1NfnBliMFjChmTlD7/hnRKzdXIXfzpUrwGlOutKX
 KHvM8HQU8mo+F2UDlTBv+5DELR8DU8xE74qxWVynUtXHkNSt983lLIxnDcJQb4SBWwhYAuQ8IQx
 F7FsBWNpphSSZ3dtkSt0ccqgfqXWWs+oh/2lK5ruU+e9LBWVbP0op0H9AvHNVY1tBEfXxJEycP2
 3UGALW/RlpgW7SS3/ESAillICb2o6t6ee9Q4RolBI8YL1TPOYKzJfUmpmg==
X-Google-Smtp-Source: AGHT+IG+WmfNazD/ph4kVdAPU/WmBsNosAhV4jmpa0H3FFQNt/R68t6yPjew9bVtT87T0InLjYFR1w==
X-Received: by 2002:a05:6a00:2184:b0:728:b601:86df with SMTP id
 d2e1a72fcca58-72fd0bf480bmr327614b3a.10.1738090703890; 
 Tue, 28 Jan 2025 10:58:23 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b2ed8sm9529681b3a.41.2025.01.28.10.58.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:58:23 -0800 (PST)
Message-ID: <429db883-84b4-4486-9789-132d13e4d4dc@linaro.org>
Date: Tue, 28 Jan 2025 10:58:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/sd/omap_mmc: Convert output qemu_irqs to gpio
 and sysbus IRQ APIs
To: qemu-devel@nongnu.org
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128104519.3981448-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 02:45, Peter Maydell wrote:
> The omap_mmc device has three outbound qemu_irq lines:
>   * one actual interrupt line
>   * two which connect to the DMA controller and are signalled for
>     TX and RX DMA
> 
> Convert these to a sysbus IRQ and two named GPIO outputs.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/sd/omap_mmc.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

