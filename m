Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21924CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIQ-0006Z0-U3; Wed, 07 Oct 2026 04:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEJmU-0000dm-7L
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEJmL-0004et-Rb
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791349275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pUoskSKOEsQ6F4h4hz7HH+gJ3d/gimy4L9+CReBhylM=;
 b=Z1QvQ882Kcy2+oCO68u4TicKfEwxlJdWZJi6wSuG/of+wGPhZeqt+CsxyLSb5lHF9erjoY
 JAnuKXcVNlsJ528Fm467GHkR6n+NKrMLbTvS4Ob38b85mi7RA2mhaiMVt1oYfpI3bRwiHk
 M+q41zgJc6tAZKRGHWMASLij4zmux2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-NcUcqjnXNa6-zezUY3aONg-1; Tue,
 06 Oct 2026 04:34:55 -0400
X-MC-Unique: NcUcqjnXNa6-zezUY3aONg-1
X-Mimecast-MFC-AGG-ID: NcUcqjnXNa6-zezUY3aONg_1791275695
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D70521851277
 for <qemu-devel@nongnu.org>; Tue,  6 Oct 2026 08:34:54 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFF05180035F; Tue,  6 Oct 2026 08:34:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Tommaso Califano <tcalifan@redhat.com>
Subject: [PULL 1/4] hw/usb: Fix USB MTP Use-After-Free in usb_mtp_deletefn
 List Iteration
Date: Tue,  6 Oct 2026 09:34:48 +0100
Message-ID: <20261006083451.956881-2-berrange@redhat.com>
In-Reply-To: <20261006083451.956881-1-berrange@redhat.com>
References: <20261006083451.956881-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Tommaso Califano <tcalifan@redhat.com>

In QEMU's USB MTP (Media Transfer Protocol) device emulation, the usb_mtp_deletefn()
function in hw/usb/dev-mtp.c iterates over a child object list using QLIST_FOREACH
while the recursive call may free the current element. After the free, the macro reads
the le_next field from freed memory to advance the iterator.

Replace QLIST_FOREACH with QLIST_FOREACH_SAFE, which saves the next pointer before the
iteration body executes.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3991
Signed-off-by: Tommaso Califano <tcalifan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/usb/dev-mtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1d8cfd32dc6..c2d36a73cf9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1152,7 +1152,7 @@ enum {
 
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
-    MTPObject *iter, *iter2;
+    MTPObject *iter, *iter2, *iter2_next;
     int ret = 0;
 
     /*
@@ -1161,7 +1161,7 @@ static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 
     QLIST_FOREACH(iter, &o->children, list) {
         if (iter->format == FMT_ASSOCIATION) {
-            QLIST_FOREACH(iter2, &iter->children, list) {
+            QLIST_FOREACH_SAFE(iter2, &iter->children, list, iter2_next) {
                 ret |= usb_mtp_deletefn(s, iter2, trans);
             }
         }
-- 
2.55.0


