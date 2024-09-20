Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6481BCF9C55
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 15:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srfwe-0000j1-Ln; Fri, 20 Sep 2024 11:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srfwc-0000iT-Rv
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 11:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srfwa-0001TG-5O
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 11:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726847594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t94wU5DjWTKp5QUp7uyTOdUR+D4avBNcpOQa947jNw=;
 b=GHOoSMpdj88WSjZllUv5fR4gn4HdwynIveItkKe8H9PCzvc6VqkGpBzlXhM5kHM5fIGCHU
 d3f0bN1VOaf4Z6xa03CK+LrmMZpwGxnsDb5/PABmsFXCI1+NY0+QNqmm9TB7IvGzfqZXqe
 uF9cnSkWmyXzg2HQFX+B+ES2kTq/FIU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Tz3mIiXxPHKfCLTt3i53Fg-1; Fri, 20 Sep 2024 11:53:12 -0400
X-MC-Unique: Tz3mIiXxPHKfCLTt3i53Fg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a9a32ac034so399976785a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 08:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847592; x=1727452392;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6t94wU5DjWTKp5QUp7uyTOdUR+D4avBNcpOQa947jNw=;
 b=fHzomvfOSelmdKuRR8QkvZcrT7FqoVwtGp6+4SWTDrtAfcXQS7Xq7rM5C9P2X4zC7a
 m92eRZmBaoKiQatHQJhRVp/SaAFz7McbHy+S8uwiyLSmScqweveIKqBZFd58WVHYBaJj
 6j9lWMAxaVayWHDwJdaYDufC1BJBekNPJAYP7SqucOMssKDWM9nefZSv1rabvWeG4q/q
 i33BGmSUY+QpHdDKIgds/szcBanNni061rLLi5u+hkSPCKrPgwnzFtsu+EyWha9NaXm4
 Ua4kSLD4x9ObIaBoFFQFDbw4/sIPnGquqbR/7Ks6q9CIOZPGP4zDEvRQMKuppbb0QJ0t
 vUmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/2/rjuYgL6SVPUr+DxAhCLTw/bt7gLdBUZ/y/8VDegSda6wBoP7ab1RP72qX70ZvFm81ASTkT7sPR@nongnu.org
X-Gm-Message-State: AOJu0YzbwowVMrc+xkulS/pLuaRrP/PbtEGGL1hO0CJv5fC4DIYa0qZB
 tNtfBOWUpvV5FZXNSieWH45LhifOW3ql9HJTB6Gp47frohDeu/GP018YkzusmfLCagZajFCZ+R6
 Ie0xBnJ/WujX5gGF4tE/Buh5S3IjA8JIwohwOr5+eAS9pBvzw5tR+
X-Received: by 2002:ac8:7fcc:0:b0:458:35f7:3952 with SMTP id
 d75a77b69052e-45b228a9eeamr47876701cf.40.1726847591871; 
 Fri, 20 Sep 2024 08:53:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7XqoXVR5OjVmwDG+xInwyrw2Ojvf4SJ5fHWTjYK3cE4BvbHmWrqDJ+CUsWN8fQSA3dCzR6Q==
X-Received: by 2002:ac8:7fcc:0:b0:458:35f7:3952 with SMTP id
 d75a77b69052e-45b228a9eeamr47876261cf.40.1726847591307; 
 Fri, 20 Sep 2024 08:53:11 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b17888cdbsm19215971cf.49.2024.09.20.08.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 08:53:10 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:53:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuchen <yu.chen@h3c.com>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration/multifd: receive channel socket needs to be
 set to non-blocking
