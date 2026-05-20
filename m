Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4316BCD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfWl-0004eX-Sx; Wed, 20 May 2026 07:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfWk-0004eH-RS
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:55:55 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPfWi-0001sZ-NX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:55:54 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso948881066b.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779278151; x=1779882951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LxaUfOS+TfS7IfFGurUcpQ92x4wDbk6S60wKF6vTQ1Q=;
 b=ZS21O1h1KZL0Tqe+qcls4KDxIJSJSFwdK56dWaSIUEv1EhWGYlRvgF65rCGvmjuvlh
 KNd631umVkevB7D2CooA0xDNQnQtEWZUuTQm89EUZBGHNDbihrwUczMH6TNpOgwKcLb0
 0T9VTU83r2qdS38MnMEwng1b/up/l6auvGzyU0KZHm14WWJBduk+/jon7j3cQz+ealxi
 7MOrkBveb7faOBAFC/JfyOk/c7HgAmfcmpksyYW54q+tX06BWDjcmiqKKZ/BSQvm+ikP
 bTDLHJjkmOabYp++oX6fguTILO3CUCjCAclhzD45z4BirIWcJ7WwVRhDcr2Xy2rWJCKb
 CH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779278151; x=1779882951;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxaUfOS+TfS7IfFGurUcpQ92x4wDbk6S60wKF6vTQ1Q=;
 b=dtNGzDBaXDz38sYqYbUVcSwkfRhdG862yOvzUdlq72ZmrJk8ZoyWYAgnSmvWKR2TNE
 00seX42Gt+CVyIdIuPtjsleYYxHkJPKuqqVgpMXFBhN0al5YegRVhOTJ4SFCNazBrUfH
 qWJ/jq8BMzzhNz8znqZzPQUbb8oLQklUF9I3ZsDxC7tvYMJfibzKyTktSnzqDbPbm+dX
 PLaZeVgwDIdU0kMVzbfbaDiyX/g8yWy2d1ILku3vAdGmEectei9BiYTVQXP+w+vlWO5Y
 gscxvZKf4s41+dEPtVzcQNz2D/xvggCU3DAUVA7rIWeTzNc0C/Nm8EzDDp+czJDFxFS1
 EQrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W8BfKoqJzrx0VxTZzFOBtft8kxC3Y/Rp1eGY6jRsHZ04516fr1t0iuC6GHFJnA7R0LQaFJ/SZ1/O4@nongnu.org
X-Gm-Message-State: AOJu0Yz+U3ht4tP3qhbqbZRT1TumX0Ge5XEoZ1VpOB6pgTyoSfDH/YE7
 lzIsSRY4gLQDzPJle/4DJUfezglI4kt8Qg0iiRy3Dh1/dhbM/ASbsP/4mKbtLb7b17AIhhHSBAG
 MEBqaqdw=
X-Gm-Gg: Acq92OFT6mzivfFACdPjGWSDkBg+YVOkK8MhACa/Ezj9YtjQSMMlQloo5ts5EZjIDDf
 /IxEe/pGfOmgGdkh+8ut2lhtQGrlm2SduQeVy6VF6MQZURkbrINnG25Sj2LcTLI2T5Y2I1XUjD8
 avxIemOLbjJ6n/XXWKJtTJ29+CQupaKxUKBE3L6Q37DI8hptUwphnnY1sCKtfKfok4qaryVgzx/
 bEzi29I5XJfys9vZxx3XWBUxy6P4IVYOQypzABQNhTKzHy9wwh6JqG/qFicYkgkgkBJOnBqAym7
 OPE3eJbYrbgZtz9Ykf9w5HCvvmsqslr8lNPd5nFMAtgocMCYMWrbsEESFrxEO4zGmaWnn2hTPNC
 aAtce/TBd9xjFz8BwVf9F3B7SssR20oi96mwpfdPHIY/uG3xsHwpyt5ZaiQkDnD9geJtZ4zZFHZ
 Zyt24wR1bFHNq+an1JJ1fkF504aadTuG90gNhMplCSLN0uWUS89lWDQygewgviL6HAux2jlrT0m
 q7EQH7XPg==
