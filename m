Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264DDC5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNthd-0000ql-5d; Sat, 07 Jun 2025 09:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNthb-0000qH-Db
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:35:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNthX-0003rv-1W
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:35:13 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a361b8a664so2432268f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749303308; x=1749908108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wzTjB/nNQL96foxfOX7+oBWhq/QEZYyIRKqEn2ymUO4=;
 b=ZxBeEEHvMQN77/TxuBMFZXvVD9TWPUFetRCAe+J9hdrbO4lFHOkDOFzHXpHgt4+7R2
 iIJuWmHLdnSdX8zCXWVMXZJMChgl8UnlI15rD7/Zq0rHpCLKtou28MTjbacvd6Iff4Kg
 oJ23JuMPVRWMw2pO6XGtGCWcrNIv2zqF1iyx/Ga3UhuwYocc2EBbzPA0uEmn/kEhNZ0b
 zt77d9A7SSE7HCPRuLqBAJU5As1KEJJ4cnjlhx75+rLZ/6eYoHm5CqAxLzVX1FKax/3k
 l5ledSqoMO/DlXErhKRLYjkxlQbEr65+A0xQbNLepkfICQkXFBE8tXwBIkI756hEK3TH
 23xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749303308; x=1749908108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wzTjB/nNQL96foxfOX7+oBWhq/QEZYyIRKqEn2ymUO4=;
 b=mYpx5YcXnkwfI6JTIKkqQ0eMRfzAmQjNSQELI3VIVlLOxIJcf0NGaN/uDGb/IeMlze
 rsFc9BDwBPt0uPiGkERa3Uyh3Yq/1glf5XMTz1wE0odhs4EGr6Bbbg+VmgGhUU0FEndt
 XIWdu8fGTSoGUGuNcerU9pmmKEGFwFqXh06Vf9lzaRaPSqIr6CVE94NdlPYy0x9fz3wr
 JZF/leHrfgiPSyoT4yCgeIl2CC8Ymqn/wW4+aUUwKK42PFRWK/Y950qhNE7XHycHzE6u
 IH7lWuIeKOZDXTFqMrTYUnU3MEN6nVlnjAq20NXJ9xbu7zrLI4NfrnulYkY/I9xzbuts
 zCtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgE0Lq6bqTN9VOVS+2MBt5ogY6Rv/1Q6FmJaPfZ6hkQ2nuLGIF5zAyjLNW7m5ONjSpLR5hdSRxDDEE@nongnu.org
X-Gm-Message-State: AOJu0YzpSap3xYxmXc3Q4M3TYbi+fxZU90npTMzysXwV0ErbfU6crFe5
 PN+9lT8EGEulJpakQoYkUiSvfXVSfloWavglq/NcDawvo4UrEozQzDbAbTe648H192QXJJ7mEJA
 8t3snccw=
X-Gm-Gg: ASbGnct4AwRTPfH+6kyUlOf48R9h7lsJb+vwPVY3/DzgqBylyYUQLN3JeyfTdne4NDK
 8QhMqYMcflTs735Y9sjkFi3CLOzmT0+o+Z/Ue9lKIEBNHI/G9dRUwGd5wVuXi8/3uwdcZ6SAGhS
 ae0AGqrzgTSnF8ITRq7KvUxFuqzinlU+DgnuGuKbcTBmUJ+QVcQmr2xf6df9CeTY7WA6LC5MhAF
 CwuBnyHudqC4+YkgjQwgCpeAnljt8hBNPytJOvkB/RTzOJgsS0fULX+tX/ccBCQfRSKhtGzub0Y
 IKR46m/ifhKab6UHJ9UhuRttXXOIhvSWjZd/MQZblof14aOJqw4q+HeR3i7MWlF2Lb/FudLIFgr
 SPGwzHeHXttaB8g/TFNccxhgYIylpfGCkHxt05XQcJogbmvJ7Cg==
X-Google-Smtp-Source: AGHT+IFbu+pdoOwxKOKNYWNK/laIDd/TPre3P3T84nvoYOz4ioxh87eqRkbC78TsOYlPYAVvlLMLQw==
X-Received: by 2002:a5d:64e7:0:b0:3a4:e65d:5d8c with SMTP id
 ffacd0b85a97d-3a531caf984mr6303705f8f.40.1749303308305; 
 Sat, 07 Jun 2025 06:35:08 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53245275esm4611548f8f.76.2025.06.07.06.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:35:07 -0700 (PDT)
Message-ID: <a95400c5-5ceb-4ad1-a019-e47a670b9f54@linaro.org>
Date: Sat, 7 Jun 2025 14:35:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/19] accel: Keep reference to AccelOpsClass in
 AccelClass
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Allow dereferencing AccelOpsClass outside of accel/accel-system.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/accel.h       | 2 ++
>   include/system/accel-ops.h | 3 ++-
>   accel/accel-system.c       | 3 ++-
>   accel/tcg/tcg-accel-ops.c  | 4 +++-
>   4 files changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

