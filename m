Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A77EF06E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpId2-0000TC-VX; Sun, 08 Feb 2026 23:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpId0-0000R2-Mr
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:12:02 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpIcz-0002lD-4f
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:12:02 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a9042df9a2so13325785ad.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770610319; x=1771215119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KbymLaFaPB2bi5iTvNhrxZOu9ychrlsGOwuwQy/PPo4=;
 b=PS3OyvTYXdgaiv+lp6h5j6Q7Kzo2+IPSnHNAMtlwnXOf1uGcnkSXu+7rkrgyLA1Luu
 XCMblo45h715FGfU6DnGFQm9zdRbKKqVPEtPimaFJNmGd3qphdWHiABCuL1L/fmCRoa/
 NI3+0T++LAX8yIvuTgB3DLQ1WmPjfLAnmq8AJT9CIewBaRqmP5cpMbKMMVy3XYaxYE5X
 YBLV6wZFgcuarP9KaQVjXNNcsMI380yTE4EYEW57q9+/0QRXiP5iiM+47ujp5ZblGwbR
 sZ4Jra/NHpEDxZALF3SQkIiuyGgd6H1r1LBGwJmCpMME2sn2CPZU1GlpnCclSIgmwMEL
 5Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770610319; x=1771215119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KbymLaFaPB2bi5iTvNhrxZOu9ychrlsGOwuwQy/PPo4=;
 b=snVMYzGjs5zh1VPlJJ8/69vUUIQectfQZi1HlbHWVfWJb6G+OzEVXj+RzLmCvMnHRT
 ER/LapsRbxzQBjvbG/tKBVGZtKzfJqETHby6LCg+blc2DwWiDnDzuh7lrphVWcEiZzoV
 pyWMzW7n0uzCzGS7+VIgH0rr+Q1gh1T7D5651A5kzVKwzPVB2851XqId2PL96ieeYkiH
 +uXt2zknFOGaavyoF57GLyXSL64EkqyeLzmHoz7L/tGe+2mdt3y+2nILqIcM/r83g2lW
 CvYtsMpnGOo53AalrExHjZhAVujaqwQu8Z3wp3aT4Nv8h4HyWZdwBwU53kKftQz99EPX
 x+mA==
X-Gm-Message-State: AOJu0YyMKZcp/V7H0ERZwz4h3ScdXGn3rbGq91xqviT1yhr5Aoqfq4XO
 AZ8qgIZNt74oYJAz0Hek1Hf6uedmovtWniFrG30uhBwTQq1IOgxu9EFvmuQPdVjBWHE=
X-Gm-Gg: AZuq6aKg1Lf5oPcclLBy/Il8fCfqw8y/SrznhdIioQekkCrusjuvaw/bWsE31EVDe81
 +WkLTtHkm2Mgs0ZqOT8HjTb89dAAzEjan/BgWiUVh3PHjEizrblklDkNirKK2hmdp+X5fl7IQZh
 bru31hQRoQwHv9I3Rt1gyKt8E916QvUT0zhX4BeSdVP3a6Drrn47tB/y5o99rqfd5baj/D/gPc+
 o3mGaNYTISpnXmgf/J/c8UdutubUHnHqbO4A9PRUCRu3smnfF/ymMrE9NdTgFg4wb1u8OkwN4ni
 CBtUGa6EdH0+vIafELb52PEc6FP2kF2fPwAgKGt9NSc1YQCaof2ah2hZYX+4h51uohDHF21gspb
 4zKDyPgEAGuVvdJgYn2BaklS2O6q45SV7JqhIgmfkmsZnaf7S5tu5cpi6j5BFxQ7yczlPQK0mby
 P24+gmC2K4ENx6lJElwf8q4ZxMZfTx6Bkq5gB3JxQ/NFLwdpbdk3W5iNwMvD1DY+s=
X-Received: by 2002:a17:902:e84c:b0:2a9:484c:ff30 with SMTP id
 d9443c01a7336-2a9516b4465mr116809585ad.26.1770610318757; 
 Sun, 08 Feb 2026 20:11:58 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:9c4:a3d:914:f9b?
 ([2001:8003:e109:dd00:9c4:a3d:914:f9b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9521e0f39sm92495725ad.67.2026.02.08.20.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 20:11:58 -0800 (PST)
Message-ID: <a85ec9af-68b6-4d80-b5a8-b630659e8ad2@linaro.org>
Date: Mon, 9 Feb 2026 14:11:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/24] bsd-user: Add do_bsd___semctl implementation
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
References: <20260208-bsd-user-claude-v2-0-58e5fcfdb84f@bsdimp.com>
 <20260208-bsd-user-claude-v2-18-58e5fcfdb84f@bsdimp.com>
 <4ac81830-4a5a-4a24-bc96-bbc091b817ef@linaro.org>
 <CANCZdfrFJA2TSMoarO9wApz5su8iygVjquPSXgGx+th4tUyqyQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CANCZdfrFJA2TSMoarO9wApz5su8iygVjquPSXgGx+th4tUyqyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/9/26 13:53, Warner Losh wrote:
>     Missing an unlock.
> 
> 
> Oh! Right you are... I'm surprised we don't have the annotated so clang tells me
> when I make a mistake like this....  Fixed in v3.

Patches welcome.  :-)


r~

