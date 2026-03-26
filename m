Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C99106F30A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5gcO-0001Ly-K5; Thu, 26 Mar 2026 05:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5gcK-0001Lg-Ja
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w5gcI-0001Ir-Hv
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774515779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V76AsbDy/N87LyKAJRrvKb93UuE5uXNuD4DHpEQh8mU=;
 b=Krmh26jhpL8nGZMBbkwBC78b44XhTvXqwhLWlF4vIH7gakUeyok4I5LvQzvHr3CwwP+YJm
 mare6YmW6PKhJouKdUwHpV2YL2ACTAybn2ueDy1VVMr5CCDBneYd+OPkaW1lrPt/rpg0rY
 uVMnuqYAI3wMarSQMKbvTKz7MyyqhKY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-CmjNTT5DPdqf9DguNZlKJA-1; Thu, 26 Mar 2026 05:02:58 -0400
X-MC-Unique: CmjNTT5DPdqf9DguNZlKJA-1
X-Mimecast-MFC-AGG-ID: CmjNTT5DPdqf9DguNZlKJA_1774515777
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-487219e0800so2894895e9.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 02:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774515777; x=1775120577; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=V76AsbDy/N87LyKAJRrvKb93UuE5uXNuD4DHpEQh8mU=;
 b=QgIECJHHUehEhl+df+3OG0ift3ve6YcBUm1alCnFOL58ab8FQZdiUwZXTpel5gpD8I
 3U1er74o4dtg2h2pIWAl5iEjCWe6/MeO6Tkpx8WsO8iIFEb9fRB6nsG+oAzOl5tlKCcF
 jw7KytfVA2pAG+RQnRNFVN6N+DHJfjkATFD1rqjgi0PwCn9SjLb6vM3YSqguLHUtMNZl
 YkavH3AHy+QsnT9z2IJ+3JTS4FVhvQGte49dCK6JfJTWKCJe/5ecEQtmU4LPSdWhSSiv
 TfMMvK6uQwlXZ8dB6/Q21akQeLcnwOHRG+Pblfi/9UNfP/6Fq1Dc4578eCSE5WXLk19c
 J2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774515777; x=1775120577;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V76AsbDy/N87LyKAJRrvKb93UuE5uXNuD4DHpEQh8mU=;
 b=oLk6sJtq8Res8NNliTcubldrdTXAjuUXZeEBLYZlJDGC2ULID9pETA8dxNfvOd8mC4
 XvoQA94NkpeQZRl8nk3TFNQQPfKmIC31QfAmchoMM/YuLN8G9eJcaODbnxd0fBz44o3e
 Z50V7rIQbe1l85eHF53jAYdnfVZ5G/X5dlaNxj73KI6C/JsuJPJu54wg6/JX2czsS5c7
 ovIIJVi30efHBS8d4DikHYFkeGu+MqL5BbObEL0JQUGFDh1gCWrFPIUVWjmSa2lL2UYk
 O0XyIV8y2pgvvCGgo2tyMn6Jx9YTXk+4z8U10bqFKwJUqfm1NBedBLTPGvNNCSSp8g9E
 fGSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ZFi2QIODmx67KrtTK5UesFuTidqL8+yEVrSZh/zwznNAM9UbevFYSh5/3PBWob+xTENr/A1cc0yB@nongnu.org
X-Gm-Message-State: AOJu0YwTX7i/GO9ryNSClJn/AuENo2AvmdqznY2Q6t10klS8NIu0KenZ
 PqucGeXbK5swu1hhDwwP0TBqxDbPo5Ewdl3ULfrpyvOFpxe55FXra8X2vLZ4yGjhsY87cM5fEnJ
 cU342ISoJFa3K4s+Ogb2IxrzJuj8naNde4DWftrIL2dSzB76+YAkd8eum
X-Gm-Gg: ATEYQzx3y/naNuqO4VfzMr128oUoduUBWkoYnAeTVezrs2QVNZSbtVLJ1agE4UGHxz0
 bYGaW1T8y+2LqSBJG9EyVbfiy1//SnmpdWul8ciLTuZar6OyLhMuOP780wNos3Q/ZC6Wh8r2nmR
 21WaCSQapCQwJ5442R9HdFgjpWDwDb9F0Zmk50GlMAObSsqJ1JVSq5fegvJpFKGZbXEqcrzIMNO
 kutlRtGSkEFr4FlkGN6akixiuSDPYjJlB0XJVlvGeVE4e6Pfux44IJx8O205iVWmqcAIQ4M9gqj
 5ntwYCtosS2g3bdAlCp7+AP5EEG1mzp/CfZDWGS29kazKaWcm4xDcN/ZjgUcmnx/wFtuAzec5o9
 FTHNWuiAglXfNOPaPUw==
X-Received: by 2002:a05:600c:c0db:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-48715ff7b2fmr80679845e9.14.1774515776120; 
 Thu, 26 Mar 2026 02:02:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c0db:b0:480:690e:f14a with SMTP id
 5b1f17b1804b1-48715ff7b2fmr80679175e9.14.1774515775533; 
 Thu, 26 Mar 2026 02:02:55 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b495sm38895895e9.2.2026.03.26.02.02.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 02:02:54 -0700 (PDT)
