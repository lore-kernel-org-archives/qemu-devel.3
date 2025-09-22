Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12035CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dbD-0001fT-FQ; Mon, 22 Sep 2025 06:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0daw-0001f0-W8
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:16:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0daj-0008Lk-HA
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758536169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XYvRW8l4NMlNeBru1cTxqd+PHgWLQfAyd3NAbUjWJlw=;
 b=CtWNzrxMVi0Bu3/M6ImQUwc4let3plC/g2V7Sfr3gHQIqhKtIbW8jmvJUYfvr2BwbhAcb1
 hrHm9c9HQ6+aHUSXvKkfqVtA/rG9+ODuD4VyaykuiFijffUmHjaUz0HWJo976KQgme35dy
 aX5dL3XNsMbR/o5YrC7UOUqVRLGuwAA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-ynB_cotdNO--fakQAeR5Ow-1; Mon,
 22 Sep 2025 06:16:00 -0400
X-MC-Unique: ynB_cotdNO--fakQAeR5Ow-1
X-Mimecast-MFC-AGG-ID: ynB_cotdNO--fakQAeR5Ow_1758536159
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0509119560B2; Mon, 22 Sep 2025 10:15:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 866453000198; Mon, 22 Sep 2025 10:15:56 +0000 (UTC)
Date: Mon, 22 Sep 2025 11:15:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Julian Ganz <neither@nut.email>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH v6 23/25] tests: add plugin asserting correctness of
 discon event's to_pc
Message-ID: <aNEh2A3wxj-spjmh@redhat.com>
References: <cover.1757018626.git.neither@nut.email>
 <073cad7dd8ae509ff64a2835fd146833b60c1f60.1757018626.git.neither@nut.email>
 <87segf69f6.fsf@draig.linaro.org>
 <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51342318ee32c932dc2a867c808989ea627d874f@nut.email>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 10:11:23AM +0000, Julian Ganz wrote:
