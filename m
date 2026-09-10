Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531B6C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4ehO-0008Ok-P6; Thu, 10 Sep 2026 09:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x4ehM-0008KU-Cw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:20:16 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1x4ehK-00025g-Hy
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 09:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=Q8Ul6Aun7zHcGKR06RWsx1C33ItDmDpABDEU+Mfeo3c=; b=p2BtHyBPcbNK2v7u
 xD7jE5hI9DmYpyKTKX73MFRI88aqqgPnulgbsgGKrxMFLfmoW59Bw7JDPfJkFaqibeoNdpljzLv/Z
 mz3OTBwqlou6tovTs6PoBIyLJjFCdS4dA7/ctVvJL06Bn2S5yRRABRlXkzDzziOFimLwxFFDcliRH
 GEmPXFrxshZQS0s7t5ZGllGx/AG07Wh/CD54M9Y3O75BTWW+iFvZ0aJKFsha0qYAObgkR+dWyLBL1
 yRZXcw3IdGqiehTcdjWdHmeg+rbKAyLGy3BVDWRiL18Zm+XifZvm5hlspiCPpVQsy0n4pFn7qKJ+y
 m/AmriyvMnKP0Gfx/w==;
Received: from dg by mx.treblig.org with local (Exim 4.98.2)
 (envelope-from <dg@treblig.org>) id 1x4ehG-00000003vRG-1Ema;
 Thu, 10 Sep 2026 13:20:10 +0000
Date: Thu, 10 Sep 2026 13:20:10 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/18] migration: HMP: Fix bandwidth parameters
Message-ID: <aqKuikOZY9HFcNWe@gallifrey>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-12-farosas@suse.de>
 <875x0dhc9u.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <875x0dhc9u.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.12.107+deb13-amd64 (x86_64)
X-Uptime: 13:18:56 up 11 days, 14:40,  2 users,  load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.13 (2024-03-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Markus Armbruster (armbru@redhat.com) wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > The max-bandwidth and avail-switchover-bandwidth parameters are
> > declared as bytes/second in migration.json and interpreted as such
> > throughout the code, except in HMP where they're expected to be
> > provided as mebibytes.
> >
> > Fix the HMP code to parse the values as bytes.
> 
> I wouldn't call this a fix.  The choice of unit was clearly intentional.
> Doesn't mean we must not change it now.  David, what do you think?

Meh I wouldn't worry about whether we call it a 'fix' or not!
The real benefit here is that by making this number consistent
the units in the next patch aren't needed since everyone uses
the same unit.

Dave

> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

