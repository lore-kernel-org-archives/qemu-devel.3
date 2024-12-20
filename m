Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB91EE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaU2-0005fh-85; Fri, 20 Dec 2024 05:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTz-0005S0-CG; Fri, 20 Dec 2024 05:43:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaTx-0005NN-P3; Fri, 20 Dec 2024 05:43:47 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-218c80a97caso15009905ad.0; 
 Fri, 20 Dec 2024 02:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691424; x=1735296224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NtU2WBbloNvmM8bd+xiOwv1bzHXwrM/Uep66/BPP7j4=;
 b=Hq9XZFYIUC4FA33TgDU3u1itPYVFhmq+O84K1QmLo4infpJrmdOXv5TRl0ZkERFc+R
 bPAXRg94Y+CY5onocxXzUGeglmjSdoqHDfm01DTDwDGeI/2GnPY8Alq4D3ef9xDk1nyx
 nm0yFl3UOHiAKGJ0jFLkH5AUHVyDuZa3xzl5SGjHHEAXYIZsNI5fp9OYKtwvqRUQ2tRY
 8qj4rORZur3WCMnZRTEsCZN6f266MxD6doz38ld1aXsYW4I6C1ZV4BHTmqRYCPcXuXk6
 mCCS1AytPWdMXo2O+SYW/ftdPGRSXLUHRDdZupCRGwhzujMXa+VedA0ErMfYX2LJiCAt
 B4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691424; x=1735296224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NtU2WBbloNvmM8bd+xiOwv1bzHXwrM/Uep66/BPP7j4=;
 b=J9lWTnI9ZmN8/k/w7SwKKlMwlApMdiaOTe2C1x9zpNptBNb6me10X96PSw8B2Snr8o
 +S+aX8E8EIAGgdqAW8rmBkMtqxQx6x3LNCIW/bNPy/pKX63hqtsqF5QoORQgKhw3z505
 bM9FVCyp2ZlpHccRdUKeO5Z30zfJBdsxExc0KZQjLdWHxY/ahkkpSdHS7DlRVKuIUBtE
 YbPTumFufw1fal2dqqqfd1Cx89ELF9z7PbKRERw/ciB5iMCkM/CPt49bdlt7u116vxsU
 SHJSlobzaTzZJjTendmKvROse6jQ0Mh1evEO/zvBCqx1Ur3jjC6BEkZ54nEkgtx3niAJ
 tpoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIPOrcfl6SSDNavs/947rO5OqTz8boCFabZfnyNOw84gcDsMeNMwCTegSWXy4CQ+GH3tUolASaKDw1@nongnu.org
X-Gm-Message-State: AOJu0Yz5AZqXvKIDix1XkAiaTsWuQhZZJDoWIGWO28aXWndDP4MVZDQ9
 7p1aH2R/NPBKA7LMN8mATvuVNbeX5ae2/mWoGEPkPehcKLr/KuawKX3fBA==
X-Gm-Gg: ASbGncuqOjV+/1NXz7dikhuwbyHjDTP1NpdKt0gvRwADJ8zUXO/ndbi1tTLi+KcJnCb
 G+1IEZG0r0LCjU8aq89us0Xb4Fz98D7CRXbrFCfBpZPf20ITCUBBnotLEUt2dqD1G8aHmd9SWON
 4UFOb4v9Umi4fWUsRl48zWf+yFMB+/JG27DGVVTFTtsi7U2XJ6qlmfq8SAhJtBMzDgfGDMUQC30
 YUC1HZM5gaNLHkP8ILmeTlotZDVssGBJF/FuF76zPnLS4+6nzCeEe74UO6JkA8zRN+OGIaPXKef
 Kjn79C0p+A==
X-Google-Smtp-Source: AGHT+IGIxTht2CABRku1kWFFweNlzAyHnUbbd/4JeiRH49/oGaO48MkU6bHK00GL5ZI2SpNsSCz/MA==
X-Received: by 2002:a17:902:d587:b0:216:5af7:eb2a with SMTP id
 d9443c01a7336-219e6ebb70bmr37150545ad.33.1734691423848; 
 Fri, 20 Dec 2024 02:43:43 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:43:43 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 09/17] monitor: Convert to new bh API
Date: Fri, 20 Dec 2024 20:42:11 +1000
Message-ID: <20241220104220.2007786-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Convert aio_bh_schedule_oneshot() to aio_bh_schedule_oneshot_event(),
which can specify the clock type, making it compatible with
record-replay.

Monitor creation and input does not affect target machine state, so it
should use QEMU_CLOCK_REALTIME so it is not recorded and replayed.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 monitor/monitor.c | 3 ++-
 monitor/qmp.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 56786c0ccc7..accdee88b51 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -583,7 +583,8 @@ void monitor_resume(Monitor *mon)
             ctx = qemu_get_aio_context();
         }
 
-        aio_bh_schedule_oneshot(ctx, monitor_accept_input, mon);
+        aio_bh_schedule_oneshot_event(ctx, monitor_accept_input, mon,
+                                      QEMU_CLOCK_REALTIME);
     }
 
     trace_monitor_suspend(mon, -1);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5e538f34c0d..c6fec04860f 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -541,8 +541,9 @@ void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
          * since chardev might be running in the monitor I/O
          * thread.  Schedule a bottom half.
          */
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
-                                monitor_qmp_setup_handlers_bh, mon);
+        aio_bh_schedule_oneshot_event(iothread_get_aio_context(mon_iothread),
+                                      monitor_qmp_setup_handlers_bh, mon,
+                                      QEMU_CLOCK_REALTIME);
         /* The bottom half will add @mon to @mon_list */
     } else {
         qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
-- 
2.45.2


