Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961D0CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 04:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpII-0005gs-8O; Fri, 29 May 2026 00:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIG-0005gQ-Ib
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1wSpIF-00086a-1t
 for qemu-devel@nongnu.org; Fri, 29 May 2026 00:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780030678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YU/NlBoWE6VBtjpdcgX0vRzu0ouBLdi1u6lcRcjVnYo=;
 b=HdsVON+ix55LC3Pbnv2gMPrThs+qC+SYp/WcUUd2P5wi8963Yw4EvQMJg7eSFJ+uS/NCcY
 ZQPkguVZuxi28gpQHoX+8fOHPRiYbzl6Mof5eFWlrs3yMMdwqtsUC1bbYehg/WJrfnYkLP
 9TuWIwgsDlMKnm7OFLMPF6xU1gKAc4k=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-yls1u-NqNe-qLxJQD77g9Q-1; Fri, 29 May 2026 00:57:56 -0400
X-MC-Unique: yls1u-NqNe-qLxJQD77g9Q-1
X-Mimecast-MFC-AGG-ID: yls1u-NqNe-qLxJQD77g9Q_1780030675
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ee7d1368so115601eec.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780030675; x=1780635475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YU/NlBoWE6VBtjpdcgX0vRzu0ouBLdi1u6lcRcjVnYo=;
 b=eY09Oo19SMmSlmoEoYIrExjEQmfF1IKwdmaB76EslNGQ6t9RBTq6KIxUGfB1fD1yFL
 PKaKCE2/IrZOdUKySq2pS/jiMPNtPyaMOEoZhBMhAi7fEAGtBTvQ7gY5CDbkBF22mcVV
 nDoLTM4OKEWJ4ixIKf11mBKcsbTn1Q7eiqKFyG3DjLwcWOOC2ZSdz1rSoEritIuvGVzg
 VsJyEB27Lp45C79K6oPARtSIKa6JoxNzvbAKEONNjy3dpSyqCHBjVAMLHVysijSCKhAf
 3Tf2qgXEolJoqlc9jqJVo7AghgqvzGLbIkwHG2mUWkkXvLKI+aghnYY5we1C5Mi9Hhbf
 HlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780030675; x=1780635475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YU/NlBoWE6VBtjpdcgX0vRzu0ouBLdi1u6lcRcjVnYo=;
 b=O9Vd5Z4JFObLfEPou34sT+ZFpImyPH7rrw97rz9stC9H/RC9XhZpqjqemsUXHGZfQC
 Hq/WE+LHq0Ysv7K4RcJNRsehlOnZSIslsXmJV9+z1EHEQD79dbEZ9lHSbsPncJSvf0dv
 y7ZiD+FL5gbhUwCVkIxaTHidEv4ZPTfRaybyGrTDMNKQVk23ZBAcsjgOrcHLertOhejA
 Uc9Zg+J3pkqfmw7UtbPN7qnobaZ8GGhwKYbuQaaDM+tHYehbOISWBCklkN40L+Q8WEyf
 edodq4DwWlrbofVgkn7qSxXnE7Z9ipesfC9YqDn0eP2/RRmoS7NZsTmyYpmijf7ZYxlb
 4TTA==
X-Gm-Message-State: AOJu0Yx5hgVrhPsZNFfUG5TBrFoWrmtiGryI3Z9JrV4tMH1icwtof0GL
 3po8iBiWppkHb2ZRkxtByF+c5OqzZh3hw+BVqLh/tKjufXRG7BwWgkLfg2j7hSMOC39dGu5LIcl
 3MpiLFGD+oBhRlVWnTwu/+s2Da8yRaa9AnixAkdAmVX6AbUOi/8wx2f6W2b5HYvl20UdiZYHLh2
 UpNsjBCF1M0J/LttL5swopfFcXz3UaJ98IHis43zciU+I=
