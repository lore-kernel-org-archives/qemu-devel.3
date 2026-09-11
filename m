Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03CEC88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9U-0002wr-Fr; Fri, 11 Sep 2026 05:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9F-0002Oz-MH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9D-00088q-Sf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=dLeDFAreUQeS9tRWb7wVgw5SasjSH4HwC9T+7fNMJwMdd1g19feuBPqmqk9i4VWDqFmjY3
 qVO4pv0YT9yGzxZhI17tP2zRpUJ8oKD2iwFoOSq6j4m0zfBx2c5ZciMYxa9i12E5DT13TI
 xKGXsnysfeWhUD31DOdgLH5RrUgQvlg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-dnktDI60MTmIy3aUTcnwFQ-1; Fri, 11 Sep 2026 05:02:14 -0400
X-MC-Unique: dnktDI60MTmIy3aUTcnwFQ-1
X-Mimecast-MFC-AGG-ID: dnktDI60MTmIy3aUTcnwFQ_1789117333
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-485afdd5079so544505f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117333; x=1789722133; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=b8QjTJBXicdBasexbnMNUCFNwRF1j0h83D87ezk7nOuF7Z2hrHiWU6pi6/YCX+zGkO
 ct600bQjvFrP6xUdWjq4fPbp/FLhne5mzvDJRdE5FjM9rhCNO4zD9aMLccEwMV/vQpyl
 K919bEf4UOxcjg4IPGeo4bqHVXU9yEZZ2RzpX3+s2vx8vCzIuh1mCHRy6ouflzDsPdCt
 0fYqlgh+bea5jH31xcoO15WKqU+e6NrGYkDbirCch3HKqRAzKXN5vFIxQmrg5NSOW0xv
 lQXZP9fDUOuGVm3oechf0qtDrQPug7wfkTlpp+MqoYBY94t3ZPYnBfTyDKXmxNU3OYq6
 wv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117333; x=1789722133;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6oAhYiiIn3xpeHIgSvH0lgBJsq4uFVnZ7OcjCH2hOg=;
 b=mT6EwaiRxGXbXwG3E9UJhxe8xmNcoaWjmkPI3RdmB1M6Z6aojDlgvWLQFPOzF5mMxr
 L04G2O+yyQ380iHCLNFA205T2vuOjAvmQmQemhp6jGoBkFQOETXsrDAi1jVAGdgr6X0M
 v0FeLx7ElbGNpzexhSDagyFVLnpLHivRPyI+rpufdE8+qH2vkm/TGj9Ln370yLEjoA+x
 yvJVD/cRE7b78ptTL+0jD6osr8GTfPNk6x4G0sete14W9u/imySnkNyWhiCNcE93KvQU
 xbBMG0xKsmuEVWITorUtfC5UHr3muTnuuA6TteROY60/UdojeT6ObNlJG0keeRFWXwLW
 xQLw==
X-Gm-Message-State: AFuF++kQJOfoGzzfvUQjH8EOFxc1/nGcxPZ5YmDEow0rsOnfpi/As/Bs
 f9tgX/IHAC9dmxsXLRqN4vLsbLUTeF+zAqNwsc+pZc8XNzKJ1rY9Jgi/cai/vbQDfBZpEBg/ud5
 Og7/sMR/sdlF+Lp28Y+wycVmaIXp5eaURcfnb1xmln/AB+HHCwaovv1reXvRN1lDnnu+jUAtjF+
 Q4HWLRvHPc/b6t4zmr2aUGxouMJwllLaLzjQ==
