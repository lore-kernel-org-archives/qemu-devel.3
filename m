Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98039C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 17:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbNoC-0007mi-71; Fri, 24 Jan 2025 12:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNo9-0007g9-Df
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:49:30 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbNo6-00045r-W9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 12:49:28 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2165448243fso52023255ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 09:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737740964; x=1738345764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N2yyo0WE7gmCW0J+UPTS0GYBIhZdopKA3IQPoNvKYKg=;
 b=HxMbV7hIlfBypSFkRx+XkDJI4JRUaUOZ84zmKkryJ5wlQLYYtuPCVGx9LJYgn3ab+y
 xG278/qZNbZbsQDlmuSmdeSOm1GliTEt5pJ6Ip00+19zoLkjaVVYF1Yzo4VJlFcJuKcl
 BiJYMY7ud0nz2tZMwmsm0AgnUAIOfaonMK5TBR8C/pOhT5wLMuOtGWMBr7xreocge5Jh
 0QjtERiXZ69912L61yeN2CmUveNw7bOU7jQz1/2Vlw5Lzz+ZeYn8WN4WDLn1l60JrCL3
 CSQRp5RZX15mwcJ+yBleWKKXfU7oeFzexMb781B1XYgBb9lg3s+/O5PV+3vHpLRLnHkK
 +j+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737740964; x=1738345764;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N2yyo0WE7gmCW0J+UPTS0GYBIhZdopKA3IQPoNvKYKg=;
 b=XrlZ+IgOLxBD47gO/5zhgChS+FGNh8s/YUCrI6KMLmUlDW79mioPK48NxfK2EbEnI3
 V0ORZ1VsKJCU+EpDM0LZnlFoKk32DEbJX6zQF7JxBJUAiOyJFVzYzdsACrnrNwMnm7M1
 VwLFoD18Ykxj3Kvp/wPVKsAhWZedM/A4w3lmB9f29vqq48hhivkT6635iF2Xjq8FBIlw
 Hu0f3Wvh6vfjH0YucUufaNF9WeuJGHcrDiCptQ+QNiRulU6bW3R1jpqAbGewzEWREi4a
 9GMn88W/8SGM3e9lkL4nraQdNRUMkzaqdt/HyjxI+R00PBkWAA7vZZL2dwBK64Pd6ueq
 FK+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6gFwvJPuAxYbeiOOdBRHBUWFtcw3x6YZtoOHh2vu6kNDSpUlCxjbemtlRHn8fuag8iib0JGdF+pdZ@nongnu.org
X-Gm-Message-State: AOJu0YyVjrpK3Rjaha3jXXUdCxW1BXb8Cpgi/iIpBgaEL87XZFfcqogv
 pv/3pXmI2tdpHCntjWeTiWn8Qqo2cr8bcSvAEZX0ioxy3dQEKWcILnsqk3ciBKE=
X-Gm-Gg: ASbGncsegi06NM+wmFWum4KdDxBIkEXr26JGYCK+Q0TrtPKibn2gMz7UPoYMfdtq8fS
 OMWmCWmpEAP26lSwMt9KcdZCteDaXKvbXFCmaulVxI3saTp/Io/nuV5koISntOE6NmYDfdcRWGj
 sRP6/UYxi8ZjRY7mGiTGSuQTrP0Q0Ce8cXiMnKAAahCHbY0S1S730v2skYsBoJMUwHDvN+iF6nZ
 +PuJEcg91K4582Y+bxkPKzSlnxlxWMOjr9gq5Zia2pflgA1kMVjk7MQIGzwcPdgNX0AkwF4oE7l
 5h069WLTFbkQXq3Rpf8KI0L4rkVDMzqQx7hEx59J51fU0lmC6GrEvRy/MBt5QZtfcQ==
X-Google-Smtp-Source: AGHT+IGiN4bJVmgXkE32BbSKM9vAKSCz7S/vq5xpkZ9XjfJwpk+Abd90voaHRSlphQf3OAArc8tuyA==
X-Received: by 2002:a17:903:24d:b0:216:2bd7:1c36 with SMTP id
 d9443c01a7336-21c353eeeebmr497184245ad.1.1737740964014; 
 Fri, 24 Jan 2025 09:49:24 -0800 (PST)
Received: from ?IPV6:2607:fb90:c9e1:9829:9eed:533c:6788:9f4a?
 ([2607:fb90:c9e1:9829:9eed:533c:6788:9f4a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea396asm19213035ad.91.2025.01.24.09.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 09:49:23 -0800 (PST)
Message-ID: <ff8d4cf6-03c1-4d1d-96fb-4ae81dc04913@linaro.org>
Date: Fri, 24 Jan 2025 09:49:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/hppa: Fix booting Linux kernel with initrd
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-3-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250122180913.18667-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/22/25 10:09, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Commit 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
> broke booting the Linux kernel with initrd which may have been provided
> on the command line. The problem is, that the mentioned commit zeroes
> out initial registers which were preset with addresses for the Linux
> kernel and initrd.
> 
> Fix it by adding proper variables which are set shortly before starting
> the firmware.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> Fixes: 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
> Cc: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/hppa/machine.c | 48 +++++++++++++++++++----------------------------
>   target/hppa/cpu.h |  4 ++++
>   2 files changed, 23 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

