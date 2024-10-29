Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D87D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5oRK-00050U-8h; Tue, 29 Oct 2024 11:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oRA-0004wW-E2
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:47:17 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5oR8-0003r1-Bf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:47:15 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so55333805e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730216832; x=1730821632; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNHGe5yniRX1hwI0HOOCgdnzsmEGRjjjmVbvHQs4sFs=;
 b=qIdF+ZF6DomKDkEiaDJTmA/LyIVWJIyWIwefyFdgEHGglA2GLpIT4QHbYmt2xHCa8S
 iVlqQJh6SEbi+1wLjsCFRCAQZXDHsJW+2whoDZfER8a7sxBA7DU5POryD3lD/Mx0fteJ
 GNgNuc9czOFUumBHIPr7qBOM6ujp+S3Xp6QQFNr54goYZDrxKR2Nusw0/p9vup2jYnUP
 q5/R9DIajBpMdPWnIczdP9Jkkfo627bOD6no6rdhrTJHx5IcCal3N5hx0nFq6+FnQBRy
 gyuORSZo3wo5n3nsqLHARIorNjXU30/b+LuLKc0duu7vQuSreymnsVEvxS4RPhLgVBOZ
 EdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730216832; x=1730821632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNHGe5yniRX1hwI0HOOCgdnzsmEGRjjjmVbvHQs4sFs=;
 b=ImC/RyOIWCkwU0APXK/AjLlEKaA22bO8fSGXdfrQd1NXYu7dQclTpeTWQtxGCbT5sp
 fzjCOFISIzD6bI+uh1+ETnZQUg3/eP/cOHkseByIbYaurXMlg5jRG8y88X5CwsmNp9Wy
 JFIhi4Z0IxXBjlh+pbidlGIfwZ+2YLIxEyH8Amnkos9NwbEpIrVY+8daS8FLifNL1VpI
 W6ffbTp6QUdZsdEOmh0y7uOlGAEuAG4bJNoHdZ+g+2eYkKRMhGtN750ZFk3jsIUtqNz/
 QQHJvJM5gPOq6brE5kYN7sd/DPfQZiZ/8w5Zo6rbCnORirv9pXLmcTmfgSJRhN6KEAXw
 48/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW8XxBaMfPCCTjwpWQy5CUqbB3VOTT0vVQ8TX5kNj2MbXZqbqHkBhxPzB+PYRo8O12KYUN2IUMmAhS@nongnu.org
X-Gm-Message-State: AOJu0YxmFdnylFMAqopXtEnhtFRYdC6eDgD7f1SWGvw2JkYQpeX/95wg
 Klvy0Rzj08qi2DF43JXrButKeZ1XcPniu1su3O9wZbRX43wQGFQZZCc5neIjQpybja+mja7PvIy
 wxXVq5A==
X-Google-Smtp-Source: AGHT+IGitqa9Fnt1dvoJlv+ck52C3sbqi/WhPVLq0bFrs1MVzYxeioxy6JrhD/H1G37023sLFRSX9w==
X-Received: by 2002:a05:600c:3b94:b0:42c:acb0:dda5 with SMTP id
 5b1f17b1804b1-4319ac74274mr114190795e9.1.1730216831765; 
 Tue, 29 Oct 2024 08:47:11 -0700 (PDT)
Received: from [192.168.21.227] ([89.100.107.89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43193595470sm146663255e9.15.2024.10.29.08.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2024 08:47:11 -0700 (PDT)
Message-ID: <1d3e5017-f0ee-4dbd-b4b9-5e97c56d63e7@linaro.org>
Date: Tue, 29 Oct 2024 15:47:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241025175857.2554252-1-pierrick.bouvier@linaro.org>
 <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025175857.2554252-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

On 10/25/24 18:58, Pierrick Bouvier wrote:
> When instrumenting memory accesses for plugin, we force memory accesses
> to use the slow path for mmu [1]. This create a situation where we end
> up calling ptw_setl_slow. This was fixed recently in [2] but the issue
> still could appear out of plugins use case.
> 
> Since this function gets called during a cpu_exec, start_exclusive then
> hangs. This exclusive section was introduced initially for security
> reasons [3].
> 
> I suspect this code path was never triggered, because ptw_setl_slow
> would always be called transitively from cpu_exec, resulting in a hang.
> 
> [1]https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
> [2]https://gitlab.com/qemu-project/qemu/-/commit/115ade42d50144c15b74368d32dc734ea277d853
> [3]https://gitlab.com/qemu-project/qemu/-/issues/279
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/2566
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/i386/tcg/sysemu/excp_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

