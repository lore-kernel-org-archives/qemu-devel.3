Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4E6C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJFj-0001C5-4i; Tue, 06 May 2025 10:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJFh-0001B0-Nq
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:26:33 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCJFg-00080o-0J
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:26:33 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so3914464a12.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746541590; x=1747146390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y1IqghFIXeDNluBDDx8gRPCXaqN0Xsj0VQP/eJlEg3g=;
 b=fKVzKA+RwnQaSJ47P3av9kYYg90I6KDupxYXA7OJuqFM7WvqkMG4s2U+gFGdWR2ZP1
 w35EJOcRO1dhoMOhVLEaRB2KSpCKQJew2fzdGhuL1oXA43MNXF48UuK+nQw5e5qCSmtf
 JJF7xpkpE67FzjM5OAMRt4cmpH//Q1AGESsn5v+B2BXa+/PLS7SmTqHxb9Aq2DQY2FVh
 9pyJjLhTwwFVID2/fMRWNtm/jgwpAfiY4IZZEJp9djFmzwVM+L4jIbb5836e1M4uy5nd
 TN2irvj2U7Wqcpyh1c7oUtLB6i8X/Ez8JXKzRZHAYuGXY0iBex4XP5V8WQmmtU9AIbYt
 xVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746541590; x=1747146390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1IqghFIXeDNluBDDx8gRPCXaqN0Xsj0VQP/eJlEg3g=;
 b=r7L+S6vNCrKXvD7CdGTVdACYdWfvbmEdf9VmKWIhrDGAzbsxT+q577CZAsPwPo2Q4j
 5m4nywFgzMuaYxf56x1KJrn0LMe5BhIxo8WSZf38yMy6TpkB3XAB1Ma/sSV8Ac2w05GT
 sTeazs7U0qnLP9s5/2UIukgqsSB3BCTsdLDCTIAq5TGhJCI1L7UV5cLyoukpmrWayHQr
 A3aw/N8T0GHPmOIA07Dgu/xI8A+HYd+QNPfFqDBWIl33gwm7PBGj9ipyScHMj5ZjqWvz
 1st2LJcLl5YpG8wPPpYoQvLoKBaVq6uRwxU/i8OYPbyL0//+lg+qJeJCOGVgl+2B2Zqs
 DETg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3KpgW7AasPmYo2zJ04KXzYnjCCGc9xLDLZIAEcKMDEtnrbewU6VS/CHuWhvg9zF0757d6qBsa8KGx@nongnu.org
X-Gm-Message-State: AOJu0YyXG8MhqIukfr79h1cU0JssWVURY0nlaCkhkhTEjCIRR5h/vurW
 +76dEGRlsKtqTBj2QoX8b72lbQcyBTeM+UyFg7uYReZlJSZNBkRhn86BZO1/1kQ=
X-Gm-Gg: ASbGncsiTtHtqQXk06nnzcK38uvJjTjKawM93HOUfOuptCB/OmUAmSg0360TcDyyb8J
 ernS2y8UaW6cgUFLItrQRrL3ddrhnlSYPWxZd4VWWT+SCQ//uaLh3mul5vxbPjqfvFnqD9EngAZ
 ysCsiPVMjlEofPFuLQ6DaWkRoLHalnqrcvA70E3BOIYJsJp7QBKw3sHXX+DiS8VTL0mEsxyT6fQ
 QU0dI/8TVVUB9fMjzeliuUIhVaDMUD3bac/FE7awapNV/sNXkquFzTXPxKF6Y5dWxzN3w5pNFEC
 cHHIqMCv5mIRxQIwVXZuXJXtGEOxgW6uKHUsBl6JkdR6Q7RWy6n60k5LCwE2AOmdn2iqeqqXYyo
 Fb9n4aFc=
X-Google-Smtp-Source: AGHT+IFIgZvtnDw7CrIZAa+bkM6EA6FPoMcZ5Jq6srtFkQTcuITa68hlt2YJPQbKlNaXH6f0U8pLNQ==
X-Received: by 2002:a17:90b:4f8e:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-30a7fcca2a7mr4974599a91.33.1746541589578; 
 Tue, 06 May 2025 07:26:29 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a892f4d93sm1181773a91.1.2025.05.06.07.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 07:26:29 -0700 (PDT)
Message-ID: <a2f65004-da23-475f-a6d7-fc99870dd126@linaro.org>
Date: Tue, 6 May 2025 07:26:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 42/50] target/arm/tcg/crypto_helper: compile file once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
 <20250505232015.130990-43-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505232015.130990-43-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 5/5/25 16:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/crypto_helper.c | 6 ++++--
>   target/arm/tcg/meson.build     | 5 ++++-
>   2 files changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

