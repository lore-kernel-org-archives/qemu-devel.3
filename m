Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E2EC36008
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRCc-0001Uo-Tq; Sun, 23 Mar 2025 15:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRCb-0001UN-Ki
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:41:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRCZ-0000ly-Up
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:41:45 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223fb0f619dso71289035ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758902; x=1743363702; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xpN0WCyhT2dzm8EtIPPU3W+5pesccd3U8/8x7J8QQvM=;
 b=zefR4drBngBIijtwLka8WxoP/72e6rvg7KMms9tn6D9raS7Wnh3b+eQTYuCJOs0HID
 moL93//FjoDilZqirQCI8dEn0Lu8edGZGbhVZrTpma8XH0anDCdoGLAcmZGUit56+fxU
 tbZep8UHXhKmFuouzgQrYp8DZns+XDRpj7WGv8Gwd9Z//kwr0vy7nojfJlwBe8y2f51M
 aIopRyt1emAdC7swRuh2wu2Pp70gW6NHkQ739AzZoeO2uEJ2txfCRa9VgWDsBTvqeBaG
 w3zrPtCnhFmezcSImyDHFdfk0GxQP6tidXvDW1+leoAyXieD8C4q4D385JsX9nmjwD6X
 6AAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758902; x=1743363702;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xpN0WCyhT2dzm8EtIPPU3W+5pesccd3U8/8x7J8QQvM=;
 b=svvuIo1wFnGifpYaS+/2HFw/kMoZm0G2aUZF7MIQnUobt2vBncpOC88XfGTmyYL3fg
 kbhTOxKvifoD7yRDO18/esFP2H3QE8OrnCcTfDueF5aymhs+Rnvr0948hxNFl4hYMNsO
 pvbqWizeVLCJzwMAQYMrEIUtPFB2xcBvEzN1b24JaL298cjdt8d/xrw/ehoHLYm5CYIE
 BKxR6o/B4hwLgs0WXX3G5lOsTcUfK74FxnNAAyQNfsdS4qKeK7MlUbr1GUeqxyDIGV0b
 QnDYd0ncHFo2kMWOPp+tGqjZnsTWZ9ZYfbJzfV72fqCB2OH7dWXjAVY8kKcZ8U0JXR2S
 LMTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzd+nGUv3usn/2vffvHCyIq91GQD/u9/G5vI/T/ShH8UW32CGvef4joGYsLHpTLKU1c4CuEZy2yYjW@nongnu.org
X-Gm-Message-State: AOJu0YzG4oeY+byH3zjegkk1jQTxh8qYNytOlmI26UsqlM35IZzdzr1E
 a4d2lOKElmDjGoRanCyuvF3/3fx8Xzd05I8eX9ryxxZrqp38fp5TBWszXdXNZJM=
X-Gm-Gg: ASbGncu1+puQTNjM3/U6yq+tuhF5TIy7NJs+rUepdD89t+jhQoS+XTxEQNI25zmrwlP
 RZyywikmuTr5yuw+Wq0UFT15jfgcZEuedST+QM7pNa3rFSPPWSqkhXHdNHK9OzJFLfXshaoEj9H
 Bdw2772tSQX8xWyqjpqmF8Psg7xBrqsp6ff2iwFCzcIbwJzhE9zkv8LrBt6nU0v7olKgM/TJvuS
 GptD3ycTI1D9yjQAa4mpdJEzH28esGyxDLxiwS6qK8/wgBOf+Dkfq3iU25aJxHCL+S9POSiw9JS
 CjbdoNZ76hdu80ARi6GhIQxLJjCSsV/A03ncb1ub2uHFEYivXZokdRSYPmBd7p/lODpkAi9u5e2
 ffLyOF1faD+NdgDiDBoc=
X-Google-Smtp-Source: AGHT+IFY6xZFysTRRyg3Adf8BTt4qkGs3hqtaQVJR7D6e7OzhF14bhxSgWzf3Sve0/kB4k/0W3qKAQ==
X-Received: by 2002:a05:6a20:1582:b0:1ee:c7c8:ca4 with SMTP id
 adf61e73a8af0-1fe43312759mr17078782637.36.1742758902333; 
 Sun, 23 Mar 2025 12:41:42 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a25dfcsm5561281a12.58.2025.03.23.12.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:41:41 -0700 (PDT)
Message-ID: <23626b2e-fd77-4def-b73c-27da0fba7eaa@linaro.org>
Date: Sun, 23 Mar 2025 12:41:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/30] target/arm/cpu: remove inline stubs for aarch32
 emulation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-24-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-24-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Directly condition associated calls in target/arm/helper.c for now.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h    | 8 --------
>   target/arm/helper.c | 6 ++++++
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

