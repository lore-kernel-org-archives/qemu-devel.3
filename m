Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F9AC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:44:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzco-000820-Ez; Wed, 02 Jul 2025 11:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzci-00080T-Ni
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:43:48 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWzcc-0001oV-SK
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:43:47 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60402c94319so4049576eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751471020; x=1752075820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFbLRNhfhcfw3FRZjfdm+jJiuda6u5fxpatg9fgcQoA=;
 b=JoWoUkCtjua9lwhYhBcDYpf19Aipb+YL+K9jhPUSibVHuAh7Cz6067THr6djqDuC6e
 yXRN3ghl7mixbsw9kGGk/ye/dr2Gn8XCrZ1g15UNfkzANonkaEZV/Fo5sgtwpOT8BoFT
 k/WhL7rO2wtN0huH0q470c4ffOQMHVE3fsTfGWWZ6W6ASA0yZeCvoc3ls6n1GJ/AwwcZ
 +YUllzHA7NM5MNJh3U0jkbwb8ZyjF6pkwJhnqa8RNBpznVEpljJwSQnPsX+aGEfG0xkE
 itn4ktlOvuaoedGZpFMrqvEIdKJjJiQDfFbZ2BLMlpxb9KjUSDaDgm3y05VO7gdcsNXQ
 OYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751471020; x=1752075820;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LFbLRNhfhcfw3FRZjfdm+jJiuda6u5fxpatg9fgcQoA=;
 b=kJ3e90LhxQ/XztHg3QbL89Dmyf7kgdjbkklKSNBY4usR8GkzxtUR8pV0IAA1MYhNbN
 y2jiEvABHyLPPxe6KXcFo8J14U4cjDj+MmsflhneJBFEz6VsrkyF+nzJK2YoHmKN94Kt
 M2ozCWjD1rNVRbjCDBkDT52Cqs3FQ4REg+rxTpe4/tN6FZLK47ZcoKbBi1JVxVJbW1TL
 nG0OFSjWrZBkA+WCDlG52Z2VQwNg7c4mil1BxaQVrNqPWBcgMaSN/z1R2M6zs5fu4kQ9
 xRQ3G4wojCCc2usLt7PCZV8TtDuT/EnfQg9k/3wHd0f9irH86LmLbwyczQntgHaE7Lu+
 Txdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKFa9Mgs0eQBQMs0RLQpuo+sbNPApgp0T+aDyzizyT5E0hK8T68eL5AKvw+cvJSQifxzoZKebmMKVs@nongnu.org
X-Gm-Message-State: AOJu0Yzg2yp+6U50isy3WqB+l7ILTffbI19VYbC4ZHPPZye7oItnQiDm
 8/sy98VMhuZC0EPQO26SL/LVaxTLUs4FrYRmekch2ESClNeOalFbr/M4wGf+kWAt6J4=
X-Gm-Gg: ASbGncv2NrgXvgaM9tc8kyy1M0XDkmMClLcottHjDtldd0uC9ABXl9ngDENrpXfUdwG
 JsgVyPuY84ztBgWYLeioDKqLFtdlVW9EVGXb9yRB0lokQfak2d8TiJDdRAMVeCspSqKfcvCW4nM
 kQzPfl+EQ+ahkhyef9xZ+yJynvIiHpsGfvZ0adqMho4I7SGGwJCWFeWlo+Z5OUvArkX8mT6lfuM
 OKpGHuiPh84bgLuA909mSfQJ3aYNj098FaOVd/VuDYPoZf1VYr3Ok83KPEuXgo3rvnBErwe7HKg
 wxOQOv9Hnatg5Bl9sMJ9zFtq55Wk+EwH+keqkykeWRs0uiHjCheYd4guh26csm1sVFYQLT86LeK
 2
X-Google-Smtp-Source: AGHT+IFc2TEgVGNvCRQyrpQ1gnW/E/xWF2rBDAsCiYwNze1EyNxGgCSLH0JwcLL+YKdDEEG1lYBCDg==
X-Received: by 2002:a05:6820:2915:b0:612:1:fec with SMTP id
 006d021491bc7-6120112db80mr2469602eaf.2.1751471020037; 
 Wed, 02 Jul 2025 08:43:40 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b848bba1sm1716915eaf.11.2025.07.02.08.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:43:39 -0700 (PDT)
Message-ID: <fba5d3ef-e494-4c7c-90c0-23e79b647bdb@linaro.org>
Date: Wed, 2 Jul 2025 09:43:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 68/68] system/memory: Restrict eventfd
 dispatch_write() to emulators
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-69-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-69-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 7/1/25 08:40, Philippe Mathieu-Daudé wrote:
> Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
> check because the only accelerator available back then were TCG,
> QTest and KVM. Then commit 126e7f78036 ("kvm: require
> KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
> '!KVM' check should be '(TCG || QTest)'. Later more accelerator
> were added. Implement the suggestion as a safety measure, not
> dispatching to eventfd when hardware accelerator is used.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   system/memory.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

