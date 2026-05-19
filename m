Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5DDCD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 22:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPT2D-0004dQ-FH; Tue, 19 May 2026 18:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPT23-0004S0-18
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:35:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPT21-0005gq-68
 for qemu-devel@nongnu.org; Tue, 19 May 2026 18:35:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c8095d7d75bso1571629a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779230119; x=1779834919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=76V8q+sPARnH8z7EYeVZOZi1mA6iPRwVYRtwTAi8hdc=;
 b=g/+21SRwDebpI3PsGGT2U78e6uRTXyBWwthjsx6lHynSWCZHVRKCSbCSqM5wBz8iHs
 CFRnyKgJuIduN7kBfnhqtlqKmywDIudlkc/8HC11HAC7t/EUut58femFl2/Za3jwgy/Y
 9pT1ahAFi6V2HrSdH2+tRZBIpoV3UY5zQPDlHGDec5R8wkRWPs2Q0mt8YKkNkvKpl/gv
 PGaAQypYImOMoG/KWTEipMfEJGvVsF2AtTXKTPSvwNKUsIRPaQSkmxqrixvIHR8FdnaK
 Nl/6SHEtuYj82y9/Sj0clxpSPPGhVh0RYVtbBP0aYSSPdxrSy1qsCz6Fz5Hg34N/XkJR
 755g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779230119; x=1779834919;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=76V8q+sPARnH8z7EYeVZOZi1mA6iPRwVYRtwTAi8hdc=;
 b=qAS9GUPhuXXCRfuCVZUIpyDnfQzyp1Cvir+SQlRxQUoPBOPfWny03uduc9oCeAr6xw
 kp30mg1EgX3QGgqiw7J4Z/LSszlv8RfgB7pQIWlLBKfxikAWxsPJfQ5ljVFwfo4QtmcY
 kOUS+/Bkia/raL/BfZtg0atdkSV5uh5dtAZBGOLyaCpaE8ZpIHKT067nmaQA1265Gt6V
 IrNdXq5pF7q/AenVcSK5cgAbyzvRuSn0CqNzfLhckCKNwKR1xqMNVrdvRopg3Ep3L4IN
 kfFHAzxrWwpmMeAwq7N/GvccaNgrHyCMKHBYtTL3kmrZi/0XfxFYARGLicMAYqvTiJsH
 7p1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QnBNh7A9aa3h+5Ft8B7xToFTn2blYAX3Q9v7BmarbiUorgid/GoGfizLaia7VaOvTHE8/wtbrd15q@nongnu.org
X-Gm-Message-State: AOJu0Ywaj0HYY3aP0jbMoRWD8zWVxiwYtJSgPLQjg2YScM6Gz7Z1oJSh
 n11aHmrc8JAG4on3mpaIB1TiLGvZWaSQBU4LlnS+xUdFZq03qZNdUNIuIrkOTBze4SA=
X-Gm-Gg: Acq92OGiAEQ6AD5zIOYMu68eIRX0uz+WGm6P1FUROIwF86XPpcbC1hltouBzwvRe2KX
 03kgUCj7lxnYNS9XZIM8AVNvxeLXU6rOOclmRYNAvrqKZ2sTw2Vm0DSxqjw2yeQ7gjVRveiM2Lj
 zrrDnrDZFy84PozTWx8y0lvoI8F3tegrjbfhmMcMZmzyNL393XwmZma31BCAIrD005q84CHO8Oc
 2vg5HtQK3Bi5fjNkgPXqPmRzpQbMOrvMA82Cx4TTmWIHw8dpUk1nSKu+D0MIOIu5atE+kv5FixI
 0pFwVWW4MJaKgCWdtliA3g0x+iw50aWx/W1M2jx6/3L3uASBbxEH2MelNJVhtRrVLY+UpYgZMWh
 w7u7++DAtFi/g9ACcvpAR3e8TlA22tAmEteNq0DT5AdrdUdU7xf3I3N9Car86P96RWvakWnkTkX
 FNHuVmhJRNz+v/iZ/yroKVpYjbR1cvNYtI9VAgrlC1UvPVLGs=
X-Received: by 2002:a17:902:f788:b0:2bc:f1ef:2e64 with SMTP id
 d9443c01a7336-2bd7e7d683amr245158895ad.12.1779230119257; 
 Tue, 19 May 2026 15:35:19 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5d11b495sm205752095ad.69.2026.05.19.15.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 15:35:18 -0700 (PDT)
Message-ID: <32e435ed-4487-445a-86eb-91c6cb6fa78e@linaro.org>
Date: Tue, 19 May 2026 15:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/40] tcg: Introduce tcg_gen_addN_i64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
 <20260519-mips-octeon-missing-insns-v2-v9-13-d7dd735ecddd@gmail.com>
 <46d5ad2c-4a76-46fa-80cc-e2a33b9fa923@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <46d5ad2c-4a76-46fa-80cc-e2a33b9fa923@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

On 5/19/26 13:52, Philippe Mathieu-Daudé wrote:
> On 19/5/26 18:22, James Hilliard wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>>
>> Add a helper for multi-limb 64-bit addition. The helper emits native
>> carry-chain TCG ops when they are available and falls back to explicit
>> carry propagation otherwise.
>>
>> This lets target translators build wider integer accumulators inline
>> without open-coding the same add-with-carry sequence at each use site.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> ---
>> Changes v7 -> v8:
>>    - New patch from Richard Henderson's v7.5 multiplier rework.
>> ---
>>   include/tcg/tcg-op-common.h |  1 +
>>   tcg/tcg-op.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
> 
> Richard, could we squash something like this?
> 
> -- >8 --
> diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
> index fd3a50bf4c4..1ac53a61114 100644
> --- a/docs/devel/tcg-ops.rst
> +++ b/docs/devel/tcg-ops.rst
> @@ -672,6 +672,12 @@ Multiword arithmetic support
>          | If mulu2/muls2 are not provided by the backend, the tcg-op generator
>            can obtain the same results by emitting a pair of opcodes, mul + muluh/mulsh.
> 
> +   * - addN *n*, *t0*, *t1*, *t2*
> +
> +     - | For each *n*, compute *t0* = *t1* + *t2* + *C*,
> +         where *C* is the input carry bit provided by the host
> +         architecture, and also compute the output carry bit.
> +         Overlap between *t0* and *t1*/*t2* arrays is not allowed.

No, because there's no addN *opcode*.  You're raising an old issue: there's no separate 
documentation for the tcg_gen_* interface.  Also, the text is inaccurate.

r~

