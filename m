Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86262C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Hl-0004Yf-3h; Fri, 11 Sep 2026 12:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Hi-0004Nh-CE
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Hh-0006gG-0k
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ToLJhQPMRz6Q1MKU2Z1nPk0uHGyHQ2rzehLqFuMaRso=;
 b=Hu2XXKYzuQ8FB+IJSgi/wGemc0UpTRi3NWOj7X8XWg3g1VHLZppRRaqqw6pJof+lfb9pfD
 w5DH2SQhvmPFOjGMBySRfvxyG4n8gXJ4vozzPp+DW8d27Mwo4+23e4n3xOs6B4i2kExYWc
 vJWnrgVFMLtuoIcEJ7DmbvFvuXEkOaE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-tEmOfhpsNlSEzQUaGzNDAw-1; Fri,
 11 Sep 2026 12:39:27 -0400
X-MC-Unique: tEmOfhpsNlSEzQUaGzNDAw-1
X-Mimecast-MFC-AGG-ID: tEmOfhpsNlSEzQUaGzNDAw_1789144765
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CCC619539B0; Fri, 11 Sep 2026 16:39:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77AE9180034C; Fri, 11 Sep 2026 16:39:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:06 +0400
Subject: [PATCH v5 32/62] net/colo-compare: fix compare_timeout setter
 visitor type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-32-7732a55b7760@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=932;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rEFhsqDOs12Ay0m8ssGFoc+f7fZzJv5d/VfvFSaHnOw=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqkLbmiiI9ArRMJfGGcCRU24fzwyHlxwJAHuamfXi1jQm66Y
 YkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqpC25AAoJENro4Ql1lpzl8QcP/1WD
 ugl39BJG8jYTslnmM8DsUWSH9KTbeT68Mg8Lci4omvAfF7hqRA7nAq/yEriLyeSwh71z2WP1E0k
 SeQ9+HIRzqqs9/nUpjm/8W7whwtaKxxw7lKz9ZUTIdnwokkWL0THVg3bXR+vevIc5HPt9Y3lF6C
 AeXoR+Yybl08DyCB13mv2L2iFRA6dPfOS3GGcyI65Za1y0YmB5T5LQO3wQLyza8QW7lnLSKK4W+
 gy8SxVBZZbxR0lKrDk5/8Ttp6p6AzubJKOorGWje6H8aNtNKMBrVwSkNfRq3deud7fOh43fszS0
 J5W4I3UMwtjQNxUntdnXWbSNBCfSkTb1yeOgcGtUtXDvKKzBvKn3E5/JvcPsE01O95Ynv3fcm9j
 gPlVdyCcrWCr1UJEIiQ64SMjzbh9MuDGt97vklEMJYALm4rpx6f1cqF9/i/aF7OsKe1RPcI8OQa
 Wiq4yCVrS8DcydMvxTf4najYrNiznOBlsrmUOyF07xzXJQYTesFCfbSffND5vk0LABTZxG/gQcy
 DY/M0Im9+2ikE7tYRi3/Pg4rt5zYkKmneiGU5QAdkLvphxKKIn7nqqSS6eN9UpmG88DMVQ8sEwZ
 FfnRIxsg+C2hHw5IrvewBigfbaZV5sxZdPnccs2vJY6fy8YJHDR4EjSfeXO/bYp0hGGL88AV+ke
 HzR7z
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The setter was using visit_type_uint32, truncating the value, while the
getter and typename use uint64. Use visit_type_uint64 consistently.

Fixes: 0c4266ef2690 ("net/colo-compare.c: Fix compare_timeout format issue")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 net/colo-compare.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 5986fb1e8800..948a2f7f9e4b 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1075,9 +1075,9 @@ static void compare_set_timeout(Object *obj, Visitor *v,
                                 Error **errp)
 {
     CompareState *s = COLO_COMPARE(obj);
-    uint32_t value;
+    uint64_t value;
 
-    if (!visit_type_uint32(v, name, &value, errp)) {
+    if (!visit_type_uint64(v, name, &value, errp)) {
         return;
     }
     if (!value) {

-- 
2.55.0.543.g5ebe2ebe4ea8


