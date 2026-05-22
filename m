Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C97CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 15:40:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQRzH-0004Pe-EX; Fri, 22 May 2026 11:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRzE-0004Ob-D9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:40:32 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQRzC-0001Je-P5
 for qemu-devel@nongnu.org; Fri, 22 May 2026 11:40:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-83537a80ab6so5020551b3a.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779464429; x=1780069229; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dsQTkKBui5fFRRMQRvgh1dY8nazE9nwFi8j6DrGnRDQ=;
 b=XthfQmXDPju2FdtFW+n0IMKoX00IceLjah9LvXb47NSQWTH+SxV4isQlzblDzKL2Az
 0R2OlZxRNRkVa9wpDVxzg607XNgYi62NRUHdNYqDNTwPdTUXn/7KEzwTTakFbPEu0v6X
 Ip5TqNq31pQAjEjyqLsmogTzvUdsF8zwH3m2+U9mGU0px3b/HYAFtEGoGx+Ih1HCC2B5
 az6JY6lzJV+2PHjT1uVaHUwuAMkUPUjhFhsCGhsAJ8bl6PG6Fet0yUIokpHzOK/hbWvz
 qmxYl3nj8t7n3wnXgFdvpWGEI8fqflNW9LSkVgxd57ePWaATXoINqzLM1WnLzvmb4b+D
 rBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779464429; x=1780069229;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dsQTkKBui5fFRRMQRvgh1dY8nazE9nwFi8j6DrGnRDQ=;
 b=rBtREEwemO4hWQAE3+MIWdL/x1pHvc2JqAd1pUL/RMBigFqjWf2GLTqwGNguQ99GG+
 OVw+p9/dnHC5WwNKwUlItYxUkePgOwU2Mb/marlFpjOX8fV6u1S5QITPJvoDJQW+T2J8
 PK8HA37ybhaYJisHYVEDsfYtS7JHVOxW/ilyIW/BMku6iF5nMJSqVhqQR01QlJaR3QEy
 UiECgVYQN6jeuYNLPCCcjYEmBcoGxH1IHeTz0vVpVIL8+VSGfZGsK4jSDpVVxpKy3/r0
 2Tq6K62Bc1zlKVZ5hpk1THbpmr/s1LP3MmgBNwQPj6Ov3sWejxKx2JUQNsXLrdz8egSw
 UYUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9G6lW+VKKLXQUWIfGDs2c2j33mCQ4Mtinz8rbIKpimmX9upbaUKR2fqSybcDbW955oZ0iB14aMjf5d@nongnu.org
X-Gm-Message-State: AOJu0YwpeGOE8irf9jmLS5Baau0oVnj2wk7gjLwVDj7CqmBQUjjagJuI
 xAH0OoKZDaYHVGUhEpMbGGveUDlGvaiix78z7NUpzVz1MEKrtj0h9dQuhS0xUKXEjrc=
X-Gm-Gg: Acq92OG+AHvCkose0zI42hCUocQjlMhWN6Pf5bH6UGcV+laMOl+kYQ3PvjUK+6ijGWP
 G7n2NMw8YIbuRxvJ9lrDisLQ3EjjUkEWCnoORY1XpIZ11Fttgrtx3ocOogypaGbmMu/alnI6OSM
 AD91xymcsNORwcGI2i45f9Q8Yk+hB7GnMJ0WAJQDMgyXKCaoDVKf89TvhHa7ksP22WcZLhxdCyK
 SWqYgXBNwgd1AcgnMpVSliSV00HnLq8bDKKO0al8DhAomTxFXROadxy4VpSsxI+QDqHbVv2O9Cc
 fUu3/bDI3iaKkQOidOKtu4RF7uCMQp8XW9WF4pymCWcV1Hn4Jfo0IZsy2R8hWbFEft634fXl2I6
 MprqL7oTIMNLWz7mcCANgXfbFI0FmhXElba+w0nmlY2S2IhFLGvRppEoc/9uVZvkgL6WnTu9QZ5
 bCpr8idgS7vBxgM6QKZwCcH2Sc0aUJ41VRxchSDfH7
X-Received: by 2002:a05:6a00:2daa:b0:82f:42bc:3386 with SMTP id
 d2e1a72fcca58-8415f1a5318mr4500971b3a.21.1779464429087; 
 Fri, 22 May 2026 08:40:29 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164b1b3d2sm2783572b3a.26.2026.05.22.08.40.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 08:40:28 -0700 (PDT)
Message-ID: <13c0bd9f-b8c2-41e4-b0d5-f62a018d94ca@linaro.org>
Date: Fri, 22 May 2026 08:40:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 22/22] tests/tcg/mips: cover Octeon QMAC instructions
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
 <20260521-mips-octeon-missing-insns-v2-v14-22-fbf08e164830@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-22-fbf08e164830@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 5/21/26 22:20, James Hilliard wrote:
> Add smoke coverage for Octeon QMAC and QMACS fixed-point accumulator
> instruction paths.
> 
> The coverage exercises normal accumulation, saturating accumulation, and
> the sticky saturation flag.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v12 -> v13:
>    - Add QMAC/QMACS smoke coverage.
> ---
>   tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

