Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D8CC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Hv-00052C-SR; Fri, 11 Sep 2026 12:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Ht-0004yR-RV
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Hs-0006jP-9Y
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Emw5udw/hAqZHIGzxhMNpVnsgLj93r4j1DXVLXU5PSI=;
 b=Lj+Z3TL9xUR2cl0Il36gkD3ureFCZR5gFqp8bVlYCzXIR9tdXQeGTxjti2HP1JUZyczpgK
 aODiG0trNE3MjpXfKdsDfug5PD0P9j4DQl6FL8PuFJw8D1JgQmX7S2vjS4y4JwvKz7Ggot
 hm47WnI0KB0Fd/g78IqxDZJuLZrumxk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-DjqXfDi6OwOL5NwFBHu7Vw-1; Fri,
 11 Sep 2026 12:39:30 -0400
X-MC-Unique: DjqXfDi6OwOL5NwFBHu7Vw-1
X-Mimecast-MFC-AGG-ID: DjqXfDi6OwOL5NwFBHu7Vw_1789144768
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD1EF18009C6; Fri, 11 Sep 2026 16:39:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D086B1956095; Fri, 11 Sep 2026 16:39:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:07 +0400
Subject: [PATCH v5 33/62] net/colo-compare: fix max_queue_size setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-33-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 Jason Wang <jasowangio@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=965;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gH4V4GYmKlKV9gTVHip9VTPSlJHQiKGxkIO6FkOUkhE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC25F2I1jFg3Wd4LHgwnQRrx5vJnIkl4bT3l5
 W3jAbHYThiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuQAKCRDa6OEJdZac
 5XnzD/9+4ueAAlJzxga5eShp2DBvON/Qepk5aWJCcBVEjfnGo6NP05Ar2vv91e6stTxDw2OlW/v
 WOUSLfsdKN18pgjbQvBpn8ZWDRBIF9YErXzLwwLVL80SrKxO4lqCU/O4Sg3txnnMkUf5RUS49cP
 HeYQSHQg4+MO1PUwsqiQV7H0ARPgTKTMHEazkPIr5JBTaIPZLQ5p/ClQYptn+W05oEux4oHoNDh
 zmYbfWXAK7dof/jxBb/JfAui3V1p78RZjOuzwehB1a8EKoND+OFrIT4SgLMkewuE7fBsfHSk5JM
 xW1ij2hgSq5yRjYfwrz7ZcX0cgf89Mt3394wdZziRoz6JesV05rOP0ec2sliXlQxaZytwTk6Dis
 jqvmsIoL9GYfi0zaqRO2cavF1gUfTxG1iRC1BxmJ1+dH+V9q2YXA8lyMh73lWkvUg93ij5thIFM
 fjd3R5/3iMsnG2BZK2IOKKIhJ7DI8GUCrPTeqAgisSKRARqpVCY1iBLI5laxtWADT7OaFH72Ixl
 aEXJw2wIHK8aGCnxqyjToPNxKyKGr0Xi+VmzZkUSzCIrXZfE/OoX/Xeah3x6bDHWFEZB+w3g+MU
 uCiMXPMN0thIok/6UOMEo3PFrmxRjbEB9Qzxu9FGbv8NVYaGPELfejLhoH6Pq5DyGjeZyA7GhUv
 3XFzSQwMgTNY/xA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

The setter was using visit_type_uint64, accepting values wider than
the uint32_t field. Use visit_type_uint32 to match the getter, field,
and typename.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 948a2f7f9e4b..a6910de869ff 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1129,9 +1129,9 @@ static void set_max_queue_size(Object *obj, Visitor *v,
                                const char *name, void *opaque,
                                Error **errp)
 {
-    uint64_t value;
+    uint32_t value;
 
-    if (!visit_type_uint64(v, name, &value, errp)) {
+    if (!visit_type_uint32(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.55.0.543.g5ebe2ebe4ea8


