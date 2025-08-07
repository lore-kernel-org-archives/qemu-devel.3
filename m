Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25610C87FD3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 03:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujqvO-0000n2-C2; Wed, 06 Aug 2025 23:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ujqvH-0000c1-85
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:04:09 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1ujqvC-0004Dp-UY
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 23:04:06 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76bc68cc9e4so626411b3a.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 20:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1754535840; x=1755140640;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0rSQb0qVIynZFOt9/956RmkxagvpXJAJJSzQ4CsrMb0=;
 b=o/9HARUCMyL6cT7ep+XNY2iPY8AvRLD4VTgU17YoEvuY6/JAFgSJANNXsNx3NvwAfI
 ye4eRHZWHI89EGE/Oy948N0XFh9paCG/J7G+e+TQoZRiSS3d7n5SS9y8lOYek5WAnnrO
 TSPsNdA7Cqk5/DuqldjW29nRFj2W7g7pJW7rto4R/IiZy4HxbFbyTnP6rrTYRehVC84L
 cgbgVBH0ufhJrgloKi8BBd8nXIOa1hvaKHuprSTuHB7a3Ant1X/NZ+9bV9ZANn5enM+1
 ZF3eOgBvecf9k3EPFBeRjiJqeEY3KRPNgbaiW2Fath1IicFmuSum4Flufx6+ZM2fNPm3
 gp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754535840; x=1755140640;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0rSQb0qVIynZFOt9/956RmkxagvpXJAJJSzQ4CsrMb0=;
 b=Fd3knS3GvTeLOwaMrYwwvq0vzJB8HhGJClq68RWMJAyc/1w+OvCd3ERe17O2c6IVO/
 gHXbmWumW/OesCn1udeOQe334bltyja886irsp1dcwEFK6RUR07EepeS7rOS7PscF/lg
 PnhsTflt6zgryll6C54WKAtnEVxkJ2RbMhenOS9aW1DL1xknHLs/NQswjH7AbTQ2a0nd
 rw6iWjabYvC2qB3HKV2aWEqyva9cdQXJoAIHJtTVWNxjwENmAzHOUis9Bl1pju7WD1PW
 RcQbnSqpj2mnkGWBKwuIScMryu0NHZOtI18CB36uLzXR2k7R4ZOQ9L/Gvmt2zvpNHDHG
 mMeg==
X-Gm-Message-State: AOJu0YxIBUElAmAZWuC105wodLCpIaQ8PHVsBPJ2T1ZzBPg030HSn9pZ
 jooUQWEqo8g5vVNnC4l0NSLq3g/diRqXMdb4JN0qSF1x4wUfFee8G387OUqUaDaopX7C6k52X3F
 icXujXyVKVg==
X-Gm-Gg: ASbGncvxhPerX/oaLNd6YuAgNIlR9ln+imtZ7898Y5kKY2J+BhoeML4Mq1nDCy0RA8H
 w4TO+mwiUHJuNVw7C/mTL526ax3Bof42RVvIywf5dl59AmrWWSWqP5JJfYhK/5mize+mvJfo3Oz
 yLXW7PAed7whfCHDCCszlsMzwx9cpxmaUL11Zb5vejQwfmasMI84D5ANDJle229S0LvnS6L8MiP
 hpgJuc1VP9B1OAAI02IZYd5VCcNbcc5ynd67CcoUcxeuDqvfZ2CoSEqI9WKVFTTSJ6L7df0KRqD
 8zBS5bB8NaKjhXwgJWqgRzKy+g6IsDoFrW93Fz+zI0KtXG8Y6eyQFcqihV7L2IEmSitGKPzC1IF
 1mf1BoEUN2QUHyFmw4BZsAOdC9OhQMupS0bvqGQhfHTYsOYqz5l8AfK8=
X-Google-Smtp-Source: AGHT+IHLOTisxnOSSq4dFGI9rDCloxO9YTAOy+HF/FtROEebdC1ya0mbgAyXzMtqW4jsfnuAQZdRkg==
X-Received: by 2002:a05:6a21:32a3:b0:240:50d:4285 with SMTP id
 adf61e73a8af0-24031558d29mr9003166637.38.1754535840349; 
 Wed, 06 Aug 2025 20:04:00 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([45.8.186.102])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bf067e310sm11719016b3a.25.2025.08.06.20.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 20:03:59 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH] multifd: Make the main thread yield periodically to the main
 loop
Date: Thu,  7 Aug 2025 10:41:17 +0800
Message-Id: <5512220e1005ae2bc7357b2def32639d164e84eb.1754534263.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Hyman Huang <yong.huang@smartx.com>

When there are network issues like missing TCP ACKs on the send
side during the multifd live migration. At the send side, the error
"Connection timed out" is thrown out and source QEMU process stop
sending data, at the receive side, The IO-channels may be blocked
at recvmsg() and thus the main loop gets stuck and fails to respond
to QMP commands consequently.

The QEMU backtrace at the receive side with the main thread and two
multi-channel threads is displayed as follows:

