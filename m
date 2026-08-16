Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E7DC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgId-0008PZ-F4; Sun, 16 Aug 2026 15:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIO-0008Kk-FM
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgII-0007EA-Qm
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHUWUIlV1L88EuNWpXBRzIO9zHPWAXRW9+Hdx8pgeCk=;
 b=f1zdj52CkvY0OWPJ3k1g7bGmC5DpLl+Bi7r5JjvoonhZive5PEnfAJZOdnoV9nr55gs37q
 L18o5rSTqJRCPinqIzLZd8lte6PpQeEojVVj4w/iKiHUAddvnD4UEnfWkGP3OUJy9Qkzo5
 KBiboGI6+HgrZvJCLfGEJ3RlK99E6fA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-qdTL-OdPNCeDIVnFyWGogQ-1; Sun,
 16 Aug 2026 15:13:02 -0400
X-MC-Unique: qdTL-OdPNCeDIVnFyWGogQ-1
X-Mimecast-MFC-AGG-ID: qdTL-OdPNCeDIVnFyWGogQ_1786907582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BB941956080; Sun, 16 Aug 2026 19:13:01 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 314FF30001A2; Sun, 16 Aug 2026 19:12:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:28 +0400
Subject: [PATCH v3 01/49] vl: fix -monitor none prefix matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-1-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3iiRReSd94lLGBmuGE+7JzjtOZA9/s2KBjEkNLxXG5k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguv3dVdsIPiywaCP8/+YKQQp+he4LmMAWzRo
 NOHvmYA3p2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILrwAKCRDa6OEJdZac
 5czZD/9XOIzzMt3YF6dJj7V8Wi8JGFJND5a3UFxv7tVn5RDF37mxwjZbQ2kkaDi36PZAZ5x3NNd
 Q1WZXVIMqOCoW0Ito0BG6SX48B53Fs1nviJF0TgJMWu43ziUyS4gRxBGSHOijqct2b/yRXz4Q2R
 aVD7ZQsy0h5EdGhxnE/RCrGhmRBMndtI0LJukSNCD7Bbx6d8Gt9M1E0CfTV4qFozE3x9bebU3wY
 xmcZWkupQk9o6NYs8k/w9+voIUIGWBWBqbwAgie692atim8cHj+0gLT2jEh6ffxVtff7krPVY5S
 zm6MNjz/vCeSdYgXtGejKWV4OtwogDvy+QHehk5SpWtfsqLYbfd2wvNFqYQ98fEvgvrYq7aHPcv
 DM9iHeLB7EBN4Waxe+6WZwKob/mnjmiNJ/3pbF4rsdUHx277QhBt5SXqb/FsFc63JG91xPJ2ZKn
 1+WD++7lJg2zglDYIJ2SVXlHsnms8bo67o6rJlGOt1a4kD0qZ8FrFAFcYRf40YmsSzLY3bQ0TA8
 Zb04/xNhDEjwk/B+n3KFVSukFuKum3vW0eoCIQFcPTCjFvXaKGSspQaSbaEdsFwSRvBLFU9umgz
 wjZ8OmkAe6L3piBcmjWFoasPO9gR9UWslz+cv39NNCuJiY8WrxrUv4MVZhUoxUIZILu7YRsVsGi
 Ojl5MYS80XvJdvQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Use g_strcmp0() for exact match instead of strncmp() which would
incorrectly treat any string starting with "none" as disabling
the monitor.

Fixes: 70e098af88f ("monitor: allow to disable the default monitor")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/system/vl.c b/system/vl.c
index 061cbdf860bf..5ccc19282ba2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3226,7 +3226,7 @@ void qemu_init(int argc, char **argv)
                 }
             case QEMU_OPTION_monitor:
                 default_monitor = 0;
-                if (strncmp(optarg, "none", 4)) {
+                if (g_strcmp0(optarg, "none")) {
                     monitor_parse(optarg, "readline", false);
                 }
                 break;

-- 
2.55.0.543.g5ebe2ebe4ea8


