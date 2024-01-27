Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7A2C47422
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 02:54:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTYpf-0005Cz-Nb; Fri, 26 Jan 2024 21:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYpd-0005Ci-Vy
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:54:10 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTYpc-0003rb-Ke
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 21:54:09 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-42a8af3c10cso2019611cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 18:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706324047; x=1706928847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JezE6Il07zY6FPlZ3ELzcCAPzDxW1RUnvMXwbQoq/yQ=;
 b=y2ScsAUjTs4B7YqHLYLqQmC0whQndVXaioGCS3ocA0d09HOSDbbnWQxrgUkKM2cbO1
 57UJ2YmrZGUaFr+G3GHDtFTAnibRajFtshFANem4XPadU8b4ThzXJEFM9DMLujlymwHB
 W1RaQt7kx46Jnaj7NIWDkPvG+MsfW2OlFISUoS1oDXxY9hywncNXPlXHTkTR2aMFlujV
 IepAbFdmyPyxlZIXcoAZODZqQ4ELa0v11gZOGJu/n+Y2P1x5YOrFdr0EkG2j2i2R5geF
 y3biKx6d/q6zz4yus05r8anks9rekz8DTlI9rzPltjYHfqr1qcDdOIj4GVIY7I9ic9d9
 PXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706324047; x=1706928847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JezE6Il07zY6FPlZ3ELzcCAPzDxW1RUnvMXwbQoq/yQ=;
 b=umDNgeJE8vQjvxAeVnaso9NqBubDOtHG6h5jgaIRtG7Z3BkIBx0fbsyctW2FKiZpMN
 vGHS71qaik8/NAbUNeMOFDw9QzDK/T4aQC69j9xn8Uk2y0idXjqb5bqv1p03adQLKwGg
 ewsVD5uj3Kmnm/r4itDf+NgL+Sr6gDndUHqUDBRRopyacXWzQ8roit0KIsT1t31kZc+5
 B6Kx+dnsNsExytRD2eh5my198GhGUmK2pC/8HwFOPmpncKmZBTxMwqLJLReJ8flYk4kE
 uQtK5MRbag/ZnhYB5UILuN04qVilKbVwvZAD5ZWqnNiHNEFAoxI+0i37xf2oCOlsWTF2
 IaHA==
X-Gm-Message-State: AOJu0YwVtCz9lPfPteXuAGQOdc03LladiQTYu5haXXjlYevl7vUEBePH
 PBtZsGvYgyaiUJ6RRDd1SuPVlIvzXZOnl31ds6PItE7axPBdjBdfjyr+XZhNfyA=
X-Google-Smtp-Source: AGHT+IGq2rPwCknd4Lk4eOloeYZg4IvbVLxiolmmb3go+5z3yC3uhnpFb5f+Nuc0m/PwxmliSnOysw==
X-Received: by 2002:ac8:578d:0:b0:42a:5060:8e27 with SMTP id
 v13-20020ac8578d000000b0042a50608e27mr1056501qta.48.1706324047034; 
 Fri, 26 Jan 2024 18:54:07 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 su16-20020a17090b535000b00293851b198csm1852843pjb.56.2024.01.26.18.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 18:54:06 -0800 (PST)
Message-ID: <4ae2a522-78c0-495a-8126-c58e6f24093d@linaro.org>
Date: Sat, 27 Jan 2024 12:53:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240125054631.78867-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240125054631.78867-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/24 15:46, Philippe Mathieu-Daudé wrote:
> Since v5:
> - Use v4 instead of v3...
> - Rebased on commit 53e8868d69
>    ("meson: remove OS definitions from config_targetos")
> 
> Ilya Leoshkevich (4):
>    accel/tcg: Make use of qemu_target_page_mask() in perf.c
>    tcg: Make tb_cflags() usable from target-agnostic code
>    accel/tcg: Remove #ifdef TARGET_I386 from perf.c
>    accel/tcg: Move perf and debuginfo support to tcg/

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

