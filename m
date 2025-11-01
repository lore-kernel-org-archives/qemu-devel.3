Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A3CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 11:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vF9Y0-0000I6-Jx; Sat, 01 Nov 2025 07:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9Xy-0000HC-IC
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:13:27 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vF9Xv-0005V7-W3
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 07:13:26 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-640a503fbe8so77942a12.1
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761995600; x=1762600400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eV8vdgw3enaRMai6uF/KG013iTjjLxBhEP/Odyd9p0w=;
 b=E43ZPM579KBU5scWISkfwz6/wb0kOcVSwrmKPomSk1d5QLQjbzqZuwA3l3QmDgy9ec
 ZfJFwzQNG0Crjr3Qd4rXPiFbibOi4vF8AXf6zoSOCweSQZrHfGSxkrpKqCk4so1Zytea
 qS6kl65vrqslWSEEZGw27nYSVVUPvDseqGeuW0PIOxJwLbRXAYNuRmu4INxdQfgNs/U+
 OmvNYbhYjvAG529ZAM+y9jSkIOPQLkPbWujsjd41pL1DJpEEiYQRbB/66A6GHNPjjcFC
 966kWKCVtoudTcNxcy5tJ3ZDVZCxcy1TwssEIGYHdB0SKNhlToIZ6Mxnsp3KcZx6XBPM
 Pk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761995600; x=1762600400;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eV8vdgw3enaRMai6uF/KG013iTjjLxBhEP/Odyd9p0w=;
 b=lXG2FgYKHlSp++brLApn7PjMNRnIfPEi07Yo0o+Y63HQx0/OZMD9EzbPY7YzLNYOTf
 xye5yuEFJe3idF2WVBFV//uLkxhbxjLDYS2EaEfTtH6taCVl2WV3KdAFRiRxL5BJ7xEx
 b+HgT606tohrAhxr8t0gjtGqUaD3qn9njI31VB/9eoInPqIdodO99IYDT8mz4BpMzXvn
 N3bsOzM4P8Nv/MzXaxssbeQ94Hxl8ocNqBqd7ZNqOFKV1mNLgbfiiKe9GKeeINTJwX6Y
 P37Ab03fPyw0Ov7+uSCqOKRk24nFvQGkBGWPOeQbcObM7eZWkkjwWviJC9AotxX2UyXv
 mq5A==
X-Gm-Message-State: AOJu0Ywt6SuuBoCK37jmi805iKaRPUut36c7QAI7tCB+oP68gEM7/uTm
 4lntzdHbp3KQAiOHOcpxIixW+q3Ot9ZH01h7/AvG9NIWBNMuOAxkMZ1aa6A5TDjq+PQSZ6jzY42
 nFnqT90s=
X-Gm-Gg: ASbGncvu72rXK23sYsxf/Y6RxaEIMbwx5+pp8B5RpJDyWohv1QxbTahULGFaWi75xcd
 PuORY12fH+AxhSwuLUGV/uOnBcfg97wFB/qkUHaN/lWhvezQ4vkcu0xrXRrSz77OvGFKBsw9qu2
 MESKEe2tEuu/2CMF+gkrBj6l/+K5wMZ2Q0/VaassqK8JbjOnmOCzcrEYJYZ0PvJJFFKHeXDBUVS
 QHRnvd5QWS87sRsCsX4kIfcxb4Zz9mvnaEVNYQ1BmJXa94YV7DRY3OsNyG21nJMu7GhwshQ9IiO
 n3hkNGucBvXlAiNjisTICUivwzt7a7Os1YhVAKazX2K3OnI1H9AXEa/s6jbFqtY8ScCGMXsPfaz
 ZMg4uF2RhNCwj8TcgTj0xOPDIeJgwn94n/leH1ze6byHROsLbMfq/oxl1L3DMhv4P6XMIT4FHAP
 MxkOK9ojOeTWwCuNoEid18YWi0TVT2jmbve42DRvQEUEeXxn9y+pk=
X-Google-Smtp-Source: AGHT+IEQ6a2+wiCqp9IjVynpHPInXfFdiqGDsLNNyjsaMlP6Wo3KNq1N9+owmQkI9NG+E/9tK5sOtg==
X-Received: by 2002:a17:907:968b:b0:b70:30c8:c35 with SMTP id
 a640c23a62f3a-b7070870ccbmr675492566b.62.1761995600252; 
 Sat, 01 Nov 2025 04:13:20 -0700 (PDT)
Received: from [10.240.88.227] (C3239BBB.static.ziggozakelijk.nl.
 [195.35.155.187]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6407b438536sm3961390a12.26.2025.11.01.04.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Nov 2025 04:13:19 -0700 (PDT)
Message-ID: <3246d988-c89a-426e-b2c6-2f086b2578f0@linaro.org>
Date: Sat, 1 Nov 2025 12:13:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Accelerators & CPU patches for Halloween 2025
To: qemu-devel@nongnu.org
References: <20251031211518.38503-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

On 10/31/25 22:15, Philippe Mathieu-Daudé wrote:
> The following changes since commit c494afbb7d552604ad26036127655c534a2645e5:
> 
>    Merge tag 'pull-nvme-20251030' of https://gitlab.com/birkelund/qemu into staging (2025-10-31 12:56:05 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-cpus-20251031
> 
> for you to fetch changes up to 0da6099730dbd44a6a96ad18774e5553d1ca7d21:
> 
>    rx: cpu: fix interrupts check in rx_cpu_do_interrupt() (2025-10-31 22:10:50 +0100)
> 
> Following checkpatch.pl error ignored:
> 
>    8/9 Checking commit 46f767bd6814 (tests/unit: add unit test for qemu_hexdump())
>    ERROR: unnecessary whitespace before a quoted newline
>    #59: FILE: tests/unit/test-cutils.c:3662:
>    +            "s is \n";
> 
>    total: 1 errors, 0 warnings, 56 lines checked
> 
> ----------------------------------------------------------------
> Generic CPUs / accelerators patch queue
> 
> - Access CPUState::thread_kicked atomically
> - Make async_safe_run_on_cpu() safe on HVF
> - Fix bql_locked status with condvar APIs
> - Document cpu_memory_rw_debug()
> - Rename init_clocks() -> qemu_init_clocks() to avoid name clashing
> - Fix QEMU_HEXDUMP_LINE_WIDTH logic
> - Fix interrupts check in rx_cpu_do_interrupt()
> ----------------------------------------------------------------

This has merge conflicts with Peter's target-arm queue.
Please rebase vs master and resend.


r~

