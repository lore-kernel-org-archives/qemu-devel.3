Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC89C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x94lZ-0006d2-Pv; Tue, 22 Sep 2026 13:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x94lU-0006cn-Bz
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x94lP-00010b-7d
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790099921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aC9Rwr83/IJN6Vh8wZqZgO8cFsxbYZyXxc5Bs5kbZ5k=;
 b=ITgJpXFBiuj6bTs/mJxSq76PYoknVNijjvqgNInPsXoudFsAJRBQ5xXEnt2yNIPN1YxTyh
 KnPKHH6jDiQwu95CuBdyPYLvDQzg2wp3XaYepSzk6lHiMX82ry3RpfgqkHko+qjyTDRnj7
 a4R4alsN8aYbb0KmvVr09FFdMJVv4WE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-_hu7dkQiPDWjLwAMKvLLjQ-1; Tue,
 22 Sep 2026 13:58:38 -0400
X-MC-Unique: _hu7dkQiPDWjLwAMKvLLjQ-1
X-Mimecast-MFC-AGG-ID: _hu7dkQiPDWjLwAMKvLLjQ_1790099917
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E83F418052F8; Tue, 22 Sep 2026 17:58:36 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 360EF30001B9; Tue, 22 Sep 2026 17:58:34 +0000 (UTC)
Date: Tue, 22 Sep 2026 19:58:32 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
In-Reply-To: <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
Message-ID: <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



On Tue, 22 Sep 2026, Richard Henderson wrote:

> On 9/22/26 10:04, Mikulas Patocka wrote:
> > I looked at the sh4 translator and it seems that it already tries to make
> > sure that the full gUSA region is translated into one TB - i.e. there is
> > "ctx->base.max_insns = max_insns" in sh4_tr_init_disas_context - that will
> > override the value "1" that is supplied by cpu_exec_step_atomic. The
> > comments suggest that the author is aware of the fact that the gUSA region
> > must be completed atomically.
> > 
> > So, the code that single-steps through the gUSA region is not needed.
> > 
> > It seems that the misbehavior is caused by the fact that if we exit from
> > the gUSA TB early, we execute the rest of the region in non-exclusive
> > context.
> > 
> > I simplified the patch, so that it adds just one method -
> > revert_uninterruptible. It tests whether we are in the unfinished gUSA
> > region, and if we are, it reverts PC and SP back to the beginning.
> 
> What good does that do?  You'll only restart the same block as before.
> 
> Is this really the case where you're encountering

Without that patch, it deadlocks in 10-30 minutes. With the patch (either 
version 1 or version 2 that I sent), it stays running overnight.

Maybe the bug is somewhere else and the patch just papers over it.

> >         if (pc != pc_end + backup || max_insns < 2) {
> >             /* This is a malformed gUSA region.  Don't do anything special,
> >                since the interpreter is likely to get confused.  */
> >             ctx->envflags &= ~TB_FLAG_GUSA_MASK;
> 
> If you add an abort here, does it trigger?

I added the abort(). It deadlocked in 25 minutes, but didn't trigger it.

> > +    /*
> > +     * If we are interrupted in the middle of the gUSA region, we must
> > +     * roll-back PC to the beginning of the region. Continuing halfway
> > +     * through the region would break atomicity guarantees.
> > +     *
> > +     * If we are interrupted after the final write instruction (i.e.
> > +     * cpu->env.pc == cpu->env.gregs[0]), we must not roll-back, because
> > +     * the atomic write is already committed in the memory.
> > +     */
> Just know that you *can't* be interrupted in the middle of a gUSA region.
> Signals will always be delayed until the end of the TranslationBlock.
> 
> So this text is misleading at best.

Yes, I am not qemu expert.

BTW. what happens with synchronous signals inside the TB? (i.e. SIGSEGV 
due to writing into a write-protected page)

Mikulas


