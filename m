Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D1DC87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjZG-0008Gh-15; Mon, 21 Jul 2025 02:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYt-0008Ai-Td
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYr-000664-Sf
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aXwN4h+5NWvUK9uc0dLGqkRb9fIsj01GkAtL71dIXQ=;
 b=FFDWM4mXuf8CtweB/D7ccP9Wmmq7oXle88J3hxapBstJ/Ml5O8LWb43RZlKtvtvBC3UT02
 RA4sIdc6TvVQvOA7lTw6zZFgMEf2z3UBSWJHDEfc8ztRiIf8ZBbTXSFpzoi8Zu7NJJCuT+
 KWPQFTAJkaxKmjhPBtxRzFadpFR8br4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-UiE96Yw1OeCJfFM-hUfW3g-1; Mon,
 21 Jul 2025 01:59:38 -0400
X-MC-Unique: UiE96Yw1OeCJfFM-hUfW3g-1
X-Mimecast-MFC-AGG-ID: UiE96Yw1OeCJfFM-hUfW3g_1753077578
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9BF41800C34; Mon, 21 Jul 2025 05:59:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1068B19560AD; Mon, 21 Jul 2025 05:59:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/12] net/tap: drop too small packets
Date: Mon, 21 Jul 2025 13:59:16 +0800
Message-ID: <20250721055927.75951-2-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Theoretically tap_read_packet() may return size less than
s->host_vnet_hdr_len, and next, we'll work with negative size
(in case of !s->using_vnet_hdr). Let's avoid it.

Don't proceed with size == s->host_vnet_hdr_len as well in case
of !s->using_vnet_hdr, it doesn't make sense.

Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/tap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/tap.c b/net/tap.c
index 23536c09b4..2a85936019 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -190,6 +190,11 @@ static void tap_send(void *opaque)
             break;
         }
 
+        if (s->host_vnet_hdr_len && size <= s->host_vnet_hdr_len) {
+            /* Invalid packet */
+            break;
+        }
+
         if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
             buf  += s->host_vnet_hdr_len;
             size -= s->host_vnet_hdr_len;
-- 
2.42.0


