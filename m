Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B452C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 12:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA6c8-0002vD-UU; Wed, 30 Apr 2025 08:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6c6-0002uF-8Y
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:32:34 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA6c4-0000QR-IK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 08:32:33 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4767e969b94so1796391cf.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746016351; x=1746621151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vuUcrKcSMMM0g6BBrWIzr9h93AbNBA2mKoiErMSu58=;
 b=HxYKYo+C4fZHD2goQ0q/ufEjgHwqugixtSBkdizH7+OoE1Ork5nn33/K6S61VEJ14z
 T16Tsx88FotXPAT4d2MM6t5j4Te76/aZ0hh6da3NrvnSo/+ROSnYVkFtoS8RpqqBZpQe
 a7HjgIU4SkiTP1IE8mkIeNsadVyJPAFOASqCvgmrgK00Txc3wG5KV/T9+pNmKCtvSE+T
 bwaoO4jzQNnuR85Boir4sd0DvoY7ifkl2JrWYCZh6hy7PZIdC5r7xisB908OJ5C/H3Vb
 BvCU7j7TitWQyCu4+MpjAH5EDvJohntgH/IGtDG60AKpVAAPwbDS4VLG48gagg1+wzl0
 ePrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746016351; x=1746621151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vuUcrKcSMMM0g6BBrWIzr9h93AbNBA2mKoiErMSu58=;
 b=D59OVQl/MDkOe+iLD7v+9AvWn/F1hUIN/gR/7bEEfD7btVCbBF849qhxsj44W5E1Eo
 +AFLH6BUKk2DkmjuZ049OULySlvLUElX+MoiV6BCS5wH6O0HMkqkU7CorYZH4w9/ClgG
 E0XbFdnPPi5rx50n2SSH4clxhLVkTniOwUDMb96DGJeHTorb1jAh0QgzkXJixYFbt+Ol
 q7rbtsMcRn996ZcqNwQfRtnNnf9H/GuUlis6FLm9HXU5ZdBeS6KE4f3N3bn2hSdIZiqQ
 aTIWXua3420LFLZlCZZ/a7PtqyGFotM0elQgUUBWYtNtLrzghDxiUotJRCRAiKMG0BTi
 2F+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHmchURN4wcbMEClSuc0z54pXQFU2E1ygJmbzsWifKXW+WCoIBqKnxXKolifvpVllwPiPQOQry6uuL@nongnu.org
X-Gm-Message-State: AOJu0YzB+9gd53mhfBdqJOc4BslPYGkBxe9jpKx4dui4AOHS5vly9ZZW
 //RqjRycTd8O+hAvOTbKjdLgZ5PiXWhTq3T/G2hdtfOvYsjvlJ3GjYgDDrphICbizIkTK6C1+q9
 S
X-Gm-Gg: ASbGncsNFVqlKmp5l0OD3VVFXEqfzjs3l88Hl1BnXw6PbL7gc8VGKeoMV9o4MMW3CBk
 4re7vzYC/tZHkyZREGQxROrW958V7CHftEs5Md7e9K2J26CRqDpt6B2KDQLOPDqOykpE2eVetBZ
 psU3Kx8gwVNulzNKEa1MSFM9jMzsAiANdW15aOJ5CX976cQ6umcZmc5xjXrnQ42xFTEcJt5AJCU
 Mc4BuEtdct0S8Svx6J9bf7j0VmMpQhUlFbFM0mkRlhqM+Lc5z2VzMnO2FSZziAGJTWtzf735bDj
 d1mq+3QGt9BJgQoegqRuPGKZroVCsDzgBdR/7J//UE6d5jnGPia93/wqTFVHZXqGV1s7+8yJ/96
 Gtt/mwKpWIdpEEviaNEczuY05
X-Google-Smtp-Source: AGHT+IGvcj+hTUGzTS5/zrDOzkvcecu33fY7f5Q8w3PgXskPgtrT9Nls2pLclxq8nvcvURBnmdBCbg==
X-Received: by 2002:a05:622a:5793:b0:476:90ee:bc6a with SMTP id
 d75a77b69052e-489e4e70749mr45093411cf.28.1746016350799; 
 Wed, 30 Apr 2025 05:32:30 -0700 (PDT)
Received: from [192.168.69.226] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47ea179413fsm91689911cf.62.2025.04.30.05.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 05:32:30 -0700 (PDT)
Message-ID: <fa297df2-5128-4b88-9232-15eea38e10b1@linaro.org>
Date: Wed, 30 Apr 2025 14:32:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/loongarch/virt: Remove global variables about
 initrd
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250430094738.1556670-1-maobibo@loongson.cn>
 <20250430094738.1556670-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250430094738.1556670-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x82b.google.com
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

On 30/4/25 11:47, Bibo Mao wrote:
> Global variables initrd_offset and initrd_size records loading information
> about initrd, it can be moved to structure loongarch_boot_info.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c         | 21 ++++++++++-----------
>   include/hw/loongarch/boot.h |  2 ++
>   2 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