X-Gm-Gg: AYBFou3Sg2j5KKq/BLjvIdnHqWsFV0SdOoc6YxmnDfqPhgA30X4v0I8pN+Vfu/iVBhZ
 RNhplmNuib6Al4bayemFOmdnpDGPI5aNIkY0KiIDoyqvudSRAoNvWCjQvQcFqIZ76Q+tic1KOYg
 Cw/bcFNWIHkhGonjOjjVYNiWmrFnYdC/ky7eLxwANd7YUULvfwyMQB3PHsNBFkMBMzaxPlnkOQ0
 A+0lLGilEGIJuP+ji6FtKfs4ugHja2GYOX6sV1yXl9Yac9Bfdmtc1qZUQL5gxXIJ88VXn9GSp2W
 xwY8gN8SqFTf6H0Uud+/ePpit2ZFaSxMBvcws4krR2NwfG03MZx6/FOp1HQcKlfYzylYgdmPCxo
 Ppfhxsd5NJuihJdrZfFNPOF4=
X-Received: by 2002:a05:6000:70c:b0:486:ed36:ba6 with SMTP id
 ffacd0b85a97d-486ed360cc2mr3114357f8f.56.1789117332442; 
 Fri, 11 Sep 2026 02:02:12 -0700 (PDT)
X-Received: by 2002:a05:6000:70c:b0:486:ed36:ba6 with SMTP id
 ffacd0b85a97d-486ed360cc2mr3114294f8f.56.1789117331791; 
 Fri, 11 Sep 2026 02:02:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34fdd2sm4477488f8f.28.2026.09.11.02.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:11 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL v2 22/75] net/tap: disable read polling for stopped VM
Message-ID: <98a0c21270709cbd1c8624618a4fd72e5e2fed99.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Polling when VM is stopped doesn't make real sense, as stopped VM can't
handle incoming traffic anyway.

And it's critical for introduction of local TAP migration
feature in the next commit: the TAP device will be transferred
to the target (open fd will be passed through migration channel),
and if we continue polling on source, we may get a package, which
we'll never handle on source (already stopped), it will be lost.
Better is save this package for target VM to handle.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-15-vsementsov@yandex-team.ru>
---
 net/tap.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index dd0d134875..51d028d956 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -36,6 +36,7 @@
 #include "net/net.h"
 #include "clients.h"
 #include "monitor/monitor.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
@@ -92,6 +93,8 @@ struct TAPState {
     Notifier exit;
 
     int queue_index;
+    bool enable_poll_on_resume;
+    VMChangeStateEntry *vmstate;
 };
 
 static void launch_script(const char *setup_script, const char *ifname,
@@ -145,10 +148,31 @@ static void tap_update_fd_handler(TAPState *s)
 
 static void tap_read_poll(TAPState *s, bool enable)
 {
+    if (enable && runstate_check(RUN_STATE_FINISH_MIGRATE)) {
+        s->enable_poll_on_resume = true;
+        return;
+    }
     s->read_poll = enable;
     tap_update_fd_handler(s);
 }
 
+static void tap_vm_state_change(void *opaque, bool running, RunState state)
+{
+    TAPState *s = opaque;
+
+    if (running) {
+        if (s->enable_poll_on_resume) {
+            tap_read_poll(s, true);
+            s->enable_poll_on_resume = false;
+        }
+    } else if (state == RUN_STATE_FINISH_MIGRATE) {
+        if (s->read_poll) {
+            s->enable_poll_on_resume = true;
+            tap_read_poll(s, false);
+        }
+    }
+}
+
 static void tap_write_poll(TAPState *s, bool enable)
 {
     s->write_poll = enable;
@@ -379,6 +403,11 @@ static void tap_cleanup(NetClientState *nc)
         s->exit.notify = NULL;
     }
 
+    if (s->vmstate) {
+        qemu_del_vm_change_state_handler(s->vmstate);
+        s->vmstate = NULL;
+    }
+
     tap_read_poll(s, false);
     tap_write_poll(s, false);
     close(s->fd);
@@ -818,6 +847,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
     int sndbuf =
         (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
 
+    s->enable_poll_on_resume = false;
+    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
+
     if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
         sndbuf_required) {
         goto failed;
-- 
MST


