Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BB5C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 16:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukQB7-0004kR-4q; Fri, 08 Aug 2025 12:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQB5-0004cg-LC
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:42:48 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukQB3-0005n0-Lm
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 12:42:47 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4233978326so1394655a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754671363; x=1755276163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GNqhsonCqSY8wdF35cZCe00iEQV0iNppvWOHeaqNqR4=;
 b=orDoCw1R/mITnbAhJvA/WylviRXusnjFdrRfREbTzTk/l7x/B9wq21MjF99ek76CVM
 RimvMI4LD7jJ6LM7Szgu9C5cj3QnSkHOtQzs5JN2hQyDUlhQsr9MDyJShkCpgq1wX7dI
 G47YbBBckRqjLOmsXEivi2uivj4vm8kkeRknJesm4//Rphj7z3tGSfuBVR+ZfC/PK/ZJ
 7dkAEjN2M/WaCjrr6kMGch6qgdkU8fvUw9jBwVhqcxTL315ERWNPBORuagwOWZe2Ja1u
 SGktSwC5kMW63t1T2L9yI5Xumw7nVODaGN5oohA/GsAdeIauByW0msBNdWaNXpdz03Aa
 RJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754671363; x=1755276163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GNqhsonCqSY8wdF35cZCe00iEQV0iNppvWOHeaqNqR4=;
 b=DsYINVNSQpFXukSHnUPQOFi+UhPl/j4zvUGGYFHMg3P1DbI7u4LtSeL4DgchvIcwM5
 DRYWlC5it5hXMdlSMd+a6bMvTO0/aJwOesChBdwk8xsgxQgAUmnfg5HQEA3VzHhe11qv
 8qE4NyznV+CU5yxPVbbH/4MgFgXTNwMecMgDRsVj3Kx+Gz7WAOWVjzosyFyjVlaYKdEk
 n+5MX5hQsIqiCW0jtzX+sxikR3yFZqLLWeq//7FxS1Af7I5SC+GXRmBEYFFr6PTu6fuD
 bsoiKmYuS77Hdhr72aIi88gtUqdhGGqrdWbXGqcDQDOPCAywPVMcCNE18EmxyLWASjeq
 qFLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAB2gAFlgeDA8KHxiiJqpkI005JSBIbGGRex0hdNfH7/s1JvmfQX9loSRwQ8jfw0nXfG5+WzgeFUaK@nongnu.org
X-Gm-Message-State: AOJu0Yw5YaTGUavf8WbeEN71gavbRVFjsBC3LsriuWUtacjzWrAaKsmg
 J/nXTvo0sHvB6lKYm/e13T0nkAXERExdL2ATSuS6Ont0VpJF/zvHS1vVzlGrlXVgE3U=
X-Gm-Gg: ASbGncvgekRwYNbgdH9o1Xj4eZPEC7AkJgYO6jyf+Gd6tq5GP8gvK013DIA5SqsXFFM
 zRO75RbHy8d4khKh878pKYiyS4LDvE11nr0SZewvB5ze3QKv+JOnylkoylyA7QVjfSLfDrxnPRN
 A/l0fiAstGvTgkhYBBTrtOpsl8c/xw/33Us9w41FV2C5tynXDA3GHINhX8MymLHogvoUef+o/Cg
 BHFEt39CeJHqSsy2Tq+/wed+yId+7DsjWkR3/uAxMZBc/3apKcSurEG1gCav5QWeXGkPUXh3v4m
 MwfA/SNy0Iav5Uih+gRzjpTkVkYqUE1FPGHmVIzjaoc/NFRYehmtamTwbEmEj647kIS2oMtU3qm
 B2Rn5FvuhylrchNaLDkt0Ws0xEkaJaM7fQTU=
X-Google-Smtp-Source: AGHT+IEhwGL+7UUVrVRwhY50a0BEsn3PxPfEfl0OVIe42LRmTPD12OE4HfgVZe9rAYRdJ1dpOPqzOg==
X-Received: by 2002:a17:90a:dfc4:b0:31e:ff94:3fa6 with SMTP id
 98e67ed59e1d1-321839bc66amr5279520a91.1.1754671362852; 
 Fri, 08 Aug 2025 09:42:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32102a42b65sm11842034a91.1.2025.08.08.09.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 09:42:42 -0700 (PDT)
