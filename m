Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E14C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0uA-0007dl-4x; Mon, 19 May 2025 09:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uH0u8-0007dI-6E
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:51:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uH0u6-0000f0-6T
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:51:43 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a36e0d22c1so838626f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747662700; x=1748267500; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TaQ2adZzLMqgAPfaB0k5L5diWXv6nP9Kg5y/xe9TS+U=;
 b=sfyn0KYIfx/Fr+1mlDsRH3PLdmTAfo2cj9F1CGQCyKQDlRlebADYMxqZQkCOUvcw5p
 NVdDuBZo1GYxEkLzlAFpQBpl6GfyNndSiQ4Mrigu6Td5yt/rYBd/xMNyvpDccxEg0iEZ
 jzTMSR7UlrC3CpWwobmmG/m6ou8XeRVZhqBqVVa0V6gTx445ejNTDj1c6NKHxpDJlgyx
 zqy9sgkTYpXrdOd96uPxVRfpOS2ifcGxsXZzoFhmCRQE7WCWCfGhgSsbZoJs/SY5y4wg
 gg+XTRY/LOuFA9bnFenuI4dDdwO5d1P376RHJBNqpcpLP4gXAcyqNK7GsZCq5zETPEhi
 o7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747662700; x=1748267500;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaQ2adZzLMqgAPfaB0k5L5diWXv6nP9Kg5y/xe9TS+U=;
 b=fdh9oWASB3vv39I09UYxNkNQBo+49zBtOpmhP4kaDWG30wO4BEzbt29CJp56PEU9B7
 Cc/fudEGb4NMWD2NdylkqX6eG1D90JdMchq8oXuZVcD/Zzqylaoyd13bUejexuEknTNZ
 frBIX1QC6Ad+zZ4ps588GojQjIWMjmPqDuGpuVCM5O0Sx8viNPHFoGkZgzStjlEH++CY
 S1mdKBrWDpndUg4l0m2pMxe1Ov4HyoJgIqr/eLoqASQevMztuogDGm6yVe+Z1qTFd+Y/
 uErfrKFI9aren8Vrja215rKey7FE/M6shdP28WXPv2XdWHZzMpzqMuKryFK0fx63Q6HY
 ibrg==
X-Gm-Message-State: AOJu0YxLJq1CTKknFKwEKIwZ9Pvh7RF+DnPyoLNhbzucGeuMOQTi+K/s
 U+1nyhsggna6KCZlOe4dWWuYR8nXRYU1ugvXGBoxz8W4IAQyjOS3tbnOatjiFS5LAPQ=
X-Gm-Gg: ASbGncvs4aCCiYEtb/em2Z+SNN02XYyqdzSaD8rTDVMI0FeOXdeBXOM2GCPU9vMyPiI
 fUuDPCEugoYiad5u6kcNp/rqAjd/d8g5jHFHWwzON7DB4MHIVrwhOCcdizRIUUYOdViCqiWvSLw
 gZn80vkkbTm55LQ1i5g5QwsuBNrqOkwum7extBoXaoaSYrKsSiR9QzwQDoAYXur9CkTxVtpqG7P
 FC1fochFM88+FF3QcGRjq8erDRkxMvVr8B+wXivEtNppy3dZqrmRQfC+fYblxZSqsAXV/3DgdVC
 6BTRrE45UeekPhA8HG574v4/THB29iFRSKIeNnpkc8vMjUnHrhEd9MRv9J+0FojvuvO5ZSRm7/X
 TzXWn6CiYAPM9BaKD0+1wTtpEGPLHIi6Q
X-Google-Smtp-Source: AGHT+IHixjDlIaKX/rNTF9kdy/MW6o3IrRMxcjXy05kThsN7g3LFSK+Cmf4i91fIl7g1trLbcaJRCg==
X-Received: by 2002:a05:6000:40e0:b0:3a0:b733:f264 with SMTP id
 ffacd0b85a97d-3a35fe5ba7amr10520197f8f.11.1747662699884; 
 Mon, 19 May 2025 06:51:39 -0700 (PDT)
Received: from meli-email.org (adsl-99.109.242.93.tellas.gr. [109.242.93.99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f9053b4dsm168254925e9.4.2025.05.19.06.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 06:51:39 -0700 (PDT)
Date: Mon, 19 May 2025 16:45:21 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?=e <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH] gdbstub: update aarch64-core.xml
User-Agent: meli/0.8.12
References: <20250519-gdbstub-aarch64-pstate-xml-v1-1-b4dbe87fe7c6@linaro.org>
 <87msb8sqts.fsf@draig.linaro.org>
In-Reply-To: <87msb8sqts.fsf@draig.linaro.org>
Message-ID: <swih62.nwehumxno4zp@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, CTE_8BIT_MISMATCH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 19 May 2025 15:55, Alex Bennée <alex.bennee@linaro.org> wrote:
>Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
>> Update aarch64-core.xml to include field definitions for PSTATE, which
>> in gdb is modelled in the cpsr (current program status register)
>> pseudo-register, named after the actual cpsr register in armv7.
>>
>> Defining the fields layout of the register allows easy inspection of for
>> example, the current exception level (EL):
>>
>> For example. Before booting a Linux guest, EL=2, but after booting and
>> Ctrl-C'ing in gdb, we get EL=0:
>>
>>   (gdb) info registers $cpsr
>>   cpsr           0x20402009          [ SP EL=2 BTYPE=0 PAN C ]
>>   (gdb) cont
>>   Continuing.
>>   ^C
>>   Thread 2 received signal SIGINT, Interrupt.
>>   0x0000ffffaaff286c in ?? ()
>>   (gdb) info registers $cpsr
>>   cpsr           0x20001000          [ EL=0 BTYPE=0 SSBS C ]
>>
>> The aarch64-core.xml has been updated to match exactly the version
>> retrieved from upstream gdb, retrieved in 2025-05-19 from HEAD commit
>> 9f4dc0b137c86f6ff2098cb1ab69442c69d6023d.
>>
>> https://sourceware.org/git/?p=binutils-gdb.git;a=tree;h=9f4dc0b137c86f6ff2098cb1ab69442c69d6023d
>>
>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>
>Queued to gdbstub/next, thanks.
>

Would patches for the field system registers (NZCV, CurrentEL, DAIF, 
SPSel) be acceptable?

If yes, I think defining them in the static core xml is cleaner than 
generating them dynamically in "system-registers.xml" like we do with 
arm_gen_dynamic_sysreg_feature() but both can work. The drawback would 
be that we wouldn't match upstream gdb's core xml schema anymore. (Maybe 
we  can add a new xml include "pstate.xml" instead)

