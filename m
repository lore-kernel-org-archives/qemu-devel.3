Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56EBD1266C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 19:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQWWg-0008HU-1n; Tue, 02 Dec 2025 14:59:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQWWe-0008Gr-DY
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:59:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQWWc-0000PS-VS
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 14:59:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so60661495e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 11:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764705541; x=1765310341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54q08+ypIHSaDsC5Nu32yfCn2asJswxfQSPRLYIRtXg=;
 b=uIREEZgd3qmUyqlwluu12gar9I05X+e8/yzs2m+EFkxKi/ZkaHLYgVtpSQp5NUhlbF
 Qj3sWl+dr/5VTH/+54R+BUcvaI7cDkeefPCymgnxujAu5FvYu+Qxlwujz091BG351YLJ
 UK1nnlwdD0M3CDTswzFFtJwAOr8XmP0q8V26EORRMHyU0j8w2XtlShLgzbEqCAGrFPum
 gadSozTPFv/50AiYT8O2svu9u8nZbgTfAOH6qTNwSOaIxSIrBaHnDlh7x8SWxfL1oBkI
 oLi5AL1Bubwdr0CwFcUksaOeN1N+q5XiCaWxavZaSAwycf7aIZhqV2O1rOyXDmgXz0DP
 9xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764705541; x=1765310341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54q08+ypIHSaDsC5Nu32yfCn2asJswxfQSPRLYIRtXg=;
 b=bWKrAJIDj+rnRuGgCIUa/po4kiAaf5EnKd/DiUOt2Zc5RMxFPGHAwaAR8djuxcwB4S
 c0aBtYlw9ofAIi7PV0hqYtA99Q5VopFbqkcQU91a9JDucWWLFi8aARh1TVzBmAMjZYqz
 4OfBxEcVa84BtdXCL+agXNv8mmjehrzk82iUiPkQ7ZpeQdE0y/KDI8hHv6ylCG2DbReJ
 69GUUX5RLtOKTfjVkVh3S5uPfE5FoBopHOCs3p1tWvvzuoWJfMkHS/+caKyUsryJmJti
 3bJ15frzTwxw7GKNwtfniXXO9GlNN7jpmZcqNgEGWJ7uu+bPCDvuyrMpWWzixKdLHO/B
 WzZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULbVe4dDBEskYh2pthtQm0OLiKXPPerI/yJKysR76/e1DVzegpUuh/4xAnQIrHyG15cdEfaXWwLJOg@nongnu.org
X-Gm-Message-State: AOJu0Yw2VK5yaiBv6VMEMy5IZprceTcRJ2Sg9cVTLAPgYpJg2Tdl5NYI
 LH1OlqE75REuJUxofVUe4nHGicoQfduyeMot1KWXCnMCz4GdFv1YVxZQEs3h62ancca/w1hRjcO
 QdJhPpxY=
X-Gm-Gg: ASbGncuM1cvvBieqyy4lwbi/WL92jaML0GywhVkisfwB6Nu9N4XrJ0L2GbM5xYjW6v1
 ic1AN1zw359180wSiUs6mjmJfsOBbp1tn3mUkBE56xLApMqgexlYFrg7TBjAtuRS3GdJGewbwjU
 xfUIxzH4GLDUwKsVvA8rEoUdy4V7QuE18BE2sv28qloTdv1e9K1ChVPZ5J3h/E5vhTid5c6WoMt
 IZN/Y5FXhG/Q5hfjqnUBvB08LC12RjCKNtrZ42B3ha+8aYkxVaWLp90bbLtw/y91sXj/PCDWIlk
 gf3GMizxeqMqzVnEzbnDhJ5LBImqeLPfi1byN8duBZi8uKojeKndPbq6LNzm3MTIflSuVktwAZM
 asWbMyLFy/Ufzsmpy7K1YScqkIvAyifVpmE5rbrXgqziyczlIIYxyE/5lZe6D4kkYdlERP/K2da
 kdfMeJI3VKpR7nSbQEkNjw3defn3nTXcOxVsZ5S2UoPyLTEDPfDzfJZA==
X-Google-Smtp-Source: AGHT+IG21v0OwhT/Zk7xyNpA1lmehgKu5LE9vjY8tj6WyMGaArhbjv/PVYRFsq96BPIq0MT/A1/Rhg==
X-Received: by 2002:a05:600c:474d:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-47904b290bcmr310451485e9.32.1764705541314; 
 Tue, 02 Dec 2025 11:59:01 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792a488966sm4646555e9.0.2025.12.02.11.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 11:59:00 -0800 (PST)
Message-ID: <e336abf5-589b-49b7-98b6-9206ead80197@linaro.org>
Date: Tue, 2 Dec 2025 20:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tcg: Zero extend 32-bit addresses for TCI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20251202011228.503007-1-richard.henderson@linaro.org>
 <20251202011228.503007-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251202011228.503007-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 2/12/25 02:12, Richard Henderson wrote:
> For native code generation, zero-extending 32-bit addresses for
> the slow path helpers happens in tcg_out_{ld,st}_helper_args,
> but there isn't really a slow path for TCI, so that didn't happen.
> 
> Make the extension for TCI explicit in the opcode stream,
> much like we already do for plugins and atomic helpers.
> 
> Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 222 ++++++++++++++++++++++------------------------
>   1 file changed, 107 insertions(+), 115 deletions(-)

Was slightly simpler to review with preliminary patch 1.5 posted
(consider taking it in between). Anyway:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


