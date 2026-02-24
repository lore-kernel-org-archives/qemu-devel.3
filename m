Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D60F4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwDt-0001U4-23; Tue, 24 Feb 2026 12:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@demindiro.com>)
 id 1vuwDn-0001Rn-FG
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:19 -0500
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@demindiro.com>)
 id 1vuwDf-0001Rw-MT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:17 -0500
Received: from [192.168.2.172] (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id 0D00AFF01C;
 Tue, 24 Feb 2026 18:28:06 +0100 (CET)
Message-ID: <e0969dbd-c91d-4dbe-a78f-6a8207cf0d50@demindiro.com>
Date: Tue, 24 Feb 2026 18:28:05 +0100
MIME-Version: 1.0
User-Agent: Icedove Daily
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command logging
 cmd ID
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260220181437.19338-1-qemu@demindiro.com>
 <20260223083257.423660c4@imammedo>
 <e483bb5d-d8c2-480e-92a4-6234d87a8522@demindiro.com>
 <ef9b046b-3f57-4b09-8d99-91c61ee41bd0@oracle.com>
Content-Language: en-US
From: David Hoppenbrouwers <david@demindiro.com>
In-Reply-To: <ef9b046b-3f57-4b09-8d99-91c61ee41bd0@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=david@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/23/26 7:49 PM, Alejandro Jimenez wrote:
> Hi David
> 
> On 2/23/26 8:06 AM, David Hoppenbrouwers wrote:
>> On 2/23/26 8:32 AM, Igor Mammedov wrote:
>>> On Fri, 20 Feb 2026 19:14:37 +0100
>>> David Hoppenbrouwers <qemu@demindiro.com> wrote:
>>>
>>>> The command ID is in cmd[0], not cmd[1].
>>> pls add a reference to the spec,
>>> and if any what impact it does have on a guest/how it manifests.
>>
>> Figure 43 "Generic Command Buffer Entry Format" in
>> https://docs.amd.com/v/u/en-US/48882_3.10_PUB
> 
> Unfortunately, the documentation links tend to be broken very often, so it
> is not a good idea to include them in commit messages. That is why I would
> opt for the longer, more verbose (but hopefully easier to find after a
> quick search) choice of listing the name of the spec with the revision,
> chapter and relevant keywords. See my proposed commit message at the end.
> 
>> But the switch() above also uses cmd[0]:
>>
>>      switch (extract64(cmd[0], 60, 4)) {
>>      case AMDVI_CMD_COMPLETION_WAIT:
>>          amdvi_completion_wait(s, cmd);
>>          break;
>>
>> It has no effect on the guest, only on the -trace option. It may be
>> confusing to developers if the actual command ID doesn't match what is
>> shown by -trace.
>>
> I think it could have an effect on (some) guest too, although this is
> unlikely given the number of things that need to go wrong, but perhaps a
> test flow in a guest driver like:
> - Guest triggers an IOMMU command with an invalid opcode.
> - Guest reads the event log (incorrectly filled by the vIOMMU) and reports
> an error on mismatched opcode.
> 
> Using cmd[1] seems clearly a typo from the original code. To honor Igor's
> request to add details, I'd propose we change the commit message to:
> 
> amd_iommu: Fix opcode reported in invalid command handling
> 
> According to the AMD I/O Virtualization Technology (IOMMU) Specification
> (Rev 3.10), Section 2.4 Commands, the Generic Command Buffer Entry Format
> encodes the opcode in bits [63:60] of the command buffer.
> 
> When handling illegal opcodes, the traces for unhandled commands and event
> log info extract the opcode from an incorrect offset in the command buffer.
> Fix this issue to avoid potential confusion with mismatched opcodes in
> traces and unlikely errors in guest event processing.
> 
> Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: David Hoppenbrouwers <qemu@demindiro.com>
> Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
> 
> If that works for everyone, I can add apply it; no need to send a new revision.
> 
> Thank you,
> Alejandro
> 
>> David

It is fine with me.

