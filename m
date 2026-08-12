Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC159C5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8gu-0004N3-2j; Wed, 12 Aug 2026 09:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8g6-00033f-79; Wed, 12 Aug 2026 09:07:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8g4-0005Ac-KS; Wed, 12 Aug 2026 09:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=OHeNzBUPPo52MwqOEEnKrj/hyObYUoiPmoCisIMr+xI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Bgmy7oPk7e6u6cfJyaBOjGhnqP6iF25hgDoA3434ami6mWiPSYevyb62XUT7+Vcv+
 +ffLf8R1/Ibh3jUiFmGWyu/qn/Xd6hTK7KBDY78dJCddsGH8lO+WOMdI8n9VgtMgBN
 yBWv7nbCPEL50QBCfbRNHs3LGW+VsCac4VLs1ZankW+ui6lL2Ov10X8JVW5LSzGlUn
 znDBNvDYSqrsro0T2wP1LAbCWMJp1mngSvJZiFMIVFtv2wcmC8lhrCyhauo2VDv9Wz
 aF4tiaOiwhmfLOdvxRXzW//ew2FoYHS6ul5qQyDY6CLMhx872gDuT87+fLcBQXssWG
 0X7ip+/XkU8nA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E9BCE1CA4AE;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2B9F9409B91;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 45A282F8F2; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, BB CC <wywwzjj@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 047/102] libvhost-user: fix heap overflow in
 vu_check_queue_inflights
Date: Wed, 12 Aug 2026 16:01:22 +0300
Message-ID: <20260812130233.621965-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Michael S. Tsirkin" <mst@redhat.com>

vu_check_queue_inflights counts inflight descriptors using inflight == 1
but copies entries using inflight != 0. If the inflight field contains
an unexpected non-0/1 value, the function copies more entries than it
allocates and overflows the heap buffer.

Stop the copy pass once resubmit_num reaches the counted inuse value.
Note: the value is not guest-accessible so not a security vulnerability.

Fixes: CVE-2026-63110
Fixes: 5f9ff1eff3 ("libvhost-user: Support tracking inflight I/O in shared memory")
Cc: Xie Yongji <xieyongji@bytedance.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3974
Reported-by: BB CC <wywwzjj@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <e2315efc526c0ee918485df4be69e2b26e8b7a73.1784892981.git.mst@redhat.com>
(cherry picked from commit b9d248dfaca5e31377ea4f7204aae788a050bafd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 037c6614018..9846de782c0 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1408,6 +1408,13 @@ vu_check_queue_inflights(VuDev *dev, VuVirtq *vq)
 
         for (i = 0; i < vq->inflight->desc_num; i++) {
             if (vq->inflight->desc[i].inflight) {
+                /*
+                 * We earlier counted exactly vq->inuse in flight -
+                 * what is going on?
+                 */
+                if (vq->resubmit_num >= vq->inuse) {
+                    return -1;
+                }
                 vq->resubmit_list[vq->resubmit_num].index = i;
                 vq->resubmit_list[vq->resubmit_num].counter =
                                         vq->inflight->desc[i].counter;
-- 
2.47.3


