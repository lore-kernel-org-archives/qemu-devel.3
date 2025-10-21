Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3648DCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 18:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBH6e-0005tv-BV; Tue, 21 Oct 2025 14:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBH6d-0005ti-2a
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:29:11 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBH6a-0002lP-6A
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 14:29:10 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CEDAB3F5B1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 18:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761071345;
 bh=AS0lTqmmkOpJrR4sxZB7xwYi3HvtM+NM7I37otTWXlI=;
 h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc;
 b=CXSNIva7UYQBjCr0Sl7RN171PI9PuCbuogXX49fKjt+D+HTpAQvHWH1uEwTfVZoVn
 erUQNNsMpVmHJ/hoNjege1oxxiouLq3AqOmYg+UYyU49w+Yw5JgY9YtB0ATMFGl5wc
 X+6qulT+LrRBumrhjxeoZz2NH/usoYweK6BxsTB+NHxUeVYM0cd2c/tZyBQllXC7Xa
 L/HNTWYQK7EpkuEboSvdYGnWAq/bJUUI6JVGPlgKBcDRXlrcJswcWo7I/e5dRl87gY
 4/lZYemFJaEa+HNjNCjOuoztmDrPV+gt3+0eZcg/KAszblfMcWxXUAVbVg7FTB5/mR
 XYL9yFOQxZHvgeMKPKPmmvsVHQo/fKeA0+j7aG23wwQ6U+RU8HCpGWY5nFSUqOXm5Y
 uOL79higNeoq3m5WG7cbS2fQjWsSQ1zSBIAKP/fb8jGvKMJt5rJ7rGCFzKKIzbl/Z5
 ps0BLvBynIEg+Z2p2NKyHLpx3IvyIFUDnPTFHszpSZ13CznMc1kboVOSeT8JeYSDr7
 BICymLXELZkRguJ2MYJowCoftN8L1/jNDI6qYjeTTjVofiZWWjsV3WF4CqIhKBrWAe
 QLfpHtiGyuTFYICjEUutM3T+A4iRjOuqjPKQ0xwMPJIC+mQewFjJlNTSbrE+ZichU0
 lJyPksUPsIg4tJbk4xE8i6JE=
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-430ca900e35so173030225ab.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 11:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761071344; x=1761676144;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AS0lTqmmkOpJrR4sxZB7xwYi3HvtM+NM7I37otTWXlI=;
 b=Vu/Cce04cmnnQrLkz8YxxZ0xT/MGVUE4wqFV+O434/3bF7R2OTkaLpFWg/WDNJDncz
 GZKGFIDZIOrSyXR6DlyjArll56SrcFsIbf4s1v6cwvRxK2cNlLRWxn4UmGzSfs/NaFdO
 OEaUxBSsn6T7724662VBsunu0E00Pyj/FWM0j8bNhIW3Ua7lN13yqaAgo9baDADAmgzN
 ACn4ROE/GBhb/ZHvUqng9E4HecqFfaQavag8oWEzbaPBoaQbQDJyb3DOFoeKlEVsbeSI
 YiYCk7C/aRzDddDwbJH9zRgQ3oEmo4rtlSezziMxjruWHQkCHwMGdr8RLooM4GyOSZQR
 ty4A==
X-Gm-Message-State: AOJu0Yw0rJPZyPtiu8ZnLHCmvibxUs7DxqnicMe30Wo8ZB+eCf6J7+VA
 cuB8+QnEuUj+Py7ap8hNHd6ZRDOCP+hprPN+zOvnQWCiOz4BldRQ3hwpiCacarJtJs4YMJBBHGd
 6yLwuv2RufmpAmrZW4W4VxgIq4gW5VBZrz7CRaJ+2PEJ1tQQQ92XH83AOFP7SCNoqyJRgDWDH