> Hi Alex,
> 
> September 21, 2025 at 6:46 PM, "Alex Bennée" <alex.bennee@linaro.org mailto:alex.bennee@linaro.org?to=%22Alex%20Benn%C3%A9e%22%20%3Calex.bennee%40linaro.org%3E > wrote:
> > Julian Ganz <neither@nut.email> writes:
> > >  +static void report_mismatch(const char *pc_name, unsigned int vcpu_index,
> > >  + enum qemu_plugin_discon_type type, uint64_t last,
> > >  + uint64_t expected, uint64_t encountered)
> > >  +{
> > >  + GString *report;
> > > 
> > This could be:
> > 
> >  g_autoptr(GString) buf = g_string_new(NULL);
> 
> I wanted to avoid doing an allocation regardless of whether we do have
> anything to report or not. But I guess a performance plugin isn't
> performance critical enough to worry? Anyway, I will have another look
> at g_autoptr.

IMHO the use of GString is pointless, there is only a single
g_string_append_printf call.  GString is only useful when
incrementally constructing a string from many pieces. This
code could have just used 'g_strdup_printf' AFAICT.

> 
> > > + const char *discon_type_name = "unknown";
> > >  +
> > >  + if (addr_eq(expected, encountered)) {
> > >  + return;
> > >  + }
> > >  +
> > >  + switch (type) {
> > >  + case QEMU_PLUGIN_DISCON_INTERRUPT:
> > >  + discon_type_name = "interrupt";
> > >  + break;
> > >  + case QEMU_PLUGIN_DISCON_EXCEPTION:
> > >  + discon_type_name = "exception";
> > >  + break;
> > >  + case QEMU_PLUGIN_DISCON_HOSTCALL:
> > >  + discon_type_name = "hostcall";
> > >  + break;
> > >  + default:
> > >  + break;
> > >  + }
> > >  +
> > >  + report = g_string_new(NULL);
> > >  + g_string_append_printf(report,
> > >  + "Discon %s PC mismatch on VCPU %d\nExpected: %"
> > >  + PRIx64"\nEncountered: %"PRIx64"\nExecuted Last: %"
> > >  + PRIx64"\nEvent type: %s\n",
> > >  + pc_name, vcpu_index, expected, encountered, last,
> > >  + discon_type_name);
> > >  + qemu_plugin_outs(report->str);
> > > 
> > I think we might want to flush here because
> 
> Yes we do. I probably (incorrectly) assumed `qemu_plugin_outs` already
> did that.
> 
> > 
> > > 
> > > + if (abort_on_mismatch) {
> > >  + g_abort();
> > >  + }
> > > 
> > This is firing on:
> > 
> >  🕙17:35:50 alex@draig:tests/tcg/i386-linux-user on  review/tcg-discon-v6 [$!?] 
> >  ➜ make run-plugin-catch-syscalls-with-libdiscons.so V=1
> >  timeout -s KILL --foreground 120 env QEMU=/home/alex/lsrc/qemu.git/builds/sanitisers/qemu-i386 /home/alex/lsrc/qemu.git/builds/sanitisers/qemu-i386 -plugin ../plugins/libdiscons.so -d plugin -D catch-syscalls-with-libdiscons.so.pout catch-syscalls > run-plugin-catch-syscalls-with-libdiscons.so.out
> >  Aborted
> >  make: *** [Makefile:226: run-plugin-catch-syscalls-with-libdiscons.so] Error 134
> >  🕙17:35:52 alex@draig:tests/tcg/i386-linux-user on  review/tcg-discon-v6 [$!?] [🔴 USAGE] 
> >  ✗
> > 
> > although it never gets to the point of reporting what failed:
> > 
> >  Thread 1 "qemu-i386" hit Breakpoint 1, __GI_abort () at ./stdlib/abort.c:72
> >  warning: 72 ./stdlib/abort.c: No such file or directory
> >  (gdb) bt
> >  #0 __GI_abort () at ./stdlib/abort.c:72
> >  #1 0x00007ffff630874d in report_mismatch (pc_name=0x7ffff630a220 "target", vcpu_index=0, type=QEMU_PLUGIN_DISCON_EXCEPTION, last=134574955, expected=134574953, 
> >  encountered=134574955) at ../../tests/tcg/plugins/discons.c:89
> >  #2 0x00007ffff6308c0d in insn_exec (vcpu_index=0, userdata=0x0) at ../../tests/tcg/plugins/discons.c:132
> >  #3 0x00007fffea431114 in code_gen_buffer ()
> >  #4 0x000055555577b0a6 in cpu_tb_exec (cpu=0x529000005200, itb=0x7fffea431000 <code_gen_buffer+200659>, tb_exit=0x7ffff49c9530) at ../../accel/tcg/cpu-exec.c:438
> >  #5 0x000055555577c92f in cpu_loop_exec_tb (cpu=0x529000005200, tb=0x7fffea431000 <code_gen_buffer+200659>, pc=134574955, last_tb=0x7ffff49c9540, tb_exit=0x7ffff49c9530)
> >  at ../../accel/tcg/cpu-exec.c:871
> >  #6 0x000055555577d151 in cpu_exec_loop (cpu=0x529000005200, sc=0x7ffff483a740) at ../../accel/tcg/cpu-exec.c:981
> >  #7 0x000055555577d2fe in cpu_exec_setjmp (cpu=0x529000005200, sc=0x7ffff483a740) at ../../accel/tcg/cpu-exec.c:998
> >  #8 0x000055555577d4c8 in cpu_exec (cpu=0x529000005200) at ../../accel/tcg/cpu-exec.c:1024
> >  #9 0x00005555557bfc83 in cpu_loop (env=0x529000007dd0) at ../../linux-user/i386/cpu_loop.c:215
> >  #10 0x00005555558ee3e1 in main (argc=4, argv=0x7fffffffe688, envp=0x7fffffffe6b0) at ../../linux-user/main.c:1038
> >  (gdb) f 1
> >  #1 0x00007ffff630874d in report_mismatch (pc_name=0x7ffff630a220 "target", vcpu_index=0, type=QEMU_PLUGIN_DISCON_EXCEPTION, last=134574955, expected=134574953, 
> >  encountered=134574955) at ../../tests/tcg/plugins/discons.c:89
> >  89 g_abort();
> >  (gdb) p report
> >  $1 = (GString *) 0x50300002bf00
> >  (gdb) p report->Str
> >  There is no member named Str.
> >  (gdb) p report->str
> >  $2 = (gchar *) 0x51100001fbc0 "Discon target PC mismatch on VCPU 0\nExpected: 8057369\nEncountered: 805736b\nExecuted Last: 805736b\nEvent type: exception\n"
> >  (gdb) 
> > 
> > I think this is where it is going wrong:
> > 
> >  IN: _dl_early_allocate
> >  0x0805736b: 89 c2 movl %eax, %edx
> >  0x0805736d: 8d 1c 28 leal (%eax, %ebp), %ebx
> >  0x08057370: 89 c8 movl %ecx, %eax
> >  0x08057372: cd 80 int $0x80
> 
> Thanks! I'll have a closer look.
> 
> > > 
> > > + g_string_free(report, true);
> > > 
> > so we could drop this... or..
> 
> As aborting is optional, we should free.
> 
> Regards,
> Julian
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


