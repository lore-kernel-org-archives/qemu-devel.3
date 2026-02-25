Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FA8F55457
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6l7-0007da-HL; Tue, 24 Feb 2026 23:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6l5-0007dA-P6
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:44:23 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6l4-0008An-B7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:44:23 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7982c3b7dfcso43330857b3.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771994661; x=1772599461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9GjSLDRrJAIdds4Zl3eDshsgpV4NAMxqUH8+hSqjb9A=;
 b=nfd1qcMsSDtZvun66afV8ZQzexEgTmFILoKiyrJAhlWQti9Fl1BpaOftCnDIkl90ak
 3Dpv974R+h2u/+BPJDfaGV6GmKbS37clXVuc/jDjgk96A/lu23tNHWVDE/QdS3fabtgG
 dsIviq/XW9w7uSVgIvZtKeqDdfTeZFZj5nbEUhbUDFDtAtXa8MvLHGcZzfeGP8LGFZMG
 cGJZby/krI+k131TLi6AnrkzecJmulkeJcyR0ZsCD5rVdUqWgul9xS6j0qXWPBnKg3Ou
 Kr/YfDcazJySZKaTg+AHwhTEwiWVXl1fNxiwVcDdrvMmgRxK8QolWob5BM4iJL/Ob/xl
 tDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771994661; x=1772599461;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9GjSLDRrJAIdds4Zl3eDshsgpV4NAMxqUH8+hSqjb9A=;
 b=cPTjDfpDEhk0KfYzUa0Y4pO2uCLbKFBY6qYBYTMrrTDgFG7mmy265UTVqSblTREU9f
 HxZSFgxkpwtJXVS+DUHhDWm6rVKmX7HSk1A9FwZ4efkH4h9StIjFucXLdW+Jen/t2PzO
 peAmngkAFeboyKN8Vu8sqoOH4VJEImq9zNOC3hF5r5ohUzQn0jnQEJac2QvcZExG+OKf
 p161IS7Cc2S3ejlHqbikTQXdYwIkeKcd8DGur7n4cPKQ5XE/t5YaIFQz13Zj+WuS5cQa
 RlEyIDu+WEwruHQxwOAJ5H7S0cDSzpLMxgMuessNbyeiLDuU+4fMooSg5runHcEcpBSE
 5fug==
X-Gm-Message-State: AOJu0Yz4yL2/QgZ6yNpFkQgEw4HJMhakmBGg33iJim8xDWvdIdGYS38m
 dAaM6pOhJ79lwaqfdXriXKWIt3KBTqzNZmyJq1qIWKQ2fcncQI5UQUoWMHHGAiDq1rd4yhslbb7
 ZXQ0TPW0=
X-Gm-Gg: ATEYQzxbRjkeKtkxo0A1Yj2OCmnX4OpXo4ByoYElj1Pafdb/IqeRsjTKYPy7idOcKbo
 dBRVSnto230UAUj2FBWH7P8Q4pa9XdXUE5TWcnEZAVzgGIY/S11VHUoulFFXNk11I2iCeGWMf+1
 W64u5ZsA15ENF0IkekthFW6nmpPkPpVIVWnoTwjDm3bxr2Ddu5gF6qNbq5/Cebv4dnJKSJtMl7w
 ruZVpeKbhUdNj9xLXpooF5U+vzTXqevO2dPZB73ynaG/QVGEJz6naijHA22zGvdKnl8rKycmQVh
 St9C9qAbGlIlrP1k5qI7hgDIsNJ31jjaAai80WQRjcJDGPD5zGQZjTSQWEsucqNfr3v+YWtWWb+
 PSf9JIyeL6cyNExKb+M9n24umXPQena9MnPfnvdsVSGTXCCL1lbvdd2lrMI7PPq9W8HKyXGrqvR
 fIAuxNAXsw+W5Vl9I+j5Z4nxZaZ0bSlN3rL5Xi4zQCoqRxU/HTaJQxGWuniStIN4g=
X-Received: by 2002:a05:690c:4991:b0:798:6a34:74bf with SMTP id
 00721157ae682-7986a347e90mr3670267b3.5.1771994661065; 
 Tue, 24 Feb 2026 20:44:21 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7985e48d14asm10737197b3.19.2026.02.24.20.44.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:44:20 -0800 (PST)
Message-ID: <56d0350e-75fc-418b-93f5-8b1f6bd01a2b@linaro.org>
Date: Wed, 25 Feb 2026 15:44:15 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] buildsys: Build most stubs once
To: qemu-devel@nongnu.org
References: <20260225035739.42848-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112e.google.com
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

On 2/25/26 14:57, Philippe Mathieu-Daudé wrote:
> Missing review: #5
> 
> v2: Move acpi_send_event() declaration
> 
> Use meson magical machinery to build stubs once,
> instead of one time per qemu-system-FOO binary.
> 
> Philippe Mathieu-Daudé (11):
>    meson: Include various directories providing stubs before libqemuutil
>    hw/acpi: Move acpi_send_event() function out of acpi_interface.c
>    hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
>    hw/acpi: Always link QOM interfaces with system binaries
>    hw/nvram: Build fw_cfg-acpi.c once
>    hw/acpi: Build stubs once
>    hw/display: Build stubs once
>    hw/net: Build stubs once
>    hw/*: Build stubs once
>    fsdev: Build stubs once
>    semihosting: Build stubs once

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

