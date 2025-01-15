Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632C1C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 10:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY0aG-0006Bn-FF; Wed, 15 Jan 2025 05:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY0aB-0006A3-M4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:25:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tY0a7-0002vB-Kl
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 05:25:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736936701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhpS1tU1wcLRfu6RtfbaAHt6OxlmjkgAZSymSzjtLQQ=;
 b=gFhY93TqTDX9ync2OprksNx+emRvAtD352QDaAs9nsL/DhKodockF5tHCR6RILX+4DXHw5
 yUmO0vjUDt0R8AkCUQPkwg5hPJK5z57pBZSH6LjNA5bnp9wGYCMCjVovDFbVS/huijIybG
 u1RojxYhcbAqw1HbLlVjZ3E1gEglEk8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-qoNkou1SM5S-oMXY4Yow4g-1; Wed, 15 Jan 2025 05:24:56 -0500
X-MC-Unique: qoNkou1SM5S-oMXY4Yow4g-1
X-Mimecast-MFC-AGG-ID: qoNkou1SM5S-oMXY4Yow4g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361ecebc5bso34068725e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 02:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736936693; x=1737541493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhpS1tU1wcLRfu6RtfbaAHt6OxlmjkgAZSymSzjtLQQ=;
 b=t9cuj8pkcSa2AtGqbR3uuOHPpoPQ/utZnqIm2DIb45j1ymsinU/lh8KJw/n6poga40
 yxWMkG+Wv9yezErJT9UOYhwPV6iGcYTKgTgQTBGfQsm8SIuVEB+25JR+toOgiO9BKKD5
 FD4aQxhWxluxEdoBxx4SKIO3Zcm66ssfSVqqGxC3dXsHogkqI6j9bFeDYp/ny00nkekR
 bn60wSIQYkrysopB/yPpjwfkbb4d1UNeguKqkGmpvs7fZckvBczAiOXzdlZrjUfc4x30
 UAEaKPKIpFwUwbQEypRO5kz5McZjvZeQEr+5vu+lpcW6iYW2RUgCnVdaLZf0aG3a6B7g
 AWyA==
X-Gm-Message-State: AOJu0Yw/L0IWbPCWN8nubNroXK9Ndtchm2zx6kCf+wNTNtpi/1cPIthI
 /Z+fQRtdVyGU7aXLOlr/UFnQfk7+FsYc8p/iIZiTzJtGzQtFMtflwC0W4WsXUx8mp4IXEeq2k/B
 yC+XzABgpHJ9BGqi2weLwZtxEh3uXGgVJ1Yj6VkU4j7kxzKzu6ZoGHiaORcZl
X-Gm-Gg: ASbGncv1XgwYcq2pW0Y5ZUUTIRf0GHRjBuYoT0oS70gLXWSYM1Zkvhm+64tVnz0Y0EY
 D4knAOjktxvfNremETN8br8ifs0XHwtfo8+NrdvrgLZR75nFD8YS3tB7fpu5a5qQ03T3hOuEoQK
 R8+ANWtZKd8YV9wDFeuUNqG31wmisqEj5TW6iDcSZEvuAs3V3IrJdeeeazaLi6GTuSZG4Em2DKx
 tZqOQ4nBLQZVVeec++biuQKZX9aMMZ8zS328JL+ctKBNfNeq2eFuFe2hNDqqMPWID7xzMwmImD9
 UGcLVikUy4kHE4HcmjtLjoGOoll3
X-Received: by 2002:a05:600c:35c1:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-436e26efb22mr228591725e9.26.1736936693459; 
 Wed, 15 Jan 2025 02:24:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGY8paSw9j91aZCZlCUJ7K21no0f8X92NzAOxnZsEpLUMayrYZZP/WH/EHoe4W3e2Wz1lo63A==
X-Received: by 2002:a05:600c:35c1:b0:434:a468:4a57 with SMTP id
 5b1f17b1804b1-436e26efb22mr228591465e9.26.1736936692999; 
 Wed, 15 Jan 2025 02:24:52 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499965sm18374775e9.5.2025.01.15.02.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 02:24:52 -0800 (PST)
Date: Wed, 15 Jan 2025 11:24:51 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH] tests/qtest/migration: Add cpu hotplug test
Message-ID: <20250115112451.021e6aa2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250113210833.1712-1-farosas@suse.de>
References: <20250113210833.1712-1-farosas@suse.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 13 Jan 2025 18:08:33 -0300
Fabiano Rosas <farosas@suse.de> wrote:

> Bug #2594 is about a failure during migration after a cpu hotplug. Add
> a test that covers that scenario. Start the source with -smp 2 and
> destination with -smp 3, plug one extra cpu to match and migrate.

-smp on target should be the same as on source.
Instead use '-device hotplugged_cpu' with the same args as
in used device_add on target, to account for an extra cpu

