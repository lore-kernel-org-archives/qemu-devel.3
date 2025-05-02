Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3F7C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 21:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyEN-0003EX-9H; Fri, 02 May 2025 17:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uAyEK-00034a-KL
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:47:36 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uAyEH-0003ln-W0
 for qemu-devel@nongnu.org; Fri, 02 May 2025 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=m8lYqra3Z84SzGYlw0DK4F45QvKpvYmvP1+8xxVQUK4=; b=EIzwwLxqamdT
 NXhLpd5PAIczkVDslfqxzIULVCafp6puGZS8bX1/sHKqC8L4mDX7wa2FMMjaASkm8/Dv6T2YPNtcq
 Y5//zOYQPi3drAjev/eF57pLXR9DE35dBZCeWv6AGCR6seyv4D4Vsu6MjC2X+sZSjbg7+HE++xFhW
 Aob3LAGdqhvi0zf7MERXowIAfXSWdB0cAujrkLYzEW4rWRm53bmGqy1m0TXzn1cIrjldUjAi0uraI
 vivvBM+UIBKnGFBq1eDx227Fg6pFHUTk8Y8nsGpzEtNPzpXtK9WyNmN8A6xT9AYpXUlSUXgGSfWM0
 UlNOZ/HXCcuaDND/g0H4GQ==;
Received: from [130.117.225.5] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1uAyAV-00C5mJ-0N;
 Fri, 02 May 2025 23:47:25 +0200
From: andrey.drobyshev@virtuozzo.com
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: [PATCH 0/1] Fix racy SEGFAULT upon monitor_cleanup()
Date: Sat,  3 May 2025 00:47:28 +0300
Message-ID: <20250502214729.928380-1-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

There's a race in monitor cleanup code which might result into SEGFAULT.
When monitor_cleanup() is launched, qmp_dispatcher_co coroutine pointer
is set to NULL (see Paolo's commit 3e6bed61 ("monitor: cleanup detection of
qmp_dispatcher_co shutting down")).  If after that we manage to send
another QMP command while monitor is shutting down, we might end up
getting SIGSEGV on aio_co_wake(NULL).

Backtrace:

> #0  0x00005565359b7e19 in aio_co_wake (co=0x0) at ../util/async.c:693
> #1  0x0000556535814903 in qmp_dispatcher_co_wake () at ../monitor/qmp.c:361
> #2  0x0000556535814c17 in handle_qmp_command (opaque=0x55653767bb10, req=0x7fd574007090, err=0x0)
>     at ../monitor/qmp.c:426
> #3  0x000055653598d8f1 in json_message_process_token
>     (lexer=0x55653767bbd8, input=0x7fd5740055a0, type=JSON_RCURLY, x=61, y=0) at ../qobject/json-streamer.c:99
> #4  0x00005565359dd68b in json_lexer_feed_char (lexer=0x55653767bbd8, ch=125 '}', flush=false)
>     at ../qobject/json-lexer.c:313
> #5  0x00005565359dd7f7 in json_lexer_feed (lexer=0x55653767bbd8, buffer=0x7fd57ecf4e50 "}", size=1)
>     at ../qobject/json-lexer.c:350
> #6  0x000055653598d9e3 in json_message_parser_feed (parser=0x55653767bbc0, buffer=0x7fd57ecf4e50 "}", size=1)
>     at ../qobject/json-streamer.c:121
> #7  0x0000556535814c72 in monitor_qmp_read (opaque=0x55653767bb10, buf=0x7fd57ecf4e50 "}", size=1)
>     at ../monitor/qmp.c:433
> #8  0x000055653580b4ca in qemu_chr_be_write_impl (s=0x5565374466a0, buf=0x7fd57ecf4e50 "}", len=1)
>     at ../chardev/char.c:214
> #9  0x000055653580b53b in qemu_chr_be_write (s=0x5565374466a0, buf=0x7fd57ecf4e50 "}", len=1) at ../chardev/char.c:226
> #10 0x0000556535806aea in tcp_chr_read (chan=0x7fd574001600, cond=G_IO_IN, opaque=0x5565374466a0)
>     at ../chardev/char-socket.c:520
> #11 0x00005565356d7f6e in qio_channel_fd_source_dispatch
>     (source=0x7fd574005780, callback=0x55653580696f <tcp_chr_read>, user_data=0x5565374466a0)
>     at ../io/channel-watch.c:84
> #12 0x00007fd590ae6f4f in g_main_dispatch (context=0x556537671f50) at ../glib/gmain.c:3364
> #13 g_main_context_dispatch (context=0x556537671f50) at ../glib/gmain.c:4079
> #14 0x00007fd590b3c268 in g_main_context_iterate.constprop.0
>     (context=0x556537671f50, block=block@entry=1, dispatch=dispatch@entry=1, self=<optimized out>)
>     at ../glib/gmain.c:4155
> #15 0x00007fd590ae65a3 in g_main_loop_run (loop=0x556537672070) at ../glib/gmain.c:4353
> #16 0x000055653570dbb0 in iothread_run (opaque=0x556537345660) at ../iothread.c:70
> #17 0x000055653599baf6 in qemu_thread_start (args=0x556537672090) at ../util/qemu-thread-posix.c:541
> #18 0x00007fd58f49f7f2 in start_thread (arg=<optimized out>) at pthread_create.c:443
> #19 0x00007fd58f43f450 in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81

Unfortunately I couldn't reproduce the issue cleanly as the race window
is quite small.  If I add sleep as follows, extending the race window
and imitating the thread being preempted by the kernel scheduler:

> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index cb99a12d94..dd608ee717 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -349,6 +349,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
>          qmp_request_free(req_obj);
>      }
>      qatomic_set(&qmp_dispatcher_co, NULL);
> +    sleep(1);
>  }
>  
>  void qmp_dispatcher_co_wake(void)

Then the SEGFAULT can be reproduced like that:

> SRCDIR=/path/to/srcdir
> QMPSHELL=$SRCDIR/scripts/qmp/qmp-shell
> QMPSOCK=/path/to/qmpsock
> 
> $QMPSHELL -p $QMPSOCK <<EOF
>     system_powerdown
> EOF
> 
> while /bin/true ; do
>     $QMPSHELL -p $QMPSOCK <<EOF
>         query-status
> EOF
> done

Andrey Drobyshev (1):
  monitor: don't wake up qmp_dispatcher_co coroutine upon cleanup

 monitor/qmp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.5


