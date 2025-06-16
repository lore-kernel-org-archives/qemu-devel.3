Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A00BC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 08:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR57y-0002js-90; Mon, 16 Jun 2025 04:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR55y-0002Do-Eu
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:21:34 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR55w-0000sg-4H
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:21:34 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so2823198f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750062090; x=1750666890; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2v7A+U0GguZRsc2/YYGWktbw6iMfk/gfZedDJ/vBDrY=;
 b=mgh9aJ3ZP7J6S/QE5Waw6EGHJrGWl4nFUDGo++JSI3h9TsAhI8WYy1zYaJIOpFkOlB
 6hQNC4GAsB8qPL+8wfW/qmc0nBywzTrewPo6s7vQtGDfSesCezAhEYJKWb/C8bw8EWkh
 aDuUkRe2Q5Jy9/fvoEzog3oTwkVn33EEp+CWfut4oF7txbOkpdobKUBqfzk6+hv1Zth2
 wteviWcu418LwARdFUL4PogmOLtu2lQfsnhmqGYA19jrc7leZkeYtucQxyKbvYjnS5g/
 8O1zOQXQ9O83BLLGKGSyH2YbHVOAC7urzq/YsyVkblCI2Ul38eRO0sqxDGL/NKYxLKea
 wu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750062090; x=1750666890;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2v7A+U0GguZRsc2/YYGWktbw6iMfk/gfZedDJ/vBDrY=;
 b=tPhErivYUVCP2BhE0Vdy87cVBypclpwCMZ7ADT9l/IKcrsCwEXVDz2vsidxBCkI2E7
 /41p1zkHL3OUW3WUZRwOjDq6Gw6B471qozvYIpmvLZPdms/vKNCj0i2Z0N8k4cRcbsUS
 zt4KLq2Juxfab18EYc9CLdnSixEat2AcgDaGYBGZu2wQTDOHB60lsmuz33nUWg2zZiQ/
 XFXvVrn7o8fY+BDJROngHQ2F+qPlDT2k6+rfbHZLioCAu0dsGuJWJ7XlUj49YoQEXJOV
 QMXCTUvKoNmDmaOJvJuoe6gupsjZGrtJzKK3IJuizjcMQfRzh/CqKmwJYtZawO6iGGzs
 LNlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhCN1wjqrxASx0aVm8MVf6BWufumrGCr/24oDAVWJKZlHzUO3hB6wuzagFDEcJT3QDNbjhqkCg/2gd@nongnu.org
X-Gm-Message-State: AOJu0Yyx8YtLXNE8qnV1HkZHhR40W3nfCKx4ROpSwfTLdMuLFKg0cbzo
 F0axpHksmpCWztULNND8go+0zh0gFFd83QRcs8YxyHWlOacqHK09ZzhSXadUE3MK4JY=
X-Gm-Gg: ASbGncufi+OjQBOhjfbyioaY4lzKnEmC9CyHBHxZEvT4J9FVjjr8JcDciMcLBFSUnDS
 P4L+jS5z2/EpH0ZPkR0I/fTL/UWrf+pBuMSk4VMvXdxpBTWpn/wPnUlrpgtk4oqVfROwlhXJ+k7
 zmVVVNihtkVCf1szLcyP9OUMDAS25GIQg5qZ0dVKrUCYuIw+PUhymUrcYrffwKMFP7HzWIQ6/XZ
 3JSpVrzKI6uEHvNOpgUeusrWVw7KiQWOsA7lY3Gyk9+b/L/kcif028MvVypO13Yd1e1uSfnmXsu
 MJrYcaqHjolzrjSYAuB2AfK2/rLB6thIBGYnwFooTl8r9c2jlANjfW+NSEZybSpC0hRbMEgwot7
 Y52zmk6DgOJKNd943/Ai9fgdJtaTVv32d2l2jWwyx
X-Google-Smtp-Source: AGHT+IHl4rm2jvgL/HchZ3eiUsOPUesmnxaCqYdvnunRZZqShm3+fzRknHWNsMd1O/TSGZaGpQNp2A==
X-Received: by 2002:a05:6000:288a:b0:3a5:3a3b:6a3a with SMTP id
 ffacd0b85a97d-3a572e5856amr6806289f8f.54.1750062089688; 
 Mon, 16 Jun 2025 01:21:29 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e4asm135488375e9.11.2025.06.16.01.21.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 01:21:29 -0700 (PDT)
Message-ID: <9ec68c71-c53d-495f-b7ab-6061ea727dd0@linaro.org>
Date: Mon, 16 Jun 2025 10:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/19] system/cpus: Only kick running vCPUs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-3-philmd@linaro.org>
 <c9a8d923-0faf-46a4-962b-5a0f4289008f@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c9a8d923-0faf-46a4-962b-5a0f4289008f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 7/6/25 15:23, Richard Henderson wrote:
