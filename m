Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC3ED3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3nH-0004ve-6s; Sun, 28 Dec 2025 22:19:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3nG-0004ud-0u
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:19:38 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3nC-0003sn-9b
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:19:36 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so80362825ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978373; x=1767583173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IzIPA3hcCmOgN2Cck2WPuroLHHBGWMgIwgHj2jrGztU=;
 b=Zd2vw4D8sw+ZXrMdPRPbwzvyyk4RI0hKaUhlj0/uyz5I4j7EVwb+HzykZkYQU1ibFR
 WkfBuqQuteFt1eWj+j1Pb94QSN5H520E6q0qCugCoRxrfcpAWdAFqVsvEKir4L/8sohg
 AF9PDUHW+ZOaqyU8zMDkFMP7SRbqUXd4X0iond3PRzFSB2P7IrsLDKsaQ6ydQ58AnXyq
 2bfwsRMrcT4mVpYytqY/sso/c9b2/CpEz3fv09UwaWr9/5yvmytSa+HUhp/sUUT+k1b3
 XEvf6m00Na5TX4RnfKp7JOq60ZiXylvaljtrMhLquSSY1heVJN+ULSFsEeH/L7i9MidQ
 QxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978373; x=1767583173;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzIPA3hcCmOgN2Cck2WPuroLHHBGWMgIwgHj2jrGztU=;
 b=GLr1HLf8uaz22e8naCAfNHCrrEAvlKFrAvN91t2f0p6lX6EVHBiIfog7n7UMudyz0S
 oygpTYXKcsegiFayWhyTg4rr9BE8YCWXzGP1fnSJD5aIZ6OHLi6ikRvHMCqPPDnBpg4h
 zXxdvDuHXET2YfqPAV8c9YY25e8R2cByi+35RuUODk7c3pSPa/gBn2RJBrZk4BfoKsVy
 m1zJlZfO+JN6s/IO690P0k8TdmKYWG33p94YL0EVm8yPu5ZMMnbfjtUTTc0VNK9Vr2b4
 PF51x74/tgRd//ma0jFUHAqaqrdWJ4QwlpwiXfjD8628Wn7zP6u+4QEKZ/Bxyw+jIULD
 NONA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7zgdOfRhAjybUrbi0Ir5vDJSKjNWKQUzN2qkyWr3hugpAUPUI5tT2r2f3t8CgcKjfGwPeIplV3wEQ@nongnu.org
X-Gm-Message-State: AOJu0YyhVE28dA/do+FX+p3ENf4/9lG+EduEne7410eWRd20EHfkhybl
 Cu3QOSV9oD6i2b672fdQdlzV2w2v2Dp5w2koRFKCY+Qqg2yPIea4HPnt20Yyj1iwPaA=
X-Gm-Gg: AY/fxX7Nc3XxoyjphWIgsQp2szZTinNVlto+VmAMF4UBY6wb7i4nLKrGXKdqsMEl1wR
 nBabThzFN6phBtPpRp2tkA3co0lbC9ERFy3akql3ZC+ad96rnQmKnFEW/VkrgwArX4tkAtzVMjI
 zIXOODp7vi9UQLxPNSxuYEiAmqmS0ek4xDev9xpmpjgEWcgRL1aNVy/jFAxb/niixGRYCyHGFAs
 v9URJYlNqOFNo6Ql3ntuWNXwSmQ2rEtUYRCOMMc+0xZYb+EpBErEu5TQq0cJq9JW5qXZcsbQQdQ
 uM4I53c1RNlAYxysGiH5v/mqFiUdVG6oXpIPlqliQ1XP2+cf3RcHni+pUblfhRR7P11G5vn+6pw
 1D5EgXb8WDUYiVgnmMPOOM2I/zyZqVbNmCygdk0GwCKEgJpEl2eEkvxaYO2WdXQET31xR3ujRxJ
 oMz2pP4RteEhBAQHSDQ08IGZct7Mve95x91/TuiC6TYoACa2wolkfelWuBeFJXXMiaCOKelQ==
X-Google-Smtp-Source: AGHT+IH3B6qIs8NT/2/Api/XMzyDM1JO4VBAeWKFLx2ZTnMroTNGxTCthXlF6wjY8byowY74PXZ9AA==
X-Received: by 2002:a17:903:1c8:b0:2a1:3769:1cf8 with SMTP id
 d9443c01a7336-2a2f2734d5emr297222445ad.33.1766978372684; 
 Sun, 28 Dec 2025 19:19:32 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6a803sm254522525ad.6.2025.12.28.19.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:19:32 -0800 (PST)
Message-ID: <b2446b22-2ddf-479e-bcf7-1a1159fda89c@linaro.org>
Date: Mon, 29 Dec 2025 14:18:51 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/alpha: Inline cpu_ldl_code() call in
 do_unaligned_access()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>
References: <20251224160040.88612-1-philmd@linaro.org>
 <20251224160040.88612-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224160040.88612-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 12/25/25 03:00, Philippe Mathieu-Daudé wrote:
> In preparation of removing the cpu_ldl_code wrapper, inline it.
> Use the return address argument.
> 
> Since Alpha instructions are always stored in little-endian
> order, replace MO_TE -> MO_LE.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/alpha/mem_helper.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

