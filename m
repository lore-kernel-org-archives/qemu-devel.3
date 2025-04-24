Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C40BC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u83bP-0000Ey-RY; Thu, 24 Apr 2025 16:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83bN-0000EH-Qm
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:55:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u83bM-0008S7-50
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:55:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so11013255e9.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745528118; x=1746132918; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BXal+zfAOvNFqXjsxCmEjhqqHx+MtMpv8FYAQTrrfds=;
 b=iN8ejvC4G4SCYGfBGakVyAkpSlYwqTf3aIKdDbXgUq3C2QN96hot9g0ElIdSM/Sp6R
 oQIqeZrNVcNsvi51nIOQhpbqSZ8v8AQ04Wojt8Nbwmm19Y7G+nFANuPnb9vsY8BgSFgM
 Zzku2GiHkO7eEejhDBqxr+gcAjwxKxTDHiTP7AlA13/cQoasEG6FPkpBqHMMQVrXOlWI
 0Qvy63UjrquvW0CCSiTgXJ4qcBHBrwtTO/BlxqfOpQLpWAvmOfSL458L4oIXqFJ8pt3v
 mDPk86rZxP1/CjU7KOhy44x9puYrMityEqQqulaAIPIybAptSke3/iNPq8CjDeMA2//g
 deJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745528118; x=1746132918;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BXal+zfAOvNFqXjsxCmEjhqqHx+MtMpv8FYAQTrrfds=;
 b=avcTOSx75chpV7oPk8Lt/bIw7Oa1GRJFzJUGm3nc8tOBv0V4hmO/28Z5CPG+5xeN5n
 MtnnC2x45rOdewnNflB88qUKRJYqOuUeyc8DyS2FOmpyyU8BTsopFhwhIMb8JmiuYIoE
 AOu5bTOtkqKr/bM1XlUxiI/gZk1yhO8v2Yv0Jr45KCqO/9JAyLZ6uHQkOEVM45wdNBk+
 EL8ylGTqQhXU6MBT2LoW7kwB0HzqFoYXBIJ0glLv5vjjHJ2ERv/vT4GDhDh/bsoWuAlk
 OBQZ2K7Gu462TsZpJtXbkwvqArx1ocbctJSZVsXZF+lYI/9gS95wSFzo3o6rRB0WccZF
 uY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU56ewjhAiq+M/h9jJfHyRrzLYs13i1JT+NI615dQtrW0v8g+p52wGvsn+cxv1z8APOtxK3tkgfuIJE@nongnu.org
X-Gm-Message-State: AOJu0Yz7nYoQRKEp+eHIVo0WT4rCBABOhuAJHzgokidOXN34nB+g4/We
 WuOsZ7WT/Cwd0r2bdjeS7VP4I08w4rxuZyn1JEILWGQ/kYruUxjYJhrzPKMZFZo=
X-Gm-Gg: ASbGncukoBMIc3YmEdVL2AeTLR3SndDu3gAeagtANCqQ6J5TjC68m24zrE/jf4rPQnv
 16aJxqVZSM8G5pgX5WFEFhCSh/UsnJkvEueW3ivZIXNFXc/SlSNRwepqdD5DFLrhkdDGwEBuzS+
 GkxeDIWpFk6XHCQBndzIBxIpnFbwAtO417cg6yZd+zNJVx/DnfDYO5KRLF3ECsC4Y/KMWlFzGGH
 uAZ1kpc9qdvVnGCXP5RBKWxZmxCsc6luChavZbEoSP7ekVoSNKiQWR+fFXmugFJUsuHEsjGhGDp
 UMTmS/H6wFFyiN9gBWRwQDffGN+9F4kTRGyp82NyIMDHPvg12ztX7oBJczPPNjn2eqlfnmZhBEn
 QpcDLl/abYob1t+stj00=
X-Google-Smtp-Source: AGHT+IH3ivIKQcd+vdHX0M5BVxbBaks42sfNY4uV7K/DLvLCojH/BLcKd2WZrfofssI0muwK5IVBxA==
X-Received: by 2002:a05:6000:4305:b0:39f:eb7:37e1 with SMTP id
 ffacd0b85a97d-3a06cecf04amr3505678f8f.0.1745528118510; 
 Thu, 24 Apr 2025 13:55:18 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c7d1sm294309f8f.83.2025.04.24.13.55.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 13:55:17 -0700 (PDT)
Message-ID: <3b402b46-76d6-482d-964b-cd0051439df8@linaro.org>
Date: Thu, 24 Apr 2025 22:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg/loongarch64: Improve constraints for
 TCG_CT_CONST_VCMP
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20250424190741.738515-1-richard.henderson@linaro.org>
 <20250424190741.738515-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424190741.738515-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 24/4/25 21:07, Richard Henderson wrote:
> Use the TCGCond given to tcg_target_const_match to exactly match
> the supported constant.  Adjust the code generation to assume this
> has been done -- recall that encode_*_insn contain assertions that
> the constants are valid.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 38 ++++++++++++++++++--------------
>   1 file changed, 21 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