X-Gm-Gg: Acq92OE8GihIJgzT23pZl4i58nDPGq/Z/wUNNfTkoZUB248RDXMUPFU3wkHEC5RMXAY
 uUU6wcbchU8E90KLjgE3H9WuCyOuUcsbasxFHjalomqJBgJ2OMcDPefRPbxrYmkcvoVrQsar9+H
 r+ud66in4bvvR2qKyVmB1t66yZACngQ0vd6t2PSCB1j6+vhgZU6/ptFaf13pPt2at/D7ScXUtl4
 nAU88oHIvwcEPK6E5eFBuflevLnCXjuoKZ+AyZSsXQWw1g9cgv/oZ3dfANYoZF7klQye1DcSF/c
 eFD+sqTmBhKdaFP8hyLKPKhPKgN1jZUsttpkuMalxJnGfNBGet0+MIBNbmVRMQsKIegX0vSga+J
 cC0xNLM04H4QrjQVNwILvKBt+mbbCjW1HV7JSz3wdzMxRyvNvOKO8dxceJWJzXfruMMg2jrIJ
X-Received: by 2002:a05:7300:dc88:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-304eb06d19fmr790047eec.5.1780030675144; 
 Thu, 28 May 2026 21:57:55 -0700 (PDT)
X-Received: by 2002:a05:7300:dc88:b0:2be:7fc2:fc38 with SMTP id
 5a478bee46e88-304eb06d19fmr790030eec.5.1780030674452; 
 Thu, 28 May 2026 21:57:54 -0700 (PDT)
Received: from localhost.localdomain ([107.172.97.67])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed3358b1sm562865eec.13.2026.05.28.21.57.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 21:57:54 -0700 (PDT)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/15] net/tap: net_init_tap(): refactor parameter checking
Date: Fri, 29 May 2026 12:57:19 +0800
Message-ID: <20260529045730.90322-5-jasowang@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529045730.90322-1-jasowang@redhat.com>
References: <20260529045730.90322-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Move checks to the top of the function to simplify further
refactoring. Merge duplicated checks.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 53 +++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 55b8b33ea8..331a779585 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -841,16 +841,30 @@ int net_init_tap(const Netdev *netdev, const char *name,
         return -1;
     }
 
-    if (tap->fd) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->fds || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, fds=, and vhostfds= "
-                       "are invalid with fd=");
-            return -1;
-        }
+    if (tap->has_queues + !!tap->helper + !!tap->fds + !!tap->fd > 1) {
+        error_setg(errp, "queues=, helper=, fds= and fd= are mutual exclusive");
+        return -1;
+    }
 
+    if ((tap->fd || tap->fds || tap->helper) &&
+        (tap->ifname || tap->script || tap->downscript ||
+         tap->has_vnet_hdr)) {
+        error_setg(errp, "ifname=, script=, downscript=, vnet_hdr= "
+                   "are invalid with fd=/fds=/helper=");
+        return -1;
+    }
+
+    if (tap->vhostfds && !tap->fds) {
+        error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
+        return -1;
+    }
+
+    if (tap->vhostfd && tap->fds) {
+        error_setg(errp, "vhostfd= is invalid with fds=");
+        return -1;
+    }
+
+    if (tap->fd) {
         fd = monitor_fd_param(monitor_cur(), tap->fd, errp);
         if (fd == -1) {
             return -1;
@@ -878,15 +892,6 @@ int net_init_tap(const Netdev *netdev, const char *name,
         char **vhost_fds;
         int nfds = 0, nvhosts = 0;
 
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->helper || tap->has_queues ||
-            tap->vhostfd) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "helper=, queues=, and vhostfd= "
-                       "are invalid with fds=");
-            return -1;
-        }
-
         fds = g_new0(char *, MAX_TAP_QUEUES);
         vhost_fds = g_new0(char *, MAX_TAP_QUEUES);
 
@@ -946,13 +951,6 @@ free_fail:
         g_free(vhost_fds);
         return ret;
     } else if (tap->helper) {
-        if (tap->ifname || tap->script || tap->downscript ||
-            tap->has_vnet_hdr || tap->has_queues || tap->vhostfds) {
-            error_setg(errp, "ifname=, script=, downscript=, vnet_hdr=, "
-                       "queues=, and vhostfds= are invalid with helper=");
-            return -1;
-        }
-
         fd = net_bridge_run_helper(tap->helper,
                                    tap->br ?: DEFAULT_BRIDGE_INTERFACE,
                                    errp);
@@ -981,11 +979,6 @@ free_fail:
         g_autofree char *downscript =
             tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
 
-        if (tap->vhostfds) {
-            error_setg(errp, "vhostfds= is invalid if fds= wasn't specified");
-            return -1;
-        }
-
         if (tap->ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
         } else {
-- 
2.54.0


