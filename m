Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B54C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX52D-0003Wr-Dx; Wed, 02 Jul 2025 17:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX521-0003N0-9g
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:30:19 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX51u-0007H6-9J
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:30:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-23636167b30so46267305ad.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751491807; x=1752096607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZehWfMyIfkq6yTIuw9X1Gv3CLzMTYrvvswzJWpiCog=;
 b=LxmIfJ1/+e9GugtLmdseZOFBiX0zUGAkdnQoCJFqW70HcEYE9JgGnAqho7dpm5rfH0
 WlxIQjocDoOKmbyVMvrwQzucjvfb+abU3AL3f+J9sugN7QIYo+uQsw02uJERQAab447Y
 v4cyaV0VKFiUjphzgWP9Qp68xT6GCJq5rvTHdxr8WSxk3xvtA5zE20C3LnBTKg1QlTdE
 PuoP/sDOD/+0fjAofRhR8eo/VZ0VbE0JnA/LMJgjPyoPB9LHFhESLT4s5aFHneZiMNoD
 3tsJySplgPmXyq6/qqxMOFQAqhSgKoSE2YxJlME6RYa8wKIC0Is5tdxVL6qP0tMU2Zi7
 65LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751491807; x=1752096607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZehWfMyIfkq6yTIuw9X1Gv3CLzMTYrvvswzJWpiCog=;
 b=rdf82rmIz9ZGONjjaoGusd6Sc+DBPofsvKkW7FDNm9Pa7/wTD3I2or+fdQh/GT9T3j
 i/2Y9irXc0p9la4x7QSiQ0FUrBsDII4XLUjAwyvT7OhvFCGt9l7v/8wK4H46VbhHYh1c
 y37LTYycEC2Zx375CVhagTT9Uu/9sOXgn3eYGYDkLK9KZALlw3dzsfJFZztjxUBbkU26
 Iny3r6+sQyucuJAHmqMGpM99UIPoXTBoZRaRHzOFp3CbCxIUE+klBmql37U33EdNS77L
 2Ivte+wEPZnI6FKHe//VxdpfhBt6z2nPpJBFGc/VcypG7y0+TxLhjDsuCB9hIERnC8Oc
 SeVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqs77qIvGOKKoPK2wXftSkNU7GxSpG5r4cfA7jmKEz0LaEXhOc/vgfbXWKQKtin+sFgCJXfxSxuEtF@nongnu.org
X-Gm-Message-State: AOJu0Yw58OpDhm9PcEOC5RI8p+skOa5nX+K64yHbu0ua9ihl7rltRg05
 E4qCi8U6oi9g8gDlRwRUxXB1T2OOmGfq7HFm3l9535sG+f7Ff1qD8ATE/s2sM4t36qY=
X-Gm-Gg: ASbGncuK+rCJgm4SJifufs+Z9AqG5WnO3JKIm7LXBEOUIde8QCzsrhZlFdhgZqaEYed
 ObVWxclJXBzbx7ytug27phCiKADmrjNpcXbfPLRMXESox/u8NJoKZayH7WxXBLxJqEfesvwZYqY
 kFtwW7Jr3xRTTuDueDCowlf56mgm4vpZYzOb66NPpSlbAMyPF6VwsDjfH73tsT8xqR8+pUaYNLf
 idlym+OrV+vmlAAs70nFeHiWOGi7R4DPrrJBnUqd9tIb5GLrCSN8qbqTSFcClWIWw7gT41veqZu
 MnXdXOQjN4TS+LunNSPiDX+mZPhlLxlbO+f0hbBXROm5wnt5jCrDdQyB8EgpHnNwJy0NhZ5kPYo
 =
X-Google-Smtp-Source: AGHT+IG9no+Unkyg/FYILPO1RDG3pnFNTZHuoOP0I7KlSIk1kl7bNstbmqliucHtTcpqKD2VVL5JCg==
X-Received: by 2002:a17:903:238a:b0:235:6f7:b918 with SMTP id
 d9443c01a7336-23c797a85a4mr15391395ad.28.1751491806805; 
 Wed, 02 Jul 2025 14:30:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e31da845sm13498733a12.53.2025.07.02.14.30.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:30:06 -0700 (PDT)
Message-ID: <ec12909f-4a74-413f-a600-2882b67d09df@linaro.org>
Date: Wed, 2 Jul 2025 14:30:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 59/65] accel: Always register
 AccelOpsClass::get_virtual_clock() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-60-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-60-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> In order to dispatch over AccelOpsClass::get_virtual_clock(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_virtual_clock() mandatory.
> Register the default cpus_kick_thread() for each accelerator.

Same same.

>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h        | 2 ++
>   accel/hvf/hvf-accel-ops.c         | 1 +
>   accel/kvm/kvm-accel-ops.c         | 1 +
>   accel/tcg/tcg-accel-ops.c         | 2 ++
>   accel/xen/xen-all.c               | 1 +
>   system/cpus.c                     | 7 ++++---
>   target/i386/nvmm/nvmm-accel-ops.c | 1 +
>   target/i386/whpx/whpx-accel-ops.c | 1 +
>   8 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


