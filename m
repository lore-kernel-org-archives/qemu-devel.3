Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FDDC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQ9x-0001ZP-MC; Fri, 08 Aug 2025 12:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ9v-0001RQ-5Q
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:41:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQ9s-0005hE-Vd
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:41:34 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so3276825b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754671291; x=1755276091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2AP18oms0+gfIebZmjvI+Hh0EWb5d9FFNLmMttz27HY=;
 b=wtCrrryUOPL101FM+TUIqenMMfQ0pAt/YIfm24U/hrEYtQRHT4U+AvxC0Dem/BVFUt
 r9EtNA+ixkvpmOLHwan8URYQC1nS8m8yTOvsDSsnJDOUKEi5+gWyKOKmBWW2T+1DzDVM
 9oLHYgh7F4JEyKG9X4HdTsDyLzlsX+X7xhpTINj7wsvizbM+7DxxjRpPPggAr+QT18bB
 WPsWdqbYA9UiIt6pWVdJu5lYo7A82gEEu0B0FYKimLs0M6aaTrJxO2tU0eHA8CrNugib
 hxfSg7rIPQzugBtPuQptAQxc5r/7aL+BRltpPV8PQ7Q7+VrYbMWA1L9QTnl1IBs1LB9M
 FpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671291; x=1755276091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2AP18oms0+gfIebZmjvI+Hh0EWb5d9FFNLmMttz27HY=;
 b=gH06wD+igKaI5NECqpwuKjrD2CUu+yZVpAkpzZ3yiImFNi4ICZwQCJfJeTzV3iA9mD
 kVjsooefkQLr/GAt+j8oILtz31jpq8EhkEiJOdBJY1V9Mx7RfVAKOCKiNKzj6IHfhZS1
 qN/c0XuM+z/+koCHQgLLd5Iq1ZBM34qjL6EpzWNGSkJwpXDUQbLB/zEVuShrEbZqrQnM
 O8KqEThqn1ikqCOYXrikVnmuKbn7Y1pwg/dTw/gjQv+qIFz6YxPBGML6X518uXE5Q6d/
 YHjIKjaEavNWH5dXXXNFgy7SQs8e6jYW3G7WmE+0e0FZ8x+yA3pW8Q+c3ZrqvUJZj19X
 YU2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3JQfUtsFaMJGyxNEkw/HKhEcF9mIDD8ZLDhBzlEfihYUQsu+C9edGSphaCXLKiITsWApFcgNqd2iB@nongnu.org
X-Gm-Message-State: AOJu0YzXdslbOWVJUpcJr1zTmgwqVYkaFsa2aqArPfJzrMnxKBwfMtv3
 OIohztdGs325JXeoVwkbDKMOcXo2p8KiP/KkrRzEJDl8EiViID1WDwSKnbouVIsdDlsee3pjoAG
 ae+mUuW/Ukw==
X-Gm-Gg: ASbGncv4Ojn/pYvePwVFWrV1axgfjHBNtysXAtMj21JioxxMaHFJY2Zm0WttCXCDlyE
 9gJ0XmmrIgFaPq80CMfYVFwNY8Zqrepvhf9K033mTivLY80koMelPSd4Ur3bOB/lkX8Sn5RkEXT
 QjFOuVkpOZ6LGuUGXHtTw80FvDO58KVUpvPsPsfC+ppqc7hv9YDml8tZTggXx5ljj5uOgTXUK3R
 EinSDfOpZcesHpTZuoHJDXN8ukNNdlFIEJUGEePcvPvgG+Pwe/EO5U2djWUbGUjEISg/3f5d+f9
 PkTQYA5Cfj2etrs4/AtV9pvWU8XNezQgsEpc5FGDJHNIODVsRVbKwiL7lJbXyQYtOImCUbSCrKn
 PAjKxixpshfXyKG5waOWIMZC4bAk8lm3Gm4A=
X-Google-Smtp-Source: AGHT+IHqwjgqfJrt4bbDoubqv8rvnMeYLcnKCYg/fh8eAbzXgq/geoozovrHFYBPmkQaFBh6FjFA3g==
X-Received: by 2002:a05:6a20:72a1:b0:23f:fd87:427c with SMTP id
 adf61e73a8af0-24055046f59mr6427407637.18.1754671291159; 
 Fri, 08 Aug 2025 09:41:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bf8f12c95sm14378553b3a.2.2025.08.08.09.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:41:30 -0700 (PDT)
