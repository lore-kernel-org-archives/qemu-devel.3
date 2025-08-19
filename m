Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD356CA0EED
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 10:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoJRm-0000Jb-ID; Tue, 19 Aug 2025 06:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJRk-0000JL-L8
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoJRi-0005Pc-J7
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 06:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755598799;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMVJQ8febb+4kkzdiFSniE4sAG9wLuK4b6UaiUczzow=;
 b=JrbIB3RUMNhYsEdsTvJ7+tHVd6OCyyr20PdMI49LcsCUAE+b4D/xyyd5XOrM7dKrhF+rtm
 vzQSjNvhjZ4G3jls6s4rqs6DPQKLJeTIzo9Ez7uRaHDiR2lQ5YEqVPoSHcZdytyfc9gWLt
 p3YFT2aCM8RvHbqIRd7sTsdNUSeDMzk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-Vdva1_SDOa2kX_JEw0yTmQ-1; Tue,
 19 Aug 2025 06:19:57 -0400
X-MC-Unique: Vdva1_SDOa2kX_JEw0yTmQ-1
X-Mimecast-MFC-AGG-ID: Vdva1_SDOa2kX_JEw0yTmQ_1755598796
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF9C0180034B; Tue, 19 Aug 2025 10:19:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD6E81955F24; Tue, 19 Aug 2025 10:19:53 +0000 (UTC)
Date: Tue, 19 Aug 2025 11:19:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: yong.huang@smartx.com
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] multifd: Make the main thread yield periodically to the
 main loop
Message-ID: <aKRPxaHPY37Vh6zp@redhat.com>
References: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 10:41:17AM +0800, yong.huang@smartx.com wrote:
> From: Hyman Huang <yong.huang@smartx.com>
> 
> When there are network issues like missing TCP ACKs on the send
> side during the multifd live migration. At the send side, the error
> "Connection timed out" is thrown out and source QEMU process stop
> sending data, at the receive side, The IO-channels may be blocked
> at recvmsg() and thus the main loop gets stuck and fails to respond
> to QMP commands consequently.

The core contract of the main event loop thread is that *NOTHING*
must ever go into a blocking sleep/wait state, precisely because
this breaks other functionality using the event loop such as QMP.

> The QEMU backtrace at the receive side with the main thread and two
> multi-channel threads is displayed as follows:

snip

> main thread:
> Thread 1 (Thread 0x7fd45f1fbe40 (LWP 1413088)):
> 0  0x00007fd46066b616 in futex_abstimed_wait_cancelable (private=0, abstime=0x0, clockid=0, expected=0, futex_word=0x5556d7604e80) at ../sysdeps/unix/sysv/linux/futex-internal.h:216
> 1  do_futex_wait (sem=sem@entry=0x5556d7604e80, abstime=0x0) at sem_waitcommon.c:111
> 2  0x00007fd46066b708 in __new_sem_wait_slow (sem=sem@entry=0x5556d7604e80, abstime=0x0) at sem_waitcommon.c:183
> 3  0x00007fd46066b779 in __new_sem_wait (sem=sem@entry=0x5556d7604e80) at sem_wait.c:42
> 4  0x00005556d5415524 in qemu_sem_wait (sem=0x5556d7604e80) at ../util/qemu-thread-posix.c:358
> 5  0x00005556d4fa5e99 in multifd_recv_sync_main () at ../migration/multifd.c:1052
> 6  0x00005556d521ed65 in ram_load_precopy (f=f@entry=0x5556d75dfb90) at ../migration/ram.c:4446
> 7  0x00005556d521f1dd in ram_load (f=0x5556d75dfb90, opaque=<optimized out>, version_id=4) at ../migration/ram.c:4495
> 8  0x00005556d4faa3e7 in vmstate_load (f=f@entry=0x5556d75dfb90, se=se@entry=0x5556d6083070) at ../migration/savevm.c:909
> 9  0x00005556d4fae7a0 in qemu_loadvm_section_part_end (mis=0x5556d6082cc0, f=0x5556d75dfb90) at ../migration/savevm.c:2475
> 10 qemu_loadvm_state_main (f=f@entry=0x5556d75dfb90, mis=mis@entry=0x5556d6082cc0) at ../migration/savevm.c:2634
> 11 0x00005556d4fafbd5 in qemu_loadvm_state (f=0x5556d75dfb90) at ../migration/savevm.c:2706
> 12 0x00005556d4f9ebdb in process_incoming_migration_co (opaque=<optimized out>) at ../migration/migration.c:561
> 13 0x00005556d542513b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:186
> 14 0x00007fd4604ef970 in ?? () from target:/lib64/libc.so.6

Here we see the main event thread is running a migration
coroutine, and the migration code has gone into a blocking
sleep via qemu_sem_wait, which is a violation of the main
event thread contract.

> 
> Once the QEMU process falls into the above state in the presence of
> the network errors, live migration cannot be canceled gracefully,
> leaving the destination VM in the "paused" state, since the QEMU
> process on the destination side doesn't respond to the QMP command
> "migrate_cancel".
> 
> To fix that, make the main thread yield to the main loop after waiting
> too long for the multi-channels to finish receiving data during one
> iteration. 10 seconds is a sufficient timeout period to set.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  migration/multifd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b255778855..aca0aeb341 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)
>              }
>          }
>          trace_multifd_recv_sync_main_signal(p->id);
> +        do {
> +            if (qemu_sem_timedwait(&multifd_recv_state->sem_sync, 10000) == 0) {
> +                break;
> +            }
> +            if (qemu_in_coroutine()) {
> +                aio_co_schedule(qemu_get_current_aio_context(),
> +                                qemu_coroutine_self());
> +                qemu_coroutine_yield();
> +            }
> +        } while (1);

This tries to workaround the violation of the event loop contract using
short timeouts for the semaphore wait, but IMHO that is just papering
over the design flaw.

The migration code should not be using semaphores at all for sync purposes
if it wants to be running in a coroutine from the event loop thread. It
either needs to use some synchronization mechanism that can be polled by
the event thread in a non-blocking manner, or this code needs to move to
a background thread instead of a coroutine.

>          qemu_sem_post(&p->sem_sync);
>      }
>      trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
> -- 
> 2.27.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


