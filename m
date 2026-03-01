Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93805FD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUK-0004Cj-DQ; Sun, 01 Mar 2026 16:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUI-0004C8-B4
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:06 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoUF-00044R-72
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401064; x=1773005864; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=f7VlSz7t7SQF/lleEx+x3vR0K2ux+w5lqSin6oQZvNVx/s+RcruBgD39E/7qBhHS
 Cf4eFbJS3U4P/L74iu3gQ04Wn28y3EYDS6iOMqZMCIEPfus7/x4aujZOgcd6ySZ76
 oKM8lg09uFQPUnzpMyKYs8K6QUUvx4RJbec0Tv5ufbJGCu1P5C2w3Vb2z5XHbZrMU
 IU74nKu67N7DXafejOklqyKwZPSBSdKzzCfHTKu9fqWTvhFbzPF81Cwb7W8QwZLhr
 jelKnBsTW5cCUTHAnmIwrh72x/QOImVDU4S1hYp6dAa2q46sgMMH3ogucWGK3BlrQ
 RuViXIwdHsruV65gcw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1vVDRD4580-015U56; Sun, 01
 Mar 2026 22:37:44 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:29 +0100
Subject: [PATCH v11 09/21] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-9-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhWTJO7WSbmYuVDySe6uREPHaAxX/WwSQGX
 L5uxpMB+KuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WEbLD/4ydg8SaCgj2vEGD4KNY0NGPcKxinP8E0OxPlTTStTM6EJT9AeCvMiGkzA0gpfUHgwdGui
 mkhW9x/f/5asq7r57ZqrWP9QvkMBpDb10HK2n1Hx5mF+cH1eqrXUCcTxa6YG56MfFa4kCir2S5b
 a+KXmvh1aYbGDwrc1hfGUBSrBUA3SXBKbELFNaeEM8yp16JI9RXl/1AeYFEQTs0HCDd5u3dH5aE
 ZRjtDTOh2F5qoVAA2WdH0g2BUnJG2bg0ZtHyFLQubA/0+XVkPCveYhEiXD+/yJxNcWlmD6etfxc
 oP43C9syLCuTTrZzZ+1ny6U0knagbPQ5EV3+KIwh9/pm3S7zwXobzh+Lye45vrl2YXlyRLVfmTa
 dEtTEEtmtg3erTVLDm2j3tAw98y8hAy+ovgTtW7vmTM+BxhBz5VP8X7iViRXSRLgWSW3OP772B3
 X54oQzHMwzDDgRYKaKXcUBo6eO55uEdgqeqvzsNrTaisAtVQL2ZeUycsKI4LJQ12rRBvtT6ylxp
 UvibPZPXHV1a4wiX2YyBJtSHSH1GO4Tw/SPsbLFdUi/d7QVSgqS58WCkmOA9eoDWZ4xtPNZQcRt
 gvx7vu+asl3PhV1Iz0rldOznUCBW2jLuNAgocoPHn/WXijS7eMY2uyx0jQvfr4eUh0SIeLq7k7/
 rFngNfyJ0f8XmRA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:0XpgMSqOBNJsXqkpoptDF0gwVmaUxsLKYwg6qheOBHO+NLVffNq
 tzZj+47IbUmIdfqYQMP3cbkmH0OSSC5F2ysT8UxcJsN0wl/bx/ebfsGnxrVLx6rVQU/XOuK
 NGnvx86UIGFXApwhSHMEOSMTvZDE54vJ3coYMU05p7NjJyy67T8o0RN1jS5D51JE5eyDtzf
 T2jEFzXn9qtzNVqsWSL/A==
UI-OutboundReport: notjunk:1;M01:P0:FYElOr00rqE=;AmZc9nbl67XnPeJa37fAxr9Xhip
 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
 nOrU9KvxqLr5eVl8euYf1tcXkBct2
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 97a224c39c49ff2269f375db47112458cab0b4cb..96102c9d0fb3b60e063c81ce07=
b730011bc4919f 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -949,7 +949,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index dba5d6ede579da42693d5270ede9660fb145238a..f36d42ef657bdf26d78ca642d7=
7a9b76e1c0c174 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


