Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294E8C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQKL-0005td-BU; Fri, 08 Aug 2025 12:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQKH-0005sg-EM
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:52:18 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQKE-0007P1-H8
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:52:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bdea88e12so2269578b3a.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754671930; x=1755276730; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gD8VDHiXC6O1QhiTrZvgU8TUrWttzrd06dV+8VVw1aA=;
 b=McOIt+IFo+XeWjmbZ/Qee1Dj9TWcYAw/U2NUpoUarVk1CtGkzP5xc/w6P8LMjrkJtA
 xYMNYpXLLZEzgRANC2ZrPuWYqFGQAj/e01MmXqRFuXaSS+h/XgZ3hgUQI/VzwaErXXt4
 zOHv1z+WPkR6UXJHddkJUYieRxdTHsN6AFfKnvN1pxkt1Zrzpfb6e7U24C1xUYA1bPTl
 muZebMXXo9TIFDvFOtxWD2LCxfv9Itsh6DbyMbGihMDjp0L112UMnm3axlRjgchm244M
 tHU74M/akujH2m0wni63rCs38gkSeOS0enMt9xT2Sp70W2nQFiBjbXmF57iLF6LNyk9z
 NGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671930; x=1755276730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gD8VDHiXC6O1QhiTrZvgU8TUrWttzrd06dV+8VVw1aA=;
 b=g6J/k1hOASM4BpUsZGYX4o25wX2Eaaryq9rjUId77OzyXzZt9l6Iq2tnoOp5I699IN
 yo2Rd9Uef2FnAyNK1o0ad4S2dlzhf4aaqXrAHCRvNYbFC3rQPhLs82G9cBYplZVNpegG
 2YJqHa75RlXQf4z6PW8wMlo7uJRXzo97R8XO/OF69lj+IAP40W6Vr9q6nINJOOhAAzkO
 HwrTsCVdtxo/UO6R/uNIjC1hUksY0AMAl+wTWiZXN9KQuuHT72D8+Rze09x6k7PpNvmc
 naLA+dLcgpHlUKkd6kSLOCVdBWCXDKhUqLtO8GT8m0PBKuQhh4sIUqldO9rRUb+aqZ4R
 vsJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcYIC1X+PE7xrpqCPdk3/8XXkYeJj2CYj1kxWkOKQeoFL9pecePsMo19Wo5aQZxiK4PQaCxiPNJflh@nongnu.org
X-Gm-Message-State: AOJu0Yz1OfVKxGHjek4i0Hcsr6vf+mOeEd+2vOIe2LWGuaUrIOD0afiz
 58zJMqEswFsBMuhqEISCz9tbqzr2s3ymRp8JPHmhd7r+oWeEQAGFzTKalmGpla/wEqM=
X-Gm-Gg: ASbGncslmCTdXZ3uNzkP8mjycAmC2pnPZSbl0HRJI/EatRx1+c1N94N4qVBeHXsmXQG
 LJnIr/aL254sn0okRi1lqoMZShyZxcLIQ4QSSGvaUzZkLhB6hy71oW8IcXca7wd5vZjbZo2/XBU
 huujxhlq7BrCaY7pNY6fV8VVxDZ+Xmix4VIu2slh/dKYNeasyN91wDwDZSxvFJbc328RBZb+sb8
 fXG/G5pen0KhZXugN6PDQEpFeCUz9jEXOnu/NFBQEfRJKPXVbd09ReAyYpGh+rE2Xu5QrKk2QMz
 V74I6Kc+nILZ3+Kg1alWt84KlEsPtbFWC1PXEckDYWsUWKqbWqoYVjYbpmDc/KUisEnHfvBE6NW
 nIvwWlZ7RsuVdDtmrCyGNM4mBWiMz6R4oMWY=
X-Google-Smtp-Source: AGHT+IGiEuFQJsL6DqwPy/4s+qzAsn2v7sd25VWwktiKfh0mA3t/mP1O0MXKXkLdijYbPOmTUekjQw==
X-Received: by 2002:a05:6a00:b44:b0:746:2ae9:fc42 with SMTP id
 d2e1a72fcca58-76c461784fcmr5746130b3a.19.1754671930159; 
 Fri, 08 Aug 2025 09:52:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfbcea9sm20908232b3a.61.2025.08.08.09.52.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:52:09 -0700 (PDT)
Message-ID: <db63fc94-72e0-4af4-976b-291860b69056@linaro.org>
Date: Fri, 8 Aug 2025 09:52:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] contrib/plugins/uftrace: implement x64 support
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>, Gustavo Romero
 <gustavo.romero@linaro.org>, =?UTF-8?Q?Alex_Benn_=C3=A9_e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
 <20250808020702.410109-8-pierrick.bouvier@linaro.org>
 <t0o5pl.3rum11rfv1tyj@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o5pl.3rum11rfv1tyj@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 8/8/25 2:42 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:07, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> It's trivial to implement x64 support, as it's the same stack layout
