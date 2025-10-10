Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BAFCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 17:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7GZt-0007H7-2q; Fri, 10 Oct 2025 13:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GZr-0007BW-DQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:06:47 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7GZh-00043q-5S
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 13:06:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so2192153b3a.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760115992; x=1760720792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y0xw2jErMAzl8pb8sqziqaM6bO+PA9qiaV40ON3hSYo=;
 b=xaMx7g/Vtq1Vlkme2xxB8iI56dGffdntcedGIsxEMLdkNIKisIGslDZialj7v/Yx8d
 06EFKVy5x2rgQ4ImACe891RWllgh4jqETS12N9gFgdClamtymcpP0lLMgBPDiOJpBJTS
 skNWgVM3j/riRrR+AvFMsOlBqi03w9BxAB0vJvPtoovX5m9dC08VALxtcyMIJJJYQI84
 Aq5w+OzDegz1uSbK5RmpVVZMcPOQmmr85FXEho90jQhmMV1eNH524XtZhV/DUEutuH5j
 mhvwSZXwmPxc8Gv+rfaVNhB7ed4kAjy/rqGzFo5a+XydJue2hKWU9zGPPNu9rxxz6lHQ
 yi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760115992; x=1760720792;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y0xw2jErMAzl8pb8sqziqaM6bO+PA9qiaV40ON3hSYo=;
 b=adBGHrWGOst1HQ5MEItKhnwT3ytHgDBoOSbUzqlukJueKCYPyCm/KrnkszU1XYyl7J
 9fURRMWyr2s8A2i2CPqeVxloWpKU6pWcVSgfo7bm7NmvLPG56LE1p59M6xDOOwJ0EAgL
 YkNIgPdytHAStwQ63S63V96oQ5aQLjlcfL35Mx01+MpXFCN/fAeTW9fXeNsMsf+4NwrN
 tw98PR32/NbwuNmxOp0jP7V17hkZe0niw9g1FT2SrV7E1oNN/EPUwlkSHMIzB7F38Ytk
 ine0q+gwemle7Oq/82SoVW5HZBVZ/YuOK+cno4Xl55a5BAsqGW2+x5wDGc5gP4PVevkd
 urPw==
X-Gm-Message-State: AOJu0Yyo0KYNC2B82S80sjuy3DngRVd0Kq04FtI6oV0J9M7jqtnRbIaL
 1iE4Ssynt+uz5FA6fgGdHMT6359vP8UmTGhn85WqImL9h+awdvR8yZGrg4kf6XXGxXk64V6xbCN
 0OwyBuFU=
X-Gm-Gg: ASbGncsx7dbnGZN+/MO5qSQOKh17/QFm5EwpdecVP/lV7R9h/iF4Bz5MQ+m1m0E6vPh
 s+KO7ZYJCY3AhpMfWD3sLwVfSRbgXLivalkN4wX91Ne64aug8E1bRJOUcSEAGm7D9w/d2T05OA6
 c3l917DU0lAVoHRXmQXCQo21E7CyuBW98Bp7RMP+i3mVza8vT63sixC556ZknXkEoAUrMQD8UIr
 OnKjZQQLMrh4W8O4Qp8j0mHxEVoX37DpruVQ1db2AEZcsgIKz5nOGgr2ftAW8GafiBFn621jjha
 nval4iHSfBLya8lCEh/dk7kP41udstw9ZL/25izVr4PMVWYiaUZ6mgoofVUDfIVhjEUAsVxNQOz
 GdpFOc4iMSP5NmkCtlokECAzi6p//YBaDYIQZCNw1vVxWAoTsnGrDe8TScGI=
X-Google-Smtp-Source: AGHT+IGuH4ZQbrov3mzZvp6uAfVT14NhD8oicf5fdndy2H+WhZ8WdtoLJmkmrvC7bUGBb3X9fhhYRQ==
X-Received: by 2002:a17:902:db11:b0:274:6d95:99d2 with SMTP id
 d9443c01a7336-290273434bamr182214975ad.39.1760115991654; 
 Fri, 10 Oct 2025 10:06:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e2096dsm62244575ad.43.2025.10.10.10.06.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 10:06:31 -0700 (PDT)
Message-ID: <00d66e2e-df1b-42cf-bca0-86a6da2f5bcf@linaro.org>
Date: Fri, 10 Oct 2025 10:06:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] target/tricore: Expand TCG helpers for 32-bit target
To: qemu-devel@nongnu.org
References: <20251010052141.42460-1-philmd@linaro.org>
 <20251010052141.42460-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010052141.42460-10-philmd@linaro.org>
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

On 10/9/25 22:21, Philippe Mathieu-Daudé wrote:
> The TriCore target is only built as 32-bit:
> 
>    $ git grep TARGET_LONG_BITS configs/targets/tricore-*
>    configs/targets/tricore-softmmu.mak:2:TARGET_LONG_BITS=32
> 
> Therefore tcg_FOO_tl() always expands to tcg_FOO_i32().
> 
> This is a mechanical replacement.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/tricore/translate.c | 2595 ++++++++++++++++++------------------
>   1 file changed, 1298 insertions(+), 1297 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

