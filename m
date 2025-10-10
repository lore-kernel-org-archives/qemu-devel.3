Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2CCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GZD-0006dY-KO; Fri, 10 Oct 2025 13:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GZ4-0006Yl-Ln
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:06:00 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GYs-0003uU-Ll
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:05:58 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b556284db11so2031331a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115940; x=1760720740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3YMB4G6zY/jjgfokG0RL7igcY/0JbaqIfJEXHwuAHo=;
 b=uHwFn2Uk4kjH5pfAurMGVHMdZSj3e++07PiTTI5UBYArNeSsNtv9P3ZGrtSgBNpZoD
 W2SdWBkPNhqr26EJC6CxYeuMpHPYgLwKR7xKRWtEx34si8h5wWOmmHfiuKvlA21TFXVl
 O7ZTHzbqu5p4bL9i/soCB/52cfNiqDjS6WfW7X0bwDbo8cBOdkqHF4H7j+Ia1xfhOSk6
 FDk8y81oIkhJ9qBN9od5oFMq1HOGlnaoNTVcOdfCP0j4Asr+d2R/h1s0s1IrW/BbdVOH
 kEr8Aev7fktJ7sNAKgJFtQZy1ydARsog9jkHjDIkyZ0ZSKGrpPAUZKQ3MtOEUCBfPm5p
 4EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115940; x=1760720740;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3YMB4G6zY/jjgfokG0RL7igcY/0JbaqIfJEXHwuAHo=;
 b=i9Bspdy9TCyo5ijCWiwriEv2g9Ob+HTxf0jp4xre/NCeGwNXIO3Pb3kJcmANs2yZMC
 HnBCrJVEyr4U2Nev6fBjpo+nRksE74m1nonMWR4pEiG4CUnOBHxKaU9ynax/3owz5B6G
 XiYxAIj6fe6BLezDWtD5CRAkzTJ126+gU0VZuxpmfcxsEaRTs7hCPsfIdnbOvOXIFzdw
 mE8VPTMvRS3GnnbKIcPh5dKVMmaFKA2p15StKvVTNx960pAzw9U3XXprBpDfX9rp+D71
 GpyA1kY0P3jXUv6Q/tlFZpzB7P3u2rJptn5lPY6wrHSj45TE7ygJLKw2jxuzqKQedAUI
 SlrA==
X-Gm-Message-State: AOJu0Yy8BnHuxzOMpAxlhxBm+Bi+8DOo2efUu6ycgA+HByPgtW+Nx1Ca
 BoR8K6VIeVTss6fwbqwy4rbf6sXUN87YAy8L8JrKLFm9nd3IQbChzy/FZs2XnhBJa/qXyz/Lqe+
 6gEH9JGU=
X-Gm-Gg: ASbGncsPs5HS0dHo/psexaeKONcx/5PPOrQz9+Uk6ZRltME1RR8GQ2D54e6QQI0Im/9
 qPGi/sMgANzoh0MJy9p7Z0INGqtM+2psjB9OPU4YzssXlWau/MY8RKNZA+b/GyxTb/P5Q4Y0FzV
 oldO1F6tAkwEkDi36kKpPORzWVLiElHLb1s4Rm4NV+Ia1jPoJsOWA8GR+LXnFtMD8C2TR65pSUy
 iv9iJaCzDtgXf4GywH8D9yN3b3pUBx65/csxYhWD8Jv+QH3INtuLdO6d/2zUMCVv0xsXoWrUsDl
 Rn+eTPntlouiw6NQaqJ7xQHDbdjpmgFCo79pCmBccojrviBvVf28C/tVsxr+2RQ7giC/Z08onGK
 dtD6y6fGKvPhtKUoq7Shf1tE3hZwqSmiFWOMX46Jo5JopHybeD2YvPeK1zP8=
X-Google-Smtp-Source: AGHT+IEjCQz8Vm4vjiJwIPOGdgmSyxx0F7RWITtb6Bt/QpROsEChyfScevrcZryYZ3VIgMgd1BreAQ==
X-Received: by 2002:a17:903:a8b:b0:265:89c:251b with SMTP id
 d9443c01a7336-290273ef081mr162108005ad.29.1760115940286; 
 Fri, 10 Oct 2025 10:05:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b678df48a83sm2906788a12.31.2025.10.10.10.05.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:05:39 -0700 (PDT)
Message-ID: <926f5c85-d382-4a73-b16e-7115463f12ca@linaro.org>
Date: Fri, 10 Oct 2025 10:05:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] target/tricore: Inline tcg_gen_ld32u_tl()
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> The TriCore target is only built as 32-bit, so tcg_gen_ld32u_tl()
> expands to tcg_gen_ld_i32(). Use the latter to simplify the next
> commit mechanical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

