Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ADBFCB63B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyYjq-0005B6-6G; Fri, 06 Mar 2026 12:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYjl-0005A5-Pu
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:13:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyYjk-0005DC-Bb
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:13:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so77118135e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772817194; x=1773421994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zYx1KXwWajHqFPUcIIXPJhKV+taNgimyOGQ9dkyvWnk=;
 b=bi8yyQipP7rwDMGAlEJzCjuoKOdS9TpT9j3CryhE2K5SLyBuMz/vFyYl5dF7O14llK
 0mWwkb8I75H8qdxDz3B1KTS5m78zPqVGPBQwPdnSfSzXIF/FRcZ3iQkgS45Eur0ieznZ
 FXoUHVoxbNvJrjxZSFYQKGc9GGu4wfaxNFnA7mmIkAlOfG0B/nUpn1KiVvmCaGFj5OKD
 X0KX1b+5jlBXNNDmk/gw5SZrS8wgxfy/xFUPzNTAkCgnIkYgpHCGGOOHZWqFYiCadT75
 Z6dYsm70QYDxKfIDSBeQra4ObcQ6D29ZAfaHuZIRXbrjy7IMlw0e88Excr86RQyFOVrU
 YINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772817194; x=1773421994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zYx1KXwWajHqFPUcIIXPJhKV+taNgimyOGQ9dkyvWnk=;
 b=wSj05q2iUIjCD5Ned0RNyD9rvvkya0+4AFD1qyzooBRBXdjLHqZndtXOt2XstwpEWn
 QlEvhOaFl71oY3zMqIal/MKPZS2t/y3wQkahkOmHulaOrdMFpwt/7OzEy7xw+VVWu7wt
 0xrP2n2xEoWCoqFlJJ+R2XOy1QiFrp0Mw5fqpLxhqeU6OIo1W/UoAj6W1WnhxRhkpsF5
 5upetgJQUbNASaArrORebrErFmRNUQ1RyZbw3NSITuf/LiwW2sgxOFFZhg9pjIsADzyT
 cxYXtOAX2R4a8AMK/BCfE2RJ8D4TDYy6/NUtNsBi22VKgcEH/wKAqyvCJi4Sl4Pt65id
 Y02Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuUkPQp4foYaT6p7xZQPxc9/yPpXnfBPiYmUhS7bLJOVXwN/UvY8WAG0wMny0vPq+xcvkPAXIHACt9@nongnu.org
X-Gm-Message-State: AOJu0YyqeeN6bh8NCAhrYyqlqgWOi82r9YpIs+lhTY7Dw4hnv2Z4zs7W
 n5GEaefUutZ8gCOey8SjsTrIGVk2Io3ygOEjOc5lg65aVIppUZjKx8XaeGDtGP2Ou4E=
X-Gm-Gg: ATEYQzwRrLwDS2V/E6ujrvHE9UKpbz3bVJTFaZcRZFbSYPpCp4JXoa5bvqPfZ6wqz3p
 Gj1KISCzo04idJnqQgVdOS2raQpoHQd0dDXqzYQ/n0AKQ9YxGYTu1388ciYQFnXUAuS9pgymB1O
 aBq0WiN5KNTHB+ZjkGRg46JdtAHMJcM7Sqf5uIwfg9+MzpBmNl+OK7gwL2soZw89f0h7d8xIcIp
 YUBgSatwQxLa6TAKrVnCP/+jR6GdfDiB5PMJfa1gjkpqHUtXgm20AInVo6sdQbk0DaXLJve80r6
 SkC0HCCa2A18vmfJSsHypZsomulbiBVWpjUol+wTDxHuULmN0mQ1pRljHxQ7d+uwlrp1E8/aQSj
 JrzxY2AS5a+sqCkCwTQxKLSAiM71a28FMn0Y5H+0dx1roPC8qBSR0qOac1mwuWsqg5QpaAoPf83
 DWmx6yQeus1D2fciol9MVHa6+bWi9iu9oFD/sohB4p+0tRvsmIJsU3CUQAUXG6faaZFw==
X-Received: by 2002:a05:600c:1d27:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-48526759afbmr49833645e9.14.1772817193725; 
 Fri, 06 Mar 2026 09:13:13 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485247014besm19787105e9.25.2026.03.06.09.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:13:13 -0800 (PST)
Message-ID: <90e44c2b-6d37-49e5-a245-dc2b4b42bd23@linaro.org>
Date: Fri, 6 Mar 2026 18:13:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] hppa: Get physical address space bits from
 HPPACPUDef
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
References: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
 <20260305-hppa-c3600-v6-2-d51526e5269c@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260305-hppa-c3600-v6-2-d51526e5269c@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 5/3/26 23:54, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/pci-host/astro.h |  2 ++
>   target/hppa/cpu.h           | 11 ++++++++---
>   hw/hppa/machine.c           | 15 ++++++++++-----
>   hw/pci-host/astro.c         |  8 +++++++-
>   target/hppa/cpu.c           |  5 +++++
>   target/hppa/mem_helper.c    | 39 +++++++++++----------------------------
>   6 files changed, 43 insertions(+), 37 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

