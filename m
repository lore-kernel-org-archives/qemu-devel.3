Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533C9C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Ih-0006ND-FE; Fri, 11 Sep 2026 12:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Ig-0006MM-1h
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Ie-000782-3m
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JF8h3ORZNfEB8i4Tjr4bqZSkhDQQB1gVmeetkO2W1xk=;
 b=KL6YwTWKM/lhVo961r9rdOpgOcxW8nU9que6XTxw4p1dAHdKgHGv+qJWXSgcNJk9atkLEn
 GunICmFDqkp+d/O165TzqBPoetyTE7O1DDTGj2qQJJbpSwDRDtiBzZPIGmP4hXyC1cuACN
 qV07hK7Fg5o2g/Cex44XzoU/Xufukuw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-110-o6s26sP-NGWVx3hOeLVniA-1; Fri,
 11 Sep 2026 12:40:23 -0400
X-MC-Unique: o6s26sP-NGWVx3hOeLVniA-1
X-Mimecast-MFC-AGG-ID: o6s26sP-NGWVx3hOeLVniA_1789144822
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25136180134B; Fri, 11 Sep 2026 16:40:22 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EADA5180034C; Fri, 11 Sep 2026 16:40:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:21 +0400
Subject: [PATCH v5 47/62] hw/pci: change the busnr type to uint8
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-47-7732a55b7760@redhat.com>
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
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=622;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=um8mwQpkF7gZqlVS3nLmWf6c8kRhu74W62ZkPTk7ysE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC27gQLXIPHRZV+4iId+9qiSI/vkOlJzbO+fW
 E/pnkUv/pGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtuwAKCRDa6OEJdZac
 5fPCD/9M9eFdnv5a6zx+j5UiLAkc6nSifT/nbK/Ft2ZpCvjI5nqliuguSTDTPj/wGPF5vMWPRia
 Ry/mA3acBb2C59JPdHQG+0K2DaBBGjjCHE7+zvgE43If8tyjxF6jPdLta/DIJRF8nKOGhEwhlLh
 abB+3N6M3wj3KGFoWngOFU0dXL1Dz8Ob/UfqnefIwAXZVWXBpnuYyYca5xeSK30KQrwEiFBDJP8
 Rlg1RaKyJyQOqbyM/XwApi3kSpvKeh80G4S6efmmJiVlJs0XccovXsrIRJFAvFzaf0JOBQaEmB5
 xfY0oNH9oL+3NA1iTOUgxrB36Id5UsiYE7eVQNkmq8tjWb658R+NtTN3k5jYqZdCI82RuHTnaHf
 PWkyb/BmtUXHn1HFM3JLFTLKOS6y5j79xMXBC6sB2A05b8cQCAJJvDOvnNrHII0zJBb5zItTS+U
 dWJqe/HbG4nyN1pzdAsk3xtSyJli5dsA0aC5eNT0rkL2F88f2CWtkoaWuxYoPgqHa4YaMvqapHA
 trn1g48GczFMco9wWK27M20cA0M4UIz0j4JeqZ5/H/UzxjS72erYlfiTtHYkdIcK65wVZ5m63eB
 MsJSMb8K3CNj9WnSaH4Y2eorNQL+FsA9jZQrSjl+dTNBdvr7POXdMgsbq5D+YW/DRTUvti9wY8N
 j6FftXB/sRn5SzQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It is effectively a u8. The next changes are going to use the
uint8_type_info for it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index c15f2b9f084a..af6e1d440c37 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -80,7 +80,7 @@ static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
 }
 
 static const PropertyInfo prop_pci_busnr = {
-    .type = "busnr",
+    .type = "uint8",
     .get = prop_pci_busnr_get,
 };
 

-- 
2.55.0.543.g5ebe2ebe4ea8


