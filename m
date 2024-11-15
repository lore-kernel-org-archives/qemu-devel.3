Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E828D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC05M-0004tE-B0; Fri, 15 Nov 2024 12:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC05D-0004Uz-Ka
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:12 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tC05C-0001Zy-AB
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:26:11 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20cceb8d8b4so13151375ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731691568; x=1732296368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OTXHzoykZn6jR7wNYYUQyvxqZmEyX78zc1dg8S8pIgk=;
 b=UQnto4o5WT5BDiRtzlxhN+zNC73ttI2MOqdiIvAqvZ5bfasHiKAeFFAJUHhYoXQTF3
 o7jxKM3w/tPZX+gXcGwB/u6S5HvIkiNMbKM4sEz8lXW0QymMqlnlrVS7aOdap+CNvy82
 9C/Gn1tH4JSlH3b0gtto+YKJqU2kWDa/pUd+bdrEn+RhxyAgVF5iBVrByeIhBgbPkgMt
 GzmV3YH6UrEoNkIBJvrvcc8M506pswDqE2fc0BzVQZ+HKr0fBOoWiwQ/F5VXIg23D947
 aMZYyzcW6k0WqgZpf+fZ/Jfci7Oljx2QeVPdAyz9dMCq954IbvNyxGa9FbSf20lwh1rj
 yQdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691568; x=1732296368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OTXHzoykZn6jR7wNYYUQyvxqZmEyX78zc1dg8S8pIgk=;
 b=J7vTJr1IrwTwAJqkP9yjEm72xPyx6Msh0P6qasJJ0qpIfaD160ZLchcUiPAUTvi1cT
 zkZmKrz9QEVtMXFEvw24SydFjrSmUJNyecdkkfXVuH3gT7Zs+9FKcGeOx4/XoSJEe9w4
 d80s0ZMM+RHf/PJLdoENu0lOPkx35ttfMGelJV9UZlWfCjjUTVDRSNb1uHIV0VeCBAdI
 ECSqJeDbkbh4b/WdwUZ6PjVO/tU3aWra/P2hV2tJWgyvOoKmMiL44zk2wiIlGFK9HueZ
 FMQbEkg5A5M/yZ53oQCvDSMZQSAvQeR31b2ko0/7BxqkMpjTiqaTw7pmExaaS1XH14cI
 8CAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlfTkrSBzH5qUekcrn+f/JX5NGZyNWZVdij6im1QqEiFXlvjZkOt2grNUe3XJQwNPNze5ZJDWdRT+n@nongnu.org
X-Gm-Message-State: AOJu0YyRBtFT+9uQmqa8TuETveS1sh5WWZBi04w4Gfx/YT8on9egcX/R
 9GfBtrwyVWWya0grD5YcfVBbBuEg4MA5usaRzlE+JgdKLdbp0ABaAJNKFDrVHG8=
X-Google-Smtp-Source: AGHT+IGRmX0VjyzBT0O3hDvfCDRrs6YvLeSwK89bW356B1CQt9OWCUX+dWtoFwmDVrXlagXuwT6PMw==
X-Received: by 2002:a17:902:d4d0:b0:20c:da9a:d5a8 with SMTP id
 d9443c01a7336-211c0f1eed6mr114583635ad.9.1731691568565; 
 Fri, 15 Nov 2024 09:26:08 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724770eeac5sm1597549b3a.36.2024.11.15.09.26.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 09:26:08 -0800 (PST)
Message-ID: <fb6367f5-832d-4713-ae2b-b11af76fa909@linaro.org>
Date: Fri, 15 Nov 2024 09:26:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Reduce log_pc() declaration scope
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241115152053.66442-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
> log_pc() is only used in cpu-exec.c, move it there.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 10 ----------
>   accel/tcg/cpu-exec.c        | 10 ++++++++++
>   2 files changed, 10 insertions(+), 10 deletions(-)

Last use outside of cpu-exec.c removed in dafa0ecc9785.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

