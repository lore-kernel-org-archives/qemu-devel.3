Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84317FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSb8-0004UZ-5y; Mon, 27 Apr 2026 16:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSax-0004Q1-Kq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:30:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSav-0002NP-2h
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:30:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so181317005e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777321815; x=1777926615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/vr2nD7lUIqndoI+VgeGAS8cqZVHxRIMj5oyAoMldzM=;
 b=GqFv7t8/lkC2OZFLmzYIEGrXpU+lASb5Bx0T8qDwfeQ583d9McrbZMbUc2+pLg5V3T
 AXXc9O+NxZRH/oAglB4s9u0hOmmuBKd4lU+8zYX7Mdjltqb3g4Kx2398jJp9I6VaNEZq
 epYX3x2+3zt1ITJa6O50xGWukXYZFJEvW0xEv+4hs81a/2kbUXMpHLF3Cpdc9TazulCF
 0LIzsNAs8FVQE7SEgHLv3n2IG8aRfcRvlTPynS0g6Z29YCnnD8ra6E/j8ybXHWDhtSxD
 B1U/lryE+tX+b3OlANwwM0mv4AA2vUuUNppzUlBYON2HL+sIlXnvkj8O7Wep39Oat0wh
 sbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321815; x=1777926615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vr2nD7lUIqndoI+VgeGAS8cqZVHxRIMj5oyAoMldzM=;
 b=XOqCWxoAE2YB1Qyr/mi7ohKX7FEjJcaTIEpMutGeQTorQTveLxnLyoQkhv5zHFHz4r
 mTII1OR/x7hCYU5puEJvWJ/yMRR06txhK7DYOvb6WwZuRvizHQqF0CFF0I8G1GcNTMaP
 myfVeY+HGmWbqlBpaBiJI1btZPXYupEBeB8Pj7Wnd35hTeIE4dlsieOBWFrdUPWuR9qj
 5IjzmJGwkJ4CLBrLW9ttLwPps6SuhXjkQo/w31XfCZGrxoSUdmpHdbDByeJ2/Ecf5hjY
 u8U2vtb6Wu6ak7l3qYh0fSBBS7+OlNGj8KCyHRxHBRsLWQZ0M02pgMQlNJYaULUgjTdH
 sWmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ct5Ok2QMoZKtS0JCK0dh0u7RLQSjMIpZeO0nW0gzbs2h9wzyrHCvKKdWVd8vS8rOvwsxFFV1NxJaS@nongnu.org
X-Gm-Message-State: AOJu0YwuuAzHJOIINM27zygum3Qkw06NwIZJvHATpAoHkiyGZWFoTtQJ
 y7SoqDH5CIbPJu50Ca0Rcu8+fLW8+REeOqfkvRZJvV8HcRtDwRzPi+l0+EnmNjz7MvEfz+vQ3as
 CdT85xjk=
X-Gm-Gg: AeBDieuYUQhEpGXB47rUywZudtcTYZZTKtVNxaFr9qUHMLYtC2yn0GsOvYO1iU/wkSG
 ONWqRk+NiR2K3Bk5N3u0acpWqgkPXnUvgdCDNH04qIkSlLOUKcjUBZMphYM9QqDKQdaBbVY7G3S
 8fWL4qY61H+iBtQsJJxO3/jzZO4gnSNr2kjf8iXHI+Xu77Okf+1Vxn9q3r7S6dwTdVe8MZ2a8t4
 XLn5nOWmq17zTc3eqpyTRkXyzKiPX8HgllmjWAGje0gHJYxfM8dQdc0HXakIOgHijRgB4quuwq7
 0Bazp1GF6/zIHnVvAnyPFtEmagbdC4YRGsL3Sasg+UMoueNttx0OsXPTI6gh+Hax4QU1vfGxfC8
 buKe2I2yIvwpmRvSdUVYoTj9r0/vkjqvcXNZNdI78u0b9R0AgD6NTmyJPEh64LGPIQMJXc2e/PA
 2jyeyukhGF7EfFEPnLTCH81AKqTL2bWumHiBKtspmyiVYwybsiC5k8dlPKxqgzqhEpxZZL27m1r
 prs
X-Received: by 2002:a05:600c:3b15:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-48a77ae5448mr3806575e9.2.1777321815361; 
 Mon, 27 Apr 2026 13:30:15 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463f5b4fa2sm700869f8f.19.2026.04.27.13.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:30:14 -0700 (PDT)
Message-ID: <40707f62-5b49-4559-be1e-e1ea5ce22a0d@linaro.org>
Date: Mon, 27 Apr 2026 22:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/84] fpu: Drop parts_round_to_int_normal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26/4/26 15:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 22 +++++++---------------
>   fpu/softfloat-parts.c.inc | 10 +++++-----
>   2 files changed, 12 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

