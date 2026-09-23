Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AECC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 19:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9T6p-0000Kr-18; Wed, 23 Sep 2026 15:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9T6n-0000KM-Oc
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpatocka@redhat.com>)
 id 1x9T6m-0001O2-5i
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 15:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790193502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qaVBTnkp0GIcsLjmloJK0bgo8E8q4y+sIZEaz9UXqHo=;
 b=IsQOyEqwDNn/eibFw1A0YhZh8TrldXqjSq42Mm9Kt77of34UMaDW7Q/zllBfV9G69v7Dz6
 F5RDpI+MQoq3kP4a/huuj2Jm37r3ctJjAxJR5LgGFUTxrQANxybjgdVeCb8jiP/u2gk83b
 j2JGHSB6K/4JREd6EjtAUJAZxFuQ2WY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-OiiiWIYtPXOEXCD8OwcGJA-1; Wed,
 23 Sep 2026 15:58:19 -0400
X-MC-Unique: OiiiWIYtPXOEXCD8OwcGJA-1
X-Mimecast-MFC-AGG-ID: OiiiWIYtPXOEXCD8OwcGJA_1790193498
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD4BD180028B; Wed, 23 Sep 2026 19:58:17 +0000 (UTC)
Received: from mpatocka-thinkpadx1carbongen12.rmtcz.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253821953948; Wed, 23 Sep 2026 19:58:15 +0000 (UTC)
Date: Wed, 23 Sep 2026 21:58:13 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>, 
 qemu-devel@nongnu.org
Subject: [PATCH v3] linux-user/sh4: fix race in atomic variables
In-Reply-To: <991e9427-bc5a-7226-453b-70de8825e4b4@redhat.com>
Message-ID: <4799ff0f-a198-36a3-0ec5-fa41cc7337f2@redhat.com>
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
 <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
 <f5f389df-3865-b0de-4b91-da40a5a05256@redhat.com>
 <c621f948-add2-4e9a-9871-344906c7b662@linaro.org>
 <d1a29727-14c6-fe95-c01a-30fd63e3ec4e@redhat.com>
 <991e9427-bc5a-7226-453b-70de8825e4b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mpatocka@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On Tue, 22 Sep 2026, Mikulas Patocka wrote:

> 
> 
> On Tue, 22 Sep 2026, Mikulas Patocka wrote:
> 
> > > Logging guest state at the point your revert hook fires could be
> > > informative...
> > 
> > Yes, I will look into it.
> 
> So, I tried, and got a hit right away:
> 
> superh_cpu_revert_uninterruptible
> pc: 45be9e
> r0: 45bea4
> r1: 55d55e40
> r15: fffffffa
> flags: 1fa0
> 
>   45be94:       10 89           bt      45beb8 <afree+0x84>
>   45be96:       03 c7           mova    45bea4 <afree+0x70>,r0
>   45be98:       f3 61           mov     r15,r1
>   45be9a:       09 00           nop
>   45be9c:       fa ef           mov     #-6,r15
>   45be9e:       21 57           mov.l   @(4,r2),r7
>   45bea0:       3b 27           or      r3,r7
>   45bea2:       71 12           mov.l   r7,@(4,r2)
>   45bea4:       13 6f           mov     r1,r15
>   45bea6:       0b 00           rts

So, after putting debugging prints into the code, I think I have found
out what happens there:

* decode_gusa calls gen_restart_exclusive
* gen_restart_exclusive generates code that sets TB_FLAG_GUSA_EXCLUSIVE
  and generates a call to helper_exclusive

* when the code is executed, TB_FLAG_GUSA_EXCLUSIVE is set
* helper_exclusive calls cpu_loop_exit_atomic, this makes cpu_exec exit
  with EXCP_ATOMIC
* we go to cpu_loop, we execute cpu_exec_step_atomic
* suppose that exit request is set, cpu_exec_step_atomic does nothing, it
  leaves the CPU in the same state as it was before
* we go back to cpu_loop
* suppose that no signal is delivered, so the gUSA is not rewound
* cpu_loop goes to cpu_exec
* there is one difference - now, TB_FLAG_GUSA_EXCLUSIVE is set and it was
  clear before - so cpu_exec will not use the TB that calls
  helper_exclusive, it will instead use the TB that performs the atomic
  operation (both of these TBs have the same PC, they only differ in
  flags)
* the TB that performs the atomic operation is executed inside cpu_exec
  => race condition

So, I fixed this by clearing TB_FLAG_GUSA_EXCLUSIVE after
cpu_exec_step_atomic - to make sure that cpu_exec will find the TB that
calls helper_exclusive and not the TB that performs the atomic operation.

I tested it and the deadlock is gone. Does this seem reasonable? Or, do 
you think that we should fix it somewhere else?

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: qemu-stable@nongnu.org

---
 linux-user/sh4/cpu_loop.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: qemu/linux-user/sh4/cpu_loop.c
===================================================================
--- qemu.orig/linux-user/sh4/cpu_loop.c	2026-09-23 21:20:08.000000000 +0200
+++ qemu/linux-user/sh4/cpu_loop.c	2026-09-23 21:20:08.000000000 +0200
@@ -62,6 +62,11 @@ void cpu_loop(CPUSH4State *env)
             break;
         case EXCP_ATOMIC:
             cpu_exec_step_atomic(cs);
+            /* If cpu_exec_step_atomic exits due to exit request, we must make
+               sure that cpu_exec will execute the TB that contains a call to
+               helper_atomic and not the TB that contains the atomic operation
+               itself - therefore, we clear TB_FLAG_GUSA_EXCLUSIVE.  */
+            env->flags &= ~TB_FLAG_GUSA_EXCLUSIVE;
             arch_interrupt = false;
             break;
         case 0x180:


