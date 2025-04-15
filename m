Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C886C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dKP-0007yR-O6; Tue, 15 Apr 2025 06:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u4dKE-0007vX-G9
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:15:32 -0400
Received: from smtp.eurecom.fr ([193.55.113.210])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Marco.Cavenati@eurecom.fr>)
 id 1u4dK8-00083f-E0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
 t=1744712121; x=1776248121;
 h=from:in-reply-to:references:date:cc:to:mime-version:
 message-id:subject:content-transfer-encoding;
 bh=zFdlkfg8HOpidi2/q2ei3yN/fl4TXRX7xhEDxC3t5/I=;
 b=cXlWzmfMcyah2btM4TtD6F7wVeIB0KPlhHtVzBz0qIwN4Tu51TG7nq6W
 yPzjZoAcHIVuAPBWkGbAgI49YHg58L7fV5gwVzFwEBKHPLdtEub27TDcC
 30j/cuu/nGxVXy6Ibkjlq3LkIMtJNnSH0oDJMh0oARScMwmTiBbvR8tq4 Q=;
X-CSE-ConnectionGUID: iaeZ/sFIR9WjKJ38Fh6M3g==
X-CSE-MsgGUID: e/ppbHHhRSWJgRGNXP4dDQ==
X-IronPort-AV: E=Sophos;i="6.15,213,1739833200"; 
   d="scan'208";a="850446"
Received: from quovadis.eurecom.fr ([10.3.2.233])
 by drago1i.eurecom.fr with ESMTP; 15 Apr 2025 12:15:15 +0200
From: "Marco Cavenati" <Marco.Cavenati@eurecom.fr>
In-Reply-To: <87ecxyhon3.fsf@suse.de>
Content-Type: text/plain; charset="utf-8"
X-Forward: 193.55.114.5
References: <20250327141451.163744-3-Marco.Cavenati@eurecom.fr>
 <87jz7rhjzq.fsf@suse.de> <4caa0-67f8d780-a89-60718600@156698708>
 <87ecxyhon3.fsf@suse.de>
Date: Tue, 15 Apr 2025 12:15:18 +0200
Cc: "Peter Xu" <peterx@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Prasad Pandit" <ppandit@redhat.com>
To: "Fabiano Rosas" <farosas@suse.de>
MIME-Version: 1.0
Message-ID: <7cd3c-67fe3180-3d9-10622a60@195384178>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?migration=3A?= add  
 =?utf-8?q?FEATURE=5FSEEKABLE?= to QIOChannelBlock
User-Agent: SOGoMail 5.12.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=193.55.113.210;
 envelope-from=Marco.Cavenati@eurecom.fr; helo=smtp.eurecom.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, April 11, 2025 14:24 CEST, Fabiano Rosas <farosas@suse.de> w=
rote:

> > If bitmap 0 implies zero page, we could call `ram=5Fhandle=5Fzero`
> > in `read=5Framblock=5Fmapped=5Fram` for the clear bits.
> > Or do you fear this might be unnecessary expensive for migration?
>=20
> Yes, unfortunately the peformance difference is noticeable. But we co=
uld
> have a slightly different algorithm for savevm. At this point it migh=
t
> be easier to just duplicate read=5Framblock=5Fmapped=5Fram(), check f=
or savevm
> in there and see what that the resulting code looks like.

I tried to get some numbers in a "bad case" scenario restoring a
clean, fully booted, idle Debian VM with 4GB of ram. The zero pages
are ~90%. I'm using a nvme ssd to store the snapshot and I repeated
the restore 10 times with and without zeroing (`ram=5Fhandle=5Fzero`).
The restore takes on average +25% of time.
(It's not a broad nor deep investigation.)

So, I see your point on performance, but I'm not fully comfortable
with the difference in zero page handling between mapped-ram on
and mapped-ram off. In the former case zero pages are skipped, while
in the latter they are explicitly zeroed.
Enabling mapped-ram has the implicit effect to also skip zero-pages.
I think it is an optimization not really bound to mapped-ram and it
could be better to have this feature external to mapped-ram, enabled
when the destination ram is known to be already zeroed (also for
mapped-ram off ideally).

> By the way, what's your overall goal with enabling the feature? Do yo=
u
> intent to enable further capabilities for snapshot? Specifically
> multifd. I belive the zero page skip is responsible for most of the
> performance gains for mapped-ram without direct-io and multifd. The
> benefit of bounded stream size doesn't apply to snapshots because
> they're not live.

My overall goal is a hot-loadvm feature that currently lives in a fork
downstream and has a long way before getting in a mergeable state :)
In a nutshell, I'm using dirty page tracking to load from the snapshot
only the pages that have been dirtied between two loadvm;
mapped-ram is required to seek and read only the dirtied pages.
About the other capabilities, I still have to understand if they might
help in my use case.

> It would be interesting to gather some numbers for the perf differenc=
e
> between mapped-ram=3Don vs off.

Repeating the same experiment as above, without mapped-ram,
I obtain +48% in restore time compared to mapped-ram and,
therefore, a +18% wrt to the mapped-ram with zeroing.
(It should be noted that mapped-ram without zeroing leaves
the restored vm in an inconsistent state).
At the moment I don't have numbers regarding savevm.

Thanks!

Best,
Marco


