Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCFEC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzC3-0004fX-M1; Tue, 25 Feb 2025 12:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmzC1-0004ew-Sg
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:58:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmzC0-00010t-4h
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 12:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740506283;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c2Is02KFbP4f2SP8aG8/as4uDCX3uLim7HjLYUtNl3M=;
 b=Uv8f1uyj+eRuB/mcuETBq/FmHoQPskS30Nn5am3t4u/luolMcuieXjKpjmVDK41ipAL7hp
 S2plps4LqaihdLuWTU1AqhozR3+o9PgJiZlUwfvBoU1wjcI6tHB1yCCm4GgzwykdwHw+bT
 u8zK+5RJK6f+Hcet75iiv6Y6FbP2eqk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-OmTgD_bBOw6buVvaOzuTgg-1; Tue,
 25 Feb 2025 12:57:58 -0500
X-MC-Unique: OmTgD_bBOw6buVvaOzuTgg-1
X-Mimecast-MFC-AGG-ID: OmTgD_bBOw6buVvaOzuTgg_1740506277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8881C180034A; Tue, 25 Feb 2025 17:57:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D36091800944; Tue, 25 Feb 2025 17:57:54 +0000 (UTC)
Date: Tue, 25 Feb 2025 17:57:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Problem with iotest 233
Message-ID: <Z74En98KD0v11X8w@redhat.com>
References: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
 <Z72XfP8gI9-SB4B9@redhat.com>
 <f500b606-b999-426c-8d72-50a9ba9e84ac@redhat.com>
 <574cdf2e-6b8c-4ff3-9a2b-a7d00c92a788@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <574cdf2e-6b8c-4ff3-9a2b-a7d00c92a788@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 25, 2025 at 06:52:43PM +0100, Thomas Huth wrote:
> On 25/02/2025 18.44, Thomas Huth wrote:
> > On 25/02/2025 11.12, Kevin Wolf wrote:
> > > Am 25.02.2025 um 08:20 hat Thomas Huth geschrieben:
> > > > 
> > > >   Hi!
> > > > 
> > > > I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When running
> > > > 
> > > >   ./check -raw 233
> > > > 
> > > > the test simply hangs. Looking at the log, the last message is "== check
> > > > plain client to TLS server fails ==". I added some debug messages, and it
> > > > seems like the previous NBD server is not correctly terminated here.
> > > > The test works fine again if I apply this patch:
> > > > 
> > > > diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
> > > > --- a/tests/qemu-iotests/common.nbd
> > > > +++ b/tests/qemu-iotests/common.nbd
> > > > @@ -35,7 +35,7 @@ nbd_server_stop()
> > > >           read NBD_PID < "$nbd_pid_file"
> > > >           rm -f "$nbd_pid_file"
> > > >           if [ -n "$NBD_PID" ]; then
> > > > -            kill "$NBD_PID"
> > > > +            kill -9 "$NBD_PID"
> > > >           fi
> > > >       fi
> > > >       rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"
> > > > 
> > > > ... but that does not look like the right solution to me. What could prevent
> > > > the qemu-nbd from correctly shutting down when it receives a normal SIGTERM
> > > > signal?
> > > 
> > > Not sure. In theory, qemu_system_killed() should set state = TERMINATE
> > > and make main_loop_wait() return through the notification, which should
> > > then make it shut down. Maybe you can attach gdb and check what 'state'
> > > is when it hangs and if it's still in the main loop?
> > 
> > I attached a gdb and ran "bt", and it looks like it is hanging in an
> > exit() handler:
> > 
> > (gdb) bt
> > #0  0x00007f127f8fff1d in syscall () from /lib64/libc.so.6
> > #1  0x00007f127fd32e1d in g_cond_wait () from /lib64/libglib-2.0.so.0
> > #2  0x00005583df3048b2 in flush_trace_file (wait=true) at
> > ../../devel/qemu/ trace/simple.c:140
> > #3  st_flush_trace_buffer () at ../../devel/qemu/trace/simple.c:383
> > #4  0x00007f127f8296c1 in __run_exit_handlers () from /lib64/libc.so.6
> > #5  0x00007f127f82978e in exit () from /lib64/libc.so.6
> > #6  0x00005583df1ae9e1 in main (argc=<optimized out>, argv=<optimized
> > out>) at ../../devel/qemu/qemu-nbd.c:1242
> 
> Ah, now that I wrote that: I recently ran "configure" with
> --enable-trace-backends=simple ... when I remove that from "config.status"
> again, then the test works fine again 8-)
> 
> Still, I think it should not hang with the simple trace backend here, should it?

IIUC this is waiting on trace_empty_cond.

This condition should be signalled from wait_for_trace_records_available
which is in turn called from writeout_thread.

This thread is started from st_init, which is called from trace_init_backends
which should be called from qemu-nbd. I would expect this thread to still
be running when exit() handlers are run.

Does GDB show any other threads running at the time of this hang ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