Message-ID: <938809d2-8dfa-4ed1-a481-3d20324f593f@linaro.org>
Date: Fri, 8 Aug 2025 09:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] contrib/plugins/uftrace: implement privilege level
 tracing
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
 <20250808020702.410109-6-pierrick.bouvier@linaro.org>
 <t0o5db.32mzh34kom9qm@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o5db.32mzh34kom9qm@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/8/25 2:26 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> We add new option trace-privilege-level=bool, which will create a
>> separate trace for each privilege level.
>> This allows to follow changes of privilege during execution.
>>
>> We implement aarch64 operations to track current privilege level
>> accordingly.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 189 ++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 181 insertions(+), 8 deletions(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 402a242433e..7737626da2f 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -44,19 +44,39 @@ typedef struct {
>>      void (*init)(Cpu *cpu);
>>      void (*end)(Cpu *cpu);
>>      uint64_t (*get_frame_pointer)(Cpu *cpu);
>> +    uint8_t (*get_privilege_level)(Cpu *cpu);
>> +    uint8_t (*num_privilege_levels)(void);
>> +    const char *(*get_privilege_level_name)(uint8_t pl);
>>      bool (*does_insn_modify_frame_pointer)(const char *disas);
>> } CpuOps;
>>
>> typedef struct Cpu {
>>      Trace *trace;
>>      Callstack *cs;
>> +    uint8_t privilege_level;
>> +    GArray *traces; /* Trace *traces [] */
>>      GByteArray *buf;
>>      CpuOps ops;
>>      void *arch;
>> } Cpu;
>>
>> +typedef enum {
>> +    AARCH64_EL0_SECURE,
>> +    AARCH64_EL0_NONSECURE,
>> +    AARCH64_EL0_REALM,
>> +    AARCH64_EL1_SECURE,
>> +    AARCH64_EL1_NONSECURE,
>> +    AARCH64_EL1_REALM,
>> +    AARCH64_EL2_SECURE,
>> +    AARCH64_EL2_NONSECURE,
>> +    AARCH64_EL2_REALM,
>> +    AARCH64_EL3,
>> +} Aarch64PrivilegeLevel;
>> +
>> typedef struct {
>>      struct qemu_plugin_register *reg_fp;
>> +    struct qemu_plugin_register *reg_cpsr;
>> +    struct qemu_plugin_register *reg_scr_el3;
>> } Aarch64Cpu;
>>
>> typedef struct {
>> @@ -72,6 +92,7 @@ typedef enum {
>> } UftraceRecordType;
>>
>> static struct qemu_plugin_scoreboard *score;
>> +static bool trace_privilege_level;
>> static CpuOps arch_ops;
>>
>> static uint64_t gettime_ns(void)
>> @@ -248,6 +269,16 @@ static uint64_t cpu_read_register64(Cpu *cpu, struct qemu_plugin_register *reg)
>>      return *((uint64_t *) buf->data);
>> }
>>
>> +static uint32_t cpu_read_register32(Cpu *cpu, struct qemu_plugin_register *reg)
>> +{
>> +    GByteArray *buf = cpu->buf;
>> +    g_byte_array_set_size(buf, 0);
>> +    size_t sz = qemu_plugin_read_register(reg, buf);
>> +    g_assert(sz == 4);
>> +    g_assert(buf->len == 4);
>> +    return *((uint32_t *) buf->data);
>> +}
>> +
>> static uint64_t cpu_read_memory64(Cpu *cpu, uint64_t addr)
>> {
>>      g_assert(addr);
>> @@ -305,6 +336,68 @@ static struct qemu_plugin_register *plugin_find_register(const char *name)
>>      return NULL;
>> }
>>
>> +static uint8_t aarch64_num_privilege_levels(void)
>> +{
>> +    return AARCH64_EL3 + 1;
> 
> Nit: A common idiom is defining an _MAX enum variant that always stays
> on the bottom of the enum definition and equals the max value, thus
> ensuring you always refer to the correct maximum variant. Though I'd be
> surprised if they ever add an EL4 :^)
>

I hesitated, so your nit is a good hint I should do it this way to not 
surprise the reader.

>> +}
>> +
>> +static const char *aarch64_get_privilege_level_name(uint8_t pl)
>> +{
>> +    switch (pl) {
>> +    case AARCH64_EL0_SECURE: return "S-EL0";
>> +    case AARCH64_EL0_NONSECURE: return "NS-EL0";
>> +    case AARCH64_EL0_REALM: return "R-EL0";
>> +    case AARCH64_EL1_SECURE: return "S-EL1";
>> +    case AARCH64_EL1_NONSECURE: return "NS-EL1";
>> +    case AARCH64_EL1_REALM: return "R-EL1";
>> +    case AARCH64_EL2_SECURE: return "S-EL2";
>> +    case AARCH64_EL2_NONSECURE: return "NS-EL2";
>> +    case AARCH64_EL2_REALM: return "R-EL2";
>> +    case AARCH64_EL3: return "EL3";
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static uint8_t aarch64_get_privilege_level(Cpu *cpu_)
>> +{
>> +    Aarch64Cpu *cpu = cpu_->arch;
>> +    /*
>> +     * QEMU gdbstub does not provide access to CurrentEL,
> 
> We should fix that... I wanted to do that for a while.
> 
>> +     * so we use CPSR instead.
>> +     */
>> +    uint8_t el = cpu_read_register32(cpu_, cpu->reg_cpsr) >> 2 & 0b11;
>> +
>> +    if (el == 3) {
>> +        return AARCH64_EL3;
>> +    }
>> +
>> +    uint8_t ss = AARCH64_EL0_SECURE;
>> +    if (!cpu->reg_scr_el3) {
>> +        ss = AARCH64_EL0_NONSECURE;
>> +    }
>> +    uint64_t scr_el3 = cpu_read_register64(cpu_, cpu->reg_scr_el3);
>> +    uint64_t ns = (scr_el3 >> 0) & 0b1;
>> +    uint64_t nse = (scr_el3 >> 62) & 0b1;
>> +    switch (nse << 1 | ns) {
>> +    case 0b00:
>> +        ss = AARCH64_EL0_SECURE;
>> +        break;
>> +    case 0b01:
>> +        ss = AARCH64_EL0_NONSECURE;
>> +        break;
>> +    case 0b11:
>> +        ss = AARCH64_EL0_REALM;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    const uint8_t num_ss = 3;
>> +    Aarch64PrivilegeLevel pl = el * num_ss + ss;
> 
> That's a bit blunt but I understand where you're coming from
> 
>> +    return pl;
>> +}
>> +
>> static uint64_t aarch64_get_frame_pointer(Cpu *cpu_)
>> {
>>      Aarch64Cpu *cpu = cpu_->arch;
>> @@ -321,6 +414,10 @@ static void aarch64_init(Cpu *cpu_)
>>                          "available. Please use an AArch64 cpu (or -cpu max).\n");
>>          g_abort();
>>      }
>> +    cpu->reg_cpsr = plugin_find_register("cpsr");
>> +    g_assert(cpu->reg_cpsr);
>> +    cpu->reg_scr_el3 = plugin_find_register("SCR_EL3");
>> +    /* scr_el3 is optional */
>> }
>>
>> static void aarch64_end(Cpu *cpu)
>> @@ -342,9 +439,34 @@ static CpuOps aarch64_ops = {
>>      .init = aarch64_init,
>>      .end = aarch64_end,
>>      .get_frame_pointer = aarch64_get_frame_pointer,
>> +    .get_privilege_level = aarch64_get_privilege_level,
>> +    .num_privilege_levels = aarch64_num_privilege_levels,
>> +    .get_privilege_level_name = aarch64_get_privilege_level_name,
>>      .does_insn_modify_frame_pointer = aarch64_does_insn_modify_frame_pointer,
>> };
>>
>> +static void track_privilege_change(unsigned int cpu_index, void *udata)
>> +{
>> +    Cpu *cpu = qemu_plugin_scoreboard_find(score, cpu_index);
>> +    uint8_t new_pl = cpu->ops.get_privilege_level(cpu);
>> +
>> +    if (new_pl == cpu->privilege_level) {
>> +        return;
>> +    }
>> +
>> +    uint64_t pc = (uintptr_t) udata;
>> +    uint64_t timestamp = gettime_ns();
>> +
>> +    trace_exit_stack(cpu->trace, cpu->cs, timestamp);
>> +    callstack_clear(cpu->cs);
>> +
>> +    cpu->privilege_level = new_pl;
>> +    cpu->trace = g_array_index(cpu->traces, Trace*, new_pl);
>> +
>> +    cpu_unwind_stack(cpu, cpu->ops.get_frame_pointer(cpu), pc);
>> +    trace_enter_stack(cpu->trace, cpu->cs, timestamp);
>> +}
>> +
>> static void track_callstack(unsigned int cpu_index, void *udata)
>> {
>>      uint64_t pc = (uintptr_t) udata;
>> @@ -397,6 +519,13 @@ static void track_callstack(unsigned int cpu_index, void *udata)
>> static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>> {
>>      size_t n_insns = qemu_plugin_tb_n_insns(tb);
>> +    uintptr_t tb_pc = qemu_plugin_tb_vaddr(tb);
>> +
>> +    if (trace_privilege_level) {
>> +        qemu_plugin_register_vcpu_tb_exec_cb(tb, track_privilege_change,
>> +                                             QEMU_PLUGIN_CB_R_REGS,
>> +                                             (void *) tb_pc);
>> +    }
>>
>>      /*
>>       * We instrument all instructions following one that might have updated
>> @@ -429,18 +558,36 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>>
>>      cpu->ops.init(cpu);
>>      cpu->buf = g_byte_array_new();
>> +    cpu->traces = g_array_new(0, 0, sizeof(Trace *));
>>
>>      g_assert(vcpu_index < UINT32_MAX / 100);
>> -    /* trace_id is: cpu_number * 100 */
>> +    g_assert(cpu->ops.num_privilege_levels() < 100);
>> +    /* trace_id is: cpu_number * 100 + privilege_level */
>>      uint32_t trace_id = (vcpu_index + 1) * 100;
>>
>> -    g_autoptr(GString) trace_name = g_string_new(NULL);
>> -    g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>> -    cpu->trace = trace_new(trace_id, trace_name);
>> -    /* create/truncate trace file */
>> -    trace_flush(cpu->trace, false);
>> +    if (trace_privilege_level) {
>> +        for (uint8_t pl = 0; pl < cpu->ops.num_privilege_levels(); ++pl) {
>> +            g_autoptr(GString) trace_name = g_string_new(NULL);
>> +            g_string_append_printf(trace_name, "cpu%u %s", vcpu_index,
>> +                                   cpu->ops.get_privilege_level_name(pl));
>> +            Trace *t = trace_new(trace_id + pl, trace_name);
>> +            g_array_append_val(cpu->traces, t);
>> +        }
>> +    } else {
>> +        g_autoptr(GString) trace_name = g_string_new(NULL);
>> +        g_string_append_printf(trace_name, "cpu%u", vcpu_index);
>> +        Trace *t = trace_new(trace_id, trace_name);
>> +        g_array_append_val(cpu->traces, t);
>> +    }
>> +
>> +    for (size_t i = 0; i < cpu->traces->len; ++i) {
>> +        /* create/truncate trace files */
>> +        Trace *t = g_array_index(cpu->traces, Trace*, i);
>> +        trace_flush(t, false);
>> +    }
>>
>>      cpu->cs = callstack_new();
>> +    cpu->trace = g_array_index(cpu->traces, Trace*, cpu->privilege_level);
>> }
>>
>> static void vcpu_end(unsigned int vcpu_index)
>> @@ -448,7 +595,12 @@ static void vcpu_end(unsigned int vcpu_index)
>>      Cpu *cpu = qemu_plugin_scoreboard_find(score, vcpu_index);
>>      g_byte_array_free(cpu->buf, true);
>>
>> -    trace_free(cpu->trace);
>> +    for (size_t i = 0; i < cpu->traces->len; ++i) {
>> +        Trace *t = g_array_index(cpu->traces, Trace*, i);
>> +        trace_free(t);
>> +    }
>> +
>> +    g_array_free(cpu->traces, true);
>>      callstack_free(cpu->cs);
>>      memset(cpu, 0, sizeof(Cpu));
>> }
>> @@ -457,7 +609,13 @@ static void at_exit(qemu_plugin_id_t id, void *data)
>> {
>>      for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>>          Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>> -        trace_flush(cpu->trace, true);
>> +        for (size_t j = 0; j < cpu->traces->len; ++j) {
>> +            Trace *t = g_array_index(cpu->traces, Trace*, j);
>> +            trace_flush(t, true);
>> +        }
>> +    }
>> +
>> +    for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>>          vcpu_end(i);
>>      }
>>
>> @@ -468,6 +626,21 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                                             const qemu_info_t *info,
>>                                             int argc, char **argv)
>> {
>> +    for (int i = 0; i < argc; i++) {
>> +        char *opt = argv[i];
>> +        g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
>> +        if (g_strcmp0(tokens[0], "trace-privilege-level") == 0) {
>> +            if (!qemu_plugin_bool_parse(tokens[0], tokens[1],
>> +                                        &trace_privilege_level)) {
>> +                fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
>> +                return -1;
>> +            }
>> +        } else {
>> +            fprintf(stderr, "option parsing failed: %s\n", opt);
>> +            return -1;
>> +        }
>> +    }
>> +
>>      if (!strcmp(info->target_name, "aarch64")) {
>>          arch_ops = aarch64_ops;
>>      } else {
>> -- 
>> 2.47.2
>>
> 
> LGTM,
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


