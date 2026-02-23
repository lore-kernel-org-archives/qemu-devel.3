Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94C1EA4FC0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuW8O-0003VM-IB; Mon, 23 Feb 2026 08:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@demindiro.com>)
 id 1vuVfV-0005I7-Lv
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:08:09 -0500
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@demindiro.com>)
 id 1vuVfM-0007wu-MW
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:08:09 -0500
Received: from [192.168.2.172] (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id 609F5FF01C;
 Mon, 23 Feb 2026 14:06:50 +0100 (CET)
Message-ID: <e483bb5d-d8c2-480e-92a4-6234d87a8522@demindiro.com>
Date: Mon, 23 Feb 2026 14:06:49 +0100
MIME-Version: 1.0
User-Agent: Icedove Daily
Subject: Re: [PATCH] hw/i386/amd_iommu.c: fix amdvi_unhandled_command logging
 cmd ID
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260220181437.19338-1-qemu@demindiro.com>
 <20260223083257.423660c4@imammedo>
Content-Language: en-US
From: David Hoppenbrouwers <david@demindiro.com>
In-Reply-To: <20260223083257.423660c4@imammedo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=david@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:37:52 -0500
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

On 2/23/26 8:32 AM, Igor Mammedov wrote:
> On Fri, 20 Feb 2026 19:14:37 +0100
> David Hoppenbrouwers <qemu@demindiro.com> wrote:
> 
>> The command ID is in cmd[0], not cmd[1].
> pls add a reference to the spec,
> and if any what impact it does have on a guest/how it manifests.

Figure 43 "Generic Command Buffer Entry Format" in
https://docs.amd.com/v/u/en-US/48882_3.10_PUB
But the switch() above also uses cmd[0]:

     switch (extract64(cmd[0], 60, 4)) {
     case AMDVI_CMD_COMPLETION_WAIT:
         amdvi_completion_wait(s, cmd);
         break;

It has no effect on the guest, only on the -trace option. It may be 
confusing to developers if the actual command ID doesn't match what is 
shown by -trace.

David

