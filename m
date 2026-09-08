Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E52C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wte-0000g7-CW; Tue, 08 Sep 2026 10:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3wtc-0000fN-JQ; Tue, 08 Sep 2026 10:34:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x3wtZ-0003Cy-24; Tue, 08 Sep 2026 10:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1788877997; bh=RdsZNCz0AUS3PFPk9w8gC4dGuTqIVTY/Q7LaHgNSg9I=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GWT32MoTASzr/FUR2u8EOp4kt13EcRmowrW6E2xITK/HgJNZbALZAePyedarAwDY4
 NDurqgOmm65Xl6MklnM7UOauJRBOq3qxdPkMdI7I4pEzAFdtGG+eipuZhFcGJF3YJk
 NGyG3+VA0ueolTFlczpXxj/XudtLvjWky8s8Hvt4QgTz3MESd/Sa70k6j6YuCeBGXY
 +l4x4na82Li4Plp9TQsLFpuVm2Qw7Wqqtjc1Ma/e00RKlCwezjk90PVI57SdPzOLUi
 DR0vLdvsoUB0N+XMqieWqvKgyAJmHyU8KABJX8nfRnloTjOSNPHmoAkXiG0jaoHGFc
 QRPzAALeEEqqA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 657161D29D7;
 Tue, 08 Sep 2026 17:33:17 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6E9864237C3;
 Tue, 08 Sep 2026 17:33:44 +0300 (MSK)
Message-ID: <c8b5723a-a05e-41c2-9e1a-77719b598f6b@tls.msk.ru>
Date: Tue, 8 Sep 2026 17:33:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [stable-8.2] Backport request: rbd: Fix .bdrv_get_specific_info
 implementation
To: Aman Asrani <amanasrani1712@gmail.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com
References: <CADExdLCU82TQaQ8+Po1cJ4QVdeyvMJmnY+JmnJtQn_xgztdQRA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CADExdLCU82TQaQ8+Po1cJ4QVdeyvMJmnY+JmnJtQn_xgztdQRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/8/26 13:52, Aman Asrani wrote:
> Hi,
> 
> I would like to ask whether commit |4af976ef398e| ("rbd: Fix .bdrv_get_specific_info implementation") could be considered for a stable-8.2 release.
> 
> This refers to the original upstream patch submission:
> https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04048.html <https://lists.gnu.org/archive/html/qemu-devel/2025-08/msg04048.html>
> 
> I am aware that stable-8.2 is closed, and that stable releases normally follow the currently maintained major release. I am therefore asking knowing 
> this is outside the normal stable policy, and I would completely understand if the answer is no.

Yes, 8.2 is end-of-life for a long time.

> The reason for asking is that Ubuntu 24.04 LTS ships QEMU |1:8.2.2+ds-0ubuntu1.16| and is supported until 2029. As a result, deployments using this 
> QEMU version with Ceph/RBD storage can remain affected for the remainder of the Ubuntu LTS support lifetime. The fix is present in newer maintained 
> QEMU branches but cannot reach 8.2 through an upstream stable release.

Heh.

The problem with ubuntu is like they don't know what they want.

First, before closing 8.2.x line, I asked them if they want this
line to be maintained for longer than usual.  They didn't answer,
so I closed it.

Later I talked to one of their qemu maintainers, and he asked me
to resume that 8.2.x line, - he wanted to update qemu in ubuntu
based on the upstream 8.2.x stable series.  I was like, meh, but
we're quite behind already, it's been closed a couple months ago.

So I went back and re-evaluated all updates happened during this
time, and resumed 8.2.x line.  This went on for quite some time.

Later, there were a few (ubuntu) users complaining some bugs were
not fixed in 8.2.x stable line.  But I knew for sure I fixed them
in subsequent 8.2.x, long ago already.  Meh.

So I looked which version is available in ubuntu, and discovered
they never, ever, updated their 8.2.2 (or .3?) in ubuntu 24.04
since 24.04.  There were a few hand-applied updates which bothered
their users, and that's it.  No single release I made for them were
actually used, and their people complained to *me* that their version
is buggy.

So I asked them again what's going on, but never got a reply.

So in the end I closed this line, now for good.  They're on their
own, together with their users.  I don't care about ubuntu anymore,
-- ubuntu is just a waste of resources and frustration, nothing more.

Thanks,

/mjt