X-Received: by 2002:a05:600c:c10b:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-48fe60d55c4mr253848335e9.9.1779271244180; 
 Wed, 20 May 2026 03:00:44 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feaf14d22sm176410015e9.3.2026.05.20.03.00.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 03:00:43 -0700 (PDT)
Message-ID: <52b9ca7a-9ac2-4e0b-8394-3e1f167560e0@linaro.org>
Date: Wed, 20 May 2026 12:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/45] target/mips: add missing Octeon user-mode
 support
Content-Language: en-US
To: James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi James,

On 20/5/26 06:36, James Hilliard wrote:
> This series updates MIPS linux-user unaligned-access behavior and fills
> in missing Octeon user-mode instruction support used by existing Octeon
> binaries.
> 
> The first patches model the Linux/MIPS sysmips ABI pieces needed by
> linux-user, including MIPS_FLUSH_CACHE, MIPS_ATOMIC_SET, and the
> MIPS_FIXADE policy used to control unaligned scalar access fixups.
> User-mode unaligned scalar accesses default to software fixups and
> sysmips(MIPS_FIXADE) can toggle SIGBUS/BUS_ADRALN behavior.
> 
> Richard Henderson's v7.5 multiplier/QMAC rework is incorporated directly
> as nine patches: two TCG preparatory patches and seven Octeon
> multiplier/QMAC patches. The Octeon multiplier and QMAC translations now
> expand inline in TCG.
> 
> The remaining Octeon patches add integer, indexed memory, atomic, COP2
> crypto, CHORD, LLM, and CvmCount RDHWR support. The COP2 work is split
> into state, helper plumbing, per-engine helper patches, explicit
> selector decode, CHORD/LLM, and smoke-test coverage, with each
> functional block isolated. The series also adds a small
> mips64/mips64el TCG guest test covering representative Octeon integer,
> fixed-point, multiplier, RDHWR, and COP2 selector paths. The final patch
> corrects the Octeon68XX CP1 feature bits and FCR defaults.

Thanks for this series, I really appreciate your dedication and the
quality of your patches. I have been trying to queue it since v7 but
you keep respinning :) Since the first half is stable and reviewed,
I'll queue that first and send in my next MIPS pull request; less for
you to carry over.

Regards,

Phil.