> On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
>> As an optimization, avoid kicking stopped vCPUs.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   system/cpus.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/system/cpus.c b/system/cpus.c
>> index d16b0dff989..4835e5ced48 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -494,6 +494,11 @@ void cpus_kick_thread(CPUState *cpu)
>>   void qemu_cpu_kick(CPUState *cpu)
>>   {
>>       qemu_cond_broadcast(cpu->halt_cond);
>> +
>> +    if (!cpu_can_run(cpu)) {
>> +        return;
>> +    }
>> +
> 
> This would appear to be a race condition.  The evaluation of cpu_can_run 
> should be done within the context of 'cpu', not here, and not *after* 
> we've already woken 'cpu' via the broadcast.

OK.

Still I don't understand something, when putting this assertion:

-- >8 --
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..0631015f754 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -493,7 +493,10 @@ void cpus_kick_thread(CPUState *cpu)

  void qemu_cpu_kick(CPUState *cpu)
  {
+    assert(cpu_can_run(cpu));
+
      qemu_cond_broadcast(cpu->halt_cond);
      if (cpus_accel->kick_vcpu_thread) {
          cpus_accel->kick_vcpu_thread(cpu);
      } else { /* default */
---

I get:

(lldb) bt
* thread #1, queue = 'com.apple.main-thread', stop reason = hit program 
assert
     frame #0: 0x000000018a669388 libsystem_kernel.dylib`__pthread_kill + 8
     frame #1: 0x000000018a6a288c libsystem_pthread.dylib`pthread_kill + 296
     frame #2: 0x000000018a5abc60 libsystem_c.dylib`abort + 124
     frame #3: 0x000000018a5aaeec libsystem_c.dylib`__assert_rtn + 284
   * frame #4: 0x000000010057ddc4 qemu_cpu_kick(cpu=0x0000000130218000) 
at cpus.c:496:5
     frame #5: 0x00000001000106ec 
queue_work_on_cpu(cpu=0x0000000130218000, wi=0x000060000038c000) at 
cpu-common.c:140:5
     frame #6: 0x0000000100010780 
async_run_on_cpu(cpu=0x0000000130218000, func=(tcg_commit_cpu at 
physmem.c:2758), data=(host_int = 60885632, host_ulong = 
105553177152128, host_ptr = 0x0000600003a10a80, target_ptr = 
105553177152128)) at cpu-common.c:177:5
     frame #7: 0x000000010059ad34 
tcg_commit(listener=0x0000600003a10a98) at physmem.c:2789:9
     frame #8: 0x0000000100591240 
listener_add_address_space(listener=0x0000600003a10a98, 
as=0x0000600003611980) at memory.c:3082:9
     frame #9: 0x0000000100590f48 
memory_listener_register(listener=0x0000600003a10a98, 
as=0x0000600003611980) at memory.c:3170:5
     frame #10: 0x000000010059abe4 
cpu_address_space_init(cpu=0x0000000130218000, asidx=0, 
prefix="cpu-memory", mr=0x000000012b1faba0) at physmem.c:813:9
     frame #11: 0x0000000100750c40 
arm_cpu_realizefn(dev=0x0000000130218000, errp=0x000000016fdfe2c0) at 
cpu.c:2572:5
     frame #12: 0x0000000100b7ed9c 
device_set_realized(obj=0x0000000130218000, value=true, 
errp=0x000000016fdfe388) at qdev.c:494:13
     frame #13: 0x0000000100b8a880 
property_set_bool(obj=0x0000000130218000, v=0x0000600003f12d00, 
name="realized", opaque=0x000060000010c1d0, errp=0x000000016fdfe388) at 
object.c:2375:5
     frame #14: 0x0000000100b87acc 
object_property_set(obj=0x0000000130218000, name="realized", 
v=0x0000600003f12d00, errp=0x000000016fdfe388) at object.c:1450:5
     frame #15: 0x0000000100b8f14c 
object_property_set_qobject(obj=0x0000000130218000, name="realized", 
value=0x0000600000386920, errp=0x0000000101e39e28) at qom-qobject.c:28:10
     frame #16: 0x0000000100b882f8 
object_property_set_bool(obj=0x0000000130218000, name="realized", 
value=true, errp=0x0000000101e39e28) at object.c:1520:15
     frame #17: 0x0000000100b7d240 qdev_realize(dev=0x0000000130218000, 
bus=0x0000000000000000, errp=0x0000000101e39e28) at qdev.c:276:12
     frame #18: 0x000000010083a81c 
machvirt_init(machine=0x000000012b1fa710) at virt.c:2329:9
     frame #19: 0x0000000100136a40 
machine_run_board_init(machine=0x000000012b1fa710, 
mem_path=0x0000000000000000, errp=0x000000016fdfe6a8) at machine.c:1669:5
     frame #20: 0x0000000100571384 qemu_init_board at vl.c:2714:5
     frame #21: 0x0000000100571154 
qmp_x_exit_preconfig(errp=0x0000000101e39e28) at vl.c:2808:5
     frame #22: 0x0000000100573a14 qemu_init(argc=17, 
argv=0x000000016fdff138) at vl.c:3844:9
     frame #23: 0x0000000100d036e0 main(argc=17, 
argv=0x000000016fdff138) at main.c:71:5
     frame #24: 0x000000018a302b98 dyld`start + 6076
(lldb)

I expect a vCPU to be in a "stable" state and usable *after* it is
realized, as we are calling various hooks in many places. Here we are
processing the pending work queue while the vCPU isn't fully realized,
so some hooks might not have been called yet...

Git history of tcg_commit() points to commit 0d58c660689 ("softmmu: Use
async_run_on_cpu in tcg_commit").
This isn't the first time I ends there, see also:
https://lore.kernel.org/qemu-devel/20230907161415.6102-1-philmd@linaro.org/. 
Using the same reasoning of this patch, adding:

-- >8 --
diff --git a/system/physmem.c b/system/physmem.c
index a8a9ca309ea..479a7a88037 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2773,6 +2774,14 @@ static void tcg_commit(MemoryListener *listener)
      cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
      cpu = cpuas->cpu;

+    if (!qdev_is_realized(DEVICE(cpu))) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
      /*
       * Defer changes to as->memory_dispatch until the cpu is quiescent.
       * Otherwise we race between (1) other cpu threads and (2) ongoing
---

makes my issues disappear; tcg_commit_cpu() calls are run on realized
vCPUs, and the order of pre-realize vcpu hooks doesn't alter anything.

I don't remember why I wrote this "The listener is also called during
realize, before all of the tcg machinery for run-on is initialized"
comment, it could be better to call memory_region_transaction_commit()
after CpuRealize, maybe in CpuReset.