Message-ID: <aea479d3-159b-4dc0-a326-48448c8038f4@linaro.org>
Date: Fri, 8 Aug 2025 09:42:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] contrib/plugins/uftrace: generate additional files
 for uftrace
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
 <20250808020702.410109-7-pierrick.bouvier@linaro.org>
 <t0o5mm.2toq6tk2xu35q@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <t0o5mm.2toq6tk2xu35q@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/8/25 2:37 AM, Manos Pitsidianakis wrote:
> On Fri, 08 Aug 2025 05:06, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>> Beyond traces per cpu, uftrace expect to find some specific files.
>> - info: contains information about machine/program run
>>   those values are not impacting uftrace behaviour, and we simply copied
>>   a random example to keep things simple.
>> - memory mapping: how every binary is mapped in memory. For system mode,
>>   we generate an empty mapping (uftrace_symbols.py, coming in future
>>   commit, will take care of that). For user mode, we copy current
>>   /proc/self/maps. We don't need to do any special filtering, as
>>   reported addresses will necessarily concern guest program, and not
>>   QEMU and its libraries.
>> - task: list of tasks. We present every vcpu/privilege level as a
>>   separate process, as it's the best view we can have when generating a
>>   (visual) chrome trace. Using threads is less convenient in terms of
>>   UI.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> contrib/plugins/uftrace.c | 130 +++++++++++++++++++++++++++++++++++++-
>> 1 file changed, 129 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
>> index 7737626da2f..6628b4256fd 100644
>> --- a/contrib/plugins/uftrace.c
>> +++ b/contrib/plugins/uftrace.c
>> @@ -115,6 +115,126 @@ static uint64_t gettime_ns(void)
>>      return now_ns;
>> }
>>
>> +static void uftrace_write_map(bool system_emulation)
>> +{
>> +    const char *path = "./uftrace.data/sid-0.map";
>> +
>> +    if (system_emulation && access(path, F_OK) == 0) {
>> +        /* do not erase existing map in system emulation, as a custom one might
>> +         * already have been generated by uftrace_symbols.py */
>> +        return;
>> +    }
>> +
>> +    FILE *sid_map = fopen(path, "w");
>> +    g_assert(sid_map);
>> +
>> +    if (system_emulation) {
>> +        fprintf(sid_map,
>> +                "# map stack on highest address possible, to prevent uftrace\n"
>> +                "# from considering any kernel address\n");
>> +        fprintf(sid_map,
>> +          "ffffffffffff-ffffffffffff rw-p 00000000 00:00 0 [stack]\n");
>> +    } else {
>> +        /* in user mode, copy /proc/self/maps instead */
>> +        FILE *self_map = fopen("/proc/self/maps", "r");
>> +        g_assert(self_map);
>> +        for (;;) {
>> +            int c = fgetc(self_map);
>> +            if (c == EOF) {
>> +                break;
>> +            }
>> +            fputc(c, sid_map);
>> +        }
>> +        fclose(self_map);
>> +    }
>> +    fclose(sid_map);
>> +}
>> +
>> +static void uftrace_write_task(const GArray *traces)
>> +{
>> +    FILE *task = fopen("./uftrace.data/task.txt", "w");
>> +    g_assert(task);
>> +    for (int i = 0; i < traces->len; ++i) {
>> +        Trace *t = g_array_index(traces, Trace*, i);
>> +        fprintf(task, "SESS timestamp=0.0 pid=%"PRIu32" sid=0 exename=\"%s\"\n",
>> +                t->id, t->name->str);
>> +        fprintf(task, "TASK timestamp=0.0 tid=%"PRIu32" pid=%"PRIu32"\n",
>> +                t->id, t->id);
>> +    }
>> +    fclose(task);
>> +}
>> +
>> +static void uftrace_write_info(const GArray *traces)
>> +{
>> +    g_autoptr(GString) taskinfo_tids = g_string_new("taskinfo:tids=");
>> +    for (int i = 0; i < traces->len; ++i) {
>> +        Trace *t = g_array_index(traces, Trace*, i);
>> +        const char *delim = i > 0 ? "," : "";
>> +        g_string_append_printf(taskinfo_tids, "%s%"PRIu32, delim, t->id);
>> +    }
>> +
>> +    g_autoptr(GString) taskinfo_nr_tid = g_string_new("taskinfo:nr_tid=");
>> +    g_string_append_printf(taskinfo_nr_tid, "%d", traces->len);
>> +
>> +    FILE *info = fopen("./uftrace.data/info", "w");
>> +    g_assert(info);
>> +    /*
>> +     * $ uftrace dump --debug
>> +     * uftrace file header: magic         = 4674726163652100
>> +     * uftrace file header: version       = 4
>> +     * uftrace file header: header size   = 40
>> +     * uftrace file header: endian        = 1 (little)
>> +     * uftrace file header: class          = 2 (64 bit)
>> +     * uftrace file header: features      = 0x1263 (PLTHOOK | ...
>> +     * uftrace file header: info          = 0x7bff (EXE_NAME | ...
>> +     *  <0000000000000000>: 46 74 72 61 63 65 21 00  04 00 00 00 28 00 01 02
>> +     *  <0000000000000010>: 63 12 00 00 00 00 00 00  ff 7b 00 00 00 00 00 00
>> +     *  <0000000000000020>: 00 04 00 00 00 00 00 00
>> +     */
>> +    const uint8_t header[] = {0x46, 0x74, 0x72, 0x61, 0x63, 0x65, 0x21, 0x00,
>> +                              0x04, 0x00, 0x00, 0x00, 0x28, 0x00, 0x01, 0x02,
>> +                              0x63, 0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +                              0xff, 0x7b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> +                              0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
>> +    fwrite(header, sizeof(header), 1, info);
>> +    const char *info_data[] = {
>> +        "exename:from_qemu",
>> +        "build_id:0123456789abcdef0123456789abcdef01234567",
>> +        "exit_status:0",
>> +        "cmdline:uftrace record qemu",
>> +        "cpuinfo:lines=2",
>> +        "cpuinfo:nr_cpus=1 / 1 (online/possible)",
>> +        "cpuinfo:desc=Intel 8086",
> 
> Haha what :D

I'm happy at least one person got the joke.

> 
>> +        "meminfo:1.0 / 1.0 GB (free / total)",
>> +        "osinfo:lines=3",
>> +        "osinfo:kernel=Linux 6.12.33",
>> +        "osinfo:hostname=pc",
>> +        "osinfo:distro=\"Debian GNU/Linux 13 (trixie)\"",
> 
> So I assume these strings can be anything, why not make them blank?
>

That's a good idea. I will see how uftrace reacts to this.

>> +        "taskinfo:lines=2",
>> +        taskinfo_nr_tid->str,
>> +        taskinfo_tids->str,
>> +        "usageinfo:lines=6",
>> +        "usageinfo:systime=0.000000",
>> +        "usageinfo:usrtime=0.000000",
>> +        "usageinfo:ctxsw=0 / 0 (voluntary / involuntary)",
>> +        "usageinfo:maxrss=8016",
>> +        "usageinfo:pagefault=0 / 0 (major / minor)",
>> +        "usageinfo:iops=0 / 0 (read / write)",
>> +        "loadinfo:0.0 / 0.0 / 0.0",
>> +        "record_date:Mon Jan  1 00:00:00 2025",
>> +        "elapsed_time:1000000000000.0 sec",
>> +        "pattern_type:regex",
>> +        "uftrace_version:v0.17 ( x86_64 dwarf python3 luajit tui perf sched dynamic kernel )",
>> +        "utc_offset:1751552954",
>> +        0};
>> +    const char **info_data_it = info_data;
>> +    while (*(info_data_it)) {
>> +        fprintf(info, "%s\n", *info_data_it);
>> +        ++info_data_it;
>> +    }
>> +    fclose(info);
>> +}
>> +
>> static Callstack *callstack_new(void)
>> {
>>      Callstack *cs = g_new0(Callstack, 1);
>> @@ -607,14 +727,22 @@ static void vcpu_end(unsigned int vcpu_index)
>>
>> static void at_exit(qemu_plugin_id_t id, void *data)
>> {
>> +    bool system_emulation = (bool) data;
>> +    g_autoptr(GArray) traces = g_array_new(0, 0, sizeof(Trace *));
>> +
>>      for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>>          Cpu *cpu = qemu_plugin_scoreboard_find(score, i);
>>          for (size_t j = 0; j < cpu->traces->len; ++j) {
>>              Trace *t = g_array_index(cpu->traces, Trace*, j);
>>              trace_flush(t, true);
>> +            g_array_append_val(traces, t);
>>          }
>>      }
>>
>> +    uftrace_write_map(system_emulation);
>> +    uftrace_write_info(traces);
>> +    uftrace_write_task(traces);
>> +
>>      for (size_t i = 0; i < qemu_plugin_num_vcpus(); ++i) {
>>          vcpu_end(i);
>>      }
>> @@ -651,7 +779,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>
>>      score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init);
>> -    qemu_plugin_register_atexit_cb(id, at_exit, NULL);
>> +    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
>>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
>>
>>      return 0;
>> -- 
>> 2.47.2
>>
> 
> LGTM,
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


