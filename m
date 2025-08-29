Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA87FCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNN5-0008EZ-En; Sat, 30 Aug 2025 11:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1us0HI-0007Zn-Ll
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:40:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1us0HE-0007zp-AX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:40:32 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57TEeJeE054845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 Aug 2025 23:40:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5cOfY4KsxJ9w2KVkX2GwNF0odtUWxEb47sjM2jUg8jw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1756478420; v=1;
 b=pDQC64DYAY11Cy/zu0XOpDVIENy/nuq5TcvKiPZDpZhNpYAki+uOAA0qjX54cOWH
 C8klR8/RHNReHufFfYlsvm1VwYD8v/Sb9XdhZwgV1nzM1RHglDlJLbzVrAUL8uAw
 rMBspzbkXYL+PqLZW+ScdaGDZ+OQ5ITdIVL94pTFFF8U+MW6lclVkDKlUCSMrBvP
 MauSmP7bztrGTMRzm5XcBLdiAakCUcAV43OKjAtMwOcbtK9GyGCIr86SbP/MO8AT
 dbThCyZLxJzQ3tmiqjv93ayDUMrw5X06EwlY3sJilQmH8TvTCL5HVzrNfZxm7/zv
 7r3O9GqZ0EAnFx48+6TGNw==
Message-ID: <942ae41e-931f-4d09-85d8-8849d36b88db@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 29 Aug 2025 23:40:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Call set_features during reset
To: Michael Tokarev <mjt@tls.msk.ru>, Fabiano Rosas <farosas@suse.de>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
References: <871pudmlmj.fsf@suse.de>
 <dc23eaca-15f5-40be-89d0-2247cfe1f716@tls.msk.ru> <87plchkaxo.fsf@suse.de>
 <3983904c-9530-4cf5-b294-12ca04658b23@rsg.ci.i.u-tokyo.ac.jp>
 <3b17f289-876d-4cbd-bda7-1bbd83832e85@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3b17f289-876d-4cbd-bda7-1bbd83832e85@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/29 17:34, Michael Tokarev wrote:
> On 28.08.2025 03:57, Akihiko Odaki wrote:
> 
>> The posted call trace indicates a lockup happens in the control path, 
>> but commit cefd67f25430 ("virtio-net: Fix num_buffers for version 1") 
>> changes the data path.
>>
>> On the other hand, I can come up with a possible failure scenario with 
>> commit ce1431615292 ("virtio: Call set_features during reset"). 
>> Perhaps it changed the machine state before loading the migrated 
>> state, and caused a mismatch between them.
> 
> Yes, the problem commit is 0caed25cd171c6 "virtio: Call set_features
> during reset", - the OP corrected himself in the next message (subject
> line updated).
> 
>> I need more information to understand the issue. A command line to 
>> reproduce the issue is especially helpful because options like 
>> mrg_rxbuf=, which you mentioned, tell enabled features, which is 
>> valuable information.
> 
> See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1112044#69 for
> the command line.  The guest is started by libvirtd.

Thank you, now I think I understand the problem.

> 
> Please note: this is stable-7.2 series, it is *not* master (I picked
> up this commit to 7.2.x).  It'd be interesting to check if master is
> affected too.  Unfortunately I never tried migration, and now I only
> have my notebook, so can only migrate between two qemu instances on
> the same box - which is probably okay too.

I think you need to backport commit 9379ea9db3c0 ("virtio-net: Add 
queues before loading them") and adda0ad56bd2 ("virtio-net: Add queues 
for RSS during migration"). Here is an explanation:

First, let me define two variables for conciseness:
N: the number of queue pairs
M: the maximum number of queue pairs, which is determined with
    n->max_queue_pairs

The problem is that QEMU inconsistently chose N for virtio-net in the 
past. Before commit 8c49756825da ("virtio-net: Add only one queue pair 
when realizing"):
1) realize() chose M.
2) set_features() chose: 1 (when RSS and MQ are disabled)
                          M (otherwise)

This itself was a problem; both RSS and MQ were disabled when realize() 
but N was M, which is inconsistent with 2) and this inconsistency was 
guest-visible.

I wrote commit 8c49756825da ("virtio-net: Add only one queue pair when 
realizing") to make QEMU implement the behavior in 2) also during 
realization and fix the inconsistency, but it broke migration when the 
migrated VM had enabled VIRTIO_NET_F_RSS and VIRTIO_NET_F_MQ because it 
expected that N == M.

This is also why the backported commit also broke migration; it 
accidentally fixed the inconsistency between the first reset state and 
the state after set_features() and caused the same problem.

I wrote commit 9379ea9db3c0 ("virtio-net: Add queues before loading 
them") to fix the issue and later complemented it with commit 
adda0ad56bd2 ("virtio-net: Add queues for RSS during migration").

There are several relevant commits because I could not fix the 
underlying problem at once, but hopefully this email clarifies how the 
two commits fixed it in the end.

Regards,
Akihiko Odaki