> 
> The issue seems to be a mismatch in the number of virtqueues between
> the source and destination due to the hotplug not changing the
> num_queues:
> 
>   get_pci_config_device: Bad config data: i=0x9a read: 4 device: 5
>   cmask: ff wmask: 0 w1cmask:0
> 
> Usage:
> $ QTEST_QEMU_IMG=./qemu-img QTEST_QEMU_BINARY=./qemu-system-x86_64 \
>   ./tests/qtest/migration-test -p /x86_64/migration/hotplug/cpu
> 
> References: https://gitlab.com/qemu-project/qemu/-/issues/2594
> References: https://issues.redhat.com/browse/RHEL-68302
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> As you can see there's no fix attached to this. I haven't reached that
> part yet, suggestions welcome =). Posting the test case if anyone
> wants to play with this.
> 
> (if someone at RH is already working on this, that's fine. I'm just
> trying to get some upstream bugs to move)
> ---
>  tests/qtest/migration/misc-tests.c | 76 ++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 
> diff --git a/tests/qtest/migration/misc-tests.c b/tests/qtest/migration/misc-tests.c
> index 6173430748..bde567b124 100644
> --- a/tests/qtest/migration/misc-tests.c
> +++ b/tests/qtest/migration/misc-tests.c
> @@ -251,6 +251,79 @@ static void test_validate_uri_channels_none_set(void)
>      do_test_validate_uri_channel(&args);
>  }
>  
> +static void test_cpu_hotplug_virtqueues(void)
> +{
> +    MigrateStart args = {
> +        .hide_stderr = false,
> +    };
> +    QTestState *from, *to;
> +    g_autofree char *device_virtio_scsi = NULL;
> +    g_autofree char *device_virtio_blk = NULL;
> +    g_autofree char *filename_scsi = g_strdup_printf("%s/qtest_disk0.qcow2", tmpfs);
> +    g_autofree char *filename_blk = g_strdup_printf("%s/qtest_disk1.qcow2", tmpfs);
> +
> +    /*
> +     * Matching the queues between src/dst allows the test to pass.
> +     * Defaults are:
> +     *   virtio-scsi-pci:   #vcpus + 2 queues that are always present.
> +     *   virtio-blk-pci:    same number of queues as vcpus.
> +     * See virtio_pci_optimal_num_queues() for the exact computation.
> +     */
> +    bool match_queues = false;
> +    const char *qs_scsi = "num_queues=5";
> +    const char *qs_blk = "num-queues=3"; /* _ vs. - is not a mistake */
> +
> +    g_assert(mkimg(filename_scsi, "qcow2", 1));
> +    g_assert(mkimg(filename_blk, "qcow2", 1));
> +
> +    device_virtio_scsi = g_strdup_printf(
> +        "-drive id=drive0,if=none,format=qcow2,file=%s "
> +        "-device virtio-scsi-pci,id=scsi0,%s "
> +        "-device scsi-hd,drive=drive0,bus=scsi0.0 ",
> +        filename_scsi, match_queues ? qs_scsi : "");
> +
> +    device_virtio_blk = g_strdup_printf(
> +        "-drive id=drive1,if=none,format=qcow2,file=%s "
> +        "-device virtio-blk-pci,drive=drive1,id=blk0,%s ",
> +        filename_blk, match_queues ? qs_blk : "");
> +
> +    /* The missing cpu will be hotplugged before migration */
> +    args.opts_source = g_strconcat("-smp 2,threads=1,sockets=1,maxcpus=4 ",
> +                                   device_virtio_scsi,
> +                                   device_virtio_blk, NULL);
> +
> +    args.opts_target = g_strconcat("-smp 3,threads=1,sockets=1,maxcpus=4 ",
> +                                   device_virtio_scsi,
> +                                   device_virtio_blk, NULL);
> +
> +    if (migrate_start(&from, &to, "defer", &args)) {
> +        return;
> +    }
> +
> +    g_free((char *)args.opts_source);
> +    g_free((char *)args.opts_target);
> +
> +
> +    migrate_ensure_converge(from);
> +    wait_for_serial("src_serial");
> +
> +    qtest_qmp_assert_success(from, "{ 'execute': 'device_add',"
> +                             "  'arguments': { "
> +                             "    'node-id': 0, 'socket-id': 0,"
> +                             "    'core-id': 2, 'thread-id': 0,"
> +                             "    'id': {},"
> +                             "    'driver': 'qemu64-x86_64-cpu' } }");
> +
> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
> +
> +    migrate_qmp(from, to, NULL, NULL, "{}");
> +    wait_for_migration_complete(from);
> +
> +    migrate_end(from, to, true);
> +    unlink(filename_scsi);
> +    unlink(filename_blk);
> +}
> +
>  void migration_test_add_misc(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
> @@ -279,4 +352,7 @@ void migration_test_add_misc(MigrationTestEnv *env)
>                         test_validate_uri_channels_both_set);
>      migration_test_add("/migration/validate_uri/channels/none_set",
>                         test_validate_uri_channels_none_set);
> +
> +    migration_test_add("/migration/hotplug/cpu/virtqueues",
> +                       test_cpu_hotplug_virtqueues);
>  }


