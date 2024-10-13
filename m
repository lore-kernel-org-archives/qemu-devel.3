Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B662CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 15:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t00ts-0002Sa-S1; Sun, 13 Oct 2024 11:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00tr-0002MP-Fk
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:52:55 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00tq-0002Zu-0O
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:52:55 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71df468496fso3233898b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728834772; x=1729439572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7n8kvIqzNZJ2oMyQEhhEJa+V8F7v7UnC/wzGl4E+gN8=;
 b=IrRlruI0a1pCgifKMBx+hQSomN0GOScR2cXGNIsRBLRbUMN6zOFGAwcTIPPdyMghIl
 wBTxdyxUiLFYqv2OlJmWFiz2+wRNj6gQTW6DH2PpXQs4X4P2G+rx8amWPAU9ZrbeQM52
 +GuWOLhm6kbEijiVCbiXHvDcaEIsnY1xkd/aTva5RFznhSfBnoV3BTFtAaes/NMVt6Ci
 uDfdsckY5axJRLapfLWbZ5a/9jON2OKYEEGdb/tgpo5gaGf+Y1ppYhmKwnmlQIluU+8w
 vUvttOSlBXL5RAc3FZk4ZLZZoRLu5XEK8VmyUHrNsBogMjjm17QmiemmvvnjK8Lysxne
 yy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728834772; x=1729439572;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7n8kvIqzNZJ2oMyQEhhEJa+V8F7v7UnC/wzGl4E+gN8=;
 b=AgnkwzjzEIlZKsAPiMPaufva+ONzSW8aHiQkPPPs93SJUX3V+cmtgO9ihJGeWDGJ2J
 HqfEx+ijhtzdEZeCrVXezBBzDTt0OilKSABeS2uyzZNFdQ1QZm5BMtyY1hil6DOkU3KI
 Xyv2U9IJ0YqvHG7E0J/nKnz/qeS2FlNu9RPD/yr15keugY5NMP4YSxBI/gougwuPfRWd
 f5G/TxfAEAmrP4cfoCM73XAeKk1WjU+f0pmrm0fn+4aOmIUdqGHEPj6O3KCeiE/VCe6D
 ZncR3nbX7x/GQnme1KvM59cVyYykVSPlmDfABykQ3qNdM1nnbRyGfz4xX+ELJLAwYNTl
 rsEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRxqOkH1MsqgaEHPMRjsDb0quazpb4ChFC1bkKAddPKMZ5IpBTnwjsfzFIVSRJOm0ijnxgIcaRXCHJ@nongnu.org
X-Gm-Message-State: AOJu0YzaEPSZkue+yVMxzOuGi7Z0pfLPiq61eg9jLxVJ98UnyS4ZujbI
 etdP0FJrz46Y/vvcWWM2DP+WjkjYCd+LCpdm5FmM1iVXzKpd/6prMuHdhcp4LL0=
X-Google-Smtp-Source: AGHT+IHGJohc183rs20174UC18aXjPqTh4NU1mhvT0qjwOeHjhnZN4l1MnGbisyxP5/zZYkmXd6G+Q==
X-Received: by 2002:a05:6a00:3d4c:b0:717:86e9:cc34 with SMTP id
 d2e1a72fcca58-71e37e4a5b1mr15702391b3a.8.1728834772656; 
 Sun, 13 Oct 2024 08:52:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e4a5059f5sm3260720b3a.117.2024.10.13.08.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 08:52:52 -0700 (PDT)
Message-ID: <846bcaa5-40fe-4dfe-8d4f-ff3630006206@linaro.org>
Date: Sun, 13 Oct 2024 08:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] target/mips: Introduce mo_endian_env() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Introduce mo_endian_env() which returns the endian
> MemOp corresponding to the vCPU env.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/mips/internal.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

