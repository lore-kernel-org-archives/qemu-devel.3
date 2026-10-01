Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E25BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 04:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC8F5-0006YV-S3; Thu, 01 Oct 2026 00:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xC8F3-0006YK-24
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:17:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xC8Ez-0003hD-0b
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 00:17:56 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6914Hjrh003862
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 13:17:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rzyAGyEKEsjxKfSnUi3spwW6eXRvG5gsNvKiW96saUI=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1790828265; v=1;
 b=N8kN5cBj+xYcN5OQ8/uDrbu+xkJVDrCSH7vp7iY1Klq6iOZTVTvqdTu6fFSMaAtA
 i2yzsRpKlqEuqzFKGsnF1LSZP/YrkZu661+P5CMmki0Ye2OacZaAEyWZlb/9Hzmj
 mSKFdRdGqJChUIhJ0oxkzU23qfqczGQLP4JXyCrIJv6yx4SUJQm0jCOlb/vdXtUO
 XHktZfHyckoJyt3YX8Vwiaj9WWU4FYELQylqTGhvvpRggUxP3Ygwz1fv8OQi6sKa
 rFK12AyqwOxMIl+qj8RE/ahse3Bu1feN7i2RAeNJV15fJRHkNEDVuAi5QnGEvPUb
 s9rJaK7SXT0nFDYF6uIrZw==
Message-ID: <d5a34ad2-d64d-4343-b99b-aba7da03152e@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 1 Oct 2026 13:17:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] monitor/hmp: add CPUClass::get_pc fallback for HMP
 $pc
To: qemu-devel@nongnu.org
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
 <20260911-query-reg-v1-5-0c04f0c02cf3@redhat.com>
 <cdf83c82-5f26-4e06-920f-5596a9e3560f@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cdf83c82-5f26-4e06-920f-5596a9e3560f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/10/01 2:31, Philippe Mathieu-Daudé wrote:
> On 11/9/26 14:27, Marc-AndrÃ© Lureau wrote:
>> Some targets, including x86, have no GDB register named "pc" (x86
>> uses eip/rip). When the GDB register lookup fails for "$pc" in
>> HMP expressions, fall back to CPUClass::get_pc so that "p $pc",
>> "x $pc" etc. work without relying on the legacy MonitorDef table.
>>
>> This prepares for the eventual removal of MonitorDef while making
>> $pc available immediately for all targets that implement get_pc.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   monitor/hmp.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> 
>> @@ -435,6 +435,10 @@ static bool gdb_get_register(MonitorHMP *hmp, 
>> int64_t *pval, const char *name)
> 
>> +    if (!strcmp(name, "pc") && cs->cc->get_pc) {
>> +        *pval = cs->cc->get_pc(cs);
>> +        return true;
>> +    }
>>       return false;
>>   }
> Before commit 57206fd42a0 ("more register values in monitor") we had
> $eip (32-bit) aliased as $pc, but I suppose in order to add the 64-bit
> port (see next commit, 75dfaa1e64b "x86-64 port (Jocelyn Mayer)") it
> was unified as a single $pc instead of adding the corresponding $rip:
> 
> -    { "eip|pc", offsetof(CPUState, eip) },
> +    { "pc", 0, monitor_get_pc, },
> 
> This was 22 years ago :) With retrospective I'd say a generic $pc is
> misleading (note, this is only for the x86 architecture, the other
> ones don't suffer from this problem).
> 
> To be pedantic we could add a 'const char *CPUClass::get_pc_regname()'
> helper, but TBH I'd just drop this and let the monitor reports an error.
> gdbstub doesn't suffer from that because EIP/RIP register index are
> used.
> 
> What is the community view on this?

One detail to note is that this patch changes the behavior of $pc in 
32-bit mode.

The new fallback calls x86_cpu_get_pc(), which omits the truncation 
previously performed by the old monitor getter. For example, with a 
32-bit code segment having a base of 0xffff0000 and an EIP of 0x10000, 
execution correctly wraps to address zero, but HMP will report $pc = 
0x100000000. Consequently, `x /1xb $pc` fails while `x /1xb 0` succeeds.

That said, I'm fine with dropping $pc anyway.

Regards,
Akihiko Odaki

