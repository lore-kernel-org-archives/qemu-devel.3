Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04B1CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7t-0000yb-A3; Thu, 15 Oct 2026 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7N-0000O5-RZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ7K-0008Ga-Lc
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPnTxz7gori3yzc32ys5GhwdB69n9JiF4dQbjWZRkhY=;
 b=EiY3z0RcUK5N6fyiVVmoPK0vwR77JXPOxue9FS7jmYizzqdd8IyXeldBZ1jEBSNVbLQwN+
 acpldvnMqzwCU9a7b5fH6KjTFsaZt2B5aFZ6NxF6IuzXSR0lhacgPDT3AIhVM7aDZ8et9t
 7c2RQji/902qpDGfHzRhk9MrN38CdBg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-4Jl7DLIGNa6FHsJ-8e7k_A-1; Thu, 15 Oct 2026 10:55:19 +0000
X-MC-Unique: 4Jl7DLIGNa6FHsJ-8e7k_A-1
X-Mimecast-MFC-AGG-ID: 4Jl7DLIGNa6FHsJ-8e7k_A_1792061718
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48b09f01f56so3302269f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061718; x=1792666518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TPnTxz7gori3yzc32ys5GhwdB69n9JiF4dQbjWZRkhY=;
 b=TKNHUemgh1MOtHloD7xKdc0vHIvoLLvG4X/anU+VOhOQYN6DWWCLpt81FsbCCifrlA
 i6hOO1l5WXZCfHrze5n5hFxzTjH9egYtxFqHlwdFJ1HZEe2W1t2hxiPWArdtSqDl5qVg
 lz72LE5sNpW5lS6cZFfXIFuV9Q0reQsMlhoMOeL8jum/Jt6C5IzcukAhJ9KdfBkqzTG5
 BShc3sjrM5qmBvV+1MRMrnjfkvxFWIkVZNbTzam9CoDT2+4BO1tKoGWed+Puu61REOCV
 l51DR95fWe9v7bqLETA84Mr3f4lhsTGE9qC+/H4NTYiuHIN7yOpvDAQ8FsCArpDXMRWS
 5Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061718; x=1792666518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TPnTxz7gori3yzc32ys5GhwdB69n9JiF4dQbjWZRkhY=;
 b=l8i9x0AwiaJ1PfwDYFzVyK10rNaqS14h9Mk20pkdvg0lSphXuj+ZWq0XYJBQMOR1VC
 08yKQfdApoJeAsxJgneUls0oHMxKH2HekJ2fTeu1a6RX9bJGRRtjVrYzgf6RtmG7b2M9
 1Z4UmU0aAiXrtwzIaPPpYAiWgz0w7Pa0NloxdeG7lxpIEtFJf5zvbtCpSzHY78+veZxf
 wJG9qdLRGoR8UnI4yCMwYIIehpwl43kD3JyZaC3N64DMIK6AJ68FGfJiA0T/3xCafZq1
 o5qq9vHICHkLQE8MeJ7wM/G4ZQEfcB27Q18wRq6tETyZ9VFOYDm/t/atoUz4TDrNZCdb
 ylNA==
X-Gm-Message-State: AFq9FYIXZDYvQ9QgaPUELNaZfkVopRzUOk1THmz0/qnr8N7ikG9+NJBV
 uPsHt7v+QiQOnaTDtzirW9IeYZwMLivqF0iB8mGy4LERznuaBacnsi+2jeG3OXAZj5VN9hQGiSG
 ycsxPZySMNDnFC4bIUvQgb+ffaiofk82jsUeySkynrxEpcqVx7n69t27xOMt+rPkWvHh8HSZWcK
 OT5z47HWJxVp3ONtLCJOfu3yvAfiAn7So65z7s7rCj
X-Gm-Gg: AYBFou3tpBtDewxKApaRt0D2Mw/YgigMlMWzTdF45iqbjPGWxsLG60/7QlMmZ/8hrAb
 NfWk6kUgUL3rgcxqoyVKN46CrsuTjnsFAUmt2V87dC6rQ9nXwYbTHkV4kvZSh6BwhdK1RbwGjeP
 HDotY+P4ONDdSUW4ExB2zj3aGmuZ1mBKF0KvuanRX6EV5UYKscRlEykkyjRX9MS2FCl9ZgnOPac
 yKaMVZdIhrDg2/9EdJWPLTpgdadpY0k60OZ6AysFUXcNncRpY35zkMbjUWTH5GdsPhfAVGS9UfR
 zZctm2GhLL8PLzLGnUlPvhPX+THXINts3D5SZcKJJ+Z5kSEP16EQGrC8PTvMF3UhjYjAyKx+/Ak
 aJ1b42FYOOx0pNvHCRMWeoNj7CSQ8pNuWMPASi/RlQQnTdetpewIGFe/BbqIilgJlQ643TOQJK0
 VbHJfu
X-Received: by 2002:a05:6000:481a:b0:48c:4d32:ccf8 with SMTP id
 ffacd0b85a97d-48dbaade745mr34769630f8f.16.1792061718457; 
 Thu, 15 Oct 2026 03:55:18 -0700 (PDT)
X-Received: by 2002:a05:6000:481a:b0:48c:4d32:ccf8 with SMTP id
 ffacd0b85a97d-48dbaade745mr34769594f8f.16.1792061718018; 
 Thu, 15 Oct 2026 03:55:18 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm18285769f8f.14.2026.10.15.03.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 10/13] file-posix: forward PR_HELPER_CLEANUP commands to
 pr-manager
Date: Thu, 15 Oct 2026 12:53:44 +0200
Message-ID: <20261015105347.827029-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-7-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/file-posix.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 328adb57233..df117f35d48 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -4362,12 +4362,20 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
         return ret;
     }
 
-    if (req == SG_IO && s->pr_mgr) {
+    if (req == SG_IO) {
         struct sg_io_hdr *io_hdr = buf;
-        if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
-            io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN) {
-            return pr_manager_execute(s->pr_mgr, qemu_get_current_aio_context(),
-                                      s->fd, io_hdr);
+
+        if (s->pr_mgr) {
+            if (io_hdr->cmdp[0] == PERSISTENT_RESERVE_OUT ||
+                io_hdr->cmdp[0] == PERSISTENT_RESERVE_IN ||
+                io_hdr->cmdp[0] == PR_HELPER_CLEANUP) {
+                return pr_manager_execute(s->pr_mgr, qemu_get_current_aio_context(),
+                                          s->fd, io_hdr);
+            }
+        } else if (io_hdr->cmdp[0] == PR_HELPER_CLEANUP) {
+            /* This is a nop without pr-manager */
+            io_hdr->status = GOOD;
+            return 0;
         }
     }
 
-- 
2.56.0


