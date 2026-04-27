Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F92DFF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSv7-0005pn-Gj; Mon, 27 Apr 2026 16:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSul-0005nv-C8
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:50:48 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSuj-0000FK-2C
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:50:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so105066835e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777323043; x=1777927843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nLBjKeevaWO4Kc5sT5HN7jwz2+BINbfgfm07ZBE+LZ4=;
 b=bA+XaqUdueLZkps1z3qDay1ITJ6c+FFnvSnau9NyyBeCJx/RBh7TJlfbWCVyEKMXt3
 IDu2qUm8WLK2uLlXOszLM9AHlj6sjhAO8P1o0+yZy8YAGepQelNfyXhvl47nLKNurUe/
 9taqPQoZ0xltTE4S7SerCHs4XjAYgk8cq5Ena9yW/FgeKpWSSZyDlZbNYjBuJgAROe5E
 FQd9R3IC6zUJZo9j46xCEowzpY3Bsr/pMWvNIuACzjW2mbhiKcFM0947k24dQwVqOG0x
 8oZl82tgmyvo482GrCNNw2YzVV4nTSJf0FvVBKeNkseATlAskJAH09qiJawGJuORiEc0
 Pibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777323043; x=1777927843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nLBjKeevaWO4Kc5sT5HN7jwz2+BINbfgfm07ZBE+LZ4=;
 b=U2uWZA31oxT+gLsbYh43Mtqn3JokWkUg16QD4AhEjbUmI3slj+rl4B3HwGgl6vGxCc
 hPhZoAsF+SYgZTy2tAad9HLYLNrpQIHIwISctSAuyLHr4TgF0HRhG4lVONtG+fDVeNEt
 bu2ylYCjf3oviMXhM29HvHKQ/+zArteooFgDMdYJ9ElktCmAeZrwGxbRfJbuIZrUCWrV
 5CYC+q6XEdjryBsJcFk/w7jCEnnJhEkSiCm7M/V+I91hWmcH+3+xrcUK6xPj4/IXHkIl
 kRNsM+hvsbe5yms9bD4cSfckZkfRhaL4LrGp5BnFckfaJsqE1EDhUiBiQq+osizckhBU
 lVjQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qkhUXAptOyCboI9af1uH1uVozuA9QKIbooQH/r/7nCOg7b1D7mRezvb7bgjXysS4MHGxZ1/EE1Ky5@nongnu.org
X-Gm-Message-State: AOJu0YxAN/KSdXRtrqJuN8cTDFOdfFITxVgWoJvfq9/93naMDCkkGbjg
 bjnaYOn8UWwh+wNfsTjUOY6FJM0Ten9qt8iusARAhj8ukHWKtFMjVy1mlFo1UtUQhxo=
X-Gm-Gg: AeBDiesL9J8DiK5x8eG+fNU+s+voQ1yvI1n6J1uenrYl78nEuSFtv5jkk6d2A0B3Kfm
 CmPYcPbNqY7bOKpXDbIf+Ij/FR6nZhw/lGOKmObMa8Ledx8tNJ09JX5H5LBobbYxRLms+9O1yQT
 UpJDYFQvcIe1AgEFccWK8s2NgJZWZA+XqN9ySEmGXHuQADV8J2dvT68UpNbiTLrMNjbpXyneV7g
 4RFk2IDzL+RUnpjnYCfVD60miCUCxQIXH3broA2IlJa0MX00i8RsyUiYKUl87NL5nN7RZ5zpzts
 xvFbLikh0Xz6JpqsmHIM+xqu9hnP80Zj4a8AQbAmS4WC6b3m2a5cTH7xC3nPFF4Fj115C6m0OXG
 SnIb368AZaN73G3Kid4PR9B6/kwg1cgT6u6sdtRgxrcUgSLoq/Q1qpj/CuizJdyOCCJzAODIU9p
 YvAV+uTd489nBcN5hP7uzojwamT97JhJtWbAggjUekXH4C4ea5+z61cZdO/PCGTSgoAU3dojdH2
 sLW
X-Received: by 2002:a05:600c:4444:b0:488:aa33:dcbd with SMTP id
 5b1f17b1804b1-48a77b22e4dmr3777915e9.26.1777323043529; 
 Mon, 27 Apr 2026 13:50:43 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77aeb223sm4464845e9.3.2026.04.27.13.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:50:43 -0700 (PDT)
Message-ID: <ef21c07f-1a59-4b31-8ded-aaa997a6661d@linaro.org>
Date: Mon, 27 Apr 2026 22:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/41] hw/arm/virt: free flash devices and OEM strings on
 finalization
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260427-qom-tests-v1-34-c413f3605311@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/4/26 21:42, Marc-André Lureau wrote:
> Flash devices created in instance_init via qdev_new() hold an extra
> reference that is only dropped on sysbus_realize_and_unref(). When the
> machine is destroyed before realization, the flash objects leak. Also,
> the oem_id and oem_table_id strings from g_strndup() are never freed.
> 
> Fixes: 602b458201ff ("acpi: Permit OEM ID and OEM table ID fields to be changed")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/arm/virt.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