X-Gm-Gg: ASbGncvB8bsfdfs3MI8GeJDxmcaEw6AM7CXjSgbKWM/f7TzZp3VBqUOHZry6I5YmT/X
 iQfWuc6LejOSJWb0EF9LfcYajCc7I3Tq6vYRBG+8Lllw2kOYkhWTMYq4OMfdseWBgiOqVrhOHnb
 1XoXwfpzEoUZaJtuAh6xW1tmEU85aAU1ca/dPmRt9m2ZPy6FJyOxaT2As/X8M1p4RGRE+pOd9Oj
 d8zrK2wr9M4o+jafLzasobUvyGdgjZeQnoByS4IFp/ALOhdk3EzWHPQtqaxBNSj0y3nMwsfnS13
 Jiiw2AJ972bUKCYhMVIfaKlOiev+dm1am4ojKUWCc7ohnmX8vfalAJy/4SKnc+PFD8JNXNGo3qt
 2VCJ3pbQy520ztbJE
X-Received: by 2002:a05:6e02:1a2b:b0:430:ab98:7b27 with SMTP id
 e9e14a558f8ab-430c527d375mr255432615ab.20.1761071344174; 
 Tue, 21 Oct 2025 11:29:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOUJEO0qjqlqF4QdAHPvZrJB8djGw213eq0HARcRFCw2mi+AI5KQy8M6YaZRz9TfAdXhLshw==
X-Received: by 2002:a05:6e02:1a2b:b0:430:ab98:7b27 with SMTP id
 e9e14a558f8ab-430c527d375mr255432275ab.20.1761071343784; 
 Tue, 21 Oct 2025 11:29:03 -0700 (PDT)
