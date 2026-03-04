Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4A7EFCE47
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxth4-0004oV-Al; Wed, 04 Mar 2026 16:23:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgg-0004m6-Hd; Wed, 04 Mar 2026 16:23:25 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtge-0003Ty-NM; Wed, 04 Mar 2026 16:23:22 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7027480809;
 Thu, 05 Mar 2026 00:23:17 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-eBKyXR3h; Thu, 05 Mar 2026 00:23:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659396;
 bh=amU9C2f3rJ88akoLojIH8Spv0Mmp5f3aJg0j9G5aQFQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=JpfjPQsp4t+8GWRCxp9StcVvbXCm1rwsiMAiVv0Iucz2pIz9n+RdcIb/3UO+cAw/J
 hiZsCpkULwdvzqVHsMjSKtstksuOf8DJxYs+pt2NnVsMaQltzDLKigzfB3sActcSI8
 R1JyqswaK1SZhXb5n7ISrCCJ440hYkTM8JTeYkS0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 channel subs...)
Subject: [PATCH v3 16/18] hw/s390x/css: drop use of .err_hint for vmstate
Date: Thu,  5 Mar 2026 00:23:00 +0300
Message-ID: <20260304212303.667141-17-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

That's the only usage through the whole base. Doesn't
worth keeping the whole complexity. And 2.7 machines were
long ago.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/s390x/css.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 04ce3178a0b..df5f0bc27f1 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -192,10 +192,6 @@ static const VMStateDescription vmstate_schdev_orb = {
 static int subch_dev_post_load(void *opaque, int version_id);
 static int subch_dev_pre_save(void *opaque);
 
-const char err_hint_devno[] = "Devno mismatch, tried to load wrong section!"
-    " Likely reason: some sequences of plug and unplug  can break"
-    " migration for machine versions prior to  2.7 (known design flaw).";
-
 const VMStateDescription vmstate_subch_dev = {
     .name = "s390_subch_dev",
     .version_id = 1,
@@ -203,10 +199,15 @@ const VMStateDescription vmstate_subch_dev = {
     .post_load = subch_dev_post_load,
     .pre_save = subch_dev_pre_save,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_EQUAL(cssid, SubchDev, "Bug!"),
-        VMSTATE_UINT8_EQUAL(ssid, SubchDev, "Bug!"),
+        VMSTATE_UINT8_EQUAL(cssid, SubchDev, NULL),
+        VMSTATE_UINT8_EQUAL(ssid, SubchDev, NULL),
         VMSTATE_UINT16(migrated_schid, SubchDev),
-        VMSTATE_UINT16_EQUAL(devno, SubchDev, err_hint_devno),
+        /*
+         * If devno mismatch on target, it may be due to some
+         * sequences of plug and unplug breaks migration for
+         * machine versions prior to 2.7 (known design flaw).
+         */
+        VMSTATE_UINT16_EQUAL(devno, SubchDev, NULL),
         VMSTATE_BOOL(thinint_active, SubchDev),
         VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
         VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),
-- 
2.52.0


