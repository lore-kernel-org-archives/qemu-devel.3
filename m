Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279C1CD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLOb-0007Ii-RK; Tue, 19 May 2026 10:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPLOY-0007I8-SY
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:26:07 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wPLOV-0003VN-Mx
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:26:06 -0400
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 64JEPn4f044511
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 19 May 2026 23:25:49 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5sYx9LwuiYz0Oow4cXAOgFLJo9xG1GY/swU3s7WbMdo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1779200749; v=1;
 b=EMKOFmDq5yboGsvPa14JPwNvlASbJoJNVhfyX8JxD3YSZn3Pw0lxBWoNLvlB9hMS
 J7c1kJXR9IpZm1xhD0NOgt6xBiDuE0Pd7u+sDboD0xGuRvABedXryQ9gUVyO4EfL
 SiAPrcLCBRKlv+GoGW7QJFD7H0qfXk5X3K4mzzpXkqVztnwEYJ9iDntMDS16TIwB
 H9XlXDZwZ7nec6JcoYa4PBl5jCBoRgbRERgvD2zF6H8wKD95ucGBtYgqQzFUqqrH
 nXHF4rMaj7I+KQZrIlqzftbkvZjLTdFv2g756XWi0b2tmmbyfkezac64y5QCe4wc
 b2//1ZdMCpU4tgltPs86FA==
Message-ID: <acd5ae7c-e104-4270-9b97-a0efb5b706aa@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 19 May 2026 23:25:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] virtio-gpu: Do not wait for the main thread during
 reset
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260424-gpu-v2-0-9fd2fc0dd1bd@rsg.ci.i.u-tokyo.ac.jp>
 <87mrxwcxzd.fsf@draig.linaro.org>
 <aeeb9f81-3dd8-4fea-83ae-7d88ec1be971@rsg.ci.i.u-tokyo.ac.jp>
 <87h5o3bmp5.fsf@draig.linaro.org> <878q9fbmap.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <878q9fbmap.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/05/19 21:45, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>
>>> On 2026/05/19 4:35, Alex Bennée wrote:
>>>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>>>
>>>>> This fixes a deadlock I previously observed with the test in [1].
>>>>>
>>>>> However, I can no longer reproduce the issue reliably with that test, so
>>>>> I used Codex, a coding agent, to write a more reliable local test case,
>>>>> shown below. I applied to Codex for Open Source to get access. The test
>>>>> case is not intended for merge: current policy prohibits that, and it is
>>>>> probably not worth carrying anyway because race-condition tests are
>>>>> inherently fragile.
>>>> What sort of hit rate where you getting with the race? So far they
>>>> have
>>>> both been rock solid without the additional patches for me.
>>>
>>> I hit the deadlock in 8 out of 10 trials.
>>
>> It's taking a lot longer on my system (~ 1 in 100) but with these
>> patches I'm still seeing a hang, it just takes a lot longer to get
>> there.
> 
> tsan shows:
> 
> [INFO] mapping blob object resource
> [INFO] resource_map_blob response is CtrlHeader { hdr_type: Command(4358), flags: 0, fence_id: 0, ctx_id: 0, _padding: 0 }
> [INFO] unmapping blob object resource
> ==================
> WARNING: ThreadSanitizer: data race (pid=3564641)
>    Write of size 8 at 0x55c8ce6d4250 by thread T1 (mutexes: write M0, write M1):
>      #0 qemu_ram_free <null> (qemu-system-aarch64+0x98f863) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #1 memory_region_destructor_ram <null> (qemu-system-aarch64+0x977046) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #2 memory_region_finalize <null> (qemu-system-aarch64+0x9830e5) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #3 object_unref <null> (qemu-system-aarch64+0xfa741c) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #4 object_finalize_child_property <null> (qemu-system-aarch64+0xfa765f) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #5 object_unref <null> (qemu-system-aarch64+0xfa73d6) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #6 flatview_destroy <null> (qemu-system-aarch64+0x978e7d) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #7 call_rcu_thread <null> (qemu-system-aarch64+0x122e268) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #8 qemu_thread_start <null> (qemu-system-aarch64+0x121cc8d) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>                                                                                                                                                                                
>    Previous atomic read of size 8 at 0x55c8ce6d4250 by thread T7:
>      #0 qemu_ram_block_from_host <null> (qemu-system-aarch64+0x98fabb) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #1 qemu_ram_addr_from_host_nofail <null> (qemu-system-aarch64+0x98ff16) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #2 get_page_addr_code_hostp <null> (qemu-system-aarch64+0x4bbd0b) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #3 tb_htable_lookup <null> (qemu-system-aarch64+0x49f7bc) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #4 cpu_exec_loop <null> (qemu-system-aarch64+0x4a08a5) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #5 cpu_exec_setjmp <null> (qemu-system-aarch64+0x4a112b) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #6 cpu_exec <null> (qemu-system-aarch64+0x4a1b74) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #7 tcg_cpu_exec <null> (qemu-system-aarch64+0x4cb92b) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #8 mttcg_cpu_thread_fn <null> (qemu-system-aarch64+0x4cbe81) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #9 do_st2_mmu <null> (qemu-system-aarch64+0x4ba389) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #10 helper_stw_mmu <null> (qemu-system-aarch64+0x4bc571) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #11 <null> <null> (0x7f936faabdb2)
>      #12 cpu_exec_loop <null> (qemu-system-aarch64+0x4a04fc) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #13 cpu_exec_setjmp <null> (qemu-system-aarch64+0x4a112b) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #14 cpu_loop_exit_noexc <null> (qemu-system-aarch64+0x4a2242) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #15 cpu_io_recompile <null> (qemu-system-aarch64+0x4b0a9b) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #16 do_ld_mmio_beN <null> (qemu-system-aarch64+0x4b47c9) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #17 do_ld2_mmu <null> (qemu-system-aarch64+0x4b93aa) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #18 helper_lduw_mmu <null> (qemu-system-aarch64+0x4bc0a7) (BuildId: 9e57c19eb7cc79d8195b5fb05324859b4db6fbbc)
>      #19 <null> <null> (0x7f936faab758)
> 
> <snip>
> 
> So I guess we are trying to free the memory while still running?

Probably not. qemu_ram_free() is named "free", but the RAMBlock itself 
is reclaimed only after an RCU grace period. So the vCPU may still 
observe the old RAMBlock while walking the RAMBlock list/MRU cache, and 
that is an expected part of the lifetime scheme.

I think TSan is more likely complaining about ram_list.mru_block. The 
read side uses an atomic RCU load:

     block = qatomic_rcu_read(&ram_list.mru_block);

but qemu_ram_free() clears it with a plain store:

     ram_list.mru_block = NULL;

If we want to fix this TSan report, the stores to ram_list.mru_block 
should be made atomic as well. In qemu_ram_free(), qatomic_set_mb() 
would also provide the barrier needed before updating ram_list.version, 
so the explicit smp_wmb() there could go away.

This looks distinct from the remaining hang/deadlock, though. For that, 
could you collect the thread backtraces when QEMU is stuck? That should 
show which threads are actually waiting on each other, instead of an 
incidental TSan report from the RAMBlock MRU cache.