Message-ID: <Zu2aYw4BOXE4KXQG@x1n>
References: <37febc26060949f891aedea01de724fc@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37febc26060949f891aedea01de724fc@h3c.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 20, 2024 at 10:05:42AM +0000, Yuchen wrote:
> When the migration network is disconnected, the source
> qemu can exit normally with an error, but the destination
> qemu is always blocked in recvmsg(), causes the destination
> qemu main thread to be blocked.
> 
> The destination qemu block stack:
> Thread 13 (Thread 0x7f0178bfa640 (LWP 1895906) "multifdrecv_6"):
> #0  0x00007f041b5af56f in recvmsg ()
> #1  0x000055573ebd0b42 in qio_channel_socket_readv
> #2  0x000055573ebce83f in qio_channel_readv
> #3  qio_channel_readv_all_eof
> #4  0x000055573ebce909 in qio_channel_readv_all
> #5  0x000055573eaa1b1f in multifd_recv_thread
> #6  0x000055573ec2f0b9 in qemu_thread_start
> #7  0x00007f041b52bf7a in start_thread
> #8  0x00007f041b5ae600 in clone3
> 
> Thread 1 (Thread 0x7f0410c62240 (LWP 1895156) "kvm"):
> #0  0x00007f041b528ae2 in __futex_abstimed_wait_common ()
> #1  0x00007f041b5338b8 in __new_sem_wait_slow64.constprop.0
> #2  0x000055573ec2fd34 in qemu_sem_wait (sem=0x555742b5a4e0)
> #3  0x000055573eaa2f09 in multifd_recv_sync_main ()
> #4  0x000055573e7d590d in ram_load_precopy (f=f@entry=0x555742291c20)
> #5  0x000055573e7d5cbf in ram_load (opaque=<optimized out>, version_id=<optimized out>, f=0x555742291c20)
> #6  ram_load_entry (f=0x555742291c20, opaque=<optimized out>, version_id=<optimized out>)
> #7  0x000055573ea932e7 in qemu_loadvm_section_part_end (mis=0x555741136c00, f=0x555742291c20)
> #8  qemu_loadvm_state_main (f=f@entry=0x555742291c20, mis=mis@entry=0x555741136c00)
> #9  0x000055573ea94418 in qemu_loadvm_state (f=0x555742291c20, mode=mode@entry=VMS_MIGRATE)
> #10 0x000055573ea88be1 in process_incoming_migration_co (opaque=<optimized out>)
> #11 0x000055573ec43d13 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>)
> #12 0x00007f041b4f5d90 in ?? () from target:/usr/lib64/libc.so.6
> #13 0x00007ffc11890270 in ?? ()
> #14 0x0000000000000000 in ?? ()
> 
> Setting the receive channel to non-blocking can solve the problem.

Multifd threads are real threads and there's no coroutine, I'm slightly
confused why it needs to use nonblock.

Why recvmsg() didn't get kicked out when disconnect?  Is it a generic Linux
kernel are you using?

I wonder whether that's the expected behavior for sockets.  E.g., we do
have multifd/cancel test (test_multifd_tcp_cancel) and I think that runs
this path too with it always in block mode as of now..

> 
> Signed-off-by: YuChen <Yu.Chen@h3c.com>
> ---
>  migration/multifd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 9b200f4ad9..7b2a768f05 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1318,6 +1318,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>          id = qatomic_read(&multifd_recv_state->count);
>      }
> 
> +    qio_channel_set_blocking(ioc, false, NULL);
> +
>      p = &multifd_recv_state->params[id];
>      if (p->c != NULL) {
>          error_setg(&local_err, "multifd: received id '%d' already setup'",
> --
> 2.30.2
> -------------------------------------------------------------------------------------------------------------------------------------
> 本邮件及其附件含有新华三集团的保密信息，仅限于发送给上面地址中列出
> 的个人或群组。禁止任何其他人以任何形式使用（包括但不限于全部或部分地泄露、复制、
> 或散发）本邮件中的信息。如果您错收了本邮件，请您立即电话或邮件通知发件人并删除本
> 邮件！
> This e-mail and its attachments contain confidential information from New H3C, which is
> intended only for the person or entity whose address is listed above. Any use of the
> information contained herein in any way (including, but not limited to, total or partial
> disclosure, reproduction, or dissemination) by persons other than the intended
> recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
> by phone or email immediately and delete it!

-- 
Peter Xu


