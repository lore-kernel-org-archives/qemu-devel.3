Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C800C0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 20:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc9Si-0008PC-Oe; Sun, 26 Jan 2025 15:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9SZ-0008OJ-1n
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:42:25 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc9SW-0002LK-Ex
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 15:42:22 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f13acbe29bso7457946a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 12:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737924137; x=1738528937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H48ko7PqBt1MRDsTfWIcWC8+CkMs626ufkIw2bc/5x8=;
 b=SKOd6Ex9KsJWDT43WE5EqCH1whm0Oy+ENZR48UQLYXqmhAoIrHNoUdwZsgBAZSMMve
 Fjeec16AT/AggA228Ra19z4lXOLDhNBxanS+kJhQRfCHCY2ncEes96HwuwGSv5yJMwVC
 ql/lZ3v/swZWDgREnuEUZYy2hPH9sl7+fMeRDMWS7/awDGCKJCni+2aXlPqh1BhKu9Zi
 ozCZgk9ps9202MFDlKNePhY6VfLTSST8qt4F9a3wZFrKhmnwOMy1fq2T1fR8ys094hNt
 pN9jeKUQEHmbsdhXuPi9FVhwSsuJPLsymlepvznewJuST01F2AQ1qAQuAEPoND+2MC65
 Mwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737924137; x=1738528937;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H48ko7PqBt1MRDsTfWIcWC8+CkMs626ufkIw2bc/5x8=;
 b=Yq5HhuO7RTTGHxQzuuSZSm+O/VOe5vHpQ1syCQvtTzLZOPllc/GU78pJnW/QZeUiF6
 B4YWTlxzY1j/bmyZIwHMYWihNg7t3mTS5WvSzyxGRQOKSkmY1Zpy05DFvGxNabviiEH1
 2vLtdi31m1HBIYdbz1+cUbSYNtGR2AvNc+hBcH9Iqcy6sPsCj9LhPufbWKPT+DKTE9Pr
 cEkdCdkWbZpXQ2wBKtaz57v9+w0fYYZBp+mf8cVOpzZnl3FhZvptaMAG1evg56/PCaGk
 TyIG6//Kz1EXj4FS8o/7wxpi9CTajlGYv4xm21Ijvb+adlt5LbNaUD0jQwxD8pPpAP+M
 N8Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdsFYyL/GZfkBsJ8jH5nTwmcTUbsZoVI0YRIQzkDm0eaZFS8ye1Aj/Wl9L6joUBmi8PF9WWXjxNYS9@nongnu.org
X-Gm-Message-State: AOJu0Yz7FeAE0Oo0Td3Hr3r9R/JmWdZvMC7Y+zJAZTHNv2ifHmbhAYRN
 yEsraEkEZpOzwGNSFw2IfDptGMH9k17i5d2w+aEySj/eQ0A6kPJZj2pmPPQcolQ=
X-Gm-Gg: ASbGncu1VmEN/4HNb1JEZPCTeNoswAKrVhiSCR/EJqiNhOhAFCtYrnOuCU7Afu5DJqh
 fzA8rYo6Oq3mQjpbh7XthHsCenPGBPvZBjYz84iA40iSqZP63MdJS6XeZHJGg4Ejz85Aclvtii8
 0MXgf+4f16e6KGIBtaduFslykkWfVFRiW0WPmA2aFTZFt0NkKPaRaZa0Z29bvJl5beydFZ4xgx6
 UWs82ecKWFLJMy/SMmhCuYFFB2eOGaT8SnYXPQvHcZTU78U7w0iIpUBkTxoGm0jYm40RvCxNtkA
 LO8zCIHrxBrlIqlt/K4xhc690g6u6vWdEUCYmmDcTvlFQtg=
X-Google-Smtp-Source: AGHT+IET1Hgf5DlFtTnLB6zbw3cCOrZlZ4h4Z0Ht47r+OhnvTjZQY9E5YHFS64waNnu9A7EWzAD+mw==
X-Received: by 2002:a05:6a00:2719:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-72f8adf4091mr15476076b3a.0.1737924137118; 
 Sun, 26 Jan 2025 12:42:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b3233sm5836919b3a.61.2025.01.26.12.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 12:42:16 -0800 (PST)
Message-ID: <fc81002d-b169-40f7-80e1-c93e55fadd30@linaro.org>
Date: Sun, 26 Jan 2025 12:42:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] accel: Forward-declare AccelOpsClass in
 'qemu/typedefs.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> The heavily imported "system/cpus.h" header includes "accel-ops.h"
> to get AccelOpsClass type declaration. Reduce headers pressure by
> forward declaring it in "qemu/typedefs.h", where we already
> declare the AccelCPUState type.
> 
> Reduce "system/cpus.h" inclusions by only including
> "system/accel-ops.h" when necessary.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/qemu/typedefs.h           | 1 +
>   include/system/accel-ops.h        | 1 -
>   include/system/cpus.h             | 2 --
>   accel/accel-system.c              | 1 +
>   accel/hvf/hvf-accel-ops.c         | 1 +
>   accel/kvm/kvm-accel-ops.c         | 1 +
>   accel/qtest/qtest.c               | 1 +
>   accel/tcg/cpu-exec-common.c       | 1 -
>   accel/tcg/cpu-exec.c              | 1 -
>   accel/tcg/monitor.c               | 1 -
>   accel/tcg/tcg-accel-ops.c         | 1 +
>   accel/tcg/translate-all.c         | 1 -
>   accel/xen/xen-all.c               | 1 +
>   cpu-common.c                      | 1 -
>   cpu-target.c                      | 1 +
>   gdbstub/system.c                  | 1 +
>   system/cpus.c                     | 1 +
>   target/i386/nvmm/nvmm-accel-ops.c | 1 +
>   target/i386/whpx/whpx-accel-ops.c | 1 +
>   19 files changed, 12 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

