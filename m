Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592E7D13595
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 03:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5GWZ-0000c8-Sw; Sun, 27 Oct 2024 23:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5GWQ-0000bd-TH
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:34:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t5GWP-00079E-Am
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 23:34:26 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so2824850a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Oct 2024 20:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730086463; x=1730691263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+hrUDzoAF3VjvoN+DlhoDkaV0tkYdmLX4Itc1OK3Hzk=;
 b=kfZbMA6jO1p1PwYweSohARSX4ArMl/i6XfW2vlIovwipGsARL+B0vRH6X6rQpwyNcH
 z6puuycCMEQ/7K7W/QPaMhGKc/z/W5XlDcNQlpOXKNn8YdPIlGCTtdVipCHnE7ltlurX
 x3kNT5O0Abc/KBCWgNTSWY3bIwERoUxdl/9kIDC7qP57r0MMKOJq9WVvNp9ummGBlcIa
 3mwBKxxqJIdJ6UAsWP1bZsWKSE3yVslPeJ+iticyNTExQn7JrmlWMgkI8H4fsrpaXQkP
 a56otbyuDv/Bc2+S4CEE09AjoMSZMLwVPPegYuwHm92KVh71XK2KH6TX3oKiUTJTZJ+H
 kr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730086463; x=1730691263;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hrUDzoAF3VjvoN+DlhoDkaV0tkYdmLX4Itc1OK3Hzk=;
 b=v1l1mTEYDJxtxPheXEmns8pvpgYXJDUbqCjXClCGJpzxskQppgGuhisMNJ8QyWHcyE
 MZwukY+2JKWihCztt1Rtmq7I3FGPWZ+5oJky7EqQrkuuyL2L6EDrja8eWCQ/E9y/U42d
 TJtG7oyj0ON1Xz2qRVN3tDwtxlM/hsgwtk7T4Pj4kdD4IHYJWBlRNs3S9eGZLxWVan9F
 ftBz5wONTmAWC9N8eaekmFFuoLJmVGjlQGQovtUUmkpeXoG60qVV2QJmA/OKFtu7Z7W7
 q0gYIFXySBfwUNbYWhqXLIZoAopp8fsTtousOPHHBAfHMQ9hwShX6FzjfLcEeKMO/Csd
 OUCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs917ZhtTqgnyDWjeOX6iDWqcyRh2GjGf/UG76e0NoEPOQQWTGj5BVrca/IFiBRw0/eDF0guvGg49N@nongnu.org
X-Gm-Message-State: AOJu0Yx1FeMMAIuuuDXSgsiOv8Uhm1pFRjakBJ9MjPmsTUxCFg9TV6f6
 MDWF2bPTN5Zbj5dOGnon6GmouMjFKd/yTDgbnCa7GVcgOPin9kH0Evv4qHSbCyg=
X-Google-Smtp-Source: AGHT+IFky77JmbHyBVG6Xfi5NwAYWcgvV9N58DJ6e5GudY+ulJ45tdzhMxJq4LtAboQvHUa8CRkLdQ==
X-Received: by 2002:a05:6a21:4d81:b0:1c4:a1f4:3490 with SMTP id
 adf61e73a8af0-1d9a84dd798mr10069670637.39.1730086463410; 
 Sun, 27 Oct 2024 20:34:23 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e48ed34sm8882405a91.9.2024.10.27.20.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Oct 2024 20:34:22 -0700 (PDT)
Message-ID: <1d7c879b-07e4-498d-bfac-1b0122155eb4@linaro.org>
Date: Mon, 28 Oct 2024 00:34:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: detect 64-bit MIPS
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241027130531.244145-1-pbonzini@redhat.com>
Content-Language: en-US
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241027130531.244145-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x52a.google.com
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

On 27/10/24 10:05, Paolo Bonzini wrote:
> While right now 64-bit MIPS and 32-bit MIPS share the code in QEMU,
> Rust uses different rules for the target.  Set $cpu correctly to
> either mips or mips64 (--cpu=mips64* is already accepted in the case
> statement that canonicalizes cpu/host_arch/linux_arch), and adjust
> the checks to account for the different between $cpu (which handles
> mips/mips64 separately) and $host_arch (which does not).
> 
> Fixes: 1a6ef6ff624 ("configure, meson: detect Rust toolchain", 2024-10-11)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