Message-ID: <7002cee0-9287-4ff1-9580-eff97aa02566@redhat.com>
Date: Thu, 26 Mar 2026 10:02:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/10] tests/qtest/migration: Force exit-on-error=false
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
References: <20260317182320.31991-1-farosas@suse.de>
 <20260317182320.31991-6-farosas@suse.de>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260317182320.31991-6-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 17/03/2026 19.23, Fabiano Rosas wrote:
> Some tests can cause QEMU to exit(1) too early while the incoming
> coroutine has not yielded for a first time yet. This trips ASAN
> because resources related to dispatching the incoming process will
> still be allocated in the io/channel.c layer without a
> straight-forward way for the migration code to clean them up.
> 
> As an example of one such issue, the UUID validation happens early
> enough that the temporary socket from qio_net_listener_channel_func()
> still has an elevated refcount. If it fails, the listener dispatch
> code never gets to free the resource:
> 
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>      #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
>      #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
>      #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
>      #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
>      #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
>      #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
>      #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
>      #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
>      #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
>      #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
>      #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272
> 
> The exit(1) also requires some tests to setup qtest to expect a return
> code of 1 from the QEMU process. Although we can check migration
> status changes to be fairly certain where the failure happened, there
> is always the possibility of QEMU exiting for another reason and the
> test passing. This happens frequently with sanitizers enabled, but
> also risks masking issues in the regular build.
> 
> Stop allowing the incoming migration to exit and instead require the
> tests to wait for the FAILED state and end QEMU gracefully with
> qtest_quit.
> 
> In practice this means setting exit-on-error=false for every incoming
> migration, changing MIG_TEST_FAIL_DEST_QUIT_ERR to MIG_TEST_FAIL and
> waiting for a change of state where necessary.
> 
> With this, the MIG_TEST_FAIL_DEST_QUIT_ERR error result is now unused,
> remove it.
> 
> The affected tests are:
> validate_uuid_error
> multifd_tcp_cancel
> dirty_limit
> precopy_unix_tls_x509_default_host
> precopy_tcp_tls_no_hostname
> tcp_tls_x509_mismatch_host
> dbus_vmstate_missing_src
> dbus_vmstate_missing_dst
> 
> Also add a comment to QEMU source explaining that the incoming
> coroutine might block for a while until it yields as this is the
> actual root cause of the issue.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
> Link: https://lore.kernel.org/qemu-devel/20260311213418.16951-6-farosas@suse.de
> [assert that key doesn't already exists]
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/migration.c                 |  5 +++++
>   tests/qtest/dbus-vmstate-test.c       |  5 +++--
>   tests/qtest/migration/framework.c     |  5 +----
>   tests/qtest/migration/framework.h     |  2 --
>   tests/qtest/migration/migration-qmp.c |  7 +++++++
>   tests/qtest/migration/misc-tests.c    |  4 ++--
>   tests/qtest/migration/precopy-tests.c | 12 +++++-------
>   tests/qtest/migration/tls-tests.c     | 14 ++++++++------
>   8 files changed, 31 insertions(+), 23 deletions(-)

  Hi Fabiano,

this patch now triggers a failure in the qtests when I'm running these in 
"SPEED=thorough" mode:

MESON_TEST_ITERATION=1 MALLOC_PERTURB_=120 
ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 G_TEST_SLOW=1 
PYTHON=/home/thuth/tmp/qemu-build/pyvenv/bin/python3 RUST_BACKTRACE=1 
QTEST_QEMU_IMG=./qemu-img 
G_TEST_DBUS_DAEMON=/home/thuth/devel/qemu/tests/dbus-vmstate-daemon.sh 
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 
QTEST_QEMU_BINARY=./qemu-system-x86_64 
/home/thuth/tmp/qemu-build/tests/qtest/migration-test --tap -k --full

TAP version 14
# random seed: R02Sb882c8142734dce2265e65214fd2b060
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
-display none -audio none -run-with exit-with-parent=on -machine none -accel 
qtest
# Skipping test: userfaultfd not available
1..80
# Start of x86_64 tests
# Running /x86_64/dirty_limit
# Using machine type: pc-q35-11.0
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
-display none -audio none -run-with exit-with-parent=on -accel 
kvm,dirty-ring-size=4096 -accel tcg -machine pc-q35-11.0, -name 
source,debug-threads=on -machine memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial 
file:/tmp/migration-test-8B95M3/src_serial -drive 
if=none,id=d0,file=/tmp/migration-test-8B95M3/bootsect,format=raw -device 
ide-hd,drive=d0,secs=1,cyls=1,heads=1  2>/dev/null -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-106610.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-106610.qmp,id=char0 -mon chardev=char0,mode=control 
-display none -audio none -run-with exit-with-parent=on -accel 
kvm,dirty-ring-size=4096 -accel tcg -machine pc-q35-11.0, -name 
target,debug-threads=on -machine memory-backend=mig.mem -object 
memory-backend-ram,id=mig.mem,size=150M,share=off -serial 
file:/tmp/migration-test-8B95M3/dest_serial -incoming 
unix:/tmp/migration-test-8B95M3/migsocket  -drive 
if=none,id=d0,file=/tmp/migration-test-8B95M3/bootsect,format=raw -device 
ide-hd,drive=d0,secs=1,cyls=1,heads=1  2>/dev/null -accel qtest
../../devel/qemu/tests/qtest/libqtest.c:201: kill_qemu() tried to terminate 
QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)

Could you please try whether you could reproduce that crash?

  Thomas


