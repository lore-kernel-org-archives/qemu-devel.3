Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619B5C5DF85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJ39-0002P7-NK; Tue, 18 Aug 2026 08:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ38-0002Ot-HH
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwJ37-0006yE-3K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787056572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DD8Iv6mmkRObF2FzIYp6c9s/Kp4YD7Brc7X7K0K/nVM=;
 b=i0W3cFNc4M0rZivaiagIP8VTnKVwhqiZJCOtyTnMEUpUfW9qq/Iua6NwQhG8xPGhp/IMsr
 VIRPrW8bp9OMf9Zy1m+efoS4xz0hJ+B85LSc5QZ3VVFgnunuzkKZDTIioC87TJjXmxL5Xe
 wx4lvsFOeDtP2B7zU9AFwKPrBfyII+o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-VK792HN4OwSQI7gzExkcqg-1; Tue,
 18 Aug 2026 08:36:09 -0400
X-MC-Unique: VK792HN4OwSQI7gzExkcqg-1
X-Mimecast-MFC-AGG-ID: VK792HN4OwSQI7gzExkcqg_1787056568
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3170B195608B; Tue, 18 Aug 2026 12:36:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA498423; Tue, 18 Aug 2026 12:36:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 16:36:37 +0400
Subject: [PATCH v3 58/74] hw/pci: change the busnr type to uint8
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-58-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=622;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=uZf4Qa+0RX3V6iYvyo4CF/MHfx6e7rZpaQ8DdYGe+hE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhFGnGiOFzzu/Gop9SM7XbPreSYQGiPqAs7wQH
 TF7gVZOjuSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoRRpwAKCRDa6OEJdZac
 5epXD/0b3FaS71TvY9jhfQ+iiGrMb4j32jkz4wv+Uehr6X1ptKnorykhT1tTn6XsvEnmT0Hy65I
 F6QUljXY70ANCdDAgcgfwMFR0qXR3WE+dZbMMyYQZ83CEddrRTK62PzpQPnP+dTmFMIdHZ5YC/E
 WlG2cfUOgoD3+yz15zywkJsHVZh7CtsG/WYxqXpePDWT+0vBL4E8Z7UNhR64M7kJZGch1OavDgb
 Y0yJjWmrx7prLc9r6fKjHEiuDvfuWeTwgMc0xKm8zZTsqfL1Rj429301zeCWap6JQ3QZSrafFL3
 TcYaM8w21tDgwfVOtjMTdyXpTnpMh2FsjV71kzyLBUd4bsvvrhRS5d1LF7/wprmnfqr0ZhHXrRx
 ivwJOJ3IyhEy9HquBQWSR2dB3jLYdLmQUld/6VELWd/MDwppcvIjLyIQXk89AJkAaGnBFlgh1XX
 rI9ygSNQYOEE3yXh6c53CTkvpI8rasaJsYt5320BWLMxWTv8kd9ryWIw6lLNL3Sc4luxQmG9jTb
 tbs6YPnxzdYxGJrHdrZ2YnOjs0ZQfqAVAs7n9RmT0rzcgtLaURyVQE9U+4alV71m/o3mcaKJri6
 7ZsVFhwqIixHeJUoGSWTXKmyb7i2esyuZnP7B10rYtmb8SgumWXc4w704XQkiuHnMbxiQNmJzaA
 kdjp6W7GgFFPM3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

It is effectively a u8. The next changes are going to use the
uint8_type_info for it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e283..be6145a90a9f 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -79,7 +79,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "busnr",
+    .type = "uint8",
     .get = prop_pci_busnr_get,
 };
 

-- 
2.55.0.543.g5ebe2ebe4ea8


