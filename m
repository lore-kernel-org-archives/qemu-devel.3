Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06479CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAK8-0006AB-Me; Sat, 05 Oct 2024 15:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAK5-00069t-2h
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:20:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAK2-0004MH-H5
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:20:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20b9b35c7c7so22626065ad.1
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728156008; x=1728760808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9c4hd56i/V2Mv9+jxA5b4JRIarasGJ72ban14YWwCpo=;
 b=Nxtu6Km2/ghXzV9jX3AMOae8h7EUgEwEPevECTZ9NkJsrDrD1WWmusD3afn2l2Cn3g
 uwFoFtw2FMYPTLY9WcYa20EIz7hfiDUnLfMBL1xzi0F7T54M2jzDe+Ua7O50ivMEngKh
 /owb91ZHTrK4mor1mRRa3R6Rc5ERLkQqdH8ye8FqujGAJrIea6kDnAegINtzC8vmGrRi
 Kj4zqdxEPphsqAx59DA+mo4iGQGe3xnruw1opdscZIrxi1kugGYfEa82lKWyc5FYzsQb
 vRmjCPgc7hbcQZ5I+uvFZVbWpVGfrMAESsyqmjJOY/vQZ6Ld+vgi0mm2ZNJ+gI8Pq2je
 uR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156008; x=1728760808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9c4hd56i/V2Mv9+jxA5b4JRIarasGJ72ban14YWwCpo=;
 b=UbWDnb+FLI+9MExdUdFqMXuFUcLQZHS8QlmzxwFrZMyru3y6vog5zN3cV7a4jTv4y6
 v6WX3QY6e7xCcf5s/P9qib9XSv2ikkqsXcUXKk0uE/lg8398AShWA8qswlxbnNoSCqXG
 VDcCIV/vCEQeoCz7w7IW1LJ26iQXFZVWWqM9Kff0ZOSznJxaan48NMiUvcPqG/YG2s/W
 jZzUlbMZpXA2gF+Pl78OCYlUcmBTgjO7r40EG/Dy1a3rCmRiWVASg7Qqe2k21KTo8aS4
 JP8Hbe/k8uQ15z7JrKzLpkAbioLu7kCo6uL5PuCO3FV/Mm2gnXtQeqhzq79f4vSPgRb6
 39xg==
X-Gm-Message-State: AOJu0Yy+/c5E6nNJ1Ax6KMXwyFvuZlZwqYAxbSceQO6fzVsxs3cKJOpZ
 eOMh0QghcabluyltaA9obikQ8DTEYDn/vwelwaFspJA3jFKS29grQ48DeVKy6Ws=
X-Google-Smtp-Source: AGHT+IE+YkwgPxgoovMBJpDaL5iPDtxe8ZrEY/uHoz3rdXg/xeeeJ1+tHsT4WhJcUisQn30omyxSkw==
X-Received: by 2002:a17:902:c94d:b0:20b:46cb:8cbe with SMTP id
 d9443c01a7336-20bfe00bc48mr104953445ad.29.1728156007829; 
 Sat, 05 Oct 2024 12:20:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138b0f48sm16208145ad.25.2024.10.05.12.20.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:20:07 -0700 (PDT)
Message-ID: <eb67f299-c70e-4ea0-aa06-5e4a3cdcb448@linaro.org>
Date: Sat, 5 Oct 2024 12:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] gdbstub: Make gdb_get_char() static
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <20240923162208.90745-2-iii@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240923162208.90745-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/23/24 09:12, Ilya Leoshkevich wrote:
> It's user-only since commit a7e0f9bd2ace ("gdbstub: abstract target
> specific details from gdb_put_packet_binary").
> 
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   gdbstub/internals.h | 2 --
>   gdbstub/user.c      | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