> ---
> Changes in v10:
> - Split the explicit Octeon COP2 selector decode patch into register,
>    CRC/GFM, HSH/SHA3, stream-cipher, block-cipher, and CHORD/LLM
>    patches.
> - Added Philippe's Reviewed-by tag and local MemOp cleanup for ZCB/ZCBT.
> - Added Philippe's Tested-by tags for VMULU, VMM0, and Octeon68XX CP1.
> - Restored the original constant-fold output ordering in the TCG mul[us]2
>    optimization patch.
> - Kept Octeon COP2 crypto state architectural by dropping shared-mode and
>    AES, GFM, SHA3, ZUC, and SNOW3G shadow state.
> - Ordered Octeon COP2 crypto CPU state and VMState fields by architectural
>    selector groups.
> - Reworked GFM reflected helpers around the full 128-bit architectural state
>    and direct RESINP XOR operations.
> - Preserved the 64-bit UIA2 GFM reduction path used by SNOW3G F9.
> - Added Richard's Reviewed-by tag for the CRC COP2 helpers and masked
>    variable-length CRC writes to CRCLEN<3:0>.
> - Link to v9: https://lore.kernel.org/qemu-devel/20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com
> 
> Changes in v9:
> - Used MO_ATOM_NONE for the 128-bit ZCB/ZCBT zero stores.
> - Reused octeon_zero_partial_product_state() in the VMM0 translator.
> - Removed the shared MIPSOcteonCop2Sel enum from CPU state headers.
> - Replaced generic selector-dispatch COP2 helpers with per-operation
>    helper functions.
> - Split COP2 helper implementation into smaller functional subcategory
>    patches: plumbing, CRC, GFM, SHA3, ZUC, SNOW3G, AES, SMS4, 3DES/KASUMI,
>    Camellia, HSH, and CHORD/LLM.
> - Added COP2 helper declarations to helper.h alongside the per-engine
>    helper implementation commits.
> - Used signed 32-bit DMFC2 direct loads for 32-bit COP2 register
>    readback.
> - Documented the AESRESINP direct register-transfer handling in the translator.
> - Combined COP2 selector readback with QMAC/CvmCount smoke coverage.
> - Link to v8: https://lore.kernel.org/qemu-devel/20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com
> 
> Changes in v8:
> - Incorporated Richard Henderson's v7.5 9-patch multiplier/QMAC rework
>    directly into the stack rather than as a follow-up cleanup.
> - Added the two v7.5 TCG prep patches as standalone patches:
>    tcg_gen_addN_i64 and mul[us]2 zero/one optimization.
> - Replaced the helper-backed Octeon multiplier/QMAC sequence with the
>    seven v7.5-shaped patches: multiplier state, MTM, MTP, VMULU, VMM0,
>    V3MULU, and QMAC.
> - Split Octeon COP2 crypto core support into state/migration, helper
>    implementation, explicit selector decode, and selector readback test
>    patches.
> - Decoded Octeon COP2 selectors explicitly in decodetree and used direct
>    TCG loads/stores for simple COP2 register moves.
> - Kept COP2 helper calls for operation selectors and shared-window state
>    that require side effects.
> - Folded ZCB/ZCBT into one patch so the decodetree wildcard is
>    introduced in final form.
> - Added new Reviewed-by tags from Richard Henderson for MTM/MTP, LA*,
>    CvmCount, and QMAC/CvmCount test patches.
> - Link to v7: https://lore.kernel.org/qemu-devel/20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com
> 
> Changes in v7:
> - Rebased on current qemu.git staging (edcc429e9e).
> - Reordered the zero-register cleanup after the BADDU/DMUL destination fix
>    and moved the multiplier-state patch next to the MTM/MTP instruction
>    patches.
> - Applied Philippe's MIPS_FIXADE TB-flag readability tweak.
> - Used explicit MO_32/MO_64 MemOps for SAA/SAAD atomic transaction sizes.
> - Folded ZCB/ZCBT decode with a decodetree wildcard and zero the cache
>    block with 128-bit stores.
> - Added new Reviewed-by tags from Philippe Mathieu-Daudé and Richard
>    Henderson.
> - Link to v6: https://lore.kernel.org/qemu-devel/20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com
[...]

> ---
> James Hilliard (43):
>        linux-user/mips: implement sysmips(MIPS_FLUSH_CACHE)
>        linux-user/mips: implement sysmips(MIPS_ATOMIC_SET)
>        linux-user/mips, target/mips: honor MIPS_FIXADE for unaligned accesses
>        target/mips: fix Octeon arithmetic destination handling
>        target/mips: drop Octeon zero-register fast paths
>        target/mips: split Octeon SEQ/SNE decode
>        target/mips: add Octeon LBX instruction
>        target/mips: add Octeon LHUX instruction
>        target/mips: add Octeon LWUX instruction
>        target/mips: add Octeon SAA instruction
>        target/mips: add Octeon SAAD instruction
>        target/mips: add Octeon ZCB and ZCBT instructions
>        target/mips: add Octeon multiplier state
>        target/mips: add Octeon MTM instructions
>        target/mips: add Octeon MTP instructions
>        target/mips: add Octeon VMULU instruction
>        target/mips: add Octeon VMM0 instruction
>        target/mips: add Octeon V3MULU instruction
>        target/mips: add Octeon QMAC instructions
>        tests/tcg/mips: add Octeon instruction smoke test
>        target/mips: add Octeon LA* atomic instructions


>   23 files changed, 4431 insertions(+), 92 deletions(-)

