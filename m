Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80100C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx7D-0004Rp-TJ; Tue, 28 Jan 2025 20:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx6w-00046X-5M
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:43:25 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx6t-0004N2-Nk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:43:21 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21680814d42so103456835ad.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114998; x=1738719798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fFfoxHa2VRvApaneyW0/LL96sCPwVER9Tq7d8lmMeyY=;
 b=Mdo+cC1rVt6FH4bK1PxK26MR3+yoaD/QNWUMfVT7DHV5tqLMWfhRSCPW18PKNf67NC
 T4ZdcRj9OkK9Pk2ZtNHoBQbOvBs/qqttEVnhYXFOAWAjgIxa93QH8h8kMUynOGiKEk1/
 dNHamb+LSG8A0g+WClqWP7C5tzLq8/Ui3mNIgjcyiv/EgtmL3W8iZ4yneCsLEHSp4CI0
 Jk1yszT/KCWG7BXjSpIivulxXMp6A6TfZijEs45DQqBsyfPqiv07HxMud206t6IY2iB1
 oIayViYiub4nhTi0iSPv4HQIyBX3Z2C3X5bgXc1i9zFvkPFTCiDrWJ/ypcdVNUL7+1VZ
 mv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114998; x=1738719798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFfoxHa2VRvApaneyW0/LL96sCPwVER9Tq7d8lmMeyY=;
 b=kL/JZoJQbjhpQ8by5QjfD85yDk88cljHrnlXAaJh3uu2iTcomLNCV9u/SQl3+kAcaJ
 cv3SnaAMPbtK+pXC5cm/CekWw4dBX3EDy0mLy3IDR+lqayPudNWorWrwPHL52U0XtfXm
 +IZDF4+zaDY1vjQEo/L8U9p/QHGstr/jcfdQJ2q1G2Qo290tp+cbtlINZxug+77fU7Xf
 mPNbP+qUxPIOEwLowYi0N/UDw/8AMhdKQFPcIpFxgdmHu3Scb9WaKfXQyMWEAhjsNQPI
 fFK2wyKGn0En0rh+Maab+kLbtcgVx/b31jKHrt2g45UdLqPMF6TQrcseRy0RqX/RLr2o
 r1BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIFiyQTSGxZsWH9MFfS27I4WBtR+bLSAsYZjQ4kFnETi97286CmSMr6HAunHYA49jq+JnnpBRyvr99@nongnu.org
X-Gm-Message-State: AOJu0Yz6kOTcIE3j4R4DUBVmDdL8sv2ICBFUrL2MYkxJ5pSFbgt2/bjx
 QYL+GAJEyl+LNwCVI1wwbKiTYuZqkK5sj7ecu8dJTRVDR7uURT+prmS9BI1PjT8=
X-Gm-Gg: ASbGnctMNL+cOKI2pTAPJzTtyoJ3hNqpwC4x5cHSGXCJauzcDmLFq4wUN5AV7sE/cMV
 /YGgwJs5oe5i9VmJd3eGbxoR7+2+9rko5d2eWnCCC5KljejEYONio5Jide6xop/f8lHWc2oSqA4
 7TgUWfwOU0aBG15XXNyr740MXivpqBS+nTk8KkoJVx5WeR2xN4AyRAaOWyvFmVFt0FBCLZlRIM7
 nI4peEsr0MjfQjTJ9oem2GBoZ0UhJ1zF+UpWLuvRfa070oPXO2TIXHvZHsp2/H3kaL7fN4vzZ+p
 tZBG6t+ZM6eD6svrGLzVkV4VawBmkg1CTnej8eLuMNSWF7SAUIMWqNg1hg==
X-Google-Smtp-Source: AGHT+IHQlccDoXYI3DlEIdNvuiPawFY8Eg6pCF4dz6fw2sbg75uYoKf9i58SSSPiuKGUCxm1mo2Yyg==
X-Received: by 2002:a05:6a21:e8d:b0:1ea:e93d:7574 with SMTP id
 adf61e73a8af0-1ed7a638ad6mr2834155637.18.1738114998405; 
 Tue, 28 Jan 2025 17:43:18 -0800 (PST)
Received: from [192.168.0.4] (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac490daffe2sm9098142a12.46.2025.01.28.17.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 17:43:18 -0800 (PST)
Message-ID: <92c7ac99-1f7c-47df-a89d-5e027eba73a4@linaro.org>
Date: Tue, 28 Jan 2025 17:43:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] target/hppa: Add CPU diagnose registers
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20250128224817.24715-1-deller@kernel.org>
 <20250128224817.24715-2-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128224817.24715-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/28/25 14:45, deller@kernel.org wrote:
> From: Helge Deller<deller@gmx.de>
> 
> Add the diagnose registers (%dr) to the CPUArchState. Those are mostly
> undocumented and control cache behaviour, memory behaviour, reset button
> management and many other related internal CPU things.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   target/hppa/cpu.h     | 1 +
>   target/hppa/machine.c | 5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

