Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACBAC98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 23:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhbww-0004LS-Pa; Sun, 18 Jan 2026 18:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbwt-0004Dq-Im
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:12:49 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhbwr-0002IP-Vw
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 18:12:47 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a743050256so1023435ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 15:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768777964; x=1769382764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/J313wSKtqJaoKh9EUl5lvU4xnPd0FBAztJKIloCp5s=;
 b=FHXAVvUm9LOssYEGu/u7KUONAHohZWnYkNaajT8Y1wpPD/mX0zJE69uWQw9kjydAoJ
 2wA9r+SVZKHSwZ6ilGLl+b8rSLDExHxwjiIzTByiqXmpYu1WVk62UiuoFkvic/220C+T
 YdkgKu80iKjxMUBAllODKaWlNvPj+jpLTb25/Leh5XZicrBBUQGD2LGo2Slw7OnkN3LF
 nGZFHbBmXXJWyaBw+27Z/v4XJPark/08xHj1+EuIGaI7KWYIcYdNKGWUqg2wgpL0TUkl
 L9WuGA77qB9+od7WJcAStXo4hKolSP51C4oriFtVkK7r6Fw5bkULUYsgUPzXnNBMi298
 U4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768777964; x=1769382764;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/J313wSKtqJaoKh9EUl5lvU4xnPd0FBAztJKIloCp5s=;
 b=HxkUv3WY3769OfRj/WigDIseloRCMwu4jMS0UOqOwTnncKWLYOPedvyW7AFxKztmH6
 y4L88FgUOFhWCQ6nG+Ldzs7pLHlPYdBSwi2ABaRMJx1ChgU34STAgSbOFFrtdjkljjmW
 z8qD/WZLaNljfomxNkE7Pktn16vzleQf0f6aiCwl+TWja2SR6LkCns+MKBz0nl3KZvnA
 WQjpVTi48ZYYlQeJh9bEc8XKdhl6uSwnkx8oo4geY0OxIeMDllAtiJ2jBTdxZBJ8MN4u
 eyr4YIBZcFhWMRTL4jQ51MpqJsdblo1qifDO1v2/wNs0tkj2kpp0qXolwbdzJ+o4mjHq
 OXsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXuZ7eHBOfO2QRLUG+STTnRvCxOa+COBCYbViAVSk4ooL27rXpT0pskJOdswDGpNy0RKZC/pBi7Ovj@nongnu.org
X-Gm-Message-State: AOJu0YxkS7rKclkwFq6S8+8/Yf1H+OlkBrL2uwdrSXc2vyh2DhGKLBo4
 vCjuw0VLNQrmNqeh5DOKIZ53FmDlgV99NIhNS2dLeb5eDkd/m5h2QuKa7S4qPzEd9Vx2r0l+7Xz
 i9MWueA+SGA==
X-Gm-Gg: AY/fxX688euFEQez9x4rN4127h93WWaOoBYLHtOBNmK6HyKT9XAN3BnCKJQmkZhJrfu
 WPsDFPxj14JFsxQBzXexPSDR2cMnlbXzSh0ySCUndF3Apv4WuM7ghFwsx9TS40Qoi4hkbOFsBYS
 VRZVcc70S2ihwvJG62aCwd+3Zeo4HPE6fymCZraqm52XQlQSTkhO/NT0RLKzDLNZ0EtrW7KP37c
 jmsH9OG3ZNnmjYsm1jfoN6Yq2mCMHo07sWnT9lGI9FF+uY071+2sqH8sKObl2nPLzB89PPrYz69
 8d4QbKtGhL9ndBcYvwIpyhC+xnLgVPKZo19nCJX0w5xJobVOQ+EwzUKd6thlHq+VYGhM+Fqzps9
 ecDa+59G8mxmuk85EbFxyNhq8qiOjfy6u+AM6x+zZHduSLNfvWLnPi5UYh9CHpEzjAp8nnNJTGE
 o4lPTb+8wXDOcaNTPKEyXlg72D6Kiiww==
X-Received: by 2002:a17:902:ea05:b0:2a2:efa3:166d with SMTP id
 d9443c01a7336-2a7177df801mr81442875ad.51.1768777964515; 
 Sun, 18 Jan 2026 15:12:44 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190aa5c9sm75009315ad.7.2026.01.18.15.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 15:12:43 -0800 (PST)
Message-ID: <20063a69-20d0-4a70-a20a-4c6b08f5dd39@linaro.org>
Date: Mon, 19 Jan 2026 10:12:38 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/18] bswap: Remove unnecessary 'qemu/bswap.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260118193509.42923-1-philmd@linaro.org>
 <20260118193509.42923-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260118193509.42923-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/19/26 06:34, Philippe Mathieu-Daudé wrote:
> "qemu/host-utils.h" and "qemu/int128.h" are included a lot in
> the tree, and don't use any definition from "qemu/bswap.h"...
> Since it contains a lot of inlined functions, remove it to
> reduce pointless compilation cycles.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/host-utils.h | 1 -
>   include/qemu/int128.h     | 2 --
>   2 files changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

