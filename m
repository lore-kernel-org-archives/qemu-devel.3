Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDF8C98308
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x965C-00032Z-Cw; Tue, 22 Sep 2026 15:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9658-0002oV-L1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9656-0002Wj-1X
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 15:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790104986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnLWYV1H3gnwlSMYPL6hp7+oSRKuOcXhRH6WavLuG/Q=;
 b=Jb1as5zCoyRlFrLIv1xe630Kw09NguEgBFI0hBdLaYUUpiFX/8lnSopL+cSqjw8hDy0pDU
 sQgEPPqT/svi5l7Z4nbPE+H7lz/mi8A0jFsqkFfF2CJkVh3n83UoD2J057sMcJkTIh6NWJ
 05TfAqUGtCZSben+Zxr4W6UmzA04PrI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Dd0API2gMhKMO1iTgRJ1Dg-1; Tue,
 22 Sep 2026 15:23:02 -0400
X-MC-Unique: Dd0API2gMhKMO1iTgRJ1Dg-1
X-Mimecast-MFC-AGG-ID: Dd0API2gMhKMO1iTgRJ1Dg_1790104981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A2D11954B2A; Tue, 22 Sep 2026 19:23:01 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD9091800446; Tue, 22 Sep 2026 19:22:59 +0000 (UTC)
Date: Tue, 22 Sep 2026 21:22:55 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
In-Reply-To: <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
Message-ID: <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
 <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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



On Tue, 22 Sep 2026, Richard Henderson wrote:

> On 9/22/26 10:58, Mikulas Patocka wrote:
> > 
> > 
> > On Tue, 22 Sep 2026, Richard Henderson wrote:
> > 
> >> On 9/22/26 10:04, Mikulas Patocka wrote:
> >>> I looked at the sh4 translator and it seems that it already tries to make
> >>> sure that the full gUSA region is translated into one TB - i.e. there is
> >>> "ctx->base.max_insns = max_insns" in sh4_tr_init_disas_context - that will
> >>> override the value "1" that is supplied by cpu_exec_step_atomic. The
> >>> comments suggest that the author is aware of the fact that the gUSA region
> >>> must be completed atomically.
> >>>
> >>> So, the code that single-steps through the gUSA region is not needed.
> >>>
> >>> It seems that the misbehavior is caused by the fact that if we exit from
> >>> the gUSA TB early, we execute the rest of the region in non-exclusive
> >>> context.
> >>>
> >>> I simplified the patch, so that it adds just one method -
> >>> revert_uninterruptible. It tests whether we are in the unfinished gUSA
> >>> region, and if we are, it reverts PC and SP back to the beginning.
> >>
> >> What good does that do?  You'll only restart the same block as before.
> >>
> >> Is this really the case where you're encountering
> > 
> > Without that patch, it deadlocks in 10-30 minutes. With the patch (either
> > version 1 or version 2 that I sent), it stays running overnight.
> > 
> > Maybe the bug is somewhere else and the patch just papers over it.
> 
> Could well be.  Do you have a reliable reproducer?  Or is this a "run the
> container and things eventually fail" sort of thing?

Download the Ajla programming language from
git clone git://repo.or.cz/ajla.git
(there is a mirror at https://www.github.com/mikulas-patocka/ajla.git)
(see the homepage at https://www.ajla-lang.cz/ )

Install the sh4 toolchain: gcc-sh4-linux-gnu (I use Debian Sid)
Install autoconf, automake, ed, make

Compile Ajla:
CC=sh4-linux-gnu-gcc CF="-DDEBUG_ENV" ./rebuild --disable-rwx-mappings

--disable-rwx-mappings is a workaround for another qemu bug - see
https://gitlab.com/qemu-project/qemu/-/work_items/2998

Download https://ajla-lang.cz/downloads/examples/advent-2023/18-2.ajla

Create an input file:
cat >18-small.txt <<EOF
R 6 (#70c710)
D 5 (#0dc571)
L 2 (#5713f0)
D 2 (#d2c081)
R 2 (#59c680)
D 2 (#411b91)
L 5 (#8ceee2)
U 2 (#caa173)
L 1 (#1b58a2)
U 2 (#caa171)
R 2 (#7807d2)
U 3 (#a77fa3)
L 2 (#015232)
U 2 (#7a21e3)
EOF

Run
while time /usr/src/git/qemu/build/qemu-sh4 ./ajla --nosave --tick=100 --thread-tick 18-2.ajla <18-small.txt; do date; done 2>&1 | tee lockup.log

Wait for several tens of minutes - it deadlocks on exit, after printing 
the output "952408144115"

> Logging guest state at the point your revert hook fires could be
> informative...

Yes, I will look into it.

> > BTW. what happens with synchronous signals inside the TB? (i.e. SIGSEGV
> > due to writing into a write-protected page)
>
> Synchronous signals like that exit the translation block right away, leading
> to the signal being delivered.

So, the TB can exit halfway through?

When I was analyzing the bug 2998, I found out that Qemu marks pages with 
executed code as read-only. When the program writes into them, it 
invalidates the translated code and marks the pages as read-write.

How does this interact with TBs exits? What happens if we write into a 
read-only page in the middle of the TB?

Note that Ajla has JIT that generates sh4 code on the fly. But the option 
--disable-rwx-mappings makes it store the generated code in separate pages 
and not on the heap. So, I don't know if it can cause these problems.

Mikulas


