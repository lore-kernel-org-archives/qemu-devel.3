Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26156FB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78eP-0006aD-PF; Mon, 30 Mar 2026 05:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78e1-0006EF-F1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1w78dx-0000QY-F5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774861844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xyb8HJu3evdR5u4pSDSMiqHu9Ih27Kcpw4fmToyE19s=;
 b=aoT/v38ZZ4PqQkNyzhQAnw76sskF0adpAjDpCyhZqOoJBYXM0D10BN7UqBb/rkNpqiz6CB
 MDggqPLVJnYh+If5JvNmnghxynA8sUYsnTxMF3h+vp4d4T3NjPywlwuAnWD9og1i+QRPAE
 aMdnsLQVBcjlctSHcYpgA2Ad/bjqmYo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-BSpXRIxpOpW7miJCcATQ2w-1; Mon,
 30 Mar 2026 05:10:40 -0400
X-MC-Unique: BSpXRIxpOpW7miJCcATQ2w-1
X-Mimecast-MFC-AGG-ID: BSpXRIxpOpW7miJCcATQ2w_1774861839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 913CD1800610; Mon, 30 Mar 2026 09:10:39 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5210419560AB; Mon, 30 Mar 2026 09:10:35 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com, mst@redhat.com, jasowang@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jmarcin@redhat.com, qemu-devel@nongnu.org
Subject: [RFC v3 6/7] net/filter: allow filters on vhost TAP backends
Date: Mon, 30 Mar 2026 16:58:14 +0800
Message-ID: <20260330090944.1008027-7-lulu@redhat.com>
In-Reply-To: <20260330090944.1008027-1-lulu@redhat.com>
References: <20260330090944.1008027-1-lulu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

netfilter_complete() currently rejects any filter attached to a
vhost-backed netdev. The AF_PACKET redirector series needs to attach
filters to vhost-backed TAP devices, so relax the blanket vhost
rejection and keep only the backend-type requirement.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 net/filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/filter.c b/net/filter.c
index 847dd34698..636586e1f3 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -264,8 +264,10 @@ static void netfilter_complete(UserCreatable *uc, Error **errp)
     }
 
     if (get_vhost_net(ncs[0])) {
-        error_setg(errp, "Vhost is not supported");
-        return;
+        if (ncs[0]->info->type != NET_CLIENT_DRIVER_TAP) {
+            error_setg(errp, "Vhost filter support requires a TAP backend");
+            return;
+        }
     }
 
     if (strcmp(nf->position, "head") && strcmp(nf->position, "tail")) {
-- 
2.52.0


