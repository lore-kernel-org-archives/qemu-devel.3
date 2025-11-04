Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F0CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 17:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGKhJ-0005lG-Rm; Tue, 04 Nov 2025 12:19:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKhA-0005eR-3H
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:19:52 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGKh1-00006g-Kl
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:19:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-640e9a53ff6so1918802a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 09:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762276778; x=1762881578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwUp2ZMe1TEIIv4KhcautXniKKRQYzPFp1wYKrxtKjM=;
 b=VzRhNWmeHKp8M8DwxOAiCJvvHz9Dy+EIhA/5hT/Wr9nzyj2td2kqDCNROqqc7fcN4O
 DN0rG3tIVvM/3AySnZwiy8heWHly3ctbdDasmCSzgEUBENamo8cVZQOsyjr4Sv9r6jvY
 KELf/Gp8bXiS5STtzb/wBb/wWuy9s0N32PJ9+hLwIGXojaO+A37BH0ki1nkAx1Jcdqy1
 Ce3eClFffHvW4albtWtca6TBnZCDfpIUH17YvwuJRrxlEo9hIjXkVjGoySvjUBvuKCSe
 YrQPWEnN/QJNv/sNI9rn15iEJN4gc7fd4Uvhk8S7QNnVVyPi4kXD3jzgx9dUmmZeIZjt
 Cndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762276778; x=1762881578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwUp2ZMe1TEIIv4KhcautXniKKRQYzPFp1wYKrxtKjM=;
 b=ahKeG+LFPcw28e7eb5b+jP5Gd8AKOtK7lH2K88SIeQrTXuJOTW+icHWJVoNuJQZkgG
 I55sod7w4PNKYHh1Ns44OQY17/5boH/y8rlMUp5nLnnz9KlUvm/VJRk/WzBTd5jIehnA
 f4WRq9OlPim05jY+pp1+3b33sAmG1IOyEScq2EMWem2CAKtSb2w/+HWIBUe+ulNqVuvh
 Y2va47S6p+O0MjZZPSOcoLSDkQxw/6js3vIcILUBx6IXEtHNHkeFXl99W2mxEQ17irBI
 tpoikpKeSEmdjm8ENm6lgKKGJszhPiBWJ1aFbMD+YWJR9avludCeJHVh0R015Q9Pr8cW
 vwOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoXXeMSIePAOIR8Tm5MHNTxpxBWIGwQHjkp0f2uYPB8QwsUsDV9Vooku7zei9QL9YnsD29oYUoFNFo@nongnu.org
X-Gm-Message-State: AOJu0Yw7RqsX2TkkFUEeVuUHoGiFTc0vPQFhb99Yj0RKoEo/1GafuXgQ
 7s8j5DoHB5wkH6jJf7G1tZDii10NRnVYav9rdylnQP7VDYxGCFIyzR/f5cZhcvXhnxs=
X-Gm-Gg: ASbGncveti9HZw9SOfuxUBHBwGhyDBHpoVx6k58t9JeAotQTG2clBI/YeUqCR6+5uLN
 0xLGtW3NtJH5L/F1eIxyhgHghl4CyS04NvrVMhE3VM4tCvAKA0iTIwcFzC889eBtONhyZ/NZMKX
 Cs4qb4H9uOZRO+a3bNfJWGaNuHPQEvdCVAYM6MTNqXVd5hemQSXio4gca4SkygCVSfOhimeJ06V
 R/fJ/aSP9rOVdVwTpKWHmpfRCvuIWBg2liiaQcJevi92bBrT8DW8LHvdsJQssbgdljnre43nDuz
 6C7qaTyBFcDLPMXtUFdXHcEUCyS6AzMLqUqbiphUJmTYdLkO5qi8CxICkEsxGxD0PgfGjB1l77p
 c6MmjyziaoXHcfssC9PDFMRSlezvZlXnk67B3mxuC13Uh1q2bJeRM8V7J3C01dgwln+NhS4Dpay
 4A1PFBR4UjaHPQrJpAazE=
X-Google-Smtp-Source: AGHT+IEY6xM9Hqizzs/kVBXbt+teH0skvVWBn0VHaQN1hVm18BFmURhYWFWFY5+nH5FgXi9m47SaXQ==
X-Received: by 2002:a17:907:3e16:b0:b6d:8557:19a with SMTP id
 a640c23a62f3a-b70704c3e8amr2027914266b.30.1762276777989; 
 Tue, 04 Nov 2025 09:19:37 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723f6e06edsm271530066b.47.2025.11.04.09.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 09:19:37 -0800 (PST)
Message-ID: <41caf11f-8f6a-40cf-8292-e7200a028d20@linaro.org>
Date: Tue, 4 Nov 2025 18:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/microvm: Use fdt field from MachineState
Content-Language: en-US
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251030-fix_microvm-v1-1-f89544a04be3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 30/10/25 15:32, Luigi Leonardi wrote:
> MachineState already provides an fdt field, remove it from
> MicrovmMachineState and use that instead.
> 
> This is useful when using the `dumpdtb` option, as QEMU expects the
> device tree to be stored in the MachineState struct, othwise it will
> return this error:
> 
> qemu-system-x86_64: This machine doesn't have an FDT
> 
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
> `fdt` field is already available in `MachineState` but
> `MicrovmMachineState` uses its own.
> 
> This prevents the "dumpdtb" option from working.
> ---
>   hw/i386/microvm-dt.c      | 96 +++++++++++++++++++++++++----------------------
>   include/hw/i386/microvm.h |  2 -
>   2 files changed, 52 insertions(+), 46 deletions(-)

Queued (typo fixed), thanks!

