Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A64C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaLX-0006JX-Rt; Thu, 13 Feb 2025 09:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaLW-0006JN-9y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:37:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaLT-0000jO-Nx
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:37:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dcc6bfbccso541526f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739457457; x=1740062257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BzyXTXR1SIti5vNjf0DFd0D0clKdjD1pu5eS/vqcSl4=;
 b=U8QyVjCHbBrv2I4sVkEdspmlCXx/M6cZcMZEAEnf+AgkAOC/PiS1mw0SzDHdcMQE8d
 gzH6oK49nF28c9CCHno9S3i77JFsVYH8fmmzyTXYzzTWJ9GjNAZwgoOvcgpE2/nDy4pb
 XWTiZa9cffhBgZxLL9Klo//Vfpkr6iH612C1Aa1LVldEGj2Zd610b/GQmusARTpG73LR
 MdghVbsmpRxl4o/4r5OHltVDCNYOFHLE+jP5/EUrG/sBjCTduz4cZXEG4SG8tIdpDuZ8
 X8JXS0azRsoWJFyZXzWnMyhshTm26nxbntLuuM17pf4vqz73sImMQ35u14c1lbU+1mah
 JjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457457; x=1740062257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BzyXTXR1SIti5vNjf0DFd0D0clKdjD1pu5eS/vqcSl4=;
 b=j7FCcUCpfvE6U5RgqhpXhSBt9k9sVcQEvyKUwwojcvAR+jnucp0e2ZvGyyT+W8r+0+
 WLdqJ0duifxRbPXNU/gDULePKPZgi32sPJ818qcjwEoBJkV51oXEMR0M+TgxD1ailvl3
 BFs1Rj61qBVPoSwmOKglTr0g9oRFdmDN8pzU0boFoafvQtgKhG3LzuxLCzNTUHaiesUw
 +lYssNePyYXJN8A+oyWegJiFwgxlJgIuJdnJ24+ww9h+2nDuH9VE7jjdklCl6vJWijD6
 BoOaLra6XGU8BnqqkOVluisXKREbTQ+oJq1y4KsJWgl33iXqmWds6Jfz69Bq7ryZahyZ
 qK5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhNNCgNgXRuUJPvq9qXrNH0D/S2b4kZTNGuCyOXwhslAlYZouT43l+w5F1hHP7RWjWCJXf0NFfidFo@nongnu.org
X-Gm-Message-State: AOJu0Yx9kvh0tQ88F4UfNDOLIzL4LVlcwPdhPm6r+9oMJFtlKMRYKKSb
 HEBUiZJYylzMXprxYlkFgMoO41cS93aaqIwaqFIb89T02lQuBQ72rGXER20EbSk=
X-Gm-Gg: ASbGncu0qvbfhI+glv2TdmDJGRKGzjXJrMiOkDu9khnpUGNb1/YXBXIe5PCSzkKyqkb
 kRgO3cpqG9mnkxjYB6U5V0bCAS/y8T1UlPcXFnk0MQvstwZly9aCjXaJTTDaHC1QX5Mnx9DyzQa
 DIlT0GTBE1ZY3U1J0udbshnfejIpBqBgUvg9NBMDKVX7RDtWaOLZFbpRIjZ5SeGvsfk8ePIonlz
 R23B+GQaEmRb1Ihdv/WHNbsPlC1qjoq4+/0fs2NbPQMfeGVtMfQN9AjigSB0I/+sVs3S4Pakp3m
 xqtVqL+G8zN7tYbSbvyr4GIsnDY1h6Qvxp9zOmsqgE6rtS+zvRVCWXa9+E2MF06zDO9djLYteA=
 =
X-Google-Smtp-Source: AGHT+IF2jE3IIlt9vy5oj0JK5Dm347x2nBsO0vztBOQvJLgpkJkMU1a0XP0kNPzcUVSDBY6J/Ie6oQ==
X-Received: by 2002:a05:6000:156f:b0:38e:dcd4:a11 with SMTP id
 ffacd0b85a97d-38edcd40a7emr6233208f8f.30.1739457457585; 
 Thu, 13 Feb 2025 06:37:37 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25915688sm2096807f8f.57.2025.02.13.06.37.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:37:36 -0800 (PST)
Message-ID: <314842e6-810b-4f34-bf5b-a419c6a306a7@linaro.org>
Date: Thu, 13 Feb 2025 15:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] tcg: Drop support for two address registers in
 gen_ldst
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