>> than aarch64.
> 
> s/than/as
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 85 +++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 85 insertions(+)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 6628b4256fd..f10172eed10 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -79,6 +79,20 @@ typedef struct {
>>      struct qemu_plugin_register *reg_scr_el3;
>> } Aarch64Cpu;
>>
>> +typedef enum {
>> +    X64_RING0,
>> +    X64_RING1,
>> +    X64_RING2,
>> +    X64_RING3,
>> +    X64_REAL_MODE,
>> +} X64PrivilegeLevel;
>> +
>> +typedef struct {
>> +    struct qemu_plugin_register *reg_rbp;
>> +    struct qemu_plugin_register *reg_cs;
>> +    struct qemu_plugin_register *reg_cr0;
>> +} X64Cpu;
>> +
>> typedef struct {
>>      uint64_t timestamp;
>>      uint64_t data;
>> @@ -565,6 +579,75 @@ static CpuOps aarch64_ops = {
>>      .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
>> };
>>
>> +static uint8_t x64_num_privilege_levels(void)
>> +{
>> +    return X64_REAL_MODE + 1;
>> +}
>> +
>> +static const char *x64_get_privilege_level_name(uint8_t pl)
>> +{
>> +    switch (pl) {
>> +    case X64_RING0: return "Ring0";
>> +    case X64_RING1: return "Ring1";
>> +    case X64_RING2: return "Ring2";
>> +    case X64_RING3: return "Ring3";
>> +    case X64_REAL_MODE: return "RealMode";
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static uint8_t x64_get_privilege_level(Cpu *cpu_)
>> +{
>> +    X64Cpu *cpu = cpu_->arch;
>> +    uint64_t cr0 = cpu_read_register64(cpu_, cpu->reg_cr0);
>> +    uint64_t protected_mode = (cr0 >> 0) & 0b1;
>> +    if (!protected_mode) {
>> +        return X64_REAL_MODE;
>> +    }
>> +    uint32_t cs = cpu_read_register32(cpu_, cpu->reg_cs);
>> +    uint32_t ring_level = (cs >> 0) & 0b11;
>> +    return ring_level;
>> +}
>> +
>> +static uint64_t x64_get_frame_pointer(Cpu *cpu_)
>> +{
>> +    X64Cpu *cpu = cpu_->arch;
>> +    return cpu_read_register64(cpu_, cpu->reg_rbp);
>> +}
>> +
>> +static void x64_init(Cpu *cpu_)
>> +{
>> +    X64Cpu *cpu = g_new0(X64Cpu, 1);
>> +    cpu_->arch = cpu;
>> +    cpu->reg_rbp = plugin_find_register("rbp");
>> +    g_assert(cpu->reg_rbp);
>> +    cpu->reg_cs = plugin_find_register("cs");
>> +    g_assert(cpu->reg_cs);
>> +    cpu->reg_cr0 = plugin_find_register("cr0");
>> +    g_assert(cpu->reg_cr0);
>> +}
>> +
>> +static void x64_end(Cpu *cpu)
>> +{
>> +    g_free(cpu->arch);
>> +}
>> +
>> +static bool x64_does_insn_modify_frame_pointer(const char *disas)
>> +{
>> +    return strstr(disas, "rbp");
>> +}
>> +
>> +static CpuOps x64_ops = {
>> +    .init = x64_init,
>> +    .end = x64_end,
>> +    .get_frame_pointer = x64_get_frame_pointer,
>> +    .get_privilege_level = x64_get_privilege_level,
>> +    .num_privilege_levels = x64_num_privilege_levels,
>> +    .get_privilege_level_name = x64_get_privilege_level_name,
>> +    .does_insn_modify_frame_pointer = x64_does_insn_modify_frame_pointer,
>> +};
>> +
>> static void track_privilege_change(unsigned int cpu_index, void *udata)
>> {
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>> @@ -771,6 +854,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>
>>      if (!strcmp(info->target_name, "aarch64")) {
>>          arch_ops = aarch64_ops;
>> +    } else if (!strcmp(info->target_name, "x86_64")) {
>> +        arch_ops = x64_ops;
>>      } else {
>>          fprintf(stderr, "plugin uftrace: %s target is not supported\n",
>>                  info->target_name);
>> -- 
>> 2.47.2
>>
> 
> No idea about x86 assembly tbh but this looks correct to me.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Funny enough, I tried to implement that for risv64 also, just to realize 
the utter mess this architecture did with frame pointer, hiding it on 
the other side of the stack frame.
Thus, it's not possible to easily walk frame pointers on this arch, and 
you need to disassemble prologue to find how big your stack frame is. 
It's crazy architects didn't learn their lesson from the past issues on 
other arch regarding frame pointers.

