Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81058C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvNE-0004jm-Jb; Fri, 28 Aug 2026 08:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMt-0004JG-Ue
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMs-0003Ji-0Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsRvbSc3x8wWXPUz4RDLXP82n3TdGCyrP0JCJ4wtlug=;
 b=JeeqPxFvRZGi/HSEkT79HDJL+futz3pkMXY2NvvdHecHfIou+aSeWJeYI3Q3C3qNAwMdRE
 VAiAp3uEmD9K5+8iACED9a+lYa04PsBbIrqn4Nw4cqrtlaZAOn3RllAa14o4HwMZsLBY+z
 SXNA00dPpackPmlUA7NvBuSCfFSfICk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-2Na8l9jRNqiYDOmlDjDPYw-1; Fri,
 28 Aug 2026 08:07:29 -0400
X-MC-Unique: 2Na8l9jRNqiYDOmlDjDPYw-1
X-Mimecast-MFC-AGG-ID: 2Na8l9jRNqiYDOmlDjDPYw_1787918848
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCF0919373D8; Fri, 28 Aug 2026 12:07:28 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E643B3001D37; Fri, 28 Aug 2026 12:07:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:31 +0400
Subject: [PATCH v5 34/50] qemu-print: document HMP/QMP behaviour better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-34-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=y5P5Y1hiNy9A+GyDHMR76y65uNpfKC5w+w7BND4fAIs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk52lLUzCvapTpeYZ0K2OI7kaw890d/DLBo9
 OG0ylXXVK+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5ToAD/4kCXiCuvkq/dIFr+AHcALm65qxCslPKF18O6wjNPO+ydp80Mf78de+2HNCs9FOVnWG9fb
 663UFcgqqy7eyaDTonObXvfKLqW6jmNhPpYZwH+Z6F8d94JsiHIsTKbEci/xghw+wP5ihn0+N3g
 KMVAnnQ5X+4p0brhlwjeKzG0EbLRVZn8vveiZ3UbScwSm+mS0uj3tDWHAOYVb8u/DmN6fu1yxCi
 NaIgOS4VV0esbFQpIZZ2d+vuPwUY7cxcfTZ1mp0VXp73IAQB6c9LIWo24rb04X/7cDAC5iWNCyD
 7MzfGglPuwcdWkpAkYO00kVCIztoMY2MK9K7G9reGuLLm6lWMHLqgbTFxh14biaYMcZhmd6dxuP
 X724sPcvqalMddJICVSbKdZ9YmyJMtRP48N0B1hDIpzIbBQxk6zeCgvvC3LCU6nIYKGLFnzVUJ3
 BwdzP5+B4Telt7g+0vrgNepZ5VUvCOGkK53hq+e4RY/w/FIOQPvWsXu7CHlYVz/vj6bhMp9G8Hi
 44JFx1jZ0vP3EaJPpmLEKPyzFHUO2SpoJ8UD4vIYfm6xfI7iklsmgw6QhXnhEibX5xvfaupx+pY
 /hLgCz+/HnR40YuzlceVONNcuAVefevUy2yQiP6sp2seX5olVyr9mQALsKrDCMmWQ3IsHYwPw50
 sUuiayDHl3RI2IQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index a2d1f0244168..5d4143d425a1 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -17,7 +17,8 @@
 
 /*
  * Print like vprintf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
@@ -30,7 +31,8 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
 /*
  * Print like printf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_printf(const char *fmt, ...)
 {

-- 
2.55.0.543.g5ebe2ebe4ea8