Received: from resolute.lxd ([147.219.77.79]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5a8a95feda4sm4308901173.11.2025.10.21.11.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:29:03 -0700 (PDT)
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 21 Oct 2025 13:28:43 -0500
Subject: [PATCH v2] stream: Remove bdrv from job in .clean()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-fix-3149-v2-1-5ffbe701e964@canonical.com>
X-B4-Tracking: v=1; b=H4sIANrQ92gC/22MQQ7CIBBFr9LMWgxDQVNX3sN0QWGwkyg0YBpNw
 93Frl2+/1/eBoUyU4FLt0GmlQun2EAdOnCzjXcS7BuDksqgVFIEfose9SCCREsnFazpHTR9ydS
 +PXUbG89cXil/9vKKv/VPZEWBQupJee0ng+fh6mxMkZ19HF16wlhr/QIKsiaJpAAAAA==
X-Change-ID: 20251020-fix-3149-f01ae62fa53c
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, 
 Wesley Hershberger <wesley.hershberger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931;
 i=wesley.hershberger@canonical.com; h=from:subject:message-id;
 bh=7OctQSxSIfTId1+aU/eH3Ys6uVks7TE7+O/6cw4PuU0=;
 b=owEB7QES/pANAwAKAfkogKziOh25AcsmYgBo99Du9YZquXNs4MLHotfuhFJGvtMpg9WxXPTEi
 iDYZwg/p6mJAbMEAAEKAB0WIQQsIHxFLwpehxEbQ8r5KICs4joduQUCaPfQ7gAKCRD5KICs4jod
 ueqNDADStKTVHSuQcsvEaZgA3nB0XWEpO/qsqj1qcIsScpAF5CreccJBwcPz04irq5odAQpd9Fa
 dDTwAEmHOgV1iNWtwUqmOoixd14m8pACdW2YkM4jJrzaT58PTtE+vBENkWGKVNtnTK00G/DU6I0
 8xQl9xTLiBElrOm8EfkZTBXG2atAiRXvxmK0mudlnvcISfsk4TOAutQja5Q/om70AD2gAsOAHWf
 mCfP8Qa87cb6SzktXZdz4G5u35Py/Q1ksZlcHDeHECQyW3KLCCNL6fsg2Rce4YRSRfVuV8QAIqJ
 UDgDPTydE72aHYF7rP/NJBh/sBDQOFz7e93H7do4ZTrvUBMZE5aKQytkuod+aNkAMtN0hRY1iOr
 wIjDns8Ccp5OCzCELQZJjdflACZYA9l4TJD/hfBRuxyR1mqzlOxzOdnj2XzPxXi5q0M8Clp1BGJ
 mGgksWF13CjYHs25yZ4P0CAUGdyAMV294buXcoDDluwxl51ygYZu6RUYoraWrbUGxrV4U=
X-Developer-Key: i=wesley.hershberger@canonical.com; a=openpgp;
 fpr=2C207C452F0A5E87111B43CAF92880ACE23A1DB9
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is similar to bdc4c4c5e372756a5ba3fb3a61e585b02f0dd7f4
(qmp blockdev-backup). The cor_filter_bs was added to the blockjob as
the main BDS (by passing it to block_job_create), so
bdrv_cor_filter_drop doesn't actually remove it from global_bdrv_states.

This can cause races with qmp query-named-block nodes as described in
 #3149. Stacktrace:

0  bdrv_refresh_filename (bs=0x5efed72f8350)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
1  0x00005efea73cf9dc in bdrv_block_device_info
    (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
    at block/qapi.c:62
2  0x00005efea7391ed3 in bdrv_named_nodes_list
    (flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
3  0x00005efea7471993 in qmp_query_named_block_nodes
    (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
4  qmp_marshal_query_named_block_nodes
    (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
    at qapi/qapi-commands-block-core.c:553
5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
    at qapi/qmp-dispatch.c:128
6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
    at util/async.c:219
7  0x00005efea74ffdb2 in aio_dispatch (ctx=0x5efed6f3f430)
    at util/aio-posix.c:436
8  0x00005efea7512846 in aio_ctx_dispatch (source=<optimized out>,
    callback=<optimized out>,user_data=<optimized out>)
    at util/async.c:361
9  0x00007f2b77809bfb in ?? ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
10 0x00007f2b77809e70 in g_main_context_dispatch ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
12 os_host_main_loop_wait (timeout=0) at util/main-loop.c:310
13 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:589
14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
15 0x00005efea744e4e8 in qemu_default_main (opaque=opaque@entry=0x0)
    at system/main.c:50
16 0x00005efea6e76319 in main
    (argc=<optimized out>, argv=<optimized out>)
    at system/main.c:93

As in bdc4c4c, there is no function to remove just the cor_filter_bs
from the job, so drop all the job's nodes as they are no longer needed.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Buglink: https://bugs.launchpad.net/bugs/2126951
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
---
This patch fixes the issue described in Gitlab #3149. Please see the bug
for additional context & reproducer for the issue.

I'm happy to discuss alternative approaches or resubmit as needed.

`make check-block` passes locally.

A review would be greatly appreciated as a customer's production is
impacted.

First-time patch mailer so please pardon any mistakes.
---
Changes in v2:
- Added backtrace to commit message
- Link to v1: https://lore.kernel.org/qemu-devel/20251020-fix-3149-v1-1-04b2d4db5179@canonical.com
---
 block/stream.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/stream.c b/block/stream.c
index c0616b69e259bf5a9b146dadd9dbac62bfaa9f23..1733abd8f96d7847701f54a7a55d3284387b8582 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -132,6 +132,12 @@ static void stream_clean(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
 
+    /*
+     * The job still holds a reference to cor_filter_bs; drop all bdrv to
+     * ensure that it is unref-ed
+     */
+    block_job_remove_all_bdrv(&s->common);
+
     if (s->cor_filter_bs) {
         bdrv_cor_filter_drop(s->cor_filter_bs);
         s->cor_filter_bs = NULL;

---
base-commit: 3a2d5612a7422732b648b46d4b934e2e54622fd6
change-id: 20251020-fix-3149-f01ae62fa53c

Best regards,
-- 
Wesley Hershberger <wesley.hershberger@canonical.com>


