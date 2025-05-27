Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57737C54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 08:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJq62-0006d6-Dw; Tue, 27 May 2025 04:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJq5y-0006Vs-Iq
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:55:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uJq5r-0002YA-Qr
 for qemu-devel@nongnu.org; Tue, 27 May 2025 04:55:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so1961037f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748336127; x=1748940927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkIDgkf/HTGYSSmH0iIlWCC6kJ0/iGD7KRCLMUZc2LY=;
 b=Fs9O4ZjsbgOeDlkarDv4+uB85lX0Ga8QMERP5dvB6QwW+GGnnJk5BPTqjQf6I1Iv+U
 3rXX+MUaUcg6zWdqe0Rri1x7IfyHEEgLDQoS1Qlyq8D0jUnfJ8rBlxmYY3K2hT6W16ul
 hRkqjYKv6d7WcbsS+LvC6+K3FSAb3U6u/Y4FB1iCXGZGGk69TvGkVhIRm8iwg2jAsLs9
 Ti+OifJcrgbk0kgjZWawZTz2SptE4oeXrwb4W7hQTGeSuOXXHfkhl1qNz6FzvZN8+4Gq
 tnM1km9ls/G7GswNr39u7TzAiI4uKQfw+Nd/Jxh9soRA5YSRw9dox/H/AziMyimwyQR+
 4KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336127; x=1748940927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkIDgkf/HTGYSSmH0iIlWCC6kJ0/iGD7KRCLMUZc2LY=;
 b=WxNGHCNTNdN58OYDwnX8RtFEOYYMa4ZUO7fei8MiE62m1Cf2gOlyssi92fzBNIr3fx
 h1/TiwB4fHDrLKu98LuoL9TKL+WpB661IHAAlK5Niq62Wjo+LdNW4xrfJLLE1txdkpSj
 tbR3lE+wUGaz+XCRLZDv1u6TrW8AHa+TYfvEY+0xaE1DX6kQ2KJN4LDGAuW9QgzE5oYJ
 4VtrM8FaWZpIpMZQQFxxvBIeyvOcKIxifOKypFSRvs3KlvOjNUdSjEDJeZ96fIUNNWIX
 HrMBl8RmZuSEJtBSjOZna8uMSmitzeiKroMW3c2VaExXsY2j6wt/0UpIT+YbYz9wcr5s
 Nh9w==
X-Gm-Message-State: AOJu0YwpEMGMc+FY1+p5shdtgp9N8Zo1WO5kUGpTxly2aDLX/OeEZXoT
 fxXq7p+Z/mZt5wGsIDgyIg/FnW6ndOjoNRoyhQ3Q4wX6HOxFIq1J53uw6ju3RyMuf+Z/Fm8R0r9
 efwRXcoi1ug==
X-Gm-Gg: ASbGncshQI5wkZRhgF7zuy7P6ffZVdsaxBVsZIskBlyKkXdq/rvqzOD7nau+Us2WedB
 5uafbygo3CQA+5lijpPe4thipCjKfG+GRS5JDWPwxIZaDerRwBKhOtnmujUBoSur1gsDf4ShueY
 V2wkFrLBUEJ/3NTQFa5sq4rSJmQ+R4ySnRWP/brMyXtR1n/x2cQWGsfjgM7vHVsu/taodOAcNra
 vLcpIkXdjcVh2uF5qlsj4Ru9SKoZrpVZ9cQXFPIUQq+1Co7ElpWbwsnE0C5kPSEUkj41obnZ6CU
 8Wm/AWi4Wq/oh45h5PPjBykZkSbAVzY+sdUcN3ETjLA5yGlLjLcCFUD8XRC/IsmlPQ==
X-Google-Smtp-Source: AGHT+IHoznR2DyzWIM34S2FLHUW+QBM4MMj3tKSaQvfPV7lbdYwmcgtHHky+b75f4uF/nFXzlFjLww==
X-Received: by 2002:adf:a3c1:0:b0:3a3:6af1:cc88 with SMTP id
 ffacd0b85a97d-3a4cb49df92mr7018414f8f.46.1748336127487; 
 Tue, 27 May 2025 01:55:27 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cd0cf5ccsm9604312f8f.8.2025.05.27.01.55.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 01:55:27 -0700 (PDT)
Message-ID: <38e6a4eb-a0fc-4c83-a7aa-f1fd8253084d@linaro.org>
Date: Tue, 27 May 2025 09:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/main: comment lock rationale
To: qemu-devel@nongnu.org
References: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/15/25 18:46, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/main.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/system/main.c b/system/main.c
> index 1c022067349..b8f7157cc34 100644
> --- a/system/main.c
> +++ b/system/main.c
> @@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
>   int main(int argc, char **argv)
>   {
>       qemu_init(argc, argv);
> +
> +    /*
> +     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
> +     * initializing cpus, to block associated threads until initialization is
> +     * complete. Replay_mutex lock is acquired on initialization, because it
> +     * must be held when configuring icount_mode.
> +     *
> +     * On MacOS, qemu main event loop runs in a background thread, as main
> +     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
> +     * and the simplest way to do that is to release them, and reacquire them
> +     * from qemu_default_main.
> +     */
>       bql_unlock();
>       replay_mutex_unlock();
> +
>       if (qemu_main) {
>           QemuThread main_loop_thread;
>           qemu_thread_create(&main_loop_thread, "qemu_main",

Queued, thanks.


r~