multifd thread 2:
Thread 10 (Thread 0x7fd24d5fd700 (LWP 1413634)):
0  0x00007fd46066d157 in __libc_recvmsg (fd=46, msg=msg@entry=0x7fd24d5fc530, flags=flags@entry=0) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
1  0x00005556d52ffb1b in qio_channel_socket_readv (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, flags=<optimized out>, errp=0x7fd24d5fc6f8) at ../io/channel-socket.c:513
2  0x00005556d530561f in qio_channel_readv_full_all_eof (ioc=0x5556d76db290, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, errp=errp@entry=0x7fd24d5fc6f8) at ../io/channel.c:142
3  0x00005556d53057d9 in qio_channel_readv_full_all (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, fds=<optimized out>, nfds=<optimized out>, errp=0x7fd24d5fc6f8) at ../io/channel.c:210
4  0x00005556d4fa4fc9 in multifd_recv_thread (opaque=opaque@entry=0x5556d7affa60) at ../migration/multifd.c:1113
5  0x00005556d5414826 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:556
6  0x00007fd460662f1b in start_thread (arg=0x7fd24d5fd700) at pthread_create.c:486
7  0x00007fd46059a1a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:98

multifd thread 1:
Thread 9 (Thread 0x7fd24ddfe700 (LWP 1413633)):
0  0x00007fd46066d157 in __libc_recvmsg (fd=44, msg=msg@entry=0x7fd24ddfd530, flags=flags@entry=0) at ../sysdeps/unix/sysv/linux/recvmsg.c:28
1  0x00005556d52ffb1b in qio_channel_socket_readv (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, flags=<optimized out>, errp=0x7fd24ddfd6f8) at ../io/channel-socket.c:513
2  0x00005556d530561f in qio_channel_readv_full_all_eof (ioc=0x5556d76dc600, iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, errp=errp@entry=0x7fd24ddfd6f8) at ../io/channel.c:142
3  0x00005556d53057d9 in qio_channel_readv_full_all (ioc=<optimized out>, iov=<optimized out>, niov=<optimized out>, fds=<optimized out>, nfds=<optimized out>, errp=0x7fd24ddfd6f8) at ../io/channel.c:210
4  0x00005556d4fa4fc9 in multifd_recv_thread (opaque=opaque@entry=0x5556d7aff990) at ../migration/multifd.c:1113
5  0x00005556d5414826 in qemu_thread_start (args=<optimized out>) at ../util/qemu-thread-posix.c:556
6  0x00007fd460662f1b in start_thread (arg=0x7fd24ddfe700) at pthread_create.c:486
7  0x00007fd46059a1a0 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:98

main thread:
Thread 1 (Thread 0x7fd45f1fbe40 (LWP 1413088)):
0  0x00007fd46066b616 in futex_abstimed_wait_cancelable (private=0, abstime=0x0, clockid=0, expected=0, futex_word=0x5556d7604e80) at ../sysdeps/unix/sysv/linux/futex-internal.h:216
1  do_futex_wait (sem=sem@entry=0x5556d7604e80, abstime=0x0) at sem_waitcommon.c:111
2  0x00007fd46066b708 in __new_sem_wait_slow (sem=sem@entry=0x5556d7604e80, abstime=0x0) at sem_waitcommon.c:183
3  0x00007fd46066b779 in __new_sem_wait (sem=sem@entry=0x5556d7604e80) at sem_wait.c:42
4  0x00005556d5415524 in qemu_sem_wait (sem=0x5556d7604e80) at ../util/qemu-thread-posix.c:358
5  0x00005556d4fa5e99 in multifd_recv_sync_main () at ../migration/multifd.c:1052
6  0x00005556d521ed65 in ram_load_precopy (f=f@entry=0x5556d75dfb90) at ../migration/ram.c:4446
7  0x00005556d521f1dd in ram_load (f=0x5556d75dfb90, opaque=<optimized out>, version_id=4) at ../migration/ram.c:4495
8  0x00005556d4faa3e7 in vmstate_load (f=f@entry=0x5556d75dfb90, se=se@entry=0x5556d6083070) at ../migration/savevm.c:909
9  0x00005556d4fae7a0 in qemu_loadvm_section_part_end (mis=0x5556d6082cc0, f=0x5556d75dfb90) at ../migration/savevm.c:2475
10 qemu_loadvm_state_main (f=f@entry=0x5556d75dfb90, mis=mis@entry=0x5556d6082cc0) at ../migration/savevm.c:2634
11 0x00005556d4fafbd5 in qemu_loadvm_state (f=0x5556d75dfb90) at ../migration/savevm.c:2706
12 0x00005556d4f9ebdb in process_incoming_migration_co (opaque=<optimized out>) at ../migration/migration.c:561
13 0x00005556d542513b in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:186
14 0x00007fd4604ef970 in ?? () from target:/lib64/libc.so.6

Once the QEMU process falls into the above state in the presence of
the network errors, live migration cannot be canceled gracefully,
leaving the destination VM in the "paused" state, since the QEMU
process on the destination side doesn't respond to the QMP command
"migrate_cancel".

To fix that, make the main thread yield to the main loop after waiting
too long for the multi-channels to finish receiving data during one
iteration. 10 seconds is a sufficient timeout period to set.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/multifd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index b255778855..aca0aeb341 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1228,6 +1228,16 @@ void multifd_recv_sync_main(void)
             }
         }
         trace_multifd_recv_sync_main_signal(p->id);
+        do {
+            if (qemu_sem_timedwait(&multifd_recv_state->sem_sync, 10000) == 0) {
+                break;
+            }
+            if (qemu_in_coroutine()) {
+                aio_co_schedule(qemu_get_current_aio_context(),
+                                qemu_coroutine_self());
+                qemu_coroutine_yield();
+            }
+        } while (1);
         qemu_sem_post(&p->sem_sync);
     }
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
-- 
2.27.0


